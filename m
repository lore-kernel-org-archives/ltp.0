Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBADC982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 11:29:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6E8B3E5D6F
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 13:29:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F2663E1691
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 13:29:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C27F41000A23
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 13:29:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0363B21ADA;
 Tue, 22 Sep 2026 11:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790076562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkJEalilQOz+Gxd1Rd4nJslZuXuvpreAFLJq2h4NrNs=;
 b=LUU/w9EC+jT4HamCCf+M2N5SvBlqFR4fYRz/wZYIsUXDwC3Y3scsNGz2kCKCSWzju3bkBS
 22+cc5nV4SuOC/iICENbwYr6fB0OmfvjU0ZhVSNWHGqbHhfGNxA53OTEKSKuUy2b1yO3OG
 DlLbzbPQEdQaMW8BYjXMDdGwxspAN5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790076562;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkJEalilQOz+Gxd1Rd4nJslZuXuvpreAFLJq2h4NrNs=;
 b=kQ5eo7nUxHsIjHqrlcug+R4x3u6/EYV8hZS7BMLYNzstkrzHiCO9oQC3MojivJFuU/F+tP
 VLGj/NbI6EqPWpDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790076558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkJEalilQOz+Gxd1Rd4nJslZuXuvpreAFLJq2h4NrNs=;
 b=djk1u0KuHShTyndHAxxhm1PyYGVRLUENDhQ5+X2Idy48EZ0AOYYh0nlYxL90WP0K618I0h
 pXm9ohFQeNOUNnCH0V0ACuPWA4MPV7fycmyUAwNkEthgyuCbVz3xYQQOo+QzbhUFiZ4hxZ
 zJIoVQ4Up/4S7odVhqhB42oSFbc/71w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790076558;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkJEalilQOz+Gxd1Rd4nJslZuXuvpreAFLJq2h4NrNs=;
 b=a9gVIrnCY/f5i7Z1gBza47xfjRc1CUzWeVrNvM9Ihckb8sVkP/L8VpZhtauf1byyEJTy/4
 ImJEThp7OAfNErBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3E44132D3;
 Tue, 22 Sep 2026 11:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cYXcHo1msmrybQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 11:29:17 +0000
Date: Tue, 22 Sep 2026 13:29:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260922112916.GB2191017@pevik>
References: <20260922105840.2193537-1-pvorel@suse.cz>
 <arJiBgKNC80acBfY@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arJiBgKNC80acBfY@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl30: Check module is presented before
 loading
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

> Hi!
> > This fixes test on the system without module:

> >     modprobe: FATAL: Module pkcs8_key_parser not found in directory /usr/lib/modules/6.12.0-160100.5-azure
> >     tst_cmd.c:112: TBROK: 'modprobe' exited with a non-zero code 1 at tst_cmd.c:112

> > With the fix it TCONF as expected:

> >     tst_module.c:72: TCONF: Failed to find module 'pkcs8_key_parser'

> > Fixes: 1bb448ed9e ("keyctl30: Test KEYCTL_PKEY_QUERY on private key")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > FYI Cyril suggested to add into struct config_module_map:

> >  	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
> >  	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
> >  	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> > +	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},

> I think that this is still cleaner, this way we skip the test even
> before we start running it.

Yeah, exit early + having it in the metadata is better - feel free to post the
above as a patch and we refuse this patch.

After release thinking:
Thinking it twice having a separate metadata for "direct" module loading was
good (the functionality we replaced by kconfig). Why? Now we need to
1) load module manually in the test
2) manual module loading is hidden in metadata behind kernel config (tester see
that in the test output, but it's not obvious in the metadata).

Sure, we don't want to revert that whole big patchset. But maybe we could
consider to
1) call tst_module_load() based on config_module_map() instead doing it
in the test
2) print this mapping in the metadata (that would require struct config_module_map
being accessible also by metadata/metaparse.c.

> Maybe we should attempt to auto-generate the
> table for all CONFIG_* variables used in LTP.

Sure, that's a good idea. Useful would be some script similar to updating
sycalls numbers. With the only exception: don't delete old modules (modules can
be deleted, but still used by supported kernels).

> Also keyctl23.c and keyctl29.c have tst_modprobe("x509_key_parser",
> NULL); So we need fix/mappping for x509_key_parser too.

Yeah, I also noted that + cve-2026-46331.c (all Andrea's agent based code,
we should teach agent about the differences).

> > Although it does not harm this is IMHO just wrong function being used.

> That depends, if we decide to have the checks in the tst_kconfig.c then
> tst_modprobe() is the only function that should be used.

Sure, for distro modules. tst_module_load() is still needed for LTP specific
out-of-tree modules (again, we should teach the agent).

> Also looiks like the primary user of the tst_module_load() are tests
> that build modules in LTP tree, where it does make sense, since these
> may fail to build and be missing and there are no CONFIG_ variables for
> these. The rest of the tests seems to be using tst_modprobe().

Exactly.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
