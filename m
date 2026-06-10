Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1E5CD98C5
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 19:44:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 975B03E24B6
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 21:44:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1B743CBAA9
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 21:44:31 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4D296600543
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 21:44:30 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8ce9df31840so54455216d6.1
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 12:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781120669; x=1781725469; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8eFAqNjI4kUASePi7NFtwJEc5UBO/JGL+RvNk1kBqRc=;
 b=tNTY4aytrL4Z124MbpBcktbDlLRIJcvWgU4fADpH1SqCz/88oV0bRRkHRtqywlomxo
 Bb4VxXUy4dQsnCVsJcn8cANOHhXyA7OSpWsYPoYxlQU2+u4MXcWmvE6C7V5m1hgKru1z
 MMxVcKqHm/FO2nxv8Z4mkaW++UbodN3TEjdtVFLS1iudakXKXEsbqD6C+/QHsPuiTqaP
 EIHpXyura+8rJyHxDFSwTyajMmGvF/NY/LLyRWjls7vQPVs0DxzNGwGKsyr6ccGPRHO8
 W+AGd6wkbPyLMi7H9Yz/M6T12TebAXERLvCJEjnaZ8FmN+fC3JJZNPwr7Kap8drP086W
 SEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781120669; x=1781725469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8eFAqNjI4kUASePi7NFtwJEc5UBO/JGL+RvNk1kBqRc=;
 b=VEkoz5PKC8TUgJ/6jHdMdXcZGm1i4/PZd5tleUTUl/tPpLIKoFWymHkbk6Y7S+NEOW
 CI5FVa/fbAg7SzgXSh734gEFCxOfF4P5EQjkR6KvSpX8ZU/bN8gM4Z5byigcOeNAT+X/
 XovgjjtjLVJ+z2uEHI3U3eS+9z8pHtKOz9xB0D8cPW2iGyrPiacCjKVtdS2NxYYWmIGg
 a2p8gAqMdNt710SIZP3JdqpQ50TCouQWPnDLS91FlGdtuCox2w9LEJpxj7Si8PrQchyO
 mT+SBvT7/xqk38OR5jeh7HGPTv1naOg04YFJ8z/diBgU5S+dCMzcaGaRsrvMcdQ1wTsE
 F/kw==
X-Gm-Message-State: AOJu0YznKatTmV09lC+uu4Ln2hDNFfnkYvHDzAR7tQ4jhj00MDq84z/X
 Jptz2GWywl0TWKVHehr6SLbZV4QmBI4avKUpV3sDj1xm/05C/Jnpo3ff
X-Gm-Gg: Acq92OFzsq4EDIsh/puhog8Wv7EfcNot6E1U/itulFEgiZ2sVYisbhT2tSKicAPFKQf
 uCOsfIqPhlRk6axoGFsJb6111x2aWWqW8n7Ssk1/MeXXl722sRHx54OtSekuBxeYe1dzR23zP4a
 NysymSe20oq0EhFZ2R578WNZy3n8ploEgY+A3SqnFXM0sdI/VYHpTcmlvRr/eXg73pUIzSI6E6t
 EIW53obrudwm+ztqbao71E210W4iT9ouwf+Dbkx3dP9DJ93JWNB3fivGRm6UHs8PqREWV2JW1hM
 1bPHUXEtkV3AIEVyVkDkwqW7YZESlLeHbt8JGq4Z0tHsPHr9B+2QD1czHe/ZuV4I7Xc40O7gpDI
 hG2OnOWe0IPcF9BoLJYjb23HF7DzGCI1KWc7QxJVwEBIZb+7MBL9hjNLsmURyDzqS3sSBwQ8gsh
 HEuXmjRUx+0724QOC/W7vOqrrDL3ICYPHbDnQrIDo/IdWHrKtmXkgz6tfPaCtWvSuNWAtCyDS7E
 UhlS7KXfsfHxrKcaaICWAgxysmxDs12NR5j2sg+243zekFN6HY/siZVqHwa
X-Received: by 2002:a05:6214:5b84:b0:8ce:f900:ad81 with SMTP id
 6a1803df08f44-8cef900af0cmr360753216d6.9.1781120668805; 
 Wed, 10 Jun 2026 12:44:28 -0700 (PDT)
Received: from
 runnervm3jyl0.u5lasr1klgpuhl44gz2o41ajse.ex.internal.cloudapp.net
 ([20.102.222.26]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccda0904sm244088736d6.7.2026.06.10.12.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 12:44:28 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 10 Jun 2026 19:44:27 +0000
Message-ID: <20260610194427.4063-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610-fw_load-v3-1-eef32edfe8d5@suse.com>
References: <20260610-fw_load-v3-1-eef32edfe8d5@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fw_load: Modernize ltp_fw_load kernel module
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

On Wed, Jun 10 2026, Andrea Cervesato wrote:
> fw_load: Modernize ltp_fw_load kernel module

--- [PATCH 2/3] ---

> +static void cleanup(void)
> +{
> +	struct fw_data *fw;
> +
> +	for (int i = fw_count - 1; i >= 0; i--) {
> +		fw = &firmware[i];
> +
> +		if (access(fw->file, F_OK) != -1)
> +			SAFE_UNLINK(fw->file);
> +
> +		if (access(fw->dir, F_OK) != -1)
> +			remove(fw->dir);
> +	}

The old code tracked whether each directory was created by the test
(the `remove_dir` flag) and only removed directories the test itself
made. The new code unconditionally attempts `remove()` on every
directory in the `firmware[]` array.

If a directory such as `/lib/firmware/updates/` existed before the
test and happened to be empty after the test file is unlinked,
`remove()` would delete it even though the test did not create it.

Could a flag (or an `access()` check before `SAFE_MKDIR`) be added
to restore the previous behaviour?

--- [PATCH 3/3] ---

> + * [Algorithm]
> + *
> + * - Set the firmware search path to the LTP temporary directory
> + * - Create ``FW_NUM - 1`` firmware files there, each named
> + *   ``n<i>_load_tst.fw`` and filled with a known byte pattern
> + * - Add one fake firmware entry that has no file on disk
> + * - Load the helper module with ``fw_size`` matching the blob size

The algorithm says the module is loaded after the firmware files are
created, but the code loads the module before creating the files
(lines 115-119). The order does not affect correctness since
`request_firmware()` is only triggered when writing to `fwnum`, but
the `[Algorithm]` section should match the actual code order.

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
