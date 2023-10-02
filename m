Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E693E74901
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 17:44:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8ABE3CE673
	for <ltp@archiver.kernel.org>; Mon,  2 Oct 2023 19:44:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A70AD3CDDD7
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:44:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 76EEE60095D
 for <ltp@lists.linux.it>; Mon,  2 Oct 2023 19:44:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98AC9215E6;
 Mon,  2 Oct 2023 17:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696268656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=abMXDW05J3InfrzsG4XTPw9HJBOvkdVW2A6NqzO8KMg=;
 b=Z8KSVW/LqCqPIYx0T+mK2u72tm81/EPuYbQfBSXWcAeILzVDneOnlMg5OzdhVxsRmI0yI9
 dtDi9kRsDeWTpfPaJAu7Dh3pUlBM4hQIgn+r4F/m9u24hw+KhwZWWAAZi1E6ewIhIFgq1W
 gkY4UM1gD0dGdXmz/4vU/mAQvCMtpIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696268656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=abMXDW05J3InfrzsG4XTPw9HJBOvkdVW2A6NqzO8KMg=;
 b=lGtxsUITs6J0LOUUrAUhSflwyoHB6NFAPT5MVnUom9sd5NseEQO/7tKmmBTY33l7ZXb608
 xwgCARytds8gi5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55D2813456;
 Mon,  2 Oct 2023 17:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XVOHEnABG2UcRgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 02 Oct 2023 17:44:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  2 Oct 2023 19:44:06 +0200
Message-ID: <20231002174406.1146201-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] tools/kirk: Update to fix symlink for rpm
 packaging
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

Update kirk to 61591a1 to fix failure during rpm packaging:
ERROR: Link /opt/ltp/runltp-ng ->
/home/abuild/rpmbuild/BUILDROOT/ltp-20230929.48a150bf-1573.1.x86_64/opt/ltp/kirk
points inside build root

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Tested in OBS:
https://build.opensuse.org/package/show/home:pevik:branches:benchmark:ltp:devel/ltp

Kind regards,
Petr

 tools/kirk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kirk b/tools/kirk
index 7e397fe1a..c47d3d931 160000
--- a/tools/kirk
+++ b/tools/kirk
@@ -1 +1 @@
-Subproject commit 7e397fe1a2d34a100c7dbfa452bd5d86ca1ddb77
+Subproject commit c47d3d9311b1b429f385e8d2b35da96dd4330df5
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
