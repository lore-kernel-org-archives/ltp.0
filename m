Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804B3C83F14
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 10:43:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 304E63CC087
	for <ltp@archiver.kernel.org>; Tue, 29 Aug 2023 12:43:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E69DF3C8948
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:43:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 39E1B10009B6
 for <ltp@lists.linux.it>; Tue, 29 Aug 2023 12:43:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C528E1F45F;
 Tue, 29 Aug 2023 10:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693305798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HC+ih5tTq/xu5fUMfx+wUyZDcBF3CGshu/E4vnl4idk=;
 b=RhwUKZjPCKF0q4jCFxoKRrvMNxKMkUaDalhjVk2Lo2svMoaSOx+uYegSJcFE1CInY8cMcZ
 L3e+ah9B0fvnwECH2TtIZl/Z4zXrPZ7s+NEw0ZTyBGLlKPFdwXfM3ctho4CR0Yv0FgDRfX
 Fn8C0lQ/19XRq4yH9TzdZ09R4G+OLaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693305798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HC+ih5tTq/xu5fUMfx+wUyZDcBF3CGshu/E4vnl4idk=;
 b=2ywKAi3ZCs3u+y/boPv2i+mFim4ppRPMjMElqZyGn/q0e2RIX70PSravdW1TJAfMR2yLjN
 l+qdK1OIaqqMrdBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B541D13301;
 Tue, 29 Aug 2023 10:43:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xjpeDMDL7WRxAgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 29 Aug 2023 10:43:12 +0000
Date: Tue, 29 Aug 2023 12:41:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZO3LUpPOJs1Qn0H7@rei>
References: <20230823130904.26051-1-andrea.cervesato@suse.de>
 <ZO2dfwOM0pK8xz1j@rei>
 <1717e228-1556-4ba0-8f91-4cb7160c3908@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1717e228-1556-4ba0-8f91-4cb7160c3908@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add epoll_wait05 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> If patch is fine, is it possible to push it removing the reference?

Pushed with one minor change, thanks.

I've also added check that epoll_wait() returns 1 otherwise the content
of the returned event is not valid.

Full diff:

diff --git a/testcases/kernel/mce-test b/testcases/kernel/mce-test
index 95e136a3b..0b4e77570 160000
--- a/testcases/kernel/mce-test
+++ b/testcases/kernel/mce-test
@@ -1 +1 @@
-Subproject commit 95e136a3b0cde818448d5fcff5bf75d58600dc0d
+Subproject commit 0b4e7757068381139db1317c07bdb7532196ef76
diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
index a055a5885..d06a024ff 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait05.c
@@ -8,8 +8,6 @@
  *
  * Verify that epoll receives EPOLLRDHUP event when we hang a reading
  * half-socket we are polling on.
- *
- * As reference please check https://lwn.net/Articles/864947/
  */
 
 #include "tst_test.h"
@@ -52,6 +50,7 @@ static void run(void)
 	struct sockaddr_in client_addr;
 	struct epoll_event evt_req;
 	struct epoll_event evt_rec;
+	int ret;
 
 	if (!SAFE_FORK()) {
 		create_server();
@@ -79,13 +78,18 @@ static void run(void)
 	tst_res(TINFO, "Hang socket");
 
 	TST_EXP_PASS_SILENT(shutdown(sockfd_client, SHUT_RD));
-	SAFE_EPOLL_WAIT(epfd, &evt_rec, 1, 2000);
+	ret = SAFE_EPOLL_WAIT(epfd, &evt_rec, 1, 2000);
+	if (ret != 1) {
+		tst_res(TFAIL, "Wrong number of events reported %i", ret);
+		goto exit;
+	}
 
 	if (evt_rec.events & EPOLLRDHUP)
 		tst_res(TPASS, "Received EPOLLRDHUP");
 	else
 		tst_res(TFAIL, "EPOLLRDHUP has not been received");
 
+exit:
 	SAFE_CLOSE(epfd);
 	SAFE_CLOSE(sockfd_client);
 
@@ -119,8 +123,4 @@ static struct tst_test test = {
 	.test_all = run,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
-	.tags = (const struct tst_tag[]) {
-		{"linux-git", "3a34b13a88ca"},
-		{},
-	}
 };

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
