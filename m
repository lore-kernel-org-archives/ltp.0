Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3497BFF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777454547; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=TC4jhmy63hs9DYUqYNa0tLKhEqK47RFI3Px3OTqvszo=;
 b=hfxWSA0l8PoEg8HgyN1IHz9zxrt6PgDdFpw+Vt83ODvktvhatpds2EYLShGN5lMx7fa42
 IA2H2TqQqCySbbFkbGcL0AfcPwqU4IebpA5SOyzJpSO15plE7OqvBs58cd/pVvg6Iqt8j20
 q5byiunpzITCbcQa/+xyd60wiobW+Bs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAA3F3E49C5
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 11:22:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75FEE3CBDC7
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 11:22:06 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5ED7A600385
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 11:22:05 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso137929905e9.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 02:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777454525; x=1778059325; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=LynzBGwRwyd4NloHZXO91PN8g/ufkVyvJKm0O48aVAo=;
 b=FAAgdk4luqSaU/lzE9i/uYYl4bq7Hx4XL+D3P7ILWfLCGnACHZMI3bVSm56asldxdr
 oGcp0t1SpFHk6WF0q356sqxjMW7fY3piYJXJo16U9yIsbHrB+/5vSEOg4eyW4reYWXC+
 1gGbb14PtTN+qgxPOArAKuM0hRuuKFIdU5Wkg8Nu+Cr3cpWQURfHILRFSSX27MJyM1pO
 WrreRR/I1SP4HD62/SBmwdJHdtvMqm0QIy60EAB742/ND0FXjQM9cMUBWgPavyMQUkii
 U8vDAtN0QyWn9Bi6wc0FHJirRNEtApOhHHvRZ9fQqbVxCGX8P1whxebbhd9xvf6JtwJk
 DdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777454525; x=1778059325;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LynzBGwRwyd4NloHZXO91PN8g/ufkVyvJKm0O48aVAo=;
 b=jOJ7FihunvZixjL9J2dm7tHulmFByu7Y5Yla8sHfiktVRj2Jnlr7C1H/m6qPcP4fi/
 pdHJiZUizma6mv/Tu7VQC3QVgPUekMpPPiHdgyWUz3JMYU4VxKRfhYU8s92MjeOxPJRB
 ON7OBJAtTXB3rhcwebu8S+L8naDZvo/BbLxJI7Qyg7VFjDyB2C5ck1f8uQsv/iLXXSGf
 sgJTiu0JJ0bbniRsgAaGeM5kT9TNb+B6rMWNx+RYEM9HWu6lJ7KkEPGZQcX4XUKR8TxK
 moN95KiGNTJR3I1oyGPDb8Ly1rQC8cs/lLLRmqvB+DN0gTFuaa/Uv3kArXNMc/HovSky
 xERw==
X-Gm-Message-State: AOJu0Yw1TgKT+hTtSBWcK9nzse3UN4CS/z/KQRXu4YaFu/GooOZaZKKp
 igJ1COnQKzz+KsUnlajX9b9Nlfbj23Nxl5ZTyeBjBje+1QbDVpSzyroPjZoJidOhK4A=
X-Gm-Gg: AeBDietjxYDg7y7Fwmd0jCq5+iHDHetAOVNAT0nL6TbeprvEruKoEXBvTz31lkd2g7d
 Lbrpcowmx1GObLtpMds7s12O3s4QNTHECdeu1h/d1J2R80Tv0BAvhzZdwxGII7Y4uaf+7hbUI4s
 SPsyBerrsW7ZezTB2CaAbw97r3i8A7XcAAezMdNiVNy8uazvWVzm2ZfpAJLdhMOBpSH87BBWTtb
 eTQQOSk2V86y5UTUiPX7STm9+IFMMExUAbUiR6WhqhsaEfVDAzFRtohle2Ro711JnnS1h9cYcsU
 O8vXn0ECae/B5CGaLKZTbGo7RCGMJ8Wz5VCty7nsEphfCDEeJmwuWJxS13uhni6lLYmlygKyIPo
 efYNUDx7MQOAx82SRwiaL6Zif4DY7ys63r6MWOc9GtxrJJokyfrY9bH2fxzQvWi8zIVP2VtcIZZ
 b0Qv9Z3/GlPgtUSN5MM3BceMPbhK/0+7uikX9a+koMBFeJWUgfLDcasNUtoVfodz/ibdMN4RFi1
 IujiPd5TLQOeBqWEwlSyFlfVjBFetksOMmadbYwphNTVrwKIequ9NqCFHu/H+JoD6Eu7m2uVBvs
 OOkuyvdkxKwYQWqC4z7tQIA=
X-Received: by 2002:a05:600c:c16a:b0:488:a639:b772 with SMTP id
 5b1f17b1804b1-48a7b5193c3mr52778485e9.7.1777454524506; 
 Wed, 29 Apr 2026 02:22:04 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c31f1ddsm13783895e9.29.2026.04.29.02.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 02:22:04 -0700 (PDT)
Message-ID: <69f1cdbc.050a0220.29173d.95d4@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <CAOcRiAEh+CFKBeaT+beQzhX_TRNiau4zP0iCuRFsahPkw7WhxA@mail.gmail.com>
Date: Wed, 29 Apr 2026 09:22:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/userfaultfd: Handle ENOSYS in
 SAFE_USERFAULTFD
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
Cc: camann@suse.com, rbranco@suse.com, Wake Liu via ltp <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> I encountered this issue during Android GKI (Generic Kernel Image) and
> VTS (Vendor Test Suite) testing on various device targets (e.g., Pixel
> 6, virtual devices). In our testing environment, we run the same test
> suite against a wide variety of kernel versions and configurations.
> 
> Specifically, on some kernels where CONFIG_USERFAULTFD is disabled,
> the userfaultfd() syscall returns ENOSYS. While you mentioned
> tst_syscall() handles it, in the version/configuration we are using,
> tst_syscall() returns -1 and sets errno to ENOSYS. This is then passed
> to safe_userfaultfd(), which currently only checks for EPERM to skip
> (TCONF) and falls back to TBROK for any other error, including ENOSYS.

I'm a bit puzzled because according to the tst_syscall() implementation
this should not happen. If syscall returns -1 with errno == ENOSYS,
the tst_syscall() implementation will always TCONF. This is visible
in include/lapi/syscalls.h generated by the build system before
compiling.

Please provide the exact test that is failing, as well as the logs
you have seen having this issue.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
