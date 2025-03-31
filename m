Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861D5C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 17:31:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27A543CAD82
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 19:31:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E1A13CA03B
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:31:05 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BBB7660020C
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:31:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C984B211F9;
 Mon, 31 Mar 2025 17:31:03 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAC2013A1F;
 Mon, 31 Mar 2025 17:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jVe0KFfR6me4cQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 17:31:03 +0000
Date: Mon, 31 Mar 2025 19:31:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250331173102.GA268097@pevik>
References: <20250328114311.187541-1-pvorel@suse.cz>
 <Z-q6Okh-lkvbx5mA@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-q6Okh-lkvbx5mA@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: C984B211F9
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 0/2] Add safe_get_nodemap()
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
> > not a huge improvement, but because all tst_get_nodemap() are in the
> > setup (and only ksm06.c allows input parameter) we could have struct
> > tst_test member which would call safe_get_nodemap().

> > e.g.:

> > .nodemap = (const struct tst_path_val) {
> > 		.type = TST_NUMA_MEM
> > 		.required = 2,
> > },

> I do not get this, the struct tst_path_val is something completely
> different.

I'm sorry, copy paste error. This was meant to be a new struct,
e.g. struct tst_nodemap_val. But I see you below suggested struct tst_numa.

> > safe_get_nodemap(tst_test->nodemap->type,
> > 	tst_test->nodemap->required * getpagesize() / 1024);

> > This would not work for non - page sized nodes, e.g.:
> > nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024);

> > => extra member would need to be added:

> > .nodemap = (const struct tst_path_val) {
> > 		.type = TST_NUMA_MEM
> > 		.required = 2,
> > 		.size = PAGES_ALLOCATED, // default == 1
> > },

> I've avoided the size to be in pages and choosen kilobytes instead
> because the page size can differ a lot.

Make sense.

> > would call:

> > safe_get_nodemap(tst_test->nodemap->type,
> > 	tst_test->nodemap->required * tst_test->nodemap->size * getpagesize() / 1024,
>          ^
> 	 This does not make any sense.

> The memory parameter is supposed to be minimal free memory on each node,
> for each node we check that it has at least min_mem_kb in the
> node_has_enough_memory() function.

> There is no point in multiplying that by the number of nodes we require.

> And this looks like it uses kilobytes not pages.

> > 	tst_test->nodemap->required);

> I guess that what you meant is that we will add tst_numa structure such as:

> struct tst_numa {
> 	enum tst_numa_types node_type;
> 	unsigned int min_nodes;
> 	unsigned int min_mem_kb;
> };

+1, thanks for suggesting a proper struct :).

BTW why we can use enum tst_numa_types in struct and not as function parameter?

-struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb);
+struct tst_nodemap *tst_get_nodemap(enum tst_numa_types type, size_t min_mem_kb);

Old toolchains? Maybe not needed nowadays? I guess with using enum we could get
rid of the check for enum validity:
if (type & ~(TST_NUMA_MEM))
	tst_brk(TBROK, "Invalid type %i\n", type);

> And then use that in tst_test structure. That would certainly make
> sense, but I guess that we would have to move the numa library to the
> lib/ as well. I'm not sure that we can have a function call from
> tst_test.c library to something that is not compiled in by default.

Correct, file is in libs/numa/tst_numa.c. But how about use predecessor check?

if (tst_test->numa) {
#ifdef HAVE_NUMA_V2
	...
#else
	tst_brk(TCONF, NUMA_ERROR_MSG);
#endif
}

With help we would even get rid of else part of the compile check in the
tests:

#else
TST_TEST_TCONF(NUMA_ERROR_MSG);

But we would have modify lib/Makefile to conditionally add "-lnuma -lltpnuma".
"-lnuma" would be based on NUMA_LIBS (stored in include/mk/config.mk, detected
in m4/ltp-numa.m4), e.g. something like this could work:

ifneq ($(NUMA_LIBS),)
LDLIBS += $(NUMA_LIBS) -lltpnuma
endif

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
