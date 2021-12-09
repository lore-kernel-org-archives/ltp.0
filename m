Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3553C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 10:29:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65A433C7FCB
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 11:29:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E11833C1D8F
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 11:28:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36579600806
 for <ltp@lists.linux.it>; Thu,  9 Dec 2021 11:28:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 46B331F37F;
 Thu,  9 Dec 2021 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1639045737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VQ0KZXHCK5o9ZRVWCHTBlk4CaA56beEPI6gCZ3SeRSs=;
 b=exPtVCoQv3vARJjWVjg3Kfa/Pv1D535fQgQ3AXsbtVru37dT8oIahDTqa6dU/eEG+lcerK
 EBN3glvCOJu8A1qF9X5Hd0zRDeS/erEDAVcMvIOuv0O19XkSNgLIEpXXAhep87fomHDo18
 b+LVPqtGU9FyrHT9eoE+7b827TlYX8g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 169A913B2D;
 Thu,  9 Dec 2021 10:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 43nEAmnasWG3KwAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Thu, 09 Dec 2021 10:28:57 +0000
To: ltp@lists.linux.it
Date: Thu,  9 Dec 2021 11:28:55 +0100
Message-Id: <20211209102855.6628-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] Add documentation for tst_parse_* helpers functions
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
 doc/c-test-api.txt | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 64d0630ce..90935e5a0 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -457,18 +457,24 @@ NOTE: The test parameters must not collide with common test parameters defined
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
 
+In particular, 'tst_parse_filesize' function accepts prefix multiplies such as
+"k/K for kilobytes, "m/M" for megabytes and "g/G" for gigabytes. For example,
+10K are converted into 10240 bytes.
+
 .Example Usage
 [source,c]
 -------------------------------------------------------------------------------
@@ -481,7 +487,7 @@ static int threads = 10;
 static struct tst_option options[] = {
 	{"t:", &str_threads, "Number of threads (default 10)"},
 	...
-	{NULL, NULL, NULL}
+	{}
 };
 
 static void setup(void)
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
