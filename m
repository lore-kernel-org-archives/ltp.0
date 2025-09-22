Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0EFCAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 08:32:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA1F33CDE3A
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 10:32:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 859F33C2566
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 10:32:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ECB21600A67
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 10:32:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C70821FE6;
 Mon, 22 Sep 2025 08:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758529948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrCTwK+PFQiWmeCsZp0+GnXmgyOno3lWacvi5uCBDok=;
 b=Ps4pJNubPS/qJc9O9fyfYc1C1p73EwYz861S99Nbexwm17xU+H4BX/4iMs73g1hl6G2Eqn
 JN/KhiOMESO08qx26/1ZNmXoM4z6+a6o5O1YwtYhxcM3wX3+bY4klvpXgOMHNNkd9SIcgw
 ivW4gKBD8bzhLDJoJKNu9O5BvVupaiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758529948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrCTwK+PFQiWmeCsZp0+GnXmgyOno3lWacvi5uCBDok=;
 b=ycFMbzrT0e4LUdCxN/mezOLSUG2bFM++m/kgLYpp0kHOa2df5PGqtiwLmb+KD7vKwdmWni
 pybld1dPPxD+SnDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758529948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrCTwK+PFQiWmeCsZp0+GnXmgyOno3lWacvi5uCBDok=;
 b=Ps4pJNubPS/qJc9O9fyfYc1C1p73EwYz861S99Nbexwm17xU+H4BX/4iMs73g1hl6G2Eqn
 JN/KhiOMESO08qx26/1ZNmXoM4z6+a6o5O1YwtYhxcM3wX3+bY4klvpXgOMHNNkd9SIcgw
 ivW4gKBD8bzhLDJoJKNu9O5BvVupaiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758529948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yrCTwK+PFQiWmeCsZp0+GnXmgyOno3lWacvi5uCBDok=;
 b=ycFMbzrT0e4LUdCxN/mezOLSUG2bFM++m/kgLYpp0kHOa2df5PGqtiwLmb+KD7vKwdmWni
 pybld1dPPxD+SnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 236F813A63;
 Mon, 22 Sep 2025 08:32:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9SzsB5wJ0WgYFQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 22 Sep 2025 08:32:28 +0000
Date: Mon, 22 Sep 2025 10:33:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Mark Wielaard <mark@klomp.org>
Message-ID: <aNEJyIv9QdQdyKQN@yuki.lan>
References: <20250918152640.1146279-1-mark@klomp.org>
 <aND_aLgsukouVATL@yuki.lan>
 <20250922082452.GH19408@gnu.wildebeest.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250922082452.GH19408@gnu.wildebeest.org>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap04: Make sure the scanf address format is at
 least 8 hex chars
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
Cc: Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > The addresses in /proc/self/maps are at least 8 hex chars. Zeros are
> > > added to the front of the address when shorted (both on 32bit and
> > > 64bit systems.
> > > 
> > > Under valgrind the mmaps used in kernel/syscalls/mmap/mmap04.c come
> > > out very low in the address space and might be shorter than 8 hex
> > > chars. This causes the scanf to fail:
> > > mmap04.c:62: TBROK: Expected 1 conversions got 0 FILE '/proc/self/maps'
> > 
> > I guess I do not understand the problem here. The PRIxPTR translates to
> > "x", "lx", or "llx" depending on architecture and as far as I can tell
> > the %x modifier handles leading zeroes just fine.
> 
> The problem is that we want to match (scanf) an absolute address
> (addr2) at the start of the line. It is this absolute/literal address
> that doesn't match (because it might not have leading zeros).
> 
> e.g. We might want to match the address 403a000 and want to match
> against: 0403a000-04048000 rw-p
> 
> When creating the fmt which we want to use for scanf we currently
> generate: "403a000-%*x %s" Which doesn't match because it is missing
> the leading zero (the "-%*x %s" would match the rest, except that the
> start of the line doesn't). So with the "%08" fix we would generate:
> "0403a000-%*x %s" which does match because it has the same number of
> leading zeros.

Ah right, I'm blind, we generate the fmt on the fly. In that case
padding to eight zeroes will match what kernel does.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
