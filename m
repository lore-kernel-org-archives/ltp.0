Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0066EC433EF
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 08:34:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE7D63CA339
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 09:34:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FEAF3C5924
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 09:34:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9CB0B1001372
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 09:34:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646296476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BDIrkSmgIWr5gXMjkgrgbySrCm+4oQhaPxC4YpbLyh8=;
 b=OC9cYukc6nkBoqdJF46RzfKjIYMtUatQdYS5LxhLuFTkko/4FOOLFSEPnChoTdJHXdk9/1
 D7TQh6RHZpDP5R0g0oynPLW5dvxsi6tr3POfDP6Ngf/0vRYWr1lBApFbKH4qqVHfHamf8H
 tcdB34P5FVFO0VjBXF3F0Np38tKQhoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-j_cxZkAuMRKdcQ1K-4TEYg-1; Thu, 03 Mar 2022 03:34:34 -0500
X-MC-Unique: j_cxZkAuMRKdcQ1K-4TEYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46967801AAD
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 08:34:33 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 056845DB9C;
 Thu,  3 Mar 2022 08:34:31 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  3 Mar 2022 16:34:29 +0800
Message-Id: <20220303083429.3827302-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] migrate_pages02: check file exist before opening it
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
Cc: bgoncalv@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test reports a warning on some special kernel (with NUMA BALANCE
disabling). The main reason is that prefix '?' makes tst_sys_conf_save
only silent ignores non-exist paths. But seems we still open it in other
places (e.g. in setup function).

  tst_sys_conf.c:58: TINFO: Path not found: '/proc/sys/kernel/numa_balancing'
  tst_test.c:1365: TINFO: Timeout per run is 0h 05m 00s
  migrate_pages02.c:279: TWARN: Failed to open FILE '/proc/sys/kernel/numa_balancing'
  migrate_pages02.c:317: TINFO: Using nodes: 0 1

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    Looks like we have many tests use the prefix '?' for knob save/restore,
    but none of them check if the paths are valid when opening at other places,
    by now, I just get informed that migrate_pages02 threw a warning.
    
    I'm thinking maybe we can keep the return value of tst_sys_conf_save
    as a check condition before opening the file, but this is not fit for
    test with many paths saving:
    e.g.
        add_key05.c-	"?/proc/sys/kernel/keys/gc_delay",
        add_key05.c-	"?/proc/sys/kernel/keys/maxkeys",

 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 485a1c5aa..309e707bc 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -37,6 +37,8 @@
  */
 #define NODE_MIN_FREEMEM (32*1024*1024)
 
+#define NUMA_BALANCING "/proc/sys/kernel/numa_balancing"
+
 #ifdef HAVE_NUMA_V2
 
 static const char nobody_uid[] = "nobody";
@@ -276,7 +278,8 @@ static void setup(void)
 	else if (tst_kvercmp(2, 6, 18) < 0)
 		tst_brk(TCONF, "2.6.18 or greater kernel required");
 
-	FILE_PRINTF("/proc/sys/kernel/numa_balancing", "0");
+	if (access(NUMA_BALANCING, F_OK) == 0)
+		FILE_PRINTF(NUMA_BALANCING, "0");
 	/*
 	 * find 2 nodes, which can hold NODE_MIN_FREEMEM bytes
 	 * The reason is that:
@@ -328,7 +331,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.save_restore = (const char * const[]) {
-		"?/proc/sys/kernel/numa_balancing",
+		"?NUMA_BALANCING",
 		NULL,
 	},
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
