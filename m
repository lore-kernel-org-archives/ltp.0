Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF075C79F8C
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 10:36:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59EFC3E57E1
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 12:36:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 089C93E53FB
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:35:57 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9F94A600A44
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 12:35:56 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-38fd9408220so1636601a91.1
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 03:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788950155; x=1789554955; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wsFXf25/2c/r3M/IoKKmBJh+yBnW3iHZNFwH/XfICJs=;
 b=lRbaPs3lML4oJq0fDwP34VCeI/oQFSj2UQbdfrOK1GstJ1y+yB+mnCNIAePjkLAlhf
 nrJebSWPkYA/EpBiTCZc6BOk2vf7w7AjHuf1HYsDoWzw81nBxuddthrwSW/Vqbnf3hgI
 OgqHxks5Fz+onucpFQIr2rfTZbYiGPDZVmWASaYzaQ8RtfzZYSS6cwufy1mPJh5DIw62
 PLKA0l1ybYl9q5OCIyJM3edD+7mXPSHhWYnBo4yvhvqwlxFMd9O5Jxr/23UAaX/ebzj+
 mfqVIu7Q/c3E03Ivt/e6e0Fjt55cVnh3xsmQoTcE7A9UUjBk0+87iFXlPqaCzmD2GFX+
 O6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788950155; x=1789554955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wsFXf25/2c/r3M/IoKKmBJh+yBnW3iHZNFwH/XfICJs=;
 b=gAE13g0pHuuVKUV6Cgb6+zb2IyqcnZtX8zrROjwt3d4ZyVnzLDA7aSxuvljrGukLLo
 OPtCNJ1g1tklDxi5AqlVzEitTcsjN2GcWY46sC5/B/bNxUkoPe7L0J42oCbpfNxS6VP5
 xNj9QB3NZXTGaPwduYSC5jJqG0peQ7si/fS+owsN2pLjWsLD1h3FUcCAbTMinsGZZOym
 CrVZ5E897s/2+btRhLLQcPbnUp1xvocsm0NBKTdk5rkRwGVoXMnyUJ2wQoVfTYEcTQ4z
 ljapQmWbBLzv1IG8KXfOdlw4SF0zXADA+AyFtWoZlXpR9CU3j1bp37EmpxGIr/o2Wa3H
 NuSA==
X-Gm-Message-State: AFuF++kKnch9iJvAXAc2FsdiHLQdbpK4ovsCFlVkcOb6EulFjNSFCuJg
 uPWzfc4zx+aSmQAsLq+uRT2Fw2ccM8tkHUBSXPJsISbma32AWZdxuBmq0t9bcdEY
X-Gm-Gg: AYBFou2Np/VQz0tO2lYgAI88ZHtVRQ2cJY1/jarGs2MBKKKkay/cb229ppILcevi9Mm
 k9NSy5HHdue2Q5/oCHd4Dcs1U+rn8YtzyYM/lQyvk3ZLpA2Pc/jlfIasz2oDDe2zLT73LV99Dt9
 ESIq6+hCXd4QQaeOtC/gTT6xhIb3I4tcbL7jMLvheSlD8cJz58riOFv9DIk4efjwqYBmpuoSjmk
 tkEvWjMSlRx4a1vZilTsdPqZQE1XSDNh20Tn3/6KwotKEGgnZv5ZSKUqhIWUjFVKXy7sEa8QQ3i
 JeooJkX1XsDIngLV6OBZ8q9o/R4wuqRd6DblkZiP2zNw0urNNg/vu7FQ/GYOAg+tmqMDLn3YJ25
 r+T4MsU8ZCgaIEmtx/B/yZDneOJPdaNJ77O1ExY0D9zfgWH/0c8TcaeV0QD++KzpJQriGtg9IfU
 9/MK+mBG6Px12jHmzLlmWJZfrn9JVno4uJOIB734lKifVxyv3JQndO5FqaCeH5XTjQBhbtaGsgB
 j+X7uPma8xvb9QnfScDEDE1alYgazLmZhmy+znPP9RgOSTu/ZGbRo3IGJw2xdRmAF3POMGgawTA
 oGf3hCQgOg==
X-Received: by 2002:a17:90a:ec8d:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-39b26101c08mr50012540a91.9.1788950154861; 
 Wed, 09 Sep 2026 03:35:54 -0700 (PDT)
Received: from
 runnervmejwal.rfdfcp0adv4ubaqtheixahij3f.xx.internal.cloudapp.net
 ([20.64.182.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39cd20b187asm1064508a91.4.2026.09.09.03.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 03:35:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed,  9 Sep 2026 10:35:52 +0000
Message-ID: <20260909103552.9380-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909-coredump-v9-1-6b0ee752f57e@suse.com>
References: <20260909-coredump-v9-1-6b0ee752f57e@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Add SAFE_FILE_VPRINTF()
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

Hi Andrea,

On Wed, 9 Sep 2026 12:04:48 +0200, Andrea Cervesato <andrea.cervesato@suse.com> wrote:
> [PATCH 1/3] lib: Add SAFE_FILE_VPRINTF()

--- [PATCH 1/3] ---

> +#define SAFE_FILE_VPRINTF(path, fmt, va) \
> +	safe_file_vprintf(__FILE__, __LINE__, NULL, \
> +			  (path), (fmt), (va))

Missing kernel-doc comment for SAFE_FILE_VPRINTF(). Public macros added to
include/tst_safe_file_ops.h must be documented with kernel-doc syntax
recognized by linuxdoc.

--- [PATCH 3/3] ---

> +	if (type == NT_PRPSINFO && descsz >= sizeof(struct elf_prpsinfo)) {
> +		struct elf_prpsinfo info;
> +
> +		memcpy(&info, desc, sizeof(info));
> +		TST_EXP_EQ_STRN(info.pr_fname, "coredump02", sizeof("coredump02"));
> +
> +		prpsinfo_seen = 1;

Using sizeof("coredump02") as the length argument triggers a
-Wsizeof-pointer-memaccess compiler warning from TST_EXP_EQ_STRN(). Use
TST_EXP_EQ_STR(info.pr_fname, "coredump02") since pr_fname is
null-terminated, or pass sizeof(info.pr_fname).

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
