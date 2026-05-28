Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46164CD5BD5
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 16:03:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7340B3D01D0
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 18:03:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 911553C573B
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:03:18 +0200 (CEST)
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96255200777
 for <ltp@lists.linux.it>; Thu, 28 May 2026 18:03:16 +0200 (CEST)
Received: by mail-oo1-xc44.google.com with SMTP id
 006d021491bc7-69d42abd04dso3850658eaf.1
 for <ltp@lists.linux.it>; Thu, 28 May 2026 09:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779984195; x=1780588995; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5mu7EuHVMVnY91+9OHBimTHelQUb02SorR0oBGYCDk=;
 b=SYBdl6tmll+YnoVjbMo9lN5gRGUOuv5lt8s/F3mA9Hc/JNoZreX0BITl+jcn4MTv9P
 KdZgASMPOm3zkiowEY4y/5QblIBfFzluHKPcLtjVlE7kx7c+8k3Qd4F0ZUr6t3fFKbIb
 FluhlnZItaJ+ZEV2g9Ht2UnQa7jCWBlShkRUCsmHG0k5WAlp3IfyLLqLbczmTDq6MjBi
 8ObXLoxAf3zcmysYxN5o5avDrX7D0SwfflEOUUpy0fJLP8AyeWUvIBzjn9N0nbKVOOFF
 qUtBXLO3N19GOm5NxZFtA1fD+DcCKsxVtDLSBhzCt2B217UY8TdgTTOq5oQd3xNPQNlX
 prBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779984195; x=1780588995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w5mu7EuHVMVnY91+9OHBimTHelQUb02SorR0oBGYCDk=;
 b=LLnWXrvTqNNCnBiri/HAwNIS613KqMT+C6b/WmjUPri18K60XRI6NnVpAPh2CKJdZC
 iOCdc2qXUBNrswP8IfHNQzgV+UpIPu3mpH4Wm3QiSJ7052L7lspuranZe/3D0bvoMSC5
 CTxF9cXF2ks7po3JMMK+pA96shgGlr4JR+YwvV8ptAuKZBUT4mM+FiGTlbfAnCLQqGLL
 40Y6nDTlkXQvSGqZn40RAMAwQj3m3WoyEYR02yDoQARfFnDiF98nTn+4jf37+k8ZpZyt
 U1O4kI8OOqkPmMGkUqTB7kJTtq9cSzgNUlSzfL7fFDk1mCUtatu5PGF+q892V4QALJ0w
 si1w==
X-Gm-Message-State: AOJu0YwnKyzFfukjyeceg/1LYANYi2pe2S4jSRvmQKIcizJb2zMFCOUy
 RIR6wPKm+9NX38EcJB7ZIMHhOtKfwdo2RYI+PzeMyq7npXp+JfbBcZLM
X-Gm-Gg: Acq92OES3+lVZ6z0iP8csm8gr54WgIqal/f1cGvrOxum4rftTbIEIPa0KgFdiKRfFF8
 9nSEulC2CvTZSts1nJ9XKM1/TO2xV7n0+WSz9UQz8cKy8c8XBTtw92D1J8cVu+XnUKI3MCMAh56
 lZojmAIPB/WcxQvl/YfDjEvpisN0OYf3gv6EAXndr1x1gQ/69bpDkHg1+Zy/s6HepyxNr7P72Vg
 UfI7+6a4mP5CX2CymdNSeQ9Sv5mRwtEW5YkllFpPmNk8e+iASWFSo8V5g804YWpA92/5qpR8qfu
 kiH4qdPgeztDg6SARibIyCa9Wf7D9oN1SGcyCb6pbkwpGK3mNQOi1K9utqPToqzNl1imozhtbst
 fS7O5O3RVrhndJgj4QRDva8sxGAM1OwGe4/WVubilOeJa7Zzzypa3DUPmn1kvvQeG2FM6ufVm+g
 ZozwK+COR5ahU0bMBgPYtQDgFB+BAOuxKYnHGM07EI3bEgGCKZs6B3ceXBRJRMo+/TNS6Pdozqk
 ZUJeTC2pFpZ3h2ymEeD1b7izLAkgBAZABSRwNHx1t7Vh5NGTTo=
X-Received: by 2002:a05:6820:1612:b0:696:70f0:7acf with SMTP id
 006d021491bc7-69d7eb32e55mr14152779eaf.1.1779984195164; 
 Thu, 28 May 2026 09:03:15 -0700 (PDT)
Received: from
 runnervm3jyl0.cy45ohermm3eteg1zablurejac.ex.internal.cloudapp.net
 ([20.125.176.183]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f8713144sm836647585a.21.2026.05.28.09.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:03:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 May 2026 16:03:12 +0000
Message-ID: <20260528160312.3688-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528151938.909301-1-amir73il@gmail.com>
References: <20260528151938.909301-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify13: fix test failure when running iterations
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

Hi Amir,

On Thu, 28 May 2026 17:19:37 +0200, Amir Goldstein wrote:
> fanotify13: fix test failure when running iterations

> The test case for FAN_SELETE_SELF deletes the objects created in

Typo: "FAN_SELETE_SELF" should be "FAN_DELETE_SELF".

> +#define TST_VARINAT_OVL_LOWER (tst_variant & 1)

Typo in macro name: "VARINAT" should be "VARIANT" -> TST_VARIANT_OVL_LOWER.
It is used consistently with the typo throughout, but it should be fixed.

> +	if (TST_VARINAT_OVL_LOWER) {
> +		rename_exchange_unsupported = renameat2(AT_FDCWD, FILE_PATH_ONE,
> +							AT_FDCWD, FILE_PATH_TWO,
> +							RENAME_EXCHANGE);
> +		if (rename_exchange_unsupported) {
> +			tst_res(TCONF, "RENAME_EXCHANGE not supported on %s",
> +				tst_device->fs_type);
> +		}
> +	}

The return value of renameat2(2) is -1 on any error, not only when
RENAME_EXCHANGE is unsupported. Storing the raw return value means any
transient failure (EIO, ENOMEM, ...) silently sets rename_exchange_unsupported
and causes all FAN_DELETE_SELF variants to TCONF, masking a real problem.
Check errno for EOPNOTSUPP/EINVAL before setting the flag:

	rename_exchange_unsupported = (renameat2(...) == -1 &&
				       (errno == EOPNOTSUPP || errno == EINVAL));

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
