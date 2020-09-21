//
//  FangViewController.swift
//  Fang
//
//  Created by liujialin on 2020/9/21.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import SnapKit
class FangViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        let btn = UIButton.init(type: .custom)
        btn.setTitle("分享", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }


    }
    
    @objc func btnClick(){
                let messageObject = UMSocialMessageObject.init()
                
                let shareObject:UMShareMiniProgramObject = UMShareMiniProgramObject.shareObject(withTitle: "title", descr: "descr", thumImage: "https://img.zhiqian.com.cn/house/second/1000513/2ca7ckxe90.jpg!2") as! UMShareMiniProgramObject
                shareObject.webpageUrl = "https://app.zhiqian.com.cn"
                shareObject.userName = "gh_de27f284439b"
                shareObject.path = "/index/pages/wholeDetail/wholeDetail?enterMode=xiaoqu&id=1"

                shareObject.miniProgramType = UShareWXMiniProgramType.release
                
                messageObject.shareObject = shareObject

        UMSocialManager.default()?.share(to: UMSocialPlatformType.wechatSession, messageObject: messageObject, currentViewController: self, completion: { (data, error) in

        })

    }

    
}
