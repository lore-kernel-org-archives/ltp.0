Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD33E606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 07:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=TujueOuT;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=mub06g46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794814847; h=date :
 mime-version : to : message-id : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=PR2eO/0KhRnXsOwQlFW/Uk4B8C9iPkL1ui5zyQSINDY=;
 b=TujueOuT4nr7hRySV6RCTRebeGFZ26UPIqqOM7Kd5xHfeaDNgEQymcdjsShEaB93T/Tnb
 j7uVuIF+cyyHl6Q+isaVgX15XrOFl4JiKAvSAzuKSb6BJGChns6egqQVAsG8WioTMntQYvx
 7nRFnj8xMxEhyDLs55XbwE6m6Yti37M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 199743CD3B4
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 08:40:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CE6C3CD3B4
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 08:40:28 +0100 (CET)
Received: from lf-1-128.ptr.blmpb.com (lf-1-128.ptr.blmpb.com
 [103.149.242.128])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0BF582003BE
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 08:40:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794814813; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=NjZcqCJqhd1quPXCgHHejseoLVF24z4tekw/ckx2hhc=;
 b=mub06g463t0OrAXBlqPiYI5BAuXTxNIcc6Wxjoyxd7jTZEU4s70mSuGdCWSbZy6q5PvpIv
 fbVnWE23V3r0iu+gkDatfBCO6H6T5w/otPmf+zCmAjxZQIz4ByKbrbhfTfbK6a2BfkXyB1
 FtsE2q0DZCrB1qZmyl6hpkEwGLGQgbRkD7O6Qe8g7QxjYjXIksoRLnjWRdtg9EOfQ4zc/i
 2ftyinJ+CDshuc5rAETDdAikDfH/IomGH0fimNhs04OXFiYUrBW3XPhKWhKAkh7dPDG8SZ
 U7GW7jN/fVxs3O1ONahJIAO2MxfH/PrfEZZIj/sXx28sk7uhKS2i6SQa9KVFrA==
Date: Mon, 16 Nov 2026 15:39:56 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26afab35b+e4c1a9+lists.linux.it+zhaogongyi@bytedance.com>
To: <ltp@lists.linux.it>
Message-Id: <20261116073956.98789-1-zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify13: clean overlay workdir when restoring
 lower objects
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Zhao Gongyi via ltp <ltp@lists.linux.it>
Reply-To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: amir73il@gmail.com, jack@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The FAN_DELETE_SELF test case removes test files. For lower variants,
overlayfs creates upper whiteouts to hide the lower objects. The current
clean_upper_dir() helper unmounts overlayfs and removes only the object
names from OVL_UPPER before remounting overlayfs.

When overlayfs is mounted with nfs_export/index enabled by default,
deleting lower objects may also leave index entries under OVL_WORK.
Removing only the upper whiteouts can leave stale index state. On remount,
collecting the recreated object ids may then fail with:

  overlayfs: bad index found (... ftype=2000, origin ftype=8000)
  fanotify.h:85: TBROK: statfs(tstmnt/file_one, ...) failed: EIO (5)

Purge both OVL_UPPER and OVL_WORK before remounting overlayfs so the
lower-variant restore starts from a clean overlay upper/work state.

Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 testcases/kernel/syscalls/fanotify/fanotify13.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index a43fae8..fde765e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -142,15 +142,16 @@ static void delete_objects(void)
-
+
 static void clean_upper_dir(void)
 {
-	unsigned int i;
-
 	SAFE_UMOUNT(MOUNT_PATH);
 	SAFE_UMOUNT(OVL_MNT);
-
+
-	SAFE_MOUNT(OVL_UPPER, MOUNT_PATH, "none", MS_BIND, NULL);
-	for (i = 0; i < ARRAY_SIZE(objects); i++)
-		SAFE_UNLINK(objects[i].path);
-	SAFE_UMOUNT(MOUNT_PATH);
+	/*
+	 * FAN_DELETE_SELF on lower objects creates whiteouts in upper and,
+	 * with nfs_export/index enabled, index entries under workdir. Remove
+	 * both trees before remounting overlayfs to avoid stale index state.
+	 */
+	tst_purge_dir(OVL_UPPER);
+	tst_purge_dir(OVL_WORK);
-
+
 	SAFE_MOUNT_OVERLAY();
 	SAFE_MOUNT(OVL_MNT, MOUNT_PATH, "none", MS_BIND, NULL);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
