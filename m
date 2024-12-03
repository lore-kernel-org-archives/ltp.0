Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F509E6C5FB
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 04:53:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EDEC3DDA9A
	for <ltp@archiver.kernel.org>; Tue,  3 Dec 2024 05:53:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 767BF3DDA7F
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 05:53:22 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 938DC62946F
 for <ltp@lists.linux.it>; Tue,  3 Dec 2024 05:53:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59F1D1F445;
 Tue,  3 Dec 2024 04:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733201598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KsSD6/gGZzrPhSalHZ6xisU7WTmNye1JLjt4MKbs9w=;
 b=Xe2gGOEHzocbi8bQVWzW4yT1K8vFuclOf9PV52jVyDqUQxKgSnoRhHR8I3w/6Vyc/f2eiu
 roW5+oVYliocj7IRWrKBP4bT0rW7SPLyfgIGfJu3dsvfgRXG2hK5LsHkETG4CrMA33nojf
 F/zOD1doeFnXqUqkTzoRrK7XKKyVMRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733201598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KsSD6/gGZzrPhSalHZ6xisU7WTmNye1JLjt4MKbs9w=;
 b=gmdcU+l4tgqLdYr+fwl10spRlSaa3CjgYRMKuO6CTgdI9MDiSFpuVxhGypD39l8X3ppXq6
 MFP/9MGc/I1YYADw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733201598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KsSD6/gGZzrPhSalHZ6xisU7WTmNye1JLjt4MKbs9w=;
 b=Xe2gGOEHzocbi8bQVWzW4yT1K8vFuclOf9PV52jVyDqUQxKgSnoRhHR8I3w/6Vyc/f2eiu
 roW5+oVYliocj7IRWrKBP4bT0rW7SPLyfgIGfJu3dsvfgRXG2hK5LsHkETG4CrMA33nojf
 F/zOD1doeFnXqUqkTzoRrK7XKKyVMRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733201598;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KsSD6/gGZzrPhSalHZ6xisU7WTmNye1JLjt4MKbs9w=;
 b=gmdcU+l4tgqLdYr+fwl10spRlSaa3CjgYRMKuO6CTgdI9MDiSFpuVxhGypD39l8X3ppXq6
 MFP/9MGc/I1YYADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A10C139C2;
 Tue,  3 Dec 2024 04:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XWMCDb6OTmceBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Dec 2024 04:53:18 +0000
Date: Tue, 3 Dec 2024 05:53:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241203045310.GA414034@pevik>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan> <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik> <Z03RB9JDmBVORPlf@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z03RB9JDmBVORPlf@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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
Cc: linux-btrfs@vger.kernel.org, Zorro Lang <zlang@kernel.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > It's a nice feature to be able to force testing on filesystem even it's set to
> > be skipped without need to manually enable the filesystem and recompile.
> > (It helps testing with LTP compiled as a package without need to compile LTP.)
> > Therefore I would avoid this.

> I guess that this should be another env variable e.g.
> LTP_FORCE_SINGLE_FS_TYPE and it should print a big fat warning that it's
> only for development purposes.

Well, LTP_SINGLE_FS_TYPE already has "Testing only" and that was the reason it
just forced filesystem regardless "skip" setup. Sure, we can turn it into
"normal" variable and introduce LTP_FORCE_SINGLE_FS_TYPE if it's needed.
But that would be an use case if anybody uses LTP really to test particular
filesystem. And it would affect only .all_filesystem tests (e.g. user's
responsibility would be to point TMPDIR to that particular system on non-
.all_filesystem tests).

@Zorro was it meant like this?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
