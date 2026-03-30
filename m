Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B247FB3CF7
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774865298; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=OuZ+OTLtNmTjWO0Lujdn8DsORJhS9wNuZONYZMm6HzY=;
 b=TNW72iCiPsmf+6OMsb08rghTAO61xdnsOZ1UzyvJOcJKnLfsKWfDzR+rb48k05CeKRqrM
 L7MP+c4UBpTMhdvGIisESqPRuSBMiZEZHXZERloiGsBloxYClDCPeNCa9j1pO7Hf4CnHcB3
 /CmMibnbup7WL0njSIiql5IjTu8ATmA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDB0F3E4F14
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 12:08:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6070D3CED08
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:07:53 +0200 (CEST)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7567F20093D
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 12:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=sePDNAW5dgssgolCZO7X76BkFFlRVH1ZG4MBZgb0qFU=; b=sl+ryoWqWcFL
 4NrVnbqND4HFNGaSbPdxe0YIrR3DL6lVbZY1pxS6pxYOEdW76eDb2MI3euS2tkoX0K067McAuDlQq
 oTWEq0E9ar0rTQ4TPBxfXuPubHaIyaQbRutvrqupKOPxla/pIHKUOMjmXgODsABMwkCjzx1uViBsg
 fiaX6UhQzHL+B9FoXe5hZOomKuEIbYryU4tsGeNsE67J/h69jcOMkXp9gRLJ14vZbZGx6pkAzrSdq
 SBtrRI4mTmx+KdqnW6ZeCvqrj1BVqIooQtCFsT3LIvCKOFaFIJc24tW/vpWuwId4SwLjuS5DDk4K9
 Jm+1tnP+yHo0oeLTySWfmg==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1w79V8-0029vd-1b; Mon, 30 Mar 2026 12:07:44 +0200
To: ltp@lists.linux.it
Date: Mon, 30 Mar 2026 10:07:44 +0000
Message-ID: <20260330100750.858390-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pidns32: fix PID namespace nesting depth off-by-one
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The 2023 refactor used tst_atomic_inc() before clone with a zero-initial
counter, which only performed 31 CLONE_NEWPID nests while still expecting
MAXNEST (32). Compare the level to MAXNEST first, then increment and clone,
so the shared counter runs 0..32 and the chain reaches 32 nested namespaces
again.

Fixes: 647cfd468c3b ("Refactor pidns32 test using new LTP API")
Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 testcases/kernel/containers/pidns/pidns32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index fc9bf0aaa..3a272f569 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -27,9 +27,11 @@ static pid_t child_func(void)
 {
 	pid_t cpid = 0;
 
-	if (tst_atomic_inc(level) == MAXNEST)
+	if (tst_atomic_load(level) == MAXNEST)
 		return cpid;
 
+	tst_atomic_inc(level);
+
 	cpid = SAFE_CLONE(&args);
 	if (!cpid) {
 		child_func();
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
