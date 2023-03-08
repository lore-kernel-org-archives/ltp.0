Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA60CC678D5
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 09:32:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 670AC3CD94C
	for <ltp@archiver.kernel.org>; Wed,  8 Mar 2023 10:32:35 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE2CA3C2A67
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 10:32:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7288F1400BDF
 for <ltp@lists.linux.it>; Wed,  8 Mar 2023 10:32:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 49B1321A01;
 Wed,  8 Mar 2023 09:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678267944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XFlBVRlEjg4meIp+BVsdBIRmrfi7gNsK9rCV1PrrBqo=;
 b=hGGVwm1JKvw0M4am7/wkECc/DQp0DW7C3MnAhsMf4SzLLxCTUWdIydR/4ZgiRPsEPtZdLZ
 URS135MqZzdSH4MyKJnSNlBlTDXMn3uDKjjbU1svhJ5kkGlFyVQId8gq2Gr5iHqDkE4XZ5
 BvnUcDmlKk53YufrYj0rtcKt9BI6qOI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678267944;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=XFlBVRlEjg4meIp+BVsdBIRmrfi7gNsK9rCV1PrrBqo=;
 b=njLpposRFJVHFDGOgMlnqIKXWHhjNYBF2E3pW8SH9+6okqdPrclxolKrMJ+wpR8PLrYZDH
 gaeaCdLRaSKP8JCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDDE71391B;
 Wed,  8 Mar 2023 09:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GglDKydWCGTFPAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Mar 2023 09:32:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  8 Mar 2023 10:32:17 +0100
Message-Id: <20230308093219.27090-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] insmod01.sh: Skip test on enabled lockdown
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

Petr Vorel (2):
  lib: shell: Add tst_lockdown_enabled.c
  insmod01.sh: Skip test on enabled lockdown

 doc/test-writing-guidelines.txt       |  2 +-
 testcases/commands/insmod/insmod01.sh |  2 ++
 testcases/lib/.gitignore              |  1 +
 testcases/lib/Makefile                |  2 +-
 testcases/lib/tst_lockdown_enabled.c  | 12 ++++++++++++
 testcases/lib/tst_test.sh             |  6 +++++-
 6 files changed, 22 insertions(+), 3 deletions(-)
 create mode 100644 testcases/lib/tst_lockdown_enabled.c

-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
