Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2451AC54E68
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 09:34:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2E6D3CFBB9
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 10:34:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFC063CD7F1
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 10:34:12 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ADEE9140E7C9
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 10:34:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 72B5D5CB94;
 Thu, 21 Mar 2024 09:34:10 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53ADC13976;
 Thu, 21 Mar 2024 09:34:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IfUgExL/+2VmCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Mar 2024 09:34:10 +0000
Date: Thu, 21 Mar 2024 10:33:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240321093350.GB548078@pevik>
References: <20240320095927.19973-1-chrubis@suse.cz>
 <20240320095927.19973-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240320095927.19973-3-chrubis@suse.cz>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: 72B5D5CB94
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls: Add test for splicing to /dev/zero
 and /dev/null
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> +
> +static const char *test_devices[] = {
checkpatch.pl suggests:
static const char * const test_devices[] = {

> +	"/dev/null",
> +	"/dev/zero",
> +};
> +
> +static void verify_splice(unsigned int n)
> +{
> +	char buf[1024];
> +	char dev_fd;
> +	int pipefd[2];
> +
> +	memset(buf, 0xff, sizeof(buf));
> +
> +	tst_res(TINFO, "Testing %s", test_devices[n]);
> +
> +	dev_fd = SAFE_OPEN(test_devices[n], O_WRONLY);
> +
> +	SAFE_PIPE(pipefd);
> +	SAFE_WRITE(1, pipefd[1], buf, sizeof(buf));
I wonder if write() fails, we don't get SAFE_CLOSE() calls, right?

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +	TST_EXP_POSITIVE(splice(pipefd[0], NULL, dev_fd, NULL, sizeof(buf), 0));
> +
> +	if (TST_PASS && TST_RET != sizeof(buf))
> +		tst_res(TFAIL, "Wrote only part of the pipe buffer");
> +	else
> +		tst_res(TPASS, "Wrote whole pipe buffer");
> +
> +	SAFE_CLOSE(pipefd[0]);
> +	SAFE_CLOSE(pipefd[1]);
> +	SAFE_CLOSE(dev_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_splice,
> +	.tcnt = ARRAY_SIZE(test_devices),
> +	.min_kver = "6.7",
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
