Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A79C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788511888; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=8muiFar78AyYsCg1GE6RTJjjYxlTFEWggWEIycSRWBs=;
 b=g6EtH/F4kuClv/i4UuYbuX0OJQVBEHUJzZg8f5Y2p5LItZf/9sr+kEULmbrey3Emcx4YC
 UGCf7YRv5FpvdqRUaUiiiJpNSFN1+hk+MIeh7R+2lv4dX53MVxWhedcyFFpa9dDbz88qw4z
 XqF8N0llbQwrv5WCoL0PP21UzEwapCY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28D983E937A
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 10:51:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C59313E56C2
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:51:08 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58858600832
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 10:51:08 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso8365595e9.1
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788511868; x=1789116668; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0Bfkn2BYI6CGAmPvOdf7ySaHmZNExMaGzuZEOlsBRJ4=;
 b=NAKF2IF6vQk+/9JAvz2/3WH0IQwpV2Ccnmz9hPBsXW8D1ZT3y201zcl1ZcCmwMmWvV
 dYU0yVB87+Amn68DuQuwWP+RB8Pp1V9AYJedsS/+/8LPWW177ZLHWMM6vQaFDDmUcdK+
 iTMypL2RufXj7eROEZep0O7pnaP6NlJ677rHMe6p4v+4ldw0zmXFv4on7eiYzEJGkKNw
 Dch1/20rooTSd6id0qkap6ZH+IjC5pyaldTLfKJ/q5qhfLIX6M2se0z73R86uf3NnIFz
 tjUkwaYcmAndQk5l1V0wXDO+EdaWUi1BMNWtHlMDXD3yXrg6afsQ7Hrj+izJbH5n1Ase
 CE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788511868; x=1789116668;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Bfkn2BYI6CGAmPvOdf7ySaHmZNExMaGzuZEOlsBRJ4=;
 b=Oha8NvdftLkdM7YNVYR4APgYvFDqsKw+kWV5lnrpv5ZpB7AH+7yzNSvUxecHwx7BzS
 qJ8lQU2U9HfLia7MXcGGrz/MVd6h563jEFQlT9c1gNgrVX9knF1hggMBwG2Ww0xGVVke
 IwE3yCMLO4qrwn9MJiX+rD3DMSn1G22HGSToqgm+I+z2EswK1gctdSlUarpOd+xT0Xj5
 Bd1epn67MbPsE8AJNAq1mOfTFiY28nA/vH01oOl5XAP3kOkAXvW5KkUq9inATTpY/ljV
 FT6mUDdnBeh4a5z9414+B7cD4TSOo6bCIMwsVVqIfGb1hupRGL3qjF+VGqQ0xJTJr+pP
 Qi9g==
X-Gm-Message-State: AFuF++mC2u4iMgL2g191eBUgvGEH0wzrCxx2t2pPqR6/dF1IMkKUJXlc
 k81f3E7c5Hig5YjVHq9gINUpDAuF179I2aXW2Dm7eokVjIiyRnviKVYbusHcFMvQl6s=
X-Gm-Gg: AYBFou2FeowOK+J289GZVVh21VWSyNPTDA11xGw9KQelxf4DAl+j2cXZTcw6oOpBNfL
 NF/ep0eemRSZZb2b6CnuDIQ9wJxkBoPCBg/3UAcqcIsIki9u20nOI9l98j25aGDHbTnjf3vDvqf
 3aSiCeuc4ZlQO8uwc0aHX+eCboiGwhPKeBRMybFHQ5Gt5rFalVWRVgg92LYgZzZYKcpnKWmdLG8
 PSdsOYjCLg7BCJ7WIooHi5pAKe5fVUHNxSLjeuUSO3bbS1iytnaNw9k8WtTjEfEgBnGdGG3W6X7
 Oo4GhXu0LYLaLJXLUm3O/MRGEqk0RzNIPUyg1a2SfBJo0crKHyQBEbd+bFkfLVy/E3fp0S9jwq5
 X4m1ZxKQTdAcbsLFqflXBWYUr0/EoU+ecnvAhGmuyWp+7z1r74ul0mkuzww2ns9O+eHWWDcTijE
 xRF574Ha46SfdaQh/ohQ1W0AibqsJwE/yBW7UaKYfCif6FoKT8JHdsrcs5567k3wTR3mIyZMo6U
 hHtx4YvZ0r5
X-Received: by 2002:a05:600d:4447:20b0:49c:fc6e:8cbc with SMTP id
 5b1f17b1804b1-49cfc6e8e40mr12267535e9.32.1788511867574; 
 Fri, 04 Sep 2026 01:51:07 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60d8a6sm137369195e9.10.2026.09.04.01.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 01:51:07 -0700 (PDT)
Message-ID: <6a9a867b.de81f790.219d91.7092@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260903095255.4925-2-wegao@suse.com>
Date: Fri, 04 Sep 2026 08:51:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11 1/2] lib: Extend tst_assert_ulong() with enum
 flags
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

H Wei,

I was re-checking the whole patch-set and it looks a bit overengineered
from my point of view. A few points below.

> +enum tst_assert_flags {
> +	TST_ASSERT_SATURATED_INT = 1,
> +	TST_ASSERT_TRUNC_32BIT   = 2,
> +};

Adding new flags for the whole LTP core library trying to fix a single
test is not a good idea in general. Also, TST_ASSERT_TRUNC_32BIT is
probably not needed.

> +	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val_64);

This is the real fix. Read below.

> +
> +	if (flags & TST_ASSERT_SATURATED_INT) {
> +		if (sys_val_64 > (unsigned long long)INT_MAX)
> +			expected_val = (unsigned long)INT_MAX;
> +		else
> +			expected_val = (unsigned long)sys_val_64;
> +	} else if (flags & TST_ASSERT_TRUNC_32BIT) {

In 32bit compat mode `unsigned long` becomes 32bit, so we can simply do:

void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
{
	unsigned long long sys_val;

	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val);

	if (val == (unsigned long)sys_val) {
		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
		return;
	}

	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
		path, val, (unsigned long)sys_val);
}

And then, inside the test:

	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
		tst_res(TPASS, "shmmax clamped to INT_MAX in compat mode");
	else
		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);

	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);


Please verify if this is working anyway. We can probably fix the
whole patch-set with a couple of lines instead of defining
redundant flags and specific code for a single test.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
