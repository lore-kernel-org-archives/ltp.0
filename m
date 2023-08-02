Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553F2C001DF
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 15:18:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ECB53CE45E
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 17:18:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B3673CD512
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 17:18:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DBDC82001CE
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 17:18:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF07E1F898;
 Wed,  2 Aug 2023 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690989490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xKzzx9laG0zc9aEyQVV7mOZk+pe8KwSsh7VnlWOtmKA=;
 b=p8QmNGhCagiQYjFyB/Gq5mZ1txo2aIxNY66EGJ3Yq+Ru6KBZwQ5N8orZNAfzLys7kDsWEy
 Uut0CQS+fIORIYCpMmIDMdlL0tC1Iw0d8+MD0lFFRgG+VNRCueLcyGKANMJoM0FY8K49er
 SLMwuUh5TBQwtymxQnaHmsLTrk5Xn0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690989490;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xKzzx9laG0zc9aEyQVV7mOZk+pe8KwSsh7VnlWOtmKA=;
 b=/2pkviycf1gZDlvqyCiOuA0gv5v2DgFV6FLPGgKWYmAJYNkIFNg//M5ei9yxT+r/6rz+3O
 /+IHEGYhez8KGiBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE5CD13919;
 Wed,  2 Aug 2023 15:18:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jb2IMLJzymRdKAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Aug 2023 15:18:10 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Date: Wed,  2 Aug 2023 17:19:04 +0200
Message-ID: <20230802151906.25258-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2 RESEND] Two fixes for sysctl_sched_rr_timeslice
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
