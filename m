Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C663C43334
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 11:03:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F7203C9FFC
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 13:03:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35293C004D
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 13:03:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6869E140044A
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 13:03:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 398EE1F975
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657191802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=D5Ebo/uirYsmehT6+aDeNxIB/5a2RlmQDS3XQp4745A=;
 b=aslOd9a3X+2wXktiWu2eIgNMrWr6H46w50VIZ/bOiBwcN9+W5+Yga9bHPC0YNmkafTz5jV
 smE2FjUCN9YTuqitvVYKYHnan0Zl/c0ZfSg6s5WEls31raMwAhX4d9ZJx5SFZpJB2B4omE
 XJD0vAYkdtAt0To4PM+HUNwvyf9T0Kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657191802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=D5Ebo/uirYsmehT6+aDeNxIB/5a2RlmQDS3XQp4745A=;
 b=JdqIXcWgqDTYt24tmnnz/FMIZg7uEL5ZIYfO9CAqLLfNDH8LmGMnTSJih9Ek6FHpVc41rt
 z1XJgCrUP4SlGeDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC51813A33
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 11:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I3g+G3m9xmI9RwAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Thu, 07 Jul 2022 11:03:21 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Thu,  7 Jul 2022 16:33:10 +0530
Message-Id: <20220707110319.24665-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/9] Simplify and convert some of rename tests to
 new LTP API
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

Rewriting some of rename tests using new LPT API and removing
rename02.c file as same testcase is covered in rename01.c.

Avinesh Kumar (9):
  Rewrite rename01.c using new LTP API
  Remove rename02.c
  Rewrite rename03.c using new LTP API
  Rewrite rename04.c using new LTP API
  Rewrite rename05.c using new LTP API
  Rewrite rename06.c using new LTP API
  Rewrite rename07.c using new LTP API
  Rewrite rename08.c using new LTP API
  Rewrite rename10.c using new LTP API

 runtest/syscalls                            |   1 -
 testcases/kernel/syscalls/rename/.gitignore |   1 -
 testcases/kernel/syscalls/rename/rename01.c | 259 +++++-------------
 testcases/kernel/syscalls/rename/rename02.c | 192 --------------
 testcases/kernel/syscalls/rename/rename03.c | 274 ++++----------------
 testcases/kernel/syscalls/rename/rename04.c | 201 +++-----------
 testcases/kernel/syscalls/rename/rename05.c | 189 ++------------
 testcases/kernel/syscalls/rename/rename06.c | 182 ++-----------
 testcases/kernel/syscalls/rename/rename07.c | 166 ++----------
 testcases/kernel/syscalls/rename/rename08.c | 200 ++------------
 testcases/kernel/syscalls/rename/rename10.c | 182 ++-----------
 11 files changed, 264 insertions(+), 1583 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rename/rename02.c

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
