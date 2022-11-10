Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3248CC4332F
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 14:23:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50EB33CDD8E
	for <ltp@archiver.kernel.org>; Thu, 10 Nov 2022 15:23:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B52903CD694
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 15:23:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 93FE9140114C
 for <ltp@lists.linux.it>; Thu, 10 Nov 2022 15:23:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70C9A22B0A;
 Thu, 10 Nov 2022 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668090200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1vBMXSat3WyLGFZGlbjpnvMPsv9S4SJY4eE9HmRyIvU=;
 b=eyJZF6aLg1c+7nyRg80YPBlNIKYD3DT+x7VlknHy7QjaUIAhyZDJWTNitZZFGBlvmc1pPh
 ke9/pUG1OAUKfY7865mpqtyPz0Uw05dlGvRJsr8Ckr0NBGhbDgTo1VAIVQzgr1O0TjzH+P
 8d9A0xOty9RI4xy4VY9OyE01OZuJry8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668090200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1vBMXSat3WyLGFZGlbjpnvMPsv9S4SJY4eE9HmRyIvU=;
 b=olMw5Kx7sajh1Ia9itO0PnNZJ1a7BqnhXu7zQVMAEKmeqUos7R8M5dUqllRXTMQVkzs+kh
 ncMy9+4SNrdh36Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 479981332F;
 Thu, 10 Nov 2022 14:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ihrZD1gJbWN6IAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Nov 2022 14:23:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Nov 2022 15:23:16 +0100
Message-Id: <20221110142316.754-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] README.md: Document IRC
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I suppose although we communicate mainly over ML and sometimes in github
issues, we should document IRC as at least some of as are on that
channel.

Kind regards,
Petr

 README.md | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/README.md b/README.md
index d45d1ee44..d88dd3488 100644
--- a/README.md
+++ b/README.md
@@ -22,6 +22,9 @@ http://lists.linux.it/listinfo/ltp
 LTP mailing list is archived at:
 https://lore.kernel.org/ltp/
 
+IRC
+#ltp on https://libera.chat/[irc.libera.chat]
+
 The git repository is located at GitHub at:
 https://github.com/linux-test-project/ltp
 
-- 
2.38.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
