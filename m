Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800AB606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 00:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=LlXEfq6z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793321905; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=uTUHzTTzHly/Aq0t/04eu3yZ6dA5w9sYRGXKGfN5Mpw=;
 b=LlXEfq6zAHIiUhUJqnjqaKWUjY/hHW4cdUQgtoKfpiAADwQydLsJAHpDU8GFuw7epOsq7
 6cLYjTrSt/ajaoBoUag1jBiFcpl/M34qnV7djBn8lXhJ9rvvcOQup15kLOpGMiujDbAE1IY
 fUHV+NxDWtZH4eFBPGrOC46rZ7Peoaw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 245BA3EA3D0
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 01:58:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3249F3E9BF0
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 01:58:02 +0100 (CET)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA3901000A12
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 01:57:57 +0100 (CET)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 69U0vmTK044618
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 08:57:48 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.56; Fri, 30 Oct
 2026 08:57:48 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 Oct
 2026 08:57:47 +0800
To: <ltp@lists.linux.it>
Date: Fri, 30 Oct 2026 08:57:18 +0800
Message-ID: <20261030005718.3343899-1-cyyang772@andestech.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 69U0vmTK044618
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] io_submit: Use TST_PTR_TO_UINT() for aio_buf
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Victor Cheng-Yen Yang <cyyang772@andestech.com>

GCC sign-extends a 32-bit pointer cast straight to a 64-bit integer, so
a buffer at or above 0x80000000 is passed as 0xffffffff8xxxxxxx and
io_submit() fails with EINVAL. The static buffer can land there in a
PIE binary with ASLR, and io_submit02 and io_submit03 then fail
intermittently.

Fixes: 7fb2b884ae8f ("syscalls/io_submit: Add io_submit02 test for native AIO")
Fixes: cd99e77be2ef ("syscalls/io_submit: Add io_submit03 test for native AIO")
Signed-off-by: Victor Cheng-Yen Yang <cyyang772@andestech.com>
---
 testcases/kernel/syscalls/io_submit/io_submit02.c | 2 +-
 testcases/kernel/syscalls/io_submit/io_submit03.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c b/testcases/kernel/syscalls/io_submit/io_submit02.c
index 36e9c29f93..ab9d6ee35a 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit02.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
@@ -45,7 +45,7 @@ static inline void io_prep_option(struct iocb *cb, int fd, void *buf,
 	memset(cb, 0, sizeof(*cb));
 	cb->aio_fildes = fd;
 	cb->aio_lio_opcode = opcode;
-	cb->aio_buf = (uint64_t)buf;
+	cb->aio_buf = TST_PTR_TO_UINT(buf);
 	cb->aio_offset = offset;
 	cb->aio_nbytes = count;
 }
diff --git a/testcases/kernel/syscalls/io_submit/io_submit03.c b/testcases/kernel/syscalls/io_submit/io_submit03.c
index 45903107d7..dd7e7217de 100644
--- a/testcases/kernel/syscalls/io_submit/io_submit03.c
+++ b/testcases/kernel/syscalls/io_submit/io_submit03.c
@@ -71,7 +71,7 @@ static inline void io_prep_option(struct iocb *cb, int fd, void *buf,
 	memset(cb, 0, sizeof(*cb));
 	cb->aio_fildes = fd;
 	cb->aio_lio_opcode = opcode;
-	cb->aio_buf = (uint64_t)buf;
+	cb->aio_buf = TST_PTR_TO_UINT(buf);
 	cb->aio_offset = offset;
 	cb->aio_nbytes = count;
 }
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
