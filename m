Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F10CD98F2
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 14:10:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 13D2F3E2377
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 16:10:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C136F3CEDDE
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:10:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3171E6012B0
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:10:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43C906D3CD;
 Thu, 18 Jun 2026 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781791828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zTCujGiYv8ifAQoIz9SHOI+hBhmYDF8gjGPpxnymlOE=;
 b=TVvn5J0TE0GiWhO9csrsLLy2chWaTg5KCRE7ykUVs+pnUN1Bi2qmBuhf5quIyIi0wHjFok
 ZzdeRTMGUH/o8BST3s6ZU+qZGZwHiqS+cXipVjGuANPZiXwFAsumWdC7ct4j3kGoTuBdUK
 KAljbXIw09b09KYyqHNUTExpdwMPuec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781791828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zTCujGiYv8ifAQoIz9SHOI+hBhmYDF8gjGPpxnymlOE=;
 b=VKz2SVXIciT1a3pLYdr0LOw52np0eqsXR7cE1iqJbXSXX8OTxgtQ8setZrJpKYAWO4YTu0
 8qUWPVK7hb+EfzBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TVvn5J0T;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VKz2SVXI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781791828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zTCujGiYv8ifAQoIz9SHOI+hBhmYDF8gjGPpxnymlOE=;
 b=TVvn5J0TE0GiWhO9csrsLLy2chWaTg5KCRE7ykUVs+pnUN1Bi2qmBuhf5quIyIi0wHjFok
 ZzdeRTMGUH/o8BST3s6ZU+qZGZwHiqS+cXipVjGuANPZiXwFAsumWdC7ct4j3kGoTuBdUK
 KAljbXIw09b09KYyqHNUTExpdwMPuec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781791828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zTCujGiYv8ifAQoIz9SHOI+hBhmYDF8gjGPpxnymlOE=;
 b=VKz2SVXIciT1a3pLYdr0LOw52np0eqsXR7cE1iqJbXSXX8OTxgtQ8setZrJpKYAWO4YTu0
 8qUWPVK7hb+EfzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FD82779A8;
 Thu, 18 Jun 2026 14:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7kEKBVT8M2p7CgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 18 Jun 2026 14:10:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 18 Jun 2026 16:10:25 +0200
Message-Id: <20260618-metadata_groups-v2-0-6ab298932233@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFH8M2oC/3WNQQ6CMBBFr0JmbU07EqquuIchZkJH6AJKOtBoS
 O9uZe/yveS/v4Nw9Cxwr3aInLz4MBfAUwX9SPPAyrvCgBob3RhUE6/kaKXnEMO2iHIO64tmNDd
 toKyWyC//PoqPrvDoZQ3xcxwk87P/W8korZwlrMlSb+nayiZ87sMEXc75C/nx9netAAAA
X-Change-ID: 20260612-metadata_groups-dd2430e21901
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781791828; l=846;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=QBvblz76v6I1PEbZ4pVEmzTtbq4keduRAhLMldKYefE=;
 b=phbKhLVg9LPBZ5zHZa9ELWRV18jP05DcGHd601HL8ykHkybafsl+/XHR/mykNR+xlz59dhP6K
 VoTYggich8SCxDLNCi0/k6VFZhXuzItHbCGEpNxyAwpkyyFOx2b2vgg
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 43C906D3CD
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Support metadata groups
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
Changes in v2:
- switch from @group to @groups
- use Cyril snippet to folter out groups from description
- optimize code
- Link to v1: https://lore.kernel.org/r/20260612-metadata_groups-v1-0-d7a24a7ac7a8@suse.com

---
Andrea Cervesato (2):
      metadata: add tests grouping support
      doc: conf.py: Show groups in test catalog

 doc/conf.py                  |  10 +++
 metadata/metaparse.c         | 159 +++++++++++++++++++++++++++++++++++--------
 metadata/tests/groups.c      |  11 +++
 metadata/tests/groups.c.json |  12 ++++
 4 files changed, 162 insertions(+), 30 deletions(-)
---
base-commit: bc9cfca5c7b6599e501d580bb42b9538390fd9a6
change-id: 20260612-metadata_groups-dd2430e21901

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
