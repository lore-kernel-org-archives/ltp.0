Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D648606A31C
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=viZJiwjF;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xGZavjQh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=viZJiwjF;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xGZavjQh
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F8283E60DF
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 12:02:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 986E33CFD9C
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 12:02:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D1C9B600931
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 12:02:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0FAFC1F444;
 Fri, 30 Oct 2026 11:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793358160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBtP3L+Ng3GGP5KK9hFHNehn9EWOIKxU4sB1fMR3b2A=;
 b=viZJiwjFrp8hNLKKKSRLsspTOWqNtf7wrK3xRa9G6WK/wGb4a1t2EF4b8R9/x8s4Wl53Nr
 UFKce1XqaYkFIyKQd35LM1fTzCbUqqhZWneIZuLzI9g/t0/HIMMLB5T60MzA2i4FNGMrvO
 eSnUz3ulyrE9IhgAREiawxDzTlzbCl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793358160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBtP3L+Ng3GGP5KK9hFHNehn9EWOIKxU4sB1fMR3b2A=;
 b=xGZavjQhu50on++6QU1N3shwW17ZgTXxHX/XjFFBSEa7b1qFQXsVryuk+2dNL2Ug+GKHx2
 1chzFGi10ywLBbDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793358160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBtP3L+Ng3GGP5KK9hFHNehn9EWOIKxU4sB1fMR3b2A=;
 b=viZJiwjFrp8hNLKKKSRLsspTOWqNtf7wrK3xRa9G6WK/wGb4a1t2EF4b8R9/x8s4Wl53Nr
 UFKce1XqaYkFIyKQd35LM1fTzCbUqqhZWneIZuLzI9g/t0/HIMMLB5T60MzA2i4FNGMrvO
 eSnUz3ulyrE9IhgAREiawxDzTlzbCl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793358160;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBtP3L+Ng3GGP5KK9hFHNehn9EWOIKxU4sB1fMR3b2A=;
 b=xGZavjQhu50on++6QU1N3shwW17ZgTXxHX/XjFFBSEa7b1qFQXsVryuk+2dNL2Ug+GKHx2
 1chzFGi10ywLBbDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78FC1132C9;
 Fri, 30 Oct 2026 11:02:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J+csCk955Gr6PwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 11:02:39 +0000
Date: Fri, 30 Oct 2026 12:02:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20261030110233.GA66190@pevik>
References: <P58XUlU--F-9@tuta.io>
 <CAOQ4uxitKA16-3Ka7YrL-ktf4mCa6Ljh9Lb3Fu6R+SATeSWo2g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxitKA16-3Ka7YrL-ktf4mCa6Ljh9Lb3Fu6R+SATeSWo2g@mail.gmail.com>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_EQ_ADDR_SOME(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3][STAGING] syscalls/fanotify26: Add test for
 nested permission events
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Edvard Conrad <edvard@tuta.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Edvard, Amir,

> > The kernel creates the file descriptor it reports with a permission
> > event by an open that must not generate further events. When the
> > reported path is on a stacked filesystem, that open opens the real file
> > on the backing filesystem, and since commit ebe559609d78 ("fs: get rid
> > of __FMODE_NONOTIFY kludge") the backing file no longer inherits
> > FMODE_NONOTIFY. A listener that also watches the backing filesystem is
> > then sent a second permission event from inside its own read(2), which
> > only the listener itself can answer, so a single reader never returns.

> > Verify that a listener returns from read(2) and answers an open
> > permission event for a file on an overlayfs mount. The first test case
> > marks the overlay only and passes on any kernel, the second one also
> > marks the backing filesystem, which is the shape an anti-malware
> > scanner uses on an overlayfs root.

> > The second case fails on a kernel without the pending fix "fs: let
> > backing files inherit FMODE_NONOTIFY from the user file", so the test
> > is added to runtest/staging for now.

> > Link: https://lore.kernel.org/all/P58Wrer--F-9@tuta.io/

> > Signed-off-by: Edvard Conrad <edvard@tuta.io>
> > ---
> > v2: https://lore.kernel.org/ltp/P50G-yE--F-9@tuta.io/

> > v3:
> > - Scale both process-state waits through tst_multiply_timeout(). The
> >   library scales all of its own deadlines, so on a KASAN or lockdep
> >   kernel a healthy but unscheduled listener was reported as blocked.
> > - Report TFAIL, not TBROK, for an unexpected event mask, and check the
> >   event's pid, following fanotify03.c. Answer the event either way, or
> >   the opener stays parked in the kernel.

+1.  I first thought wrong mask would be kind of fatal (i.e. to be fixed also in
fanotify03.c), but double checking it looks to be a normal error when test can
continue.

LGTM, I'll merge it in few hours.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > - Probe FAN_CLASS_CONTENT + FAN_MARK_FILESYSTEM + FAN_OPEN_PERM with
> >   REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(), the combination run()
> >   actually uses. The two previous probes checked neither class nor mask.
> > - Use SAFE_READ_ALL rather than a literal 1, matching SAFE_WRITE_ALL.
> > - Drop the explicit SAFE_WAITPID() for the opener. tst_reap_children()
> >   runs after every iteration and checks the exit status this discarded.
> > - Drop three unused includes.

> > Amir's Reviewed-by from v2 is not carried over: the failure reporting
> > and the support probe changed since, so it needs a fresh look.

> Still looks good

> Reviewed-by: Amir Goldstein <amir73il@gmail.com>


> > Not changed: the [STAGING] keyword stays in the patch subject rather
> > than the commit subject, which is the form ground_rules.rst documents.
> > Answered on the v2 thread.

Sure.

> > Tested on mainline v7.3-16259-g6b4b543fa18 with and without the pending
> > fix: both cases pass with it, and the second fails without it.

FYI Once we get kernel fix in Linus' tree we add it into "linux-git" tag and
move test into runtest/syscalls. Please send then a follow up patch (or Cc me
with info it got merged and I can do it).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
