Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B90CE7A95
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 11:04:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 548B83CE225
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 13:04:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AF2C3C998B
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:04:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C10051A00997
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 13:04:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35A0021846;
 Mon, 25 Sep 2023 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1695639868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uIa7+c35/5Qw00guIjNw6fw9Lx4y+C9zFShq4oZr93I=;
 b=miM2SMsVhx9MklbI7G8AjkUOgwkjjmuHfJm5QhvfBoXwsvBuIct4Fa5Lm505XC8yvfL9GK
 Z//Xo23vz8ZXFrrL8cJmQ/8B31DaNy3Va9Bsk0PqPspGoiDXNB6eYZzGDY4FIe/u+57IQh
 Dnkqo09ve+gSF6lO1YeS/jZ83EuyP8Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3265613580;
 Mon, 25 Sep 2023 11:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C+7LOTppEWVPOwAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 25 Sep 2023 11:04:26 +0000
To: wegao@suse.com,
	ltp@lists.linux.it
Date: Mon, 25 Sep 2023 07:04:20 -0400
Message-Id: <20230925110422.19167-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 0/2] factory
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao (2):
  seccomp01.c: Add SECCOMP_RET_USER_NOTIF check
  d

 configure.ac                                  |   1 +
 include/lapi/seccomp.h                        |   7 +
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/ptrace/ptrace05.c   | 147 ++----
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 306 +++++++-----
 testcases/kernel/syscalls/seccomp/.gitignore  |   1 +
 testcases/kernel/syscalls/seccomp/Makefile    |   8 +
 testcases/kernel/syscalls/seccomp/seccomp01.c | 456 ++++++++++++++++++
 8 files changed, 689 insertions(+), 239 deletions(-)
 create mode 100644 testcases/kernel/syscalls/seccomp/.gitignore
 create mode 100644 testcases/kernel/syscalls/seccomp/Makefile
 create mode 100644 testcases/kernel/syscalls/seccomp/seccomp01.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
