Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0701FC44507
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784279110; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=dN7jHwRnYFIonYELgNYlFzi4/1OdzrASStYzfKjtBpSsvw7NY/DnSVEgFem7/5MtvR8FS
 xsvBYOV15B9CZLElduzua81cQV/JQk5VVDKkbOzrNAUy4c/roR2N0csKV93bB87DvIa2VUW
 iFUi9bZFNdgc9sYYZjSft5ThxCRWGoc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C50D3E5E98
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 11:05:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 683BA3C5E52
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:04:50 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C7CE31400DFC
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 11:04:49 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-493f25d47dcso26554905e9.1
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 02:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784279089; x=1784883889; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=apEouaj0Oa9W+q43ZeK6m3Ugpy9vfyB1QpSJliQE3BBcHXFcYBMX698/uDPAhUVmKN
 j5uL0BScQfx68TSkRjRssbHTm+eH5IQHeI2LrDpJUBjsBc7eRMSDBzXcMZQzfsKIo5c8
 tH7mF0j5xLmwZN1Gr9spp2BEeCMYPxuKiz/6QIKulITt5JAhLVDkL13mbDl9wwGWjDRf
 FerSrt0guKrecVpAUTElvAIle2GyN4Bq1P/XaHicu/9UYMWdN8i1/DrU0ky4FIsrik3r
 GVmqXSUmCf6O63rtqVVOH91W7tQX2nhJMvcQbkt5tms97kWuk2Vc8s2vOnIqGo7Q0UPx
 G5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784279089; x=1784883889;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=ii553ZybJ2XeuH2TURjC1VJ4q2wNUY5zbyJtKVpu3rILf/Ibcz6ZHf+HE4kZzVpR5m
 xVkszzp+PIzPiazICRDjth2b3hQKgicrxMF3Hhad0BSDBtt4R2x1Qpco3tnixyACgZPt
 aovcLgYtSCS1zlNdayR6IvYte6kP23MG/9uBrQ707O8PvOgoAcCJhLee4V9sZumigXGD
 WedwlJCihx22BO9sgslMe9z/L4TY38+914UIUkD2egUv7FSDomrgx2tdMeOY3Lp6fvop
 mIhgd2nkPnzrwS65Et3Y4Nklh/Ndt/dii+Scuy1RMMwe6dTnIoYgpPqANgnD9SN1M10H
 togw==
X-Gm-Message-State: AOJu0YxqblW859dFLGLkUiTV1lFOMPBYyXLdUXALnvFNMH+aIQTHyHer
 4DrKnshGjyU6I/jHp4cirUuph1nMtxohR4Mv+bNR00UCMDMo/nW2LQZ5sqmLPRc/v1Y=
X-Gm-Gg: AfdE7cnXmim1Q5S4lxQwnDd/9U5c5VmAgI8/4rdmSCRaToD4n8UCVOhOm6r0ra9yi/G
 PuV5lFy/uFFLqXnDKMj8BrYdkHgYpepB/kM9h396zS6+yQ1LIXao0ERRVCTcdef6lJ2YB2TY14v
 1xkpYzn1tNZSDWIPReQYq8ebFHgROpY7d3rzY6zlfBofTWq65jETMyrg2Mzudcd47bn+IJCKNsA
 NZEXTizC5A/+yg7zHyPSOQqjJHxCjuH5HBSbJk+eFh81SF5K9SkaoRlIePai21YwlJlAHeh/TAr
 O92Py+i4eyzty4+776s2JIGseJPceHTWetM0p8UBHMh6M6K6TCLTv67exp48t7ffGvpCR2oVtCh
 Gv9rHlgazirALL1Z5bSTSsTMl610qMwKtOSMUfYmSkivNcmwCo0kuadPTg6u+/+4zs8vn4DH3wT
 s7IZZCHJHA2gSi7IJpAiYu1yrDLQ==
X-Received: by 2002:a05:600c:4f54:b0:495:4815:2c54 with SMTP id
 5b1f17b1804b1-4954a41303amr18589395e9.34.1784279089014; 
 Fri, 17 Jul 2026 02:04:49 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2edda2sm29710145e9.13.2026.07.17.02.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 02:04:48 -0700 (PDT)
Message-ID: <6a59f030.48c5cbf4.90506.4ddc@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260717-fix_tst_test_hugepages-v2-1-235342ee6fe6@suse.com>
Date: Fri, 17 Jul 2026 09:04:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] hugepages: make compact_memory setup optional
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
