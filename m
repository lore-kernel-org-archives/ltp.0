Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E16FC5935
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 11:33:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0F79A3CB8C5
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 12:33:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C85C3C29FF
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 12:33:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6EFCF200935
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 12:33:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BF0504D25D;
 Thu, 26 Feb 2026 11:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772105599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CE62q81qEA8z4nlIQP+ceIk2oALmC3qTUXSwsic+Gls=;
 b=fDBwy+jhDMu9H++WlOLfm+0q8dAhgIZ2UMSpMjIMor0x92TmpOhU4VaQ10u2Q2MXUGhYxo
 2Z6LlbafJN+Y2x0CAYEGHEXZGy1sAjMY9PY+XmhGFTfSkfsAhU3uibgBMWmVLc3uvCiyrj
 T8g7TTTD41cLsZdrrTO3SKqzhVIpDCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772105599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CE62q81qEA8z4nlIQP+ceIk2oALmC3qTUXSwsic+Gls=;
 b=6te4P8UjUlfds+IchPGY+7Ms7AUNEoTndXYHwnLmpLduTbPDxZGJ+eiHjrwuv2LFJoTkWu
 uKbSPBdWC7rGafBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CV65KPja;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="1IaCw/lL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772105598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CE62q81qEA8z4nlIQP+ceIk2oALmC3qTUXSwsic+Gls=;
 b=CV65KPjaS5nlpS8WZAZKFAuSRhUXCJeo8VHbmjPqvwlVgp0/BKvwgxX64EVrU+anmgYFUF
 dH3siuJ0WMlQOzE1n5CkXZQWidDsMs2VJkUEXqw4hZz/7J5o5nCb0IY4EzFQ4hyQfV66LJ
 aDz7TODSWU+gECL8ol5wj+yVOS5b8to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772105598;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CE62q81qEA8z4nlIQP+ceIk2oALmC3qTUXSwsic+Gls=;
 b=1IaCw/lLx1Psi760Brrr4djrjrKp7KsMTkF6hX/vmgVG7WdRdBwZirQILDVxxhssEIFY18
 OKEDpA+qfnftQ2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A90883EA62;
 Thu, 26 Feb 2026 11:33:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t1Q1KX4voGnEXAAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 26 Feb 2026 11:33:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 6C2FEA0A27; Thu, 26 Feb 2026 12:33:14 +0100 (CET)
Date: Thu, 26 Feb 2026 12:33:14 +0100
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <fphyc5rbamxl3ddsmzo6wl7paq5ehmgmhipxg324gsy6mvrlik@57sf4p47a67s>
References: <20260220154742.54150-1-mdoucha@suse.cz>
 <20260220154742.54150-3-mdoucha@suse.cz>
 <aZyApOha4WN9Y1lw@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aZyApOha4WN9Y1lw@yuki.lan>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_LAST(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,lists.linux.it,gmail.com];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BF0504D25D
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add test for fanotify monitoring of tracing
 filesystem
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
Cc: Jan Kara <jack@suse.cz>, ppavlu@suse.cz,
 Amir Goldstein <amir73il@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 23-02-26 17:30:28, Cyril Hrubis wrote:
