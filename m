Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B43C5CFC1
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 12:50:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCC8B3C751F
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 14:50:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A25493C6CD7
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:49:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3760C60082C
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:49:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9065F3F13
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786711789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0gRVARkvXKwsR7sbd+RLUrB6/SK4loRipeVxDhIKwU4=;
 b=Q236XTD3ZjmYZpvt50nc9gg5QY5kd2I9PvJAzcnPxEDUYBNEPN2Xy0Wu8b/BssYIvAZksm
 4AzyQJSREyOFQJt8eqqOy83Z9fwqt7KoB+O35jI6xCCoj1C3FIQJuvzH3w5eUoaSgRFvmw
 QoVCdysxCfmPnu40+d5AoreXtw3MiLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786711789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0gRVARkvXKwsR7sbd+RLUrB6/SK4loRipeVxDhIKwU4=;
 b=5wDbvTqePa9x2USKHuhZnft9FgTvZi8ycAXaN5ymipNeOkVdPwT4CgvfXrZwEW852SpbUN
 QU6zS2TZBlmElpAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=frZKfNAh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S5b6oZr5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786711785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0gRVARkvXKwsR7sbd+RLUrB6/SK4loRipeVxDhIKwU4=;
 b=frZKfNAhrNrK6nwqohVeh7Lh4kwVFO+P9nlohcUFD+P9W6mgaexdQ7DIVHTAMyCQpXhSkv
 3k7ThSC5I0u0dHt3IXstCpOL6sKBwW0xyosP9WtTVPXcemlstNU24HuB2wwCP8OoSsk1ju
 yDAswk2rCBQwuTvUoXxHve+npaSMpmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786711785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=0gRVARkvXKwsR7sbd+RLUrB6/SK4loRipeVxDhIKwU4=;
 b=S5b6oZr5j1fHgS5fmM46HsNjLed3WHXU2fEYFXHdCtv8jDlTHVWHIJqsA5Jjfgyf/22V+M
 zkBRegRpnZ/E+JBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 749B3783AA
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 31LFGukOf2rlKgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Aug 2026 14:49:35 +0200
Message-ID: <20260814124943.36853-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9065F3F13
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_ONE(0.00)[1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] Add optional kernel support checks for filesystem
 features
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

Add optional checks to the LTP library whether the kernel supports mounting
a filesystem with special features. The check is enabled through the
.mount_check_support attribute in struct tst_fs.

Also use this check in the two tests which require XFS reflink support:
file_attr02 and refluxfs.

Martin Doucha (3):
  struct tst_fs: Add flag for checking filesystem mount support in
    kernel
  refluxfs: Check kernel reflink support before mount
  file_attr02: Simplify device mounting

 include/old/tso_safe_macros.h                   |  2 +-
 include/safe_macros_fn.h                        |  2 +-
 include/tst_safe_macros.h                       |  7 ++++---
 include/tst_test.h                              |  4 ++++
 lib/safe_macros.c                               | 14 ++++++++++----
 lib/tst_test.c                                  |  3 ++-
 testcases/cve/refluxfs.c                        |  1 +
 .../kernel/syscalls/file_attr/file_attr02.c     | 17 +++--------------
 8 files changed, 26 insertions(+), 24 deletions(-)

-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
