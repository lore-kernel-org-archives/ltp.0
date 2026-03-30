Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1764A1061B07
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 14:59:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDEF13E5717
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 16:59:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 098093E2344
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 16:58:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 620BD1A00704
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 16:58:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E2FA5BD10;
 Mon, 30 Mar 2026 14:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774882737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vgn4Bw0E3toXGKDAPLOD9M6CyJs83aiPTBrTu6rcVio=;
 b=a4Jxuoha6F9G20GN/DJ2j3+aH+CtbCMEpOd2lq9lexpuT4CjccS9hJPXOVSlpSrFtE72AF
 zCWbZf50vBLxqfMfeFefUjL9bPSrsq+6pNbgYDJJYCRVWcBQf1NV6thUbm1vX5A1rNQUQO
 YbXVyeWT1sF7/pHBA8lDXsxiBRjqENs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774882737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vgn4Bw0E3toXGKDAPLOD9M6CyJs83aiPTBrTu6rcVio=;
 b=pJhYaoZEjKTZS+9Isb/Xhf1FiSsfdwdKlSx6DaGBdm1QJ9gVF8danklOcXDVrGqv1VBkHj
 yTVV+j5N1fogCKDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=a4Jxuoha;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pJhYaoZE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774882737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vgn4Bw0E3toXGKDAPLOD9M6CyJs83aiPTBrTu6rcVio=;
 b=a4Jxuoha6F9G20GN/DJ2j3+aH+CtbCMEpOd2lq9lexpuT4CjccS9hJPXOVSlpSrFtE72AF
 zCWbZf50vBLxqfMfeFefUjL9bPSrsq+6pNbgYDJJYCRVWcBQf1NV6thUbm1vX5A1rNQUQO
 YbXVyeWT1sF7/pHBA8lDXsxiBRjqENs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774882737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vgn4Bw0E3toXGKDAPLOD9M6CyJs83aiPTBrTu6rcVio=;
 b=pJhYaoZEjKTZS+9Isb/Xhf1FiSsfdwdKlSx6DaGBdm1QJ9gVF8danklOcXDVrGqv1VBkHj
 yTVV+j5N1fogCKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C5D84A0A2;
 Mon, 30 Mar 2026 14:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZHBkIbGPymk+egAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 30 Mar 2026 14:58:57 +0000
Date: Mon, 30 Mar 2026 16:58:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acqPsJkCQXlH9gx5@yuki.lan>
References: <20260326125216.159239-1-pvorel@suse.cz>
 <acYYc47HXGYa5Mqj@redhat.com> <20260327090505.GA40147@pevik>
 <acaDd9VjQX-FtCkb@yuki.lan> <acaDztrhBMninsBV@yuki.lan>
 <20260327151741.GA1092845@pevik> <acarQ7I8FUNNtDpg@yuki.lan>
 <20260327164459.GA1097030@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327164459.GA1097030@pevik>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E2FA5BD10
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd03.c: Require kernel 6.1
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
> > > > > > Nothing besides trying to fix 6.11 (which was not the case) and trying to
> > > > > > simplify. But whole effort is somehow relevant to general checking test
> > > > > > requirements cleanup (we had a discussion runtime checks vs. kconfig/min_kver
> > > > > > which resulted in Cyril's "lib: tst_kconfig: Add runtime checks" [2]).
> 
> > > > > I guess that the check for all userfaultfd tests should be moved to the
> > > > > tst_kconfig.c once my patch that adds runtime checks there is in.
> 
> > > > Or I can send a V3 that adds that check as well.
> 
> > > Sure, having /dev/userfaultfd in kconfig check would be a benefit. Thanks!
> 
> > However it looks like we cannot do that, the /dev/userfaultfd was added
> > into 6.1 while the usefaultfd syscall existed since 4.3. Hence tests
> > that need /dev/userfaultfd need additional checks.
> 
> We require for userfaultfd05.c also CONFIG_HAVE_ARCH_USERFAULTFD_WP=y.
> Maybe bound /dev/userfaultfd check to it?  OTOH
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=y is much older (v5.19-rc1) and original commit
> in 6.1 [1] does not refer to it.

Does not work either, the /dev/userfaultfd was added without any changes
in CONFIG. If we wanted this as generic funcitionality we would have to
add .needs_devices field into tst_test structure but as far as I my
grepping shows, usefaultfd is at the moment the only test that depends
on a device that has been added recently so it does not look like
it's worth the trouble.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
