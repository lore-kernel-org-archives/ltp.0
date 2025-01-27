Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352F4C02188
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 19:59:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EF043C57AF
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 20:59:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D88EE3C2830
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 20:59:29 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABBE521C560
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 20:59:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC83D210FB;
 Mon, 27 Jan 2025 19:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738007967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=D0M3FQQ+RNkvVz1kUFtBUGKhzUUJmPto6EwDVccl4fc=;
 b=ytqCkwnoA1w7YlEgeeQfuMae/fWxb441Tf1gjZ0t0nO3txBO4uh0Ai8bv/kXxRT2OPpJ2M
 XzhTSo0wM48nEsA+wtb+nFWkO6anIJehgwDmL09uNtm76ptQpTyJzDY6LzZ9PYy9ar90AO
 CiLwXrUaCYvN9RnRhSFRrpKw7NPs5aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738007967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=D0M3FQQ+RNkvVz1kUFtBUGKhzUUJmPto6EwDVccl4fc=;
 b=BwI9zj4tEBk0pG2mPOA6qtnsMAj3NoFoGrlDi7hqswNcjuyb511qP8zhDw81JV1yJA0d3M
 1xWcmhMr+91Kh2AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ytqCkwno;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BwI9zj4t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738007967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=D0M3FQQ+RNkvVz1kUFtBUGKhzUUJmPto6EwDVccl4fc=;
 b=ytqCkwnoA1w7YlEgeeQfuMae/fWxb441Tf1gjZ0t0nO3txBO4uh0Ai8bv/kXxRT2OPpJ2M
 XzhTSo0wM48nEsA+wtb+nFWkO6anIJehgwDmL09uNtm76ptQpTyJzDY6LzZ9PYy9ar90AO
 CiLwXrUaCYvN9RnRhSFRrpKw7NPs5aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738007967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=D0M3FQQ+RNkvVz1kUFtBUGKhzUUJmPto6EwDVccl4fc=;
 b=BwI9zj4tEBk0pG2mPOA6qtnsMAj3NoFoGrlDi7hqswNcjuyb511qP8zhDw81JV1yJA0d3M
 1xWcmhMr+91Kh2AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E0F7137C0;
 Mon, 27 Jan 2025 19:59:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dHAYEJ/ll2fwLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 Jan 2025 19:59:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 Jan 2025 20:59:08 +0100
Message-ID: <20250127195908.326511-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: AC83D210FB
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ver_linux: Add filesystems, remove unused items
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

Add filesystems:
* bcachefs
* btrfs
* ntfs
* exfat
* vfat
* xfs

Removed items:
* pppd (not used)
* reiserfsck (dropped from mainline kernel)

Fixed mount formatting, add extra space before loaded modules.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I'm sorry for not splitting this into more commits.
I originally intend to add bcachefs, in the end add more fs and did
cleanup.

Kind regards,
Petr

 ver_linux | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/ver_linux b/ver_linux
index 4fa34f4a98..4333575d3d 100755
--- a/ver_linux
+++ b/ver_linux
@@ -72,22 +72,34 @@ ld -v 2>&1 | awk -F\) '{print $1}' | awk \
 
 mkswap -V 2>&1 | awk '{print "util-linux            ", $NF}'
 
-mount --version 2>&1 | awk -F\- '{print "mount                 ", $NF}'
+mount --version 2>&1 | awk '{$1=$2=""; print "mount               ", $0}'
 
 insmod -V  2>&1 | awk 'NR==1 {print "modutils              ",$NF}'
 
-tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' |  awk \
+bcachefs version 2>&1 | grep "^[0-9]"  | awk \
+'NR==1 {print "bcachefs              ", $1}'
+
+mkfs.btrfs -V 2>&1 | grep "^mkfs.btrfs" | sed 's/,//' | awk \
+'NR==1 {print "btrfs                 ", $5}'
+
+tune2fs 2>&1 | grep "^tune2fs" | sed 's/,//' | awk \
 'NR==1 {print "e2fsprogs             ", $2}'
 
-reiserfsck 2>&1 | grep reiserfsprogs | awk \
-'NR==1{print "reiserfsprogs         ", $NF}'
+mkfs.exfat -V 2>&1 | grep "^exfatprogs" | sed 's/,//' | awk \
+'NR==1 {print "exfat                 ", $4}'
+
+mkfs.ntfs -V 2>&1 | grep "^mkntfs" | sed 's/,//' | awk \
+'NR==1 {$1="";print "ntfs                 ", $0}'
+
+mkfs.vfat 2>&1 | grep "^mkfs\." | sed 's/,//' | awk \
+'NR==1 {print "vfat                  ", $2}'
+
+mkfs.xfs -V 2>&1 | grep "^mkfs.xfs" | sed 's/,//' | awk \
+'NR==1 {print "xfs                   ", $3}'
 
 cardmgr -V 2>&1| grep version | awk \
 'NR==1{print "pcmcia-cs             ", $3}'
 
-pppd --version 2>&1| grep version | awk \
-'NR==1{print "PPP                   ", $3}'
-
 isdnctrl 2>&1 | grep version | awk \
 'NR==1{print "isdn4k-utils          ", $NF}'
 
@@ -125,6 +137,7 @@ loadkeys -V 2>&1 | awk \
 
 expr --v 2>&1 | awk 'NR==1{print "Sh-utils              ", $NF}'
 
+echo
 if [ -e /proc/modules ]; then
     X=`cat /proc/modules | sed -e "s/ .*$//"`
     echo "Modules Loaded         "$X
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
