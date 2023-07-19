Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AE4C0015E
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 10:37:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 631E73CE9C3
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 12:37:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C5B53C98BC
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 12:36:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8B4E9600325
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 12:36:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A3E821AE0;
 Wed, 19 Jul 2023 10:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689763006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xKzzx9laG0zc9aEyQVV7mOZk+pe8KwSsh7VnlWOtmKA=;
 b=p+iTSG3dntqxUTvDhfNKgy74M4bthsIeJ4IFVvxfaJ+4mGA4ZxgVj3BiSEZiIKt03epJe4
 zmzKSbR2GBbKouDzqDkUj1AQtOOo5gplv+l5lpX0eTQuFC0bZvJ2tIq6fXtOIVJKbn14tx
 1SlZMALDV/HrOZuErA836z2/K5+0tsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689763006;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xKzzx9laG0zc9aEyQVV7mOZk+pe8KwSsh7VnlWOtmKA=;
 b=ZLn/RpCVVASMvYwMeDWg69gvYbOfGnQgtEyeVf8lFOSx+uidrofXQGzyyvv2KE56WY9Wu+
 kLe+QEnuSwUFT6Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE7D41361C;
 Wed, 19 Jul 2023 10:36:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id leFXOb28t2RLRQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 19 Jul 2023 10:36:45 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Date: Wed, 19 Jul 2023 12:37:41 +0200
Message-ID: <20230719103743.4775-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Two fixes for sysctl_sched_rr_timeslice
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

- Fixes rounding error for initial value with CONFIG_HZ_300

- Fixes read from the file after reset to default (by writing val <= 0)

Cyril Hrubis (2):
  sched/rt: Fix sysctl_sched_rr_timeslice intial value
  sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset

 kernel/sched/rt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
