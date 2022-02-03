Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76448C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 17:05:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90B893C9A97
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 18:05:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4463C9871
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 18:05:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3C6F41000F26
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 18:05:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2B9B21136;
 Thu,  3 Feb 2022 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643907929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmwCsdBv/AML/Mizfmf+cemZwHHLJYFn6YdmLGAWTTE=;
 b=PPloPfvX6k4T7MSuiYcEIWQZc4mcc4m4wQLtyNSgzDbh/xGGxOz0sQFagZmpF2nUT2FbTX
 f+/CHesHkW2yjAnN4ZXknJKKOtTee8wRYKmOHo6oIaljRRndX81cnakKFQo/ruGHb1NV/u
 qPSI/TNTzhma+FCWMyOYFJr7l9ytGfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643907929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmwCsdBv/AML/Mizfmf+cemZwHHLJYFn6YdmLGAWTTE=;
 b=qRLPtIVmMLrthqFEKmutnwWArPOj7k03Lv/o+e8WA9rJ8RYfHrP5CYkiSNU3fiZZzM8sKH
 BrTbM2a9Ob3EInBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 783E313A07;
 Thu,  3 Feb 2022 17:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6By8G1kL/GEJOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Feb 2022 17:05:29 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  3 Feb 2022 18:05:22 +0100
Message-Id: <20220203170522.22051-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203170522.22051-1-pvorel@suse.cz>
References: <20220203170522.22051-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] sctputil.h: TCONF on EAFNOSUPPORT
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
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Neil Horman <nhorman@tuxdriver.com>, Vlad Yasevich <vyasevich@gmail.com>,
 linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

That's returned on systems without IPv6 support
(e.g. boot with ipv6.disable=1).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 utils/sctp/testlib/sctputil.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
index 1e21760bec..c4bedb47cf 100644
--- a/utils/sctp/testlib/sctputil.h
+++ b/utils/sctp/testlib/sctputil.h
@@ -133,9 +133,14 @@ extern int TST_CNT;
 static inline int test_socket(int domain, int type, int protocol)
 {
 	int sk = socket(domain, type, protocol);
+	int res = TBROK;
 
-	if (sk == -1)
-		tst_brkm(TBROK, tst_exit, "socket: %s", strerror(errno));
+	if (sk == -1) {
+		if (errno == EAFNOSUPPORT)
+			res = TCONF;
+
+		tst_brkm(res, tst_exit, "socket: %s", strerror(errno));
+	}
 
 	return sk;
 }
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
