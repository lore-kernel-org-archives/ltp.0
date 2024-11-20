Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D35D711CB
	for <ltp@archiver.kernel.org>; Wed, 20 Nov 2024 17:08:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAAFC3D923C
	for <ltp@archiver.kernel.org>; Wed, 20 Nov 2024 18:08:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 505173D922B
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 18:07:48 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E43D7BD0C8
 for <ltp@lists.linux.it>; Wed, 20 Nov 2024 18:07:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C0D421F7C4;
 Wed, 20 Nov 2024 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732122466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3eSQYYNcxObBB6KIHTthPx1YrX+ASykBYPNaSLP69Eo=;
 b=A3uBWMKvZUxvlBwsaj4R1KJP5LaGQEfpHoX9hC9Qm3QY6KSGzlShJVWTBxjgbHOdJirGmM
 DkV+7P2Gmlj9+Pp7vwgDPwSHAIG6QJsZU8NuzJGiqsjhYHEC/FuNYJdRrjC+uwRnrqdtFH
 P9i5NiGRJYzbv4asAd1RY+IOlYeQ6t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732122466;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3eSQYYNcxObBB6KIHTthPx1YrX+ASykBYPNaSLP69Eo=;
 b=Vjt/OkXVikTA/xoTpbxfWuYq3Z4GTaTWhvljyOzxOiw0LjnJx948XNmZsdOO2hYlCn9RYh
 IIfDzLPy/ERfDICw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732122464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3eSQYYNcxObBB6KIHTthPx1YrX+ASykBYPNaSLP69Eo=;
 b=MFnolcq5VEleKrBlTdRVDwgeDJ6xTBQhUguk3guUUVK9e8u1G/pIeObJkmHCpLZfFzZvTE
 YrTRz4VVBP0gs+KksBjUWb4TMqe51aW7e4RBMkmbM3GWuwNBR1U33Es5vhJ8WUm9eUveAF
 vlYZK9X86eUQhUTZEqwHHkEemfVJBzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732122464;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3eSQYYNcxObBB6KIHTthPx1YrX+ASykBYPNaSLP69Eo=;
 b=UKMFm9j3D+2G+fOYuW5tE6xRPr2wym0MrRzL+pNik1m155Yw0Sf3sQdjSogShOnMu3CsIv
 ugNfU+1Zx7mPeSCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8DB513297;
 Wed, 20 Nov 2024 17:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oHRPN18XPmeFYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 20 Nov 2024 17:07:43 +0000
Date: Wed, 20 Nov 2024 18:07:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20241120170738.GA38310@pevik>
References: <CAASaF6yd+FHWf8urwFbk6U6oTNnXhdR+CbGhWqq6DT+eKjeVfQ@mail.gmail.com>
 <7cdc48ed109ee67af12d0bc74eb32c0b7f862430.1732031092.git.jstancek@redhat.com>
 <CAASaF6xyu0kuOZ=PJTb+byWFFJ2U-ap3hdX-YTfDTLQYQgm0Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xyu0kuOZ=PJTb+byWFFJ2U-ap3hdX-YTfDTLQYQgm0Aw@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pkeys01: use a dummy function instead of
 function_size
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

Hi Jan,

...
> > This could be an alternative to reverting PKEY_DISABLE_EXECUTE test.
> > I haven't tested it yet on 32bit, but since it doesn't rely on any
> > instruction codes I don't expect it to break. An important test
> > would also be ppc64le.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
LGTM.

NOTE: we have hackweek this week, I guess you get Martin's feedback next week.

> I tested 32bit and ppc64le, both worked fine, so I propose we give this
> a consideration as alternative to Martin's revert.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
