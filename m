Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA70CA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 12:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C85183CB437
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 14:08:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8314A3C8E87
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 14:08:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A15226002D6
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 14:08:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F60121CAC;
 Tue, 12 Aug 2025 12:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755000499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQSyC8Zcxvhs261gWrZj57ea+F2Cuo8sXKUx8NQEHv0=;
 b=FiRzSNxZvu4MLe+2oGT8LaGIc7L+GRY6U5JEguqosvXIvq5RemSt9oNexyBVgfjUNTmLJ5
 h6SF56bCZj+ICetw4Ze6E4T7NiJlTi3md3IwfbfihUziostVdLzu7DRcgTtIEUhwEiGOZd
 JzV/wXh6bpmOjm2AlMzgA7L24Sw6KIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755000499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQSyC8Zcxvhs261gWrZj57ea+F2Cuo8sXKUx8NQEHv0=;
 b=h+rDG7mlcWM0skhWhskkuk5fslYpp7uxL59lIvmd8UhFnl4spn74K6ekkG2ujGQKeBB/xK
 lGOwPg2Oie+YnSDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FiRzSNxZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=h+rDG7ml
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755000499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQSyC8Zcxvhs261gWrZj57ea+F2Cuo8sXKUx8NQEHv0=;
 b=FiRzSNxZvu4MLe+2oGT8LaGIc7L+GRY6U5JEguqosvXIvq5RemSt9oNexyBVgfjUNTmLJ5
 h6SF56bCZj+ICetw4Ze6E4T7NiJlTi3md3IwfbfihUziostVdLzu7DRcgTtIEUhwEiGOZd
 JzV/wXh6bpmOjm2AlMzgA7L24Sw6KIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755000499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WQSyC8Zcxvhs261gWrZj57ea+F2Cuo8sXKUx8NQEHv0=;
 b=h+rDG7mlcWM0skhWhskkuk5fslYpp7uxL59lIvmd8UhFnl4spn74K6ekkG2ujGQKeBB/xK
 lGOwPg2Oie+YnSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FDEB136C7;
 Tue, 12 Aug 2025 12:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YQeeBrMum2hoJgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 12 Aug 2025 12:08:19 +0000
Date: Tue, 12 Aug 2025 14:09:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aJsu4qw72EZiKnSP@yuki.lan>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <20250812101237.GA835467@pevik> <aJsg11G8hOAqoGkw@yuki.lan>
 <20250812114540.GC843668@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250812114540.GC843668@pevik>
X-Rspamd-Queue-Id: 2F60121CAC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [doc,
 runtest] [was: Re:  [PATCH] cve: add CVE-2025-38236 test]
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
> This problem happen on all runtest files, fixing just one does not fix the
> problem.

Well we can do that for any runtest file that has clear definition of
which tests belongs there. For CVE it's crystal clear, tests that have
cve tag should be there. For the rest of the runtest files, it's not so
much. Maybe for syscalls we may be able to do so.

The main thing is that we have to start somewhere got eventually get
there. I just quickly looked at the cve runtest file and figured out
that we have to add tests variants somewhere into the metadata. I.e.
quite a few of the CVE tests have command line options in the runtest
file which has to be stored somewhere else.

> Sure, it'd be possible to generate runtest/cve from metadata. Do we really want
> to implement it? (I can create a ticket). I guess we would use C and ujson to
> not require json-c or python3 for building LTP.

Or we can hook it up directly into the metadata parser, instead of
parsing the resulting JSON we can act on the data while they are in the
memory. Matching some tags and writing a test name into a file could be
easily done.

> I would be more interested to have section "CVE reproducers" in Statistics page [1].
> While the same tool could be used to do both goals, when only doc page
> implemented, it could be easily done in python3 (doc/conf.py already parses
> ltp.json).
> 
> When we are at Statistics page, also generating list of reproducers (based on
> kernel fixes) would be also nice. Because this was implemented in the previous
> asciidoctor implementation. How about having these lists Statistics, where are
> other tables already (and linking each test to "Test Catalog")?
> 
> Also I find "Statistics" name confusing. It says nothing about the content. I
> wonder if people curiously click on the page or just ignore the page (if they
> don't like math :)). Maybe "Kernel coverage" or something like that would be
> more informative.

I would put the list of reproducers and list of CVE reproducers into a
separate page that would be have "reproducers" in the name.

And statistics is probably okayish name, since coverage may mislead
people even more. For example we have a lot of tests for a write()
syscall yet coverage for all the possible write handlers in kernel is
very poor and not likely to improve.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
