Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9923C7EE25
	for <ltp@archiver.kernel.org>; Tue, 16 May 2023 16:59:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F9C53CDD56
	for <ltp@archiver.kernel.org>; Tue, 16 May 2023 18:59:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5C423CBD7C
 for <ltp@lists.linux.it>; Tue, 16 May 2023 18:59:33 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 030471400521
 for <ltp@lists.linux.it>; Tue, 16 May 2023 18:59:32 +0200 (CEST)
Received: from [172.29.16.86] (helo=finist-vl9.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <khorenko@virtuozzo.com>) id 1pyy0B-000MFC-1l;
 Tue, 16 May 2023 18:59:21 +0200
To: ltp@lists.linux.it
Date: Tue, 16 May 2023 19:59:28 +0300
Message-Id: <20230516165929.1343864-1-khorenko@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] scsi_debug/tlibio/lio_write_buffer: Always return
 total amount of written bytes
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
From: Konstantin Khorenko via ltp <ltp@lists.linux.it>
Reply-To: Konstantin Khorenko <khorenko@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Sometimes we got failures like:
 growfiles(gf217): 65884 growfiles.c/2262: 104203 tlibio.c/744 write(3, buf, 5000) returned=2288
 growfiles(gf217): 65884 growfiles.c/1765: 104203 Hit max errors value of 1
 gf217       1  TFAIL  :  growfiles.c:134: Test failed

Which looked strange as partial write is something usual and valid.
It turned out that lio_write_buffer() has the code cycle writes in case
of a partial write happens, but it anyway returns the amount of bytes
written by the LAST write.

And upper growfile() consider the returned amount from
lio_write_buffer() to be less than it tried to write and fails the
testcase.

Fix lio_write_buffer() to always return total bytes written, even in
case partial writes.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 lib/tlibio.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index cc110d1c9..8298e2de9 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -539,6 +539,8 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 		long wrd)	/* to allow future features, use zero for now */
 {
 	int ret = 0;		/* syscall return or used to get random method */
+	int totally_written = 0;/* as we cycle writes in case of partial writes, */
+				/* we have to report up total bytes written */
 	char *io_type;		/* Holds string of type of io */
 	int omethod = method;
 	int listio_cmd;		/* Holds the listio/lio_listio cmd */
@@ -745,13 +747,14 @@ int lio_write_buffer(int fd,		/* open file descriptor */
 						fd, size, ret);
 					size -= ret;
 					buffer += ret;
+					totally_written += ret;
 				} else {
 					if (Debug_level > 1)
 						printf
 						    ("DEBUG %s/%d: write completed without error (ret %d)\n",
 						     __FILE__, __LINE__, ret);
 
-					return ret;
+					return totally_written + ret;
 				}
 			}
 			wait4sync_io(fd, 0);
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
