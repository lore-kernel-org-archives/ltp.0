Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59E4C55179
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 11:17:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 421CB3E7191
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 13:17:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2974E3E53BA
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 13:16:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF0F31A008A9
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 13:16:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B89817F07D;
 Mon,  3 Aug 2026 11:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785755761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t9eOzmavFvaEiamj8YKDgeDSA7RDvrCNBh9COyvXhWA=;
 b=UeiixRoR+eip8Yq5uPKXPLuhVsT/NUxd7RhqicJykdAy8QIgU20fm6xN7KU1Ou1zEn/yPo
 oR03pD0ex3CkZYQVA+1/jsLcl86FMaq0CAhVTe6dNHdUcRZLoIMHRxUo+xK4q72oiRmGIC
 2CXyoEXlUIL5G6mzs/SHX4KFN0ssNp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785755761;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t9eOzmavFvaEiamj8YKDgeDSA7RDvrCNBh9COyvXhWA=;
 b=FiYXrdTiwVRY1V6IJ1rkkOemrrr4/eZ/AB1cjOO7kYXq+zE0FRo+rSe4bsggJJ8apRet5G
 Zx3QM+c+ykmffCCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785755757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t9eOzmavFvaEiamj8YKDgeDSA7RDvrCNBh9COyvXhWA=;
 b=B/4neg1zgyVNpWa64AYaG/mbm/65HnzAFMft5V+EjGnabEEJypNbKfUxZw/GCPAwWeu5uj
 JYJfMpatlt6qGQr6p8FWzcfKPzcMe7XSH2emwSUQ4Mss2yBioPPzSQXxuXig5CYRUyFgjp
 YOHsAX1KCLdGYjTMGuV+1OPhwr+tj0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785755757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=t9eOzmavFvaEiamj8YKDgeDSA7RDvrCNBh9COyvXhWA=;
 b=W4Cr0Akql/26GbwU+vye6VpYGt1JWJ+ZeJRLm2EUNxoRDe+rKHd84UL6aD820NoRsvFUus
 /Y5As8Trp/8t4hBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16142779A1;
 Mon,  3 Aug 2026 11:15:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id B2qgAW14cGo4BQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Aug 2026 11:15:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: linux-kernel@vger.kernel.org
Date: Mon,  3 Aug 2026 13:15:53 +0200
Message-ID: <20260803111553.229452-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[13]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[fujitsu.com:email,linux.it:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] MAINTAINERS: Add LTP patchwork instance
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
Cc: Tim Bird <tim.bird@sony.com>, Andrew Morton <akpm@linux-foundation.org>,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP project recently switched to patchwork.kernel.org,
document it.

Link: https://github.com/linux-test-project/ltp/commit/3590f66120d1c875bef5d573c66c4c0d340c1612
Link: https://lore.kernel.org/ltp/20260731054548.133241-1-pvorel@suse.cz/
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe67f7bfa44c..69618d65c689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15521,6 +15521,7 @@ M:	Xiao Yang <yangx.jy@fujitsu.com>
 L:	ltp@lists.linux.it (subscribers-only)
 S:	Maintained
 W:	https://linux-test-project.readthedocs.io/
+Q:	https://patchwork.kernel.org/project/ltp/list/
 T:	git https://github.com/linux-test-project/ltp.git
 
 LTR390 AMBIENT/UV LIGHT SENSOR DRIVER
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
