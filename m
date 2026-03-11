Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2841125842
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 15:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773243431; h=message-id :
 to : date : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=NahAwlYAUGkJRHl+CUnUA+rjUX8JSm7TlKSm4V2Kpxk=;
 b=fqp/oaR6wfziapPhKC7fLH7WwVlnsDnMwRcGCxszDazm/2cb753sTBXgWAstWj3R6GUfV
 a2iRDgJp6WiXJR99PRBGBSk/CeWabyLhc/UtZ9eMFIaDDgp5qSEu4Q+nllbTTg4MpS8w2tw
 y6QyuzhFEoKBVjxJXNYvxt3Wlee4/Jk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82C763E1459
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 16:37:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A4043E0D3D
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 16:36:49 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 50BE41401105
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 16:36:48 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48540d21f7dso29633175e9.0
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 08:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773243407; x=1773848207; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:to:from:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iBfnj8ucdOH/p6C6loStVvyvLXWr4ZmTnqrfoVyGuUc=;
 b=AmcXEhiZUk2WSM2JQk8kRQCXUIudIFnej1En615/UYxQLrsbVPvozfQmaHiKJ0Vcqb
 f0bZiEHhooqdPrafOlB8d7r+sSKt24NQ5WXPMdk7JsLXVyxj85BV2ekI7SyzkaxNGPi8
 SJi92ZhPrhKBqTwziB9A3JHKVDAErjjjn8FRFiTaSib+zUW+K/YcazUqDkp4kqto6J21
 goR86jNGMAb5vI0qBsxmVvtFHBxpF01CvKgTl1nuZsAuVqvFs2W8exZJsoK+e15DPtni
 vrPFSviZuyFdLBGqCVnj20LnphQi4JtjgMMDNncqsWcUM53WfIlDte6iLKxedkHpyBdE
 mHog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773243407; x=1773848207;
 h=date:content-transfer-encoding:subject:to:from:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iBfnj8ucdOH/p6C6loStVvyvLXWr4ZmTnqrfoVyGuUc=;
 b=igQa7540rI3oCpC1FHBcv8omG9smj4WlTwE2KA5VdlpUieJSNnUp3EOYDmLd37FsIW
 8brVhNCkUySqjsg/+WfBfMWxbIRwLjFdAmWjXz/X2DrX2kkLvV8jsu9JpRNDvVAYks5I
 3e6lKMH4/UiGQhhcXtxmFiJbV4SUsK4chrHgd+nRHGRPHoXKJzg2SZDfn9+joLLVp7Kv
 XukHQONTfcLCu+JFlk3HRXDreaD7GIgcRQDHXGUT/LO0qHd7CDfPgLnYqf4IW8Sm4QGb
 IXueGbRCnGSEOn+kB3zgfHpK66rk55ucyA3f6VOZTkMT7nRPhBoKFpLxDZDPJ8nJC4SK
 8Mqw==
X-Gm-Message-State: AOJu0YzxAr05yGGFsSGgPGJU0xGD1CU/XkErTg0I07X46EaQpusjBNQ+
 IVu+wdyZBZnTqrPb3jvOdT6BYMvyMaPKSGZ+g3tZH2Eyp8AOFeUzXoalBlNzCjtMC06g+vVEDj+
 T7n1D
X-Gm-Gg: ATEYQzxPk3V8gyymmoBjf7E789up/9ekeFsU2xNgVNruHCLKtX3iZ+gqphYXF9UmULg
 EhMQ4xssPce1L9mCL70ie40RUkdIr5tSM+2jCcC2Pbxg26dAxHXFRGTFWfCvsGkWLQ09h4x50em
 gU6fA38h+L6YMbeRDogwZDAygqlioYmnNW6un1htCZMFSwEAoapGj3numJSipA6KSBw/m7jA8Of
 B2d40OWtr+IjZj2j1Hd0kHLguw6YYf2MX3QYNak4GY1+lFuz9gyzZBgEMu6vDdKQ3wE+msO3gWY
 4jUcto5sBpFnIhQOH2BLDQlWyUgc0qNOnWgG6djIr47R9qOjBYDV/rPYD4VU3/pccyYD7WQE/tH
 x58aD5amC1MFHJdijbd35j4COTobGmyTcjFayqar33us1JGmOwmoo4gt66pShdb6fILSz9CuZKy
 ACu/dnOnO2pWC4Y4X9I5jfY6SikHm5p1PeNHaVguYa
X-Received: by 2002:a05:600d:849c:10b0:485:35ba:1d91 with SMTP id
 5b1f17b1804b1-4854b1b1aecmr39276145e9.25.1773243407169; 
 Wed, 11 Mar 2026 08:36:47 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b5f6c24sm55760785e9.5.2026.03.11.08.36.46
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 08:36:46 -0700 (PDT)
Message-ID: <69b18c0e.050a0220.17c32a.e62f@mx.google.com>
To: ltp@lists.linux.it
Date: Wed, 11 Mar 2026 15:36:45 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP - After Release March 2026 Meeting
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

this is a friendly reminder for the LTP mailing list about the next LTP meeting.

Ad previously discussed.

Next meeting will be on the 16th of March 09:00 UTC.
Platform: https://meet.google.com/jon-gytf-uei

--
Andrea Cervesato
SUSE QA Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
