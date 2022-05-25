Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61727C433EF
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 10:33:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0100F3CAC69
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 12:33:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A89AA3CAC4B
 for <ltp@lists.linux.it>; Wed, 25 May 2022 12:33:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8FDB3200BAF
 for <ltp@lists.linux.it>; Wed, 25 May 2022 12:33:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653474823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D9k59P/DqlwN/ZNGLS6i4eaT1RD1UBDzJZTBQcuWue4=;
 b=SY4jSMpO/H2pHjl0gPgd5cpn8N1zhu7rcl2JZ3VF2vaUsEwhLiqJvuasQrAkcPGRFq1v5U
 5apkEQDWqBrdlHgkuhBNSGmts45siPN7vrMFa4ahQ08itWLvNcUJuHZYnLN25EJE+/3WRZ
 Fwtcmzoj2pcBnZIrO7FyMByLCA1082c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-G4SMwhcuOrKBmbAr2tNLlQ-1; Wed, 25 May 2022 06:33:39 -0400
X-MC-Unique: G4SMwhcuOrKBmbAr2tNLlQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BD45858EED;
 Wed, 25 May 2022 10:33:39 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F28A7AD8;
 Wed, 25 May 2022 10:33:37 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 25 May 2022 18:33:36 +0800
Message-Id: <20220525103336.2676073-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] preadv203: set max_runtime to 60s
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

Before the runtime patchset preadv203 uses 5min as default timeout
per fs, that's really long enough for each test. But after that, it
now only has 30s which is too short to finish the verify_preadv2()
function that spins for at most 60 seconds.

  ==== Before =====
  # ./preadv203
  ...
  tst_test.c:1459: TINFO: Timeout per run is 0h 05m 00s
  preadv203.c:143: TINFO: Number of full_reads 2567, short reads 10, zero len reads 0, EAGAIN(s) 2530185
  preadv203.c:180: TINFO: Number of writes 682740
  preadv203.c:194: TINFO: Cache dropped 114 times
  preadv203.c:223: TPASS: Got some EAGAIN
  tst_test.c:1531: TINFO: Testing on ext3
  tst_test.c:999: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
  mke2fs 1.46.5 (30-Dec-2021)
  tst_test.c:1459: TINFO: Timeout per run is 0h 05m 00s
  ...

  ==== After =====
  # ./preadv203
  tst_device.c:89: TINFO: Found free device 0 '/dev/loop0'
  tst_test.c:1524: TINFO: Timeout per run is 0h 00m 30s
  tst_supported_fs_types.c:89: TINFO: Kernel supports ext2
  ...
  tst_test.c:1597: TINFO: Testing on ext2
  tst_test.c:1062: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
  mke2fs 1.46.5 (30-Dec-2021)
  Test timeouted, sending SIGKILL!
  tst_test.c:1575: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
  tst_test.c:1577: TBROK: Test killed! (timeout?)

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/preadv2/preadv203.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 01622ad15..60dc4a882 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -199,7 +199,6 @@ static void *cache_dropper(void *unused)
 static void verify_preadv2(void)
 {
 	pthread_t reader, dropper, writer;
-	unsigned int max_runtime = 600;
 	void *eagains;
 
 	stop = 0;
@@ -210,7 +209,7 @@ static void verify_preadv2(void)
 	SAFE_PTHREAD_CREATE(&reader, NULL, nowait_reader, NULL);
 	SAFE_PTHREAD_CREATE(&writer, NULL, writer_thread, NULL);
 
-	while (!stop && max_runtime-- > 0)
+	while (!stop && tst_remaining_runtime())
 		usleep(100000);
 
 	stop = 1;
@@ -279,5 +278,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
+	.max_runtime = 60,
 	.needs_root = 1,
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
