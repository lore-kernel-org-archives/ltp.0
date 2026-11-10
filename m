Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D521E606A7DA
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIpnr3Ru
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E3723EA18A
	for <ltp@archiver.kernel.org>; Tue, 10 Nov 2026 14:06:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6D8F3E1B79
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 14:05:44 +0100 (CET)
Received: from mail-oa2-x00.google.com (mail-oa2-x00.google.com
 [IPv6:2607:f8b0:4864:30::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 34D1660018D
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 14:05:44 +0100 (CET)
Received: by mail-oa2-x00.google.com with SMTP id
 586e51a60fabf-4a86da07919so898219fac.0
 for <ltp@lists.linux.it>; Tue, 10 Nov 2026 05:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794315942; x=1794920742; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gY4UJ0gn0pXtOMywYoU0if+oYafZBT17FhZr/zzSCXE=;
 b=pIpnr3RuxyR987Br5wOAPQseK0dWAVoRZPSg98sFXI2CKX2HY6/P65XilSTomHPdjX
 pgZ+upeWZcTxh8TBzH4vTcDMaqhPpV3qvTEWZeo7CT7BYImQ03rWGu4AnSzkXnq6sQLy
 RUxlpsgGA62AHpPLYCV8eo7nAtK0YJ8qOSZ1dv0jrXQpqEsINnVnjyIDx+4f/XXP92zp
 HU2bOOQpj/BkqDY8dl/jAz+/t5+1zyCxtm0UU0kp0mjAS/il2I73ZMg3zrMOOAOssesY
 2LwJI2ZeAw8dxCM4RWh7HSd/bu/R/YcgaqWAjSLi31PBwR17eC/KILNoAIC0c6D1O4iH
 FOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315942; x=1794920742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gY4UJ0gn0pXtOMywYoU0if+oYafZBT17FhZr/zzSCXE=;
 b=tUjFfMp6F4F+foMYQ2w531NtZ/BNtFCqn/7aROgIzePZP0KB8YQRA4rzElBm3hFSXS
 VKLwbdpJDgGZpIaZVC6Kj16+3ekFbmljZTAUuONmDupk6efMALJYv9Uv+c+4cDstfZ9M
 CWcz7GVX90d6dHDRP6NboQqhvPp1KSmkmBbkNuVH3W4v1TxeX8EiUCTr6iqgumroZBvV
 Yieyf6ZjN/A4kB7QMEa/53lgkVXjjBKZU6rbzxhtw41a6nzny6hFj16NSueW240zRZcT
 W9PSLQODnHprZc4QycTzMVBuQ4jPAm06qen8qtf0e9qQ2nSxujFQAsrww9SGOZz/u+IK
 J3LQ==
X-Gm-Message-State: APuU4Z8NEZK7sTYXdYJm9XXTxTu5ZvGcIFaYpDdtNOsPwNO3UhUKXyve
 E6tFVcdM1d5K7fyDW1SQuOFN2iMAGn5S+ClgPAXwGwl4la4u/VWngm3M
X-Gm-Gg: AYBFou1rj5+oOIdnAs74yithXdXfPAyLye3KFSXH9tSvtk/+7aYPxk90mab5T7Jy/d5
 0LT6vcyvUSVApfSO7aQg2UY+MFLXAiGoFwR/OPOlG3IhJOooC5shxMt1JRuURN4T2REzp4Ru8Po
 Mlo7I9B7NmLinIZk7jclJGeuu/aLF1s/3dwnOGDcftQ0DazF4IgpXY0dLfGtwx/b8Mnr4a7K6go
 mJ6a3eMwgug3SKqhqgr68UXoDYs9Hk5FhyyO4gubXEpHELytScKgUNGY8+B7mMzLcRb6D5GtbIf
 uuQmpp/LQMKS32EKM+cRdlDdSYl7niv5NEgR7OWhck1JE7CK0FfTKGi2vlKiUW2kWFFCbXM57Se
 nW/R6pPHgFqtq4CoP/nmix1VBU9cvlmUCofPd2EKsLxmTRpxSVr/NB8jco3PgkMweCEL0EwNZVS
 jVqWnDkrk4nWHZ8TPBPAtBO7RDn868KMphD0V2pFbYd1H+1VKG8GgYwypgnFZoTRxve2eebte66
 WgLbdckWWf3G8sg6q5CiEMGTXI2YKHKPdHQfnOyQ6yFWMkAxRRv3/PwE5auVL+zJR4172kl9xeq
 qI1PKSqX72FqW5gN5N7Q2czy2aA1wuNo7ZLZYofSyyvxe8sC9CMckNKvbTfLhxBEWV74eMLIn+J
 r3pcqAPF9MwU3ckpkU0VWrC+q+rO3Gv+0Y7/XTTE=
X-Received: by 2002:a05:6809:11c:10b0:56a:dc07:f222 with SMTP id
 5614622812f47-56adc080617mr321347b6e.4.1794315942380; 
 Tue, 10 Nov 2026 05:05:42 -0800 (PST)
Received: from
 runnervmwuk1x.3jql0x250rbu1ccdxgzqpxunja.gx.internal.cloudapp.net
 ([172.171.7.1]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-56905735edasm2022053b6e.7.2026.11.10.05.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:05:41 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Tue, 10 Nov 2026 13:05:40 +0000
Message-ID: <20261110130540.4085-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110112100.1594353-1-wakel@google.com>
References: <20261110112100.1594353-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tse_swap: Fill swapfile with zeroes on exFAT
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

On Tue Nov 10, 2026, Wake Liu wrote:
> tse_swap: Fill swapfile with zeroes on exFAT

> -	/* Fill the file if needed (specific to old xfs filesystems) */
> -	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
> +	/*
> +	 * Fill the file if needed: swapon() rejects preallocated but
> +	 * unwritten blocks on old XFS and on exFAT.
> +	 */
> +	fs_type = tst_fs_type(swapfile);
> +	if (fs_type == TST_XFS_MAGIC || fs_type == TST_EXFAT_MAGIC) {
>  		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
>  			tst_brk_(file, lineno, TBROK, "Failed to fill swapfile");
>  	}

The swapon() failure on fallocate()-preallocated exFAT swapfiles in v7.2 is a
kernel regression that was fixed in v7.4 by kernel commit 4483ab85d1e0
("exfat: map allocated extents for swap activation"), which suppresses
IOMAP_REPORT during swap activation so preallocated blocks beyond valid_size
are mapped as IOMAP_UNWRITTEN instead of IOMAP_HOLE. Filling the swapfile with
zeroes on exFAT works around this kernel bug in LTP and masks the failure on
kernels missing that fix, so this change should be dropped.

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
