Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E291AC5516D
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 19:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785441263; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GVxweHb3R+i5tvW07sG8XKxUiXV9BIg3RIQ7z4t0/GI=;
 b=Cu1E5I4tQJcv7puZxEojfZOOO3sv3KW9KFzlSpnGUF+dil5EWDShrohPyZevxxoMvYh9z
 6ah6pbM1HRSAWfrdF+XZF7baS7L3uoy1P2E6BuIeBUW7g6Ew7wUtucAv0nSRVno9LJEwW7U
 oGRtnwM4tSbLi0H50keGGUVdyziOhhc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0EB13E7636
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 21:54:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BE383E49F7
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 21:54:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CBCFF600700
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 21:54:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785441239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qe2ysZs7rPyWAp4gwEZ1tGzJAp5sGsqm8pfbLxsG75A=;
 b=fpBB06MUb6Xd6Ff3erSCg4/Ad8/KTfpWoX5qYm/360CtQWRDsaU8nQz1/1dQKjitcbysC+
 hmOnQcGwJPTKDqcGsXMRYZbf1/1Iv+ZXE63yCrAKVHuva1snpwWqmEYUaIJG2dlutx8jY+
 FfoUJqLS5ulOd4zz+Fv70aG4+BD/2Tc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-QtDlPTIGMDCsPZztMStcsg-1; Thu, 30 Jul 2026 15:53:57 -0400
X-MC-Unique: QtDlPTIGMDCsPZztMStcsg-1
X-Mimecast-MFC-AGG-ID: QtDlPTIGMDCsPZztMStcsg_1785441237
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e6ed4fe99so45976585a.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 12:53:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785441237; x=1786046037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qe2ysZs7rPyWAp4gwEZ1tGzJAp5sGsqm8pfbLxsG75A=;
 b=BiqVb7NJgbbdyf1MGNT59PLk/nd967ccPEI9vYlJo9gPe8LEdXXelpYZXecI3/nt09
 N0T2BbI0l5MowERlqhStSfFQy37cwsArJExKcUimHQItAQ0V+FK6MtrWO7AW+U2MNyoM
 4OhfAZwWwjc7EX+SGoiXNku2cxuPq9iB5Q8B1uwwr1SOFHH6iQIKvj0iggsAZ5Pm3fex
 dnlXIAGKQuk1zRA+VIAUu0eGkj0B/aqsxESU5zsR0I7gg86SJ5MYIiLWdwqW2LHwr42M
 f1u3vyp8Oe2QLLzDvHPn8XVDTyPEnlsJOGkZf+tA94FHGMos70T4BwkhrsvVA3gpj668
 VgIg==
X-Gm-Message-State: AOJu0Yz9QXhZgw8NDKJ7KWinpCKpPbesvhL8ozgctkzvXv0cqPHVYIlA
 In8mgF1QBdxlF9q6BFYmhs8i3Ut8XhTl0IgNLKQRkV5mP5cz0kSKySV/5km+dPv3mrbk/do0px8
 S9+8sNXw6Nx0MYZGmQQnHDuI3xrpdl8WhNiMuxAwA7NqLeEVeGSfBy8DEGL5W1FyNjbGHZjBIrb
 waAq1KAvDrlYfCilk2DRnZMruCm8hkTDdgKvGp
X-Gm-Gg: AR+sD11rcB0/PpDTHKzTSIPdaCmtUv6ZY7GyWy6hnGgk7lpODgHNHFUl/t6NDdUU+Dk
 jzLTakAAVwY266k50r0OR8sxAMzheoMfi7L2cWnn29m6j5RQU2olJwOTCfXhauKQLQOhviE9U99
 w94QKJkETGOnimEsaJnJR2MpYIorczgHeVIWi9L2Ds830Qljb9NNwyVWYHPjWXEg4lJ+9fK1A3w
 OyRD30aejtwkUPsnESOz61oWNwCaL6kJHr+5eJus7DirR52zCMHd8HhCyztJkSif12HtvPE4hDe
 PNyyxeC5hVpJAti3TeQRnpSNyYZX6cZZsLdVNIDzY7asLhXXpoifVquUoGeyxqY4MP9UyAeBC4c
 V95dX9+iFx4FYKY7E787Z8B6WIQ==
X-Received: by 2002:a05:620a:6b84:b0:915:abc4:b570 with SMTP id
 af79cd13be357-934861449admr349049485a.48.1785441236593; 
 Thu, 30 Jul 2026 12:53:56 -0700 (PDT)
X-Received: by 2002:a05:620a:6b84:b0:915:abc4:b570 with SMTP id
 af79cd13be357-934861449admr349047185a.48.1785441235957; 
 Thu, 30 Jul 2026 12:53:55 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-933e73181e1sm479185485a.25.2026.07.30.12.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 12:53:54 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 30 Jul 2026 15:49:50 -0400
