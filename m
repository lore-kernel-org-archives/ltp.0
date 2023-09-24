Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB25CE7A88
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 05:09:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14DCA3CBDDD
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 07:09:18 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 227753C9AC2
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 07:09:04 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E5631000D5E
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 07:08:59 +0200 (CEST)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ae18567f42so464924b6e.1
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 22:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695532138; x=1696136938; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iihM7fNHraKjWmXna1UvLf+5E692wDKvi6IGfIk1b2A=;
 b=DhuUyk3GPArDbPdI17SA4M/N85m+pC9u/c3WiVPt9yuCg1DkLUPgzMPXh6smw/Ps/m
 /tatsiDS7ZD3jvq8gBw0/JCbHUBqNP1N5hsR3zqdUstiuLYnq++XMAtE/kW38B9ogzwp
 YYLsWALCiYCui1V1KkfjdIjjRhL8S7l5lc+G2lgz1ikPHVGDJKSN1PgEPjpAqqG5McYC
 7DYOTe09P4x7nqgRI1Ua7p8VOKo3MnOKNkSL7+7SYAjTR4TT2oW0z1E6CEvh49RyhM8R
 IQvwe9z9fiU9Y9kLf9FyiGruQfar5KANM0SRigZRsivESHJ8vl0Y1MaNhnMuMZpvlVSV
 9AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695532138; x=1696136938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iihM7fNHraKjWmXna1UvLf+5E692wDKvi6IGfIk1b2A=;
 b=MDekDYW0NDijV6/Q2IykUZcUGGs5NEg5QzjtbM/HE94G94n4gaKOL6OBhGvmRf+bi7
 Ld8c+xGevp3l7PNUIM4cMpHYjr/BdnGnh1FqIvtjwqQrPYMHt7hAyDzgdOOYpHCADE8j
 TSKzTiLYd95Es9XJ0MKEvKE9fxxjAogXVG2Ve3bQLxz6EjQWQ0teoeHgP+qVxvyIIsFf
 ospt0/b6y2/SgtJTIdDZ+ycVHVyFQELl2un41Ge9pTwutq07f1/MXuI8E3KSPZg9TO/z
 8tZI9MUPckHlmfLK8ll40oqrzKzZMF66b/vrk7ZaYXvyY4vbzpVfhA7a8C6usgodrZ0v
 nF0Q==
X-Gm-Message-State: AOJu0YwFXMR8uSBO7bOPqs2mBLrloTDV7aq86AO4TQwY9HF38fUxTugM
 Zj6rFU1T+UkaZaPv6ASw1gM=
X-Google-Smtp-Source: AGHT+IEWXTeY45Kdzy/4A5emiEePpYA2DmqOJKpzmWxay/53yMaIrDRx8U2UFxT52j4G3C6Eq9gUjw==
X-Received: by 2002:a05:6870:c105:b0:1d6:790f:2007 with SMTP id
 f5-20020a056870c10500b001d6790f2007mr3151863oad.4.1695532138132; 
 Sat, 23 Sep 2023 22:08:58 -0700 (PDT)
Received: from node202.. ([209.16.91.231]) by smtp.gmail.com with ESMTPSA id
 dk7-20020a0568303b0700b006b96aee5195sm1350018otb.11.2023.09.23.22.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 22:08:57 -0700 (PDT)
From: Reuben Hawkins <reubenhwk@gmail.com>
To: amir73il@gmail.com
Date: Sun, 24 Sep 2023 00:08:46 -0500
Message-Id: <20230924050846.2263-1-reubenhwk@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, willy@infradead.org, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
 Reuben Hawkins <reubenhwk@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Readahead was factored to call generic_fadvise.  That refactor added an S_ISREG
restriction which broke readahead on block devices.

This change swaps out the existing restrictions with an FMODE_LSEEK check to
fix block device readahead.

The readahead01.c and readahead02.c tests pass in ltp/testcases/...

Fixes: 3d8f7615319b ("vfs: implement readahead(2) using POSIX_FADV_WILLNEED")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Reuben Hawkins <reubenhwk@gmail.com>
---
 mm/readahead.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index e815c114de21..0ff6fffe3c84 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -734,8 +734,7 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 * on this file, then we must return -EINVAL.
 	 */
 	ret = -EINVAL;
-	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	if (!(f.file->f_mode & FMODE_LSEEK))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
