Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71108C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 15:43:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C63963CEE6F
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:43:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EEAD3CD71B
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 16:43:10 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA5F41401221
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 16:43:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FD241FD7E;
 Tue, 23 Jan 2024 15:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706024588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qRP/dM+8T9qoS5PbYKwrhRsLHAVN6/fIz9nHw4frT5A=;
 b=y0pyf0Je6Rzee15o5/a7SIW4TK9JpF0em+H2t52tjSH1HWMd0J5EgM4NPA22tcbzI7x+DI
 OlUeXYr+rK3PWG4C4fPl0DhFuwAE6kGwy+rJVDlvCirmd6rVq0S817xm8mB57tlBIJSfqw
 iVM/Y67ywZjZ2mU9DDQd6psLQtDWdL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706024588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qRP/dM+8T9qoS5PbYKwrhRsLHAVN6/fIz9nHw4frT5A=;
 b=SdrXh4tJYS9gLBr5JDZVigmoaOUNZxuMyhSW1wgV17imDktMSsiNzXU4et9Gwhlg0zvuyx
 QJHa7MfefnUDX5Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706024588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qRP/dM+8T9qoS5PbYKwrhRsLHAVN6/fIz9nHw4frT5A=;
 b=y0pyf0Je6Rzee15o5/a7SIW4TK9JpF0em+H2t52tjSH1HWMd0J5EgM4NPA22tcbzI7x+DI
 OlUeXYr+rK3PWG4C4fPl0DhFuwAE6kGwy+rJVDlvCirmd6rVq0S817xm8mB57tlBIJSfqw
 iVM/Y67ywZjZ2mU9DDQd6psLQtDWdL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706024588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qRP/dM+8T9qoS5PbYKwrhRsLHAVN6/fIz9nHw4frT5A=;
 b=SdrXh4tJYS9gLBr5JDZVigmoaOUNZxuMyhSW1wgV17imDktMSsiNzXU4et9Gwhlg0zvuyx
 QJHa7MfefnUDX5Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7EC4136A4;
 Tue, 23 Jan 2024 15:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jnfcNYver2V7ewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 15:43:07 +0000
Date: Tue, 23 Jan 2024 16:43:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240123154305.GA201093@pevik>
References: <20240123132207.2646026-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240123132207.2646026-1-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.66 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.04)[59.06%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapoff01: make use of make_swapfile
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

Hi Li,

> This patch updates the swapoff01 test setup by replacing the previous
> swapfile creation method with a single call to make_swapfile, which
> now creates a contiguous swap file.

> This change simplifies the setup and fix failure on TMPDIR on btrfs.

> Note: it is a single fix but better applied with behind the libswap updates.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

This fixes issue on SLES. The only problem is that we makes swap partition much
smaller than before (e.g. we loose coverage of testing on big swap).

Kind regards,
Petr

> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/syscalls/swapoff/swapoff01.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
> index b27eecdad..f36f7f17c 100644
> --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> @@ -44,11 +44,8 @@ static void setup(void)
>  		tst_brk(TBROK,
>  			"Insufficient disk space to create swap file");

> -	if (tst_fill_file("swapfile01", 0x00, 1024, 65536))
> +	if (make_swapfile("swapfile01", 1))
>  		tst_brk(TBROK, "Failed to create file for swap");
> -
> -	if (system("mkswap swapfile01 > tmpfile 2>&1") != 0)
> -		tst_brk(TBROK, "Failed to make swapfile");
>  }

>  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
