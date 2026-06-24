Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F08BCDE000
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 10:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782297529; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=hMXNs6Tx4C1LBPmGjczLw0fQ5548xn/1tsXY7JbVn5A=;
 b=jKyGuX/uUUzrU9GkVIHv6vIXVVXkBvBuz1lGiwlTRoAIKBNJLSn/wFd728YXzLPSH3Gfg
 lfaiZk1wxrd9Psi0IpDOIxSjQDGfsk2AE6TdN5C1LxaDxzr2GHELkLuYHbA18EEW7+YEgYt
 BMtquOREbDF9f/4OgBQhlLhNHW+cI3Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42EF03E594D
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:38:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D8C23E1644
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:38:29 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BB2D96000FE
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 12:38:28 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-49258ac7294so5951405e9.0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 03:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782297508; x=1782902308; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cw1xtqCmVEFbGQCgfhF7TcIgLIeHhi1iZSgoymsjbq0=;
 b=Z+X0CTla7knWFpDvPSgwXG8J0mbt/dRW1pQYZ3BeXmSP+nbvAO79LNpA0VgVXRWNl2
 vth2FbkL8VnnNsFepwsoW4TEmEScvyv4DM9vaZuhzqgWXatunEVdyIO3J2LidunLI7bV
 16OE1ViHQdFWgcEuGWzb4Q1d5K88V/SCKjqFdDjsXvtN3vkBrGoijQJ6CGFelqgqTfUn
 VvK+vDFX3XoXqY7MUXZYXIL3dXV4MWam7zCUsYJEEzVTx8+z34+obdVBEgR6yLRKEVK6
 zbvroH4gehz08PQFSFPd2NAeWBPxqpU/lLNh4ZygjtSYDsu7u0Q7oO4yciChvu68Kpk8
 V+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782297508; x=1782902308;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cw1xtqCmVEFbGQCgfhF7TcIgLIeHhi1iZSgoymsjbq0=;
 b=q+xu7w0OnHFODAxg9eryPLG0dyH/c/Gl+2ulAJfjmBMIuKF3MPR7vfEsTNBzN9uZCZ
 UhctV+xto2sHUXJO5QF69dX36a0OLO//picwFy/2SpYO178hF85seR3b5v1EjSefwkuE
 cWfeZWhOwEhMKBIFxtC8TPN1WbOG+INvoXtvrtoL+4tMRQinj6OaYg69GJUlZzL4YFFt
 VMbDUb40oxDOJUXdfpGAI1YHGgA3zt80Av1NRn6XpAA7P0aIcIoUFL2LqSQNTn2QmciV
 8/N/M8AaBCSyQkynjZWuezNdRxXIPnGSruOPo1qYbbh3W0g2GwYKfQF4mHKou/yinFHg
 Sh5g==
X-Gm-Message-State: AOJu0YypvlRygXTsiPhq4Ytz31VNr8+kmBHqxT9ZNbnxhcVDPxcLLD+p
 nEI4XVxDAxws6FPEGfsvuQ75e1WZcWBAEIacvTo+/z84bU7xbNnh9h73YZ7CObsunJc=
X-Gm-Gg: AfdE7clo7na8nq26xbDAIszOEbmpm6GA+yVMupsQLYgMaVmS/CX55FTWMkMzsPJKaIc
 sdeJa7BpzqA51SWzgKeAzmiJbhCBNl19gESnMsqh3U5RSGTTj6061t22w47OBOLb0dsAgkE7vEN
 vAAMIGED5IZrEtFHk20F0Efl3lt35X6mGAw1lkaCHOtL2kc/VvKUZSju2RbF6XdRyCswBgM9qpL
 5WWaOMW0kcwFspT7Yh5nKDGrLu/BWYs6aurGDoqrmFwllyc+sBtz5MQdq8H3ZBnYF+GmYh6DMTH
 9t/MPZzsMN6d+AwSCVSWRbl5huYAM6zYlJ81VSk/DJMCYjkMnPqwGo1ZBAlX3krS2vUCu858MYX
 h7YGFM2Iuk1D56sINP8CDZ7p6ZBw/sw6fFG68g4muFb1Bgkzz3f+Ni72prfwKgmMO3EwiwDV0ja
 P/lNq5eTdAZrSTxmpudfCEN3vzX0AN/JLXzGrcYifyr2h/BA1wRUBwfhMO2/NMpoPur/vYwtptH
 NceFGDaWppfpWr4QrwAintJW4BTnNVCW51eQCR8QnISvacayJdexdKWEHm7Fsw2uQMtHtirwS9B
 3A==
X-Received: by 2002:a05:600c:5493:b0:492:486d:77ff with SMTP id
 5b1f17b1804b1-4926087f997mr37068055e9.37.1782297507919; 
 Wed, 24 Jun 2026 03:38:27 -0700 (PDT)
Received: from p200300ef2f13eb007ed17b715703ca11.dip0.t-ipconnect.de
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923cbe7sm343198605e9.8.2026.06.24.03.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 03:38:27 -0700 (PDT)
Message-ID: <6a3bb3a3.2ebcb9b0.30a7e7.2d58@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-2-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 10:38:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/13] tst_test: Add may_kmemleak flag and
 annotate tests
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

This seems to be one of the first steps towards an
"informational" metadata that can be used by the executors,
such as kirk or openQA, isn't it?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
