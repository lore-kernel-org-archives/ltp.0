Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAB9C48BC3
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 16:55:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D75013D13AF
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 17:55:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6224C3C06A6
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 17:55:11 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 82242201164
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 17:55:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A498521D03;
 Mon, 19 Feb 2024 16:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708361708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UEhYQQ7H8eNjc5Z/Vt7Z09/PDgPmWAnMgjtMdp0akkg=;
 b=Q/uzZibP+1uLaBr+GbvzM2+t4Qw05VzOVqsHldTy7dZOEM+/KVL3pYc7hdwKX5x0yW7a1k
 gye4kR1LO6h+w1/qc/uCU7vBYne51JiGFD242K6xhNgJ3bA8ljeMynKgHxBf47YNhqMRZK
 duEiQeOQwtuF8j1Og//VZd3+EX7k9+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708361708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UEhYQQ7H8eNjc5Z/Vt7Z09/PDgPmWAnMgjtMdp0akkg=;
 b=eZsLPFFIgKwSBBDRAavpoisUpNMX2ziWONs3fROO2IxHCtENp1EnjdK59PBvPtvhuK5FTO
 QdrUWQ0RMidAtSDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708361707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UEhYQQ7H8eNjc5Z/Vt7Z09/PDgPmWAnMgjtMdp0akkg=;
 b=G7bpZ8FZzbDLhafd9KsvVY5NL+wjjJ9Z9y/xXJnvMiqerUnDmeeaa94w47Q7hWAvIXkSlI
 uDPUXZZ0zaPo8Zf8gojqlEJf46+vaTv4Qc6a05sRqlr2deJsxAWn2jyyNIws33BcemPfs3
 wRvvPRdRmfQ13+fCLG0XXpvFhCb4oyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708361707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=UEhYQQ7H8eNjc5Z/Vt7Z09/PDgPmWAnMgjtMdp0akkg=;
 b=cgY6QEE1gmKC71c8TmxwUc0Z6Dl9GsNfoooS/PcM01SWsqRHPpnjM6fHUiw9nesF398+s5
 Xm7i1/FzCJDZMDBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9735C139D0;
 Mon, 19 Feb 2024 16:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ALxsJOuH02WmCAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 19 Feb 2024 16:55:07 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Petr Vorel <pvorel@suse.cz>,
	ltp@lists.linux.it
Date: Mon, 19 Feb 2024 17:54:50 +0100
Message-ID: <20240219165506.19825-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=G7bpZ8FZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cgY6QEE1
X-Spamd-Result: default: False [4.69 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nfs05.sh:url,nfs06.sh:url,suse.cz:dkim,suse.cz:email,nfs07.sh:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A498521D03
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] net.nfs: Fix nfs06.sh runfile entries
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

The old names of two nfs06.sh test entries got left behind which breaks
runfile processing.

 runtest/net.nfs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index af2a64174..929868a7b 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -58,8 +58,8 @@ nfs05_v41_ip6t nfs05.sh -6 -v 4.1 -t tcp
 nfs05_v42_ip6t nfs05.sh -6 -v 4.2 -t tcp
 
 nfs06_v30_v40_ip4  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
-nfs06_vall_ip4t nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
-nfs06_v4x_ip6t nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
+nfs06_vall_ip4t nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
+nfs06_v4x_ip6t nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 
 nfs07_v30_ip4u nfs07.sh -v 3 -t udp
 nfs07_v30_ip4t nfs07.sh -v 3 -t tcp
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
