Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E75C369A2
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744638013; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=W1EtnXsBZbya0DHVqZw64tKQcsdOdxo3L1bTFtVn+cw=;
 b=kQcMTyEeppZHeVYrGGvPL+O8lxWRfVw6ofVH8C5pcRV86oOLLTIJFH3FkOrAzwsYySxjG
 KO4tWYJGiLzh6m7P6HlotWL3uv/9Vvnqi/cEzm/XaT/gFWRaFVVndwEQ8nM/Vtln+pVmN2N
 kl+5bs4FX/Zgk9JyQPuDA6Q84tg7ee0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC7523CB71C
	for <ltp@archiver.kernel.org>; Mon, 14 Apr 2025 15:40:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 889423C0B7C
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 15:39:51 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6A72560004C
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 15:39:50 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso2411826f8f.2
 for <ltp@lists.linux.it>; Mon, 14 Apr 2025 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744637989; x=1745242789; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kR1790xYyXCXkWRat0miL8anPfol4SkuUYSd8LHk4v0=;
 b=HnRLCx8ID0Og7SqLuVzSGwHBXh8OAts743vb1X4n3iFYmpms/9tMYIP51C8pA/JsoM
 2bPXExF7WDelFUG23UepenzjskA7kPCUCOGuQKsrIunN9KX5VdW4KqyhZwKX7QcP05Ri
 H9CZMGXbrEipNI515CNfvafnytqPUhVK8/K1+c9dr54cRZ2MADrAFbu49sJxjGjsdj4P
 Sfrk5LELTvBjTaavY0TF9S+zKgXQ1EW5bCQjTdtlr2AYjrlqL4OF9cUXDZtmAY6VVr6X
 Ml5kZILyfGlEbh+pq7NqU7w2CeoZ+QB3mJa9Y2rZydFueTpy66abMO9VsglC327oQ4vW
 ziuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744637989; x=1745242789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kR1790xYyXCXkWRat0miL8anPfol4SkuUYSd8LHk4v0=;
 b=XTA3/MhAT+woEGo3d2EzfOi4CrR7Z//jMz86+tSgJSDsG7nLdml2DVT6WH5rTIpLp8
 r0xI32F9xLGYKrIhpMeztsIgDJGdkngYjYk1go1BgCCdO8dJz/2w8ZGD9Wcx4dhc1Q63
 m0SbDdufEPEiYn1hSIX5lkaE4V8wTSJkckYncZ0/x4oBK4FSYSurzdFfRwP/Mw+DHU3h
 a+LKpoSUYYrqBPi70h3dZ9YSYEEJhgzKwsLZD2wsJZFQifW53AiY0xfkQF/gAEBRj426
 /bF2xdD0CK6XTECmoRE4FRhBDHxAJbv26jsscVrYdASkYuetGzBw8w9nMl3jukIOKbvo
 v/Pw==
X-Gm-Message-State: AOJu0YyOgt6fOk7qTDucnXgiaDqLCSpL7jBcHut25sxwl7X4mcnxBm8d
 4sHrtk0Xt95nbL3YGIAguUvcHa2p+yyz7jZqPZWJjImD7Jvor9xbyLrr/PDGVYUiteot3lz/inL
 tag==
X-Gm-Gg: ASbGncttTst3HYu51e9DnIsU5tw3YQQR9rwHex3UTtnoo766OYbZlwy0nsXXu+q9DFR
 RmI0U917djWh28Jlt4+pgStu4aetFPc8KcxFgSWqcSShZ8js7O2DX2MyDHMGGkQaSyvvze9TqOZ
 HxtEKP1DnSj1i6CCwel5gtet1tRx7qt8pw5+v3/3AhmdkGo7U44tTmo/aJbTMQgxVLQpbtZWTVA
 KwHaRjXmDRaDaURA2f123DtG19QGgBeFT+KjqVYMeXwD5knXpdgOQQltwtIaFFSQCMgWTxRZSPr
 nmENypMCjwWNlS+YWgu/dPYfu91NgA==
X-Google-Smtp-Source: AGHT+IF9jUNjaWm7BCjrzhEvS9H+ix/fCIA3ezTVc0r7YEA+cqKd6JNRZHwuz0BAeySpy67xxiUSBA==
X-Received: by 2002:a05:6000:40cd:b0:39c:266c:421 with SMTP id
 ffacd0b85a97d-39e9f3d9c2cmr9405691f8f.0.1744637989424; 
 Mon, 14 Apr 2025 06:39:49 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-306dd1717c3sm11215153a91.30.2025.04.14.06.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 06:39:48 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 14 Apr 2025 21:39:18 -0400
Message-ID: <20250415013944.173030-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410054956.5071-1-wegao@suse.com>
References: <20250410054956.5071-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/2] ioctl_fiemap01: New test for fiemap ioctl()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes v6-v7:
* Update check_extent function parameter 
* New check_extent_count function
* Other small updates base Cyril's comments on v6

link to v6:
https://patchwork.ozlabs.org/project/ltp/patch/20250410054956.5071-3-wegao@suse.com/

Wei Gao (2):
  tst_safe_macros.h: Add SAFE_STATVFS
  ioctl_fiemap01: New test for fiemap ioctl()

 include/tst_safe_macros.h                     |   6 +
 lib/tst_safe_macros.c                         |  19 +++
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_fiemap01.c    | 126 ++++++++++++++++++
 5 files changed, 153 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
