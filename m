Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63523C77B78
	for <ltp@archiver.kernel.org>; Sun, 23 Apr 2023 02:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17EBB3CBE57
	for <ltp@archiver.kernel.org>; Sun, 23 Apr 2023 04:27:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A6933CAD0A
 for <ltp@lists.linux.it>; Sun, 23 Apr 2023 04:27:28 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 91B2B2002D1
 for <ltp@lists.linux.it>; Sun, 23 Apr 2023 04:27:22 +0200 (CEST)
X-UUID: 98b568ead06945a997278978f2694d48-20230423
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:2e884932-2751-4ec9-8b35-5a8b72e44105, IP:10,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTI
 ON:release,TS:-4
X-CID-INFO: VERSION:1.1.22, REQID:2e884932-2751-4ec9-8b35-5a8b72e44105, IP:10,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
 :release,TS:-4
X-CID-META: VersionHash:120426c, CLOUDID:2feed1eb-db6f-41fe-8b83-13fe7ed1ef52,
 B
 ulkID:230423102705IM8YRGR4,BulkQuantity:0,Recheck:0,SF:24|17|19|42|102,TC:
 nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
 I:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 98b568ead06945a997278978f2694d48-20230423
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
 (envelope-from <zenghao@kylinos.cn>) (Generic MTA)
 with ESMTP id 275759830; Sun, 23 Apr 2023 10:27:05 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
 by mail.kylinos.cn (NSMail) with SMTP id 2FAD2E0084A1;
 Sun, 23 Apr 2023 10:27:05 +0800 (CST)
X-ns-mid: postfix-64449779-89884155
Received: from zdzh5-QiTianM428-A376.. (unknown [172.20.12.253])
 by mail.kylinos.cn (NSMail) with ESMTPA id 6D56AE0084A5;
 Sun, 23 Apr 2023 10:27:03 +0800 (CST)
From: Hao Zeng <zenghao@kylinos.cn>
To: chrubis@suse.cz
Date: Sun, 23 Apr 2023 10:27:02 +0800
Message-Id: <20230423022702.3486141-1-zenghao@kylinos.cn>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] fs/doio:Use the snprintf function to prevent
 buffer overflow
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
Cc: Hao Zeng <zenghao@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Use the snprintf function instead of sprintf in the write_log.c file

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
---
 testcases/kernel/fs/doio/write_log.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/fs/doio/write_log.c b/testcases/kernel/fs/doio/write_log.c
index e8ef9c7cb..44e6fd165 100644
--- a/testcases/kernel/fs/doio/write_log.c
+++ b/testcases/kernel/fs/doio/write_log.c
@@ -141,7 +141,7 @@ int wlog_open(struct wlog_file *wfile, int trunc, int mode)
 
 	oflags = O_RDWR;
 	if ((wfile->w_rfd = open(wfile->w_file, oflags)) == -1) {
-		sprintf(Wlog_Error_String,
+		snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 			"Could not open write log - open(%s, %#o) failed:  %s\n",
 			wfile->w_file, oflags, strerror(errno));
 		close(wfile->w_afd);
@@ -218,14 +218,14 @@ int wlog_record_write(struct wlog_file *wfile, struct wlog_rec *wrec,
 		reclen += 2;
 
 		if (write(wfile->w_afd, wbuf, reclen) == -1) {
-			sprintf(Wlog_Error_String,
+			snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 				"Could not write log - write(%s, %s, %d) failed:  %s\n",
 				wfile->w_file, wbuf, reclen, strerror(errno));
 			return -1;
 		} else {
 			offset = lseek(wfile->w_afd, 0, SEEK_CUR) - reclen;
 			if (offset == -1) {
-				sprintf(Wlog_Error_String,
+				snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 					"Could not reposition file pointer - lseek(%s, 0, SEEK_CUR) failed:  %s\n",
 					wfile->w_file, strerror(errno));
 				return -1;
@@ -233,13 +233,13 @@ int wlog_record_write(struct wlog_file *wfile, struct wlog_rec *wrec,
 		}
 	} else {
 		if ((lseek(wfile->w_rfd, offset, SEEK_SET)) == -1) {
-			sprintf(Wlog_Error_String,
+			snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 				"Could not reposition file pointer - lseek(%s, %ld, SEEK_SET) failed:  %s\n",
 				wfile->w_file, offset, strerror(errno));
 			return -1;
 		} else {
 			if ((write(wfile->w_rfd, wbuf, reclen)) == -1) {
-				sprintf(Wlog_Error_String,
+				snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 					"Could not write log - write(%s, %s, %d) failed:  %s\n",
 					wfile->w_file, wbuf, reclen,
 					strerror(errno));
@@ -274,14 +274,14 @@ int wlog_scan_backward(struct wlog_file *wfile, int nrecs,
 	 */
 
 	if ((lseek(fd, 0, SEEK_END)) == -1) {
-		sprintf(Wlog_Error_String,
+		snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 			"Could not reposition file pointer - lseek(%s, 0, SEEK_END) failed:  %s\n",
 			wfile->w_file, strerror(errno));
 		return -1;
 	}
 	offset = lseek(fd, 0, SEEK_CUR);
 	if ((offset == -1)) {
-		sprintf(Wlog_Error_String,
+		snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 			"Could not reposition file pointer - lseek(%s, 0, SEEK_CUR) failed:  %s\n",
 			wfile->w_file, strerror(errno));
 		return -1;
@@ -309,7 +309,7 @@ int wlog_scan_backward(struct wlog_file *wfile, int nrecs,
 		 * Move to the proper file offset, and read into buf
 		 */
 		if ((lseek(fd, offset, SEEK_SET)) == -1) {
-			sprintf(Wlog_Error_String,
+			snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 				"Could not reposition file pointer - lseek(%s, %d, SEEK_SET) failed:  %s\n",
 				wfile->w_file, offset, strerror(errno));
 			return -1;
@@ -318,7 +318,7 @@ int wlog_scan_backward(struct wlog_file *wfile, int nrecs,
 		nbytes = read(fd, bufstart, bufend - bufstart - leftover);
 
 		if (nbytes == -1) {
-			sprintf(Wlog_Error_String,
+			snprintf(Wlog_Error_String, sizeof(Wlog_Error_String),
 				"Could not read history file at offset %d - read(%d, %p, %d) failed:  %s\n",
 				offset, fd, bufstart,
 				(int)(bufend - bufstart - leftover),
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
