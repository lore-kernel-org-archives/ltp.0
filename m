Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ED6CDB46B
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 08:53:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EE643E53C6
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 10:53:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA8EC3E53A3
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 10:53:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6EBEE10006CF
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 10:53:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2F3A758D2;
 Mon, 22 Jun 2026 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782118399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+2WN8elIs9bQ1LWENXMRF0M43qPNj3p6DURqOFNkpko=;
 b=xpaOGJsDMJnfM6KlvbFs1sjiF1d7MmlQmZ9T6IULOIh1DW2Dn0o8y7za+qPxBa4oHG4GZU
 20Hd5FiODuMP6WwTnUbSuq5t2ghp8f0qejl8t064HavYtRjrq4AawUYILiO+2HNmT61X/x
 e8JIvwpBrLZJPjHQGTzpu630UngFSos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782118399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+2WN8elIs9bQ1LWENXMRF0M43qPNj3p6DURqOFNkpko=;
 b=XtiS0FFerQbZhP1Vqj98GNICHOj0WwvO9ATU5J9TeOrpWu3V+6Ddf24OcgMwH5HtonnskN
 8ztJ7tpATtC5jPDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782118399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+2WN8elIs9bQ1LWENXMRF0M43qPNj3p6DURqOFNkpko=;
 b=xpaOGJsDMJnfM6KlvbFs1sjiF1d7MmlQmZ9T6IULOIh1DW2Dn0o8y7za+qPxBa4oHG4GZU
 20Hd5FiODuMP6WwTnUbSuq5t2ghp8f0qejl8t064HavYtRjrq4AawUYILiO+2HNmT61X/x
 e8JIvwpBrLZJPjHQGTzpu630UngFSos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782118399;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+2WN8elIs9bQ1LWENXMRF0M43qPNj3p6DURqOFNkpko=;
 b=XtiS0FFerQbZhP1Vqj98GNICHOj0WwvO9ATU5J9TeOrpWu3V+6Ddf24OcgMwH5HtonnskN
 8ztJ7tpATtC5jPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94B2F779A8;
 Mon, 22 Jun 2026 08:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tlmFHv/3OGoeFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jun 2026 08:53:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jun 2026 10:53:16 +0200
Message-Id: <20260622-metadata_groups-v3-0-45651d685c3c@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPz3OGoC/3WNywqDMBBFf0WybkoyER9d9T9KKVMz1Sw0ktHQI
 v57oyuhdHkunHMXwRQcsbhkiwgUHTs/JDCnTDQdDi1JZxMLUFCoQoPsaUKLEz7a4OeRpbWQG0W
 ga6VFssZAL/fei7d74s7x5MNnP4h6W/+3opZK2hIhxxKbEqsrz0znxvdiS0U46tWvDkkv8Al1V
 RsAYw76uq5fW/z15OwAAAA=
X-Change-ID: 20260612-metadata_groups-dd2430e21901
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782118399; l=1715;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=aIqrM7Dl6O1ZFGAeO6+GEzopnXqwT58XGnZ5ZlkJZVU=;
 b=40tHkl4u5U9k7ptkjHVwRVlUfEqFk1WI1kl3/LpBxPZJuDlZ1DTSAaH6jQgGFCNAP6u5wEkG1
 FqfJsEcgT4EAAI4wbCN01rsHqoNQztT+rfNgKZMfTvQXxvku+J0Int/
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Support metadata groups
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v3:
- match @groups not groups
- drop const qualifier in eat_asterisk_space()
- WARN() when empty groups is provided
- error on strdup() failure
- we always add 1 group, so always add items to the hash
- Link to v2: https://lore.kernel.org/r/20260618-metadata_groups-v2-0-6ab298932233@suse.com

Changes in v2:
- switch from @group to @groups
- use Cyril snippet to folter out groups from description
- optimize code
- Link to v1: https://lore.kernel.org/r/20260612-metadata_groups-v1-0-d7a24a7ac7a8@suse.com

---
Andrea Cervesato (2):
      metadata: add tests grouping support
      doc: conf.py: Show groups in test catalog

 doc/conf.py                           |  10 +++
 metadata/metaparse.c                  | 163 +++++++++++++++++++++++++++-------
 metadata/tests/array_size01.c.json    |   2 +
 metadata/tests/array_size02.c.json    |   2 +
 metadata/tests/array_size03.c.json    |   2 +
 metadata/tests/array_size04.c.json    |   2 +
 metadata/tests/empty_struct.c.json    |   2 +
 metadata/tests/expand_flags.c.json    |   2 +
 metadata/tests/groups.c               |  11 +++
 metadata/tests/groups.c.json          |  12 +++
 metadata/tests/include.c.json         |   2 +
 metadata/tests/macro.c.json           |   2 +
 metadata/tests/macro_str.c.json       |   2 +
 metadata/tests/multiline_macro.c.json |   2 +
 metadata/tests/tags.c.json            |   2 +
 15 files changed, 187 insertions(+), 31 deletions(-)
---
base-commit: bc9cfca5c7b6599e501d580bb42b9538390fd9a6
change-id: 20260612-metadata_groups-dd2430e21901

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
