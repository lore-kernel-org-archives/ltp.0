Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDAFCD4F5B
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 11:42:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB0243CDE5E
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 13:42:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C6F13C9EAE
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 13:42:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F2B9A1001F27
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 13:42:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC2E621A9E;
 Fri, 22 Sep 2023 11:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695382961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=65+lm7d+dGRTiOMAyApVmU/Xt+Gy4JHwF9IUeIK1m1Q=;
 b=yJPzw4jKA78/KuVPeDtJPzXDAGBL5vPvSoxnuXVCM8RAh2RYriDdPP+yZAKS1CutJLntVi
 FFh4Iud6erKaiL6VZAjIt13auEAuC/Ru/cFgGCnz0KDuU75TY/uTVxI288PcND9Fv3aST4
 gkCLkcAXbu43vZ1RiVGQ5jRQknt5Ec0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695382961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=65+lm7d+dGRTiOMAyApVmU/Xt+Gy4JHwF9IUeIK1m1Q=;
 b=fLpi/29qParzWJqJjq1VQuYRYSpCWpAK2Bu9U9mzTnpOu+5h7/MOI5YeDEWFf+l3OCP1Wd
 cS4+u8sAD88kp2DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D311113478;
 Fri, 22 Sep 2023 11:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w6kLL7F9DWXnJAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 22 Sep 2023 11:42:41 +0000
Date: Fri, 22 Sep 2023 13:43:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ingo Molnar <mingo@kernel.org>
Message-ID: <ZQ193uwifmWWbqSP@yuki>
References: <20230901154355.5351-1-chrubis@suse.cz>
 <20230901174529.GB364687@pevik> <ZPIqsmTbJh7z-LcO@yuki>
 <ZQ1iabFEs93OZMSE@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQ1iabFEs93OZMSE@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched/rt: Disallow writing invalid values to
 sched_rt_period_us
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
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > Documentation/scheduller/sched-rt-group.rst [1] specifies this as values from -1 to
> > > (INT_MAX - 1), I guess due int range. Looking into proc_dointvec_minmax() [2]
> > > even INT_MAX would pass the check. I suppose we can do nothing about that,
> > > because there is no value in sysctl_vals[] which would represent INT_MAX - 1.
> > > 
> > > And you specify in LTP test range: from -1 to INT_MAX.
> > > 
> > > But even much shorter value than INT_MAX fails:
> > > 
> > > $ echo 1234567 > /proc/sys/kernel/sched_rt_runtime_us
> > > sh: echo: write error: Invalid argument
> > 
> > That is because runtime_us must be < period_us by definition, since
> > runtime_us defines how much time is allocated from the period_us. I
> > guess that this is not described good enough in the kernel docs.
> 
> Mind adding a second patch to your series, clarifying 
> Documentation/scheduler/sched-rt-group.rst?

Yes, that is the plan. I've been working on LTP release for past two
weeks so this has been postponed. I will get to it hopefully next week.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
