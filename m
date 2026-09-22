Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B60C982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 09:25:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E8EE3E6CB0
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 11:25:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EDD43E1CC9
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 11:25:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CC17600356
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 11:25:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52ACA21D6C;
 Tue, 22 Sep 2026 09:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790069134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soMuN9sINCHVoJKkNwCkTc8Qb7FDY4ay5v6X4X5xuNQ=;
 b=yIFUPFi32lr4+UzKj9NtDo1J94tKQbawYcOWYBsX/sQv/eDzVIwVm2nCFtG4/XtcX++QfQ
 9OOPEpbsP2TpMUHnLzN790RDr+5GctYbh5xxjIhUkujQZoPIWsEvdt4+x/MH54ef660qEK
 y4beOhIVdUOtjrGz+sDJToWAOVGhmCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790069134;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soMuN9sINCHVoJKkNwCkTc8Qb7FDY4ay5v6X4X5xuNQ=;
 b=f5lM/wsG88ogV+XQfmIpkF3rmvqA0uFcnPR3D3cf91ZxPjDqfc/S+bJkhFRaNPfAVHSZYN
 A6GtyppRH02BYgAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790069130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soMuN9sINCHVoJKkNwCkTc8Qb7FDY4ay5v6X4X5xuNQ=;
 b=omsmVgtzLPhB2fCvXQ/9boimIj3HHMks//DFL3DADZbHRtnEx7e05W899agVP87V/OqbUc
 54paEYnk0xVXDJTmJ42rvj4O/JX7PFt5zWaYZ9zyoRkxf3V3GlRl+eyNcBWC8ydTsEQu1o
 Lu4vc+vjBmKpL5lMuLDhb+TJUvLmarg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790069130;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soMuN9sINCHVoJKkNwCkTc8Qb7FDY4ay5v6X4X5xuNQ=;
 b=JCozVY/nUh21PUwQh7ibyF8/Ixa7TvXSesudIpgGzC5BSptSfjlcRCZGJzhfjyhF5L4dvE
 AMKgnhn18zywSeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1588139EE;
 Tue, 22 Sep 2026 09:25:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3N2VMYlJsmqUYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 09:25:29 +0000
Date: Tue, 22 Sep 2026 11:25:24 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>, ltp@lists.linux.it,
 Jan Stancek <jstancek@redhat.com>, Li Wang <li.wang@linux.dev>,
 Michael Menasherov <mmenashe@redhat.com>
Message-ID: <20260922092524.GA2161916@pevik>
References: <20260918194316.109853-1-avinesh.kumar@suse.com>
 <20260921085403.GA2052539@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260921085403.GA2052539@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] coredump01: Skip pipe core_pattern under SELinux
 enforcing
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh, all,

> Hi Avinesh,

> thanks for the fix, merged.

FYI I was not able to reproduce the problem on 2 older Tumbleweed versions:

$ getenforce
Enforcing

$ uname -r
7.2.0-1-default # Tumbleweed VERSION="20260826"
6.17.0 # Tumbleweed VERSION="20250310"

$ cat /proc/cmdline
... security=selinux selinux=1 ...


$ rpm -qa |grep -i selinux # Tumbleweed VERSION="20260826"
libselinux1-3.8-2.2.x86_64
libselinux-devel-3.8-2.2.x86_64
selinux-tools-3.8-2.2.x86_64
python313-selinux-3.8-2.3.x86_64
selinux-autorelabel-4.0+git7-1.2.x86_64
selinux-policy-20250305-1.2.noarch
selinux-policy-targeted-20250305-1.2.noarch
container-selinux-2.234.2-1.2.noarch
patterns-base-selinux-20241218-5.1.x86_64
libselinux1-32bit-3.8-2.2.x86_64

coredump01.c:72: TPASS: core.%e.%p.%s expanded to core.coredump01.893495.6 passed
coredump01.c:57: TPASS: Expect: /tmp/LTP_corqUjmUe/core.coredump01.893495.6 starts with ELF magic
coredump01.c:58: TPASS: e_type == ET_CORE (4)
coredump01.c:126: TINFO: Testing pipe core_pattern
coredump01.c:107: TPASS: exe == "coredump01" (coredump01)
coredump01.c:108: TPASS: pid_seen == pid (893496)
coredump01.c:109: TPASS: sig_seen == SIGABRT (6)
coredump01.c:110: TPASS: Expect: coredump01_helper read 598016 bytes of ELF core dump
coredump01.c:111: TPASS: et_core == 1 (1)

Because we have these tests failing in our openQA testing it's a real problem.
I just wonder what setup / version bump caused it. I try to update my VM to see
if I'm able to reproduce it locally.

Kind regards,
Petr


> @Jan @Li @Michael FYI

> Kind regards,
> Petr

> > SELinux in enforcing mode silently blocks the kernel's usermode-helper
> > spawn for the piped core_pattern, so the helper never runs and the
> > test reports FAIL.

> > coredump01.c:126: TINFO: Testing pipe core_pattern
> > coredump01.c:100: TFAIL: coredump01_helper did not report any core dump

> > Skip with TCONF instead of failing.

> > Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> > ---
> >  testcases/kernel/coredump/coredump01.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)

> > diff --git a/testcases/kernel/coredump/coredump01.c b/testcases/kernel/coredump/coredump01.c
> > index c4fb92e4dcb0..15aaf8c56143 100644
> > --- a/testcases/kernel/coredump/coredump01.c
> > +++ b/testcases/kernel/coredump/coredump01.c
> > @@ -31,12 +31,14 @@

> >  #include "coredump_common.h"
> >  #include "tst_kconfig.h"
> > +#include "tst_security.h"

> >  #define HELPER "coredump01_helper"
> >  #define HELPER_TIMEOUT 10

> >  static char helper_path[PATH_MAX];
> >  static int static_usermodehelper;
> > +static int selinux_enforcing;

> >  /*
> >   * e_ident[] and e_type live at the same file offset in ELF32 and ELF64,
> > @@ -89,6 +91,11 @@ static void verify_pipe_pattern(void)
> >  		return;
> >  	}

> > +	if (selinux_enforcing) {
> > +		tst_res(TCONF, "SELinux is enforcing, skipping pipe core_pattern");
> > +		return;
> > +	}
> > +
> >  	set_pattern("|%s %%e %%p %%s %s/res.%%p", helper_path, cwd);

> >  	pid = crash_child();
> > @@ -137,6 +144,8 @@ static void setup(void)
> >  	tst_kconfig_read(&kconfig, 1);
> >  	static_usermodehelper = (kconfig.choice == 'y');

> > +	selinux_enforcing = tst_selinux_enforcing();
> > +
> >  	if (tst_get_path(HELPER, path, sizeof(path)))
> >  		tst_brk(TCONF, "'%s' not found in $PATH", HELPER);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
