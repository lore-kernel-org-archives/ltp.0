Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722C3C43602
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 13:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783083628; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=dvBH7UoH1yxGMW4S0yvlzFuReDEAJR4fJEEipt2aosM=;
 b=ZnkoOmoQbscXxzTLqWqap/LnaPklZDJ01S3BcWHFJTyrgWLd8m7cniq8Umt7TMhYXU0z2
 m2Dd4PsKyoEpnGLF4ZgilZwTaghbrNvdNmv+VstZO/OC8DuXbkqTp+eWTtMBa+PejBF7tXe
 xPeBAZKMYEyZm9y0DkmS3+tRGZ2qUe0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99E043E9468
	for <ltp@archiver.kernel.org>; Fri,  3 Jul 2026 15:00:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1E4C3E1644
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 15:00:09 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E46314010CB
 for <ltp@lists.linux.it>; Fri,  3 Jul 2026 15:00:08 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493b779003fso2567055e9.3
 for <ltp@lists.linux.it>; Fri, 03 Jul 2026 06:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783083608; x=1783688408; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rA4o4zLhDpfhZmGyX+NAlQfPmTynktvQZHHhPkusDYo=;
 b=V6fMPXrGOhUl2qmemg/2LmjxaYG0nx/QzG/GKje1S3fAG5QlmWlQMHedDFufedC42G
 FuNCDpYNJ3sdFrMuiJThGnGq/RMe7RhqeYTvd6dMCXxc/f+yw22DDzknKvl8Qihq9SvH
 vDvuDp40pWQVShfvsFQBSg5pg6tuh/kkFUhdOXJ+nsQyCPigwR7RYoi+VjhX/lLhCtXw
 YQXqLDmKS9ZmUNRxUTbZpWxBGYjXFwhaFS2L5rQeuQWL8ZDCooMljLwnLtdM3kYxwhJ1
 y+Z+4NUb7Mg0hqS7z7TesT/Y5GcuPoc73rrwL52yw6lfd/lGbBUuFyVNPa4yQ0BzAoqn
 arTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783083608; x=1783688408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rA4o4zLhDpfhZmGyX+NAlQfPmTynktvQZHHhPkusDYo=;
 b=QDOj5bVfwk29flJLupKzSs9Mf8w5QFjEyWy4v2mAh7HmaDamSaFmGf9+ZHEKWbuHgU
 MIq4Aq0XWpiLs3CIe66Lndvxoq/PfBU4jke7iCZhPFOThdvjO29iqblQBolEkRZpdULF
 wvZzPHQgutZOTdpf82Xt2JrNN4SSSVlR0RVLb2N+sDT8zxla1UxyWJJ0QgKypA7q7DJz
 jcIlR5bICm1+K7Noj0vEsC/9k+wSYIem5rMSYtyBAFNiBNOQH8v2rUAaHqdUu6UFWeR0
 xcnKxuEahOoP9F8IezNnGwbldK8sTsNkhuGLKu9hOfZlw7LLqES/ufyLVwjaFnRsBYgA
 GtHw==
X-Gm-Message-State: AOJu0YzJYdwDyKTOkVkyzJe2l6nh/furtk8YfpDwHAtDCl88FaaB1M5B
 mIzq1JAp7zXh+O0yaT01gSGCCLM9GRcgnEccIMlxJvI6cGqbxTq7FlKggspgj01rZTDQKVjAs8l
 LyAo=
X-Gm-Gg: AfdE7cmsjC1z7AdFsXti/2mg7mrnRJtmplplWV+w8dLm1pv8+tpos6+I0u9clWhuwzV
 DWMMNjYPmxxs/eJqMnNXrhvbm9TK5l+w0f6SjG8dq6KGXoX1MDW+no9k2VjZJkEuuk6Cea8qBZI
 +qeMBwN+ToSdwYgWv9NsJg1+4VBu42rlFc3tPBzpRbPXptCrful4rGyKsCeLxIoCiHujPlCWTFO
 TpPPYjYy0m/MPDoVu5RRqk5OtHSxzIdc4GhtoDf9tZdvGzqycPbik02KZWRhBN66B+FkO5PD2nx
 8Lz90wTKiVjEcsN7ywOopJGdp4EazD+q9Jc4gQVV8JmSePOVqoMUpAYQ05pxgrHnaXlSpWC7N2T
 4WbrZrUQ4qAFYbgoa5Ous6+z7ZJonX/Kp0fIQXztPV4XCHTUjQXFcJQubSb2rjEiyluyoNShEqm
 Xx
X-Received: by 2002:a05:600c:5010:b0:493:72d3:4a81 with SMTP id
 5b1f17b1804b1-493c2b5161emr134908095e9.16.1783083607828; 
 Fri, 03 Jul 2026 06:00:07 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-493cce040b4sm64840515e9.10.2026.07.03.06.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 06:00:07 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri,  3 Jul 2026 12:59:29 +0000
Message-ID: <20260703125958.21260-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703015745.20728-1-wegao@suse.com>
References: <20260703015745.20728-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] statx/statx04: Skip vfat and exfat filesystems
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On newer kernels (v7.2-rc1+), vfat and exfat implement fileattr_get to
support reporting casefolding. This causes the FS_IOC_GETFLAGS ioctl to
return success, whereas on older kernels it returned ENOTTY.

Since FS_IOC_GETFLAGS succeeds, statx04 assumes standard writable inode
attributes (append, immutable, nodump) are supported on these
filesystems. However, they are not, causing the statx() attribute check
to fail with TFAIL.

This addresses the failures introduced by the following upstream Linux
kernel commits:
- 27e0b573dd4a ("exfat: Implement fileattr_get for case sensitivity")
- c92db2ca726f ("fat: Implement fileattr_get for case sensitivity")

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/statx/statx04.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index af30a200e..c029cd06e 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -47,6 +47,22 @@
  *
  *  mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs
  *
+ * vfat and exfat are skipped because they do not support standard writable
+ * attributes (append, immutable, nodump) even though newer kernels support
+ * casefolding which causes FS_IOC_GETFLAGS to succeed since the following commits:
+ *
+ *  commit 27e0b573dd4aa927670fbfd84732e569fde72078
+ *  Author: Chuck Lever <cel@kernel.org>
+ *  Date:   Thu May 7 04:52:57 2026 -0400
+ *
+ *  exfat: Implement fileattr_get for case sensitivity
+ *
+ *  commit c92db2ca726fe61a66580d30ecff8c192a791935
+ *  Author: Chuck Lever <cel@kernel.org>
+ *  Date:   Thu May 7 04:52:56 2026 -0400
+ *
+ *  fat: Implement fileattr_get for case sensitivity
+ *
  */
 
 #define _GNU_SOURCE
@@ -133,6 +149,8 @@ static struct tst_test test = {
 	.skip_filesystems = (const char *const[]) {
 		"fuse",
 		"ntfs",
+		"vfat",
+		"exfat",
 		NULL
 	},
 	.tags = (const struct tst_tag[]) {
@@ -141,6 +159,8 @@ static struct tst_test test = {
 		{"linux-git", "04a87e347282"},
 		{"linux-git", "5f955f26f3d4"},
 		{"linux-git", "e408e695f5f1"},
+		{"linux-git", "27e0b573dd4a"},
+		{"linux-git", "c92db2ca726f"},
 		{}
 	},
 };
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
