Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0DFCD3427
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 14:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777991569; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=SdQAcPqgK8LG10GxgmOI3J7ipBJJsgbn4vBb1aoSX7qIIxrFxXAqrOEqRwru4cfdehTyK
 m/V1G/mdT7NnPwoOWoupqLwKW8Pk2tL8X8galuWj3qpm1q44jcvqqAbmns8G4a8Gl5Rc7VW
 QtWSVSk9rrI+/krhtH1jK5U8zEIjVqw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B40923E6AE9
	for <ltp@archiver.kernel.org>; Tue,  5 May 2026 16:32:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7844B3CF46D
 for <ltp@lists.linux.it>; Tue,  5 May 2026 16:32:26 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DD7E360095D
 for <ltp@lists.linux.it>; Tue,  5 May 2026 16:32:25 +0200 (CEST)
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a85b30dd54so4135014e87.2
 for <ltp@lists.linux.it>; Tue, 05 May 2026 07:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777991545; x=1778596345; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BZDSYq8RPZhvBUKU3zoisZ6OWPi+cIjWI1o33ZLylLTGNFJ+eFBznbFx9bSjw4ILZh
 tClAntPXFSeeXrNH/Wvhk4ULXDkhKPzqifn/LL3vNoQUnBfmfh9B50WsIcPCTacWCY1F
 xdXLdZo5wnUSr9QgCMzhCuRrNO9x5zrxQc1UAuYVCBZ+WsLBEp7tzVbUrYshTeDQWYCa
 aLmBcl1V330TKwy56mve46v8vF1Utp4CK0Gbx0lZNoBsWAlsDYRpB2fQbS35YaSuRsXr
 ecgjlhF3Z/RMVQWGL+DAf/cZolSqvhDmAwqRNeVKHyjqq2/gSP5f7aTRQx4SFce7yWM1
 28wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777991545; x=1778596345;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Vz2ezJNXiBfoHsi4cGa5O+XgBgwtOOKQa8K6j/4CxTXPdYpjw3qVlI9mnZzrhfDbPs
 LE5GXKfNKhwUk8YmWMiaePqnYWJPx/ZTdd5itFlFsWW7OlWm2WR9L6tblh0jme76jMWS
 ASqte8vH8KF2HwSqYFL7Z4AHiSvc+YirzdaWGmdoq1+YSOOUHQA+EsbrhOdCxaGL2/sr
 6+f8AKZ+fiIIv2RscOOglluF8o0CSdj7PUHhY9RYQqSIfp/R96EBdcEqFhMuT3X8Plmt
 5EyQv+rBgz+Yqrt0n7bfpjTVz5cpuktz7yXvgbCFDiGl/pH5aefMTWsk65g7pkFtl0ZX
 4TBQ==
X-Gm-Message-State: AOJu0YyP42ImiBBfd0/fzSJZhzBze+gMbjvZBbJheJ6KmE23t/rKsRYO
 c9RuyTkifbWIL1Ul5Ssux3bZOyvfvF7ZHilsk8bxJWlX+fyoqF+pDwnrEZAuSlycMYni0i+z/2a
 LUFmnrf8vAw==
X-Gm-Gg: AeBDieuCX4d7iiBiXv/wuk/HTbutlyrEloCwWtM4PqvwlyNUTISADPxaNSrnICA5mK8
 mgK53rTsYvSshHOwoLpnybWbrUGeaY3THFCyFnQU+nE1spmQFOdHlkjsOMEr1+S5UgPE4r0EfJZ
 99ULjhLt4T3cG+wFPyi+CsjP88pJ9dbv6/u41d26KxaEek4G/bEg+9ORbFGH2z9toiypFfN7F1u
 4IE1EpTMMhIClG37IVwzMXXGbDP7hTGjmomBCHtisxVh9q8vnfliLFKkXNYPSQuKKPm7GkVFbyI
 qGwYFZ0aOATa03aZ6/AK8fot6euEKThUg31uE+zoakL9YWGpHuDcq8Xsmt2NpMNv2bN3sirXSn8
 Bg+dP+IYWL6laQUvPJcuTlvbyF29AWMd/3vo+AphWLRrpqZZMMTelhcY41I8qY4O9mvKe3tTHVU
 HlePjAtlqTk7CE0c653Oib7jUdymI7i5ipC46MpSkQsn5zvNjWgRT+BJxTnsmvv/gcVU7OZ3e6W
 J1zN+K4lxW7sAMZnfWnc57ZYyTdWj7xOmV9hB5pKIHEZZsoSNdO/m9rpCUHbzpOE8hiV9uZZIEJ
 Sz2rwcMTqRVi
X-Received: by 2002:a05:6512:3095:b0:5a8:6eb1:2b6d with SMTP id
 2adb3069b0e04-5a86eb12d46mr3667701e87.9.1777991544713; 
 Tue, 05 May 2026 07:32:24 -0700 (PDT)
Received: from p200300ef2f4fc900870fb8f8416d0411.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b03e04sm5294002f8f.21.2026.05.05.07.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 07:32:24 -0700 (PDT)
Message-ID: <69f9ff78.df0a0220.260af5.758e@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260504-fix_nanosleep_pts_get_clock-v1-1-754e299f929d@suse.com>
Date: Tue, 05 May 2026 14:32:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nanosleep: use POSIX runtime detection for
 CLOCK_MONOTONIC
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
