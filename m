Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DE9C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 04:05:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D03A3C9AF3
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 05:05:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC09B3C5776
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 05:04:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 00332140054C
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 05:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644206695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3n4H6zCp6SSQdWLDGHZqxu6IElxbiDcCYJ5X1/CKUr8=;
 b=Yw5kUu+xxnlLVG260v6BFBrLAYweAabKWf0ZTZ9Kbd3lfbyR2LQV4Ts3MZr90RJXzp6n+D
 0ZOadiAgyr0bvTQwFKEQ4pTrIT2TeXcZdrPvuPgIZKI6K7z7xu/1bVii7jvqDw/9AG+r5I
 Z2FRq9m2YqWUcz4dlN5B90YD5FI0SIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-T5b97sRxNrucVKPOSPInfQ-1; Sun, 06 Feb 2022 23:04:52 -0500
X-MC-Unique: T5b97sRxNrucVKPOSPInfQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3733C1006AA5
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 04:04:51 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70A834CED5
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 04:04:48 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon,  7 Feb 2022 12:04:47 +0800
Message-Id: <20220207040447.2803113-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getrusage03: skip on small RAM system
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

It is easy to get VmSwap increase with a small system, here is
run with a 1G RAM kvm guest and TBROK:

    7	tst_test.c:1365: TINFO: Timeout per run is 0h 05m 00s
    8	getrusage03.c:43: TPASS: initial.self ~= child.self
    9	getrusage03.c:57: TPASS: initial.children ~= 100MB
    10	getrusage03.c:66: TPASS: child.children == 0
    11	getrusage03.c:84: TPASS: child.children ~= 300MB
    12	getrusage03.c:104: TPASS: initial.children ~= pre_wait.children
    13	getrusage03.c:112: TPASS: post_wait.children ~= 400MB
    14	getrusage03.h:25: TBROK: VmSwap is not zero
    15	getrusage03.c:133: TPASS: initial.children ~= after_zombie.children
    16	getrusage03.h:25: TBROK: VmSwap is not zero
    17	getrusage03_child.c:57: TPASS: initial.self ~= exec.self
    18	getrusage03_child.c:62: TPASS: initial.children ~= exec.children

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    Ps. I also think we might need .min_mem_[avai|total] field but
        not sure if it is really necessary to add that.

 testcases/kernel/syscalls/getrusage/getrusage03.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
index bf5127483..5aa0b2326 100644
--- a/testcases/kernel/syscalls/getrusage/getrusage03.c
+++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
@@ -173,6 +173,14 @@ static void run(unsigned int i)
 	}
 }
 
+static void setup(void)
+{
+	long long mem_avail = tst_available_mem();
+
+	if (mem_avail < 512L*1024)
+		tst_brk(TCONF, "Needed > 512MB availabe, only have: %ld kB", mem_avail);
+}
+
 static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
@@ -182,6 +190,7 @@ static struct tst_test test = {
 		{"linux-git", "1f10206cf8e9"},
 		{}
 	},
+	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(testfunc_list),
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
