Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACE8C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:41:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F30AF3C7B78
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 13:41:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D0DC3C7A53
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:41:23 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B1DC1425597
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 13:41:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 56CBE2192D;
 Wed, 15 Jan 2025 12:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736944882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lx1IoHPNbpKEku90KOAc8/SHtiSpkvtkvL98am4cWkc=;
 b=0pAT0wJTPTaRKGejveiWW4+ljtxOGGRencpTSfQdMOF8Ih7lRDyxA5kbL8fdVsfFRfFlH4
 mXFnpU3At0qAZ69oKYeq/4etxr5BZ0iTVKuFWDlJamg9Nfg03ZZ47KKYcrUUCjKPMMNYc9
 DaOXxFPsXa7vdTgXBhL4EriBLPwaeX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736944882;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lx1IoHPNbpKEku90KOAc8/SHtiSpkvtkvL98am4cWkc=;
 b=aKNr6QS6z9o0oS+UVeS0PFeTL6o72X/pQviP3EdoOiAZ0iVkxMolgpEgs4gk3Sl5M6LGbM
 mwMPvnfztgpTz9AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736944881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lx1IoHPNbpKEku90KOAc8/SHtiSpkvtkvL98am4cWkc=;
 b=i4ATWifKjzHGmRFmdjJmN+jDG4DEQf6V2AHYDysWYq09BTtFd2YZz6cU4oLdILLx+uPDrS
 EcTfpSOcrRAsxqywJa1FO/wumFCM4JFupwF5X90CAbNcqAX0OMcXLsaSPXiCk25zFXqI0m
 6rpLnRLGbKqLVMBsS5DuihtS0fa33Pc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736944881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lx1IoHPNbpKEku90KOAc8/SHtiSpkvtkvL98am4cWkc=;
 b=8bqhU96YAZwTSCKrpsIRL6eOl91zTLbBindsXn10SJSU2AGnl0l4kFlzxbKJVa0Yez5poS
 00j/RLo/YyXDr1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3503113A6F;
 Wed, 15 Jan 2025 12:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fx3zC/Gsh2dyUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 Jan 2025 12:41:21 +0000
Date: Wed, 15 Jan 2025 13:41:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250115124115.GB648257@pevik>
References: <20241211001418.392890-1-pvorel@suse.cz>
 <Z4eVyQM2kiYrz3f8@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4eVyQM2kiYrz3f8@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Fix TBROK => TWARN evaluation
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

> Hi!
> This I suppose got broken in:

> commit 55bfa08e179de16773f19b703de70262896383ea
> Author: Petr Vorel <pvorel@suse.cz>
> Date:   Thu Dec 14 15:00:10 2023 +0100

FYI it was broken by 5c36ae3e30 ("tst_test.sh: Call cleanup function only after
test start") (much earlier than 55bfa08e17).

>     tst_test.sh/tst_brk(): Convert only TBROK to TWARN in cleanup


> The original code only only depended on TST_DO_EXIT being set. I guess
> that the easiest fix here would be actually to revert that patch. That
> is because we mostly call the cleanup from _tst_do_exit() which sets the
> TST_DO_EXIT before it calls _tst_do_cleanup(). The only place where we
> call _tst_do_cleanup() wihout the TST_DO_EXIT is inside of the
> _tst_run_iterations(), if we wanted to convert TBROK to TWARN in that
> case we can simply do:

> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index cfdae0230..ac1caebcb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -820,6 +820,7 @@ _tst_run_iterations()
>                 _tst_i=$((_tst_i-1))
>         done

> +       TST_DO_EXIT=1
>         _tst_do_cleanup

OK, you would revert 55bfa08e179de16773f19b703de70262896383ea + use variable as
guard here (TST_TBROK_TO_TWARN or whatever name it uses).

I'll try to test it. BTW I remember in the past there were problems when setup
got tst_brk TCONF, which calls the cleanup.

Kind regards,
Petr

>         if [ "$TST_MOUNT_FLAG" = 1 ]; then


> And possibly change the TST_DO_EXIT to TST_TBROK_TO_TWARN as well.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
