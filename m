Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E65E784A4
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 11:55:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 03A763CDE09
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 13:55:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5810A3CCEA3
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 13:55:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 96ED62002B2
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 13:55:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2D1F2185E;
 Mon,  2 Oct 2023 11:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696247715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsXx++ft+4VCJrpVJaIU2XEeGtrebfs0OM99VTK3rfw=;
 b=1Mag04Uu8qGqH6FxLtUYVFIpkO3sXmjqFUIVACEoFDjjDCL2KNJ4I9ume9PPD8RG7TTwE/
 N43sWOm7p/wspFvAlrzquk2aQ8edSS+78bbIRCROKVW6C96zQT+Zcmr9/087DISvosGgcn
 xgIZqOY1yGjJ6Qchjr5zhKJ0Z4cM7Dg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696247715;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsXx++ft+4VCJrpVJaIU2XEeGtrebfs0OM99VTK3rfw=;
 b=xy1XsqQVhp51b6Y77aSP9q6sJLgyBlyAYmkIOowJElDC6zf/JLbxTR+j5P3ssRorUP4xBE
 XLtR/Zm1G5ynqpCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B36813434;
 Mon,  2 Oct 2023 11:55:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gaVlJKOvGmU/FAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 02 Oct 2023 11:55:15 +0000
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
Date: Mon,  2 Oct 2023 13:55:52 +0200
Message-ID: <20231002115553.3007-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002115553.3007-1-chrubis@suse.cz>
References: <20231002115553.3007-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] docs: scheduler-rt: Clarify & fix sched_rt_*
 sysctl docs
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

- Describe explicitly that sched_rt_runtime_us is allocated from
  sched_rt_period_us and hence always less or equal to that value.

- The limit for sched_rt_runtime_us is not INT_MAX-1, but rather it's
  limited by the value of sched_rt_period_us. If sched_rt_period_us is
  INT_MAX then sched_rt_runtime_us can be set to INT_MAX as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Documentation/scheduler/sched-rt-group.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 655a096ec8fb..a16bee8f74c2 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -87,18 +87,20 @@ lack an EDF scheduler to make non-uniform periods usable.
 The system wide settings are configured under the /proc virtual file system:
 
 /proc/sys/kernel/sched_rt_period_us:
-  The scheduling period that is equivalent to 100% CPU bandwidth
+  The scheduling period that is equivalent to 100% CPU bandwidth.
 
 /proc/sys/kernel/sched_rt_runtime_us:
-  A global limit on how much time realtime scheduling may use.  Even without
-  CONFIG_RT_GROUP_SCHED enabled, this will limit time reserved to realtime
-  processes. With CONFIG_RT_GROUP_SCHED it signifies the total bandwidth
-  available to all realtime groups.
+  A global limit on how much time realtime scheduling may use. This is always
+  less or equal to the period_us, as it denotes the time allocated from the
+  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
+  this will limit time reserved to realtime processes. With
+  CONFIG_RT_GROUP_SCHED=y it signifies the total bandwidth available to all
+  realtime groups.
 
   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
   * sched_rt_period_us takes values from 1 to INT_MAX.
-  * sched_rt_runtime_us takes values from -1 to (INT_MAX - 1).
+  * sched_rt_runtime_us takes values from -1 to sched_rt_period_us.
   * A run time of -1 specifies runtime == period, ie. no limit.
 
 
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
