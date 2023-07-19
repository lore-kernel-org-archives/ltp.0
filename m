Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C2FEB64DA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 11:01:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC5B43CE9CA
	for <ltp@archiver.kernel.org>; Wed, 19 Jul 2023 13:01:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3671A3C98F1
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:00:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8DA0D200A0F
 for <ltp@lists.linux.it>; Wed, 19 Jul 2023 13:00:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7E0AC21B20;
 Wed, 19 Jul 2023 11:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689764455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E7osXWPx0QZgLxfmTeJsr28G2oUGLckSWzkemBMH1ow=;
 b=I5l2rrFlW6r7tNdf9dYGd4FM0CYAgL6H/DVE8uslSXL+eg0XApM70p6aBZOz5jw/zIueWt
 FPC+YjPy9OOqngjwiR3dxyQedd3FtdXDvt/aQTj9M3z3FEMLv50jXvxMHNX73HbquPLyti
 WUmBISb94NWrpIQ75Kn0Po/8dgqUw5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689764455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=E7osXWPx0QZgLxfmTeJsr28G2oUGLckSWzkemBMH1ow=;
 b=ITHwtkivDB0k9ZRZzV/y6fDtLDs4FcK8gkG3poNOTNxONRFR+za54QjOkrPL7LOdl6zUKp
 TLUK4slT15yhAcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 08CAC1361C;
 Wed, 19 Jul 2023 11:00:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aTKhAGfCt2RtUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jul 2023 11:00:55 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 19 Jul 2023 13:00:47 +0200
Message-Id: <20230719110051.1237775-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] Makefile: Add C header with generated LTP
 version
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
* proper make solution from Cyril, slightly modified (first commit)
ltp-version.h gets regenerated only when make requires to run in lib/,
but I'm ok with that.
* .gitignore cleanup (last commit)

I wonder how about shell API? Do we want to create tst_version binary in
testcases/lib/ ?

Kind regards,
Petr

Cyril Hrubis (1):
  Makefile: Add C header with generated LTP version

Petr Vorel (3):
  lib/C-API: Add option -V to print LTP version
  lib/C-API: Print LTP version at test start
  lib: Move gitignore entries to their directory

 .gitignore           | 18 ------------------
 lib/.gitignore       |  3 +++
 lib/Makefile         | 13 +++++++++++++
 lib/gen_version.sh   | 16 ++++++++++++++++
 lib/tests/.gitignore | 17 +++++++++++++++++
 lib/tst_test.c       |  8 ++++++++
 6 files changed, 57 insertions(+), 18 deletions(-)
 create mode 100644 lib/.gitignore
 create mode 100755 lib/gen_version.sh
 create mode 100644 lib/tests/.gitignore

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
