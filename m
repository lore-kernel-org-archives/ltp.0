Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784C1CCFA05
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 16:50:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05DB43CED7A
	for <ltp@archiver.kernel.org>; Thu,  6 Nov 2025 17:50:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26D1B3C9078
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:50:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E138A600950
 for <ltp@lists.linux.it>; Thu,  6 Nov 2025 17:50:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DE3B1F786;
 Thu,  6 Nov 2025 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762447822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nEdK05739ApazKY8ZzVB8qQDLDO8wWIGgW/DrwDFM8=;
 b=oTCcdme4pIQscCBrakmCfiBgFNMVp4E+Y8cWTY4x+YydcQnOVHvwFMiw2c3sZnprSXns2R
 MmeAnM0DvkgSEmVZxhqxyQfhCfDKTqmMX3QgVvS5zKW3eKOshFIfkGkKY5446TqOAU1iO1
 +5Lcx/XFLCX6JMrWWMhevz6VAWZDxd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762447822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nEdK05739ApazKY8ZzVB8qQDLDO8wWIGgW/DrwDFM8=;
 b=kqhgTc6nBf2rfYDMnMbmy+8U3XoVua0hl2WKVdB8Rmq/Bfe6+81sLJ4TsjJfAiS6CZLYV1
 Vu3J7pwSHlXIQPDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762447822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nEdK05739ApazKY8ZzVB8qQDLDO8wWIGgW/DrwDFM8=;
 b=oTCcdme4pIQscCBrakmCfiBgFNMVp4E+Y8cWTY4x+YydcQnOVHvwFMiw2c3sZnprSXns2R
 MmeAnM0DvkgSEmVZxhqxyQfhCfDKTqmMX3QgVvS5zKW3eKOshFIfkGkKY5446TqOAU1iO1
 +5Lcx/XFLCX6JMrWWMhevz6VAWZDxd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762447822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5nEdK05739ApazKY8ZzVB8qQDLDO8wWIGgW/DrwDFM8=;
 b=kqhgTc6nBf2rfYDMnMbmy+8U3XoVua0hl2WKVdB8Rmq/Bfe6+81sLJ4TsjJfAiS6CZLYV1
 Vu3J7pwSHlXIQPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF65D13A31;
 Thu,  6 Nov 2025 16:50:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3NcDOc3RDGmNUgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Nov 2025 16:50:21 +0000
Date: Thu, 6 Nov 2025 17:50:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251106165012.GA1064259@pevik>
References: <20251106114337.550054-1-piotr.kubaj@intel.com>
 <aQyYnbgewc4AptZJ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aQyYnbgewc4AptZJ@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] thermal: add new test group
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
Cc: helena.anna.dubel@intel.com, tomasz.ossowski@intel.com,
 rafael.j.wysocki@intel.com, Piotr Kubaj <piotr.kubaj@intel.com>,
 daniel.niestepski@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr, Cyril,

> Hi!
> First of all, the tst_test.sh test library is in maitenance mode and new
> shell tests should use the tst_loader.sh instead. Have a look at the
> testcases/kernel/mem/vma/vma05.sh test on how does it look like.

Piotr, first thank you for submitting a test.

My wish would be no more shell based test. shell loader is kind of compromise to
improve existing shell based tests, but I'm not happy to see yet new more tests
in shell (we in SUSE will be then actively rewriting it into C :( to avoid
various problems with shell tests).

Piotr, would it be so hard to rewrite it into decent C?

C API has many helpers and it's more reliable:

https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc
https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html
https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tutorial.html

+ many tests rewritten as a real code examples (see these which include "tst_test.h").

Also, do you plan to write only a single test? If yes I'm not sure if single
test deserves it's own scenario group.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
