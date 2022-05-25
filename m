Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B01EC433EF
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 06:51:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D25693CAC5E
	for <ltp@archiver.kernel.org>; Wed, 25 May 2022 08:51:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D824D3C08DA
 for <ltp@lists.linux.it>; Wed, 25 May 2022 08:51:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 56275140004F
 for <ltp@lists.linux.it>; Wed, 25 May 2022 08:51:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653461489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/k4/TLkX32y95DgKZgSNTsZ6/+6QLn58kMo5hk7EAM=;
 b=icwe/0p0GJEKswUIp3MLthczaMDBtf0zdjpoC8Kc6p9Y90D1kqxT7qSEiFEgEnN9lNXcxD
 UJZb2AP63oZ+QS8GCHHE0/B6Q1pEcXYLewnt8XZq91meTD/kXRCmFbQg4ES7TggUyhRSDH
 4aKU0YtEKRKX2U47bjqAUjGl3lRPnZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-3xU2BkU1MkWsQtBABioOuw-1; Wed, 25 May 2022 02:51:28 -0400
X-MC-Unique: 3xU2BkU1MkWsQtBABioOuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE3D5858EED;
 Wed, 25 May 2022 06:51:27 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BAEF1410DD5;
 Wed, 25 May 2022 06:51:26 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 25 May 2022 14:51:24 +0800
Message-Id: <20220525065124.2665801-1-liwang@redhat.com>
In-Reply-To: <YozXG/f0HHSrhm9E@yuki>
References: <YozXG/f0HHSrhm9E@yuki>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] preadv203: set max_runtime to 270s
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

Before the runtime patchset preadv203 use 5min as default timeout
per fs, that's really long enough for prepare_device(). But after
that, its now only has 30s which might be short for a slower system
to do preparation work.

Let's set max_runtime to 270s to make the timeout at least equal
to previously.

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
  # time ./preadv203
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

  Summary:
  passed   0
  failed   0
  broken   1
  skipped  0
  warnings 0

  real	0m36.246s
  user	0m0.706s
  sys	1m2.965s

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
---

Notes:
    Another fixe way is going with define DEFAULT_TIMEOUT to 60, that
    generally extends all timeout for each fs to perform prepare_device().
    And this will impact all test cases with setting .all_filesystems.

 testcases/kernel/syscalls/preadv2/preadv203.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 01622ad15..46bb39ef1 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -279,5 +279,6 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.mount_device = 1,
 	.all_filesystems = 1,
+	.max_runtime = 270,
 	.needs_root = 1,
 };
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
