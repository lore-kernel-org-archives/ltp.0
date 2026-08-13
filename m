Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F545C5B572
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 20:44:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 347653C6F2C
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 22:44:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72C503C579E
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 22:44:31 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3D25140096D
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 22:44:30 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 d9443c01a7336-2cf02ecb572so5083685ad.1
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786653869; x=1787258669; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YmcdJpPrRLw5mQWI2cFEAE5twJOt4MI2r6ZrM6xOC0Q=;
 b=j9D43GZhYaVS2v1rdkdnV+gd0HOH58A6wdK21je3K+/lMSdaZXMkfyEUmMRL4/gss0
 AQEdnX54XL3vFZE04k9yJ2J7vppi/dxmB3egigNkIGdU3+tGtOLA2ZwKFYmr9AKVBDaW
 BP4p4b1zA7Wm8SZxQ6DPqjepJTeMuzCe1IVA6O7vd/HI1dYme4ilv2Tnd43rHR/A99fI
 930va+K7lgCzIZwdJTVhDuGm2ToLwNo1T39f4KAyjHHV31IsQZ3h51PVNxzpkKFCudgF
 ucYB15KptYayPPNSzSVvvabwEYljtCeooQV2/rHX30mSt3M1RgrN1eLYIgItbVLtLuPW
 ZPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786653869; x=1787258669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YmcdJpPrRLw5mQWI2cFEAE5twJOt4MI2r6ZrM6xOC0Q=;
 b=Cy657n3tt/29okGajIUpJOiRd4XcVwv8lSsuCC4y33X/Szzveu6Zvk6ltImWd0Dc05
 neMmcyyivcjKAeN5yEIvI4LldE2P9ZeTaqcwnshhTYTndRL8mrwXgGd7RwClPMgEoe2y
 V4YaJgrtnoic0ekwG+AW0x2IOnedHe8KeT5/PFbO/S6Pxsdlh/y7PaLastV5DseE0Zdt
 lDnuuxtunEZCVaA6cBbzNABCvYIXKJPd+/iBk8YrSlYiXMwQ+CyysuTzNJJVbM2Bt0/N
 hd+iTP70Fc++7IzoGjGrBUH+VD3xAnF8fe//xPrUdP+LQZifbNgvtsF1Y+ZlX38NNX02
 8gFQ==
X-Gm-Message-State: AOJu0YyPKWiV+y01kRKOcRkIaLGiqeo/9NOlhlR9k+8ztQpRtzq5wKhU
 RJ4y2QdPbRG6NtWExzM1wI1akYeILZNdQccVxcUDy2+9IT4nGQtCZYz6
X-Gm-Gg: AR+sD11aUs6zhbvyJtRYKBGUOukuH36a5G+oAexBLCx0pjSRc/hxOntVpUEjlHbdwLd
 wo2vBEG26k0he4Gv7SEiXCWaDFXhhI5dwO3jWxSMFmPGvKnJ5uQnRSV3D0Z5UzUMzFr63lGB1WA
 rurbxSM1OO9179xbT3OwnfUrCC+cLLIeVaPDNhKXXMZB2pAskZ9v1ZJ6iKHTP7PV7wxneKwR2AI
 uRoVlaEx2m/9QyWLhLzixrN+0iUbKvHGDHfhjYCmwedXygt9GWQQ95fOPftM/zK8OzDTdrYzl7D
 aKDKfDW2nvxaSgxTwYhCJAKcFKM9kF0eQJ+pEjFrQIBBBz9sLCNRzNxvloRWwADqXes0091OkKK
 bn0wwdsL4Lz2RpnBvJZk7HofJBrA5bGeOeYdjMLFbjh6oskYKQg+35u7mNae1z/zahigXoGjQKx
 Q4LBM5GSPTQdkz3xvybpEFiPvrgikDeadcN+a4yYyw0X9q74lRoxkpFliRuAHFOoKsxOqEeKaf5
 WlC4Q04jhuJdsCQPfax9ADku6juzzNFln6fs+44FeTxC6/Lc5vtpKPEI0tMZ8aOiaGNTUuL8OoX
X-Received: by 2002:a05:6a21:3295:b0:3cc:6d6e:288b with SMTP id
 adf61e73a8af0-3cc71d1e826mr475474637.23.1786653869088; 
 Thu, 13 Aug 2026 13:44:29 -0700 (PDT)
Received: from
 runnervmzvulz.uatqm141rrqebhdmasass55mng.phxx.internal.cloudapp.net
 ([57.154.3.147]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31ebc75d8casm12268179eec.3.2026.08.13.13.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 13:44:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Thu, 13 Aug 2026 20:44:27 +0000
Message-ID: <20260813204427.8855-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813192649.192136-1-avinesh.kumar@suse.com>
References: <20260813192649.192136-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: rename11: Convert test to new API
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

Hi Avinesh,

On Thu, Aug 13, 2026, Avinesh Kumar wrote:
> syscalls: rename11: Convert test to new API

> syscalls: rename11: Convert test to new API
>
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>

Could the commit message include a sentence explaining why this conversion is
needed? This changes lifecycle, device handling, result reporting, and cleanup
semantics, so it is not a trivial change for which the subject alone explains
the motivation.

> +/*\
> + * Verify that :manpage:`rename(2)` fails with:
> + *
> + * - ``ELOOP`` when too many symbolic links are encountered while resolving
> + *   oldpath or newpath.
> + * - ``EROFS`` when the file is on a read-only file system.
> + * - ``EMLINK`` when oldpath is a directory and the link count of the parent
> + *   directory of newpath would exceed ``LINK_MAX``.
> + */

Could the description state that root is required to mount and remount the
test filesystem for the EROFS case? Tests setting ``.needs_root`` must
document why those privileges are needed.

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
