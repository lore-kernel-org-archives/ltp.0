Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86BBCC5AC7A
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 11:04:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE2EB3E6FFC
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 13:04:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 920FA3C713B
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 13:04:16 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0031D1400E51
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 13:04:15 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2ceb5a39c48so11715275ad.1
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 04:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786100654; x=1786705454; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C3TLH4k0/zOPHdX6RqzqB6Dvy5GMIcIX7+Cmx4sKrrw=;
 b=JjlP48iLWH0rcBpv3TDIB7X8iGlBydV4NP6MrhzKLrPOAAX/xUcWwQKTmt7RW8zerX
 QQs9ILUPCKVF79Whm3LciAcjV6QfG9xc9Ettfo0oVx0a8LvLYGeK02Swk7TeaTDCJG5d
 D6IgLyxX3HxAqJf8ZwSSF1qNeiwPfvBtl7AEsJtaOypb+M+h64ka7Lk2gQMzuIY+EymH
 cBU9FAYnvoa5S/GBfaGbDtmjKd7klk3++K0iR4QvKxSFAweakb3nrFAhDX7/sFj/AeSU
 bDnZS7uWtdFbOyxbxY9ms5PNfTnJuBeKYYzN3QUZt+M9t/vdm8imhctkKSevKTixfmOm
 JWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786100654; x=1786705454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C3TLH4k0/zOPHdX6RqzqB6Dvy5GMIcIX7+Cmx4sKrrw=;
 b=ZLBMLGBBIlKGNLmYRO2wb4MMHwzgM6JoeVmQG4kxaayELDE1lSdLHhTf6kc9eQ8vY3
 uTsu8Lmpv8zvIiKKbMAfDLrK8mSavyIj/Wr91rLKf4uNYBo/mRlhbmeO2IxubqOMQrYM
 JMNZEDN+ivVY17rWh9Me3XQNnukWgpz6ToQ93GUmZpO4arhwJwc73MLR26MtYyRQfJEy
 uBDYacfWhFPk1TJH5YpFbSQHlZztc6yhYi5vHq+qf3yZqjbxaJPHVUdHB7RZZYD/qfnC
 t/M9x1P5IUIXKJM+LVzbSG6QXqH9/PePc/QO5L50WABGjff/G2qOjcOsEsGvZFGpmRdp
 BZpg==
X-Gm-Message-State: AOJu0Yx5OglmGPRgjdUPdBj7ySG3hN1knU3Tp1H2PcgueXl6R6MCsJ3v
 VmSx5b+vCzA38eetF4cl1GQBsFG89nFwkrHSduut2vsf0Cp208KT1zKd
X-Gm-Gg: AR+sD10hV6TrfM3Cd+eImBrglKl4Xp59W0B/mUxATRAg1DMlzjS5j99H8wSUP5eEWM3
 F+K+iSx8lC23p+jcSngslSccyBlPY160Hw14nqAgOzc08BaJLlXBAjiIxaJMmdgJH1MLxWIwhrB
 L6SfLDA3R6+L4SjQxYyiJz2nhEI+rP2+nDN4n475B0b9rYH6d26V7quvtFkNksijwce7TTlcBqc
 f0RyB7fdaHhrTip8g64bhNkiNQ+PkL1yB+nQgLYq33SQh1vdhNxCiErv580ogRCJuUncUCpqDAP
 ge+YoLAaXDlUXGeYh9Y3tfYX/l7hofKfQ4b84LwUnDoUz4iex+l56QpIkxoDiElSF9WVs+ElAnB
 OuJDW7RIXpu02iopUTgf/3H3x34F8VIg9yhY7tsjYP6jYpoldDYupNLfrSEh8SmvQM/ZotOG8Bs
 ZSEn75sj7drBHnNla4HfWnzj3xhwP8cl4G864q9lKQhI+TX0uzdRrRoevAnNeYTp+8Ln8FTZGPI
 xDes1h3EREkmNeP6yyPWWqdXpfYtMqF2NAYvTEzBOV8FGnnLXb7aQ1GM+oMXVaeI3tVSpE3OalF
 GpytEe6LKj6g
X-Received: by 2002:a05:6a20:d12e:b0:3b4:71c1:ab29 with SMTP id
 adf61e73a8af0-3cb85e3e76cmr27545213637.16.1786100654332; 
 Fri, 07 Aug 2026 04:04:14 -0700 (PDT)
Received: from
 runnervmvrwv9.5yvi33z0yeoehpnbutyr4hiofa.dx.internal.cloudapp.net
 ([52.159.139.248]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141019a0528sm6236162c88.1.2026.08.07.04.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 04:04:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri,  7 Aug 2026 11:04:12 +0000
Message-ID: <20260807110412.3995-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260807105634.2837348-1-wakel@google.com>
References: <20260807105634.2837348-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] inode01: Use uint64_t to prevent inode truncation on
 32-bit
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

On Fri, 07 Aug 2026, Wake Liu wrote:
> inode01: Use uint64_t to prevent inode truncation on 32-bit

> struct inode_info {
> -	ino_t ino;
> +	uint64_t ino;
> 	char path[PATH_MAX];
> };
>
> static void record_inode(struct inode_info *inodes, unsigned int idx,
> 			 const char *path, ino_t ino)

Could the record_inode() parameter also be changed to uint64_t? Every inode
collected by verify_tree() passes through this parameter, so on the 32-bit
ABI described in the commit message the value is still truncated before it
is assigned to the new uint64_t field.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
