Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA85EC3ABD8
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 07:51:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0A683CC55F
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 09:51:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86FF43CC526
 for <ltp@lists.linux.it>; Fri, 16 May 2025 09:51:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A94B114060BB
 for <ltp@lists.linux.it>; Fri, 16 May 2025 09:51:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 932252124D;
 Fri, 16 May 2025 07:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747381876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxjxL2LgKdwj/66V7aTGyUmMnOCEVpErcWC3vf/42Zw=;
 b=NhW3ef8rr+TtkN1EqxNuSFGO6UBdNubq2jZ41+teEfSHo8HNifjAEG9fEW86YJAdfuLFMM
 /ylSlIzo2IMKDZPpjKy6WvJrhgf0h2Ge4PrkeG4jCaEANCh6rkDGBczp9Tj15Fc4aG5D/R
 nBhikBFsN55fwFdL5awWoMOH3vB00PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747381876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxjxL2LgKdwj/66V7aTGyUmMnOCEVpErcWC3vf/42Zw=;
 b=MbtNjua2t9ybqGO7Fs38c+2/9RnHCuXa5Knc2AqRzxvEuh97hjiUD+gZzDi3upVLfpc2HJ
 Sj/gcKpxP79+PDDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NhW3ef8r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MbtNjua2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747381876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxjxL2LgKdwj/66V7aTGyUmMnOCEVpErcWC3vf/42Zw=;
 b=NhW3ef8rr+TtkN1EqxNuSFGO6UBdNubq2jZ41+teEfSHo8HNifjAEG9fEW86YJAdfuLFMM
 /ylSlIzo2IMKDZPpjKy6WvJrhgf0h2Ge4PrkeG4jCaEANCh6rkDGBczp9Tj15Fc4aG5D/R
 nBhikBFsN55fwFdL5awWoMOH3vB00PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747381876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxjxL2LgKdwj/66V7aTGyUmMnOCEVpErcWC3vf/42Zw=;
 b=MbtNjua2t9ybqGO7Fs38c+2/9RnHCuXa5Knc2AqRzxvEuh97hjiUD+gZzDi3upVLfpc2HJ
 Sj/gcKpxP79+PDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 622AE13977;
 Fri, 16 May 2025 07:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4q+cFnTuJmgWSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 16 May 2025 07:51:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 16 May 2025 09:51:13 +0200
Message-ID: <20250516075113.522145-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 932252124D
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] valgrind-announce: Update valgrind ML
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

valgrind-developers has heavy traffic, use valgrind-announce.

Fixes: 93039e4384 ("doc: ltp_release_procedure: Add valgrind-developers ML")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/maintainers/ltp_release_procedure.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/maintainers/ltp_release_procedure.rst b/doc/maintainers/ltp_release_procedure.rst
index 6dbafa4f81..24ea864b03 100644
--- a/doc/maintainers/ltp_release_procedure.rst
+++ b/doc/maintainers/ltp_release_procedure.rst
@@ -157,7 +157,7 @@ The announcement is sent to:
 * ltp at lists.linux.it (requires a subscription)
 * linux-kernel at vger.kernel.org
 * libc-alpha at sourceware.org (requires a subscription)
-* valgrind-developers at lists.sourceforge.net (requires a subscription)
+* valgrind-announce at lists.sourceforge.net (requires a subscription)
 
 CCed to:
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
