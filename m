Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEB5FB3D00
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774866584; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=2kAqdLTmd3KBjH/M8YfH+iTPIZXCKShwTByqd1mSUE0=;
 b=QMypys9IHhxwqkHxjX3eiNj/+4hfFxzJWZtkKSPBQEJw2nlwM8jFASYpoF0+RnZcjYlFJ
 1Vi8howWMLW9C0SjlEStp//MIP1impvO98g5pOhfu4ySjY5yVCOzrSwOntxjCqw9djqA7+7
 hnQUlUIuRT29cWCOklGsJqJhVLiqIC0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E1843E4F13
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 12:29:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC8C93E4F0E
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:29:19 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55E74100024A
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:29:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-ID:Date:Subject
 :From; bh=WDsvazCmwsJSjFhtmtF34qI0/tqlC+IHUSv62bhN0TI=; b=rXUGOSMbHRqotu8gOxj
 M4d8RXV+ybzCUwN6FnD5UfdqPOhO0tM35jEZK1o1cF/vtOOgTiM7RIIh3rVF89Gz3zuhxN1O2zTVQ
 obkfGUjfkSmW7qjKGs7ggs/sjdnix2IKJbZpQeQaAFZOobxwXgC4cu/HrbDJRzn2QuQCyI7SQsNd9
 N9UeRlJOWcXK//JB+kY6Zm8v4OeeEGPU4XmWxn2o4ZebJuLGBjP8jiUPY2/HWCpuAGYR7j6tSWnJq
 S6K3N8CX1rOJLuTMDGi+RZ1yUdqiBNo2I94isgovY2ZC+NJZadLQVKRF7KbsuxQvl6mBhk0p3IS6P
 Ge63DXGiBfdj9JA==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1w79ps-002jRx-2Q; Mon, 30 Mar 2026 12:29:10 +0200
To: ltp@lists.linux.it
Date: Mon, 30 Mar 2026 10:20:23 +0000
Message-ID: <20260330102909.863484-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] configurable wake timeout and memcontrol03 fixes
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Parents and children in memcontrol03 coordinate with very tight
timeout budget(10s) which ofter leads to timeout fails in slow configs.

The first patch extends tst_safe_checkpoint_wake() with an explicit
millisecond timeout; 0 keeps the previous 10s default.
It adds TST_CHECKPOINT_WAKE_TIMEOUT / TST_CHECKPOINT_WAKE2_TIMEOUT macros
so tests don't have to change existing TST_CHECKPOINT_WAKE* call sites.

The second patch uses tst_multiply_timeout(10) * 1000 for the checkpoint waits
and wakes in memcontrol03.c, including cleanup, so those budgets track
LTP_TIMEOUT_MUL.

Vasileios Almpanis (2):
  lib/checkpoint: add configurable timeout for checkpoint wake
  memcg: scale memcontrol03 checkpoint timeouts for slow kernels

 include/tst_checkpoint.h                      | 41 ++++++++++++++++---
 include/tst_checkpoint_fn.h                   |  2 +-
 lib/tst_checkpoint.c                          |  9 +++-
 .../kernel/controllers/memcg/memcontrol03.c   | 13 +++---
 4 files changed, 51 insertions(+), 14 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
