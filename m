Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671C0C3065C
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 14:48:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C846B3D3EE8
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 16:48:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C13903D3EC2
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:47:54 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ABB4760FB4B
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 16:47:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D59191FBAC;
 Tue,  2 Jul 2024 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719931672; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfuWaiSulo/q0OuoeZQUpO4J/1kE6XMwrrFPIBekGjE=;
 b=T3qSTb1MiVDT2rJKpTrdUPYGijoztR7uG6RLVLElEWuzN8M7N0AKw1xfi3Qbl7CEkkq0pE
 GVbQ+OL8olLbQM5IHyptPW8Tg3UX2etZXEC6mrnwhCpBob5+N/pBstvmREgE2g5oYhYSfv
 yTJO7qJnDGMYZXc/sf51d0INp+ge5vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719931672;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfuWaiSulo/q0OuoeZQUpO4J/1kE6XMwrrFPIBekGjE=;
 b=E9PAGKruPjQfaJU0THkzuDQ3vTAi2qtC6USAvI81siRC8AnAlOTOa5NyI83bp4SFPLmGna
 BWz7dV/JoWmgEsDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1719931671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfuWaiSulo/q0OuoeZQUpO4J/1kE6XMwrrFPIBekGjE=;
 b=KAwxZADsiwoFvRDRqtgvgj0wccmDR1ShJclsnC3b5exYY0h9PLVav3roVloKAw9rk1B/aT
 0Go2eItgNg+ckdMdSTHYx+h9H/qiQedB5dgyWb0jsGSEz3Ur/6VQuEElH9ButmjmpfnrXS
 Hh9OYUrA8sBNmbs57iJuJ0SVxLCLbLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1719931671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mfuWaiSulo/q0OuoeZQUpO4J/1kE6XMwrrFPIBekGjE=;
 b=+Os9R0SmtZT1hvOFMPY0Caea5+3ISKp+YaeLo2t/bu6G8kp9Bz/ZWv2Za5LOXE0EM8yUnn
 qlJWbMI4vm+kiqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C51F81395F;
 Tue,  2 Jul 2024 14:47:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SN0pLxcThGY5GgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 02 Jul 2024 14:47:51 +0000
Date: Tue, 2 Jul 2024 16:47:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "joe.liu" <joe.liu@mediatek.com>
Message-ID: <ZoQTD_QLwP8w9sPe@yuki>
References: <20240612112311.10334-1-chrubis@suse.cz>
 <20240701095032.18930-1-joe.liu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240701095032.18930-1-joe.liu@mediatek.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched: starvation: Autocallibrate the timeout
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
Cc: alix.wu@mediatek.com, xufeifei1@oppo.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > What kernel version do you use?
> We are now using kernel 5.15
> 
> > Do you run LTP with background tasks to keep the CPU bussy?
> Yes, we are testing LTP with Android VTS. And the test environment is under Android Launcher.
> 
> > Do you have any custom patches for kernel scheduller applied?
> I think there is no any patch applied for kernel scheduller.
> 
> > It really looks like something unexpected is happening at your end.
> 
> Actually, the same kernel version using 64bit kernel can pass the ltp test.
> 
> 
> 
> 1. for 32bit kernel, we have this log
> 
> 32bit kernel
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:161: TINFO: do_test by pid 4523
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 4523
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 4524
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:166: TINFO: main pid is 4524
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:167: TINFO: child pid is 0
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:176: TINFO: go loop, current pid is 4523
> external/ltp/testcases/kernel/sched/cfs-scheduler/starvation.c:145: TINFO: current ppid is 4523, current pid is 4524, go to child() start
> 
> main pid is 4523, child pid is 4524, and we only see child pid is working (checking by top)
> 
> 4524 root         20   0  14M 472K    0 R 85.7   0.0   0:14.93 starvation_v4 -t 1000000 -l 1000000 <-- cpu_load by top

So this looks like we managed to reproduce the issue the test was trying
to catch. The child is hogging the CPU and the parent process cannot
proceed. And I suppose that this happens only on 32bit because 32bit is
less tested these days.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
