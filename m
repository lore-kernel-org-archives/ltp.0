Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94525C61DE2
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 08:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788165951; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HL12i5PE+nhU8tHLu/U9V6BT/bev/mNBnTirvENWTio=;
 b=W6uojFUdd4ojoy+gQU7OwQPf5nqZwsE7y5FBut6kRXIdkGve0StoM6fZHiBfpAzT3HYKB
 urta0KnbxH5ZX5eXunNu8Tqb8cf8InK5QFBGmNliR8vUtJnbvO3Vw6E2rWPKkcvPbA9Kbm2
 xscCGAzflMqjNkGr7FDoRqk2yFfTdZw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 887A83E9477
	for <ltp@archiver.kernel.org>; Mon, 31 Aug 2026 10:45:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A83B43E1620
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:45:31 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1D1D22005DB
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 10:45:30 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-495590dde14so30599715e9.0
 for <ltp@lists.linux.it>; Mon, 31 Aug 2026 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788165930; x=1788770730; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1wWgRaz9vb88f0IG2fCejhPqSmbvlmU/tbtVq3K3B+o=;
 b=GnAHGFXHDnd9G0g2QgmhrmIBrpYRFf5ozw4V6JkCTVmSseE+KiPG8rzXhYBgA7zqot
 8Mwz6SzOoamJXipqcxch01s5fnQFjSOLs3gN4ajCBoBp28HRnki6UVlvh2esvRPqJ3de
 fZtmgzgjpM5RQqQA4K50v46r850AHBvWlign8jw/7PjQG7KT28QM1JvN8FHNe9D/IvhY
 G3/A4XyHdiNMa3XRrEJDBubwdVk8exge1VKIquOaPd82astv+pxsOggzDrImZFZkscZd
 EoKKk+xFMxmJtKJicm28tBbnGj0WCwI1ArFvku8Tzlbf2GWymtN9FDnzTYwcayB3kfRO
 kjZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788165930; x=1788770730;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1wWgRaz9vb88f0IG2fCejhPqSmbvlmU/tbtVq3K3B+o=;
 b=BAGotsBQguc03knWBIAOewArMPsFv3jzAFC1Nt7vEbG8Zz5ie5zccXOYfIhDvGVOUl
 HUFRq7y2qXttX+ZL6iHQ2xwJo3qNpvkCiyLrzNNDQBP/WYw+xcKz+eMAo461Dyn6pFI1
 B7VDh5iABkF2a2DbmCbTKVFuk2ZvJCRbddjRdA8AAMh0CiS0pYVNXb0SASBT9f53mWNJ
 xmfq92UkYHn7iVuHxKyYtnlEOxb4E4U2OMr02osAlFIacRNORAL7yItBROqzhL90sn87
 nPF0DQ06t1/q+7MIwmGKLNvExIGkNXL6J5mTdgxd4KpvLQkhwpqP7mpCA9DqDW3rcv1/
 /now==
X-Gm-Message-State: AFuF++nIZQ/uGuFxCVSlgPZFdD392k/RkqN9dS2XONlI4aMX3ffQgSG9
 XVezXD4+o9jfXSSCdEAoPf5iFKDqUP+cgQcJCGLIXVlZWb9gK2MqrBSqips0dt7xB/VDCObjcbN
 WuypgyvfXKA==
X-Gm-Gg: AR+sD10X1s0SeeTdRcGTLuNn10vh41Zk0AuwaR4vpf6D5D3qEKJQUyEN2zoKJlXzWly
 PllCTzIGoult88Ij50N+npSX0d35ore7YMAB2MvwvpE3er4Zy0dIuUcaf/p6cy86AO6fhM9Mwc+
 8JTU7Kecycy4J1yZAx+23CUqZDH9xxYO9TVW6oXtvQIrnnUKjlaaV1mhdruFL2twNTP/U4nPzEn
 LbaZqteBO+cXrg9wcV/ZLJDHB60B5XChnaKKa+0suTx9C9tj/JgzUkosiyCfm2jMWtQvEMsKAuK
 729G3UNOU/I7CWcqRatqeY2JDiCiLdLwEvoFlJqSyEJniULEKASiDbUfomuwZO85qEvIF2PZF+N
 J8p4Fy5hNQgOBI5XP3VHypwGQw6jcZ7HyaTpcUI1THjsjvOr6gPwss3imr5LkfLVp938sIrFe+5
 oACoG6Qi9sta/HtaYPlFtwGsZ0CQGC8zaXz1K2nPv37ydS+1vHeM+tassE1BRXqUIgJoQovRrru
 fYz68NMYJYYH93AhZxNxOcmKqxtHd1y3I0hAkbuEuMOBWlLJt7U4Ygnn+tj7F1DiupAmL8A
