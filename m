Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8B9C55175
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 09:45:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 495AF3E62BB
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:45:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92ABE3C0169
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:44:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D645660029C
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 11:44:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75BD87EFE3;
 Mon,  3 Aug 2026 09:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785750291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDrmJr7+dYyv4L9GA3jwJ0YVbhk2IAdV3OqNccHofsg=;
 b=h+fi9E/qbPzFVnaNvGp9XPuHvEXs+KxILOCfoRXIk40LGyxHo8aCJNefKGfmZyNqSSs+3q
 wpImaVn0eauP/U8M8uK6LtY2eW3ZceTPXp9zwT3MGLNquC5SwOmT1mwZAcctr0fYkGoI4p
 Ft0AfSnDMNCqcfDaJbOMl6XChZmHrqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785750291;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDrmJr7+dYyv4L9GA3jwJ0YVbhk2IAdV3OqNccHofsg=;
 b=Bic6e3Bt4HfCe0wayKupmOQq1Gvrl/pfBKpyINpdnH9LF+TUI75NeOhLr4+hGqv8RSfAKZ
 9fjTrDLcm7ABOwDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785750287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDrmJr7+dYyv4L9GA3jwJ0YVbhk2IAdV3OqNccHofsg=;
 b=QdsA4UEXdNGyxUkozvSsddEni/8RoMDKZC0XXaDjDp71ymSi5OY8GksIZtI8CCaufYzpwE
 VOIzxBZ3pjU1F/Hd9OCctgubLSw5qyvCrUqT32Fl39gBUSfCUMifcLssSX4wpn/HY68epE
 ZyMKmtpIBEcl5en6qZhD0B/q2vO8ldk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785750287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MDrmJr7+dYyv4L9GA3jwJ0YVbhk2IAdV3OqNccHofsg=;
 b=1XcKpLk1MVpblOHNBiTs2nzy7g25Us8vXmu7ZdZGxSMvKVB5lWg6MtUHtDtstIKq/UTld5
 rDBonDp3Vs2Ly5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 222C1779A1;
 Mon,  3 Aug 2026 09:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6x3VBg9jcGqZKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Aug 2026 09:44:47 +0000
Date: Mon, 3 Aug 2026 11:44:45 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260803094445.GA217746@pevik>
References: <20260803091348.GA216243@pevik>
 <6a705e29.c69142e7.53fee.4a71@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a705e29.c69142e7.53fee.4a71@mx.google.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,ozlabs.org:url];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,ozlabs.org:url];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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

Hi Andrea,

> Hi Petr,

> > to patchwork.kernel.org. FYI we already have 18 patches on it, AI review is
> > there as well.

> Unfortunately AI review doesn't work there at the moment, I'm waiting for
> the LTP CI user set inside the new patchwork instance. But for now, we can
> backup this with my personal token, if needed.

Good catch, thanks! Although AI reviews are posted to both instances (they both
get mails from LTP ML), the review status does not work.  That's due LTP CI user
not being part of LTP maintainers on patchwork.kernel.org [1] (as it is on the
old instance [2]) that should be solved soon. Please let me know if there is
something else missing.

FYI new instance also have only REST API enabled, the deprecated XML-RPC API is
disabled. Fortunately Andrea's ci/tools/patchwork.sh script uses the REST API :).

If somebody uses pwclient, it requires ~/.pwclientrc modification:
-url = https://patchwork.ozlabs.org/xmlrpc/
+url = https://patchwork.kernel.org/api/
+backend = rest

I also wonder if (once we switch) should send an announcement to LTP ML.

And (how ironically) atm patchwork.kernel.org respond really slowly for me,
patchwork.ozlabs.org does :). I suppose that should be just temporarily.

Kind regards,
Petr

[1] https://patchwork.kernel.org/project/ltp/
[2] https://patchwork.ozlabs.org/project/ltp/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
