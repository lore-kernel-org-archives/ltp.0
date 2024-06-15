Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AC6C27C4F
	for <ltp@archiver.kernel.org>; Sat, 15 Jun 2024 05:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DC493D0CF6
	for <ltp@archiver.kernel.org>; Sat, 15 Jun 2024 07:36:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57FA83C0326
 for <ltp@lists.linux.it>; Sat, 15 Jun 2024 07:35:58 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 45F7360FB4D
 for <ltp@lists.linux.it>; Sat, 15 Jun 2024 07:35:56 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9184C602C3;
 Sat, 15 Jun 2024 05:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818CBC116B1;
 Sat, 15 Jun 2024 05:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718429752;
 bh=jxLbk5ssxSIp8RBgGpLgzWuKu/Z2z1NW57KUbzwdFn8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pKttWYCN/pUPUveq/A1j08MIgS3wbfwxlzfOxUxEVLMOxU9ArsfpifapFYgSvrBtr
 HRpxilA9p2X7UPjn2xHc4YNTFdpu1cXGL9R4paW9ZmjApMSqFspVIsARYQXXGgeFjD
 1TfKi6mjQ4BBO1N0yuMzNn1ynyvUfYhM1iVMWDIS55aTh9EdinvuV4SOedq7AtMCLO
 aI+8SM3iDTJl9f4bB/Csv2NzD1SbreI0IyL3tBGOEh6F3m2osFCXA6rsYq551T9d6I
 /qUSQIBUrrcUujoicn4KTFkde/PDSDC/RFaKX2XpebKCVGpD5Pn9SGZyBjxVwuZ3j/
 bonNOOCi0t8DA==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Date: Sat, 15 Jun 2024 07:35:42 +0200
Message-ID: <20240615-fahrrad-bauordnung-a349bacd8c82@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <171817619547.14261.975798725161704336@noble.neil.brown.name>
References: <171817619547.14261.975798725161704336@noble.neil.brown.name>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jxLbk5ssxSIp8RBgGpLgzWuKu/Z2z1NW57KUbzwdFn8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTlaui7Z7UWvdDqnn7iRLrEn1dzbBaeiVge9D192wPPy
 fVzijicO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYydSrDH9570xOtKlkXiOwL
 mHbwo05CvMfuWI3PW2YeubAwTSzDnZPhf1r6ll/vNNsKE9673tk2Z9mlrZp11rOebCysPOthWhU
 cyw4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-nfs@vger.kernel.org, ltp@lists.linux.it,
 Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 12 Jun 2024 17:09:55 +1000, NeilBrown wrote:
> When a file is opened and created with open(..., O_CREAT) we get
> both the CREATE and OPEN fsnotify events and would expect them in that
> order.   For most filesystems we get them in that order because
> open_last_lookups() calls fsnofify_create() and then do_open() (from
> path_openat()) calls vfs_open()->do_dentry_open() which calls
> fsnotify_open().
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
      https://git.kernel.org/vfs/vfs/c/7536b2f06724

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
