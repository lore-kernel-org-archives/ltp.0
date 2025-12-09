Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5ABD3B98D
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 17:57:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76A333D031E
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 18:57:58 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B06583CFF45
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 18:57:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D6B6C60082B
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 18:57:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B1E3337E8;
 Tue,  9 Dec 2025 17:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765303061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ay51YitQDinvNkRWn9/fbFnaHBh68fRyNp2i6bn9s8=;
 b=XmJNkO22S64G4L/dbei6NG+PSAbx79WeJSIXASFjNslN1eWqGfT0lg8eN560AGWElCqIis
 QgleV7i9tnnVN1MmGCNHZXA/Z/GFbi3WgH6MsuO2ONLEYMmHhny9X2FkRq/FQ1JveEuf7r
 5G2Q8kZnPncrcQFxcaQ6mU1aSyiIL3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765303061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ay51YitQDinvNkRWn9/fbFnaHBh68fRyNp2i6bn9s8=;
 b=/S+z42QtozJ7C8N4Ve1IWAgUyqIsT4UoKQN7USp7v+PHLUnI4XGTiRfAslde+/ELtC4I/C
 hPt3GP2MTk6VVmBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765303061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ay51YitQDinvNkRWn9/fbFnaHBh68fRyNp2i6bn9s8=;
 b=XmJNkO22S64G4L/dbei6NG+PSAbx79WeJSIXASFjNslN1eWqGfT0lg8eN560AGWElCqIis
 QgleV7i9tnnVN1MmGCNHZXA/Z/GFbi3WgH6MsuO2ONLEYMmHhny9X2FkRq/FQ1JveEuf7r
 5G2Q8kZnPncrcQFxcaQ6mU1aSyiIL3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765303061;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Ay51YitQDinvNkRWn9/fbFnaHBh68fRyNp2i6bn9s8=;
 b=/S+z42QtozJ7C8N4Ve1IWAgUyqIsT4UoKQN7USp7v+PHLUnI4XGTiRfAslde+/ELtC4I/C
 hPt3GP2MTk6VVmBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59B5E3EA63;
 Tue,  9 Dec 2025 17:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6bXyFBVjOGnkFAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 17:57:41 +0000
Date: Tue, 9 Dec 2025 18:57:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Juerg Haefliger <juerg.haefliger@canonical.com>
Message-ID: <20251209175740.GC9500@pevik>
References: <20251209155726.519179-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251209155726.519179-1-juerg.haefliger@canonical.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.986]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mkdir_tests.sh: Handle error message from mkdir
 from rust coreutils
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

Hi Juerg,

> mkdir from rust coreutils doesn't print the directory path. Account for
> that.

> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  testcases/commands/mkdir/mkdir_tests.sh | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/testcases/commands/mkdir/mkdir_tests.sh b/testcases/commands/mkdir/mkdir_tests.sh
> index c0a570e5c0e6..3bafbfdda7ba 100755
> --- a/testcases/commands/mkdir/mkdir_tests.sh
> +++ b/testcases/commands/mkdir/mkdir_tests.sh
> @@ -34,6 +34,9 @@ test2()

>  	if grep -q "$LONG_PATH.*No such file or directory" mkdir.out; then
>  		tst_res TPASS "Got correct error message"
> +	elif grep -q "mkdir: No such file or directory" mkdir.out; then
> +		# mkdir from rust coreutils doesn't print the directory path
> +		tst_res TPASS "Got correct error message"

I was thinking about using extended regular expressions to use a single check,
but it's more readable this way.

I wonder why rust folks did not want to follow coreutils in
this case.

Anyway, merged. Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
