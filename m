Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B435BCD4F54
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 21:31:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5191A3D0F2F
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 23:31:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 631973CB44A
 for <ltp@lists.linux.it>; Thu, 28 May 2026 23:31:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C820B1400DB5
 for <ltp@lists.linux.it>; Thu, 28 May 2026 23:31:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 486436A836;
 Thu, 28 May 2026 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780003881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EhDOSm3PNuDXwATNhUE4VbyJpLCirdWTRshkoyXan/4=;
 b=VJ5Qwn8bqTvuurngYKnV+GrGXVVVwk5z8wbu+EdVezWcvtMusQnyBO1Jcn8t6VFihT+SV2
 zzY3MTbz8ZerjBqZqr9DqkPXbPHHmqwccd7Sb6kPmc43PdlklZMcidDwE3ZKTs2K8U0c85
 LOppM7sNtaBCuX1rjkTRdzFnWp/ymFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780003881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EhDOSm3PNuDXwATNhUE4VbyJpLCirdWTRshkoyXan/4=;
 b=IpJpo/WkRhYMLYB9AlR1d4/7VNp1Y6qnp/to6B6KhAGV/b7jwVO/a6I1E3bkYq1gg3Aj1N
 gidGkprYaoxVJSDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780003881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EhDOSm3PNuDXwATNhUE4VbyJpLCirdWTRshkoyXan/4=;
 b=VJ5Qwn8bqTvuurngYKnV+GrGXVVVwk5z8wbu+EdVezWcvtMusQnyBO1Jcn8t6VFihT+SV2
 zzY3MTbz8ZerjBqZqr9DqkPXbPHHmqwccd7Sb6kPmc43PdlklZMcidDwE3ZKTs2K8U0c85
 LOppM7sNtaBCuX1rjkTRdzFnWp/ymFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780003881;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EhDOSm3PNuDXwATNhUE4VbyJpLCirdWTRshkoyXan/4=;
 b=IpJpo/WkRhYMLYB9AlR1d4/7VNp1Y6qnp/to6B6KhAGV/b7jwVO/a6I1E3bkYq1gg3Aj1N
 gidGkprYaoxVJSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 135745AFCA;
 Thu, 28 May 2026 21:31:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Z0jWAim0GGqoIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 28 May 2026 21:31:21 +0000
Date: Thu, 28 May 2026 23:31:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260528213115.GA418635@pevik>
References: <20260523101749.27657-1-sebastian.chlad@suse.com>
 <20260523165718.26187-1-sebastian.chlad@suse.com>
 <20260524181639.GA26213@pevik>
 <11106a2a-175f-4b40-af46-d7ff4fb15c26@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <11106a2a-175f-4b40-af46-d7ff4fb15c26@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.com,lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] io_uring/pintheft: Add CVE-2026-43494
 regression test
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
Cc: ltp@lists.linux.it, Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

> Hi!

> On 5/24/26 20:16, Petr Vorel wrote:
> > > +	rds_fd = socket(AF_RDS, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
> > > +	if (rds_fd < 0) {
> > > +		if (errno == EAFNOSUPPORT || errno == ESOCKTNOSUPPORT ||
> > > +		    errno == EPROTONOSUPPORT || errno == ENOPROTOOPT)
> > > +			tst_brk(TCONF | TERRNO, "RDS is not available");
> > > +
> > > +		tst_brk(TBROK | TERRNO, "socket(AF_RDS) failed");

> > Just a quick Sunday evening comment (not yet looking into the reproducer itself).
> > I wonder if we need this complicated check when we already have kconfig based
> > checks at the end. Could we just simply use SAFE_SOCKET() here? Or have you
> > encountered problems with older kernels?

> I've checked, SAFE_SOCKET() will fail on kernel-default-base due to the
> usual kconfig-RPM mismatch.

Thanks for info! There will be more modules like this [*]. I also wonder if
SAFE_SOCKET() should not change to TCONF on these errnos, we do that already for
some safe functions (safe_io_uring_init(), safe_unshare(), safe_timerfd_*(). It
should be safe also in this case.

BTW isn't it that autoloading is not working? i.e. testing on some old machine
with Debian (i.e. not JeOS missing modules problem).
$ uname -r
6.18-amd64
# ./pintheft
...
pintheft.c:120: TCONF: RDS is not available: EAFNOSUPPORT (97)
=> module not autoloaded by socket() (or the other syscalls) => IMHO worth to
double check if it should be autoloaded and/or call "modprobe rds_tcp" in the test.

# modprobe rds
# ./pintheft
pintheft.c:337: TFAIL: Kernel is vulnerable: tainted during RSS accounting checks
tst_test.c:1928: TFAIL: Kernel is now tainted
=> loading manually it detects it

# rmmod rds_tcp
# rmmod rds
# ./pintheft
tst_kconfig.c:90: TINFO: Parsing kernel config '/boot/config-6.18-amd64'
tst_taint.c:85: TCONF: Ignoring already set kernel warning taint
...
pintheft.c:274: TINFO: Completed 1024/1024 sendmsg() attempts with EFAULT
pintheft.c:359: TPASS: Kernel seems to have survived RDS zerocopy cleanup
=> are we really safe now? Maybe yes, as rds is not autoloaded automatically.

> > > +	if (clone_buffers(ring_fd2, ring_fd1)) {
> > > +		if (errno == EINVAL || errno == EOPNOTSUPP)
> > > +			tst_brk(TCONF | TERRNO, "IORING_REGISTER_CLONE_BUFFERS is not supported");
> > Also here do we need it? IMHO CONFIG_IO_URING should be enough.
> > And if errno is really needed, it'd IMHO be better to be in handled in
> > clone_buffers(), not separately.

> IORING_REGISTER_CLONE_BUFFERS was added in kernel v6.12 so the feature check
> is also needed.

Shouldn't the test require v6.12 then? Without it test TCONF anyway. Or you
expect being it backported? OTOH fix was backported to v6.6.141 (but IMHO test
is not able to test that old kernel).

$ uname -r
6.9.9-amd64
# ./pintheft
pintheft.c:120: TCONF: RDS is not available: EAFNOSUPPORT (97)
# modprobe rds
# ./pintheft
pintheft.c:169: TCONF: IORING_REGISTER_CLONE_BUFFERS is not supported: EINVAL (22)

$ uname -r
6.12.38+deb13-amd64
# ./pintheft
pintheft.c:120: TCONF: RDS is not available: EAFNOSUPPORT (97)
# modprobe rds
# ./pintheft
pintheft.c:337: TFAIL: Kernel is vulnerable: tainted during RSS accounting checks
tst_test.c:1928: TFAIL: Kernel is now tainted

# rmmod rds_tcp
# modprobe rds
# modprobe rds_tcp
tst_taint.c:85: TCONF: Ignoring already set kernel warning taint
pintheft.c:359: TPASS: Kernel seems to have survived RDS zerocopy cleanup

Kind regards,
Petr

[*] I.e. any module which cannot be detected via /proc/sys like check in
lib/tst_kconfig_checks.h; I was even thinking about checking via /proc/modules
or /sys/module/*/, but that would work only to double check if module
autoloading or direct loading with modprobe work. Maybe too complicated, but for
tests which call modprobe on some modules e.g. hwpoison_inject or zram it could
be useful.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
