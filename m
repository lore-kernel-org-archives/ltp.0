Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A66C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 09:21:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B4213C9221
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 11:20:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FE073C9203
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6F5BD600052
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 251371FB54
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655716783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sglOKWEznl6oNG6nvpZEtL9VnjwJ4VRBE6pNVYg785o=;
 b=3M4RIG2qB+w5njZw4jrEmlUwTV9gGbJEKH1KHb3FqJgl+z3C09yD1ifWOkCuzA/9TlYja5
 KTdrBeZTMNji+u10EJI41e/6cBs4mDVPpXNrG7MTpJMz7J6t2WOTJZiKeoYvOJdpkMbaoR
 UbGFPGTZPjocf/7AyZRwb7ZhiGr+V3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655716783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sglOKWEznl6oNG6nvpZEtL9VnjwJ4VRBE6pNVYg785o=;
 b=xNUqEe5TYvcWWebndGQUNLMbwA77RNA9Yty+ziEaJk9O1yeeY88ag/nEyJ78LpEj/Cqxuw
 rRYUOPQMMyswxFBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1179B134CA
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kmcDA687sGJqQAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:43 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jun 2022 11:21:45 +0200
Message-Id: <20220620092146.7604-7-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220620092146.7604-1-chrubis@suse.cz>
References: <20220620092146.7604-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 6/7] openposix: mq_timedreceive: Silence warning
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

We do not use the exit value from the child at all, but that's not a
reason to produce warnings.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../conformance/interfaces/mq_timedreceive/5-3.c                 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
index a843c13ee..d79d9720d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_timedreceive/5-3.c
@@ -110,5 +110,6 @@ int main(void)
 		sleep(1);	/* give time to parent to set up handler */
 		/* send signal to parent */
 		kill(getppid(), SIGABRT);
+		return 0;
 	}
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
