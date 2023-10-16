Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E0A2CDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 12:32:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 729843CEF89
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 14:32:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36D593CD19B
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 14:32:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6F3561000EB7
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 14:32:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 74A571FE53;
 Mon, 16 Oct 2023 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697459563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RIBjXf78j/jh8+rw0wtKXE5+lD3lQxHQhfKhInHA9ss=;
 b=U5/mdbyKZSNm8yr2ff9CzlMJmZ+/Z0RtwF9z2wSzRgife5Mo1oIeDwHsDyaTF3Tdf3K1Mx
 uSeaQ0eg//h+0nQIcWOgx7tls09IESgSPa5e5VuH9Pjc/39Ibc54+XSkIp1wszzo5Tp9fA
 hy1dhhYWypRBF5KLHqp+7wihWlTAGAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697459563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RIBjXf78j/jh8+rw0wtKXE5+lD3lQxHQhfKhInHA9ss=;
 b=aZCQJV6Uh/xQNMmfLNmwx/mXCYh8ZtZA/A/G8VhACgkFbdH6IRWv5IHyHKEDsVHPTN+AOB
 NdEsfz1ECDr5rmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53764133B7;
 Mon, 16 Oct 2023 12:32:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iYB+E2stLWVDHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 16 Oct 2023 12:32:43 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 16 Oct 2023 14:33:16 +0200
Message-ID: <20231016123320.9865-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [6.91 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_SPAM(0.01)[44.38%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; BROKEN_CONTENT_TYPE(1.50)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.99)[-0.995]; NEURAL_SPAM_LONG(3.00)[1.000];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_CC(0.00)[infradead.org, gmail.com, redhat.com, kernel.org,
 zeniv.linux.org.uk, suse.cz, vger.kernel.org]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4]  Add tst_fd iterator API
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes in v2:

 - Changed the API into iterator rather than a funciton callback
 - Added a lot more fd types
 - Added splice test

Cyril Hrubis (4):
  lib: Add tst_fd iterator
  syscalls: readahead01: Make use of tst_fd
  syscalls: accept: Add tst_fd test
  syscalls: splice07: New splice tst_fd iterator test

 include/tst_fd.h                              |  61 ++++
 include/tst_test.h                            |   1 +
 lib/tst_fd.c                                  | 331 ++++++++++++++++++
 runtest/syscalls                              |   2 +
 testcases/kernel/syscalls/accept/.gitignore   |   1 +
 testcases/kernel/syscalls/accept/accept01.c   |   8 -
 testcases/kernel/syscalls/accept/accept03.c   |  47 +++
 .../kernel/syscalls/readahead/readahead01.c   |  54 +--
 testcases/kernel/syscalls/splice/.gitignore   |   1 +
 testcases/kernel/syscalls/splice/splice07.c   |  85 +++++
 10 files changed, 558 insertions(+), 33 deletions(-)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c
 create mode 100644 testcases/kernel/syscalls/splice/splice07.c

-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
