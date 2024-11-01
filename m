Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9E5E6F06C
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 16:41:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B6273CDA15
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 17:41:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAD893CD9D4
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 17:41:24 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 73C21141A27D
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 17:41:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F22A1FEFC;
 Fri,  1 Nov 2024 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730479280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QZfiwBqlWOy72UgAv03l/1aOer+zIpbSuuA0jrOaecU=;
 b=eDTcHRqJHJ+yVO0ZfcbIBMZK5OPJeVdQfaY4Q4lYixjmGzdD8qP0DjorMfPdUhh9FuQoqA
 hRFnKBzx8Oqv4PuPGabxYWHadqmYQzqw+9Un9uXYYoSBdBFWq7z6lyj8/PVCr5D+RKSmxO
 bUue5r004FB6CS9PtPE0GFo0Yrw+dUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730479280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QZfiwBqlWOy72UgAv03l/1aOer+zIpbSuuA0jrOaecU=;
 b=Xg/EHNJHA9mh9gEattxEIK8WrN3PNzRu9+YK16YY3QtAv3/AWPe3eqmH+qFqd4g9KtFMmN
 sY1ikVtMF9XOPeDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eDTcHRqJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Xg/EHNJH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730479280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QZfiwBqlWOy72UgAv03l/1aOer+zIpbSuuA0jrOaecU=;
 b=eDTcHRqJHJ+yVO0ZfcbIBMZK5OPJeVdQfaY4Q4lYixjmGzdD8qP0DjorMfPdUhh9FuQoqA
 hRFnKBzx8Oqv4PuPGabxYWHadqmYQzqw+9Un9uXYYoSBdBFWq7z6lyj8/PVCr5D+RKSmxO
 bUue5r004FB6CS9PtPE0GFo0Yrw+dUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730479280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=QZfiwBqlWOy72UgAv03l/1aOer+zIpbSuuA0jrOaecU=;
 b=Xg/EHNJHA9mh9gEattxEIK8WrN3PNzRu9+YK16YY3QtAv3/AWPe3eqmH+qFqd4g9KtFMmN
 sY1ikVtMF9XOPeDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B968F13722;
 Fri,  1 Nov 2024 16:41:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q2y6K68EJWdkKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 16:41:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Nov 2024 17:40:46 +0100
Message-ID: <20241101164046.1294654-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0F22A1FEFC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] hugemmap34: Use lapi/mmap.h to fix build on old
 distros
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
Cc: Samir Mulani <samir@linux.vnet.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Required on very old distros we still support:
* Ubuntu Bionic
* openSUSE Leap 42.2

Fixes: 21fdea4799 ("Migrating the libhugetlbfs/testcases/stack_grow_into_huge.c test")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Trivial patch I'll merge tonight after CI finishes:
https://github.com/pevik/ltp/actions/runs/11632875155

 testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
index 3f04376b65..a7a88fbb2d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -20,6 +20,7 @@
  * huge page-only segment -- resulting in bugs.
  */
 
+#include "lapi/mmap.h"
 #include "hugetlb.h"
 #include <errno.h>
 
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
