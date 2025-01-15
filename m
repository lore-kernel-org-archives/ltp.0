Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99794C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 11:09:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24D413C7B7A
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:09:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB51B3C7B2B
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:09:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0F0346305E9
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:09:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F7EA2127B;
 Wed, 15 Jan 2025 11:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736939350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mM57Bh6CRtjPIjOZiYtpFa4tDn1VgMJyrurTpemOTV8=;
 b=dqApISD2xqZgGrINH4KXw/ITMY94kP3Xtui8/6AQ+OHhBvQtWFz+DKnTHNY6ov3+dowC4v
 AVRG/zIFYCLshlEANFjiLu7PMgAVCnkzcqovq7ledsosj2CFfArW15wEM1Myhcb0lq4f2c
 ef/33U4yx3Ru9HEFxcoudJmlU/f4t9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736939350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mM57Bh6CRtjPIjOZiYtpFa4tDn1VgMJyrurTpemOTV8=;
 b=SUYdDYwuRucZ9NiboR4gA4oBtNXEt+ma+G9ixaa2pPn9ZqMynEMWSsNNRnqft6aBMsehB5
 N8GY1ErE6FpcoMAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vbAzuqqm;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=76BCr3tX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736939349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mM57Bh6CRtjPIjOZiYtpFa4tDn1VgMJyrurTpemOTV8=;
 b=vbAzuqqm675uJwfpEdlbTu2qEBlWuA2+pB42B7c+iirNmeIuVJXU6sObzyb9Jo5JfwEiJ5
 s8UPIVAsCeLSe3DSwtPqMjiqetNAXe4Ly5KTBbvfGq92gbnZIq5Em7sLSyJgHc4xeSNIkN
 /dWI6sJFV7JG8LQG5z3kFflo7UnlKdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736939349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mM57Bh6CRtjPIjOZiYtpFa4tDn1VgMJyrurTpemOTV8=;
 b=76BCr3tXz0osIoWdWJ7Z9OAErnpwjmFekHP8e6ZFBc0ZBLLON6ulkCmDtS5UPK0bjNO6Se
 2Wnv7b0eJbVz+pBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6601213A6F;
 Wed, 15 Jan 2025 11:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l7DwF1WXh2frNAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 15 Jan 2025 11:09:09 +0000
Date: Wed, 15 Jan 2025 12:08:55 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z4eXR-VoAjnc20cm@yuki.lan>
References: <20241211001418.392890-1-pvorel@suse.cz>
 <Z4eVyQM2kiYrz3f8@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4eVyQM2kiYrz3f8@yuki.lan>
X-Rspamd-Queue-Id: 7F7EA2127B
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, tst_test.sh:url, suse.cz:dkim,
 suse.cz:email, imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns,
 linux.it:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> commit 55bfa08e179de16773f19b703de70262896383ea
> Author: Petr Vorel <pvorel@suse.cz>
> Date:   Thu Dec 14 15:00:10 2023 +0100
> 
>     tst_test.sh/tst_brk(): Convert only TBROK to TWARN in cleanup
> 
> 
> The original code only only depended on TST_DO_EXIT being set. I guess
> that the easiest fix here would be actually to revert that patch. That
> is because we mostly call the cleanup from _tst_do_exit() which sets the
> TST_DO_EXIT before it calls _tst_do_cleanup(). The only place where we
> call _tst_do_cleanup() wihout the TST_DO_EXIT is inside of the
> _tst_run_iterations(), if we wanted to convert TBROK to TWARN in that
> case we can simply do:
> 
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index cfdae0230..ac1caebcb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -820,6 +820,7 @@ _tst_run_iterations()
>                 _tst_i=$((_tst_i-1))
>         done
> 
> +       TST_DO_EXIT=1
>         _tst_do_cleanup

And of course add:
	unset TST_DO_EXIT
after the cleanup.

>         if [ "$TST_MOUNT_FLAG" = 1 ]; then
> 
> 
> And possibly change the TST_DO_EXIT to TST_TBROK_TO_TWARN as well.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
