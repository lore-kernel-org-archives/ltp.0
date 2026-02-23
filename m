Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B95CEA4FA0
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 10:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771844299; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=MnNRQ/9bSJl2EC74w4xizidq+SWGoECrOXMBhbltJ8w=;
 b=JgFHPIi1np8eKmsslN+W8TcMzkjQ+8/g3+JOHs/uoiwOXE+DOLq6WnDxkv75SVrbsluQg
 65ueB7SgGVDb6w3lbjY7iWtsDk58sTOwwy+Rvl9FQy01VbvUOSLZvaF2aN2YQ9tYmrLwKeY
 jrDtHj9gmeQ5/pLlP/XSET8DAB0em78=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FEBD3D0EEF
	for <ltp@archiver.kernel.org>; Mon, 23 Feb 2026 11:58:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B2D23C7C41
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:28 +0100 (CET)
Received: from lf-1-131.ptr.blmpb.com (lf-1-131.ptr.blmpb.com
 [103.149.242.131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D53EB1A00245
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 04:18:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1771816696; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=lgz26iRoNLXrakDTd1oz5hGJkO9cQ5KBGDvtOFjCr5E=;
 b=QQOdpO2/ta2vcchlW6pnCN6nuGo+Jr5PGSKfuksRT1kKGttNQ9iPStd1AWmdODrI0+GXh0
 jNQYVJj7C2BRzpV3Ma8smAV2nCfLZ+6v6Ow4cxBmyz2xhWBMF8FV5aq77y0oBtTRdiFcdN
 pqRh4RFceG+9Hex9UKzPfvy6p/WT68K/DGrKuDiDmeXQM0sUEW7wdm5h5i/oosLgqHwgh1
 /rOGkLrri1Fb1XYiEH1i3QCzNZoiDc9L4U8Lapn3eaL7d0VpVfzR1RlAshsp9P1YoqzT7m
 3x9BJe+WSXBPQ5g/vJb3cx8OlbMGzYJJQA56sl54zTL7S9XKeRNHekITkR19BQ==
Date: Mon, 23 Feb 2026 11:18:59 +0800
To: <ltp@lists.linux.it>
X-Mailer: git-send-email 2.20.1
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
Message-Id: <20260223031903.4037526-1-weiguixiong@bytedance.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2699bc6f7+43e3c1+lists.linux.it+weiguixiong@bytedance.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 23 Feb 2026 11:57:56 +0100
Subject: [LTP] [PATCH 0/4] syscalls/ipc: shmctl04: Fix /proc/sysvipc/shm
 parsing
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
From: Guixiong Wei via ltp <ltp@lists.linux.it>
Reply-To: Guixiong Wei <weiguixiong@bytedance.com>
Cc: Guixiong Wei <weiguixiong@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

This series fixes shmctl04 parsing and reporting for /proc/sysvipc/shm.

On systems with large SHM segments, the "bytes" column in /proc/sysvipc/shm may
exceed int range, which can lead to truncation and incorrect accounting. The
series parses the size column as unsigned long, requires fscanf() to match all
expected fields to avoid using stale values on partial matches, fixes format
specifiers when reporting counters, and uses SAFE_FOPEN/SAFE_FCLOSE for /proc
reads.

Thanks.

Guixiong Wei (4):
  syscalls/ipc: shmctl04: Parse /proc/sysvipc/shm size as unsigned long
  syscalls/ipc: shmctl04: Require full fscanf match
  syscalls/ipc: shmctl04: Use SAFE_FOPEN for /proc parsing
  syscalls/ipc: shmctl04: Fix shm_info print formats

 .../kernel/syscalls/ipc/shmctl/shmctl04.c     | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

-- 
2.20.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
