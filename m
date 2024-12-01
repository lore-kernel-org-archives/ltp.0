Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9F8D7831E
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733146357; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xMtU5hDTvHyY2hB4TmsmjHvZUqL3JB8x0Rd2ziqEaxs=;
 b=PhEhdv70aAeS/4SEjK8ifpKFLqzy+RDgWiMup+iaUCL+ydW4rYk11ymC9PzeOx7CAoNMa
 Ml5HpuOiCXZTjuJyiQ8xKv2WZDnWC6eW7uylk2MGPNMX0I964zmj7yx0eFXg+YxxW4Dw/kT
 yLU3Ds7u+UHHkXT3JIITm4Dq+8ZLr8o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 135003DD45F
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:32:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D26093DC5B7
 for <ltp@lists.linux.it>; Sun,  1 Dec 2024 10:36:14 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=zlang@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EDE2B1017B48
 for <ltp@lists.linux.it>; Sun,  1 Dec 2024 10:36:13 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id F3E875C5EA2;
 Sun,  1 Dec 2024 09:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA46C4CED2;
 Sun,  1 Dec 2024 09:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733045771;
 bh=IE4LAlT4CHnSy+VJG/nkGoQkCvxrzBq1C5OtbyvYSR0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CvH3dTFNIul33BtAeIOy/ThatctQznqEhgqDCwzANcySa2Km66nN3B1uc0YB13i9F
 KJDAzR8vb3JTTjph7l5nHgXsqzsxlxM056XbQrlhjn8XwL3KsySKYNui2w95XSSPJU
 GWjOpL4JC6f/p00TFYf56kH+PtynZf2hQRMAUZ59QcFWWiW70ZZQZV6yzn6/6O4vQC
 ioiCn7ch5lzdHJIwXamM/SFNfd4J08CMtKUH3AZN9zteMaq8ux/+Bt4u+g7358+FVp
 13VlsOu1oiu3ETMC69YevbcabMRVtRxw0MGZ6E476yIly58S9HlQHEGPYxqeOuXkIK
 PWt6zOL56yyTQ==
To: ltp@lists.linux.it
Date: Sun,  1 Dec 2024 17:36:04 +0800
Message-ID: <20241201093606.68993-2-zlang@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201093606.68993-1-zlang@kernel.org>
References: <20241201093606.68993-1-zlang@kernel.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 02 Dec 2024 14:31:52 +0100
Subject: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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
From: Zorro Lang via ltp <ltp@lists.linux.it>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test need to skip test known filesystems, but according to below
code logic (in lib/tst_test.c):

  if (!tst_test->all_filesystems && tst_test->skip_filesystems) {
        long fs_type = tst_fs_type(".");
        const char *fs_name = tst_fs_type_name(fs_type);

        if (tst_fs_in_skiplist(fs_name, tst_test->skip_filesystems)) {
            tst_brk(TCONF, "%s is not supported by the test",
            fs_name);
        }

        tst_res(TINFO, "%s is supported by the test", fs_name);
  }

if all_filesystems is 1, the skip_filesystems doesn't work. So set
all_filesystems to 0.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
index fab0daaee..b7f676ec7 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone02.c
@@ -57,7 +57,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
-	.all_filesystems = 1,
+	.all_filesystems = 0,
 	.skip_filesystems = (const char *[]) {
 		"bcachefs",
 		"btrfs",
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
