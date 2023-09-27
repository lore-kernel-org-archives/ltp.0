Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC0BE810C1
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 10:30:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A13C93CDDC3
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 12:30:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 77C9D3CBAC1
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 12:29:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB7CD608A99
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 12:29:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDD9A2192D;
 Wed, 27 Sep 2023 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695810572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxG0ZA7/Za7bKDG5oepNfkkaA1iabq3sh46JVCNH8po=;
 b=dDe2oM3eK05m45PKqfd2dr2jQJnjjU5g+MDzcdEpeUR4plWb0ym3fDxultL2cnZ4fDaTki
 017FNq+dyOK1IglPAzU55pezr194FZeSgR7Ck5OYWZagIgWxIAnmERaHVg4murdvrGFc00
 d1WHi5FRluuTEaEkKZzE6FgQt/r1m+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695810572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZxG0ZA7/Za7bKDG5oepNfkkaA1iabq3sh46JVCNH8po=;
 b=H7HJMb6JO9ZjffHKwP/FT5OgGufVRDAUQ+i/z0HZ9qYliWVizjxNv3V23nGH2xf9uB/ohl
 /gh4AczGHeLCqmCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD35F13479;
 Wed, 27 Sep 2023 10:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HORLNAwEFGWqMwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 27 Sep 2023 10:29:32 +0000
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
Date: Wed, 27 Sep 2023 12:30:12 +0200
Message-ID: <20230927103012.9587-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927103012.9587-1-chrubis@suse.cz>
References: <20230927103012.9587-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] docs: scheduler-rt: Clarify & fix sched_rt_*
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

- The limit for sched_rt_runtime_us is not INT_MAX - 1 but rather it's
  limited by the value of sched_rt_period_us. If sched_rt_period_us is
  INT_MAX then sched_rt_runtime_us can be set to INT_MAX as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Documentation/scheduler/sched-rt-group.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index 655a096ec8fb..033661a5838f 100644
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
+  less or equal than the period_us as it denotes the time allocated from the
+  period_us for the realtime tasks. Even without CONFIG_RT_GROUP_SCHED enabled,
+  this will limit time reserved to realtime processes. With
+  CONFIG_RT_GROUP_SCHED it signifies the total bandwidth available to all
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
