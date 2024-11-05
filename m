Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB1A3D3177B
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 18:06:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98A5A3D2A09
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 19:06:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AB0E3C8994
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 19:05:46 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 966C3142E647
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 19:05:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B365021D3A;
 Tue,  5 Nov 2024 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730829942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w+6iWYl7iXwVGa/FUh/N3xBHntVf1DMmDet0vQ7nC84=;
 b=VutASHIfFk72+yyDkpTujNnkbHvNJRfIS2Tzrc2DKfR8XYfLZUcPftqpPWRPeankxnoYnC
 7dsU87JMraLTDkUy6p9X82O0oXRp6qXIjqQ+rcJA+vYlsCpn+XIreYW1Ic+Jj7XQoWIQ/G
 fs8xDWDO1k/cUG8q7muCbO9jtWi4z9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730829942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w+6iWYl7iXwVGa/FUh/N3xBHntVf1DMmDet0vQ7nC84=;
 b=Q+7lWAPEb54YJakmRYuQ1cDtByy7dM0RVstovA9BX0WL5FG3gSue6XYa7tSh5T4Kk6x/gI
 O8TUFzioOWRhq4AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VutASHIf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Q+7lWAPE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730829942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w+6iWYl7iXwVGa/FUh/N3xBHntVf1DMmDet0vQ7nC84=;
 b=VutASHIfFk72+yyDkpTujNnkbHvNJRfIS2Tzrc2DKfR8XYfLZUcPftqpPWRPeankxnoYnC
 7dsU87JMraLTDkUy6p9X82O0oXRp6qXIjqQ+rcJA+vYlsCpn+XIreYW1Ic+Jj7XQoWIQ/G
 fs8xDWDO1k/cUG8q7muCbO9jtWi4z9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730829942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w+6iWYl7iXwVGa/FUh/N3xBHntVf1DMmDet0vQ7nC84=;
 b=Q+7lWAPEb54YJakmRYuQ1cDtByy7dM0RVstovA9BX0WL5FG3gSue6XYa7tSh5T4Kk6x/gI
 O8TUFzioOWRhq4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 832CC1394A;
 Tue,  5 Nov 2024 18:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8yRbHnZeKme2ZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 05 Nov 2024 18:05:42 +0000
Date: Tue, 5 Nov 2024 19:05:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <20241105180541.GA1592518@pevik>
References: <20241104153404.21273-1-akumar@suse.de>
 <20241105104003.GA1573194@pevik>
 <5667b9b5-c19e-4c00-8fa1-176ae7e1176d@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5667b9b5-c19e-4c00-8fa1-176ae7e1176d@redhat.com>
X-Rspamd-Queue-Id: B365021D3A
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] crypto/af_alg0[13]: update tests for additional
 possible errno case
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

> On 05.11.24 11:40, Petr Vorel wrote:
> > Hi Cyril, Jan, David,

> > > kernel behaviour wrt checking invalid algorithms has changed [1] [2]
> > > updating the tests to address the additional errno case.
> > > Related discussion on the mailing list [3]

> > Looking at 57ab2160c0 ("move_pages04: remove special-casing for kernels < 4.3") [4]
> > recently reverting errnos for 4.3 d539a004dd ("move_pages04: fix zero page
> > status code for kernels >= 4.3") [5] please double check this already merged
> > change. I still believe it's a different case thus merging this is correct.
> > Also Eric is suggesting this (I should have added Suggested-by: tag for him).

> > Maybe we need some rules to clarify when we are ok with different errno and when not.


> Right.

> Regarding d539a004dd, we pretty much hid kernel bugs: behaving differently
> than expected+documented.

> If the kernel starts reporting a different errno it might be a bug: user
> space might not be prepared to handle that. Or it might be expected, because
> nobody really cares about the exact error code.

I don't remember last time anybody noticed, but sure it's important.

FYI an example where errno change was not important enough was for bind, where
commit 0fb44559ffd6 ("af_unix: move unix_mknod() out of bindlock") did some
fixes and a side effect was that errno on an attempt to bind a unix socket to
the same path twice changed from -EINVAL to -EADDRINUSE [1]. Bug which that
kernel commit fixed was way more important than changing errno [2] (and
therefore backported to all stable/LTS mainline kernels [3]).

The attempt to to fix errno [1] was just considered as not needed. But this
might be a special case, because both errnos were listed in the man page, it was
just matter of priority which of the error checks was handled first.

First attempt to fix the affected bind03.c was to detect kernel version [4],
which was wrong (some versions in between did not get the fix). In the end it
was possible to adjust test to get always expected errno regardless kernel got
0fb44559ffd6 backported or not [5].

Back to move_pages04. Jan wrote [6]:
   If people find it too noisy now for older kernels, we could add .min_kver = ""
   to the test.

I guess nothing happen, because 4.3 is way too old (the oldest mainline LTS kernel is 4.19, IMHO nobody tests 4.3 kernel with current LTP).

But having a written rules 1) when we care about errno change and when not and
what to do in both cases would be useful.

> So if a test starts failing, it's definitely concerning and needs a closer
> look.

> > I also thought there would be some rule "don't hide kernel bugs", but I can't
> > find it in the docs.

> That rule makes sense to me.

I was not clear. We follow "don't hide kernel bugs" (at least Cyril mentioned
this several times), but I haven't found if we document it somewhere in doc/
folder.

Kind regards,
Petr

[1] https://lore.kernel.org/netdev/20170630073448.GA9546@unicorn.suse.cz/
[2] https://lore.kernel.org/netdev/CAK8P3a1q32spcF445Zhw-KMXG2VwFZuMw5C1sYFk3qLXz3HB5w@mail.gmail.com/
[3] https://lore.kernel.org/netdev/20181129123650.GI3149@kroah.com/
[4] https://lore.kernel.org/ltp/20180831132453.6461-1-junchi.chen@intel.com/
[5] https://lore.kernel.org/ltp/20180911102403.7094-1-junchi.chen@intel.com/
[6] https://lore.kernel.org/ltp/CAASaF6yLa6F9Bz9Adck=Y5RJePzYmboSAizYWJP_BHmy12cQ=g@mail.gmail.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
