
//
//  WelcomePageViewController.swift
//  gotokeep
//
//  Created by Gaowz on 2018/11/24.
//  Copyright © 2018 fadaixiaohai. All rights reserved.
//

import UIKit
import AVFoundation
import Lottie

class WelcomePageViewController: UIViewController,UIScrollViewDelegate {

    
    private var pageScrollView: UIScrollView?
    private var pageControl: UIPageControl?
    private var recordIndexList = [0]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        playStartMP4()

    }
    
    
    func playStartMP4() {
        
        let filePath = Bundle.main.path(forResource: "intro_video_iphone", ofType: "mp4")
        let videoURL = URL(fileURLWithPath: filePath!)
        
        let player = AVPlayer(url: videoURL)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(playerLayer)
        
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self](time) in
            let loadTime = CMTimeGetSeconds(time)
            let totalTime = CMTimeGetSeconds((player.currentItem?.duration)!)
            
            if loadTime == totalTime {
                print(loadTime,totalTime)
                playerLayer.removeFromSuperlayer()
                self?.setPageScrollView()
                self?.setpageScrollViewbackgroundColor(index: 0)
            }
        }
        
        player.play()
        
    }
    
    func setpageScrollViewbackgroundColor(index: Int) {
        
        let colorLists = [UIColor(red:0.47, green:0.58, blue:0.80, alpha:1.00),UIColor(red:0.46, green:0.46, blue:0.79, alpha:1.00),UIColor(red:0.76, green:0.47, blue:0.48, alpha:1.00),UIColor(red:0.33, green:0.30, blue:0.36, alpha:1.00)]
        
        for i in 0..<colorLists.count {
            let contentViewBg = pageScrollView?.viewWithTag(200+i)
            contentViewBg?.backgroundColor = colorLists[index]
            let colors = [UIColor(white: 0, alpha: 1).cgColor,UIColor(white: 0, alpha: 0.9).cgColor,UIColor(white: 0, alpha: 0.8).cgColor]
            let layer = CAGradientLayer()
            layer.frame = contentViewBg!.bounds
            layer.colors = colors
            layer.startPoint = CGPoint(x: 0, y: 0.0)
            layer.endPoint = CGPoint(x: 0, y: 1)
            contentViewBg?.layer.mask = layer
        }
        
        
    }
    
    
    func setPageScrollView() {
        
        let jsonLists = ["welcome_page_first","welcome_page_second","welcome_page_third","welcome_page_fourth"]
        let titleLists = ["视频训练 · 科学计划","有氧跑步 · 专业指导","丰富内容 · 每日定制","交流经验 · 享受运动"]
        
        pageScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        pageScrollView?.bounces = false
        pageScrollView?.isPagingEnabled = true
        pageScrollView?.showsVerticalScrollIndicator = false
        pageScrollView?.showsHorizontalScrollIndicator = false
        pageScrollView?.isDirectionalLockEnabled = true
        pageScrollView?.contentInsetAdjustmentBehavior = .never
        pageScrollView?.delegate = self
        self.view.addSubview(pageScrollView!)
        
        pageScrollView?.contentSize = CGSize(width: kScreenWidth*CGFloat(jsonLists.count), height: kScreenHeight)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: kScreenHeight-200, width: kScreenWidth, height: 20))
        pageControl?.numberOfPages = jsonLists.count
        pageControl?.currentPage = 0
        self.view.addSubview(pageControl!)
        
        
        let startButton = UIButton().getDefaultStyle(frame: CGRect(x: 50, y: kScreenHeight-150, width: kScreenWidth-50*2, height: 50))
        startButton.setTitle("开始使用", for: .normal)
        self.view.addSubview(startButton)
        
        for  index in 0..<jsonLists.count {
            
            let contentView = UIView(frame: CGRect(x: CGFloat(index)*kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight))
            pageScrollView?.addSubview(contentView)
            
            let contentViewBg = UIView(frame: contentView.bounds)
            contentViewBg.tag = 200+index
            contentView.addSubview(contentViewBg)
            
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 0, y: 100, width: kScreenWidth, height: 50)
            titleLabel.text = titleLists[index]
            titleLabel.textColor = UIColor.white
            titleLabel.font = UIFont.getKeepFont(size: 25)
            titleLabel.textAlignment = NSTextAlignment.center
            contentView.addSubview(titleLabel)
            
            let boatAnimation = LOTAnimationView(name: jsonLists[index])
            boatAnimation.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            boatAnimation.contentMode = .scaleAspectFill
            boatAnimation.frame = CGRect(x: 15, y: 200, width: view.bounds.width-15*2, height: 400)
            boatAnimation.tag = 100+index
            contentView.addSubview(boatAnimation)
            
            if index == 0 {
                boatAnimation.play()
            }
            
        }
        
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / scrollView.frame.width
        let indexs = lroundf(Float(index))
        
        setpageScrollViewbackgroundColor(index: indexs)
        pageControl?.currentPage = indexs

        guard recordIndexList.contains(indexs) else {
            let boatAnimation = scrollView.viewWithTag(indexs+100) as! LOTAnimationView
            boatAnimation .play();
            recordIndexList.append(indexs)
            return
        }
        
    }
    


}
