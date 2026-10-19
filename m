Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C51CCF2E5
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 10:29:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDB6C3EA647
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 12:29:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15BA13E2832
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:28:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B8ED2001CC
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:28:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 693E221C92;
 Mon, 19 Oct 2026 10:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792405731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDHTWBtKSZ84BiJ9DNYeGOJGrX2SFWVPkF/aP3Bfuy0=;
 b=k13297EwKGjV/ael6yK/4agbzXtawWEMdcOjfoR6i35/VFdz6bBMp0ZEm7wQaKW3sik+Cf
 dAKgf2cp60v5bVJL8nViwL1GQkbJhOKdO8/LnAMkslSnHpGjPfqehx/z1y6oaz5YoeQE+C
 yNzPuATorm4aLiIeAl+0Ct6Bdmzlrow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792405731;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDHTWBtKSZ84BiJ9DNYeGOJGrX2SFWVPkF/aP3Bfuy0=;
 b=plt+QWfQaoICCdRtQihD/nUmn8UnRFIUGcv+m9Fzvvk4sleiC85fIrx6uMp/Q5t2+kKyk9
 hUcb3rGGeKI0mOBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YVLi3qQj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/qQOvzUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792405730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDHTWBtKSZ84BiJ9DNYeGOJGrX2SFWVPkF/aP3Bfuy0=;
 b=YVLi3qQjFjiC4BOG27isd6+/u4r5pzJYoA+1ts+KMPU8wy+ox1S5jhGOVBbKxoeL0k2W+N
 fERYHm1Sz7WxKUDQGXcCS7e//J1R/f41vbBmkYr7U7wh7JIHxZhQo/3gyjMrf7+CAzXdnA
 ST5m6CzcF9kDKpc5AgzpxleftqJuR3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792405730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDHTWBtKSZ84BiJ9DNYeGOJGrX2SFWVPkF/aP3Bfuy0=;
 b=/qQOvzUIcA0NDdNeG4Cop/s9DRZtpQJOwIJ/eaLhKbpa9J2qNA8vaBfRGs4KE/citcekVU
 znOjVtJzt9WIbgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08DCA136CC;
 Mon, 19 Oct 2026 10:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bFb3H+Dw1WpYYAAAD6G6ig
 (envelope-from <gpathak@suse.de>); Mon, 19 Oct 2026 10:28:48 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: ltp@lists.linux.it
Date: Mon, 19 Oct 2026 15:58:34 +0530
Message-ID: <20261019102835.371021-1-gpathak@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261016105203.9420-1-linuxtestproject.agent@gmail.com>
References: <20261016105203.9420-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 693E221C92
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 2/2] statx: Add regression test for
 STATX_WRITE_ATOMIC on regular files
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
Cc: Gaurav Pathak <gaurav.pathak@suse.com>, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Gaurav Pathak <gaurav.pathak@suse.com>

This series adds syscalls/statx13, an LTP test exercising statx(2)'s
STATX_WRITE_ATOMIC reporting on regular files for XFS and ext4.
It covers the hardware-backed atomic write path (shared by both
filesystems, where the underlying block device itself advertises
atomic write support) as well as XFS's newer software/CoW-based
atomic write path (Linux v6.16+), which works even on devices without
hardware atomic write support, such as loop devices.

---
Changes in v8:
- Query the test device's own atomic write capability via statx()
  before formatting, instead of assuming fixed mkfs options always apply.
- Derive the XFS/ext4 mkfs block size (and ext4 bigalloc cluster size)
  from the device's reported atomic write limits at runtime, capped at
  the 64KiB xfsprogs/e2fsprogs ceiling and at the page size unless THP
  (xfs) or blocksize_gt_pagesize (ext4) allows larger blocks.
- Add support for XFS's software (CoW/reflink-based) atomic write path
  (Linux v6.16+), so the test produces meaningful results on loop
  devices too, not just on real or scsi_debug-emulated hardware.
- Keep ext4 on the hardware-only path, since it has no software
  fallback; TCONF cleanly when the device lacks atomic write support.
- Switch from .mount_device with static per-filesystem mkfs_opts to
  .needs_device + .needs_root with explicit setup()/cleanup(), to
  support the new dynamic mkfs/mount logic and TCONF branching.
- Drop the hardcoded xfs-only .min_kver = "6.12" override; gate
  behavior on runtime statx() results instead of a fixed kernel
  version.
- Expand the file's top comment to document the hardware vs.
  software atomic write mechanisms and the block-size constraints
  involved.
- Link to v7: https://lore.kernel.org/r/20261016-statx-atomic-write-v7-1-d9cd4e1f1bcd@suse.com

Signed-off-by: Gaurav Pathak <gaurav.pathak@suse.com>

--- b4-submit-tracking ---
# This section is used internally by b4 prep for tracking purposes.
{
  "series": {
    "revision": 1,
    "change-id": "20261019-statx-atomic-write-1919fc099e97",
    "prefixes": []
  }
}
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
