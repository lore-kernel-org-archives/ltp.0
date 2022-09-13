Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907C2C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 06:21:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF7DD3CAB0D
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 08:21:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C11563CAAE1
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:21:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46B0A601145
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 08:21:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C12B22437;
 Tue, 13 Sep 2022 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663050067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4wb+HMS4N6OGnRzY8GY3CAX+pB6wUUyykhyxOeLgeTE=;
 b=DpkBqEFi1gbJSsOdnAcGFgfBcx0sx5K6zPkcPNURvta0YQrtSbBm6U5H0FHttsXP0iziDu
 qyhsCgIqAfisn5xFbxioEBPAM6vwRrRcKmMdA0hnBm/hgzxKGg4+bJ7Ptl9XinjsrQesVR
 3oEjHxNcMPfuWAj3xC/0IKbWMXri6NU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663050067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4wb+HMS4N6OGnRzY8GY3CAX+pB6wUUyykhyxOeLgeTE=;
 b=dzLuMAM1ROPlCsmtcAr4TDXQu62gU5KH0CjguBkBs9HxXaPEeRvj35jc1XNGO9uqTZBOPz
 ZQCKYmPpubAr6MCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6E9C139B3;
 Tue, 13 Sep 2022 06:21:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b9oTM1IhIGNKZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 06:21:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 13 Sep 2022 08:21:00 +0200
Message-Id: <20220913062103.3910-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3]	fanotify{14,20}: cleanup
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

Hi,

changes v1->v2:
* Rename macro (Cyril)
s/TST_EXP_FD_ERRNO/TST_EXP_FD_OR_FAIL/

Kind regards,
Petr

Petr Vorel (3):
  tst_test_macros: Add TST_EXP_FD_OR_FAIL() macro
  fanotify20: Simplify code
  fanotify14: Use TST_EXP_FD_ERRNO()

 include/tst_test_macros.h                     |  10 ++
 .../kernel/syscalls/fanotify/fanotify14.c     | 118 +++++-------------
 .../kernel/syscalls/fanotify/fanotify20.c     |  81 +++---------
 3 files changed, 62 insertions(+), 147 deletions(-)

-- 
2.37.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
