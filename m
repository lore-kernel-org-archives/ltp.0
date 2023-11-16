Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BC1C197A0
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 16:48:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 337933CE3C8
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 17:48:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C78E13CE3A1
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 17:47:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3876D1401244
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 17:47:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3BF422941
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700153245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9dx1WDkTwGeEpC44ZEPNFoAbod8MoXHKmylU/s1oEU=;
 b=hNyXRX/Mvn42oFa031xIOMamFyxRBIxk48GbTYPtFRsNjaGLDftuyJxtRK/IzXyPwi9vnL
 2c2kLx42z6FDyHc+Zz18KX2mqQhviTuNKiuHmlGqi7fduLpbEOzSbPE7gu3v6lhxgyo4eQ
 0P2DHMSR1TbopaWnPQXzlyWfgTOCB0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700153245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u9dx1WDkTwGeEpC44ZEPNFoAbod8MoXHKmylU/s1oEU=;
 b=SK17n7AT2c4iTF4zd1/ghBY7gGkhPQUYHQcH7ClIlqHUh6+ALV9/f9lOsBqWYjrxCQfIsh
 EwfYcjlLtUT7RbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DC7F13A9F
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kP+pJZ1HVmVtAwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Nov 2023 17:46:55 +0100
Message-ID: <20231116164723.4012-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231116164723.4012-1-mdoucha@suse.cz>
References: <20231116164723.4012-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[45.73%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] tst_netlink_check_acks(): Stop on first error
 regardless of ACK request
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

tst_netlink_check_acks() currently ignores errors in response
to netlink messages that did not explicitly ask for ack.
If a multimessage netlink request fails early, this will lead
to TBROK failures due to missing acks. Return the first netlink
error even if the corresponding request did not ask for ack.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v2: New patch

 lib/tst_netlink.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/tst_netlink.c b/lib/tst_netlink.c
index 7bc98af56..d61cc8b88 100644
--- a/lib/tst_netlink.c
+++ b/lib/tst_netlink.c
@@ -455,18 +455,19 @@ int tst_netlink_check_acks(const char *file, const int lineno,
 		if (!(msg->nlmsg_flags & NLM_F_ACK))
 			continue;
 
-		while (res->header && res->header->nlmsg_seq != msg->nlmsg_seq)
+		while (res->header && !(res->err && res->err->error) &&
+			res->header->nlmsg_seq != msg->nlmsg_seq)
 			res++;
 
-		if (!res->err || res->header->nlmsg_seq != msg->nlmsg_seq) {
-			tst_brk_(file, lineno, TBROK,
-				"No ACK found for Netlink message %u",
-				msg->nlmsg_seq);
+		if (res->err && res->err->error) {
+			tst_netlink_errno = -res->err->error;
 			return 0;
 		}
 
-		if (res->err->error) {
-			tst_netlink_errno = -res->err->error;
+		if (!res->header || res->header->nlmsg_seq != msg->nlmsg_seq) {
+			tst_brk_(file, lineno, TBROK,
+				"No ACK found for Netlink message %u",
+				msg->nlmsg_seq);
 			return 0;
 		}
 	}
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
