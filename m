Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4201BC001DF
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 15:08:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D5643CEDBF
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 17:08:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87FAE3CEDBF
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 17:07:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71EA36007AC
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 17:07:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41EDC21A2C;
 Fri, 20 Oct 2023 15:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697814470; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HqLHMZ78q4M9k14OisnrkyrISVjoCVpLSmU2Ibinnpg=;
 b=KGZn+g9QThYYmNL0UQu8Kq0ba09WCkveAcvnWWU8gAFuK0sOm/4PlG8LE0XwMGdIT8OKYa
 Q5D5CROOF8/+UuYM9LHtezAHERdkqY4aqjGAhBUatiekKySqKWB7ld9PWQpeiAk+ZxNBuW
 wCD47AtgQ8M/+Mdx2ABnnK7md3QZ9S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697814470;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HqLHMZ78q4M9k14OisnrkyrISVjoCVpLSmU2Ibinnpg=;
 b=tzb1OoU04SrD3WQFF6ZZgnLCivBuFJWAenuhIaFKGgZSPvMF2kBxjm3ECvg6rAhGM654aN
 Oy7a8tunGr1cMQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23B16138E2;
 Fri, 20 Oct 2023 15:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IBO0B8aXMmW6WgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 20 Oct 2023 15:07:50 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Date: Fri, 20 Oct 2023 17:06:01 +0200
Message-ID: <20231020150749.21165-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.82 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 R_MISSING_CHARSET(2.50)[]; BROKEN_CONTENT_TYPE(1.50)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FREEMAIL_TO(0.00)[gmail.com,suse.cz,lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.08)[63.45%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] Fix fanotify14
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

Fanotify14 tests some fanotify_init() flags which are not supported
on older kernels but doesn't properly check for their availability.
Add a reusable helper function for fanotify_init() feature detection
and fix kernel support checks in fanotify14.

After discussion in the SUSE LTP team, I've decided to fix my previous
patchset and submit it again.

Martin Doucha (2):
  Add fanotify_get_supported_init_flags() helper function
  fanotify14: Improve check for unsupported init flags

 testcases/kernel/syscalls/fanotify/fanotify.h | 43 +++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify14.c     | 15 ++++---
 2 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
