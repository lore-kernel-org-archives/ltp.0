Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440B1EB7EAC
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 09:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772616060; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=JcNO3onumtnzxwNrqPzLB5UK0Ktfvew8fIFHC/iTsGZCcAHulPL/wG5S+KjlCgvm5w8tW
 T8Ml/Lj+DVZzvXmcg/MOSm+8k6CfHhakY0CEbkWo2AEV9vjlJQsH34kBu/FtX72MWsgaRdM
 9AwaR937QlHQ8Ez4cUdjcXqB5jfYn6o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E513D3DAC06
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 10:21:00 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4263C3CB27C
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 10:20:37 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D433F1A002F5
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 10:20:32 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4833115090dso67599085e9.3
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 01:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772616032; x=1773220832; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=crDtNuvr/mGyGgUrjvz8LHWYsgosz0lTFAYrEVT8ElEaInTZhVslhXddhHlIBnPb1A
 BH+F7zENTyYcF2icZQh/p2n53wDwmWAeEJb3Vzlk8BYFeMV7L08vFzS0uRLVJeCMT0o4
 gVPXZZNh+wKg67MqJTA3kCOh/8gEuMOkouo6+AFSLaXTq+QWQnt18zfBKefJ5ApSx9XW
 JiHaQCwY3zFa05LYqmZ5UohyPEA0yLpG1Ig4Hh44jNAoZeL1ThUtRt0gsx9uzUTitHc9
 47kiYGhKMqI14feCyvBggSE7+0g73Lq5tAN2bOSV4NnJ70zCiCDdHsMGvN7JNLGZUiL0
 bNrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772616032; x=1773220832;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=kM69saZRbyQ8PKHZ4TJ2s5GWPL3yMfTKTketAN/U0z7+Ix2R7PcQ5xqaRcLylPSsYT
 ncvJlO2wAGmmsmAE7mEFAm3Qx8Bsivgn8sx1sAqr+ZVEeZSNjf7QGwGGL7cOQreI3nPU
 kwVRDjQIgsp8JQ2uOqEoFXbGz/h+G6629/rnzoEuCoyNvPEs1Jc/eimdRhM9aH7/ZoIM
 U7Tb5LSL+1svAgufJAkJH8nzIGOrYB0mPYUJ57kUsQ6HuJn9HMVvbmHXxKElj0E/VFeQ
 eBKjD1a41nNe23Kd0dmc/BDogxY98bGOF8twVPwoCD8uQEuT9NMrEMic9TrfuMDqX9Sl
 6cHA==
X-Gm-Message-State: AOJu0YzbZbmp6qRLt9KPYP+G6TrKlqFG2HqQ5rbpBQHV55IXjC+WPtCP
 j9Q9e9BQ3/QsEhZMEuUuOf2d40Gc4zga3LYE3iYfUuKTfyDwVTNiSn56tN79dNISuLWVotNaX6X
 mWMziNgM=
X-Gm-Gg: ATEYQzxlcZE67x1LAhDiSrfHBTt2G6Px4wzE6BTnSbsQxvLDf2/JrA32tr401EM90zk
 jld3SBTqGp5fwtjpU5odrqqAPQyCKw6F+ZSPai3TtzmOYwwIzstfaCjtGGbTuQqD3tFMkx1RmyQ
 NqTMr4aotpVOTgFR2GyfpYV+wkALRz6nSA7KfzXveIpw1639AQgtCw/oi643jTKVrMMAtKdC0cc
 sVqy/Pjih8C7wP+LTT/rP8Y5ecr+RzhlGONvE633jVO1VMVwOX++dClgIeX9Hq/rEddZUZKqIv9
 qFRKkoZVb/qf72npI5FZO9L1Uto9sI/fkhKuC2BDSnZaL91hF4EZppaCS8A3PRkjWa3lDafSOr1
 K1PUNXXheGMSnPoZFtGbeWN6JKs52Kslxu60i8ksgEWUPCFiNDUD9+SLuZjVUk1U/cbsSVpJPRA
 kQYEWAoc7Dy6ZAFrm6krLJWSnlY+wsDe9y5gjj6MDE2Ht62qX25GGMSdjXfvVm6jaGdAQOj6r+B
 NA97+SyCUp9BBWih4exnWIEhoFnuHlRVN4=
X-Received: by 2002:a05:600c:1986:b0:45d:d8d6:7fcc with SMTP id
 5b1f17b1804b1-48519897a4cmr19150275e9.27.1772616031649; 
 Wed, 04 Mar 2026 01:20:31 -0800 (PST)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851887fa9csm37916685e9.9.2026.03.04.01.20.30
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 01:20:31 -0800 (PST)
Message-ID: <69a7f95f.050a0220.23477f.af4d@mx.google.com>
To: "Li Wang via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260304034034.59303-2-liwang@redhat.com>
Date: Wed, 04 Mar 2026 09:20:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] lib: Extend LTP_ENABLE_DEBUG to support
 verbosity levels
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
