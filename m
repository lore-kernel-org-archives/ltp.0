Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22564C3DA7F
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 10:34:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 908053D1D86
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 12:34:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FB7A3D1D7D
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 12:34:38 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9D57A1401207
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 12:34:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4EC321A9D;
 Tue, 30 Jul 2024 10:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722335676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUuL2K40Ym/Bz1YzJxw0jfnm6ipn80ovERkdZcIlYWs=;
 b=Qyd2+mc96X+8VREXXnIb1toJWrF/IS30NAbzuepLAe6HtzztwCdYgr1/e7rBbJwdnECNyc
 HddZq4vuSUOh1tTkyzcBw+WTMy3ir+K33vbGjGW8QnYBZK3F5mzNPFLOad0kP0TpxvCGSe
 gV++m4dV1DzmRQjKrbzbJSLjGDlVyuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722335676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUuL2K40Ym/Bz1YzJxw0jfnm6ipn80ovERkdZcIlYWs=;
 b=eGbJiPMD6szPVEg724mvFIUXWxOhbeO86kV9IdU7D3w9LpF189r1hgO/r+z2iEDNqSk/yw
 9JSUfmj6Bq0A7UAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sLoHLiQo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MMA0KjfT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722335675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUuL2K40Ym/Bz1YzJxw0jfnm6ipn80ovERkdZcIlYWs=;
 b=sLoHLiQozfeMx/pj5a8Sju4UDehxhAtGEffitDXE+xTqGVDxYVkXoFpBeobbZ+TleP1dkl
 0HgCgmvMcnbu2x4PvRVHwiNtI8QV3K+Pjh23Uca9PVDlul0Be8IxMyQ71wmgNiRrO2AehW
 tIfAH0je2sTeUs2TvtGxWKtQ5sNPMXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722335675;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUuL2K40Ym/Bz1YzJxw0jfnm6ipn80ovERkdZcIlYWs=;
 b=MMA0KjfTE3/ghfsreUOsFIeWKRR/gYpUGWCCxhhRpyOI8w9t/YzFjB/OlgC0vGNDM5NpF8
 I2MxmPNb21I3CPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBD5613297;
 Tue, 30 Jul 2024 10:34:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xi6SLLvBqGZeJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jul 2024 10:34:35 +0000
Date: Tue, 30 Jul 2024 12:34:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20240730103431.GA1371143@pevik>
References: <20240521081552.2162-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240521081552.2162-1-maxj.fnst@fujitsu.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E4EC321A9D
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] request_key: Add negative tests for request_key
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
Cc: keyrings@vger.kernel.org, ltp@lists.linux.it,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ma, Eric, all,

> Add negative tests for request_key(), when errno is EFAULT or EPERM

LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

We also somehow test EACCES (request_key04.c). Looking into man page, there are
other interesting errno to test I suppose (EDQUOT, EKEYEXPIRED, EKEYREJECTED,
...)

@Eric, other devs, would you have time to have a quick look on the test?

Kind regards,
Petr

> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>  runtest/syscalls                              |  1 +
>  .../kernel/syscalls/request_key/.gitignore    |  1 +
>  .../syscalls/request_key/request_key06.c      | 52 +++++++++++++++++++
>  3 files changed, 54 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/request_key/request_key06.c

> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3a28123a5..c04359fcd 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1187,6 +1187,7 @@ request_key02 request_key02
>  request_key03 request_key03
>  request_key04 request_key04
>  request_key05 request_key05
> +request_key06 request_key06

>  rmdir01 rmdir01
>  rmdir02 rmdir02
> diff --git a/testcases/kernel/syscalls/request_key/.gitignore b/testcases/kernel/syscalls/request_key/.gitignore
> index e8dc1c570..6dcf613c7 100644
> --- a/testcases/kernel/syscalls/request_key/.gitignore
> +++ b/testcases/kernel/syscalls/request_key/.gitignore
> @@ -3,3 +3,4 @@
>  /request_key03
>  /request_key04
>  /request_key05
> +/request_key06
> diff --git a/testcases/kernel/syscalls/request_key/request_key06.c b/testcases/kernel/syscalls/request_key/request_key06.c
> new file mode 100644
> index 000000000..bd872867b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/request_key/request_key06.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> + * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that request_key(2) fails with
> + *
> + * - EFAULT when type points outside the process's accessible address space
> + * - EFAULT when description points outside the process's accessible address space
> + * - EFAULT when callout_info points outside the process's accessible address space
> + * - EPERM when type argument started with a period '.'
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +
> +static struct test_case_t {
> +	char *type;
> +	char *description;
> +	char *callout_info;
> +	key_serial_t dest_keyring;
> +	int expected_errno;
> +	char *desc;
> +} tcases[] = {
> +	{(char *)(-1), "description", NULL, KEY_SPEC_PROCESS_KEYRING, EFAULT,
> +		"type points outside the process's accessible address space"},
> +	{"type", (char *)(-1), NULL, KEY_SPEC_PROCESS_KEYRING, EFAULT,
> +		"description points outside the process's accessible address space"},
> +	{"type", "description", (char *)(-1), KEY_SPEC_PROCESS_KEYRING, EFAULT,
> +		"callout_info points outside the process's accessible address space"},
> +	{".type", "description", NULL, KEY_SPEC_PROCESS_KEYRING, EPERM,
> +		"type argument started with a period '.'"},
> +};
> +
> +static void verify_request_key(unsigned int i)
> +{
> +	struct test_case_t *tc = &tcases[i];
> +
> +	TST_EXP_FAIL2(request_key(tc->type, tc->description, tc->callout_info,
> +		tc->dest_keyring),
> +		tc->expected_errno,
> +		"%s", tc->desc);
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_request_key,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