X-Received: by 2002:a05:600c:3f07:b0:49b:8c63:dfdf with SMTP id
 5b1f17b1804b1-49cd94845demr32532105e9.15.1788165930150; 
 Mon, 31 Aug 2026 01:45:30 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c321184sm422389065e9.11.2026.08.31.01.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:45:29 -0700 (PDT)
Message-ID: <6a953f29.55a5960c.18cfbe.85e5@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260828114100.2356329-1-wakel@google.com>
Date: Mon, 31 Aug 2026 08:45:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode01: Increase dev_min_size to prevent ENOSPC
 on exfat
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wake,

the agent couldn't complete because patch didn't apply, so I will
send you the complete review from a local instance.

On Aug 31, 2026, Wake Liu wrote:
> inode01: Increase dev_min_size to prevent ENOSPC on exfat

> On exfat, each file and directory occupies at least one cluster (default
> 32 KB for volumes > 256 MB), which requires ~350 MB of data clusters.

The test does not let mkfs.exfat pick the default cluster size. Master
already forces 4 KB:

	.filesystems = (struct tst_fs[]) {
		{.type = "exfat", .mkfs_opts = (const char *const[]) {"-c", "4K", NULL}},
		{}
	},

That comes from 4bf4da8c6fda ("inode01: Configure 4KB cluster size on
exfat to prevent ENOSPC"), merged on 2026-08-13, which targets this
exact ENOSPC.

So the "default 32 KB" premise does not hold here and the ~350 MB figure
does not follow.

> The parallel scenario concurrently spawns multiple workers (default 5),
> each creating 2,185 files and directories, totaling 10,925 objects.

The object count matches. With depth=6 fanout=6 each level creates 3
dirs and 3 files, and the 3 dirs recurse, giving 2184 objects plus the
per-worker root created at inode01.c:214, so 2185 per worker and 10925
in total.

But at the 4 KB cluster size actually in use that is ~43 MB, not
~350 MB. Each file holds repetitions=8 records of strlen(path) bytes
(inode01.c:60-61), well under one cluster, and each directory holds only
6 entries, so every object costs exactly one cluster.

512 MB leaves roughly an order of magnitude of headroom.

>   inode01.c:61: TBROK: write(3,...) failed: ENOSPC (28)
>   inode01.c:64: TBROK: mkdir(...) failed: ENOSPC (28)

This is the same file and the same two line numbers as the log already
quoted in ecf418722780. Was this reproduced on a tree that contains
4bf4da8c6fda?

If the failure is still real there, the numbers above say the cause is
not the cluster size, and doubling the device would hide it rather than
fix it. Could a fresh log be posted together with the geometry mkfs.exfat
actually produced (its output, or dumpexfat on the formatted device)?

> -	.dev_min_size = 512,
> +	.dev_min_size = 1024,

dev_min_size is not only the loop device size. With .all_filesystems = 1
tmpfs is also exercised (lib/tst_supported_fs_types.c:34), and the tmpfs
mount is sized from it (lib/tst_test.c:1246-1268):

	if (!tst_test->dev_min_size)
		tmpfs_size = 32;
	else
		tmpfs_size = tdev.size;

	if ((tst_available_mem() / 1024) < (tmpfs_size * 2))
		tst_brk(TCONF, "No enough memory for tmpfs use");

tdev.size is the acquired device size (lib/tst_test.c:1573), so this
raises the available-memory requirement from 1 GB to 2 GB.

That tst_brk() runs inside prepare_device(), which run_tcase_on_fs()
calls in the parent before fork_testrun() (lib/tst_test.c:1984-1997), so
it aborts the whole run rather than skipping the tmpfs pass.

There is no per-filesystem way out either: dev_min_size is global, and
struct tst_fs.mkfs_size_opt can only limit a filesystem below the device
size (include/tst_test.h:267-270).

Given the ~43 MB actual footprint, is this cost intended?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
