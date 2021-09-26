//
//  ViewController.swift
//  CirclarPath
//
//  Created by Rin on 2021/09/25.
//

import UIKit

final class ViewController: UIViewController {

    // Views
    private let circularPathView: CircularPathView = {
        let path = CircularPathView()
        path.createCircularPath(radius: 150)
        return path
    }()

    private let stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("stop", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    private let resumeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("resume", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("start", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("reset", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()

    // LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // CircluarPathViewの配置
        view.addSubview(circularPathView)
        circularPathView.center = view.center

        setupLayout()

    }

    private func setupLayout() {
        // buttonをstackViewにまとめる
        let stackView = UIStackView(arrangedSubviews: [startButton, stopButton, resumeButton, resetButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        // constraints
        [
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50)

        ].forEach { $0.isActive = true }
        startButton.addTarget(self, action: #selector(tappedStartButton), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(tappedStopButton), for: .touchUpInside)
        resumeButton.addTarget(self, action: #selector(tappedResumeButton), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(tappedResetButton), for: .touchUpInside)
    }

    @objc private func tappedStartButton() {
        circularPathView.progressAnimation(duration: 10)
    }

    @objc private func tappedStopButton() {
        circularPathView.pauseAnimation()
    }

    @objc private func tappedResumeButton() {
        circularPathView.resumeAnimation()
    }

    @objc private func tappedResetButton() {
        circularPathView.reset()
    }

    private func highlitedButtonColor(selectedBtton: UIButton) {
        if selectedBtton.isHighlighted {
            selectedBtton.alpha = 0.5
        }
    }
}

