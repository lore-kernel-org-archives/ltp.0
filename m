Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF05AC19F2D
	for <ltp@archiver.kernel.org>; Sat, 13 Aug 2022 19:59:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A32D3C954C
	for <ltp@archiver.kernel.org>; Sat, 13 Aug 2022 21:59:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C10923C02C2
 for <ltp@lists.linux.it>; Sat, 13 Aug 2022 21:59:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 820DA1400551
 for <ltp@lists.linux.it>; Sat, 13 Aug 2022 21:59:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A5EB4D4BB;
 Sat, 13 Aug 2022 19:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660420773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnBxSISVSbw01CB7e+zPwsYufpVXYEtFg0Q5JxkLfMc=;
 b=jvNshCA/wGYXs7EZhM04IWITHqVCwsKjDL69Nxqjat5k3uiLZgzIriG/zsSdt8HXAh1RVp
 BxK43YJOtYsHJNsEu/BZAmOIjtE8rdHHOGCEx4H4qdja7n2jU5SptKzmfwo0L2HtFKrKZ2
 pP3/XESTKmv1eeDhm8/DK4QluOkwYyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660420773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TnBxSISVSbw01CB7e+zPwsYufpVXYEtFg0Q5JxkLfMc=;
 b=MakE0gr9StG5AvuKGy/pHNpFBJaBleAFgerqucpjP2rXKVysnpifcp+Y5PpF6c5xE+KVOy
 YBW8c40uznWJMDDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 267F71341F;
 Sat, 13 Aug 2022 19:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JGmuB6UC+GJ2dAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 13 Aug 2022 19:59:33 +0000
Date: Sat, 13 Aug 2022 21:59:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: William Roche <william.roche@oracle.com>
Message-ID: <YvgCowvy1VJOPKj4@pevik>
References: <1659975072-29808-1-git-send-email-william.roche@oracle.com>
 <1659975072-29808-2-git-send-email-william.roche@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1659975072-29808-2-git-send-email-william.roche@oracle.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [LTP PATCH v1 1/1] syscalls/madvise11: Add some memory
 page soft-offlining control
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

Hi William,

Just few quick notes before somebody get to proper review:

There should be a record in runtest/syscalls:
madvise11 madvise11

...
> +++ b/testcases/kernel/syscalls/madvise/Makefile
> +
> +/*\
> + * [Description]
> + * Stress the VMM and soft-offline code by spawning N threads which
> + * allocate memory pages and soft-offline them repeatedly.
nit: if you intend this get formatted as paragraph, insert spaces:

> + * Control that soft-offlined pages get correctly replaced: with the
> + * same content and without SIGBUS generation when accessed.
and here

> + * Could be used for example as a regression test-case for the
> + * poisoned soft-offlined pages case fixed by upstream commit
> + * d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
Instead of this I'd put .tags record into struct tst_test.
https://github.com/linux-test-project/ltp/wiki/C-Test-API#138-test-tags

Also there are some formatting errors:
$ make check-madvise11
CHECK testcases/kernel/syscalls/madvise/madvise11.c
madvise11.c:46: ERROR: do not initialise statics to 0
madvise11.c:51: WARNING: Missing a blank line after declarations
madvise11.c:55: ERROR: open brace '{' following function definitions go on the next line
madvise11.c:213: ERROR: "foo* bar" should be "foo *bar"
madvise11.c:254: WARNING: Missing a blank line after declarations
madvise11.c:295: ERROR: return is not a function, parentheses are not required
madvise11.c:303: ERROR: "foo* bar" should be "foo *bar"
madvise11.c:316: ERROR: space required after that ',' (ctx:VxV)
madvise11.c:338: ERROR: space required after that ',' (ctx:VxV)

I'd also consider which comments are really useful. Most of them is, but at
least some document what is obvious, e.g.: 
/* Number of threads to create */
/* Success! */ => you specified return at the comment above the function
allocate_offline(), also this return code is pretty obvious:

...
> +	fd = SAFE_OPEN("/dev/kmsg", O_WRONLY);
> +	if (fd < 0) {
> +		tst_res(TCONF | TERRNO,"/dev/kmsg not available for writing");
> +		return;
> +	}
If check is not needed, because SAFE_OPEN() exits the test with
tst_brk(TBROK, "open(...) failed"

Also fd might not get unclosed, which could hit too many open files.

...

Also trying Fedora once more:
Running single iteration (./madvise11) or two iterations (./madvise11 -i2)
it fails in the end:

# ./madvise11 -i2
...
madvise11.c:136: TINFO: Thread [59]: allocate_offline() returned 0, succeeded.  Thread exiting
madvise11.c:175: TPASS: soft-offline/alloc stress test finished successfully
madvise11.c:316: TINFO: Restore 900 Soft-offlined pages
tst_test.c:1583: TBROK: Test killed by SIGSEGV!

Summary:
passed   2
failed   0
broken   1
skipped  0
warnings 0

But running more, i.e. 5 iterations, I don't get SIGSEGV.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
