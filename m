Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161BCCCFA1A
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 14:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3767F3CF778
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 15:19:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D61653CF6FB
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:19:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8E44210005DC
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 15:19:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AFFA1F7FA;
 Wed, 12 Nov 2025 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762957151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CO3VUBcruSmOw0Rc4Q6i2XG2pY3hAG8XI62z5Uwyt+4=;
 b=z92SYve6UOAWODdL63xg+lR4Qn82kXMXOpaAD6sQIZUcQYP8fawrecfwfyruDy9/WcoSpR
 Zzez0SxdfEe96buTTip5OiVghtiIqH82Gb87o7kfjjWmeI6FSUIAs7VDM1n/SvWQgmbIxx
 SPwGCkK6BfVcSKAjh4V1frfzW4rqIFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762957151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CO3VUBcruSmOw0Rc4Q6i2XG2pY3hAG8XI62z5Uwyt+4=;
 b=ARtA/HDk2srdbj6SEBD3NrEISPo1SzS6t49nLCQKFkrapciXRCz422xMN3UWRlHyPT6YEK
 maPWj8j7+uoqcbBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762957151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CO3VUBcruSmOw0Rc4Q6i2XG2pY3hAG8XI62z5Uwyt+4=;
 b=z92SYve6UOAWODdL63xg+lR4Qn82kXMXOpaAD6sQIZUcQYP8fawrecfwfyruDy9/WcoSpR
 Zzez0SxdfEe96buTTip5OiVghtiIqH82Gb87o7kfjjWmeI6FSUIAs7VDM1n/SvWQgmbIxx
 SPwGCkK6BfVcSKAjh4V1frfzW4rqIFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762957151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CO3VUBcruSmOw0Rc4Q6i2XG2pY3hAG8XI62z5Uwyt+4=;
 b=ARtA/HDk2srdbj6SEBD3NrEISPo1SzS6t49nLCQKFkrapciXRCz422xMN3UWRlHyPT6YEK
 maPWj8j7+uoqcbBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D89463EA61;
 Wed, 12 Nov 2025 14:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FNgzM16XFGlhJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Nov 2025 14:19:10 +0000
Date: Wed, 12 Nov 2025 15:19:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251112141909.GB141617@pevik>
References: <20251110102407.15308-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251110102407.15308-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[email.com:email,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add basic shell test description
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

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/developers/api_shell_tests.rst | 91 ++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)

> diff --git a/doc/developers/api_shell_tests.rst b/doc/developers/api_shell_tests.rst
> index b6e8560d9..bad9f1f4b 100644
> --- a/doc/developers/api_shell_tests.rst
> +++ b/doc/developers/api_shell_tests.rst
> @@ -2,3 +2,94 @@

>  LTP shell API
>  =============
> +
> +Shell API overview
> +------------------
> +
> +First lines of the shell test should be a shebang, a license, and copyrights.
> +
> +.. code-block:: shell
> +
> +   #!/bin/sh
> +   # SPDX-License-Identifier: GPL-2.0-or-later
> +   # Copyright 2099 Foo Bar <foo.bar@email.com>
very nit: maybe foo.bar@example.org?

...
> +At this point everything has been set up and we can finally write the test
> +function. The test results are reported by the usual functions `tst_res` and
> +`tst_brk`. As in the C API these functions store results into a piece of shared
> +memory as soon as they return so there is no need to propagate results event
> +from child processes.
> +
> +.. code-block:: shell
> +
> +   tst_test()
> +   {
> +        tst_res TPASS "Bar enabled Foo"
> +   }
> +
> +In order for the test to be actually executed the very last line of the script
> +must source the `tst_run.sh` script.

Also this could be :master:`testcases/lib/tst_run.sh`.

Of course, all the changes can be done before merging (no need to post v2).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
