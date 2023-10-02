Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199CBE784A4
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 11:55:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69C733CDD94
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 13:55:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39CBF3CCE91
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 13:55:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ACB1C1000AE4
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 13:55:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3EB2B2185F;
 Mon,  2 Oct 2023 11:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696247716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20h7KCpcQajnFp3w5doiMii1hEINmAwyPkgpAacIcrA=;
 b=0XBgxH/3uEkxE5rwWYDJbxD2pnpq8xEDVD76JmxuUplNhbQCxus67Gd2HPME5sNaH1wKFm
 EuFx+gtWVWY6vsZjJ2uKdjtxOUQ3I5C/9cpXAec6WUbE26GozoG/xqjnBTj96kl+mF1fh7
 suOk9uESkButXiFCFLy68Z0S8VMzHYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696247716;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20h7KCpcQajnFp3w5doiMii1hEINmAwyPkgpAacIcrA=;
 b=eYmRgWqpmG+K3u8AaBXjk2wqUQci8T/zb85Zg0nyUDuFvL92prmlP0KqxKcI20NbPwylw8
 VX3VNv6BV8z18pBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2777813434;
 Mon,  2 Oct 2023 11:55:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u2sxCKSvGmVBFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 02 Oct 2023 11:55:16 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Date: Mon,  2 Oct 2023 13:55:53 +0200
Message-ID: <20231002115553.3007-4-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002115553.3007-1-chrubis@suse.cz>
References: <20231002115553.3007-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/3] docs: scheduler-rt: Use real-time instead of
 realtime
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

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Documentation/scheduler/sched-rt-group.rst | 34 +++++++++++-----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index a16bee8f74c2..d685609ed3d7 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -39,10 +39,10 @@ Most notable:
 1.1 The problem
 ---------------
 
-Realtime scheduling is all about determinism, a group has to be able to rely on
+Real-time scheduling is all about determinism, a group has to be able to rely on
 the amount of bandwidth (eg. CPU time) being constant. In order to schedule
-multiple groups of realtime tasks, each group must be assigned a fixed portion
-of the CPU time available.  Without a minimum guarantee a realtime group can
+multiple groups of real-time tasks, each group must be assigned a fixed portion
+of the CPU time available.  Without a minimum guarantee a real-time group can
 obviously fall short. A fuzzy upper limit is of no use since it cannot be
 relied upon. Which leaves us with just the single fixed portion.
 
@@ -50,14 +50,14 @@ relied upon. Which leaves us with just the single fixed portion.
 ----------------
 
 CPU time is divided by means of specifying how much time can be spent running
-in a given period. We allocate this "run time" for each realtime group which
-the other realtime groups will not be permitted to use.
+in a given period. We allocate this "run time" for each real-time group which
+the other real-time groups will not be permitted to use.
 
-Any time not allocated to a realtime group will be used to run normal priority
+Any time not allocated to a real-time group will be used to run normal priority
 tasks (SCHED_OTHER). Any allocated run time not used will also be picked up by
 SCHED_OTHER.
 
-Let's consider an example: a frame fixed realtime renderer must deliver 25
+Let's consider an example: a frame fixed real-time renderer must deliver 25
 frames a second, which yields a period of 0.04s per frame. Now say it will also
 have to play some music and respond to input, leaving it with around 80% CPU
 time dedicated for the graphics. We can then give this group a run time of 0.8
@@ -70,7 +70,7 @@ needs only about 3% CPU time to do so, it can do with a 0.03 * 0.005s =
 of 0.00015s.
 
 The remaining CPU time will be used for user input and other tasks. Because
-realtime tasks have explicitly allocated the CPU time they need to perform
+real-time tasks have explicitly allocated the CPU time they need to perform
 their tasks, buffer underruns in the graphics or audio can be eliminated.
 
 NOTE: the above example is not fully implemented yet. We still
@@ -90,12 +90,12 @@ The system wide settings are configured under the /proc virtual file system:
   The scheduling period that is equivalent to 100% CPU bandwidth.
 
 /proc/sys/kernel/sched_rt_runtime_us:
-  A global limit on how much time realtime scheduling may use. This is always
+  A global limit on how much time real-time scheduling may use. This is always
   less or equal to the period_us, as it denotes the time allocated from the
-  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
-  this will limit time reserved to realtime processes. With
+  period_us for the real-time tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
+  this will limit time reserved to real-time processes. With
   CONFIG_RT_GROUP_SCHED=y it signifies the total bandwidth available to all
-  realtime groups.
+  real-time groups.
 
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
@@ -110,7 +110,7 @@ The system wide settings are configured under the /proc virtual file system:
 The default values for sched_rt_period_us (1000000 or 1s) and
 sched_rt_runtime_us (950000 or 0.95s).  This gives 0.05s to be used by
 SCHED_OTHER (non-RT tasks). These defaults were chosen so that a run-away
-realtime tasks will not lock up the machine but leave a little time to recover
+real-time tasks will not lock up the machine but leave a little time to recover
 it.  By setting runtime to -1 you'd get the old behaviour back.
 
 By default all bandwidth is assigned to the root group and new groups get the
@@ -118,10 +118,10 @@ period from /proc/sys/kernel/sched_rt_period_us and a run time of 0. If you
 want to assign bandwidth to another group, reduce the root group's bandwidth
 and assign some or all of the difference to another group.
 
-Realtime group scheduling means you have to assign a portion of total CPU
-bandwidth to the group before it will accept realtime tasks. Therefore you will
-not be able to run realtime tasks as any user other than root until you have
-done that, even if the user has the rights to run processes with realtime
+Real-time group scheduling means you have to assign a portion of total CPU
+bandwidth to the group before it will accept real-time tasks. Therefore you will
+not be able to run real-time tasks as any user other than root until you have
+done that, even if the user has the rights to run processes with real-time
 priority!
 
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
