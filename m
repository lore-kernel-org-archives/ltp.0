Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81AACEB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 14:03:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E27E73CEB31
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 16:03:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A73F3C9A2E
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 16:03:10 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 34407600114
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 16:03:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 63398218F8;
 Tue, 18 Jul 2023 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689688989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OZqarg5fMpWd7AaknJ41DNarATXoeE9zUDXa0r/AhUg=;
 b=B1K1x4usBjfrFo8ifTChNH/E3Cq3M4EX0gWl0FmvI0vb9JFNrzPlE8KENAolcUoLYDLAp2
 f1xRk7lpo80lCMG2Owab0jhWJvW9yiKllC39GwZT5ZU6yo4SYdsjOBrFirUG8VhCzPOINR
 zH/GkFIM0mavZ/gPvaqh1gAkThjBwko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689688989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OZqarg5fMpWd7AaknJ41DNarATXoeE9zUDXa0r/AhUg=;
 b=btyX5NLLw4ccLc8C9iBs9cv5icIRJyDiEi/44xXdOhSESXvcajGTbN8Rl6wmHWotTHyHfQ
 XtsXqg9ih8CT8qCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 510DD134B0;
 Tue, 18 Jul 2023 14:03:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rnmTEp2btmTeegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jul 2023 14:03:09 +0000
Date: Tue, 18 Jul 2023 16:04:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZLab3JV7ECyGIccZ@yuki>
References: <20230718114027.GA1172148@pevik>
 <ZLaYMAkKxMK3h7mC@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZLaYMAkKxMK3h7mC@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] sched_rr_get_interval01 depends on particular CONFIG_HZ
 value
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > sched_rr_get_interval01.c depends on particular CONFIG_HZ value.
> > Recent change in openSUSE kernel from the default 250 to 300 breaks it:
> > 
> > sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> > sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> > sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> > sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> > sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> > sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> > 
> > According to kernel/Kconfig.hz CONFIG_HZ can have various values (100, 250, 300,
> > 1000). Should we adapt the test to expect any of these? Or should we require
> > kernel config to read CONFIG_HZ value and check for correct value?
> 
> We had the same problem with getrusage04.c, see the
> guess_timer_resolution() function there.

However in the case of sched_rr_get_interval() both values are supposed
to be in seconds. The sched_rr_get_interval() fills in a timespec and
the proc file is in miliseconds. As far as I can tell we actually
compare apples to apples in the test and not oranges and apples.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
