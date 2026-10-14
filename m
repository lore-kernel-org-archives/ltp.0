Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612E9CC6B1D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 11:23:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65F383E9E3D
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 13:23:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF81D3E6C83
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:22:45 +0200 (CEST)
Received: from mail-dl2-x07.google.com (mail-dl2-x07.google.com
 [IPv6:2607:f8b0:4864:38::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 262611400DE9
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 13:22:45 +0200 (CEST)
Received: by mail-dl2-x07.google.com with SMTP id
 a92af1059eb24-14345ae29c5so120319c88.1
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791976963; x=1792581763; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K6jbaZiePO/1fRF8ijJg2tskqCeB/VQx+Jrq3X8qkHY=;
 b=NNFNQzCEdziPQ11LuG81MECUO0Ms9EatAi8m4dI9r+5bOqjuB123LuyJh+EbCPD6du
 UfBdkMgXF0iNvhqKoHL2LJhWjflmUj4rTxQGETEMoVl5ATVJbt6qvi0e8/WQKFYouMwe
 6GUUaPnF5vaL9bBFaeLASQUsk2U7cllHKhL4JDwJ+7yNB1H0yTKUFAh5ttoGJHjv2hoW
 tzYlgl+UROGU/aOvuPeOaJd4IX51sFhNy6EKtDwz1jOiv8t1ik48RhQEdF6yZpxVu6hF
 hQ1qxl0yjq6QwIyg+itVegESdisVqzBCCMxFRIyIuc5bLBNXnEcWdpfKDp/vPo1FqvMO
 +lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791976963; x=1792581763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K6jbaZiePO/1fRF8ijJg2tskqCeB/VQx+Jrq3X8qkHY=;
 b=IHmve9unXr7ft+zu/0u1vW0c0MfXorU5s7h6wAp/pRX1u6PCpHeAcwdNvWjty6Jgkw
 EIZRLNIu+KAyJB3QRfOo509+FrFzTGawYzW7z7f8FNO1XFLWH++a126ventCLXh3TBfe
 iWXWMgA7EchBETIZUR9QnnjeIDnWPZb6j6sZ4Rjrojxd6D6RsfXomJIGb0AGWbrJXF7P
 UliJrDTHHPGY/vUIBkI3PRJh2QqlxrEJ7q8CSIntoTkxm0KDGYTvInhbHP3jrUcxoXxm
 GxOauYhc55j9Ydop09mXLfX/TbD1eYwX72tghJkVlKOqw2FgB9a+tZa9Ip+ErOsgdMJK
 +d3Q==
X-Gm-Message-State: AFq9FYJoBxuKziRupUhoPnQnTYq3KDn82+lHpB9thDYlipqCPFxH2xLZ
 ZgX51MJyafpFHG50fagLVcVrRnmk++w39MhWz82xPQ41or+FGxg/ikI2
X-Gm-Gg: AYBFou22s4kNUStoaAJmmPIN9ZUTFH+u+G47uXq2bSzZgjhIX9ii/cQ3wBri9KwpXjY
 1e1tBGV32+BJ4PvVeH52BBs6e8oEFdDHZLrAHGHxpB5jcUOYi1DPQLAC5AKogTBu2KdQKD6k3nz
 1w8zhK1wHQLYMVw+CuBBTzzR6KWsmNTYNCkO+YMIxhcgm0zYTx3FckxjzpXp2i0HGmk7Fki1x1c
 p3stKA5I6dQ/EH8RF2wl3POMGyWMqcWoSA792ZtCKM2/lNQhszfEI2lnrQyKT/1+3dkVQl9m6YY
 CsYP728Hi9GO3eFNHoy2ECTl57kKJmYCCY8vCeoSSdnWKLaC4kd9QKylFBEDk0gE+kjOdEkx+dn
 q3teCLzuSVi5VE64FDrTgzPIoe7OErT29X15khhHtF9kHk+3gYSSHnVUwKMWAB6P+uGSeJVLCb3
 FzUnr4Qf8iYa8drj9V7NZ28G2cygKlAmteRnM5PXWtjspWVHsJSx2KFR+H2rCmjPVc4dbtmW1NT
 opLy7Rr0o+tbNitDCcH/nfBQDrVAxL0jk0O4Nyp6iuNHLnC2LalYVAZYJHhG9sAApsGaUWLpGXF
 CtcXX1s9WAy4e2tnReXKSg==
X-Received: by 2002:a05:7022:296:10b0:153:4a27:4ea5 with SMTP id
 a92af1059eb24-16a600667a0mr19720023c88.28.1791976963153; 
 Wed, 14 Oct 2026 04:22:43 -0700 (PDT)
Received: from
 runnervmmprz5.wq2q5grpnnbu3kw3y55qhe3g0e.phxx.internal.cloudapp.net
 ([4.242.197.38]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm49656637c88.0.2026.10.14.04.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:22:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Ramesh Chhetri <rameshch@linux.ibm.com>
Date: Wed, 14 Oct 2026 11:22:41 +0000
Message-ID: <20261014112241.9233-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014075616.5050-1-rameshch@linux.ibm.com>
References: <20261014075616.5050-1-rameshch@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/connect02: Handle IPV6_ADDRFORM removal and
 listen() EINVAL
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

Hi Ramesh,

On Wed, 14 Oct 2026 09:56:16 +0200, Ramesh Chhetri wrote:
> syscalls/connect02: Handle IPV6_ADDRFORM removal and listen() EINVAL

> @@ -91,6 +91,14 @@ static void run(void)
> +			if (TST_ERR == ENOPROTOOPT || TST_ERR == EOPNOTSUPP) {
> +				tst_brk(TCONF | TTERRNO,
> +					"IPV6_ADDRFORM is removed/unsupported by this kernel");

High: A kernel containing b6f6118901d1 without 82c9ae440857 returns
ENOPROTOOPT here because its TCP branch leaves retv at -ENOPROTOOPT.
This turns the existing regression check's TFAIL into TCONF.
Distinguish removal, for example with getsockopt(IPV6_ADDRFORM) on fd
before closing it, and retain TFAIL when the option still exists.

> @@ -104,7 +112,15 @@ static void run(void)
> +			if (TST_ERR == EINVAL) {
> +				SAFE_CLOSE(fd);
> +				SAFE_CLOSE(confd1);
> +				continue;
> +			}

Medium: When 8cc3aef0cb19 rejects this transition, all 1000 iterations take
this branch and the function reports TPASS without reaching the second
connect()/accept() that exercises CVE-2018-9568.
Report TCONF when the transition is unavailable instead of silently
continuing to a pass.

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
