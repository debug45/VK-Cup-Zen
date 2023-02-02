//
//  HapticSliderCell.swift
//  Zen
//
//  Created by Sergey Moskvin on 01.02.2023.
//

import UIKit

final class HapticSliderViewControllerHapticSliderCell: UITableViewCell, InteractiveFormatViewController.ItemCell {
    
    private let feedbackGenerator = UIImpactFeedbackGenerator()
    private let animatingDuration: TimeInterval = 0.25
    
    private var activeState: (
        timer: Timer,
        intensityMultiplier: Float,
        isAttenuation: Bool,
        targetClosenessAccumulatedDuration: TimeInterval?
    )?
    
    private let titleLabel = UILabel {
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        
        $0.numberOfLines = 0
        $0.textColor = .Zen.foreground
    }
    
    private let sliderContainerView = UIView()
    
    private let minBenchmarkLabel = UILabel {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .Zen.foreground.withAlphaComponent(0.5)
    }
    
    private let maxBenchmarkLabel = UILabel {
        $0.font = .systemFont(ofSize: 14)
        
        $0.textColor = .Zen.foreground.withAlphaComponent(0.5)
        $0.textAlignment = .right
    }
    
    private let sliderLeadingBackgroundView = UIView {
        $0.backgroundColor = .Zen.accent
    }
    
    private let sliderTrailingBackgroundView = UIView {
        $0.backgroundColor = .Zen.foreground.withAlphaComponent(0.2)
    }
    
    private let sliderView = UISlider {
        $0.maximumTrackTintColor = .Zen.background.mixed(
            with: .Zen.foreground.withAlphaComponent(0.2)
        )
    }
    
    private let minBenchmarkLineView = UIView {
        $0.backgroundColor = .Zen.accent
        $0.layer.cornerRadius = 2
    }
    
    private let maxBenchmarkLineView = UIView {
        $0.backgroundColor = .Zen.background.mixed(
            with: .Zen.foreground.withAlphaComponent(0.2)
        )
        
        $0.layer.cornerRadius = 2
    }
    
    private let resultContainerView = UIView()
    
