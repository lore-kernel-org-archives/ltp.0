Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1545C4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 12:33:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DC9F3CE4CE
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 13:33:08 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF1E03CC27C
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 13:31:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6FB94601290
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 13:31:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8756D1F894;
 Tue, 14 Nov 2023 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1699965101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lSIxzKHbX9ltYiGCcOOwWOC1x156ZNZtpxMbn9wgKJA=;
 b=Ce0Pc8HMUBtz6eqn7UA2XQNJLfcpWpQH3p1gfmHUPShlDtgAo4fqu7sxMKcbePa8gLP/yq
 a0Cw8k/iR2khpFiJoiegE6sUCY8vCCzG5IH0JVhmV2Ey64ImT2bG9ePZE6oUdTOF1B6tDn
 OTYC74mBOtIEgCUgM9Utpo9X2tsmuV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1699965101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=lSIxzKHbX9ltYiGCcOOwWOC1x156ZNZtpxMbn9wgKJA=;
 b=dcZWBiwrjKfSlsHm6RF60AoQbP8i9zmrIHUDLBzaBGB+spK/Z8N6mFchxCbT5rr2Mzy8bm
 hwEqFu41bezjO2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 753BF13416;
 Tue, 14 Nov 2023 12:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oEWjG61oU2UibAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 14 Nov 2023 12:31:41 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Petr Vorel <pvorel@suse.cz>,
	ltp@lists.linux.it
Date: Tue, 14 Nov 2023 13:31:21 +0100
Message-ID: <20231114123140.1144-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.06 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.96)[99.84%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/5] Netlink helper functions refactoring + CVE
 2023-31248
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
specific to the NETLINK_ROUTE protocol so they keep the old prefix. The fourth
patch adds new attribute handling functions for generic struct nlattr.

The third patch replaces old netlink send/receive helper functions
with the context-based helpers in crypto test code.

Finally, add test for CVE 2023-31248 which was promised in v1.

Martin Doucha (5):
  tst_rtnetlink: Refactor helper function for generic use
  tst_netlink_destroy_context(): Allow safely passing NULL context
  crypto: Replace old netlink helper functions with netlink contexts
  tst_netlink: Add helper functions for handling generic attributes
  Add test for CVE 2023-31248

 doc/C-Test-Network-API.asciidoc         | 159 +++++++++---------
 include/tst_crypto.h                    |  69 +-------
 include/tst_netdevice.h                 |   8 +-
 include/tst_netlink.h                   | 195 +++++++++++++---------
 include/tst_rtnetlink.h                 | 108 ------------
 lib/tst_crypto.c                        |  90 ++--------
 lib/tst_netdevice.c                     | 115 ++++++-------
 lib/{tst_rtnetlink.c => tst_netlink.c}  | 170 ++++++++++++++-----
 testcases/cve/tcindex01.c               |  16 +-
 testcases/kernel/crypto/crypto_user01.c |  58 +++----
 testcases/kernel/crypto/crypto_user02.c |  17 +-
 testcases/kernel/crypto/pcrypt_aead01.c |  10 +-
 testcases/network/iptables/Makefile     |   2 +-
 testcases/network/iptables/nft02.c      | 211 ++++++++++++++++++++++++
 14 files changed, 667 insertions(+), 561 deletions(-)
 delete mode 100644 include/tst_rtnetlink.h
 rename lib/{tst_rtnetlink.c => tst_netlink.c} (63%)
 create mode 100644 testcases/network/iptables/nft02.c

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
