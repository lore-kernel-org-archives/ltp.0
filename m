Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21AF6CCF2DA
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 10:17:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0FF63E9E13
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 12:17:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E5923E9E13
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:16:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EB7FD6007B9
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:16:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B57D1F444;
 Mon, 19 Oct 2026 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792404998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDHTWBtKSZ84BiJ9DNYeGOJGrX2SFWVPkF/aP3Bfuy0=;
 b=sFQnXIgmkh/WpukGZKXD2lNAuJAgWrSABTiandnRSsWY7fIGuZhE1mH2PqvYgdCced6CLF
 RzyKpXD8lGR0i3VhnapmPtGPYNOjcEbscyORXRZusB1VJunGEA+m1kJyukIy9uJXxxE/SP
 7DlYzfJNKZG5EBfVLdK+aFD+R/r7VnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792404998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDHTWBtKSZ84BiJ9DNYeGOJGrX2SFWVPkF/aP3Bfuy0=;
 b=YZsMk4Qhf93xOkE3rM2kKWXr3LT+civhpqvRf+fsGYmFH9K3551RzNNYYzpBcAgq2Hba/g
 qvWo3+piJKAoesCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792404998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDHTWBtKSZ84BiJ9DNYeGOJGrX2SFWVPkF/aP3Bfuy0=;
 b=sFQnXIgmkh/WpukGZKXD2lNAuJAgWrSABTiandnRSsWY7fIGuZhE1mH2PqvYgdCced6CLF
 RzyKpXD8lGR0i3VhnapmPtGPYNOjcEbscyORXRZusB1VJunGEA+m1kJyukIy9uJXxxE/SP
 7DlYzfJNKZG5EBfVLdK+aFD+R/r7VnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792404998;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDHTWBtKSZ84BiJ9DNYeGOJGrX2SFWVPkF/aP3Bfuy0=;
 b=YZsMk4Qhf93xOkE3rM2kKWXr3LT+civhpqvRf+fsGYmFH9K3551RzNNYYzpBcAgq2Hba/g
 qvWo3+piJKAoesCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25C75136CC;
 Mon, 19 Oct 2026 10:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rcvrIQDu1WplUwAAD6G6ig:T2
 (envelope-from <gpathak@suse.de>); Mon, 19 Oct 2026 10:16:36 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: ltp@lists.linux.it
Date: Mon, 19 Oct 2026 15:46:20 +0530
Message-ID: <20261019101620.370689-2-gpathak@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261019101620.370689-1-gpathak@suse.de>
References: <20261016105203.9420-1-linuxtestproject.agent@gmail.com>
 <20261019101620.370689-1-gpathak@suse.de>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_CC(0.00)[gmail.com,suse.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TAGGED_RCPT(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 1/1] statx: Add regression test for
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
