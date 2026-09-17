Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBBFC88E72
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 08:54:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 653F23E7545
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 10:54:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17FAC3E259F
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 10:54:35 +0200 (CEST)
Received: from mta0.migadu.com (out-185.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0191B1400DAA
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 10:54:32 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=kB6jgJ9G9GfO7UTVipYA1+Q99DhcNxsxKv6GZyr3FK4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789635271; v=1; x=1790240071;
 b=URgc80C85xUfBQC+INoI4STQv94uinoCe2K/kzOAglYKe1YO+qJaL2+Me4wyo7PXsReQNLWa
 WtUPLupamTaTsOpLB7JmrhTmr6080gE78AgU4kx9E2+ZXcsTGoOOouwqzkUXYzxONDhikZWhnw2
 p8fIkkO3VzacUhOAiKx8DUuw=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id d406f2490dc8068e;
 Thu, 17 Sep 2026 08:54:21 +0000
X-Mizu-Trace-ID: d406f2490dc8068e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 17 Sep 2026 16:54:16 +0800
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aququIx31-BBNlnq@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Cyril Hrubis <chrubis@suse.cz>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-10-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-10-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 09/36] keyctl15: Test KEYCTL_GET_SECURITY label
 retrieval
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

> +static void run(void)
> +{
> +	int rc;
> +
> +	memset(buf, 0, sizeof(buf));
> +
> +	rc = SAFE_KEYCTL(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0);
> +
> +	if (buf[0] != '\0')
> +		tst_res(TFAIL, "empty label is not NUL terminated");

The code unconditionally checks if the buffer is empty (buf[0] != '\0')
without verifying the return code (rc) first. On a system has SELinux enabled,
the kernel returns a valid security label (length 54). Therefore, buf[0]
contains a valid character (not \0), which incorrectly triggers failure:

# getenforce
Enforcing

# ./keyctl15
tst_test.c:2067: TINFO: LTP version: 20260529
tst_test.c:2070: TINFO: Tested kernel: 6.6.145-10.sl26.x86_64 #1 SMP Mon Sep 14 12:59:37 CST 2026 x86_64
tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1895: TINFO: Overall timeout per run is 0h 00m 30s
keyctl15.c:46: TFAIL: empty label is not NUL terminated
keyctl15.c:58: TPASS: security label returned, full length 54
...

Maybe refine it like below:

static void run(void)
{
	int rc;

	memset(buf, 0, sizeof(buf));

	rc = SAFE_KEYCTL(KEYCTL_GET_SECURITY, key, (unsigned long)buf, sizeof(buf), 0);

	if (rc < 1) {
		tst_res(TFAIL, "returned %d, expected >= 1", rc);
		return;
	}

	if (rc == 1) {
		if (buf[0] != '\0')
			tst_res(TFAIL, "empty label is not NUL terminated");
		else
			tst_res(TPASS, "no label set, empty string returned");
		return;
	}

	if (buf[0] == '\0')
		tst_res(TFAIL, "non-empty label is NUL terminated");
	else
		tst_res(TPASS, "security label returned, full length %d", rc);
}

> +
> +	if (rc < 1) {
> +		tst_res(TFAIL, "returned %d, expected >= 1", rc);
> +		return;
> +	}
> +
> +	if (rc == 1) {
> +		tst_res(TPASS, "no label set, empty string returned");
> +		return;
> +	}
> +
> +	tst_res(TPASS, "security label returned, full length %d", rc);
> +}

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
