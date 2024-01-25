Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103C0C47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 11:04:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E0223CE1D6
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 12:04:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 157B33C5D1E
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 12:03:57 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8116B200C67
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 12:03:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E62A21E21;
 Thu, 25 Jan 2024 11:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706180635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqsS+t0mWOa5o8YVEsAUPKEH/2WY6qUD2PhHmAt/tW0=;
 b=NHWKuNtbrIz9IscP88DLyPkCLv7g6dLfTy9AAq9Xl67gQuOk/MlbMZIKf3VdRvJMT/Nkwe
 ZhOCPx4G61QF70N8q/FJjj/FbupFmEJkUap8Nb/8XP2rnlprbhcfdM5rTtKZQHbsn9raPk
 CzWjU0/V8KUwU9BvuE3SqHjWDMn3WKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706180635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqsS+t0mWOa5o8YVEsAUPKEH/2WY6qUD2PhHmAt/tW0=;
 b=nIs9hq2duWXeDV2SOxxJuNx3KaR+P0jWJIHEPvpc8G/PzRtuSDSxYBIrItwLqv0+jnqnnD
 bYC0snPh6mzuY2Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706180635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqsS+t0mWOa5o8YVEsAUPKEH/2WY6qUD2PhHmAt/tW0=;
 b=NHWKuNtbrIz9IscP88DLyPkCLv7g6dLfTy9AAq9Xl67gQuOk/MlbMZIKf3VdRvJMT/Nkwe
 ZhOCPx4G61QF70N8q/FJjj/FbupFmEJkUap8Nb/8XP2rnlprbhcfdM5rTtKZQHbsn9raPk
 CzWjU0/V8KUwU9BvuE3SqHjWDMn3WKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706180635;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kqsS+t0mWOa5o8YVEsAUPKEH/2WY6qUD2PhHmAt/tW0=;
 b=nIs9hq2duWXeDV2SOxxJuNx3KaR+P0jWJIHEPvpc8G/PzRtuSDSxYBIrItwLqv0+jnqnnD
 bYC0snPh6mzuY2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66453134C3;
 Thu, 25 Jan 2024 11:03:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G05jFRtAsmUDcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 25 Jan 2024 11:03:55 +0000
Date: Thu, 25 Jan 2024 12:04:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZbJAKJTVqP9_o2c5@yuki>
References: <ZZQHPkwg-W2R1ejJ@yuki> <Zak5QdHCUyUmJ5x4@yuki>
 <CAEemH2dZrhc_1G+PY5s89tQMhQ-F-mVbjBz+_CdbjBYm9CG_Ow@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dZrhc_1G+PY5s89tQMhQ-F-mVbjBz+_CdbjBYm9CG_Ow@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
> Test based on the latest LTP (main-branch + libswap-patchset) results as:

Thanks a lot!

> splice07: rhel9.3 + kernel-6.7.0, all-arches
> 
>     86	splice07.c:62: TINFO: /dev/zero -> ...
>     87	splice07.c:54: TPASS: splice() on /dev/zero -> file : EINVAL (22)
>     88	splice07.c:54: TPASS: splice() on /dev/zero -> O_PATH file : EBADF (9)
>     89	splice07.c:54: TPASS: splice() on /dev/zero -> directory : EBADF (9)
>     90	splice07.c:54: TPASS: splice() on /dev/zero -> /dev/zero : EBADF (9)
>     91	splice07.c:54: TPASS: splice() on /dev/zero -> /proc/self/maps
> : EBADF (9)
>     92	splice07.c:54: TPASS: splice() on /dev/zero -> pipe read end : EBADF (9)
>     93	splice07.c:54: TFAIL: splice() on /dev/zero -> pipe write end succeeded

We see that one too, on a random set of kernels the splice from zero to
pipe succeeds. We are trying to investigate.

>     94	splice07.c:54: TPASS: splice() on /dev/zero -> unix socket : EINVAL (22)
>     95	splice07.c:54: TPASS: splice() on /dev/zero -> inet socket : EINVAL (22)
> 
> 
> proc_sched_rt01: rhel-9.3(5.14.0-362.8.1.el9_3), all-arches
> 
>     10	proc_sched_rt01.c:45: TFAIL: Expect: timeslice_ms > 0 after
> reset to default
>     11	proc_sched_rt01.c:51: TPASS: echo 0 >
> /proc/sys/kernel/sched_rt_period_us : EINVAL (22)
>     12	proc_sched_rt01.c:53: TFAIL: echo -1 >
> /proc/sys/kernel/sched_rt_period_us invalid retval 2: SUCCESS (0)
>     13	proc_sched_rt01.c:59: TPASS: echo -2 >
> /proc/sys/kernel/sched_rt_runtime_us : EINVAL (22)
>     14	proc_sched_rt01.c:72: TFAIL: echo rt_period_us+1 >
> /proc/sys/kernel/sched_rt_runtime_us invalid retval 1: SUCCESS (0)
> 
> 
> sched_rr_get_interval01: rhel-9.3(5.14.0-362.8.1.el9_3), all-arches
> 
>      9	sched_rr_get_interval01.c:44: TINFO: Testing variant: vDSO or
> syscall with libc spec
>     10	sched_rr_get_interval01.c:61: TPASS: sched_rr_get_interval() passed
>     11	sched_rr_get_interval01.c:68: TPASS: Time quantum 0s 100000000ns
>     12	sched_rr_get_interval01.c:76: TFAIL:
> /proc/sys/kernel/sched_rr_timeslice_ms != 100 got -1
>     13	sched_rr_get_interval01.c:44: TINFO: Testing variant: syscall
> with old kernel spec
>     14	sched_rr_get_interval01.c:61: TPASS: sched_rr_get_interval() passed
>     15	sched_rr_get_interval01.c:68: TPASS: Time quantum 0s 100000000ns
>     16	sched_rr_get_interval01.c:76: TFAIL:
> /proc/sys/kernel/sched_rr_timeslice_ms != 100 got -1

These are most likely missing bacports for the sysctl fixes.

> sched_getattr01: rhel-9.3(5.14.0-362.8.1.el9_3), all-arches
> 
>      7	sched_getattr01    1  TFAIL  :  sched_getattr01.c:57:
> sched_setattr() failed: errno=EPERM(1): Operation not permitted

Does this one still fail on a freshly rebooted machine? My guess is that
if we succeed to set invalid values in the proc_sched_rt01 it may
confuse the kernel enough to fail this test as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
