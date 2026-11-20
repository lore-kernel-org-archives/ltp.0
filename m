Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE37606A320
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ocKZwuHr;
	dkim=fail reason="signature verification failed" header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=/3UWy6bd
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 582E13E9FF4
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 16:37:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 218633C5DAE
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 16:36:25 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9D84A1A01088
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 16:36:24 +0100 (CET)
Date: Fri, 20 Nov 2026 16:36:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1795188982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0v8j2lBvxHjXaH9n0pHRtDOnUfQzBe+8Nl6XwJcdi84=;
 b=ocKZwuHrzuSS5ct2BH9+QHW61CP+dOVKPTj6OnEL5JRcOuENkj0NL0skilIvwRsvY8R/4d
 CLIEdNZEGWZ2+GWNRnttwKPWCQR99CItKiWt7sPu3FVy6wjwmSwNrGuA4vnLpx8j1aV4KN
 oucdLvD2xawYd7/siHeOJkUWKmh9rEdf18jCqNzAbDKDhNZxIeRPBGBfXmtckHgfJaDYM3
 HyHUcuzXU18kwelECl+BVuwFH5XSoHKvLoAwDSqQePK4qcrHGtHd1lh/ALmZSc+ILWYJSt
 G0R9OpDpF46Mpq0CKPoZ+vSMMP4Bfw80YQ2jR05qhh7pPFKC1Uw9FCHQ11/rLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1795188982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0v8j2lBvxHjXaH9n0pHRtDOnUfQzBe+8Nl6XwJcdi84=;
 b=/3UWy6bdseM8Bvl3FVKoUU8HTCV8bfiOwegV1SE7IS2/xYsJtTfC9IiB5w7SmqUznWC2HV
 P5ol4oPM0GV6hXDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Juri Lelli <juri.lelli@redhat.com>
Message-ID: <20261120153619.gkOojPT4@linutronix.de>
References: <20261113-sched_dl-v3-6-a76ffa1cdeee@linutronix.de>
 <202611192004.cca8bf73-lkp@intel.com>
 <20261119142348.MkPQ2Fby@linutronix.de>
 <awBiDzEvUch_5ZJn@jlelli-thinkpadt14gen4.remote.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <awBiDzEvUch_5ZJn@jlelli-thinkpadt14gen4.remote.csb>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 20 Nov 2026 16:36:41 +0100
Subject: Re: [LTP] [PATCH v3 6/8] sched: Limit sysctl
 sched_rt_{period|runtime}_us to RT_GROUP_SCHED
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun@kernel.org>,
 Yuri Andriaccio <yuri.andriaccio@santannapisa.it>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Ben Segall <bsegall@google.com>,
 John Ogness <john.ogness@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Vincent Guittot <vincent.guittot@linaro.org>, yu.c.chen@intel.com,
 Jonathan Corbet <corbet@lwn.net>, luca abeni <luca.abeni@santannapisa.it>,
 aubrey.li@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Josh Triplett <josh@joshtriplett.org>,
 Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it, lkp@intel.com,
 Zqiang <qiang.zhang@linux.dev>, Joel Fernandes <joelagnelf@nvidia.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Qais Yousef <qyousef@layalina.io>, Tejun Heo <tj@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Yuri Andriaccio <yurand2000@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2026-11-20 16:06:55 [+0100], Juri Lelli wrote:
> Hello,
Hi,

> I agree on the RT throttling part. Before this series, writing to them
> does serve a purpose, though. 5/8 moves that functionality to sysfs,
> which leaves the files without a purpose, and 6/8 then removes them. So
> existing users don't lose a useless knob; they lose the working one,
> which has moved somewhere else. LTP is not the only one that will
> notice, I'm afraid.
> 
> This is what I meant with "yes and no" in the RFC thread: we need an
> interface for admission control, and I wasn't sure how much breakage
> moving it would cause. Now we have a first data point. :)
> 
> You suggested yourself back then to keep the files and make them apply
> to DL only. I think that's something like:
> 
>  - keep sched_rt_{period,runtime}_us for !RT_GROUP_SCHED, backed by the
>    same code as the new dl_{period,runtime}_us (sched_dl_try_boundary()),
>    keeping the current validation semantics (the LTP test checks the
>    EINVAL cases, and 0 is a valid runtime today)
>  - pr_warn_once() on write saying they only control DEADLINE admission
>    control and that RT throttling is handled by the fair_server,
>    pointing to where its knobs are
>  - fix the documentation as you are doing already
> 
> That way nobody gets surprised anymore, which was your point, and we
> don't break anyone? We can still discuss deprecating the procfs names
> later, once the new interface has been around for a while maybe?

Doesn't sound bad. Let me respin it with these changes.
Thanks.

> Thanks,
> Juri

Sebastian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
