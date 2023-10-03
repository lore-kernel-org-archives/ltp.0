Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C50E7AD41
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 13:22:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A51B3CBA0D
	for <ltp@archiver.kernel.org>; Tue,  3 Oct 2023 15:22:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E1693CBA0D
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 15:22:28 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2DAF4200227
 for <ltp@lists.linux.it>; Tue,  3 Oct 2023 15:22:26 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A73EB6121F;
 Tue,  3 Oct 2023 13:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DC5C433C7;
 Tue,  3 Oct 2023 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696339344;
 bh=4HJ4lXE/gn+p/GC4BBOANqh3Tq17/zOiY/nqfu3N/6k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gYm+00vHtYYsOzjxMEN31pv5biGQGFgdy9kZQ4SIrfILcdj12L49OMRHb65vM0R9K
 G4IAyXyzOMcB+N8VHE6potlovixV/fXKezOEqf+9kxoJB9N2LelIr+3HXCnaYZiHby
 N+seD1jPInhKK3f6DpaUx7g+UMQYYEoMzTejIlFGFvcFdx4BFEQRyYuT9rlJdf+JXs
 UA17Ycft9hXLUmPYFJwZjnt/e02+dsIPUA91GyMF/4ZqMSyPJxQUhpZzdJ88gYguuY
 klo386RCZAkQVKXpiEBwHD2e0y8KMZ109amfC2/NtAl+F4hlQiSFW0BoIb2QkxCErC
 eDDeFpiYBlSnQ==
From: Christian Brauner <brauner@kernel.org>
To: amir73il@gmail.com,
	Reuben Hawkins <reubenhwk@gmail.com>
Date: Tue,  3 Oct 2023 15:22:16 +0200
Message-Id: <20231003-weglassen-anlassen-e42c8cc2db9a@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003015704.2415-1-reubenhwk@gmail.com>
References: <20231003015704.2415-1-reubenhwk@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1220; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4HJ4lXE/gn+p/GC4BBOANqh3Tq17/zOiY/nqfu3N/6k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTKiDZbBzyNnBxbuIdFoTn7tvbd0O29u9l1Zvy7+E/S6ctp
 3+OTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbidoCRoeN64Tdt5p/nKzIVT0gG2l
 maepUw1nVu3XHGassLlbNXDjIyLFitNl8j6JPXs2mPguzf3N3nU2Tn8rFq39fEtHXbas/e5wYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 willy@infradead.org, oe-lkp@lists.linux.dev, oliver.sang@intel.com,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 02 Oct 2023 20:57:04 -0500, Reuben Hawkins wrote:
> Readahead was factored to call generic_fadvise.  That refactor added an
> S_ISREG restriction which broke readahead on block devices.
> 
> In addition to S_ISREG, this change checks S_ISBLK to fix block device
> readahead.  There is no change in behavior with any file type besides block
> devices in this change.
> 
> [...]

On vacation so just picking up smaller (hopefully obvious) stuff.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/1] vfs: fix readahead(2) on block devices
      https://git.kernel.org/vfs/vfs/c/165bb7140aa4

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