    private let resultLabel = UILabel {
        $0.font = .systemFont(ofSize: 34, weight: .bold)
        $0.textColor = .Zen.foreground.withAlphaComponent(0.3)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews(
            titleLabel,
            
            sliderContainerView.addSubviews(
                minBenchmarkLabel,
                maxBenchmarkLabel,
                
                sliderLeadingBackgroundView,
                sliderTrailingBackgroundView,
                
                sliderView,
                
                minBenchmarkLineView,
                maxBenchmarkLineView
            ),
            
            resultContainerView.addSubviews(
                resultLabel
            )
        )
        
        let defaultInset: CGFloat = 20
        
        let lastVerticalConstraint = sliderContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        lastVerticalConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            sliderContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: defaultInset),
            sliderContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -defaultInset),
            
            sliderContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            lastVerticalConstraint,
            
            minBenchmarkLabel.leadingAnchor.constraint(equalTo: sliderContainerView.leadingAnchor),
            minBenchmarkLabel.topAnchor.constraint(equalTo: sliderContainerView.topAnchor),
            
            maxBenchmarkLabel.trailingAnchor.constraint(equalTo: sliderContainerView.trailingAnchor),
            maxBenchmarkLabel.centerYAnchor.constraint(equalTo: minBenchmarkLabel.centerYAnchor),
            
            minBenchmarkLineView.heightAnchor.constraint(equalToConstant: 16),
            minBenchmarkLineView.widthAnchor.constraint(equalToConstant: 4),
            
            minBenchmarkLineView.leadingAnchor.constraint(equalTo: minBenchmarkLabel.leadingAnchor),
            minBenchmarkLineView.topAnchor.constraint(equalTo: minBenchmarkLabel.bottomAnchor, constant: 12),
            
            maxBenchmarkLineView.heightAnchor.constraint(equalTo: minBenchmarkLineView.heightAnchor),
            maxBenchmarkLineView.widthAnchor.constraint(equalTo: minBenchmarkLineView.widthAnchor),
            
            maxBenchmarkLineView.trailingAnchor.constraint(equalTo: maxBenchmarkLabel.trailingAnchor),
            maxBenchmarkLineView.centerYAnchor.constraint(equalTo: minBenchmarkLineView.centerYAnchor),
            
            sliderLeadingBackgroundView.widthAnchor.constraint(equalToConstant: 8),
            sliderLeadingBackgroundView.heightAnchor.constraint(equalToConstant: 4),
            
            sliderLeadingBackgroundView.leadingAnchor.constraint(equalTo: minBenchmarkLineView.trailingAnchor),
            sliderLeadingBackgroundView.centerYAnchor.constraint(equalTo: minBenchmarkLineView.centerYAnchor),
            
            sliderTrailingBackgroundView.widthAnchor.constraint(equalTo: sliderLeadingBackgroundView.widthAnchor),
            sliderTrailingBackgroundView.heightAnchor.constraint(equalTo: sliderLeadingBackgroundView.heightAnchor),
            
            sliderTrailingBackgroundView.trailingAnchor.constraint(equalTo: maxBenchmarkLineView.leadingAnchor),
            sliderTrailingBackgroundView.centerYAnchor.constraint(equalTo: sliderLeadingBackgroundView.centerYAnchor),
            
            sliderView.leadingAnchor.constraint(equalTo: minBenchmarkLineView.trailingAnchor, constant: 1),
            sliderView.trailingAnchor.constraint(equalTo: maxBenchmarkLineView.leadingAnchor, constant: -1),
            
            sliderView.centerYAnchor.constraint(equalTo: minBenchmarkLineView.centerYAnchor, constant: -0.5),
            sliderView.bottomAnchor.constraint(equalTo: sliderContainerView.bottomAnchor),
            
            resultContainerView.leadingAnchor.constraint(equalTo: sliderContainerView.leadingAnchor),
            resultContainerView.trailingAnchor.constraint(equalTo: sliderContainerView.trailingAnchor),
            
            resultContainerView.topAnchor.constraint(equalTo: sliderContainerView.topAnchor),
            resultContainerView.bottomAnchor.constraint(equalTo: sliderContainerView.bottomAnchor),
            
            resultLabel.leadingAnchor.constraint(equalTo: resultContainerView.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: resultContainerView.trailingAnchor),
            
            resultLabel.centerYAnchor.constraint(equalTo: resultContainerView.centerYAnchor, constant: -6)
        ])
        
        var selector = #selector(sliderViewDidTouchDown)
        sliderView.addTarget(self, action: selector, for: .touchDown)
        
        selector = #selector(sliderViewDidTouchUp)
        
        sliderView.addTarget(self, action: selector, for: .touchUpInside)
        sliderView.addTarget(self, action: selector, for: .touchUpOutside)
        
        selector = #selector(sliderViewDidValueChange)
        sliderView.addTarget(self, action: selector, for: .valueChanged)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        resetActiveState()
    }
    
    var availableWidth: CGFloat?
    
    weak var delegate: InteractiveFormatViewController.ItemCell.Delegate?
    
    var model: Model? {
        didSet {
            resetActiveState()
            
            guard let model else {
                return
            }
            
            titleLabel.text = model.title
            
            minBenchmarkLabel.text = model.minExample.title
            maxBenchmarkLabel.text = model.maxExample.title
            
            sliderView.value = model.userValue ?? 0.5
            resultLabel.text = model.target.title
            
            sliderContainerView.isHidden = model.isResultShow
            resultContainerView.isHidden = !sliderContainerView.isHidden
            
            [sliderContainerView, resultContainerView].forEach { $0.alpha = 1 }
        }
    }
    
    private func switchToResult() {
        model?.isResultShow = true
        
        UIView.animate(withDuration: animatingDuration, delay: 0, options: .curveEaseIn, animations: {
            self.sliderContainerView.alpha = 0
        }, completion: { isFinished in
            guard isFinished else {
                return
            }
            
            self.sliderContainerView.isHidden = true
            
            self.resultContainerView.alpha = 0
            self.resultContainerView.isHidden = false
            
            UIView.animate(withDuration: self.animatingDuration, delay: 0, options: .curveEaseOut) {
                self.resultContainerView.alpha = 1
            }
        })
    }
    
    private func resetActiveState() {
        activeState?.timer.invalidate()
        activeState = nil
    }
    
    @objc private func sliderViewDidTouchDown() {
        if activeState != nil {
            if activeState?.isAttenuation == true {
                activeState?.isAttenuation = false
            } else {
                return
            }
        }
        
        let timeInterval: TimeInterval = 0.025
        
        let intensityMultiplierStep = Float(timeInterval * 2)
        let targetClosenessAccumulatedDurationStep = timeInterval
        
        let timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
            guard let self, let model = self.model, var activeState = self.activeState else {
                return
            }
            
            if !activeState.isAttenuation && activeState.intensityMultiplier < 1 {
                activeState.intensityMultiplier += intensityMultiplierStep
            } else {
                if activeState.isAttenuation {
                    if activeState.intensityMultiplier > 0 {
                        activeState.intensityMultiplier -= intensityMultiplierStep
                    } else {
                        if activeState.targetClosenessAccumulatedDuration == nil {
                            self.resetActiveState()
                            return
                        }
                    }
                }
            }
            
            if var targetClosenessAccumulatedDuration = activeState.targetClosenessAccumulatedDuration {
                targetClosenessAccumulatedDuration += targetClosenessAccumulatedDurationStep
                
                if targetClosenessAccumulatedDuration >= 1 {
                    activeState.targetClosenessAccumulatedDuration = nil
                    activeState.isAttenuation = true
                    
                    self.switchToResult()
                } else {
                    activeState.targetClosenessAccumulatedDuration = targetClosenessAccumulatedDuration
                }
            }
            
            let targetValue = model.relativeTargetValue
            let currentValue = self.sliderView.value
            
            var intensity: Float
            
            if currentValue <= targetValue {
                intensity = currentValue / targetValue
            } else {
                intensity = (1 - currentValue) / (1 - targetValue)
            }
            
            intensity *= intensity
            intensity *= activeState.intensityMultiplier
            
            self.feedbackGenerator.impactOccurred(
                intensity: .init(intensity)
            )
            
            self.activeState = activeState
        }
        
        activeState = (timer: timer, intensityMultiplier: 0, isAttenuation: false, targetClosenessAccumulatedDuration: nil)
    }
    
    @objc private func sliderViewDidTouchUp() {
        guard model?.isResultShow != true else {
            return
        }
        
        activeState?.isAttenuation = true
    }
    
    @objc private func sliderViewDidValueChange() {
        guard let model, !model.isResultShow else {
            return
        }
        
        model.userValue = sliderView.value
        
        if var activeState {
            let isClosely = abs(model.relativeTargetValue - sliderView.value) < 0.1
            
            if isClosely && activeState.targetClosenessAccumulatedDuration == nil {
                activeState.targetClosenessAccumulatedDuration = 0
            } else {
                if !isClosely && activeState.targetClosenessAccumulatedDuration != nil {
                    activeState.targetClosenessAccumulatedDuration = nil
                }
            }
            
            self.activeState = activeState
        }
    }
    
}

extension HapticSliderViewController {
    typealias HapticSliderCell = HapticSliderViewControllerHapticSliderCell
}

extension HapticSliderViewController.HapticSliderCell {
    final class Model {
        
        let title: String
        
        let minExample: Benchmark
        let maxExample: Benchmark
        
        let target: Benchmark
        let relativeTargetValue: Float
        
        var userValue: Float?
        var isResultShow = false
        
        init(title: String, minExample: Benchmark, maxExample: Benchmark, target: Benchmark) {
            self.title = title
            
            self.minExample = minExample
            self.maxExample = maxExample
            
            self.target = target
            relativeTargetValue = (target.value - minExample.value) / (maxExample.value - minExample.value)
        }
        
        struct Benchmark {
            
            let title: String
            let value: Float
            
        }
        
    }
}
