Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1153AC433EF
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 13:35:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D8C33C5743
	for <ltp@archiver.kernel.org>; Tue,  7 Dec 2021 14:35:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D84D3C2911
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:35:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E0F9520032D
 for <ltp@lists.linux.it>; Tue,  7 Dec 2021 14:35:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 250C521B38;
 Tue,  7 Dec 2021 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1638884117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=SJNnmw9Dpj5zTKKSxwRESB1+3muDBGC+tSa7S1inlko=;
 b=etRXRfaGNF3zk/i6tb7CUTL/FKgy+jfjp0K2R7LlnQ+rXuH5puUFeXHXuABNd8Re5i7/pS
 8CH4WG006LSplukiFP4/kg2Crqn+C6agqg5mHqqGOdvzQX0YhgHxFGgVhllxu2lSIUQtsw
 8qr+LQxfiU01NE+9H1uImDdS2gi/gsQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED3B513A7E;
 Tue,  7 Dec 2021 13:35:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mSjPNxRjr2HtTQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 07 Dec 2021 13:35:16 +0000
To: ltp@lists.linux.it
Date: Tue,  7 Dec 2021 14:35:15 +0100
Message-Id: <20211207133515.24053-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Add documentation for tst_parse_* helpers functions
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
 doc/c-test-api.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 64d0630ce..b03124ed3 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -457,15 +457,17 @@ NOTE: The test parameters must not collide with common test parameters defined
 [source,c]
 -------------------------------------------------------------------------------
 int tst_parse_int(const char *str, int *val, int min, int max);
+int tst_parse_long(const char *str, long *val, long min, long max);
 int tst_parse_float(const char *str, float *val, float min, float max);
+int tst_parse_filesize(const char *str, long long *val, long long min, long long max);
 -------------------------------------------------------------------------------
 
 Helpers for parsing the strings returned in the 'struct tst_option'.
 
-Both return zero on success and 'errno', mostly 'EINVAL' or 'ERANGE', on
+Helpers return zero on success and 'errno', mostly 'EINVAL' or 'ERANGE', on
 failure.
 
-Both functions are no-op if 'str' is 'NULL'.
+Helpers functions are no-op if 'str' is 'NULL'.
 
 The valid range for result includes both 'min' and 'max'.
 
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
