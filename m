Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0BFC433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 16:11:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DA653C22F6
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 17:11:30 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 356D73C0681
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 17:11:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9391620004D
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 17:11:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC8501FD34;
 Mon,  6 Dec 2021 16:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638807079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8pnwA+LoYE/b89KyG4Q4msyLiUNOo4x7m+ke9alcT2c=;
 b=szSGCN1NyWvo2TnOlQqldTLdF999ZAcaPvJQ1Hgk5BMefqNjxJup6i8UK8y9E0s3pefmEN
 h3yNL4x3p2Lg1DBvCSLN/biHdx9RRjKiUNjjCe5nv0TH/6blHvbkiiVKC4IdH3x2RtHrRD
 JpMLOPZ8Z9PsnQLtRlfAVVBTj9FFPFg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A771413C4C;
 Mon,  6 Dec 2021 16:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wKfNJic2rmElagAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Mon, 06 Dec 2021 16:11:19 +0000
To: ltp@lists.linux.it
Date: Mon,  6 Dec 2021 17:11:12 +0100
Message-Id: <20211206161112.5726-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add tst_parse_filesize functionality in LTP test
 API
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
 lib/tst_test.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index a79275722..6cb003802 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -679,6 +679,47 @@ int tst_parse_float(const char *str, float *val, float min, float max)
 	return 0;
 }
 
+int tst_parse_filesize(const char *str, long long *val, long long min, long long max)
+{
+	long long rval;
+	char *end;
+
+	if (!str)
+		return 0;
+
+	errno = 0;
+	rval = strtoll(str, &end, 10);
+
+	if (str == end)
+		return EINVAL;
+
+	if (errno)
+		return errno;
+
+	switch (*end) {
+	case 'g':
+	case 'G':
+		rval *= (1024 * 1024 * 1024);
+		break;
+	case 'm':
+	case 'M':
+		rval *= (1024 * 1024);
+		break;
+	case 'k':
+	case 'K':
+		rval *= 1024;
+		break;
+	default:
+		break;
+	}
+
+	if (rval > max || rval < min)
+		return ERANGE;
+
+	*val = rval;
+	return 0;
+}
+
 static void print_colored(const char *str)
 {
 	if (tst_color_enabled(STDOUT_FILENO))
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
