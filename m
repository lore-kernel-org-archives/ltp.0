Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F6FC04A94
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 13:10:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B956D3CD09A
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 15:10:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27D0B3C62E0
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 15:10:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2902D601626
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 15:10:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4053221846;
 Thu, 10 Aug 2023 13:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691673021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eZiCifhjGtH6DBnw5l9us8t3gxrAVU/9f9dIv1t9RRw=;
 b=kj+QXwzkS86GS2Ae7Op0jng9SP/Yhq6ao6Hl9tZ6H2GVSoVa78SqOu+gn2ZctQfayoj1rU
 NjuW+7b5Ss5VyRo0OOOjR3JM2NWg9iUAaD4eRm1xkB8/SSGJc0ezJQMxvu7Y/Ir087fbeI
 6AZanuIQpr0W/YjxHeMt4nzZAG7b3vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691673021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eZiCifhjGtH6DBnw5l9us8t3gxrAVU/9f9dIv1t9RRw=;
 b=0ikNDgfKIdT8pCeupyB+EAVfMJIkXUva09e1+UDaduOfxzz8zX7/4CXYKqaWEibS0wJb24
 Ugydp7v4/vfmsMAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E661138E2;
 Thu, 10 Aug 2023 13:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hhpJC73h1GSoYwAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 10 Aug 2023 13:10:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A5AA6A076F; Thu, 10 Aug 2023 15:10:20 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 10 Aug 2023 15:10:12 +0200
Message-Id: <20230810131012.13026-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify23: Make evictable marks tests more reliable
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
Cc: Jan Kara <jack@suse.cz>, petr.vorel@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It has been observed that when fanotify23 test is run in a loop, it
eventually fails as:

fanotify23.c:112: TPASS: FAN_MARK_ADD failed with EEXIST as expected when trying to downgrade to evictable mark
fanotify23.c:75: TPASS: FAN_MARK_REMOVE failed with ENOENT as expected after empty mask
fanotify23.c:156: TPASS: Got no events as expected
fanotify23.c:81: TFAIL: FAN_MARK_REMOVE did not fail with ENOENT as expected after drop_caches: SUCCESS (0)

This is because repeated evictions of caches done by the test reclaim
all freeable slab objects in the system. So when the test calls drop
caches, only the dentry and inode of the test file are there to reclaim.
But for inode to be reclaimed, dentry (which holds inode reference) has
to be freed first and for dentry to be freed it has to first cycle
through the LRU which takes two slab reclaim calls.

Call drop caches twice to make sure dentry has chance to pass through
the LRU and be reclaimed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify23.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
index 89fd4f36a09b..2d50f70585b7 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify23.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
@@ -160,10 +160,15 @@ static void test_fanotify(void)
 	}
 
 	/*
-	 * drop_caches should evict inode from cache and remove evictable mark
+	 * drop_caches should evict inode from cache and remove evictable mark.
+	 * We call drop_caches twice as once the dentries will just cycle
+	 * through the LRU without being reclaimed and if there are no other
+	 * objects to reclaim, the slab reclaim will just stop instead of
+	 * retrying.
 	 */
 	fsync_file(TEST_FILE);
 	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
+	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
 
 	verify_mark_removed(TEST_FILE, "after drop_caches");
 
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
