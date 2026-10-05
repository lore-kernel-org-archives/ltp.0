Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F94CA5FF5
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791206226; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=LGaPhJAAvXQBqhZk0/kR91WCV7xmQ6lTx6HRkI8iFYoc3m0FHLsmDI/VexJl95QpM+KOw
 /ahNVpdTtMNr7BtJan/7tx0NPNjgLUTn7MmbpjJGHxEB3eE2KThCympitfYdeDH0pCKRoUL
 Qn40C+fIbZ9RaYEx5HuWd7QgntaJI34=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AADB13E6B3D
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:17:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4A6F3E4B3E
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:16:45 +0200 (CEST)
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com
 [IPv6:2a00:1450:4864:30::e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C7C7600731
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 15:16:45 +0200 (CEST)
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48af9f88c95so610622f8f.0
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 06:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791206205; x=1791811005; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=fcLU53K7KNxj86DnlwYcn7AUwGfwX5+9mA6I8mJxjnVH1vs6nrpmR7MFTvxwxcQzMs
 07v9y4tJDehiei8E9b7u+/2SkF/HyULDdl781I2PezkqYMUPMUMF3LI5dFYVUMgGkMli
 +QpCXur8/1bs3rtm4PV5th0I4uEJNG+rL5ikWU59bVsNLIzkmKnTwV4RLEd6nd1aW6ro
 QsrmorcHiKh1G4+mzR61h3n2S1RQgRjyexUPyrQV7jRejx6ec5fVx4ORMYAEsG6mf9TO
 ZENQ1aKtedooYOzPfcdvSEXLaV9WYuPrwa0/zUa3oMDIzzynLm5bQn7RfGSUEv8n4gGD
 pAUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791206205; x=1791811005;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=N3UOUyRjD9tqhxOeikvhn+AF3uTmLsgi5juhrEP3IURf5Q6qW4SFiJdOj7dkEpM/27
 SzrK7uLkD3rdH1hrS3v0AHJmO42hoIKcAiWJdHNFk0gz+3GVhOoVnX8qRCmcNXL/1J2v
 2+mPERqU53Ykz35TgW82pJzqrhim2kfQeAf189H6QObL4YHSTE4IufwaNBevq/FDOyOB
 HW96ZsQ3+FLod2/RMxsVBXsI+XjPoKbUiqDYTagSUEBQqvt6x2AOauiOX4pp8lboKQhe
 F83TBEHlogxvPqKso6EAaJSgX+FMFddyIFzR3TtKDtk90s9VK04oYVsO63Ye+fZCdInU
 BExQ==
X-Gm-Message-State: AFuF++lIP80BOYJ/GlW65UwDQBTeOrN+LrCeMkD1vL4KQSsqOtRvCvwS
 SihyBatCAHhTde7pTkGNvoplgCuBZowsipeCjq3BHqeCXtLBVhOe4Z9BOTY7KWkkwIr4iyPy6lA
 z5+4+jSo3/g==
X-Gm-Gg: AYBFou0Zalzvfz4z8rGtnl5r1iJ/Y1Nki8YT5j3z4PqmiJBNzFubl8wjpbfRkB55QiR
 uepTR3nZOgl705u+0/eD/dbk33fhYSXnTFO9FbAeHsSajevPLlDyrKvJKmVEAGvcssQI0b306kA
 Ss2trQV3z6nxi/mygsap4n17+CKDyvz13vhxxYmC39NxJWOXZaYcRqkmwF1kncmknbIk6GkHzAz
 UBb/snWuMF1xjZkyv9yOjBd+5id7E8pD5BFv+8nBDfH0tkAVvPxM3uKeHPm77MfzSvfGE2Jkxfb
 ib5v+N8Ev7Y21hEqqiX2xC8kpFOwwpcpc2b520WiPZL2CqZXpik2FatHCi7Xt+h7qNuTXM/AZb/
 dVBoCzRwpBu+y1jk69HjJ7r6NtwZRZf76gYKnZlLbsSmoA7ne9L/EOPqX73rjdwX9BwWuySPNc8
 dmoUnZWwZSA5H64uam5/OmSx54+IJE6UE2OSFPWBOUMlFYHjQ5gAA//QZSw+U59IfWEvUsF1Dha
 M+s4SuoVLCPScj3nKyMDjhQAjvcDMbcGa1eFd838IcxfJU=
X-Received: by 2002:a05:600c:3b05:b0:49e:715d:95ca with SMTP id
 5b1f17b1804b1-4a027561e0fmr173739335e9.13.1791206204779; 
 Mon, 05 Oct 2026 06:16:44 -0700 (PDT)
Received: from localhost.localdomain (p50918b5c.dip0.t-ipconnect.de.
 [80.145.139.92]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03043fae5sm205938615e9.0.2026.10.05.06.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 06:16:44 -0700 (PDT)
Message-ID: <6ac3a33c.84d2e96f.216f63.0f58@mx.google.com>
To: "Florian Schmaus" <florian.schmaus@codasip.com>
In-Reply-To: <20260928153059.1624905-1-florian.schmaus@codasip.com>
Date: Mon, 05 Oct 2026 13:16:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] epoll_wait04: Use tst_multiply_timeout()
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
