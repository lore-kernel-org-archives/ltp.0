Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A148C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 16:14:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EED1A3C8BB8
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 17:14:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA2C33C013D
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:14:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D991200A11
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:14:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0DD501F3B9;
 Mon, 13 Dec 2021 16:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639412067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M22CaOmdS0awcHan5F/m2Ya0oSlaCxy5Cd0XdTEi2nE=;
 b=sJQEul7y7eirDFirp2gVpP0XrJr3zj2bf1PHHQ3UU7JR+wpndLPzIhZrYA5noGp7togGzW
 BHq78plk82BtRY+jE/N+PvfLUlBObxJiF3rZ9fR4gTVvMiYy4n0SSgS9yKwaw7RPvqPOX2
 hfH8LojQsQPKPKD47hoCnW/VRBayk2w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639412067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M22CaOmdS0awcHan5F/m2Ya0oSlaCxy5Cd0XdTEi2nE=;
 b=HILA5B/EtebVfMA/CvnK7/zfUUPxRRB4auBNGHhIVXIhBUo4+JNK/Y/R8ty1hu9l12KUDd
 dwhH8Uo0zlCEFaDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDA8613E3A;
 Mon, 13 Dec 2021 16:14:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vHbOOGJxt2GYWAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Dec 2021 16:14:26 +0000
Date: Mon, 13 Dec 2021 17:15:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Ybdxt/KBUQ6ZKHmY@yuki>
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
 <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
 <85404e01-f8f0-7209-8ce1-9e8a2a416e86@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <85404e01-f8f0-7209-8ce1-9e8a2a416e86@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] enable OOM protection for the library and test
 process?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > There are likely more processes that could become unintended targets
> > (e.g. harness process)
> > (if we haven't tried already) Could we make expected victim process
> > more appealing target by tweaking its oom_score/oom_score_adj ?
> 
> I'm afraid it won't be that easy. The main cause of OOM killer going
> postal and killing processes with tiny memory footprint is that a
> process executing the mlock() syscall cannot be targeted by OOM killer
> at all. That's a known issue in the kernel with no easy fix.

This is only single test out of at least 10 that can trigger OOM, right?

> You can protect the main test process using oom_score_adj but chances
> are that OOM killer will just kill PID 1 (kernel panic), or find no
> killable process left (also kernel panic).
> 
> Protecting the test harness is a bad idea because oom_score_adj is
> inherited by child processes and it'll affect other tests as well. Given
> the nature of OOM tests, I'd rather not assume that the protection will
> be properly removed at the end.

This should be easily doable since the test library forks right before
it executes the test, so we have a single place where the score has to
be reset.

For new library tests there is a process that does nothing but waits for
the actuall test pid to finish and kills it on timeout. It really makes
sense to protect this exact process and maybe even mlock() it into the
memory.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
