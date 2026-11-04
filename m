Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5813606A31B
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=TR0gwLxZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=tLo5205y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793790066; h=message-id :
 to : date : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=RRqLqhVxM1vP+qqN96TecSZAAJqbPxzaj7wIMFan1rA=;
 b=TR0gwLxZJN8oyEXKxbCoNYMPDJjAcC0ZnZA8vf5tLz4BNQ4u5XG960GSuoKElpIHTUR5E
 /d3d3jAaXq6/MD/b+nU0IZn4yX91SVrO/m2OUew2qdUeT4S2YG+nvr4PrFZbCL/uxdPpqnG
 qTkxYFEP1DugUM5BvuQT3Kt4IE+Cvp0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81CC73CB757
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 12:01:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 835C83C99C5
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:00:29 +0100 (CET)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B34F6140042D
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:00:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793790023; bh=XK8bfT83G0BiS1w9ON8KVC8+Q1v0DPrHGhWC3B0+QA0=;
 h=From:To:Cc:Subject:Date;
 b=tLo5205yyB/OVkHaKeux1sZyTA0zNYhltm6Bw6fQrVQVvj9adwHgVFT3LfKbcybHG
 llleX3vP6M3RfDJJ1OHEYxfkHnsRnQrgHeT9bj0oMCwcjkDCQxMH4UH3Lc3E0iPo4/
 //Ue7dlvo4Cpeml39yEAtHk2jmAM1Ruz74lmwZ7g=
Received: from LAPTOP-KQCD4QBN.localdomain ([123.121.145.87])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 15B4472; Wed, 04 Nov 2026 19:00:21 +0800
X-QQ-mid: xmsmtpt1793790021tqz1ckenm
Message-ID: <tencent_E68267738B880AA1228A6E2F44F355AD0B07@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLc91pBua2KR7lVv5Ihi+H2cP7PpxuKarLq3ZoC+tttTMbhAs8+3
 z407M6EwHP8vXAPeVGmREtnHrAoqS7j0quNQOiM+v7REn0E05pj+A3uA8OFD7RSypdQpPeGDeMQW
 aoghhgsT3kmVp7PWt/d6YKUx8QvAzAUrqpKzlG+5BJqVAUQfGumGdJklLguJmj4eXxGAiZDspaRx
 hrfA8oM9qijs3bVPPYUcv0RT6BDygRZFZ6sQhLt/c7VqJBmHuOaEpVq6ipUYPY5HjiPvmusjvk3N
 W/K3WFsZUaaLV4bGIwb44uBsbO3dc3P9s2zR5E4AnS5X2F6cn3xt9JgoZ/IL7Y0eBESi1DhyY7gi
 pWpA8MYYDt3JBgTYHBqb8aKdW/TbdKfwh9qiyyl307VVQ5sg76AqZ6AoNPzu0Yd2XU1KT/7zCxkX
 r4bgQGdBgZ6YpZtuI+9j4HePnMVDvWu8Y1HTAxU+pNPVPAEcfUebGXb3hqUKN4RSUGmg5njRkr+z
 2HdeDyCQRBMu/KAWCjNjzMsp3nd9HQWvVaNEkq2tEhubFyUvh23dbF9HIfrBasBlA6JgM68xxU84
 TQDg5/Mb3jEc1H6Bd30yiUkEqzur61yc9PJlxc/DG/ArhcijDy65gzPlYTj03EMFSRAxakgiJXZB
 yfqs936CpJRHy9bLJKleoCyPoXDDz5XwFosQugGAoKSHRPUPKBtV+HwK1im5xwHaPoHKgegyIJR2
 zJNxuD/WYzNDwtLl+KEQITz4wjMjOfdsP312IZozJCvCbTa8+9StHU4gnohaA0K9RI7vtTqD4s0X
 BqlhbsuTUiku/orzxuLv0hLJPtsOiHu8Ta3RQJIpU9hpm/bV02l0ZY9p6vGXMfYiz3BXnkFhJE3V
 kxyyrP4K0GZyc3lsVxIy5Xc1HKFAXTAe2MMY0J4stquoESPAOKv1kd7CHHswzLV6ghapPZeefWxU
 W5X4Ad0AW/Cy5Tvd/IBbHBHVzr+8TUEbJiN8WCmgR4RYIue/VpbJnoRXxjVDG6LrUVXA3riO/yeo
 caWf/UbHC1Poa5v6uoZdfkvO0qW6pwoqjFhQRlGqTMC8GjyHvMwwlYG2F8gT4jsbejGfW3PQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 19:00:19 +0800
X-OQ-MSGID: <20261104110021.7870-1-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_REPLYTO_END_DIGIT,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Harden safe_sysconf() and add madvise13
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wenyuan Li via ltp <ltp@lists.linux.it>
Reply-To: Wenyuan Li <2063309626@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is v2 of the RFC that adds a madvise() test covering MADV_DONTNEED
across an unmapped hole.

I split this into two patches: the first tightens safe_sysconf() as
suggested, the second adds madvise13. I can squash them if you prefer a
single patch.

The library change affects every SAFE_SYSCONF() caller, so keeping it in
its own patch makes the blast radius visible and makes it easy to review,
bisect or revert independently. Patch 2/2 depends on 1/2.

Changes in v2 (addressing Cyril Hrubis' review):
- lib: move the page size validation into safe_sysconf(), reject values
  below -1, and for _SC_PAGESIZE also reject -1 without errno, zero and
  non-power-of-two values; leave the generic -1 && !errno path unchanged
- split the check helpers into page_mapped()/page_first_mismatch() and
  keep TPASS/TFAIL in run()
- drop the MADV_NOHUGEPAGE call
- rename the local range macros to RANGE_FIRST/RANGE_LAST/RANGE_PAGES to
  avoid confusion with MADV_* advice constants
- rebase on current master (d9add0a9a)

Verified on x86_64, 4096-byte pages, kernel 6.18.54.1 (WSL2): lib and
madvise13 build cleanly, madvise13 reports 18 TPASS / 0 failed and 36
TPASS with -i 2. git diff --check passes.

Link: https://lore.kernel.org/ltp/tencent_B786C5458553D16AB70F62E3AAC3C5C9B306@qq.com

Wenyuan Li (2):
  lib: Validate sysconf() return values in the safe wrapper
  syscalls/madvise13: Check MADV_DONTNEED across an unmapped hole

 lib/safe_macros.c                             |  20 +++
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/madvise/.gitignore  |   1 +
 testcases/kernel/syscalls/madvise/madvise13.c | 154 ++++++++++++++++++
 4 files changed, 176 insertions(+)
 create mode 100644 testcases/kernel/syscalls/madvise/madvise13.c

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
