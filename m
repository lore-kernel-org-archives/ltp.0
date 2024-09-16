Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354C8C3ABA2
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 09:54:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A89183C2BD3
	for <ltp@archiver.kernel.org>; Mon, 16 Sep 2024 11:54:21 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 984223C2B00
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 11:54:04 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ECCCB6001EA
 for <ltp@lists.linux.it>; Mon, 16 Sep 2024 11:54:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DF041F88D;
 Mon, 16 Sep 2024 09:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726480440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VjAo2jnstuPOJiwrqBz8Ibhaw6n20FzsieurPZcVBA=;
 b=raSVN6Ejxh409foD9lHX83C6KdkuGIevJg3N9QUxUKiU14RrSKfagMeN0BLgjUt8kGv8gX
 oApG5VAgCG0Ob/JlzkD3XqlF06ivHBg9NDeEjHZ9Ph36xJ2y68zHFzVRtgIvAnoGC+67xe
 t1IKXyEpIf8bcCiu9YzWNXMu/TC8ZoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726480440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VjAo2jnstuPOJiwrqBz8Ibhaw6n20FzsieurPZcVBA=;
 b=ujia320ziuhZDbikW827/D0CjuNn9KBZxn4+18OkdyPHN8W5uIKa6bMWJc9KnEBp81PDWj
 EhzLlC9rTfeE4pCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=raSVN6Ej;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ujia320z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726480440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VjAo2jnstuPOJiwrqBz8Ibhaw6n20FzsieurPZcVBA=;
 b=raSVN6Ejxh409foD9lHX83C6KdkuGIevJg3N9QUxUKiU14RrSKfagMeN0BLgjUt8kGv8gX
 oApG5VAgCG0Ob/JlzkD3XqlF06ivHBg9NDeEjHZ9Ph36xJ2y68zHFzVRtgIvAnoGC+67xe
 t1IKXyEpIf8bcCiu9YzWNXMu/TC8ZoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726480440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VjAo2jnstuPOJiwrqBz8Ibhaw6n20FzsieurPZcVBA=;
 b=ujia320ziuhZDbikW827/D0CjuNn9KBZxn4+18OkdyPHN8W5uIKa6bMWJc9KnEBp81PDWj
 EhzLlC9rTfeE4pCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F9581397F;
 Mon, 16 Sep 2024 09:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2A1RHjgA6GZRWgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 16 Sep 2024 09:54:00 +0000
Date: Mon, 16 Sep 2024 11:52:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zuf_8O7qYncg39Iz@yuki.lan>
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
 <20240903082415.GB728268@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240903082415.GB728268@pevik>
X-Rspamd-Queue-Id: 8DF041F88D
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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
> I hoped testcases/lib/run_tests.sh could be run in CI (and manually).
> 
> We have in the toplevel Makefile other test targets, could we add
> testcases/lib/run_tests.sh to test-shell target?
> 
> 1) Add test target to testcases/lib/tests/Makefile (similar to
> metadata/tests/Makefile).
> 
> test:
> 	@echo == Run C - shell integration tests ===
> 	@./run_tests.sh
> 
> 2) Add test target to testcases/lib/Makefile which would call test target in the
> test/ directory (similar to metadata/Makefile).
> 
> test:
> 	$(MAKE) -C $(abs_srcdir)/tests/ test
> 
> 3) Add testing to the toplevel test-shell target + build dependency to testcases/lib/.
> 
> test-shell: lib-all
> ifneq ($(build),$(host))
> 	$(error running tests on cross-compile build not supported)
> endif
> 	$(call _test,-s)
> 	$(MAKE) -C $(abs_top_builddir)/testcases/lib
> 	$(MAKE) -C $(abs_top_srcdir)/testcases/lib test

Quite a few of these testcases fail in order to test failures, we need
to be able to record the test output and compare that with the expected
outcome first, in order to make these tests useful. And I guess that we
need that for the C library tests as well. So I would rather do this
later for both libraries instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
