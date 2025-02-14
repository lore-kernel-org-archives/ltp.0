Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1B1C02198
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 13:56:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0295A3C9AFB
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 14:56:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4381C3C7A25
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 14:55:44 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A9F6E1017B51
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 14:55:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C12381F381;
 Fri, 14 Feb 2025 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739541337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+l1sEIi+WKs8N5tsQtsFy2G0jpxobw8V5Qn8e13aIA=;
 b=G1ikcaFK7aHHY3DBzmSCIBe1iFn7T/Cc/al2xLnSZ1HKxSwfEZZMtNaNKfNxVbASNxvELl
 C4Iyx1iM5j5KeBFvk0DCfrVigdkDYadtEz/e6NToVS0sth1WNEd6qAuN9kyVBL1JlSOfmH
 z2LZPHkxixrLyNfMBZbkYMIGY7EXoQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739541337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+l1sEIi+WKs8N5tsQtsFy2G0jpxobw8V5Qn8e13aIA=;
 b=1bFXqGwnWHanEdh2x3jwmWm8zhBV6Llhq/1O69XRsrQ41w7MEmQ0RvTg8TZCoX5YvTQPp9
 OY+pC4yx4dG4lIBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x3fCQ1BI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7InHcY2Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739541332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+l1sEIi+WKs8N5tsQtsFy2G0jpxobw8V5Qn8e13aIA=;
 b=x3fCQ1BIAG7XisWfgFDT37u3CLPCKgwx0sDSObWwEVgmN/Kc/AdFmbqIIYxXZekVf5WV2A
 kLZvte/d8gINDY7vf9/GszKZGEPeErMMHEAe75ws9a566V6S1Jjg6A38hqEtAiLOSGfLRc
 9P1QFuHtrL7aS3TKYVXcVuS614MJnLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739541332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d+l1sEIi+WKs8N5tsQtsFy2G0jpxobw8V5Qn8e13aIA=;
 b=7InHcY2YYYE2qraQ5OdbnAJHKecotEbbBfRLzymeXBA/u6Cn2SdHTioqadZij6pUEGKh1D
 AyIY5FQS3XD9RrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 83DAB13285;
 Fri, 14 Feb 2025 13:55:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rf7gHVRLr2eTFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Feb 2025 13:55:32 +0000
Date: Fri, 14 Feb 2025 14:55:31 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250214135531.GB2221874@pevik>
References: <20250214112135.18947-1-chrubis@suse.cz>
 <20250214112135.18947-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250214112135.18947-3-chrubis@suse.cz>
X-Rspamd-Queue-Id: C12381F381
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_NIXSPAM_FAIL(0.00)[2a07:de40:b281:104:10:150:64:97:server fail];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] shell lib: Add support for test cleanup
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


> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/lib/run_tests.sh                    |  4 +++-
>  .../lib/tests/shell_loader_brk_cleanup.sh     | 20 ++++++++++++++++++
>  testcases/lib/tests/shell_loader_cleanup.sh   | 21 +++++++++++++++++++
>  testcases/lib/tst_env.sh                      |  4 ++++
>  4 files changed, 48 insertions(+), 1 deletion(-)
>  create mode 100755 testcases/lib/tests/shell_loader_brk_cleanup.sh
>  create mode 100755 testcases/lib/tests/shell_loader_cleanup.sh

> diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
> index 168dbb451..d568d4614 100755
> --- a/testcases/lib/run_tests.sh
> +++ b/testcases/lib/run_tests.sh
> @@ -9,6 +9,7 @@ shell_loader_filesystems.sh
>  shell_loader_kconfigs.sh
>  shell_loader_supported_archs.sh
>  shell_loader_tcnt.sh
> +shell_loader_cleanup.sh
>  shell_test01
>  shell_test02
>  shell_test03
> @@ -21,7 +22,8 @@ TESTS_TBROK="
>  shell_loader_invalid_block.sh
>  shell_loader_invalid_metadata.sh
>  shell_loader_no_metadata.sh
> -shell_loader_wrong_metadata.sh"
> +shell_loader_wrong_metadata.sh
> +shell_loader_brk_cleanup.sh"

>  TESTS_TCONF="shell_test06"

> diff --git a/testcases/lib/tests/shell_loader_brk_cleanup.sh b/testcases/lib/tests/shell_loader_brk_cleanup.sh
> new file mode 100755
> index 000000000..8c704a540
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_brk_cleanup.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
> +#
> +# ---
> +# env
> +# {
> +# }
> +# ---
> +
> +TST_CLEANUP=cleanup
> +
> +. tst_loader.sh
> +
> +cleanup()
> +{
> +	tst_res TINFO "Cleanup runs"
> +}
> +
> +tst_brk TBROK "Test exits"
> diff --git a/testcases/lib/tests/shell_loader_cleanup.sh b/testcases/lib/tests/shell_loader_cleanup.sh
> new file mode 100755
> index 000000000..b183f1d28
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_cleanup.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
> +#
> +# ---
> +# env
> +# {
> +# }
> +# ---
> +
> +TST_CLEANUP=do_cleanup
> +
> +. tst_loader.sh
> +
> +do_cleanup()
> +{
> +	tst_res TINFO "Cleanup executed"
> +}
> +
> +tst_res TPASS "Test is executed"
> +
> diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
> index 68f9a0daa..b13bab37c 100644
> --- a/testcases/lib/tst_env.sh
> +++ b/testcases/lib/tst_env.sh
> @@ -35,3 +35,7 @@ tst_brk_()

>  alias tst_res="tst_res_ $tst_script_name \$LINENO"
>  alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
> +
> +if [ -n "$TST_CLEANUP" ]; then
> +	trap $TST_CLEANUP EXIT
> +fi

thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Unfortunately TST_SETUP will not work that way - function is not found or if you
load tst_env.sh at the end, it complains about missing tst_res or tst_brk:

./tests/./shell_loader_brk_cleanup.sh: line 16: tst_res: command not found

Obviously it does not help to add it to tst_loader.sh.

I'm surprised it checks that, is there shopt option which could disable it?

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
