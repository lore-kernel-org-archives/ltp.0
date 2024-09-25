Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57982C369AA
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 08:49:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A7103C4DAD
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 10:49:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 933113C31A5
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 10:49:37 +0200 (CEST)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id C4BBC140120C
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 10:49:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=dTHua
 XzvhYJHqP1atRvIMTJOa9iY4kLjdwGSTJDuqCs=; b=NwK0tFbc/E6WBDFXsn8fj
 MknTTmyW9hZVd9xRWQ7/bK0qzmolquNuy02awsvpXIpbtmqEet4Oq1hrA+dzxHy6
 XLlg7+K58aQMSAyhBktetIFy/++kFQZHGZ9b8U92qaVzdCNg100Ogj5sLSnJkAH5
 V4jq1DqjvrjsBQ3rV79SyY=
Received: from fedora40.. (unknown [160.86.227.245])
 by gzga-smtp-mta-g3-3 (Coremail) with SMTP id _____wDXj1STzvNmwQsWFQ--.51379S2;
 Wed, 25 Sep 2024 16:49:27 +0800 (CST)
From: Xiao Yang <ice_yangxiao@163.com>
To: ltp@lists.linux.it
Date: Wed, 25 Sep 2024 17:49:21 +0900
Message-ID: <20240925084921.16352-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-CM-TRANSID: _____wDXj1STzvNmwQsWFQ--.51379S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1fKr4UKw1xZFyrKr1UGFg_yoW8Zw4rp3
 yxtw1Ikw4FqFyrtrW8uanYqay8uwn8Xr15CF4Yyr4Fvr40kFn8Cr4qq3W3JFyUWFW3uayY
 93y3Xr4Fyw4Fga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUkfQ_UUUUU=
X-Originating-IP: [160.86.227.245]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiMw1lXmbzzYofGQAAsR
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/{fanotify17,
 getxattr05}: Fix the ENOSPC error
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

If the value of max_user_namespaces is set to 10 but more than
10 user namspaces are currently used on system.  In this case,
these tests fail with ENOSPC. for example:

# lsns -t user -n | wc -l
17

# ./fanotify17
...
fanotify17.c:174: TINFO: Test #0: Global groups limit in init user ns
fanotify17.c:130: TPASS: Created 128 groups - below groups limit (128)
fanotify17.c:174: TINFO: Test #1: Global groups limit in privileged user ns
fanotify17.c:154: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
tst_test.c:452: TBROK: Invalid child (6958) exit value 1

Try to fix the issue by increasing the default value of
max_user_namespaces by 10.

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 testcases/kernel/syscalls/fanotify/fanotify17.c | 2 +-
 testcases/kernel/syscalls/getxattr/getxattr05.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
index 3ecb31b6e..a6206d953 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify17.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
@@ -224,7 +224,7 @@ static void setup(void)
 		user_ns_supported = 0;
 	} else if (!access(MAX_USERNS, F_OK)) {
 		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
-		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
+		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns + 10);
 	}
 
 	/*
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index d9717a695..f1c8e8391 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -156,7 +156,7 @@ static void setup(void)
 		user_ns_supported = 0;
 	} else if (!access(MAX_USERNS, F_OK)) {
 		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
-		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
+		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns + 10);
 	}
 
 }
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
