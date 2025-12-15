Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCDDD41D74
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 08:00:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0B2D3CF82C
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 09:00:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 519343C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 08:59:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF61B1400252
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 08:59:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D7FE5BD19;
 Mon, 15 Dec 2025 07:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765785580;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8iRfQt29fevf3kpfG2cCu8y4N2TnKWn7JngacsRbbRk=;
 b=NuOuYurNb9rBIpeVtpXolAoETOt7t4NZ/hFpSA6GrmvhvcJeWSsx3yd7WJ1yEWqKN1g+By
 9Ol/mV4W6zt5Vy6iaBlkuhoPc1IbLmw9m2wozPvUbZDYtD2ao8lNjFZhdamJtFbYyjoCjc
 6HTfB8P7estsKkuNM/GJ75x+YSYrK4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765785580;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8iRfQt29fevf3kpfG2cCu8y4N2TnKWn7JngacsRbbRk=;
 b=prICrtsZyy0I0V7b416B63/8z/obq6SNTxFsdmYbN9s7hK492UaT8rT7drvGB9R4xBOk04
 MqsjN12Mq42V8bBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765785579;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8iRfQt29fevf3kpfG2cCu8y4N2TnKWn7JngacsRbbRk=;
 b=RJ+iOenRDOl2s03hy1soj88SUkzbPEe+oLPbo1WuJ/Aa+xaHdQwYX1kDXYBNdEtejQVbV1
 sUrkE5o0ki0/xDjri0rBhKn5CjdYgAn7aa/APLDZ6KoLnDbHnACtalWyGbQXSvIQaU+kAA
 /WDSBzwogcywYRpew/UhcLpf1YqwZOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765785579;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8iRfQt29fevf3kpfG2cCu8y4N2TnKWn7JngacsRbbRk=;
 b=ZH6RAz6ncY7V95Lj4n70H1/VI6Nyi3raYd0fJBYyr4CI9N7m7aMLtxkKiLli8/Smw/OMW2
 cff8MvdmLp7xrhBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E60503EA63;
 Mon, 15 Dec 2025 07:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p/3MNuq/P2lbPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 07:59:38 +0000
Date: Mon, 15 Dec 2025 08:59:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Changwei Zou <changwei.zou@canonical.com>
Message-ID: <20251215075922.GA233529@pevik>
References: <20251214060640.41555-1-changwei.zou@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251214060640.41555-1-changwei.zou@canonical.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,canonical.com:email,suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] splice07: require kernel version 5.10
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

Hi Changwei,

> On Linux kernel 5.9, the splice07 test fails as follows:

>   Running tests.......
>   tst_fd.c:260: TCONF: Skipping memfd secret: ENOSYS (38)
>   splice07.c:64: TINFO: directory -> ...
>   splice07.c:56: TPASS: splice() on directory -> file : EINVAL (22)
>   splice07.c:56: TPASS: splice() on directory -> O_PATH file : EBADF (9)
>   splice07.c:56: TPASS: splice() on directory -> directory : EBADF (9)
>   splice07.c:56: TPASS: splice() on directory -> /dev/zero : EBADF (9)
>   splice07.c:56: TPASS: splice() on directory -> /proc/self/maps : EBADF (9)
>   splice07.c:56: TPASS: splice() on directory -> pipe read end : EBADF (9)
>   splice07.c:56: TFAIL: splice() on directory -> pipe write end expected EBADF, EINVAL: EISDIR (21)
>   ...
>   splice07.c:64: TINFO: pipe read end -> ...
>   splice07.c:56: TPASS: splice() on pipe read end -> O_PATH file : EBADF (9)
>   splice07.c:56: TPASS: splice() on pipe read end -> directory : EBADF (9)
>   splice07.c:56: TPASS: splice() on pipe read end -> /dev/zero : EBADF (9)
>   splice07.c:56: TPASS: splice() on pipe read end -> /proc/self/maps : EBADF (9)
>   splice07.c:56: TPASS: splice() on pipe read end -> pipe read end : EBADF (9)
>   Test timeouted, sending SIGKILL!
>   tst_test.c:1918: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
>   tst_test.c:1920: TBROK: Test killed! (timeout?)

>   Summary:
>   passed   121
>   failed   1
>   broken   1
>   skipped  5
>   warnings 0
>   INFO: ltp-pan reported some tests FAIL
>   LTP Version: 20250930-60-gb446dd4ed

> This test passes on kernel versions 5.10 and later.

IMHO this is wrong. Older kernels are broken, and this would hide they are
buggy. That's the reason why the related issue was closed [1].
The correct way in ideal world would be to fix the kernel (but that would
require nontrivial backports).

FYI we have rule "Do not work around kernel bugs" (the doc is not yet
merged [2], but will be soon to be visible in docs [3]) and this would violate
it.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/1156
[2] https://lore.kernel.org/ltp/20251209120246.18435-1-chrubis@suse.cz/
[3] https://linux-test-project.readthedocs.io/

> Signed-off-by: Changwei Zou <changwei.zou@canonical.com>
> ---
>  testcases/kernel/syscalls/splice/splice07.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
> index c750a14bf..10206514f 100644
> --- a/testcases/kernel/syscalls/splice/splice07.c
> +++ b/testcases/kernel/syscalls/splice/splice07.c
> @@ -69,4 +69,5 @@ static void verify_splice(void)

>  static struct tst_test test = {
>  	.test_all = verify_splice,
> +	.min_kver = "5.10",
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
