Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35152C25B47
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 08:37:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F9C93CCBC4
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 10:37:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7E253CCC1C
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 10:37:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 12B36200AD9
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 10:37:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32E5E1FF31;
 Wed, 25 Oct 2023 08:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1698223040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HDWI8Fb9T74yY8Z6qKHCfqWy5WjDHNXTClFD6+dVgEM=;
 b=UdGUBt9ykbTpEFg7e0eRQ0DMaASF6teCtu0jqOJYWIES/Zjc4Lbtn75IIVmC6v8SZxhm4s
 zcR9/E9nTpA6/PjwylsLIDUfJjNDiKWQ7mln+t2YzvrFIG5DEVFr1Mt3RAYcxHekLGvG7P
 yvnaiFK9PjyEeE1+07Jl+zLP3NaEIVg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B50213524;
 Wed, 25 Oct 2023 08:37:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kM0pGb/TOGVhAQAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 25 Oct 2023 08:37:19 +0000
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 04:37:06 -0400
Message-Id: <20231025083706.13767-3-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231025083706.13767-1-wegao@suse.com>
References: <20231021122958.13458-1-wegao@suse.com>
 <20231025083706.13767-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] execl01.c: set stack to unlimited
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/execl/execl01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
index 9268d4976..dfefd1fa8 100644
--- a/testcases/kernel/syscalls/execl/execl01.c
+++ b/testcases/kernel/syscalls/execl/execl01.c
@@ -35,4 +35,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.child_needs_reinit = 1,
 	.test_all = verify_execl,
+	.ulimit = (const struct tst_ulimit_val[]) {
+		{RLIMIT_STACK, RLIM_INFINITY},
+		{}
+	},
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
