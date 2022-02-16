Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5DFC433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 12:25:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D1723CA08D
	for <ltp@archiver.kernel.org>; Wed, 16 Feb 2022 13:25:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB7A73C9E16
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:24:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5E89714011B6
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 13:24:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A70A5212C1
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645014298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GCnw1QcPx9GYpFSFKhCs8Qj429AR5OeIZnfqfe7PDjg=;
 b=e1V4BzZoWqD5+TiLoDOaBsTYIxHao69jkDAg9f2iQtEHpUOhtcCh3yUhZwAnrvDKk/61FY
 e5/LZ9fQjwPpq7tkbynBJcMiYCj6iFQQlE1ttSOhvgVdmKSaQuPpTLt0SGN/8VoY8/nKyH
 btAVII/puEH0hhtnis0Jnely36ONYVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645014298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GCnw1QcPx9GYpFSFKhCs8Qj429AR5OeIZnfqfe7PDjg=;
 b=I9Si68YUJVlJ7ywo5M61g70K38kG0QT/JOke6Zf8kBHK8mfomCQxanWlb9/VrVhhScWk2Q
 3gQ1fBD9zaiIrRBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87CDE13AF3
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 12:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p0IsHxrtDGIHTQAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 16 Feb 2022 12:24:58 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Feb 2022 13:24:47 +0100
Message-Id: <20220216122447.9790-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [COMMITTED] [PATCH] metadata: metaparse: Fix warn messages
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

Since we added -I option the filename is no longer argv[1] but
argv[optind].

Fixes: 36d6d745ccdc ("docparse: Implement #define and #include")
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/metaparse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index f71d8628d..2384c73c8 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -876,7 +876,7 @@ int main(int argc, char *argv[])
 			for (j = 0; implies[i].implies[j]; j++) {
 				if (data_node_hash_get(res, implies[i].implies[j]))
 					fprintf(stderr, "%s: useless tag: %s\n",
-						argv[1], implies[i].implies[j]);
+						argv[optind], implies[i].implies[j]);
 			}
 		}
 	}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
