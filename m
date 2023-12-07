Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD298C10DC3
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 19:40:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0E213CF9D8
	for <ltp@archiver.kernel.org>; Thu,  7 Dec 2023 20:40:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CC7D3CBBA7
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 20:40:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A413605643
 for <ltp@lists.linux.it>; Thu,  7 Dec 2023 20:40:35 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 267CE1F750;
 Thu,  7 Dec 2023 19:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701978035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NJNd7NoZJyzTww1mqoSz00tSROp7biBBjkoSRXyiXnw=;
 b=cZN+MycVqAxk8FfOMw3qAtRlNhhKuPGHYEUFXu2oMDDRGUIeR5uqkFMop3dTHIrisX/bKd
 mgxfuNRvjJSLIE31MgHekdMF+y2DkN5+altI4iu8nrTtKkajM70WwY+73AXvzoHamhVyn1
 1mJB0xmudkwnu8rLZfB6mJ9mPAxFQJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701978035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NJNd7NoZJyzTww1mqoSz00tSROp7biBBjkoSRXyiXnw=;
 b=m4QvHhFYO4NRoJdJl/MHph0YMhOXJJFjEuQtxHhehIMRqA/d6aHKxXoEyL4bMwWyB7mP8H
 pcIS2yvhaus37EBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701978035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NJNd7NoZJyzTww1mqoSz00tSROp7biBBjkoSRXyiXnw=;
 b=cZN+MycVqAxk8FfOMw3qAtRlNhhKuPGHYEUFXu2oMDDRGUIeR5uqkFMop3dTHIrisX/bKd
 mgxfuNRvjJSLIE31MgHekdMF+y2DkN5+altI4iu8nrTtKkajM70WwY+73AXvzoHamhVyn1
 1mJB0xmudkwnu8rLZfB6mJ9mPAxFQJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701978035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NJNd7NoZJyzTww1mqoSz00tSROp7biBBjkoSRXyiXnw=;
 b=m4QvHhFYO4NRoJdJl/MHph0YMhOXJJFjEuQtxHhehIMRqA/d6aHKxXoEyL4bMwWyB7mP8H
 pcIS2yvhaus37EBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 760BF13907;
 Thu,  7 Dec 2023 19:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id xfK2GLIfcmVyBQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Dec 2023 19:40:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  7 Dec 2023 20:40:08 +0100
Message-ID: <20231207194011.273027-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [4.84 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[14]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[suse.cz,redhat.com,suse.com,fujitsu.com,linux.dev,vger.kernel.org,gmail.com];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.06)[61.54%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] Add support bcachefs filesystem
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
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

@Amir @Jan, could you please have look on fanotify failures on Bcachefs?
fanotify13.c, fanotify15.c and fanotify16.c produce many errors.

To test, just apply this patchset and then run with LTP_SINGLE_FS_TYPE:

# LTP_SINGLE_FS_TYPE=bcachefs ./fanotify15

changes v1->v2:
Two new commits:
* lib: Add Bcachefs magic
* statx04: Skip STATX_ATTR_COMPRESSED on Bcachefs

Petr Vorel (3):
  lib: Add Bcachefs magic
  lib: Add support bcachefs filesystem to .all_filesystems
  statx04: Skip STATX_ATTR_COMPRESSED on Bcachefs

 include/tst_fs.h                          | 3 +++
 lib/tst_fs_type.c                         | 2 ++
 lib/tst_supported_fs_types.c              | 2 ++
 testcases/kernel/syscalls/statx/statx04.c | 5 +++--
 4 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
