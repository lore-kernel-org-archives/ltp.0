Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850E5C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 09:03:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 997F93CC0A5
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 10:03:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A2F73C69D4
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 10:03:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4DA07200C65
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 10:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675933394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ISjHA2Sj0265vTXsw2dyhOqoC/nq5q9pL+Klc2pnU3M=;
 b=QYseyJScUPDS+uTfxdn5ME8BiPLPat1K3dzvO9fHlOEAbn20wWBjC8eZ1AtgWfkV6u92nB
 uku36qlYGd+Nl4xIay/e2jE4BFeCCG32z6huxXhQ/pKXulPE98Ji2p+yslT2FJ6NXfoaul
 2XcbuNcbX0sjhIzT/bldIMAo5iNnlz8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-xUjpyPuUNfS_P-zRrXS6ow-1; Thu, 09 Feb 2023 04:03:11 -0500
X-MC-Unique: xUjpyPuUNfS_P-zRrXS6ow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC81E1C05149;
 Thu,  9 Feb 2023 09:03:10 +0000 (UTC)
Received: from nay-workstation.nay.redhat.com (unused-66-82-86.nay.redhat.com
 [10.66.82.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0148A2166B29;
 Thu,  9 Feb 2023 09:03:08 +0000 (UTC)
From: Ping Fang <pifang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 Feb 2023 17:03:07 +0800
Message-Id: <20230209090307.491586-1-pifang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] aiocp: Filter out O_DIRECT before read
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
Cc: liwan@redhat.com, rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When aiocp executed with -f DIRECT will fail.

<<<test_start>>>
tag=AD049 stime=1675520824
cmdline="aiocp -b 8k -n 8 -f DIRECT"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1560: TINFO: Timeout per run is 0h 30m 30s
aiocp.c:211: TINFO: Maximum AIO blocks: 65536
tst_device.c:585: TINFO: Use uevent strategy
aiocp.c:250: TINFO: Fill srcfile.bin with random data
aiocp.c:279: TINFO: Copy srcfile.bin -> dstfile.bin
aiocp.c:291: TINFO: Comparing srcfile.bin with dstfile.bin
aiocp.c:306: TBROK: read(3,0x7ffcd743abe0,4096) failed, returned -1: EINVAL (22)
...

syscall read manual ERROR section said that:
EINVAL fd  is  attached to an object which is unsuitable for reading;
or the file was opened with the O_DIRECT flag, and either the address
specified in buf, the value specified in  count, or the file offset is
not suitably aligned.

We need filter out O_DIRECT flag before read.

Signed-off-by: Ping Fang <pifang@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/aiocp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index bc0e209b2..e4252d641 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -297,8 +297,8 @@ static void run(void)
 		return;
 	}
 
-	srcfd = SAFE_OPEN(srcname, srcflags | O_RDONLY, 0666);
-	dstfd = SAFE_OPEN(dstname, srcflags | O_RDONLY, 0666);
+	srcfd = SAFE_OPEN(srcname, (srcflags & ~O_DIRECT) | O_RDONLY, 0666);
+	dstfd = SAFE_OPEN(dstname, (srcflags & ~O_DIRECT) | O_RDONLY, 0666);
 
 	reads = howmany(filesize, buffsize);
 
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
