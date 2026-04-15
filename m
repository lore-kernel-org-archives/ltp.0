Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F278F4198B
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 11:08:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A3AB3E5B6D
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 13:08:32 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADF5F3C22A5
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:08:13 +0200 (CEST)
Received: from mail-dy1-x1342.google.com (mail-dy1-x1342.google.com
 [IPv6:2607:f8b0:4864:20::1342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AB92B60094A
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 13:08:12 +0200 (CEST)
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2d891442388so5622457eec.0
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776251291; x=1776856091; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xpKCN8ssO7O6PwEddFTbFV+9yw0ncVKxPOFqHTZDVI=;
 b=fhKq+aua4kocat6wNawx1br138bo4AAQ3TEYmoXClUDgnyUshwrcr6MydfPVBjXGp/
 5ZgYDC7MSkgu0Tk5LD5nZjIcvzPLO6Sjvu24OXYTMZKEfMA2tazfUYaBdpW8vDEV5IQV
 gCxxIZHqrU9ajHstQrTzLmKEw3fy8LbwSJ+n+UCSHtxTYBng4TEEc0je5h+fP1EUtnDn
 AZV522doyb5po0tk5mNn/YnX4GO1Yco5W18jMCYo2Rgc2HQt6dzp9XMsF5RKV2yxbxps
 JYaIOgzpLSOCxTRvOMQuaISs14TTxXYfDLbg/ZuUnWbEynjVS9HrMWgKjocfRsiXyuu8
 pX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776251291; x=1776856091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3xpKCN8ssO7O6PwEddFTbFV+9yw0ncVKxPOFqHTZDVI=;
 b=I/ITsQ1shSjjkTz+FqybNFtcp761+lBUL1IsOfSs2CfDIfQM8XGdCEC9t72yGqRBZF
 gae4x3B5cxvemqjiIXMKc3Lgfa6Pj6TWiO7S7k7x+Mekm+mUqE5NovkSMIvkjUPLMTMu
 pj5SkrLTnHIzcdVIFdk5AqtShbIMg1TPJFyMmkztlrvp82MKhwwBbNW+OHgAK15BsBz2
 okz6MZ7XIuUBA7q1Qq0sdSgxk4MGVv4+rwiYnt4w/2anb++O6bHnAwnG49HQBHeh3TRb
 PmWrlxkt5DmaYE19PG72AvoCjQ0J/lU2GoGz1opws9pD3AZ7CuoWjY4mgqyzAMEwQ0CD
 MIeg==
X-Gm-Message-State: AOJu0Yzd6e6hFhJYDi4TZNk4CMcBGwRC4/iXmcAmDX5yZpfBPm6z3Jnp
 fl3bUc4KkuZvFtDAIRd9x2fmLb60YiiU4D8XTJmfkzc9SB8/gaNkNx35howx4EEmGf9gjw==
X-Gm-Gg: AeBDiesqYmqrlSi29MjM5yOXSwbc4hhCeCvmaR36M/oO+0O5ThXHF7fkPUVJQyYVWr+
 /wYLmvcXOnwQpP1CUr1a+5j54m9UTRHpy3ubBCTUEZRNDAfI4/2OHkx9S27mnPcSSUPbJ8JtP8J
 LFwfpu283W7VGmwsUcgxYIWS72gvngi6VwwDBFC9XDXiOtRRqElI9CzUdXfnnoaKhSNeuBWIMZk
 94B1V0kX07pVBHOuSUoAA3Z0Sb/c87cT7iRaf8wB2q3ywzsCMbrRqi1tMVa5jCp09SqqlCBsa77
 D1zKvhHWKRyI82mhXLbKWO8aeZ8JEcDdHyLKXGSeEyy69hdIBieuDgclfnrcU2sRuR63QJtWMMC
 V4qjibi2B7O6HvegJNd9JL9xxi9nqSFU0xnwhfQMmxfvI2ZxM8JSqPzTeSm2WfkJ0bABDUfjCS3
 v7LQDb2vGGRXfyQFPDKoKh1bkl+6FtTstMoV/dz2YZWTJ6HGc0WhrdHhXKzabaSB53ObMaPo+lU
 apAPhHzrnR2Vyb0ajXUj4uhYDCUxPPaDhOnW7SRsEl325bHkz4=
X-Received: by 2002:a05:7300:e790:b0:2db:2089:460f with SMTP id
 5a478bee46e88-2db20894cfbmr4526543eec.19.1776251290876; 
 Wed, 15 Apr 2026 04:08:10 -0700 (PDT)
Received: from
 runnervm35a4x.oz3hdax1fqteba02tevjkwltrd.yx.internal.cloudapp.net
 ([57.151.138.147]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f960dd1sm2082354eec.25.2026.04.15.04.08.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 04:08:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 15 Apr 2026 11:08:09 +0000
Message-ID: <20260415110809.3987-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415103812.21999-2-wegao@suse.com>
References: <20260415103812.21999-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: New library function tst_get_free_uid
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

Hi Wei,

On Wed, 15 Apr 2026, Wei Gao wrote:
> open16: allow restricted O_CREAT of FIFOs and regular files

--- [PATCH 2/2] ---

On Wed, 15 Apr 2026, Wei Gao wrote:
> open16: allow restricted O_CREAT of FIFOs and regular files

> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "2");
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "2");
> +	SAFE_CHMOD(DIR, 0020 | S_ISVTX);
> +
> +	if (!SAFE_FORK()) {
> +		SAFE_SETUID(uid2);
> +		TST_EXP_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777), EACCES);
> +		TST_EXP_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777), EACCES);

uid2 is a free (unused) UID with no group memberships. With mode 0020|S_ISVTX
the "other" bits are 0, so the kernel's DAC check rejects openat/open before
reaching the protected_regular/protected_fifos logic in may_open(). EACCES
fires for the wrong reason.

For a valid level-2 test the directory needs group-execute and group-write
(e.g. 0770|S_ISVTX), and uid2 must be placed in the directory's owning group
so it can access the directory but is still blocked by the protection check.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: <review_url>

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
