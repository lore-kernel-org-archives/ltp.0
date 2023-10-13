Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B7ACDB482
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 15:17:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83D733CE546
	for <ltp@archiver.kernel.org>; Fri, 13 Oct 2023 17:17:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DF3D3CD3E4
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 17:17:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 604C1600AF0
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 17:17:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACCE321997
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697210245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IwAW6BBF7tQZ5act1qjz08qjBpR/YGek72O1Gg5Q7As=;
 b=wKhVXdCR5ImIYvoXn0NQ5SqhneJNdwayXzH+wfXerGdTfKyfK5ratRhkfs8vc17wvGGKMW
 AtOh7Ihzeah2H8A596sTPNaEUhqnkSUm4Zhsazxj2N65zOeaCx4rVTgVg68vXJwyNKE/nV
 iKo/2sHGnukLSq9hUqMRKC4GkipytNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697210245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IwAW6BBF7tQZ5act1qjz08qjBpR/YGek72O1Gg5Q7As=;
 b=tnj3tsO/AVLZpWX0WblUEmbGJ7Rcq80XQdHChZfmNB/XNnpbIENqerzw8EDIJTVQNxhZHm
 HmCV/T9rgXP4RuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E42C138EF
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iE+PJYVfKWU3SQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 13 Oct 2023 15:17:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Oct 2023 17:17:13 +0200
Message-ID: <20231013151724.23057-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.08 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; R_MISSING_CHARSET(2.50)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.98)[86.95%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Netlink helper functions refactoring
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

Let's refactor the rtnetlink helper functions for generic use where possible.
The Netlink context structure can be used for other Netlink protocols like
NETLINK_CRYPTO or NETLINK_NETFILTER. One of the exceptions is
the NETLINK_KOBJECT_UEVENT protocol which returns raw data without the usual
headers.

The first patch replaces the tst_rtnl_* and RTNL_* prefix with tst_netlink_*
and NETLINK_* respectively to signify that the functions can be used
for generic netlink communication. The attribute handling functions are
specific to the NETLINK_ROUTE protocol so they keep the old prefix.

The last patch then replaces old netlink send/receive helper functions
with the context-based helpers in crypto test code.

Coming soon is a new netfilter CVE test which will also use the refactored
code.

Martin Doucha (3):
  tst_rtnetlink: Refactor helper function for generic use
  tst_netlink_destroy_context(): Allow safely passing NULL context
  crypto: Replace old netlink helper functions with netlink contexts

 doc/network-c-api.txt                   | 159 +++++++++++-----------
 include/tst_crypto.h                    |  67 +---------
 include/tst_netdevice.h                 |   2 +-
 include/tst_netlink.h                   | 171 ++++++++++++++----------
 include/tst_rtnetlink.h                 | 108 ---------------
 lib/tst_crypto.c                        |  90 +++----------
 lib/tst_netdevice.c                     |  95 ++++++-------
 lib/{tst_rtnetlink.c => tst_netlink.c}  |  88 ++++++------
 testcases/cve/tcindex01.c               |   4 +-
 testcases/kernel/crypto/crypto_user01.c |  58 +++-----
 testcases/kernel/crypto/crypto_user02.c |  17 +--
 testcases/kernel/crypto/pcrypt_aead01.c |  10 +-
 12 files changed, 331 insertions(+), 538 deletions(-)
 delete mode 100644 include/tst_rtnetlink.h
 rename lib/{tst_rtnetlink.c => tst_netlink.c} (77%)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
