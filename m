Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E22ECAAA1
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 09:26:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D9E73CA821
	for <ltp@archiver.kernel.org>; Tue,  6 Sep 2022 11:26:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66EB33C285E
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:26:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 50B451A00E1A
 for <ltp@lists.linux.it>; Tue,  6 Sep 2022 11:26:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AA4A33B8A;
 Tue,  6 Sep 2022 09:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662456380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fWWG+sF3qN8pghQuQc/pO95cf6GxZSSH+gxxk9D43UA=;
 b=m8nUnuqdtninODes6SGH1zwOIYwhTyKs9ynJ7gWPDplfg5yvearh4kpJx0Egj+MrB9cn2V
 rqrgWEgYGe2fBFLBsg3T3nbsLVNjzAIsiSvFBklxK/ID0SYE0OC6tgx7KRaH22QNYriyXs
 u4O9QrllEfImsBMR1EjGJlaXXwr4QNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662456380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fWWG+sF3qN8pghQuQc/pO95cf6GxZSSH+gxxk9D43UA=;
 b=SPTMO5MApD9F9iEvQkS+yyvG+05L6EXdeGZMEJ1XiJ/epN9w0hJfXpOC8sauRdylQvOkNL
 d9QkAc7PkEj6GOAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE2E113A93;
 Tue,  6 Sep 2022 09:26:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wsRnMzsSF2NTawAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 06 Sep 2022 09:26:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  6 Sep 2022 11:26:12 +0200
Message-Id: <20220906092615.15116-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] fanotify{14,20}: cleanup
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
Cc: Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

just an example how to further cleanup fanotify tests by using test macros
from include/tst_test_macros.h. This can wait till Amir's FAN_MARK_IGNORE
patchset [1] is merged (unless there is going to be v2).

fanotify20 is an example what I'd address in the code, fanotify14 just
uses newly added TST_EXP_FD_ERRNO() (more cleanup here and actually in
other tests could be done).

I also admit code in include/tst_test_macros.h is a bit hard to read due
being macro. We should probably add some documentation to it.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220905154239.2652169-1-amir73il@gmail.com/

Petr Vorel (3):
  tst_test_macros: Add TST_EXP_FD_ERRNO
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
