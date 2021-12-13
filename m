Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00DEC433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 10:58:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3095F3C8B0A
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 11:58:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62CC13C88E7
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:58:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BBC52200BDC
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:58:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C70B91F3BB;
 Mon, 13 Dec 2021 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639393122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZBaknDvUEDr8+TL+j9hReJv6xSGabyzqbzGmREL67uM=;
 b=fI5jKGELZyWEzbaeDW8z+D3qunF5fP39IJxsci/MGSK0RIhfYKspJWBEKAiGMEzVxqqez+
 lUSe9AoVX0NkIQsjlkJv2Elwpiqf/UVRtpU/FjQPbiYzAITfqS+VJtaHlUROZI4IBxYqG9
 ASSZTIwxkbthM5CEBfU/E/aHHRLnjvc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EDBC13CE5;
 Mon, 13 Dec 2021 10:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bA2GJGInt2HqSwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 13 Dec 2021 10:58:42 +0000
To: ltp@lists.linux.it
Date: Mon, 13 Dec 2021 11:58:41 +0100
Message-Id: <20211213105841.2670-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add io_read_eof in common.h utilities
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/io/ltp-aiodio/common.h | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/testcases/kernel/io/ltp-aiodio/common.h b/testcases/kernel/io/ltp-aiodio/common.h
index c9fd0bbaa..304613496 100644
--- a/testcases/kernel/io/ltp-aiodio/common.h
+++ b/testcases/kernel/io/ltp-aiodio/common.h
@@ -86,6 +86,37 @@ static inline void io_read(const char *filename, int filesize, volatile int *run
 	SAFE_CLOSE(fd);
 }
 
+static inline void io_read_eof(const char *filename, volatile int *run_child)
+{
+	char buff[4096];
+	int fd;
+	int r;
+
+	while ((fd = open(filename, O_RDONLY, 0666)) < 0)
+		usleep(100);
+
+	tst_res(TINFO, "child %i reading file", getpid());
+
+	while (*run_child) {
+		off_t offset = 0;
+		char *bufoff;
+
+		SAFE_LSEEK(fd, SEEK_END, 0);
+
+		r = SAFE_READ(0, fd, buff, sizeof(buff));
+		if (r > 0) {
+			bufoff = check_zero(buff, r);
+			if (bufoff) {
+				tst_res(TINFO, "non-zero read at offset %zu",
+					offset + (bufoff - buff));
+				break;
+			}
+		}
+	}
+
+	SAFE_CLOSE(fd);
+}
+
 /*
  * This code tries to create dirty free blocks on
  * the HDD so there is a chance that blocks to be allocated
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
