Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7C8C021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:05:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D13C53C2A78
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 10:05:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A71B3C249C
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:05:40 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 75AA91BD86FC
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 10:05:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D605620539;
 Wed, 19 Feb 2025 09:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739955937;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4ObJj6Wl3AXyvrF5AtWfsZiIOxzosYm589tf0zIetM=;
 b=nLWy8kikP34y+WR2+8jTOf31l9/Zl1VuGlVx+18DwYEDrcA5hitKocP01jmIvdhejrFob8
 IXS8jYDpx7QYQ/JaNU3mUxMvSKhymet8+E4yd8pAXYrYMllE3slXj1p1DlE9b/lHqJYOsa
 XImYfSmnK4E2KiL2fDZeVyBOkIMixb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739955937;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4ObJj6Wl3AXyvrF5AtWfsZiIOxzosYm589tf0zIetM=;
 b=6xUl5LJiSgGzC8vTAOnfrZ3gyJJn8R2WUMlwbSMCcv7aE4Jk4mmOA9VhJGSwrGsdZvzxOJ
 Fsoii+TKgIpTLgDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739955937;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4ObJj6Wl3AXyvrF5AtWfsZiIOxzosYm589tf0zIetM=;
 b=nLWy8kikP34y+WR2+8jTOf31l9/Zl1VuGlVx+18DwYEDrcA5hitKocP01jmIvdhejrFob8
 IXS8jYDpx7QYQ/JaNU3mUxMvSKhymet8+E4yd8pAXYrYMllE3slXj1p1DlE9b/lHqJYOsa
 XImYfSmnK4E2KiL2fDZeVyBOkIMixb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739955937;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4ObJj6Wl3AXyvrF5AtWfsZiIOxzosYm589tf0zIetM=;
 b=6xUl5LJiSgGzC8vTAOnfrZ3gyJJn8R2WUMlwbSMCcv7aE4Jk4mmOA9VhJGSwrGsdZvzxOJ
 Fsoii+TKgIpTLgDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92DAB13A53;
 Wed, 19 Feb 2025 09:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TkPkIeGetWcqLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Feb 2025 09:05:37 +0000
Date: Wed, 19 Feb 2025 10:05:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250219090536.GB2544812@pevik>
References: <20250217020423.31602-1-wegao@suse.com>
 <20250218151858.GA2492575@pevik> <Z7WajlVc0xMSztSe@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z7WajlVc0xMSztSe@wegao>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount_setattr02.c: Check mount_setattr
 attr.propagation
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

> On Tue, Feb 18, 2025 at 04:18:58PM +0100, Petr Vorel wrote:
> > Hi Wei,

> > nit: I guess you want to replace dot with space in subject.
> You mean i s/attr.propagation/attr propagation ?

Yes.

...
> > > +#define DIRA "/DIRA_PROPAGATION_CHECK"

> > Is it necessary to to use directory under root?
> Yes. Otherwise failed will happen during mount_setattr.
> But i have not check for detail.

Ideally we would create files in TMPDIR. Specially if bug in the code leave
/DIRA_PROPAGATION_CHECK kept.

> > ...
> > > +static void cleanup(void)
> > > +{

> > I guess this is due result of:
> > SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> > There should be either a proper detection whether this works or 

> > ../../../../include/lapi/fsmount.h:113: TCONF: syscall(442) __NR_mount_setattr not supported on your arch
> > mount_setattr02.c:52: TWARN: rmdir(/DIRA_PROPAGATION_CHECK) failed: EBUSY (16)


> > > +	SAFE_RMDIR(DIRA);

> > When running on old kernel (e.g. SLES based 4.12) it fails due TCONF:

> > ../../../../include/lapi/fsmount.h:197: TCONF: Test not supported on kernel version < v5.2
> > mount_setattr02.c:52: TWARN: rmdir(/DIRA_PROPAGATION_CHECK) failed: ENOENT (2)

> > There should be a flag to remove dir only when it was created.

> > > +
> > nit: please remove this new line (I have to keep asking this :( ).
> Sorry, i need pay attention, thanks for point this out with great patient :).

Thank you, not a big deal :).

...
> > + I later create generic helper from is_shared_mount().
> I sent v2 patch now, once your create generic helper i can do another patch together with
> your generic helper.

Sure, it should not block your work on the test.

Kind regards,
Petr

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
