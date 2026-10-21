Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F93606A31E
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=fGahwJOw;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dZKEvc51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792575134; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=6iU1qyQnxbl8j0Tp71nVnwfcmprXrZwWhxz0iRyz9NY=;
 b=fGahwJOw1YejzNqLhv8rCn5FmDpMU+uKS/dHlDxY+gZuhplJP7nBJPLDV7kOR4v0cbPB0
 JerkKiolgcLv9XgJD2ry9TDG+t9bKFcT0KyJUXOvn4tWAIavsUOAlJHRhi0u8030LINkNJW
 uqSCSBadhCyIZ9O3yJUv1qAhWMDzaaw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3911F3CAB90
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 11:32:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8863F3C308D
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:31:54 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 047436009CD
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 11:31:54 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso348991f8f.0
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792575113; x=1793179913; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UpT7/91vqpjjfqNMPyfHz6KbdmwUqOF35Ml4si+XyfM=;
 b=dZKEvc51hs4y+XvMDqiNYB4Fj+B7fVpXoofWE3MOka86dI/eZ7K4uDY+s4NMqQtzsF
 oxaQP1K5f5y7UyWCZ86zJGz5XGxsXMdziCzYT1HVDHxukbtNO+y/B26Q1Gp0hiHFNQ/Q
 BiZ11Rm3fUm/fuvsSKVlEY8iz7givGJDcXEF52HNvxaY7qcWOka28uWL/wEUnRmQFdpV
 LKQEFxCaWSUxabKsxrpjRO3M4kWplaiKHvn481nER75YWRbjUs/4gbvcPchSBM7yXHdA
 vr/IsRIf71AfoZaQ4ap/RbfD5jseqGn5s/0Ci4emrUoRKiMhS7HMNMiwuPrlaKFj/Td8
 okQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575113; x=1793179913;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UpT7/91vqpjjfqNMPyfHz6KbdmwUqOF35Ml4si+XyfM=;
 b=TwEFzKHPomMsAACZubL9FBZ10YKABfJRcpkGIW0YHS/fShxXgldHT1XVoHpERH4Q5u
 R9wmhYKRWhoypvQ0xETgwAThjJxWN0vzHF+bGh6uOo9A5/cMhBb79fu1Dsed50hLKa1x
 RaxegBlg/ZEOrGaxEEh/M1+zU7xvDCAETMMoKn0xLfOZC0oNo514pVS0mpu6I/CocGNn
 A1o1QdSd2v2+ThC2v1J9IIicccGRkbqSBHBJosNX74UF4nAUSzTTIFyKeCEPlhTZ1Aym
 cvgYkgIsidgCOqcf+NskfJjYXflI+jWy0ZTEhWR3kWODJ30juL89UCk01dNU3n4lqfNN
 uOgg==
X-Gm-Message-State: AFq9FYLGSIfwPRToER+0gjwCRgf1k011oDeAIWOy1bfGP6/ZR8H/NnCr
 cFD1YJ3PlqEZ+2aEY0j+UrjWePXeuGdepp17mXeIQR3E5SqHLxdlHqB7qlP9ebdQcH0=
X-Gm-Gg: AYBFou0FETPUBH8AXMJmcKzpi5yIsZc2O2twBY2OWW8vde4FcbVB/FT1zAhXp1LLXD5
 loWi5B+ccUDokqhTQjGhDi9iH8UbFwVdN6gL5bctnayzedZiSG35E/QBdIme3pIT8QSPAH2Wh1C
 FA01xcINFtv79XJsOsZk7HAT4dw/kDGYLUiqmN83cf+jdAuE8GPhpJ/9Rxu3I95v4qbz7XAvG7y
 2RTsIsZFEubzpRpRqM1ZoTTVXsat3adIbHXHXpv2eLstiORR7aSZ6HIJ3H8bx2wsya1HAoMvYcc
 McF525Z+dCAs3SkAj04xhdGdw6geOd64AGxIzXHBJcJn6R+btSOgWDFltLolZpXdVZrf892ozIE
 Vom/qAPwvT28xo415c+zDuPKcsHVTwkj0iybMj1ya01TwhDHbTwrfrGhSmRd91WBCEP3FH7nJyD
 6m8XKQHIwwy9mC72znkQbuMfcmciyiEFbNDIiOsn3CzQuys/fBfgPS0RZDzmKuu3AQPGcEz71XP
 SeVF4ET3+USx3dI7qaOf3r3lOzn+YEIhrMMH8D6Qv+a949x+wvgplU3ZNWbfIWEtd+iKC53dowl
 OuxXyNETk9k552oVyWSC3TTQCq/5W0nRk+qrTq9nkbYr828nfOZPmmkxucY=
X-Received: by 2002:a05:6000:1ac5:b0:48e:791:1cb with SMTP id
 ffacd0b85a97d-48e264cc332mr2962409f8f.35.1792575113389; 
 Wed, 21 Oct 2026 02:31:53 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25840115sm4208621f8f.48.2026.10.21.02.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 02:31:52 -0700 (PDT)
Message-ID: <AtUuaJpLQ5fehj5aJ3y4dJHs3nd7boLw8jhr@localhost.localdomain>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20261019132621.3943362-1-wakel@google.com>
Date: Wed, 21 Oct 2026 09:31:52 +0000
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] swapon04: Report TCONF when SELinux denies
 loop device I/O
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

unfortunately I don't see other options available but skipping the test
"guessing" that SELinux enforcement is producing an EIO error.

But did you check if other tests are having the same issue?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
