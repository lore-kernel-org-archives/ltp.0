Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891F7C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 16:21:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189C361100
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 16:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 189C361100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 995073CA2DC
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 18:21:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 198BC3C2201
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 18:21:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A71C6006DC
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 18:21:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BA6332017E
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632241259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LpuYsWr2GLl6v7/MNQKBBmkzhJBqRVYZt7EZcD90DfI=;
 b=P3fEmz9i7eIhJxWnsFfUUk1bOdJt47bLLjvDUrZ2agTfVNMVrqAduHzY8qMhheKBP6qfs/
 goopXSR7BNRMgPvf854Qw0yBjqwjXO1L5qHP4xm2R0AIWF8nMJP7kXYY7K1rcP7rrD0rAW
 y6Hqyi4/zBTqK6mKMBfk6GPZpAusk7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632241259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LpuYsWr2GLl6v7/MNQKBBmkzhJBqRVYZt7EZcD90DfI=;
 b=7dLbKJs7Y8kK/jaPY7wEcim4IUK1UgJT0HVnYEueHDjT3Y4S0hYYkVzjWHxYSkLkeK1Qo6
 MPczt6xpl1K4mTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A690613BD9
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 16:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mLGOJ2sGSmGkGgAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 16:20:59 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Sep 2021 18:20:57 +0200
Message-Id: <20210921162057.29598-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921162057.29598-1-mdoucha@suse.cz>
References: <20210921162057.29598-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Fix failures due to missing max_user_namespaces
 procfile
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/icmp_rate_limit01.c                   | 2 +-
 testcases/kernel/containers/userns/userns08.c       | 2 +-
 testcases/kernel/syscalls/bind/bind06.c             | 2 +-
 testcases/kernel/syscalls/sendto/sendto03.c         | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt05.c | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt06.c | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt07.c | 2 +-
 testcases/kernel/syscalls/setsockopt/setsockopt08.c | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 913fba3eb..b3a237b30 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -58,7 +58,7 @@ static void setup(void)
 	for (i = 0; i < SRCADDR_COUNT; i++)
 		fds[i] = -1;
 
-	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index 775561081..c141b1aca 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -121,7 +121,7 @@ static void setup(void)
 	SAFE_WRITE(fd, 1, "\n", 1);
 	SAFE_CLOSE(fd);
 
-	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 4a85d5b0e..297311c04 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -34,7 +34,7 @@ static void setup(void)
 	int real_gid = getgid();
 	struct ifreq ifr;
 
-	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index c99fb144f..217383993 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -43,7 +43,7 @@ static void setup(void)
 	int real_gid = getgid();
 	struct ifreq ifr;
 
-	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index a65ec6861..4b8b3d22e 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -40,7 +40,7 @@ static void setup(void)
 	struct ifreq ifr;
 	socklen_t addrlen = sizeof(addr);
 
-	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index ee460cb18..12a80dee4 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -35,7 +35,7 @@ static void setup(void)
 	int real_uid = getuid();
 	int real_gid = getgid();
 
-	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index 917cce0d2..d2c568e3e 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -38,7 +38,7 @@ static void setup(void)
 	int real_uid = getuid();
 	int real_gid = getgid();
 
-	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index e8035edb0..5b648d754 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -95,7 +95,7 @@ void setup(void)
 			"The vulnerability was only present in 32-bit compat mode");
 	}
 
-	SAFE_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
 
 	SAFE_UNSHARE(CLONE_NEWUSER);
 	SAFE_UNSHARE(CLONE_NEWNET);
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
