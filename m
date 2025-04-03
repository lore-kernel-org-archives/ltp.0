Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE312C3601E
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 12:36:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A5B93CB09B
	for <ltp@archiver.kernel.org>; Thu,  3 Apr 2025 14:36:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26A013CA5B8
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 14:36:16 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 245D9200097
 for <ltp@lists.linux.it>; Thu,  3 Apr 2025 14:36:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E6CB01F749;
 Thu,  3 Apr 2025 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743683773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyxhdNpFymzeOyVRGqQ2lzXqDYG67DDLAF0h5tIma+c=;
 b=wCAyxrY7agAtiu4gE+mEqo9VOr/GSiMZMJTwuouphwfGOd9GiVzzvtnB3r7KImzOI4eipa
 k9UepontFFu1OcZe41LRuuqqzc/xqDgMIvQgsmsct1/bQhcgWdz65UliPKW01zwL6rjN73
 q72ORp43/n9Dw3I9HeQbsYwpnr5l2lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743683773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyxhdNpFymzeOyVRGqQ2lzXqDYG67DDLAF0h5tIma+c=;
 b=MpsLDW8Gfc4TknZ4kbk45SRktqfQfiUr7vf+/ZxwuOseyp1v8YAzf5MCOmiNwwgQQ01xif
 KMkMqWj2Absgy4AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nrmC9ttn;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Yb0z+ayh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743683772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyxhdNpFymzeOyVRGqQ2lzXqDYG67DDLAF0h5tIma+c=;
 b=nrmC9ttn3DwITjFNBw6oc1RD7q/dz6lFsQIHauYjBCIF9b8flFv91NXaCkJpiZBYP9/mWG
 hePGn2YlSd2/Y++JHyxO9Re9CkDjNajh0KVT1DDSeczlZW1QTnuaHw0wd1BCl+bg2Lsyke
 ODwInJyT9IUAQJsB+hqZv9wYI5AJepE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743683772;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WyxhdNpFymzeOyVRGqQ2lzXqDYG67DDLAF0h5tIma+c=;
 b=Yb0z+ayhj5ZN2gMMJMtdJinr/0roMdQSA4mmU7tDupXKZQPp1rowqzkJxl5+ZhKy81mNLN
 X1bNCvcWnBGaQwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 63D6C1392A;
 Thu,  3 Apr 2025 12:36:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WHRXEbyA7meXMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Apr 2025 12:36:12 +0000
Date: Thu, 3 Apr 2025 14:36:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250403123610.GA465253@pevik>
References: <20250403113053.20040-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250403113053.20040-1-chrubis@suse.cz>
X-Rspamd-Queue-Id: E6CB01F749
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: Fix tst_brk() handling
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

Hi all,

[ Cc Jan and Li s there can be some hidden problems. ]

> This makes the tst_brk() handling cleaner and saner as instead of
> propagating the tst_brk() result in a return value an abort flag is
> introduced into the shared memory.

> Now:

> - All the processes but the library one that reports the results exit
>   with 0
> - tst_brk(TBROK, ...) increments result conters, sets the abort flag.
>   and exit current process
> - all other tst_brk() variants will just increments the countes and
>   exits the current process

> This makes the tst_brk() behavior well defined so we can now even call
> tst_brk() with TFAIL and TPASS as well.

+1. As a separate effort we can replace with coccinelle
tst_res(TFAIL or TPASS) followed by return by tst_brk(TFAIL or TPASS).

> And since TBROK is supposed to exit the test immediatelly (i.e.
> unrecoverable error) we are now properly doing so.

> The case that main test pid called TBROK was working correctly before
> this patch, since send the SIGKILL signal to he process group after we
> waited for the main test pid. All that was missing is a code that sends
> a signal to the main test pid in the case that TBROK was triggered by
> one of it's children and now we properly kill all test processes in that
> case as well.

+1

Also thanks for doing tests.

Generally LGTM.

One thing I'm worried is the fact that some shell loader tests core dumped in CI:
https://github.com/pevik/ltp/actions/runs/14242818586/job/39916477770
e.g. these which are supposed to TBROK due broken metadata:
shell_loader_invalid_block.sh, shell_loader_no_metadata.sh,
shell_loader_wrong_metadata.sh:

Segmentation fault (core dumped)

I also wonder if tst_brk() related doc should be updated.

Isn't there anything which should be updated in doc/old/C-Test-API.asciidoc ?
This docs will stay with us for some time, the conversion to kerneldoc takes
time, it'd be good to keep it updated (valuable texts will be migrated to
kerneldoc).

Maybe parts:
1.8 Doing the test in the child process
1.9 Fork() and Parent-child synchronization
(both code examples and the description).

very nit: please before merge fix typos in both code and commit message:
exitting => exiting
countes|countes => counters
immediatelly => immediately
filtesystem => filesystem

NOTE: test_brk_pass could be added to lib/newlib_tests/runtest.sh. I would also
prefer, if we changed tests to behave like testcases/lib/run_tests.sh, i.e.
allow to run all tests and check exit code (intermediate step before we compare
the test output).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
