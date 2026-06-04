Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34A7CD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 04:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780548635; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=0Ykl9Hd8Unw8okHoxY7zBvYN/wei1BPJ/k4y0NWMfSs=;
 b=SrrtEQ+nOUSLMnC8oLNvkzMvpCtLltrVbScUU+wjkEfZ/0rrDCNyJEkyszMIrdjdecvh3
 ZOPE2rMhRJzWXg7GKbd11cKnnXsBhFH/EOTn1KWQp4ASzEX7/SDJAACGeGcS+hheB/1kA0Y
 M4ZWDOKVzW53D2IuTFuv2kwoH/K+VCk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D6CA3E276E
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 06:50:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D9753E0D3C
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:50:14 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 85C891000900
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 06:50:14 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso1631055e9.1
 for <ltp@lists.linux.it>; Wed, 03 Jun 2026 21:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780548614; x=1781153414; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4ELPzeNRoiCcbF0613jmYnv02hoURos1wEfSmeR0FQ=;
 b=c5p5xezkquJ3XD0K8Aw3rAQLlNthvE4VCiRQUwyG44el91mP/xZVissfBY6FlYwJ5B
 yj07/eepVOleDTdb4SOZBYw08V0YhqTboa0TJBWb1uIf3CdgB0VDonCpBs/Kwp3RMiVL
 764uRRERz6tdVAeKWKs5wRy7qJRIF9o8eEiwyGBiM1sz7lCnqj8o/AFXU4cN0amwEsAh
 OEH1qGk4FTdpLGtt9khSpnNuLzXD5O2gFng69rlfakGkKE1hjZrcRu4WXs5DN4dC4VJO
 rxFb2Nm3MyZ+0V7zFHJem/h1xng0Fcqu6fRpFUH4SXdnu79B+Lr5Os/NO6cwDkAXkBPH
 ABdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780548614; x=1781153414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z4ELPzeNRoiCcbF0613jmYnv02hoURos1wEfSmeR0FQ=;
 b=E38r2dKtJZrgapQWW33Np0yczD3pru3BHwR2bkw7JkgdObArc/6r/+yiXrjAZbl6bo
 KGf8CErpWZolNaXZ/Pv12aq/4x1QSpPfGIW8L3e9YTs2l7W0pquWyNJSt6MNsWFqkZUN
 9SZNfZpbmK6C9zsIwqnLt2UbnFYQpsw7aWXbRmNti6kzESklYxqPaIbILCQuzBIf0Qlp
 u/yQ6EtzIRThhFp/Js1fL5rRQ0gYGdn9HSZD+M+74Nb2/Pk9MPfG6FgQiuIqXm9TpQMB
 hNrqJ2wIIhMHc8JLkWxd13NoVzhINwmwYqLTqCWA1b35tvamp4RI2FEODcBN7PBBYUcD
 Q+ug==
X-Gm-Message-State: AOJu0YykbcoOGDzMLgmTVf0NzHqVtqgtQisQR+PPN78XiXtTn0muu4X5
 g5CzSyiTvZjdoM9vzekm/Nrp5u4qzxi1wiM31VI20gpzjUnqisyRfDr1y11GA69JG/36ri9iPvm
 HyFk=
X-Gm-Gg: Acq92OEENFWGv9r/gQDHM2N/8V7un8epevT0wLyPlqorKhqCEYa03cFoabyHUD08jEj
 fCG1sxFxwdmCRpR6aOM5fTYpUWhMmS++AAnTe7tXF5jF8ZbUrBsvAeex4KbazGJ+OmBhA620pG1
 CkRnthFSoVSJOY47+zne302OtZrH/oPGWzUA2OtOLFaqZHoORItXCgdkNb7E5JMiq+4HN2WdeaK
 Jtf9iRBTHr0HAKZiDpYzAEPUe7Gz7sWFTP3lEiMX2DS932VB8olbnaVtWjrm0gvt4ucQjk7Dj1A
 nQFtY5s84w/DQnnQbsf1cRlC7LA+XRQdq90oFK4pikMO+ZBa5KK6DVS6YeK+vDOhDGnn22N1D0a
 utrGnHasIOwRR2kSEYOG0JxrdSxRs3+UIYmMKEw4PDI+oOcC4fCE9iOvLamTpoNuV8cGx2cHx50
 bFFTo2CZbA0B6KQfHx/jkjnA==
X-Received: by 2002:a05:600c:1392:b0:490:a1a6:6f24 with SMTP id
 5b1f17b1804b1-490b5eaad68mr97331185e9.15.1780548613957; 
 Wed, 03 Jun 2026 21:50:13 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f0a43e9sm13216102f8f.0.2026.06.03.21.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 21:50:13 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 04:49:54 +0000
Message-ID: <20260604045008.29021-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525090228.11895-2-wegao@suse.com>
References: <20260525090228.11895-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/2] connect01: Convert to new API
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

v2->v3:
- Update copyright year to 2026.
- Fix parameter continuation indentation for sys_connect() per kernel coding style.
- Use SAFE_CLOSE() instead of close() for the server socket in start_server().
- Add explicit SAFE_CHMOD() to SOCK_FILE to make the EACCES test umask-independent.

Wei Gao (2):
  connect01: Convert to new API
  connect01: Add negative tests

 testcases/kernel/syscalls/connect/connect01.c | 395 ++++++------------
 1 file changed, 134 insertions(+), 261 deletions(-)


-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
