Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32690C47071
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 16:47:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ACBF3CE3DA
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 17:47:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A6A23CC1C9
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 17:47:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B1AF46181DF
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 17:47:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 872E322933
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700153245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ERS1EyR/1nLJaF23kr3ZqePN9zXvjhRQrl4Bnp9WPzk=;
 b=XZ2YoqGhSf8FV0KfoA6YdY9yl97XEpgTfdSuUait5rxU7no9W9uExH9SAp9s0Ll9syL+RW
 dWd+csy0fHAr52Bppu2sNLvk/Aub29w/g12FPgBxD+cNV82fkHwXfgmWrX08asB6nd/v2O
 iMytx0HdvrUX/774Nf44EreawStfgzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700153245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ERS1EyR/1nLJaF23kr3ZqePN9zXvjhRQrl4Bnp9WPzk=;
 b=HMv1W0/scR4sx+og+I9U+/6TJIrpLPkKldWnOpMdvkQFsUbcq3+jtCQ84xu0bi/GyQ1vhY
 i4iEhjtyItAO3xBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 727261377E
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RcnxGp1HVmVtAwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Nov 2023 17:46:53 +0100
Message-ID: <20231116164723.4012-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.53 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.985]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.17)[69.84%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] Test for CVE 2023-31248
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

Add test for CVE 2023-31248. Support for older kernels requires some
changes in tst_netlink_check_acks() and a new LAPI header.

Changes tested on kernels 4.4, 4.12 and 5.14.

Martin Doucha (4):
  tst_netlink: Add helper functions for handling generic attributes
  tst_netlink_check_acks(): Stop on first error regardless of ACK
    request
  Add lapi/nf_tables.h
  Add test for CVE 2023-31248

 configure.ac                          |   1 +
 include/lapi/nf_tables.h              |  19 +++
 include/tst_netdevice.h               |   6 +-
 include/tst_netlink.h                 |  38 ++++-
 lib/tst_netdevice.c                   |  20 +--
 lib/tst_netlink.c                     |  97 +++++++++++-
 runtest/cve                           |   1 +
 testcases/cve/tcindex01.c             |  12 +-
 testcases/network/iptables/.gitignore |   1 +
 testcases/network/iptables/Makefile   |   2 +-
 testcases/network/iptables/nft02.c    | 213 ++++++++++++++++++++++++++
 11 files changed, 375 insertions(+), 35 deletions(-)
 create mode 100644 include/lapi/nf_tables.h
 create mode 100644 testcases/network/iptables/.gitignore
 create mode 100644 testcases/network/iptables/nft02.c

-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
