Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D89E7B604
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 12:46:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF2733CDB0D
	for <ltp@archiver.kernel.org>; Wed,  4 Oct 2023 14:46:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEC123CB78E
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:46:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EA7131A00E2D
 for <ltp@lists.linux.it>; Wed,  4 Oct 2023 14:46:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3428D1F74C;
 Wed,  4 Oct 2023 12:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696423589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BsF3UVfl/y6P+aPwJrRdOfdTj+gYUjFPOJgjlOhpAZg=;
 b=vXeHv9qGyT8I7aTXp06t/B9dAyii79ISLcyLxiLWa3y0cMUkJgx0z8mCXpYvFzJkt9LCoj
 sj5QMlmDjONJPqmJ0tnQmZ2QLU2IIPvge638t1VZtV04FIMuSE8fMV97jMXHxeDPFkzeki
 L2eL1hcERscCEnkGxlCa1Q2gTN//DNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696423589;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=BsF3UVfl/y6P+aPwJrRdOfdTj+gYUjFPOJgjlOhpAZg=;
 b=tBYCb8DjuvBtW+7I7Rn4A1wqVSvZeV/OGL+6W121Kwhgc4UB4cdOa7ncqGu9BGCARJIXlY
 4JvQcOwj8saXCDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D57513A2E;
 Wed,  4 Oct 2023 12:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7f8EBqVeHWXWPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 04 Oct 2023 12:46:29 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  4 Oct 2023 14:47:09 +0200
Message-ID: <20231004124712.3833-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Add tst_iterate_fd()
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

 - adds tst_iterate_fd() functionality
 - make use of tst_iterate_fd() in readahead01
 - add accept03 test which uses tst_iterate_fd()

This is a prototype for how the functionality to iterate over different
file descriptors should look like it converts one tests and adds
another. There is plenty of other syscalls that can use this kind of
testing, e.g. all fooat() syscalls where we can pass invalid dir_fd, the
plan is to add these if/once we agree on the API.

Cyril Hrubis (3):
  lib: Add tst_fd_iterate()
  syscalls/readahead01: Make use of tst_fd_iterate()
  syscalls: accept: Add tst_fd_iterate() test

 include/tst_fd.h                              |  39 ++++++
 include/tst_test.h                            |   1 +
 lib/tst_fd.c                                  | 116 ++++++++++++++++++
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/accept/.gitignore   |   1 +
 testcases/kernel/syscalls/accept/accept01.c   |   8 --
 testcases/kernel/syscalls/accept/accept03.c   |  46 +++++++
 .../kernel/syscalls/readahead/readahead01.c   |  46 +++----
 8 files changed, 224 insertions(+), 34 deletions(-)
 create mode 100644 include/tst_fd.h
 create mode 100644 lib/tst_fd.c
 create mode 100644 testcases/kernel/syscalls/accept/accept03.c

-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
