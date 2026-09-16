Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A138C88E77
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 11:34:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68C8C3E7B87
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 13:34:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9939D3E68E4
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 13:33:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F1852200215
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 13:33:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EE03E21C72;
 Wed, 16 Sep 2026 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789558425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOVqqv2rKELqt2R8DxOmSYPzqT0Y3ZsJBoIKj0MC5Iw=;
 b=odMdhDYc3jBQSEHfAqfjo5wJxnFpdZo9Iqnu9LeodSRkAXsHHt5qpwemgNMv2GJSqfLnmC
 Vx1OT83qZBteFPMiETzCe+hp9L6610pUUZ9Vy1AjhRgNAWK9Tk+K7GTCtH3hRvWUNg3bcV
 7KxCWAji762ufZvbMbpKHRLnM0t11K8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789558425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOVqqv2rKELqt2R8DxOmSYPzqT0Y3ZsJBoIKj0MC5Iw=;
 b=YTn3FIZFZazpM++jlVgQ+GbRbHqB6cu9SJYt/2LRxC45pRR9hxsKkEczGSXAAasUF+cCbo
 sPms7d78vDmI+5CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789558420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOVqqv2rKELqt2R8DxOmSYPzqT0Y3ZsJBoIKj0MC5Iw=;
 b=VBYqfghcXxe2Y8pxxMB9M4esrs47E/Kmcz3ogPYSaaxMy6nf4Tkls87effSE52Lb6ql2Jp
 D6MbUAZfS9KjSVYxCjM3H1iUZeBgMEBCp8cLpXXnxKOA+JsBm5HskEOS4G+kArhUPYUZRj
 iXxPBhtWdVpUsS8D25LebAZ/ZfrLO34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789558420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qOVqqv2rKELqt2R8DxOmSYPzqT0Y3ZsJBoIKj0MC5Iw=;
 b=QDo4ETD01Y5bcnvJxDsBAiz+UYJRmN4IXURL3oBgCqb0H4dRH/3fhZ6rsbYDnsQpf3pFu5
 QR/N8oydmMKkJdAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BC231348F;
 Wed, 16 Sep 2026 11:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TwbJGpR+qmqcIQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 11:33:40 +0000
Date: Wed, 16 Sep 2026 13:33:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260916113339.GA1756857@pevik>
References: <20260903095255.4925-2-wegao@suse.com>
 <6a9a867b.de81f790.219d91.7092@mx.google.com>
 <ap5n5QV5xneoAFYm@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ap5n5QV5xneoAFYm@autotest-wegao.qe.prg2.suse.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11 1/2] lib: Extend tst_assert_ulong() with enum
 flags
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

> On Fri, Sep 04, 2026 at 08:51:06AM +0000, Andrea Cervesato wrote:
> > H Wei,

> > I was re-checking the whole patch-set and it looks a bit overengineered
> > from my point of view. A few points below.

> > > +enum tst_assert_flags {
> > > +	TST_ASSERT_SATURATED_INT = 1,
> > > +	TST_ASSERT_TRUNC_32BIT   = 2,
> > > +};

> > Adding new flags for the whole LTP core library trying to fix a single
> > test is not a good idea in general. Also, TST_ASSERT_TRUNC_32BIT is
> > probably not needed.

> But this is follow Cyril's suggestion:
> https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/

FYI the informal rule Cyril announced few weeks ago "at least two tests needs
it" (we talked about .max_kver member of struct tst_test, I guess this would
more or less applied to library API code.

When I acked this in v9 [1] (after suggesting to use enum instead of #define in
v8 [2]) I expected it'd be actually needed in more tests, based on Cyril's
suggestion.

Anyway, Dan Carpenter mentioned [3] kernel commit af7c693f1460
("Cap shmmax at INT_MAX in compat shminfo") which does 

+       if (smi->shmmax > INT_MAX)
+               smi->shmmax = INT_MAX;

[1] https://lore.kernel.org/ltp/20260902090418.GA910767@pevik/
[2] https://lore.kernel.org/ltp/20260828092602.GA715959@pevik/
[3] https://lore.kernel.org/ltp/aJYBSmcQpbHUvOqW@stanley.mountain/

Searching in kernel git

$ git grep -A2 'if.* > INT_MAX' |grep ' = INT_MAX' 

I found only:

block/bfq-iosched.c
drivers/usb/class/usbtmc.c
drivers/xen/pvcalls-front.c
fs/ext4/inode.c
include/net/netfilter/nf_conntrack_core.h
ipc/shm.c
kernel/time/itimer.c
lib/vsprintf.c
net/mptcp/protocol.c
sound/core/oss/pcm_oss.c
tools/lib/bpf/ringbuf.c

IMHO none of them uses export data truncated by INT_MAX to sysfs.

> > > +	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val_64);

> > This is the real fix. Read below.

> > > +
> > > +	if (flags & TST_ASSERT_SATURATED_INT) {
> > > +		if (sys_val_64 > (unsigned long long)INT_MAX)
> > > +			expected_val = (unsigned long)INT_MAX;
> > > +		else
> > > +			expected_val = (unsigned long)sys_val_64;
> > > +	} else if (flags & TST_ASSERT_TRUNC_32BIT) {

> > In 32bit compat mode `unsigned long` becomes 32bit, so we can simply do:

> > void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
> > {
> > 	unsigned long long sys_val;

> > 	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val);

> > 	if (val == (unsigned long)sys_val) {
> > 		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
> > 	}

> > 	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
> > 		path, val, (unsigned long)sys_val);
> > }

> > And then, inside the test:

> > 	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
> > 		tst_res(TPASS, "shmmax clamped to INT_MAX in compat mode");
> > 	else
> > 		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);

> > 	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
> > 	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);

Looks like quite elegant solution, give we really need it just for a single
test.

> > Please verify if this is working anyway. We can probably fix the
> > whole patch-set with a couple of lines instead of defining
> > redundant flags and specific code for a single test.

Yes it works.

=> I vote to merge Andrea's solution instead.
@Cyril @Li WDYT?

Kind regards,
Petr

> > Regards,
> > --
> > Andrea Cervesato
> > SUSE QE Automation Engineer Linux
> > andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
