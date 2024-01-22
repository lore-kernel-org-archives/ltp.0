Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806BAC4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:48:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13B1C3CE241
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:48:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD2E43CE227
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:47:50 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 35D301000232
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:47:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E56B321E42;
 Mon, 22 Jan 2024 07:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705909669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yh4gU7uIIdVrWq23vLAaakpZuzxWV0a9v9XhZ/atg3E=;
 b=m/b1+GOCSGy46/iCaEv9Rn9sWFBefTNS8HDQ2PPSOlHeb0ajfdWEyrXefIvfy25K0EBuhY
 RnhfSSjgMj4nhgTDrHmM2qJNk1ORTBqy/jlOjmg3L0gMHfXnuxUw0EmEIy6C5pJPSuHqZ+
 G6kh7SmAV4aaRlsvvGmBreL7U/rjV1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705909669;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yh4gU7uIIdVrWq23vLAaakpZuzxWV0a9v9XhZ/atg3E=;
 b=6Edp/4Y8XWT7o2gf+cng1AWilfZf7+ACeAWI7CXD1ZKwLp1gJcMArhWvCM60IVqzkPlzQD
 6fwJ+auzPYSsBuBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705909668;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yh4gU7uIIdVrWq23vLAaakpZuzxWV0a9v9XhZ/atg3E=;
 b=JbXt4Psc90rv0ewTnPxLbw8VqQ0Bp8qJrBpqxiqHca5lcQpwiG7paaqKiHpGXZaUxHV7w4
 dIiLa6LEPTklS3U00tCj0qyssQ3dqLUzPRvORNioYW4hiq+WhgnRqE/y24+/xxBnzdQd0k
 nPIUxxHeMHOgDn9rZvrU6ealmOkGrCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705909668;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yh4gU7uIIdVrWq23vLAaakpZuzxWV0a9v9XhZ/atg3E=;
 b=tfnhgaS4h434KXKCkTqUi4YyZU0ywatYgAYwG+N9n8X66SqJ77Pzb3HN/A1JIBhSX6Olpd
 bSWe4LA9blQCYpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6379139A2;
 Mon, 22 Jan 2024 07:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7Mx+GaQdrmW3UAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 07:47:48 +0000
Date: Mon, 22 Jan 2024 08:47:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, David Howells <dhowells@redhat.com>,
 ltp@lists.linux.it
Message-ID: <20240122074742.GA70626@pevik>
References: <20240111100636.1897637-1-pvorel@suse.cz> <Zakb4b4EKURkixiC@yuki>
 <20240118142325.GB2774347@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240118142325.GB2774347@pevik>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JbXt4Psc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tfnhgaS4
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E56B321E42
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl05: Improve the dns_res_payload for
 boundary testing
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, David,

> > Hi!
> > > NOTE: I would wait with this to at least v6.8-rc2. Ideally it should be
> > > released, when the commit reaches any stable tree or when v6.8 is released.

> > What is the status here? Shall we include this for the January stable
> > release? Did the kernel patch got backported to stable kernels allready?

> I guess the question was to David (and I prefer him to clarify).

> I see patches backported to stable already, e.g. for 6.6.x stable:

> $ git show afc360e8a1256acb7579a6f5b6f2c30b85b39301
> commit afc360e8a1256acb7579a6f5b6f2c30b85b39301
> Author: David Howells <dhowells@redhat.com>
> Date:   Sat Dec 9 00:41:55 2023 +0000

>     keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry

>     [ Upstream commit 39299bdd2546688d92ed9db4948f6219ca1b9542 ]
> ...

I'm sorry I checked a different commit, we're talking about
acc657692aed ("keys, dns: Fix size check of V1 server-list header")

v6.8-rc1 is out, with this commit. I see it's already prepared in stable queue
for 6.7 by Sasha [1] and somebody already asked to add it to 6.1 and 6.6, where
it's needed (I verified test fails without it).

I guess we can merge now to get it to the upcoming release.

Kind regards,
Petr

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.7/keys-dns-fix-size-check-of-v1-server-list-header.patch
[2] https://lore.kernel.org/stable/CA+icZUUc_0M_6JU3dZzVqrUUrWJceY1uD8dO2yFMCwtHtkaa_Q@mail.gmail.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
