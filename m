Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF56C28B28
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 09:59:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 005193CA4E2
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 10:59:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 141443CA304
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:58:44 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 92E01200989
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 10:58:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7AC91F388;
 Thu, 13 Mar 2025 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741859922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwkVBRKQJYYNyzoOqA9sXM9IN5y8qF51j0NTDG4ZhwM=;
 b=ENpN4frKFF474APZ2lCfgyiK7awjH3rcxjgGEKbup9M2axo9niZID1GVtVIoWuOoeUk0SD
 7oOqpD5SL2E43qbYS1zjFYXywc5o4aNOOIEpt26myLf+werxIaj7ZrNCUZ9Amj89pVsPnh
 QTnZrotr8AH/otyxufpeUtMEDHSiRRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741859922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwkVBRKQJYYNyzoOqA9sXM9IN5y8qF51j0NTDG4ZhwM=;
 b=YS/Fqrzh8X7/64CWgB4c2kNObc4rR/p7ZDLGRPOQRTV0A1j7zrqNmNomy3xgM3fanrdhha
 JJ1l3WcvawUI5fCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741859922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwkVBRKQJYYNyzoOqA9sXM9IN5y8qF51j0NTDG4ZhwM=;
 b=ENpN4frKFF474APZ2lCfgyiK7awjH3rcxjgGEKbup9M2axo9niZID1GVtVIoWuOoeUk0SD
 7oOqpD5SL2E43qbYS1zjFYXywc5o4aNOOIEpt26myLf+werxIaj7ZrNCUZ9Amj89pVsPnh
 QTnZrotr8AH/otyxufpeUtMEDHSiRRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741859922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UwkVBRKQJYYNyzoOqA9sXM9IN5y8qF51j0NTDG4ZhwM=;
 b=YS/Fqrzh8X7/64CWgB4c2kNObc4rR/p7ZDLGRPOQRTV0A1j7zrqNmNomy3xgM3fanrdhha
 JJ1l3WcvawUI5fCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAFB8137BA;
 Thu, 13 Mar 2025 09:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jrJSLVKs0mdTQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 13 Mar 2025 09:58:42 +0000
Date: Thu, 13 Mar 2025 10:58:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250313095837.GC135222@pevik>
References: <20250313-mmap_suite_refactoring-v3-0-eb9172686230@suse.com>
 <20250313-mmap_suite_refactoring-v3-1-eb9172686230@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250313-mmap_suite_refactoring-v3-1-eb9172686230@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/8] Refactor mmap03 test
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

Hi Andrea, Cyril,

...
> +++ b/testcases/kernel/syscalls/mmap/mmap03.c
> -		/*
> -		 * Check whether the mapped memory region
> -		 * has the file contents.
> -		 *
> -		 * with ia64 and PARISC/hppa, this should
> -		 * generate a SIGSEGV which will be caught below.
> -		 *
> -		 */
> -
> -		if (sigsetjmp(env, 1) == 0) {
> -			if (memcmp(dummy, addr, page_sz)) {
> -				tst_resm(TFAIL,
> -					 "mapped memory region "
> -					 "contains invalid data");
> -			} else {
> -				tst_resm(TPASS,
> -					 "mmap() functionality is "
> -					 "correct");
> -			}
> -		}
> -#if defined(__ia64__) || defined(__hppa__) || defined(__mips__)
> -		if (pass) {
> -			tst_resm(TPASS, "Got SIGSEGV as expected");
> -		} else {
> -			tst_resm(TFAIL, "Mapped memory region with NO "
> -				 "access is accessible");
> -		}
...

> +#if defined(__ia64__) || defined(__hppa__) || defined(__mips__)
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> +		tst_res(TPASS, "SIGSEGV has been received");

In the previous discussion [1] Cyril noted:

	The fact that memory mapped with PROT_EXEC is readable is an
	implementation detail for an architecture and not guaranteed. So the
	best result is either to expect that the child returns with 0 or dies
	with SIGSEGV, either one is correct behavior.

Therefore we don't need to check this for *any* specific architecture (e.g.
remove #if defined preprocessor wrap. And we should check either for 0 or
SIGSEGV, many tests do this, e.g. fstatfs/fstatfs02.c, clone/clone07.c.

> +	} else {
> +		tst_res(TFAIL, "Mapped memory region with NO "
> +			"access is accessible");
nit: Please no split strings (when they are reasonable long).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/Z7ykr8it7KmHjWsY@yuki.lan/

...
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
