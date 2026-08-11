Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7D5C5CFCF
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786437603; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=t+tPDrkda4uUQlbqtfFN0F8xSI5bPkZcInK1UohHcIQ=;
 b=kzdY40Nm70gDDa+0COMEWcmLEXgUtLf+CT3TT9gMP0sOSUQQIzzg9meZFhpiojRwSCTZj
 2+Ag6UaNwIrNvurSZnciKqcV6OAs+xDaDtAS9xfH7PYQfjSE4FDk2Yqco6CxGFh2J6ECUDf
 LlDChhfKMKx+GV4/2tkO+2KJjRLt1hU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D24553D0E80
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 10:40:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 76C653CB2CF
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:39:44 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B55C140025C
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 10:39:43 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so26281485e9.3
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786437583; x=1787042383; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=P5iP6qRuzEDCWIswc1hiWfyPAzvJVzgHoCsz2ethO031dY/Y7ouTATTnohPsaM9P97
 h/f0Kubdr0C0lIAxLOov8rOQc0V4SUkICIv4Bw34p+3tQ9osPcxqShEwZuV5kQRuEFrG
 1w2llu+h9gFes5BvGLxnfYvDdx2kx2o9hVIiDBs8/ZpZ1hz7ryrlAEBUDTYLzcSCzPaz
 l3KYvfG5rxQi30jVO3gBF7WTjlesn6cATcUOWD53ogVuh8KFyazM5YRUzLR2CGhAN/1q
 aG0YsQUIohWPFPAWdCOYImFvPalDtbaIu+nDYir/NMAaorZWcOK+Zkjk0+WNBweIdPKN
 GQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786437583; x=1787042383;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jGXancutBpAh0TGpHnpaxnKSsY5Z6csMSIKid1U+mDo=;
 b=mkMuDGSKOEl6PaFOienm8OUAbRxwEPJi620axOrYCx0hwQF/kN2Gye04rlFmovENoh
 08fcab0j5atrQyqGZttKCDAjoxTfHygT7GntTMhBUMb23HmtcWgeE5phxVs8ftP6zExT
 /lcb/0ajQVxOhMwqd5w/JSR2QQk1T7SdS5dgLvQY9NshoNO8XuRWbvxRb9fT+lhQqHz4
 sG3E1DWV/bDpfYMEwuTuB+uC0oXag2o7Ixd+PgPjxCrCNQeZaQBaNFYQxefWiM5ytf0/
 C1/PKvugWt7crQXyUSCoDlQhsuz5R86rwp/7BDRN1asRBUqnfr+zENVoM71yy33ZnDUd
 EJ8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNcxs5kD52D136eJ7re1FiydXan+fFOk9e5JYteLzAIRz8Jzna05j0Cmr2jgpYMInny2U=@lists.linux.it
X-Gm-Message-State: AOJu0Yz2JirgXLNBGBz4H00IRbxx0oawHWuiw23SKxFzcObSydGTKm7O
 vL189/IGUN0Wp9NnjsyMCR02coNTJkSxjPkrBH5qIwu4Kg9cDpoI53olDiC4ygmdmdg=
X-Gm-Gg: AR+sD11PEGRoIzs4McCf0Suu/KscAfjadqn2Re81zTCr//w2Znjxr2Z6bnUca3Sgx1n
 KzMcMrw3bJ8FzFs2nEY20r2QGz9CRZM4QGAN8NdZJvtNx2Y8x2MB0KVtY1r/m1otOav8FkUwtv4
 9Nz2E1aeW2m25fVxhAuhuktSigXJ62uCjrmNulvZRP4PPH6ZK8BCnHbdbe63vLBIErDZ0UMDwqx
 s4Sh8BTKER0acJcncW1uiOjkKA27gyrlPBXlP6bv8HXfh2GHhfvqDAbwod5eCDqz67hjWiso4Xm
 II1bh3mlHQlW3LZDNBMbIS/3ubsyA+8aYKVhPPGSDvjwiA6LMTOpj2xVRwffhGcRaHjwC9D55Wn
 JHx4F6iXTOeMAB9ZUTqvPIE+mjudzUtblY3M8RmL0fYB24MkOrQ7W7V8w+fgKoh8LLH4o4q+Da9
 7MpC97Q18c/bmayK4TCvFmhCXGm9DX1U5DvEESQEN9xqtlt3tSamRTaI70SpTSpSKf2R7doA==
X-Received: by 2002:a05:600c:8904:b0:496:cb48:5eb8 with SMTP id
 5b1f17b1804b1-499784661ebmr25868035e9.15.1786437582791; 
 Tue, 11 Aug 2026 01:39:42 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49977df9489sm49277615e9.1.2026.08.11.01.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 01:39:42 -0700 (PDT)
Message-ID: <6a7adfce.da15fda7.2929db.1677@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260807000113.8784-1-linuxtestproject.agent@gmail.com>
Date: Tue, 11 Aug 2026 08:39:41 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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
