Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC61EB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 13:47:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31983CDE9D
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 15:47:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F3EC3C98F4
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 15:47:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B538C60029E
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 15:47:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D8F59218F8;
 Tue, 18 Jul 2023 13:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689688048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dfs+plJw5fUAmZ7pigJAUQpbM0qGAQG6PnaJA0Sf8n0=;
 b=TXiG4m4fVWt3j7t1VP43+IJ8HDP12GY7SqPGLo1PCF1j39PyDntaMrPnMCEHE0GimyIhqu
 F4uUyhlAb88nKmscVL8slyiuDFQBkwMKJ5KpvhxOVh2l8oFo2tmRRXgLefOC6F1X4/+Uf8
 BKgJ8OtD4N+lnOl/HtkRzojNHKGKq0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689688048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dfs+plJw5fUAmZ7pigJAUQpbM0qGAQG6PnaJA0Sf8n0=;
 b=cSLuXOPsVAxvNP3RF4oTbaoC53/LFcAEmhiGlUDkmLbw+O6KV/qFA+Vaf50vANe5R4P4zj
 fHZDVw5ZYFD2l1CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C654613494;
 Tue, 18 Jul 2023 13:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 999WL/CXtmQvcgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jul 2023 13:47:28 +0000
Date: Tue, 18 Jul 2023 15:48:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZLaYMAkKxMK3h7mC@yuki>
References: <20230718114027.GA1172148@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230718114027.GA1172148@pevik>
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
> sched_rr_get_interval01.c depends on particular CONFIG_HZ value.
> Recent change in openSUSE kernel from the default 250 to 300 breaks it:
> 
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> sched_rr_get_interval01.c:57: TPASS: sched_rr_get_interval() passed
> sched_rr_get_interval01.c:64: TPASS: Time quantum 0s 99999990ns
> sched_rr_get_interval01.c:72: TFAIL: /proc/sys/kernel/sched_rr_timeslice_ms != 100 got 90
> 
> According to kernel/Kconfig.hz CONFIG_HZ can have various values (100, 250, 300,
> 1000). Should we adapt the test to expect any of these? Or should we require
> kernel config to read CONFIG_HZ value and check for correct value?

We had the same problem with getrusage04.c, see the
guess_timer_resolution() function there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
