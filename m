Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1376C43334
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 15:34:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EDA23CA35E
	for <ltp@archiver.kernel.org>; Tue, 12 Jul 2022 17:34:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B12C3C97FD
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 759B2600836
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 17:34:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6653F1F747
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1657640060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GZpl5em2ZrP+Es2AUl+jYdhG/kwe44AasCDXA1uFgLQ=;
 b=VWCa38jjymU6qNqXb8vGPCWyX4OnKbq4Omrp97XvIbADsrtJNNde9dKFLXtJWFbnyHUPt7
 oNFZ3Nr2O5gGsnELL3wjTiDHT2db0aA8n29xXrZKug3nHQYhr8JQK7qxFIXNWatWkblf0I
 /Ayn6C4ZafTFgkRdqKIamrVrkyGi5Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1657640060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GZpl5em2ZrP+Es2AUl+jYdhG/kwe44AasCDXA1uFgLQ=;
 b=5PIo/mStvA8spe81aXW7nSX7GIyFjULZpY4qQ5Ig9mw0CePQ7SWbstrlGQ0IsBKpLQj0HN
 WuYfpfYIJqyLdVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D820F13A94
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zoWdJXuUzWIcfAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Tue, 12 Jul 2022 15:34:19 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue, 12 Jul 2022 21:04:08 +0530
Message-Id: <20220712153417.14551-1-akumar@suse.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/9] Simplify and convert some of rename tests to
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

Rewriting some of rename tests using new LPT API, enabling for all
filesystems, and removing rename02.c as same testcase is covered in rename01.c

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
 testcases/kernel/syscalls/rename/rename01.c | 267 +++++--------------
 testcases/kernel/syscalls/rename/rename02.c | 192 --------------
 testcases/kernel/syscalls/rename/rename03.c | 279 +++++---------------
 testcases/kernel/syscalls/rename/rename04.c | 204 +++-----------
 testcases/kernel/syscalls/rename/rename05.c | 193 ++------------
 testcases/kernel/syscalls/rename/rename06.c | 187 ++-----------
 testcases/kernel/syscalls/rename/rename07.c | 171 +++---------
 testcases/kernel/syscalls/rename/rename08.c | 205 ++------------
 testcases/kernel/syscalls/rename/rename10.c | 187 ++-----------
 11 files changed, 305 insertions(+), 1582 deletions(-)
 delete mode 100644 testcases/kernel/syscalls/rename/rename02.c

-- 
2.36.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
