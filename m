Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE66E6748D
	for <ltp@archiver.kernel.org>; Mon, 22 Dec 2025 08:00:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3E7C3D066C
	for <ltp@archiver.kernel.org>; Mon, 22 Dec 2025 09:00:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7A733CC50D
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 09:00:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ABB87600742
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 09:00:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 69C5B3369F;
 Mon, 22 Dec 2025 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766390415;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBv01iLQTXJfYJ52hPOh3BRIUQxGCWcZDCWQkcgI0yw=;
 b=R62fyuHSkV5MvB2gcrx1e+0JIFQHr7Ytwyq0KDbP7igAMecqh/hIryp3sbPUTmuKCI3R94
 pmqwVQKqAOc4cDAl8UX/6TJYBCgHsl+CDinHq7HTHI+gGvUDvgINRjLf/niLbMQBkc07WX
 bcWXVpU+mmrG+Z9r1Awdrn4tdWnOoMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766390415;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBv01iLQTXJfYJ52hPOh3BRIUQxGCWcZDCWQkcgI0yw=;
 b=t9wYPYdggP9kmfaQg2f5mAGnkN3631f4Kk+yP4HRSQJAjyYze9EXqkA99gtMZve4MzvH4d
 MPsCo9D9FzJ927Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=R62fyuHS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=t9wYPYdg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766390415;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBv01iLQTXJfYJ52hPOh3BRIUQxGCWcZDCWQkcgI0yw=;
 b=R62fyuHSkV5MvB2gcrx1e+0JIFQHr7Ytwyq0KDbP7igAMecqh/hIryp3sbPUTmuKCI3R94
 pmqwVQKqAOc4cDAl8UX/6TJYBCgHsl+CDinHq7HTHI+gGvUDvgINRjLf/niLbMQBkc07WX
 bcWXVpU+mmrG+Z9r1Awdrn4tdWnOoMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766390415;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBv01iLQTXJfYJ52hPOh3BRIUQxGCWcZDCWQkcgI0yw=;
 b=t9wYPYdggP9kmfaQg2f5mAGnkN3631f4Kk+yP4HRSQJAjyYze9EXqkA99gtMZve4MzvH4d
 MPsCo9D9FzJ927Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B45A3EA63;
 Mon, 22 Dec 2025 08:00:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qDfcDI/6SGlwPAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Dec 2025 08:00:15 +0000
Date: Mon, 22 Dec 2025 08:59:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20251222075958.GA69608@pevik>
References: <20251219094219.151887-1-pvorel@suse.cz>
 <aUUteQjVmMx1R_X9@yuki.lan> <20251219140216.GA247368@pevik>
 <20251219144102.GA325483@pevik>
 <CAEemH2f2nhCBzxw-5u5qGnDS9BcogD-KWOd+mrOoLvmJ0XPR9w@mail.gmail.com>
 <CAEemH2dts8FsEAM7gfKQjSv3ohkVehy9fXSf09_bqLfoDnUf1g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dts8FsEAM7gfKQjSv3ohkVehy9fXSf09_bqLfoDnUf1g@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 69C5B3369F
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/1] swapon03: Try to swapon() as many files
 until it fails
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

> > is_swap_supported():


> Or, naming it as is_swapfile_supported().

Thanks a lot for a great summary. Could we merge the above with just tst_brk()?
Or you'd prefer tst_res() and break?
And I'll do cleanup in beginning of January?
Of course I can send the change as a v5 patch.

Kind regards,
Petr

+++ testcases/kernel/syscalls/swapon/swapon03.c
@@ -53,7 +53,7 @@ static int setup_swap(void)
 			if (errno == EPERM && swapfiles > min_swapfiles)
 				break;
 
-			tst_res(TFAIL | TERRNO, "swapon(%s, 0)", filename);
+			tst_brk(TFAIL | TERRNO, "swapon(%s, 0)", filename);
 		}
 		swapfiles++;
 	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