> Hi!
> CCing Jan and Amir.
> 
> > Add a test that will start monitoring the kernel tracing filesystem,
> > write new configuration into tracing sysfiles and then verify
> > that the writes triggered fanotify events.
> > 
> > Signed-off-by: Martin Doucha <mdoucha@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> > ---
> >  runtest/syscalls                              |   1 +
> >  runtest/tracing                               |   1 +
> >  testcases/kernel/syscalls/fanotify/.gitignore |   1 +
> >  .../kernel/syscalls/fanotify/fanotify25.c     | 126 ++++++++++++++++++
> >  4 files changed, 129 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify25.c
> > 
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index 2f629e4e4..30224f5b4 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -671,6 +671,7 @@ fanotify21 fanotify21
> >  fanotify22 fanotify22
> >  fanotify23 fanotify23
> >  fanotify24 fanotify24
> > +fanotify25 fanotify25
> >  
> >  ioperm01 ioperm01
> >  ioperm02 ioperm02
> > diff --git a/runtest/tracing b/runtest/tracing
> > index d2700ca57..674e2ad97 100644
> > --- a/runtest/tracing
> > +++ b/runtest/tracing
> > @@ -3,6 +3,7 @@ ftrace_regression01	ftrace_regression01.sh
> >  ftrace_regression02	ftrace_regression02.sh
> >  ftrace-stress-test	ftrace_stress_test.sh 90
> >  dynamic_debug01		dynamic_debug01.sh
> > +fanotify25 fanotify25
> >  pt_full_trace_basic pt_test
> >  pt_snapshot_trace_basic pt_test -m
> >  pt_ex_user pt_test -e user
> > diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
> > index 16af3db85..d6d0599f1 100644
> > --- a/testcases/kernel/syscalls/fanotify/.gitignore
> > +++ b/testcases/kernel/syscalls/fanotify/.gitignore
> > @@ -22,4 +22,5 @@
> >  /fanotify22
> >  /fanotify23
> >  /fanotify24
> > +/fanotify25
> >  /fanotify_child
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify25.c b/testcases/kernel/syscalls/fanotify/fanotify25.c
> > new file mode 100644
> > index 000000000..c982f3225
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
> > @@ -0,0 +1,126 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2026 SUSE LLC
> > + * Author: Petr Pavlu <ppavlu@suse.cz>
> > + * LTP port: Martin Doucha <mdoucha@suse.cz>
> > + */
> > +
> > +/*\
> > + * Verify that fanotify monitoring can be applied to the tracing filesystem
> > + * and write events will be correctly delivered.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include "tst_test.h"
> > +#include "lapi/mount.h"
> > +
> > +#ifdef HAVE_SYS_FANOTIFY_H
> > +#include "fanotify.h"
> > +
> > +#define MNTPOINT "/sys/kernel/tracing"
> > +#define EVENTS_SYSFILE MNTPOINT "/kprobe_events"
> > +
> > +static const struct traceconfig {
> > +	const char *filename;
> > +	const char *wdata;
> > +} trace_cmds[] = {
> > +	{EVENTS_SYSFILE, "p:ltp_load_module_0 load_module"},
> > +	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "1"},
> > +	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "0"},
> > +	{EVENTS_SYSFILE, "-:ltp_load_module_0"},
> > +	{}
> > +};
> > +
> > +static int fan_fd = -1;
> > +static int unmount_needed;
> > +
> > +static void setup(void)
> > +{
> > +	if (tst_fs_type(MNTPOINT) != TST_TRACEFS_MAGIC) {
> > +		SAFE_MOUNT("tracefs", MNTPOINT, "tracefs",
> > +			MS_NODEV | MS_NOEXEC | MS_NOSUID, NULL);
> > +		unmount_needed = 1;
> > +	}
> > +
> > +	if (access(EVENTS_SYSFILE, F_OK))
> > +		tst_brk(TCONF, "Kprobe events not supported by kernel");
> > +
> > +	fan_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK, O_RDONLY);
> > +	SAFE_FANOTIFY_MARK(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT, FAN_MODIFY,
> > +		-1, MNTPOINT);
> > +}
> > +
> > +static void do_child(void)
> > +{
> > +	int i, fd, events, ret;
> > +	pid_t pid = getpid();
> > +	struct fanotify_event_metadata buf;
> > +
> > +	for (i = 0, events = 0; trace_cmds[i].filename; i++) {
> > +		fd = SAFE_OPEN(trace_cmds[i].filename, O_WRONLY, 0644);
> > +		SAFE_WRITE(1, fd, trace_cmds[i].wdata,
> > +			strlen(trace_cmds[i].wdata));
> > +		SAFE_CLOSE(fd);
> > +
> > +		while ((ret = read(fan_fd, &buf, sizeof(buf))) > 0) {
> > +			if (buf.pid != pid)
> > +				continue;
> > +
> > +			if (!(buf.mask & FAN_MODIFY)) {
> > +				tst_res(TFAIL, "Unexpected event %llx",
> > +					buf.mask);
> > +				continue;
> > +			}
> > +
> > +			events++;
> > +		}
> > +
> > +		if (ret < 0 && errno != EAGAIN)
> > +			tst_res(TFAIL | TERRNO, "fanotify read() failed");
> > +	}
> > +
> > +	if (events == i)
> > +		tst_res(TPASS, "Received %d events", events);
> > +	else
> > +		tst_res(TFAIL, "Received %d events, expected %d", events, i);
> > +}
> > +
> > +static void run(void)
> > +{
> > +	/*
> > +	 * Fork a child to do the actual trace writes, otherwise tracefs
> > +	 * would be busy until the current process exits and it would become
> > +	 * impossible to unmount in cleanup().
> > +	 */
> > +	if (!SAFE_FORK()) {
> > +		do_child();
> > +		SAFE_CLOSE(fan_fd);
> > +		exit(0);
> > +	}
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (fan_fd >= 0)
> > +		SAFE_CLOSE(fan_fd);
> > +
> > +	if (unmount_needed)
> > +		SAFE_UMOUNT(MNTPOINT);
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.needs_root = 1,
> > +	.forks_child = 1,
> > +	.taint_check = TST_TAINT_W | TST_TAINT_D,
> > +	.needs_kconfigs = (const char *[]) {
> > +		"CONFIG_TRACING",
> > +		NULL
> > +	}
> > +};
> > +
> > +#else
> > +	TST_TEST_TCONF("system doesn't have required fanotify support");
> > +#endif
> > -- 
> > 2.52.0
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
