Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78045C32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 10:32:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E8363CA1B5
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:32:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 460373CA1A4
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:31:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 97FED600735
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 12:31:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DD3534B98;
 Fri, 19 Aug 2022 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660905110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFFi2+w5ruWH1gSQkHztYKEB1VHDFWTH5wAfYVgm5Dw=;
 b=UsvGFNup5aHkC/ERxpXC4fFcoeVOPvYHrWFjhrVAFbzfwGlZLS4hpIeX1banpDiM4Wwuw0
 CYEmbAhyI7JaKIcOTF9aeP2vA1f9Oy4bUMh5PalW0a02ggR5nh7bLEBPfiNvgUTm9wXaud
 1q+rK4tSWxuF8B6joGlW9BAjjiWWTAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660905110;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFFi2+w5ruWH1gSQkHztYKEB1VHDFWTH5wAfYVgm5Dw=;
 b=dADsqkPugGnIDh9ZBwwsGUZrWlrO+4+4zLQtcoarbMvrJEQkJYqA+OoHL489cCslA9VA7L
 1TTW6HujjzchjUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 742EC13AE9;
 Fri, 19 Aug 2022 10:31:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wdToGpZm/2JDGAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 10:31:50 +0000
Date: Fri, 19 Aug 2022 12:31:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Yv9mlIgAZ/xjE1C/@pevik>
References: <20220818171724.9182-1-pvorel@suse.cz> <Yv9Jafy8AzSCH437@yuki>
 <Yv9lxML3bw61wI1o@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yv9lxML3bw61wI1o@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] bpf_prog0[5-7]: Run with
 kernel.unprivileged_bpf_disabled = 0
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

> > Hi!
> > > --- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
> > > +++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
> > > @@ -209,6 +209,11 @@ static struct tst_test test = {
> > >  		{&msg, .size = sizeof(MSG)},
> > >  		{}
> > >  	},
> > > +	.needs_root = 1,
> > > +	.save_restore = (const struct tst_path_val[]) {
> > > +		{"?/proc/sys/kernel/unprivileged_bpf_disabled", "0"},
> > > +		{}
> > > +	},

> > If we set needs_root the test would run under root and there is no need
> > to fiddle with the unprivileged_bpf_disabled at all.

> I expected that as well, but well, I don't know why, but:

> # cat /proc/sys/kernel/unprivileged_bpf_disabled
> 2

> # id
> uid=0(root) gid=0(root) groups=0(root)

> # ./bpf_prog05
> tst_buffers.c:55: TINFO: Test is using guarded buffers
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> bpf_common.c:16: TINFO: Raising RLIMIT_MEMLOCK to 10485760
> tst_capability.c:29: TINFO: Dropping CAP_SYS_ADMIN(21)
> tst_capability.c:29: TINFO: Dropping CAP_BPF(39)
Maybe dropping CAP_BPF() causes that even running root is not enough.

Kind regards,
Petr

> bpf_common.c:39: TCONF: Hint: check also /proc/sys/kernel/unprivileged_bpf_disabled
> bpf_common.c:40: TCONF: bpf() requires CAP_SYS_ADMIN or CAP_BPF on this system: EPERM (1)

> Summary:
> passed   0
> failed   0
> broken   0
> skipped  2
> warnings 0

> I.e. 1 or 2 kernel.unprivileged_bpf_disabled results bpf() returning EPERM for
> *all* users including root. 0 allows running again for all users, but we need
> root to set it 0 via .save_restore:

> tst_sys_conf.c:106: TBROK: Failed to open FILE '/proc/sys/kernel/unprivileged_bpf_disabled' for writing: EACCES (13)

> Maybe we could change tst_sys_conf_save() not to write the value if value can be
> read and is the same (and not run tst_sys_conf_restore() if value was the same).

> That way we would not need to require root if value is the same.

> But it'd be nice to have some tag saying: maybe root is needed, depend on sysfs
> value...

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
