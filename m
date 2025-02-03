Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9659AC02197
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 14:42:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 037423C8EFD
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 15:42:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27E353C5584
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 15:42:04 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 914A5600687
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 15:42:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D051021109;
 Mon,  3 Feb 2025 14:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738593722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIQ/5qmBpMCp2TafQehva9Km/jMFyl83X97qdU++40k=;
 b=T/FTcL2MGIpiuD8DGcMgSVR1yF9cuWnR8iqheA7XBnThjJNsjeESwpNhf8eUF33+4YMfYi
 USGDP9+eMqsDjhKDpT+6bUiQk7nWvwZhNAg/MCaRUr+OB4EoZw5r8Xbu/ponwxLmeyuypD
 qyZwxVfpaG0eC+KRNH56UJMvBvCtHjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738593722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIQ/5qmBpMCp2TafQehva9Km/jMFyl83X97qdU++40k=;
 b=cl9NCMdZZLZk7E9oio8Tufp/UlqN8lUl8blLtBYyfWICqkDiyzwpLFUaD04Ybu8qFl94rH
 /zl7QtHw0sdchIAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738593721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIQ/5qmBpMCp2TafQehva9Km/jMFyl83X97qdU++40k=;
 b=umhw+BzzDTxWKFvo0lbtFcWGenkwf7bWHKGLGDfO1rOtghUvStta7YEocQuvml9j0hYuPB
 CB8w6P9uf2lVDej/JSXX4oLwpk+aEzARivrNYFRZeASaGrA0ZDINKAghoE7hVIrsrQrIkw
 88W7SF+PE8/3xtk37v1Hpn92Kd+D4ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738593721;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIQ/5qmBpMCp2TafQehva9Km/jMFyl83X97qdU++40k=;
 b=oMnSMblDb5g4HIbTrA8tkKyuDuTQrX8GrJik2bPCkt1bROXHW3QtgVV3ff0kTurgTZl+hH
 fy/drQ0GElWtzODg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C240413795;
 Mon,  3 Feb 2025 14:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8EKbLrnVoGcDSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 03 Feb 2025 14:42:01 +0000
Date: Mon, 3 Feb 2025 15:42:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z6DVuQ4DcH5Ai1fX@yuki.lan>
References: <20250203-doc_tests_list-v1-1-5fe69c07b1ab@suse.com>
 <Z6CxekRPhvsSdfLc@rei>
 <7f6d9a5d-284a-4c25-b491-cfd7b15da2dd@suse.com>
 <4f163ac1-d282-4ea1-baa7-c574b342243c@suse.com>
 <Z6DBxBvFRXHvolkt@yuki.lan> <20250203141408.GA1266486@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250203141408.GA1266486@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: add tests catalog page
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
> > I guess that we want group the data somewhat like:
> 
> >  - options (because command line options may be useful there)
> 
> >  - min_kver, needs_kconfigs, min_cpus, needs_drivers, needs_cmds...
> >    (because it may describe why tests are skipped)
> 
> >  - needs_cgroup_ctrls + cgroup knobs (for tests that use cgroups)
> Also .needs_cgroup_ver, .needs_cgroup_nsdelegate

That should be covered by the "cgroup knobs"

> >  - all_filesystems, skip_filesystems, filesystems
> 
> >  - timeout, runtime         (here as well, run for longer)
> 
> >  - needs_root      maybe?
> >  - needs_device    maybe?
> IMHO both can be interesting - you can list tests you loose if you don't use
> root or you don't have kernel with loop device configured.
> 
> Also there are more: .caps, .hugepages, .needs_hugetlbfs, .min_mem_avail,

I guess that .caps is closer to be interanal than not.

> .min_swap_avail, .dev_min_size, .needs_abi_bits, .needs_overlay (at least).

And we also have supported_archs, that is probably interesting.

> Why not to show all the info like it was previously? We never know what the
> reader will be interested in.

The chalenge here is to keep the page nicely formatted and generally
well arranged, having less helps a bit there. So the idea is to skip the
data that are generally mostly interesting to the test runner. The
quesitos is where to draw the line.

> If we are really not interested at all, I would just avoid few LTP true
> internals, e.g.: .needs_checkpoints, .forks_child, .child_needs_reinit.

These are really uninteresting to anone reading that documentation.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
