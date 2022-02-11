Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30444C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 16:04:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A5F83C9F38
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 17:04:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B2633C2690
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 17:04:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6D51214013BE
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 17:04:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE3E11F3A8;
 Fri, 11 Feb 2022 16:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1644595482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qJVUnr6tqDHm0Xzhl6dbqJ14X+LwLa21URIRNmo+EAY=;
 b=0KW2XexPVGjAvCY/NIDiwsaYnrK0IofGoOtnSx3BMNJhSWiEYxU+O7CP2bWPtR0kCWojB/
 XNYVPEpxLUQZL3OZmZBIkL6JAdaGDAxGqTeHqeGOgdlKLrCLcZX+uu8LhukUh4ojXV+Btq
 qfHX/mWjz/E5RrVY5CZViu6WGbqM8P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1644595482;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qJVUnr6tqDHm0Xzhl6dbqJ14X+LwLa21URIRNmo+EAY=;
 b=5FIQN1QO97AzzX+j+gnxBFeZ9TzGQhVZedOvpR9iW/V7dix/LaJ7iy608ORLLfYFW/KHh8
 1ys4a9sLs9awU0AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 653E413C9A;
 Fri, 11 Feb 2022 16:04:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9s2wFRqJBmINYQAAMHmgww
 (envelope-from <blezhepekov@suse.de>); Fri, 11 Feb 2022 16:04:42 +0000
From: Bogdan Lezhepekov <blezhepekov@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Feb 2022 18:04:40 +0200
Message-Id: <20220211160440.9342-1-blezhepekov@suse.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib/tst_memutils.c: Fix resource leak
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
Cc: martin.doucha@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

File descriptor was not closed properly
before return.

Signed-off-by: Bogdan Lezhepekov <blezhepekov@suse.de>
---
 lib/tst_memutils.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 4a4974761..2e6d7d5fd 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -122,7 +122,10 @@ static int write_score(const char *path, int score)
 		return 1;
 
 	if (fprintf(f, "%d", score) <= 0)
+	{
+		fclose(f);
 		return 1;
+	}
 
 	if (fclose(f))
 		return 1;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
