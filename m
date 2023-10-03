Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB79E776F0
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 01:57:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A8B83CDE22
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 03:57:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BDE83CD759
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 03:57:11 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55362100076A
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 03:57:11 +0200 (CEST)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1dd22266f51so82066fac.0
 for <ltp@lists.linux.it>; Mon, 02 Oct 2023 18:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696298230; x=1696903030; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O00OPeBX0OAQavpWTikv1KaJprJXcYLW3QJEgWJmVgY=;
 b=BEjW+WMEwsTb+3w87J9o/MXdLwNruroIhOSlRBq/UfZ099bjxLqoKmh+POa3e/9TBu
 gBJr2XlIl3Jd9/w5Uz1xIgI9NzJOqHHhCPUhZYbKssuDdwz2tmy+JaQISqeaPzqUVV3L
 hQYedCwY8Zz15zYlG4NGLR5CuwN1QmN+9BWGofB/eAZ1RqEVdDRqPRWnHAk8qb/umkWj
 Ed2tSlMcNXk5T5nWHQSMex45MVV5755Pfz0TC01uHIUM/gzA/wBxYpnHLHkvGdPhT36c
 sDV9d8l//GuHXhiYkjtjF5oKObkN/AwYNOW1JtgeHHUVSgpJS8kAJqe52fAdZ/fOOH3q
 zyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696298230; x=1696903030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O00OPeBX0OAQavpWTikv1KaJprJXcYLW3QJEgWJmVgY=;
 b=Onw2kJDi86c7u+J1obQRUBBoTnDh+dgd35Y6DMbMSZBO7ivmQdqDLYYm1syurwp7vl
 0JEUVd+SXpPG2jsQhDLof7IXiieVMae6RzF3NI22rM7IlISnlRRsUHQ2310XB7BzAaWE
 taqQLOWAXsj40Q6To7RIRR6P+pFWWIlExvsRPeSfKfqs4WOXj/c2wPxKoajDtdyF2Wty
 47ZyqN87dvoc0GTigUD/iDJXyh/d2t0TDwUEE9qaXieqoaNzPLrpdbzmztWzn5RnnUnh
 47ezksuIj6Feh1ZVrx0+JrHXvO7Kv/6To8a7xN+00FiM0ygfbnyEfymyLJR1OpeVS14N
 UTpQ==
X-Gm-Message-State: AOJu0YzB5ZA7RoxUMXWffJvsM1mOKeysa6kxfgSsForNj/4LVqdGXP35
 3X3h+x3OuzxzQyX9pJsGc74=
X-Google-Smtp-Source: AGHT+IGMJhd67lE+Kn9AwqiETrIu/sIPojytQz9RjEUQ8PA8jl9s9zZ3r6SHYmG4F1v3iGBhsR75mg==
X-Received: by 2002:a05:6870:9707:b0:1d5:f814:56a3 with SMTP id
 n7-20020a056870970700b001d5f81456a3mr15700234oaq.2.1696298229848; 
 Mon, 02 Oct 2023 18:57:09 -0700 (PDT)
Received: from node202.. ([209.16.91.231]) by smtp.gmail.com with ESMTPSA id
 f22-20020a9d7b56000000b006b9443ce478sm22803oto.27.2023.10.02.18.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 18:57:09 -0700 (PDT)
From: Reuben Hawkins <reubenhwk@gmail.com>
To: amir73il@gmail.com
Date: Mon,  2 Oct 2023 20:57:04 -0500
Message-Id: <20231003015704.2415-1-reubenhwk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 oe-lkp@lists.linux.dev, oliver.sang@intel.com, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Reuben Hawkins <reubenhwk@gmail.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Readahead was factored to call generic_fadvise.  That refactor added an
S_ISREG restriction which broke readahead on block devices.

In addition to S_ISREG, this change checks S_ISBLK to fix block device
readahead.  There is no change in behavior with any file type besides block
devices in this change.

Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNEED")
Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 mm/readahead.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e815c114de21..6925e6959fd3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -735,7 +735,8 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 */
 	ret = -EINVAL;
 	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	    (!S_ISREG(file_inode(f.file)->i_mode) &&
+	    !S_ISBLK(file_inode(f.file)->i_mode)))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
