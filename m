Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F02EB64DE
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 13:17:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A82B43C1B3F
	for <ltp@archiver.kernel.org>; Tue, 10 Sep 2024 15:17:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47B633C1A29
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 15:16:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 52D1B601544
 for <ltp@lists.linux.it>; Tue, 10 Sep 2024 15:16:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A8DAE1F812;
 Tue, 10 Sep 2024 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725974212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kT383BI5tImCHtN3JRXQPsKuuBGw8GNHZ+VGH23T+tU=;
 b=nmsbmfs5ZS/XIgyCa782O009dcA8U8fRztgl8dAYbpIEPRBGNRRG8IV2iBw63R//yjWrmK
 p9aRaO/Ty7rmWvluKuF1Bc2MeNzZigZ4+ZFKMfxvxCtAhubDK3I/ybt7366eKkSB4OSnF2
 8Yy7tFwGay8kUBZhvE34nMFLJdD+0Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725974212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kT383BI5tImCHtN3JRXQPsKuuBGw8GNHZ+VGH23T+tU=;
 b=rY6Ij8ZQhcuQzXGwGIgWpUbpUTaRnmrLuFj5oPJ1R32Q0yyrBA9bUpmBzQXA7LCnahWNLF
 FASVJWCE607xPrDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nmsbmfs5;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rY6Ij8ZQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725974212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kT383BI5tImCHtN3JRXQPsKuuBGw8GNHZ+VGH23T+tU=;
 b=nmsbmfs5ZS/XIgyCa782O009dcA8U8fRztgl8dAYbpIEPRBGNRRG8IV2iBw63R//yjWrmK
 p9aRaO/Ty7rmWvluKuF1Bc2MeNzZigZ4+ZFKMfxvxCtAhubDK3I/ybt7366eKkSB4OSnF2
 8Yy7tFwGay8kUBZhvE34nMFLJdD+0Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725974212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kT383BI5tImCHtN3JRXQPsKuuBGw8GNHZ+VGH23T+tU=;
 b=rY6Ij8ZQhcuQzXGwGIgWpUbpUTaRnmrLuFj5oPJ1R32Q0yyrBA9bUpmBzQXA7LCnahWNLF
 FASVJWCE607xPrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AF3013A3A;
 Tue, 10 Sep 2024 13:16:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ydG8JMRG4GYNGgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 10 Sep 2024 13:16:52 +0000
Date: Tue, 10 Sep 2024 15:15:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZuBGfgODoO6-NZD4@yuki.lan>
References: <20240830132905.14902-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830132905.14902-1-andrea.cervesato@suse.de>
X-Rspamd-Queue-Id: A8DAE1F812
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] Refactor fork05 using new LTP API
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

Hi!
> +/*\
> + * [Description]
>   *
> - * http://www.sgi.com$
> + * This test verifies that LDT is propagated correctly from parent process to
> + * the child process.
>   *
> - * For further information regarding this notice, see:$
> + * On Friday, May 2, 2003 at 09:47:00AM MST, Ulrich Drepper wrote:
> + *  Robert Williamson wrote:
>   *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> + *  I'm getting a SIGSEGV with one of our tests, fork05.c, that apparently
> + *  you wrote (attached below).  The test passes on my 2.5.68 machine running
> + *  SuSE 8.0 (glibc 2.2.5 and Linuxthreads), however it segmentation faults on
> + *  RedHat 9 running 2.5.68.  The test seems to "break" when it attempts to run
> + *  the assembly code....could you take a look at it?
>   *
> + *  There is no need to look at it, I know it cannot work anymore on recent
> + *  systems.  Either change all uses of %gs to %fs or skip the entire patch
> + *  if %gs has a nonzero value.
>   *
> - *    Linux Test Project - Silicon Graphics, Inc.
> - *    TEST IDENTIFIER	: fork05
> - *    EXECUTED BY	: anyone
> - *    TEST TITLE	: Make sure LDT is propagated correctly
> - *    TEST CASE TOTAL	: 1
> - *    CPU TYPES		: i386
> - *    AUTHORS		: Ulrich Drepper
> - *			  Nate Straz
> + * On Sat, Aug 12, 2000 at 12:47:31PM -0700, Ulrich Drepper wrote:

You need an empty line here in order for the next block to render
correctly. Have you checked the metadata.html?

> + *  Ever since the %gs handling was fixed in the 2.3.99 series the
> + *  appended test program worked.  Now with 2.4.0-test6 it's not working
> + *  again.  Looking briefly over the patch from test5 to test6 I haven't
> + *  seen an immediate candidate for the breakage.  It could be missing
> + *  propagation of the LDT to the new process (and therefore an invalid
> + *  segment descriptor) or simply clearing %gs.
>   *

...

> +	if (WIFSIGNALED(status))
> +		tst_res(TFAIL, "Child crashed with %s", tst_strsig(WTERMSIG(status)));

I suppose we should fail the test unless the child returned with 0. I.e.

	if (WIFEXITTED(status) && WEXITSTATUS(status))
		tst_res(TPASS, "Child did exit with 0");
	else
		tst_res(TFAIL, "Child %s", tst_strstatus(status));


Other than these two minor things:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
