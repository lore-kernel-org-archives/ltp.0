Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D86BC61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 08:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787906875; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KI5DnKZHKmalsgGjozAwQfH4kav9Sl8fFdZw4rDZGng=;
 b=Z7hnMLlCc0uB+E44SqfWN2C0KDSwzlTIAuOZVRZFX691EcebGPsn64XBuXeW38U/+wvKd
 D2YUZeZuvbcPhSYxwZD6vtJzw0QnE25cf3QwNM3lCQgWyvBQg35iUEB4HV0RQ3Tz8tq2nGH
 yYfnUMKCj9Kk7o/ufAUl2PT1KYqr1r8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BABBD3E5D7C
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 10:47:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51A693DA1BE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 10:47:36 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA7B7200AEB
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 10:47:35 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47db714766aso1360496f8f.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787906855; x=1788511655; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qPfWpPhuVbzVRxJGqBh0CmiV3i09F+FSgCHCiRQQ1Mo=;
 b=aPyFNyZavzwfRvMzAKzvS2vMXdrR4/aSjbch61LTd6Cg9PIOx9VAAlkygbdaBXOD1y
 xdreyNJoa3/BN0VCtzjA1yrnzd+gj7mV0uu4at4jZ7yHClDga0lbBzo7y8uxU6OhvRbp
 I4xK0C82JCtzTr8kPolcuM0Gm8b0jsFDf8f8lXVTl/Pd66rTF3FlkbRinaku3rx3J600
 YLs57+Ny+N1TbLsB7Wegh70sLz1CeRTkeGMh+zv3ELy0oLzb0nA4pqFFsq9kIgWt08QO
 zXbdh+malLoLHsLkPjE5a+ss/0K4Kzh3jnCDV2rby/gGLIfgv8WAZGYHF1Ndgh+3XV49
 pILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787906855; x=1788511655;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qPfWpPhuVbzVRxJGqBh0CmiV3i09F+FSgCHCiRQQ1Mo=;
 b=ZKJtTmp2of3mVJIsj4xQrFxyPxZw8bTvan4zXjOWWwji83HED/ksIM7U2wV2i0dpSr
 tJVG4JX6NXf5k09/JUtUsiwhbVpZtEZYamoNq7q6Ko3VD7qeGRreTsLIFqiQnFrs+aTG
 +6sfMRwCLHpTnmeHqXvaZijOcr40uL5phfgaJt0ps1cYuODl2wdFNfiX9nXuyZ2EKWVe
 aRyAIGsWi+oABXqqzE3EjHeiVsS2A0uZfUUdelJRkiOIILhaHq+84+7N6j035Y7YN4bR
 pbVCqVZgjjA1L1sr0bxUlZToyiQ45Uu16TJB+J4r68tUq8yjpNkP3m/9iz0f++7WMmPm
 +MvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RppbnBrO41LC6abs8+JptY6+kS0khZ50xAALt1/RdNYcXXCKgdB0tfUjiwxFpBz2AE1R4c=@lists.linux.it
X-Gm-Message-State: AFuF++lK2uZgwnZHo9f/KLK402/r2EY+ejYHdZSeEuXqnCrdYvMMC8Fx
 rj6kLbl63Ap7XI2c0Go40UnFProx776nNds+PWrnZyfMa3aqYxuWCgO/P6CbHq9Pfq4=
X-Gm-Gg: AR+sD10gLff4GKldldtCe+sv0P++yR5nlEi/cJpFS4RyA8B5WAOVc0QDt+QoKjE5V5m
 3yJ5NWayAvhWKTNCZKHxqz+v782SkXwTQNWDCnlJUbYQsfoRwjTw01EmBxz3aDs72yXJ6aFqIG8
 VgIBgUV4R3iTyQxi1g/g6ifyA80HwTalY+Pf49L6TXfImAYl3MUubJhLUvyF0WAUv0DtMo3Flpz
 26s8q/INRGF7KVKTVDg021re1nWH1Pq04vyI3y/9vJ2vf52FSf0l65hE+/lZ5x6m4SGVG2AHIi+
 XQdOXTqdwwahbMHEiVWuXON6g9VxaYdVPpG+XFnDT/NtSQP/mVFiNOrD1Gokv5v6id19xcFBtIs
 Qps8ddTkEY5ufMdQsWdsnoAYyNnbycYq6MIRDw4llR/az5T7Thc57QmKC1Os7xoyRp/RQ8awG/I
 Z+xRkr8+e6zJT+L3+NcrTdp2pmfF2v+G0R1Kjkb/QgIAqs0WYsTwKNU/jNAhXPgW8K6fipMsG6A
 B2uHLAIbMQ95ayQj8Xyf7vdxHgrNktRAvib/bOjohfEwWzkcUtRTfM9PsI0vxs2r5cxgnQ=
X-Received: by 2002:a05:600c:1c28:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49b91a5899fmr75803795e9.3.1787906855150; 
 Fri, 28 Aug 2026 01:47:35 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013d06sm46133485e9.12.2026.08.28.01.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 01:47:34 -0700 (PDT)
Message-ID: <6a914b26.1f1211b9.7a419.d9d7@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a91470b.7557dadb.15e29c.77e9@mx.google.com>
Date: Fri, 28 Aug 2026 08:47:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] swapon04: Add test for discard flags
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> this is interesting. Also I notice how it's hard to read the logs, so
> I need a TINFO before the checks. But technically, this could be a kernel
> bug: can you please add a sync() before stat() while we are getting the
> blocks_after? We might need to flush the cache before reading the blocks.
> 
> 	fd = SAFE_OPEN(BACKING_FILE, O_RDONLY);
> 	SAFE_FSYNC(fd);
> 	SAFE_CLOSE(fd);

sorry, this should stay after the tst_fill_file()

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
