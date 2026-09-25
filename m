Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39212C98326
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 06:55:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B0CF3E6138
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 08:55:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D40013C5493
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 08:55:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 09F5C140013A
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 08:55:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E97B1FDAD;
 Fri, 25 Sep 2026 06:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790319315;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LTSczxXjCN8O8IOYO9MhrAE1GMKsxxWf3yMc4IoC8yM=;
 b=PELXIPsk5trkbyn45nyJ6refpLAylzvPn3kNDV4x4tj1d9huHcsUNQGd1dkF8t6ezdWB9l
 mZIed0/hi4GDM3JRV+5kTUVbOxi0vhn+vUTKjdqV3HGxNKid0GeNzIhf5pPD3I7HwpEBxg
 qC/zx5bNxEmo71q4TjffItXINswwe7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790319315;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LTSczxXjCN8O8IOYO9MhrAE1GMKsxxWf3yMc4IoC8yM=;
 b=QD6hnTcJBrCqFVL6cTzVzdjYk5uNqkWCRP9qIAa94NB9bCgX5une6HohzFWtk23RBkENOy
 iwM9uR3+NnjIdSDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790319311;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LTSczxXjCN8O8IOYO9MhrAE1GMKsxxWf3yMc4IoC8yM=;
 b=FswYIGzxQI55weud4la4wvo7sURAe/Rfc00rDi8mHyRODMxJofcx2VnfouR/JoK+2NmQwn
 QbBg8QZgtO7jvEaR9YyjAdom/oW22Q5TQC7gR6q8t8LbEok5b8TDckiAAqeja+Bm7Gjm+6
 9SgRrrMB6Xq60/HWpey05ECqQzkmQSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790319311;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LTSczxXjCN8O8IOYO9MhrAE1GMKsxxWf3yMc4IoC8yM=;
 b=muTnFGABqDXod3ztTBzPwz+PelSWmAabNRYbBZYZF0YSPoo2PRYfc/gqMAKF0T7a4S6pQ6
 fCym51ybymrMAoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDBB513432;
 Fri, 25 Sep 2026 06:55:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qd00I84atmoXawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Sep 2026 06:55:10 +0000
Date: Fri, 25 Sep 2026 08:55:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260925065505.GB2387785@pevik>
References: <20260924112514.2375626-2-pvorel@suse.cz>
 <20260924132408.4225-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260924132408.4225-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_assert: Use 'long long' to fix 32bit compat mode
 truncation
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

> Hi Andrea,

> On Thu, 24 Sep 2026 13:25:12 +0200, Andrea Cervesato wrote:
> > [PATCH 1/3] tst_assert: Use 'long long' to fix 32bit compat mode truncation

> --- [PATCH 1/3] ---

> > @@ -25,16 +25,17 @@ void tst_assert_int(const char *file, const int lineno, const char *path, int va

> >  void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
> >  {
> > -	unsigned long sys_val;
> > +	unsigned long long sys_val;

> > -	safe_file_scanf(file, lineno, NULL, path, "%lu", &sys_val);
> > +	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val);

> > -	if (val == sys_val) {
> > +	if (val == (unsigned long)sys_val) {
> >  		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
> >  		return;
> >  	}

> > -	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
> > +	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
> > +		path, val, (unsigned long)sys_val);
> >  }

> Casting sys_val to (unsigned long) truncates values exceeding ULONG_MAX on
> 32-bit systems, causing false passes when (sys_val & 0xFFFFFFFF) == val and
> printing a truncated value on failure. Compare values without truncation
> using (unsigned long long)val == sys_val, and print sys_val with %llu on
> mismatch. Handling of 32-bit compat truncation for /proc/sys/kernel/shmall
> should be done in shmctl03.c instead of altering generic library assertions.

I wonder if it's safe to ignore this.

> --- [PATCH 2/3] ---

> > @@ -30,7 +30,14 @@ static void verify_ipcinfo(void)
> >  	else
> >  		tst_res(TPASS, "shmmin = 1");

> > -	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> > +	if (tst_is_compat_mode() && info.shmmax == INT_MAX) {
> > +		unsigned long long shmmax;
> > +		SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%llu", &shmmax);
> > +		TST_EXP_LE_LU(INT_MAX, shmmax);
> > +	} else {
> > +		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> > +	}
> > +

> Branching on info.shmmax == INT_MAX conditions on the result of the syscall
> under test, and TST_EXP_LE_LU(INT_MAX, shmmax) only asserts that the sysctl
> file is >= INT_MAX rather than verifying that info.shmmax was clamped.

I wonder if it's really important to verify it was clamped.

> Read PATH_KERN_SHMMAX into shmmax first, and if in compat mode with
> shmmax >= INT_MAX, assert TST_EXP_EQ_LU(info.shmmax, (unsigned long)INT_MAX);
> otherwise assert info.shmmax == shmmax.

OK, reading it twice is not optimal.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
