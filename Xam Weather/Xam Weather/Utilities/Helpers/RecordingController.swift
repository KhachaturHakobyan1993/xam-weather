//
//  RecordingController.swift
//  Xam Weather
//
//  Created by Khachatur Hakobyan on 4/25/19.
//  Copyright © 2019 Khachatur Hakobyan. All rights reserved.
//

import Foundation
import Speech

protocol RecordingControllerDelegate: NSObjectProtocol {
	func didRecognizeSpeech(_ result: String)
	func didFail(_ title: String, _ message: String)
	func didDenyAuthorization()
}

class RecordingController: NSObject {
	private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
	private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
	private var recognitionTask: SFSpeechRecognitionTask?
	private let audioEngine = AVAudioEngine()
	private var speechResult = SFSpeechRecognitionResult()
	weak var delegate: RecordingControllerDelegate?
	
	func requestAuthorizationAndRecording() {
		SFSpeechRecognizer.requestAuthorization { authStatus in
			OperationQueue.main.addOperation {
				var alertTitle = String()
				var alertMsg = String()
				
				switch authStatus {
				case .authorized:
					do {
						try self.startRecording()
					} catch {
						alertTitle = "Recorder Error"
						alertMsg = "There was a problem starting the speech recorder"
					}
				case .denied:
					alertTitle = "Speech recognizer not allowed"
					alertMsg = "You enable the recgnizer in Settings"
					self.delegate?.didDenyAuthorization()
					return
				case .restricted, .notDetermined:
					alertTitle = "Could not start the speech recognizer"
					alertMsg = "Check your internect connection and try again"
				}
				guard !alertTitle.isEmpty else { return }
				self.delegate?.didFail(alertTitle, alertMsg)
			}
		}
	}
	
	private func startRecording() throws {
		guard !self.audioEngine.isRunning else { return }
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
			self.timerEnded()
		}
		
		self.recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
		let inputNode = self.audioEngine.inputNode
		guard let recognitionRequest = self.recognitionRequest else { fatalError("Unable to create the recognition request") }
		recognitionRequest.shouldReportPartialResults = true
		
		self.recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
			var isFinal = false
			
			if let result = result {
				isFinal = result.isFinal
				self.speechResult = result
			}
			
			if error != nil || isFinal {
				self.audioEngine.stop()
				inputNode.removeTap(onBus: 0)
				self.recognitionRequest = nil
				self.recognitionTask = nil
			}
		}
		
		let recordingFormat = inputNode.outputFormat(forBus: 0)
		inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
			self.recognitionRequest?.append(buffer)
		}
		
		self.audioEngine.prepare()
		try self.audioEngine.start()
	}
	
	@objc private func timerEnded() {
		guard self.audioEngine.isRunning else { return }
		self.stopRecording()
	}
	
	private func stopRecording() {
		self.delegate?.didRecognizeSpeech(self.speechResult.bestTranscription.formattedString)
		self.audioEngine.stop()
		self.recognitionRequest?.endAudio()
		self.audioEngine.inputNode.removeTap(onBus: 0)
		guard let recognitionTask = self.recognitionTask else { return }
		recognitionTask.cancel()
		self.recognitionTask = nil
	}
}


// MARK: - SFSpeechRecognizerDelegate -

extension RecordingController: SFSpeechRecognizerDelegate {
	func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
		guard !available else { return }
		self.delegate?.didFail("There was a problem accessing the recognizer", "Please try again later")
	}
}
