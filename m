Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6750ACCF2DA
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 10:16:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0D053EA655
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 12:16:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B4503E61A9
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:16:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BEAF810007C3
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:16:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 571451F444;
 Mon, 19 Oct 2026 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792404995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEGfFZl0RoVwHYZZ85zt/jsw7QOiPFj1Xn0KAYiaX08=;
 b=pscG+93FcXMe6pK4XvlGV2//FoUUBNOHhxTOQKoGn+zhO5T5QS3bjYMSyQ0vLlEurvkR5M
 tW1/+oWeNCl6VDw/vALD0/awG390O5dT962vWdmMSTKjzG9JqCBShOMhBNU6T+9mMU/UAe
 GBt1mqqdaXy8KnV4dKk0TXD9d2Y11Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792404995;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEGfFZl0RoVwHYZZ85zt/jsw7QOiPFj1Xn0KAYiaX08=;
 b=cKtSHwlAtyJqHN8hxJz6jjNHJzuzTt8NEOb0qRc/XbvkeB7vMsjfncsSM0oRjzecL2lJk7
 3NaapziVIaFko7CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792404994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEGfFZl0RoVwHYZZ85zt/jsw7QOiPFj1Xn0KAYiaX08=;
 b=VyAukOiLKFMEJYt2hdUFJ+3wQDRzlx0PD6sh4chf9Puh5T8LYpeWNXzKopJOiP4MSJhBr1
 jumtKs+p1ueDDgGjlHYIAFdRCtjM/+QaGI+D3Bo8LkzV69nzDZPsBQe5RDizcqJ3K9/9u/
 50CLm7UXFREnKT9awi8p3NZCQsxQ+vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792404994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sEGfFZl0RoVwHYZZ85zt/jsw7QOiPFj1Xn0KAYiaX08=;
 b=pi1k2prHpX3d35pGJZxk3mfuOknsHAtYP+oHcl8CRnQJ5L0S11y8nNYZWHcgqfsVm2Q6SJ
 0FDR9v9L5SYg5HAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A675136CC;
 Mon, 19 Oct 2026 10:16:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rcvrIQDu1WplUwAAD6G6ig
 (envelope-from <gpathak@suse.de>); Mon, 19 Oct 2026 10:16:32 +0000
From: Gaurav Pathak <gpathak@suse.de>
To: ltp@lists.linux.it
Date: Mon, 19 Oct 2026 15:46:19 +0530
Message-ID: <20261019101620.370689-1-gpathak@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261016105203.9420-1-linuxtestproject.agent@gmail.com>
References: <20261016105203.9420-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 TAGGED_RCPT(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 0/1] statx: Add regression test for
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

Gaurav Pathak (1):
  statx: Add regression test for STATX_WRITE_ATOMIC on regular files


-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
