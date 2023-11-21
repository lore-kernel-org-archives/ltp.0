Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7B1C61D90
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 15:43:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F7273CC27A
	for <ltp@archiver.kernel.org>; Tue, 21 Nov 2023 16:43:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF9553CB329
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 16:42:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2EDF66027B7
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 16:42:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D0BE1F8BF
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700581355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TBqppWnivRvqMnKn7NZYhwdYhDSc89HXa1yS5lLFP0w=;
 b=ktpwn8rCWLHjClV6y/m8rElyxMg+xVtMEKg6tdhXdi8qEXncLCwYQo2xdxvUeHV4MAmz+v
 hprbaC3YbBUJCEFMKMrjDNO/qJWgknbiwuvNJqCNkL2Pfz3QodJto6l2cZ8o/EggR4uZlh
 ZZHs3NWoVnfgPAKUkX7OJHhF6IBUA30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700581355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TBqppWnivRvqMnKn7NZYhwdYhDSc89HXa1yS5lLFP0w=;
 b=XcIUuNG+9AcWQX9xBis7FeZmKj6ie0ZyXA0OrPAX8XymGUlj9+edrTcmhoPm7Yi4V47GTp
 r88r84W1+dqj1eAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 718F1139FD
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 15:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UlusGuvPXGX+fQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 21 Nov 2023 15:42:35 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Nov 2023 16:42:22 +0100
Message-ID: <20231121154234.24668-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.75 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_ONE(0.00)[1];
 NEURAL_HAM_LONG(-1.00)[-1.000]; TO_DN_NONE(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.15)[-0.752]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[43.15%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/4] Test for CVE 2023-31248
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
 doc/C-Test-Network-API.asciidoc       |  66 +++++---
 include/lapi/nf_tables.h              |  19 +++
 include/tst_netdevice.h               |   6 +-
 include/tst_netlink.h                 |  38 ++++-
 lib/tst_netdevice.c                   |  20 +--
 lib/tst_netlink.c                     |  97 +++++++++++-
 runtest/cve                           |   1 +
 testcases/cve/tcindex01.c             |  12 +-
 testcases/network/iptables/.gitignore |   1 +
 testcases/network/iptables/Makefile   |   2 +-
 testcases/network/iptables/nft02.c    | 216 ++++++++++++++++++++++++++
 12 files changed, 423 insertions(+), 56 deletions(-)
 create mode 100644 include/lapi/nf_tables.h
 create mode 100644 testcases/network/iptables/.gitignore
 create mode 100644 testcases/network/iptables/nft02.c

-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
