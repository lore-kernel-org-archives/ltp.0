Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D73C108B901
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 11:31:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0B2C3E279D
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 12:31:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DE043C940A
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 12:30:43 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BE28860240D
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 12:30:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A27DE4D259;
 Fri, 20 Mar 2026 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774006241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w95kcZMVyWWPKRTHVp1pCXm/9q1Y9wo7W5JxN93MnQs=;
 b=Wc7NBqekSbzOoHuG8yvfZYiKOct3BK38INhZQEwZ/N0CsDhKBiHzBrK2R6AXL2uTkQsRCU
 WN0z96Mmp5V1ZvEMK4UIzExB68hQcmUON0PvknI39sXQ0v4KhCWqaWWihh5XrA3ohOBiJP
 QRhgsG8AgE2jwVnKOA3buylLDqOCCEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774006241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w95kcZMVyWWPKRTHVp1pCXm/9q1Y9wo7W5JxN93MnQs=;
 b=3YZM4UmChtivE5Sym1fpyijgvIT8q6mXcjhAXruDijaoSx7R6uwSmMavvYmZV2xLlXGh5q
 5XzWwy/3tl5D+sCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774006241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w95kcZMVyWWPKRTHVp1pCXm/9q1Y9wo7W5JxN93MnQs=;
 b=Wc7NBqekSbzOoHuG8yvfZYiKOct3BK38INhZQEwZ/N0CsDhKBiHzBrK2R6AXL2uTkQsRCU
 WN0z96Mmp5V1ZvEMK4UIzExB68hQcmUON0PvknI39sXQ0v4KhCWqaWWihh5XrA3ohOBiJP
 QRhgsG8AgE2jwVnKOA3buylLDqOCCEM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774006241;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w95kcZMVyWWPKRTHVp1pCXm/9q1Y9wo7W5JxN93MnQs=;
 b=3YZM4UmChtivE5Sym1fpyijgvIT8q6mXcjhAXruDijaoSx7R6uwSmMavvYmZV2xLlXGh5q
 5XzWwy/3tl5D+sCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AF2942791;
 Fri, 20 Mar 2026 11:30:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oYsRGeEvvWkBfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 20 Mar 2026 11:30:41 +0000
Date: Fri, 20 Mar 2026 12:30:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260320113040.GB140154@pevik>
References: <20260318144113.30981-1-pvorel@suse.cz>
 <69bd15a1.050a0220.27cce5.4d03@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69bd15a1.050a0220.27cce5.4d03@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print tcnt in tst_{brk,res}()
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

Hi Andrea,

> Hi Petr,

> the idea is ok, but there are a few issues in the implementation.

> > +static unsigned int tcnt;

> `tcnt` is misleading because we are already using the same name inside
> `struct tst_test`. Better to use `tcase_idx` or something like this.

I deliberately chose tcnt because it's related to tst_test->tcnt. And test_all
is actually tcnt == 1. But sure we can name it tcase_idx.

> >  struct context {
> >  	int32_t lib_pid;
> > @@ -344,7 +345,7 @@ static void print_result(const char *file, const int lineno, int ttype,

> print_result() is used everywhere, by any tst_brk, tst_res, tst_vbrk_, tst_cvres
> etc. Which means you will have a `tcnt` printed everywhere. It looks better if
> we select only the starting message.

IMHO it's printed only on tst_brk() and tst_res() messages. tst_cvres() is
a special case of tst_vres_ called during test cleanup (TBROK changed to TWARN).

> >  		if (results_equal(&saved_results, results))
> > -			tst_brk(TBROK, "Test %i haven't reported results!", i);
> > +			tst_brk(TBROK, "Test %i haven't reported results!", tcnt);

> The new prefix printed by print_result() is 1-indexed (tcnt+1), but this
> message body still passes the 0-indexed value. A test skipping its first
> case would produce:

>   tst_test.c:1738: 1 TBROK: Test 0 haven't reported results!

Good point. FYI was also indexed by 0 before, but maybe we should really unify
it to start from 1. Or, really use 0 as it used to be, but I quite liked the
idea that 0 is for the setup function and tcnt + 1 is for the cleanup.
But looking that sometimes is the number really misleading:

$ ./test04
tst_test.c:2059: 1 TINFO: LTP version: 20260130-83-g4286eb4155
...
tst_test.c:1887: 1 TINFO: Overall timeout per run is 0h 00m 30s
test04.c:26: 1 TINFO: setup() executed by pid 147535
test04.c:16: 1 TPASS: PASSED message
test04.c:19: 2 TBROK: BROKEN message
tst_test.c:479: 2 TINFO: Child process reported TBROK killing the test
tst_test.c:1950: 1 TINFO: Killed the leftover descendant processes

=> it might be better if the number was printed really on tests, eg. [test 1],
maybe print also [setup] [cleanup] and [lib].

tst_test.c:2059: lib TINFO: LTP version: 20260130-83-g4286eb4155
...
tst_test.c:1887: [lib] TINFO: Overall timeout per run is 0h 00m 30s
test04.c:26: [setup] TINFO: setup() executed by pid 147535
test04.c:16: [test 1] TPASS: PASSED message
test04.c:19: [test 2] TBROK: BROKEN message
tst_test.c:479: [lib] TINFO: Child process reported TBROK killing the test
tst_test.c:1950: [lib]  TINFO: Killed the leftover descendant processes

Other thing to consider: do we want to print library and test forked child PID?
It might be useful when one sees somewhere in SUT logs coredump PID.
But quite a big part of each line would be occupied by this kind of prefix.
Maybe just printing once library and test PIDs would be enough.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
