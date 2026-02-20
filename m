Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006E0C5AC7A
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 15:48:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97A583D084D
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 16:48:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 61F503D085E
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:47:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 060CB200213
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:47:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34DDF3E725;
 Fri, 20 Feb 2026 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771602468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvTXUl9qbfn0OuG2l/XfEbh8IznF7bDqRGjn/B6K0mo=;
 b=thbrIQMxc7DNXRg0+gNpJDtg5oDOxKT2zVkTNeNIP3Mx5EC2hqmBzm9wK4az1bK/WNsNfQ
 eFzXHEy3jD6obD+rrW+BRm2zQBN8NA2Ceg+P4ZanZbepxN+QnK2zMvEFwuSKFbqndWJsxw
 hJQSJp90nHrir5cMjJZjMZ281dILQ6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771602468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvTXUl9qbfn0OuG2l/XfEbh8IznF7bDqRGjn/B6K0mo=;
 b=KoLmfmwgeirc2NETg9NTbcVttfp2Q/gcAcgtbQFz0Z86k2dqR3EEcuspT/vXSHypQ/dTIy
 hYIDpVha2D6+j2DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QG7IXJto;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/6D11Ig6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771602467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvTXUl9qbfn0OuG2l/XfEbh8IznF7bDqRGjn/B6K0mo=;
 b=QG7IXJtos8rmhM07EkW7z2it1e0lnwpRubr7wb86A9vxTbTbt7Y+hsgP9zyHX7ak1OZiaj
 bbup8gc1rYwKD0CNTJSnDeYE5G41u1fjmfMQjRds49Qcyn02Qxru0qaX2uyzEQ4D5BBKGy
 L3y16jN+NOWtqCsJcpcHJjbERQei5b4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771602467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rvTXUl9qbfn0OuG2l/XfEbh8IznF7bDqRGjn/B6K0mo=;
 b=/6D11Ig6saaNk8XAxXR6EGkKOCBh+p4yt9w4ieUgPtcvlMS5s7bxyZT6sVYXdnUB/WtM38
 FTrj7/cTAlSo1rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13A3A3EA66;
 Fri, 20 Feb 2026 15:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6L+ZBCOCmGkmdwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 20 Feb 2026 15:47:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ppavlu@suse.cz,
	ltp@lists.linux.it
Date: Fri, 20 Feb 2026 16:47:08 +0100
Message-ID: <20260220154742.54150-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220154742.54150-1-mdoucha@suse.cz>
References: <20260220154742.54150-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_NONE(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim, suse.cz:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 34DDF3E725
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_fs.h: Add TST_TRACEFS_MAGIC constant
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
 include/tst_fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index ceae78e7e..6dfa157a5 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -11,6 +11,7 @@
 #define TST_NFS_MAGIC      0x6969
 #define TST_RAMFS_MAGIC    0x858458f6
 #define TST_TMPFS_MAGIC    0x01021994
+#define TST_TRACEFS_MAGIC  0x74726163
 #define TST_V9FS_MAGIC     0x01021997
 #define TST_XFS_MAGIC      0x58465342
 #define TST_EXT2_OLD_MAGIC 0xEF51
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
