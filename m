Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC52D7831F
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733146334; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=8KM831GEFJNxHvol7WjVd4Y60DhlocTuBV/e0jXgV2Y=;
 b=gPn0KqOVKSFZbauuxdpLXXDpT7fYC7NQJn+B9GllIzJFitDUWcKwyJKFAEPY4Dw/2kDGe
 mzmZONT9KATBGVnrKLOUX+weZ/lKy655Gwa5/ZbyXCSWxqUSvqgJvZ1TMeXbqb756oS9voe
 XsAXCGMLfIh+zzMhkvyI+IRwWdXPU3c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 579D93DD467
	for <ltp@archiver.kernel.org>; Mon,  2 Dec 2024 14:32:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 907353DC586
 for <ltp@lists.linux.it>; Sun,  1 Dec 2024 10:36:14 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=zlang@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EBCF5619DD3
 for <ltp@lists.linux.it>; Sun,  1 Dec 2024 10:36:13 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 56BA85C5E99;
 Sun,  1 Dec 2024 09:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12837C4CECF;
 Sun,  1 Dec 2024 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733045770;
 bh=lB+n7whgH/n5VB95xkecNn+qN4Edltxk65mTNO9GcuQ=;
 h=From:To:Cc:Subject:Date:From;
 b=KMIwFkPMQ8zslzNAOc+6wPRDEKsOAEwMeuMFKRB2ycGuUyEoypVY8My6wd1fjcKxB
 k+U6n3keJvW7n3YGyE5FJKiZ+LiYa6sFhmkU/BeiLL4reMqw7P5zU0KUU8FbVJCCHV
 pY/aNqz3d8LZHGqq/14SsRuMnd/c90Wou41tYmgVy7FyBp/Yl3RXLs70giwZ2ivDmo
 0MMdkeveCv2SMbMww5ZqhpkS+S6jqJ3HZPNTfR913KLwxzxJ+kW8rmTBt3mcpzEwHA
 gyROky50Efez7rkrXf9mtv/X1+83Bua9MkRNq0Ns760ixvQnY+/WB2s29PdU6D9omn
 NAOZJFOEu4N5Q==
To: ltp@lists.linux.it
Date: Sun,  1 Dec 2024 17:36:03 +0800
Message-ID: <20241201093606.68993-1-zlang@kernel.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 02 Dec 2024 14:31:52 +0100
Subject: [LTP] [PATCH 0/3] LTP random fixes for xfs and btrfs
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

[PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero

  It doesn't skip filesystems as its plan, fix it.

[PATCH 2/3] stat04+lstat03: fix bad blocksize mkfs option for xfs

  mkfs.xfs doesn't support "-b 1024", needs "-b size=1024"

[PATCH 3/3] stat04+lstat03: skip test on btrfs

  The "-b" option of mkfs.btrfs isn't a blocksize option, there's not blocksize
  option in mkfs.btrfs. So I'd like to skip this test for btrfs. But I'm not
  sure if there's better way, so CC *btrfs list* to get more review points for
  that.
  (BTW, better to have a common helper to deal with different filesystems'
   blocksize options in the future)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
