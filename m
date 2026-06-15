Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DAFCD98C5
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781533690; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=by90BgbyVgfWZ06/QuRGBHgJmxXctglMnjNr8o2GiOafhdr0/32lUGX9DRzWvQ2IPJh2u
 WE+XsowsK3Sa7jPBLlvHH5zj82kLv92SfN33wbrQ9qKeFRTKNjolPMFK3zoHN/0ss/JVLrF
 g+FGpgHk2/nLiC/4gQSNoSWajHh97pQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE0FB3E5C23
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 16:28:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7103A3C5763
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:27:50 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B71522001A6
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 16:27:49 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490aebf33e9so15459015e9.3
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781533669; x=1782138469; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=SFmh+dWpM9g8O6Q5J5uBKQCbdMJviNqTos1pWTxX2Et0wDvrA/VlvHoiy0mZPRJ8ck
 2fxgsfi6VkbmCmgJPletjJCoVl7H7HxkcTNxMllFuD2nZ4UlkgnG0HofI6HKVpT0CSlx
 AMhfKr7ir75c9fIvWVakLEZzl6iUYk/C0hrh1GepXiCLVus2n311rL77zWLo6f08j1p5
 y7M0cf7cHWC173NCHWm/Xipsu2ZhmlS9Oy7nh4cjp5bazGgjnERs4hUMDvySlnHXn8kg
 s73B4r6XAN+A38TIrcTcHUnUNa57rFztppv9nk/C/PiKB2oR6PX6NDXC/Z4kaD9Euxmt
 x/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781533669; x=1782138469;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=W49fyUfgWs6uLYEDdNR+TBcvZYU0W7xbPd+GW7SElwEb2btos3qPaAOprMxHfY+7fI
 MNh+WwRQBUtpPcO2KSnPASug2UoxujkevfCRutzdHhSnviDveodx1O/vMvHuuPC4KyZc
 erxOd/ugKIC8xFzt2GUk6VShRTIgD7QF7SCCLIeDqxW7g6jyLsHB3Ez2Zk4fYlPENyqQ
 QUJpsEcDZDx+MD2bfci24CqMWLGL7pOaICjVVAYBgP4GK8IG0o8Nbi7VaY6EYYw+24jG
 J2/gHCiurFlFI9bQx1pqKDtI0GS5nqJau2ScxwU/UqyqT7gsMrFaeIHziG6V9rtehDsD
 HArg==
X-Gm-Message-State: AOJu0Yym4DybAcn+AEWqGtqGC2UNBXZSWcePqk4QjgN3L7lizwwTHmP8
 QtQAst3RFN1bqavWip/McIxTgBmrqjhotKvMxbcCCN+1Nc9oQ8f1B4vyHro3G09Vxn8=
X-Gm-Gg: Acq92OEUKFRrY2zWT2OkHzwbH811JXa+flOXSWyI+CqkGya5NwCmYQ014e4yvkY0ipD
 vWz6S+AMEThCEI3WKTOuRrf2fAIr9flI6z7lArdQz2cRhhb4dXwMzOilgEQAYnJNEIfGT4g8XXf
 M+ZpTmIgPnZ0beJC/nQPwjMCMS5LG8O0QHAF3owmfXQH+F1ZgkQwl/TuIJ747hQ1TLJuO4dHO+q
 ACfMCFrGvb2X7DILPy21MlapFnef3/1DJBFCAEkNW/2euW6HijhC5n+XQ8V8RWD/WF0cafWJBYc
 v0fyXS3HamkJ517sKfCnCXhJYtk2wILV8bp3DuXp+3GWibPxAFtXk+JiJFQcLQkoCrFsj+75WVb
 l/vdwFon+xPgKpYa1CUrA3ntO/Gv3ZNKok9MNgJYU/YZngUlX7kdESdf91iPNKlnSNzO3uu1/2M
 a+DNikCkdmpDtn8vFkgQH2vTezTkvxXTgXYHLasm9AG25wVdB3ueV6xukKCWe34FBwPMRnTgTQ
X-Received: by 2002:a05:600c:4595:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-490ec4fb683mr193835985e9.20.1781533668968; 
 Mon, 15 Jun 2026 07:27:48 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922031b7d2sm274890635e9.5.2026.06.15.07.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:27:48 -0700 (PDT)
Message-ID: <6a300be4.f844783c.2a67c4.8fd0@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260615142526.70655-1-mdoucha@suse.cz>
Date: Mon, 15 Jun 2026 14:27:48 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openposix: Remove pthread_detach_1-2
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
