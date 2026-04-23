Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685EFF589DA
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 13:49:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DABB3C0206
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 15:49:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEE7D3E1DE8
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 15:48:48 +0200 (CEST)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D73B360057D
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 15:48:47 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1776952126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=x4/zY60/0tXuYCfjCFC2RpmgL50C0uhJrTB3ehoM448=;
 b=vcm45f8upuvL+PbKSGB83eMV8bfkOGatW3tGQfkdZGk8UdqAdT4EjKGhNeNzsf9DkRNZcx
 ZsyP6BCsi8O3TFmEvEaFQ5/eMC68SKsD6oIcf1Uc4lrvbHzv65sKm60zR9Re0yn+ohZLQI
 CKNC/UXQbp22FacNKLfA4Tob3zXAcr4=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 21:48:38 +0800
Message-ID: <20260423134838.32141-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH COMMITTED] mailmap: enable li.wang@linux.dev address
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

I hope to dedicate this email address to Linux and LTP
development work.

Signed-off-by: Li Wang <li.wang@linux.dev>
---

Notes:
    I apologize for updating the mailmap twice in one day. I didn't
    realize kernel.org has approved my email account so quickly :).

 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index b488d309e..d1e4419f0 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1,4 +1,5 @@
-Li Wang <wangli.ahau@gmail.com> <liwang@redhat.com>
+Li Wang <li.wang@linux.dev> <liwang@redhat.com>
+Li Wang <li.wang@linux.dev> <wangli.ahau@gmail.com>
 Petr Vorel <pvorel@suse.cz> <petr.vorel@gmail.com>
 Petr Vorel <pvorel@suse.cz> <pevik@users.noreply.github.com>
 Xinjian Ma (Fujitsu) <maxj.fnst@fujitsu.com> <maxj.fnst@fujitsu.com>
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
