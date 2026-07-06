Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92337C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 07:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783324680; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ko4GqYIo7hpuL7dPZCPNlcFYeeuUE55Gr1ie0ceipJMNf4G7YkXeIAsptkPZuyG2m8Ms+
 3yvTPvziEsGHqx0+NOX8u/6CVIRbl95t3p37L0niyvAc7rNV+GrMHONlF/EJYFEE6TiH4FQ
 D9J70KOHAvbvcoUXb/C3aIcNvPgHw04=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 765A13C9F78
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 09:58:00 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8A233C25D4
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 09:57:39 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD15F1A002F3
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 09:57:37 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso526642f8f.3
 for <ltp@lists.linux.it>; Mon, 06 Jul 2026 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783324657; x=1783929457; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=N1LrXA/FU7bl9s+ti+2sZBcAd/owXniPaPs7L3ggwK1yHeg53rEBMg07YR+flmfO8J
 3Q05mtaGKo+8iiIh1HF9JboO1cW/+LKXvYl/QvEca722dR1YXyoLScTclYHUu+Ob6Loz
 Xj6cS5eV69uKF+XIcAPalSLaHJD2f/FQaTNPGXnyczAwQ0FPH9kESImKapMrFj3CjgPY
 emHpVed5l0H3O1Y8gCzQWTuuCmubY6NzTIleeS1Ge7zNt1Pivbc60awyYmc9fwKnqRku
 6SbG440LFtLVTpgOvmo5iBgjqKy3sVvWlIvikOs2h/C1m+hlrjX1I7Oql0oXOTQje/Vd
 JUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783324657; x=1783929457;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=mJsFDWlR2W1panwN6XXwBytWEhEFcyuLadhEjRGAYhjG1rADgvogwrDpp/lrVhpIA0
 XJ1E28Lr/2u6bvlzITMoG8r2BWZxjeP4ktlHvpDZFAonu+9SseaREEABRzJ2VPvo3B8Y
 jTNJg3TK5qNt/Yw0qO5t/hplj2HTArDFeHPx2DzUVcvHNDy0rLYgLmSnFeqPJfGPvjYN
 CE6EdMebIQ8wpJQ0E/9cuwWPvsTzFUz8GqZt24cUZxSLX7re8hkWbWQg3ZHBgXg+UN/F
 W8TBH3g/754Z863kF52PVqAodf8hCp/4KtSmUOJqxfGQQYIZdp9r7OimUWEtD8xkoIzi
 99xA==
X-Gm-Message-State: AOJu0YwQvfjiZRXwTWE+9HvGl9mstm2psiiiW9zkgImLWK4tZzOYZKcL
 bMeplEbIO9hLR67u3Rk5sifxLO/pCybve4cizElFt67MpMQu+fUst96cIcngITanPrsNBDM/bDD
 YXNtc
X-Gm-Gg: AfdE7cnLAosf5y9jdw+rZVDgUwJQMf3tQAbLemdWj9SOJBpYQ2zRqY0A86TwhHPUJi/
 mBF0sNlkXzk2J0xhUrsj3NdxOqec4FS9MKpQ71P8Cx85tI9Tstf5kxD6P/pMXAOLDHy+jg4gBBq
 zv1MBzTFuLH3FEdh6S+VKK5zonWKYE7oLmEq7NMAKjLl29IIRjszV9afOMgpoVmNqROFu9/t5rj
 G21zgQ5A2OVlBV/u8L8istC8g4jDkxnE4KXFHyjF2k1pUd2GSbawsza4Kej+dXc4UIJBZd3q2ld
 HA30+QXVIzjW+kTfQsapXNq/+0JV+Bb3CYHrwtJettLCZ4zodIlcaYh4w1E9pks5EJpPkwtHlcI
 zKsbuBXvM3oz5mhnBmYTg/kGxkovKb1fZhyxfxYJErTTJPlXci0+kgpM2JCi6vg0/XFoiK1zawE
 s3BoMGLyJJmki2JxEP4sdLtCMEknG+67EhnOLc+LX/zbZ2nsUCuQWvhe74cAIBQh4rndDAGjB9C
 Cdbli8qJYLyTyd0XCfHUqqDtpNVoqvDGw==
X-Received: by 2002:adf:f0cd:0:b0:475:f0f0:9eed with SMTP id
 ffacd0b85a97d-47aae97dee0mr8174520f8f.50.1783324657011; 
 Mon, 06 Jul 2026 00:57:37 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8cdsm24478011f8f.1.2026.07.06.00.57.36
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 00:57:36 -0700 (PDT)
Message-ID: <6a4b5ff0.b2781ae3.385c0f.d976@mx.google.com>
To: "Ivan Hu via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260706013720.450291-1-ivan.hu@canonical.com>
Date: Mon, 06 Jul 2026 07:57:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] landlock04: Skip variants unsupported by the
 running Landlock ABI
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
