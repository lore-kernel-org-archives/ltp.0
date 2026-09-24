Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A478C9830E
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 11:30:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A28AF3E64F2
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:30:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8A6F3E5C69
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:30:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2885B1001170
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:30:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F3F1200B4;
 Thu, 24 Sep 2026 11:30:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57CD813668;
 Thu, 24 Sep 2026 11:30:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4r1qCt0JtWrkJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 24 Sep 2026 11:30:37 +0000
Date: Thu, 24 Sep 2026 13:30:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260924113031.GE2364284@pevik>
References: <20260924095933.4183470-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260924095933.4183470-1-chrubis@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 8F3F1200B4
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_test: Clarify the .needs_abi_bit TCONF
 message
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

> The previous message was confusing. On 32bit machine sendfile09 tests
> that has .needs_abi_bits = 64 produced this message:

> tst_test.c:1493: TCONF: 64bit ABI is not supported

> This message is a bit confusing, since on 32bit x86 machine 64bit ABI
> is, of course, not supported, so why do we skip the test?

> After this patch the message is:

> tst_test.c:1493: Test needs 64bit ABI

> Which is, as far as I can tell, more clear.

+1, sure, merge before release.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Fixes: 56f63e54e5a3 ("lib: Add .needs_abi_bits")
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  lib/tst_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index ed3d26cad..e27a24c24 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1490,7 +1490,7 @@ static void do_setup(int argc, char *argv[])
>  		tst_brk(TCONF, "Not supported in 32-bit compat mode");

>  	if (tst_test->needs_abi_bits && !tst_abi_bits(tst_test->needs_abi_bits))
> -		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);
> +		tst_brk(TCONF, "Test needs %dbit ABI", tst_test->needs_abi_bits);

>  	if (tst_test->needs_cmds) {
>  		struct tst_cmd *pcmd = tst_test->needs_cmds;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
