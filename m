Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FE1C3DA60
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 17:18:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E25723D1AF1
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 19:18:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C62003D1ADB
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:20 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7DCF601E0C
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 19:17:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9972C2199B;
 Wed, 17 Jul 2024 17:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=voVL63OrW2n69qEElvkduqbRbK9N/UPCNFknKH6yu3c=;
 b=Si8rZtueEFtgI6m0cm4gmtb8FkhuHgc/2+hcfZJOWTBiE8Gpz5QTj8GuYtVKI+BVcES859
 xtvAjGUAYR/OsgtCA1CXTlK4mf6AggbEYSxJGTZ327rPeiFqSLj572DwBTOpbhQHcobkRe
 pZ+lvavHx+4WTQoDNRIpP1/E6Nf8hEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=voVL63OrW2n69qEElvkduqbRbK9N/UPCNFknKH6yu3c=;
 b=X0Go9MJzbqRyLTTn9rwqErIGk3uFiWLMtlKKTQKGqFAVX+xA1pP2gGHZbrY17lY/mrLIjZ
 FA5caefxR+yBDYCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Si8rZtue;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=X0Go9MJz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721236637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=voVL63OrW2n69qEElvkduqbRbK9N/UPCNFknKH6yu3c=;
 b=Si8rZtueEFtgI6m0cm4gmtb8FkhuHgc/2+hcfZJOWTBiE8Gpz5QTj8GuYtVKI+BVcES859
 xtvAjGUAYR/OsgtCA1CXTlK4mf6AggbEYSxJGTZ327rPeiFqSLj572DwBTOpbhQHcobkRe
 pZ+lvavHx+4WTQoDNRIpP1/E6Nf8hEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721236637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=voVL63OrW2n69qEElvkduqbRbK9N/UPCNFknKH6yu3c=;
 b=X0Go9MJzbqRyLTTn9rwqErIGk3uFiWLMtlKKTQKGqFAVX+xA1pP2gGHZbrY17lY/mrLIjZ
 FA5caefxR+yBDYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62310136E5;
 Wed, 17 Jul 2024 17:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lPs2Fp38l2ZQOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jul 2024 17:17:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 17 Jul 2024 19:17:07 +0200
Message-ID: <20240717171713.687339-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9972C2199B
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/6] sched_football in runtest/sched + configure
 cleanup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel (6):
  configure: Print info about TI-RPC testsuite in summary
  configure: Don't assume testcases/realtime/configure.ac
  configure: Print info about KVM testsuite in summary
  configure: Enable realtime testsuite by default
  runtest/sched: Add sched_football
  realtime: Use proper syntax for non-system include

 configure.ac                                        | 13 +++++++++----
 include/mk/features.mk.in                           |  3 ---
 runtest/sched                                       |  2 ++
 testcases/Makefile                                  |  4 ----
 .../realtime/func/async_handler/async_handler.c     |  4 ++--
 .../realtime/func/async_handler/async_handler_jk.c  |  4 ++--
 .../realtime/func/async_handler/async_handler_tsc.c |  4 ++--
 .../realtime/func/gtod_latency/gtod_infinite.c      |  2 +-
 testcases/realtime/func/gtod_latency/gtod_latency.c |  4 ++--
 testcases/realtime/func/hrtimer-prio/hrtimer-prio.c |  4 ++--
 testcases/realtime/func/matrix_mult/matrix_mult.c   |  4 ++--
 .../realtime/func/measurement/preempt_timing.c      |  2 +-
 testcases/realtime/func/measurement/rdtsc-latency.c |  2 +-
 .../func/periodic_cpu_load/periodic_cpu_load.c      |  4 ++--
 .../periodic_cpu_load/periodic_cpu_load_single.c    |  4 ++--
 testcases/realtime/func/pi-tests/test-skeleton.c    |  2 +-
 testcases/realtime/func/pi-tests/testpi-0.c         |  2 +-
 testcases/realtime/func/pi-tests/testpi-1.c         |  2 +-
 testcases/realtime/func/pi-tests/testpi-2.c         |  2 +-
 testcases/realtime/func/pi-tests/testpi-4.c         |  2 +-
 testcases/realtime/func/pi-tests/testpi-5.c         |  2 +-
 testcases/realtime/func/pi-tests/testpi-6.c         |  2 +-
 testcases/realtime/func/pi-tests/testpi-7.c         |  2 +-
 testcases/realtime/func/pi_perf/pi_perf.c           |  4 ++--
 testcases/realtime/func/prio-preempt/prio-preempt.c |  2 +-
 testcases/realtime/func/prio-wake/prio-wake.c       |  4 ++--
 .../pthread_kill_latency/pthread_kill_latency.c     |  4 ++--
 testcases/realtime/func/rt-migrate/rt-migrate.c     |  4 ++--
 testcases/realtime/func/sched_jitter/sched_jitter.c |  4 ++--
 .../realtime/func/sched_latency/sched_latency.c     |  4 ++--
 testcases/realtime/func/thread_clock/tc-2.c         |  2 +-
 testcases/realtime/lib/librttest.c                  |  4 ++--
 testcases/realtime/lib/libstats.c                   |  4 ++--
 .../realtime/perf/latency/pthread_cond_latency.c    |  2 +-
 testcases/realtime/perf/latency/pthread_cond_many.c |  4 ++--
 .../realtime/stress/pi-tests/lookup_pi_state.c      |  2 +-
 testcases/realtime/stress/pi-tests/testpi-3.c       |  2 +-
 37 files changed, 61 insertions(+), 61 deletions(-)

-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
