Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB0C43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 09:21:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54CAF3C9223
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 11:21:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2B203C927E
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 293A5600712
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD7701FAC6
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655716783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=It8fiu6j4U7NeUILTyecfYAyy5siOMi2iTnAtTFF3ZA=;
 b=l+QzhrPieKyMVwYFwunwYjf9jL11aF3ujUlZnJ8yAfPiyvMN13apS+xpfQLVdE3RJBEIOS
 REvy2/nYrPZYmwdebfTQN6ZWxUoKT9JLzOK4j8kHx+ia6cbvGN+7YtpJda0urTkbElQHRT
 On3UXvBOl/+l02wrZMIy9n5P0n43M2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655716783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=It8fiu6j4U7NeUILTyecfYAyy5siOMi2iTnAtTFF3ZA=;
 b=JM+dIvq1Yo9AqeUG5zDE9lE45kKean7BYsYOiEU7o8GM1Chx6Q2goyaIDyL2vPg5zSjkur
 LaCs74E6IsZQEPBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B815A134CA
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JaZMLK87sGJvQAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:43 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jun 2022 11:21:46 +0200
Message-Id: <20220620092146.7604-8-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620092146.7604-1-chrubis@suse.cz>
References: <20220620092146.7604-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 7/7] opeposix: pthread_barrierattr_getpshared/2-1:
 Simplify codeflow
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

This actually fixes a 'no return in nonvoid function' warning since gcc
may get confused during the codeflow analysis.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../interfaces/pthread_barrierattr_getpshared/2-1.c   | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
index a21a5a507..52c074173 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrierattr_getpshared/2-1.c
@@ -141,7 +141,9 @@ int main(void)
 	if (pid == -1) {
 		perror("Error at fork()");
 		return PTS_UNRESOLVED;
-	} else if (pid == 0) {
+	}
+
+	if (pid == 0) {
 		/* Child */
 		/* Map the shared object to child's memory */
 		barrier =
@@ -209,10 +211,7 @@ int main(void)
 
 		printf("Test PASSED\n");
 		return PTS_PASS;
+	} else {
+		return serial;
 	}
-
-	if (pid == 0) {
-		exit(serial);
-	}
-
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