Message-ID: <20260730194953.274721-2-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730194953.274721-1-sbertram@redhat.com>
References: <20260730171956.237584-1-sbertram@redhat.com>
 <20260730194953.274721-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MnYu7i9lfKPy9XA0a9Y3VEjukDOoag-JkFCp1nBI5gk_1785441237
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] newipc: Factor out generic
 get_ipc_idx_from_id() helper
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Stephen Bertram <sbertram@redhat.com>

get_shm_idx_from_id()'s per-index STAT loop will be needed again for
semctl01's SEM_STAT lookup. Move it into a generic get_ipc_idx_from_id()
helper in libs/newipc, taking a per-family stat() wrapper, so IPC tests
that need to translate an id to its live kernel index can share one
implementation instead of duplicating the loop.

shmctl01 is converted to use the new helper. No functional change.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
Assisted-by: Cursor:Sonnet-5
---
Test: ./kirk -w 4 -f syscalls_32 -p shmctl01 -i 1000
After changes:
Total runs:  32000
Runtime:    24m 57s
Passed:     384000
Failed:     0
Skipped:    0
Broken:     0
Warnings:   0

 include/tse_newipc.h                        | 20 ++++++++++++++++++++
 libs/newipc/tse_newipc.c                    | 13 +++++++++++++
 testcases/kernel/syscalls/shmctl/shmctl01.c | 14 +++++++-------
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/include/tse_newipc.h b/include/tse_newipc.h
index 1d3bbd129..175a60234 100644
--- a/include/tse_newipc.h
+++ b/include/tse_newipc.h
@@ -49,4 +49,24 @@ void *probe_free_addr(const char *file, const int lineno);
 #define PROBE_FREE_ADDR() \
 	probe_free_addr(__FILE__, __LINE__)
 
+/**
+ * get_ipc_idx_from_id() - Find the kernel index of an IPC resource by id.
+ *
+ * @id: The msqid/semid/shmid to look for.
+ * @max_idx: Highest kernel index to search, from IPC_INFO/SEM_INFO/SHM_INFO.
+ * @stat_fn: Per-family *_STAT wrapper called as stat_fn(idx, buf) for
+ *           each idx in [0, max_idx]; must return the id at idx, or -1
+ *           on error, without aborting the test.
+ * @buf: Buffer passed through to @stat_fn.
+ *
+ * SysV *_STAT commands (MSG_STAT/SEM_STAT/SHM_STAT) take a kernel array
+ * index rather than the id returned by *get(), and that index is not
+ * guaranteed to match the id when other IPC users are active. This walks
+ * the live indices to find the one that currently maps to @id.
+ *
+ * Return: The kernel index mapping to @id, or -1 if none was found.
+ */
+int get_ipc_idx_from_id(int id, int max_idx,
+			int (*stat_fn)(int idx, void *buf), void *buf);
+
 #endif /* tse_newipc.h */
diff --git a/libs/newipc/tse_newipc.c b/libs/newipc/tse_newipc.c
index f7edda6b5..aee286a31 100644
--- a/libs/newipc/tse_newipc.c
+++ b/libs/newipc/tse_newipc.c
@@ -86,3 +86,16 @@ void *probe_free_addr(const char *file, const int lineno)
 
 	return addr;
 }
+
+int get_ipc_idx_from_id(int id, int max_idx,
+			int (*stat_fn)(int idx, void *buf), void *buf)
+{
+	int i;
+
+	for (i = 0; i <= max_idx; i++) {
+		if (stat_fn(i, buf) == id)
+			return i;
+	}
+
+	return -1;
+}
diff --git a/testcases/kernel/syscalls/shmctl/shmctl01.c b/testcases/kernel/syscalls/shmctl/shmctl01.c
index 05aea58cc..bfc11fa39 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl01.c
@@ -224,20 +224,20 @@ static void dummy_sighandler(int sig)
 	(void)sig;
 }
 
+static int shm_stat(int idx, void *buf)
+{
+	return shmctl(idx, SHM_STAT, buf);
+}
+
 static int get_shm_idx_from_id(int shm_id)
 {
 	struct shm_info dummy;
 	struct shmid_ds dummy_ds;
-	int max_idx, i;
+	int max_idx;
 
 	max_idx = SAFE_SHMCTL(shm_id, SHM_INFO, (void *)&dummy);
 
-	for (i = 0; i <= max_idx; i++) {
-		if (shmctl(i, SHM_STAT, &dummy_ds) == shm_id)
-			return i;
-	}
-
-	return -1;
+	return get_ipc_idx_from_id(shm_id, max_idx, shm_stat, &dummy_ds);
 }
 
 static void setup(void)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
