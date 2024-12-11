Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F12E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 19:00:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D7AD3E9B24
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 20:00:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A30E53E8A10
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 20:00:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63DB763D16E
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 20:00:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB8151F38C;
 Wed, 11 Dec 2024 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733943627;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4eJCvWb8qX1U9BXfR6tBG+A9k7Tqfk+5Z+ge9Eu6y4=;
 b=pakGRQGhJcqeg8VBOsh+wubJnV5V8Rv2CBXzJq7+vSc6EJgD599vGGvBU60JzqwTSZInkY
 sTsXEwvJR2Fes07hPJQbGb+2ZR3L80zx1pKVGHT/A9wZtEx1U+fI6cqCx1Rpd2sE7wKDVY
 s3jkdhS4B7pkBCea8EhbjTf0PujD/b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733943627;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4eJCvWb8qX1U9BXfR6tBG+A9k7Tqfk+5Z+ge9Eu6y4=;
 b=bjuDEsm7tsxqQDbYe+Lj9KlgF2QKxNtmTvLPJeZIUO7arhbDX9WGYVmDWw4vMWVMJufo+f
 CQrNDltI5E0a5qAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733943627;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4eJCvWb8qX1U9BXfR6tBG+A9k7Tqfk+5Z+ge9Eu6y4=;
 b=pakGRQGhJcqeg8VBOsh+wubJnV5V8Rv2CBXzJq7+vSc6EJgD599vGGvBU60JzqwTSZInkY
 sTsXEwvJR2Fes07hPJQbGb+2ZR3L80zx1pKVGHT/A9wZtEx1U+fI6cqCx1Rpd2sE7wKDVY
 s3jkdhS4B7pkBCea8EhbjTf0PujD/b0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733943627;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u4eJCvWb8qX1U9BXfR6tBG+A9k7Tqfk+5Z+ge9Eu6y4=;
 b=bjuDEsm7tsxqQDbYe+Lj9KlgF2QKxNtmTvLPJeZIUO7arhbDX9WGYVmDWw4vMWVMJufo+f
 CQrNDltI5E0a5qAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FCCD13927;
 Wed, 11 Dec 2024 19:00:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LAN4DkvhWWe4BgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 11 Dec 2024 19:00:27 +0000
Date: Wed, 11 Dec 2024 20:00:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <20241211190017.GA440022@pevik>
References: <20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com>
 <20241211014710.GC383036@pevik>
 <heoebo5b4mslxrpopscllz7a2rfviwltnxsvtl6bvsd4h7gacz@kttzguhbtix2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <heoebo5b4mslxrpopscllz7a2rfviwltnxsvtl6bvsd4h7gacz@kttzguhbtix2>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap01: Convert to new API
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

> Hi Petr!

> On 11 Dec 24 02:47, Petr Vorel wrote:
> > Hi Ricardo,

> > ...
> > > +static void run(void)
> > >  {
> > > +	pid_t pid;
> > > +
> > > +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE,
> > > +			 MAP_FILE | MAP_SHARED, fildes, 0);
> > > +
> > > +	/*
> > > +	 * Check if mapped memory area beyond EOF are zeros and changes beyond
> > > +	 * EOF are not written to file.
> > > +	 */
> > > +	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz))
> > > +		tst_brk(TFAIL, "mapped memory area contains invalid data");
> > FYI test fails when run more iterations (e.g. -i2)


> Thanks for taking a look, but I don't see the issue here:

> # /opt/ltp/testcases/bin/mmap01 -i4
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmaiVJsAq as tmpdir (fuse filesystem)
> tst_test.c:1890: TINFO: LTP version: 20240930-73-g865be36ffce8
> tst_test.c:1894: TINFO: Tested kernel: 6.11.0-virtme #1 SMP PREEMPT_DYNAMIC Fri Oct  4 13:39:48 -03 2024 x86_64
> tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
> mmap01.c:49: TPASS: Functionality of mmap() successful YES
> mmap01.c:49: TPASS: Functionality of mmap() successful YES
> mmap01.c:49: TPASS: Functionality of mmap() successful YES
> mmap01.c:49: TPASS: Functionality of mmap() successful YES

> Summary:
> passed   4
> failed   0
> broken   0
> skipped  0
> warnings 0

> I appended the "YES" just to make sure I wasn't running some outdated
> code, can you please provide more details?

I have no idea myself. I verified if I'm using v4 [1] and I really do.
Can you please push the code you're using?
Your code I'm testing is in my fork [2].

Tested on more systems:

# ./mmap01 -i4
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmabiOth0 as tmpdir (tmpfs filesystem)
tst_test.c:1890: TINFO: LTP version: 20240930-116-g23f5a4447
tst_test.c:1894: TINFO: Tested kernel: 6.13.0-rc1-1.g492f944-default #1 SMP PREEMPT_DYNAMIC Mon Dec  2 08:55:00 UTC 2024 (492f944) x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
mmap01.c:49: TPASS: Functionality of mmap() successful
mmap01.c:68: TFAIL: mapped memory area contains invalid data

Summary:
passed   1
failed   1
broken   0
skipped  0
warnings 0

$ ./mmap01 -i4
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmakqgzvS as tmpdir (tmpfs filesystem)
tst_test.c:1890: TINFO: LTP version: 20240930-115-g786b808eda
tst_test.c:1894: TINFO: Tested kernel: 6.11-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.11 (2024-11-23) x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
mmap01.c:49: TPASS: Functionality of mmap() successful
mmap01.c:68: TFAIL: mapped memory area contains invalid data

Summary:
passed   1
failed   1
broken   0
skipped  0
warnings 0

[1] https://patchwork.ozlabs.org/project/ltp/patch/20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com/
[2] https://github.com/pevik/ltp/commit/a3c07097784088a679e77a4486bb10adfe03eea0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
