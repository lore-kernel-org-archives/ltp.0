Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0D9C25B0E
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 09:07:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21A373CA278
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 11:07:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833823C54EC
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 11:07:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 91CA31A00A5B
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 11:07:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 701CB20A85;
 Fri, 19 Aug 2022 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660900029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CFjYMslf5M1e51kIUUy5bnX5hePGmjpu4zOiPj+1q1w=;
 b=MVheZ/4cnAD7GVfykTgBwaQZ2h9yJddAbC7YvW9vLcGOwV9VNMlI1qXXVne8g740LJvWVG
 r+yTgXSrtJwFH7JfUmiZvJzPS0xyeTEYucFp574BjiX5+MOr1LLqNQErotHpH/Eom9GDM9
 0mog/eY6PeTJ0evkKG9K31eiY1Rrzyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660900029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=CFjYMslf5M1e51kIUUy5bnX5hePGmjpu4zOiPj+1q1w=;
 b=opqSYA66bIPqGk0ZenZYTpvivC7crw2p6Yt42eaWAPWY7Fpu3fsDZi8U1kduEjajaQSuh8
 VatLEuGISLJKVFAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46B0D13AC1;
 Fri, 19 Aug 2022 09:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OBbND71S/2ITdQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 09:07:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 19 Aug 2022 11:07:04 +0200
Message-Id: <20220819090704.17219-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
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

They are defined in .tags, having in docparse results into poor
formating in metadata.{html,pdf}.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Li,

I've done cleanup like this in the past, but sending a patch just to
make consensus about it. If we prefer to have git commits like this in
the code (i.e. if being in .tags is not enough), they should be in
normal comments /* ... */ so that they aren't in docparse.

IMHO docparse can mention some commit if wanted to add some description,
but just as 5f955f26f3d4 or 5f955f26f3d4 ("xfs: report crtime and
attribute flags to statx") if the commit subject is a description
itself.

http://linux-test-project.github.io/metadata/metadata.stable.html#statx04

Kind regards,
Petr

 testcases/kernel/syscalls/statx/statx04.c | 35 +----------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index 98f9a6315..6c562b3d7 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -14,41 +14,8 @@
  * - STATX_ATTR_NODUMP: File is not a candidate for backup when a backup
  *                        program such as dump(8) is run.
  *
- * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
+ * XFS filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
  * three other flags.
- *
- * ext2, ext4, btrfs, xfs and tmpfs support statx syscall since the following commit
- *
- *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
- *  Author: yangerkun <yangerkun@huawei.com>
- *  Date:   Mon Feb 18 09:07:02 2019 +0800
- *
- *  ext2: support statx syscall
- *
- *  commit 99652ea56a4186bc5bf8a3721c5353f41b35ebcb
- *  Author: David Howells <dhowells@redhat.com>
- *  Date:   Fri Mar 31 18:31:56 2017 +0100
- *
- *  ext4: Add statx support
- *
- *  commit 04a87e3472828f769a93655d7c64a27573bdbc2c
- *  Author: Yonghong Song <yhs@fb.com>
- *  Date:   Fri May 12 15:07:43 2017 -0700
- *
- *  Btrfs: add statx support
- *
- *  commit 5f955f26f3d42d04aba65590a32eb70eedb7f37d
- *  Author: Darrick J. Wong <darrick.wong@oracle.com>
- *  Date:   Fri Mar 31 18:32:03 2017 +0100
- *
- *  xfs: report crtime and attribute flags to statx
- *
- *  commit e408e695f5f1f60d784913afc45ff2c387a5aeb8
- *  Author: Theodore Ts'o <tytso@mit.edu>
- *  Date:   Thu Jul 14 21:59:12 2022 -0400
- *
- *  mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs
- *
  */
 
 #define _GNU_SOURCE
-- 
2.37.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
