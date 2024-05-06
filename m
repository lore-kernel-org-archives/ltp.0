Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219D9C25B10
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 20:26:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71F2A3CDA30
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 22:26:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B3D53C0831
 for <ltp@lists.linux.it>; Mon,  6 May 2024 22:26:26 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 90F2061123A
 for <ltp@lists.linux.it>; Mon,  6 May 2024 22:26:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CEF4227AC;
 Mon,  6 May 2024 20:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715027184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Bv2u3rQYkyAGAb7aIdp43s4fcvhwokXJilAzcVOQIQ=;
 b=y8Ox1uIDzQkgvzYdrqvoAY9GEL/a+KIwjXectYfUQ0YrE80InZgmXu2toj+QiBTJNuoAak
 KfL092xwWN7PUVlN+7wOxL6oqufO8vnIAGWbWf1OYYO/mfn1Fnkm2yYki9nv5n3NQAe7oz
 j5GFs6Md0SH1fW6P+xRhheW9m1Xercs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715027184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Bv2u3rQYkyAGAb7aIdp43s4fcvhwokXJilAzcVOQIQ=;
 b=rnBP/WrtMPtmAqfwvB9rFQN8vHT5YS6eCxEElVOQcCp3AvNyTFX0v4GGHvlXqMiFePDLYG
 jFJSTARoHir6RKDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715027184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Bv2u3rQYkyAGAb7aIdp43s4fcvhwokXJilAzcVOQIQ=;
 b=y8Ox1uIDzQkgvzYdrqvoAY9GEL/a+KIwjXectYfUQ0YrE80InZgmXu2toj+QiBTJNuoAak
 KfL092xwWN7PUVlN+7wOxL6oqufO8vnIAGWbWf1OYYO/mfn1Fnkm2yYki9nv5n3NQAe7oz
 j5GFs6Md0SH1fW6P+xRhheW9m1Xercs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715027184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+Bv2u3rQYkyAGAb7aIdp43s4fcvhwokXJilAzcVOQIQ=;
 b=rnBP/WrtMPtmAqfwvB9rFQN8vHT5YS6eCxEElVOQcCp3AvNyTFX0v4GGHvlXqMiFePDLYG
 jFJSTARoHir6RKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 298C71386E;
 Mon,  6 May 2024 20:26:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m1leCPA8OWYVYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 May 2024 20:26:24 +0000
Date: Mon, 6 May 2024 22:26:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240506202614.GC38981@pevik>
References: <20240503081647.18253-1-andrea.cervesato@suse.de>
 <a85b4fe7-a235-4b7b-8211-4caf8c3112c2@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a85b4fe7-a235-4b7b-8211-4caf8c3112c2@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor fork14 using new LTP API
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

Hi Andrea, Martin,

> Hi,
> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

+1

...

Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.forks_child = 1,
> > +	.skip_in_compat = 1,

BTW test on x86 (i.e. true 64 bit) behaves exactly the same as on compat mode:

tst_test.c:1614: TINFO: Timeout per run is 0h 00m 30s
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:46: TINFO: mmap() failed
fork14.c:49: TCONF: mmap() fails too many times, so it's almost impossible to get a vm_area_struct sized 16TB.

IMHO we should whitelist it as well, I can change before merge with diff below.

(More elegant way would be to add .skip_in_32bit.)

Kind regards,
Petr

+++ testcases/kernel/syscalls/fork/fork14.c
@@ -18,6 +18,8 @@
 #include <stdlib.h>
 #include <sys/wait.h>
 
+#ifndef __i386__
+
 #define LARGE		(16 * 1024)
 #define EXTENT		(16 * 1024 + 10)
 
@@ -121,3 +123,6 @@ static struct tst_test test = {
 		{}
 	}
 };
+#else
+TST_TEST_TCONF("Not supported on x86 in 32-bit");
+#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
