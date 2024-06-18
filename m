Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7AFC27C4F
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 14:28:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4A823D0D7D
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 16:28:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE56E3CE19A
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 16:28:14 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=brauner@kernel.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B3D231000BC6
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 16:28:13 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5B708CE1A7E;
 Tue, 18 Jun 2024 14:28:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E02C4AF48;
 Tue, 18 Jun 2024 14:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718720889;
 bh=Tvh4hB5cyhfUoWV+w/CwDW/s35vlDm+9FWKgwonoTug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dKgSBSaoQFby1RLs8vJoGD3tvLVQFetZ88877MWwWI2J5G4Np0wHCoAd2xh94Djrr
 IZbaLRIZ9/JvcSGgwxrmnoCkMGmmeG7REBAQWQKUzTNCTNJ0EqdUqI6m3ij63Cr/D8
 TG+58ieBAHONiwJJG2qH1VobC+bDyR3Pk1j5yYbXU5zZC+NtfQg6WY0V2Ii1jahx0G
 7T6pxhFG39+CNNT60Jst7rD4okCHtrMjaUcyhcIr4DWJumC/Sa0VqpnID3N/7Uucol
 Pa+4UVSHInZo+vGQGJxWcNCFkNtcMBEP0+6sbS4tpMVBg9XNIfGWPoLa+j8o7Up4jY
 dHcIDL7w4pX6Q==
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Date: Tue, 18 Jun 2024 16:28:01 +0200
Message-ID: <20240618-modular-galaabend-c0dba5521bc4@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617162303.1596-1-jack@suse.cz>
References: <20240617161828.6718-1-jack@suse.cz>
 <20240617162303.1596-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Tvh4hB5cyhfUoWV+w/CwDW/s35vlDm+9FWKgwonoTug=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQVziw0EtThc9yhHjBVc8nF/wIBweu/TvnxQdrpEWP+m
 VfqqX3rOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACayq4aR4eS+tjbZzeycTZGz
 ZR+frL35eMNW07C58YqTY7pvf2cN+M/w33+7q+KDE3+svMtPqL3+XuyWLXXSgulhYrpj6qtivrk
 V/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] fsnotify: Do not generate events for O_PATH
 file descriptors
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
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neilb@suse.de>,
 linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it,
 Al Viro <viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, 17 Jun 2024 18:23:00 +0200, Jan Kara wrote:
> Currently we will not generate FS_OPEN events for O_PATH file
> descriptors but we will generate FS_CLOSE events for them. This is
> asymmetry is confusing. Arguably no fsnotify events should be generated
> for O_PATH file descriptors as they cannot be used to access or modify
> file content, they are just convenient handles to file objects like
> paths. So fix the asymmetry by stopping to generate FS_CLOSE for O_PATH
> file descriptors.
> 
> [...]

I added a Cc stable to the first patch because this seems like a bugfix
per the mail discussion.

---

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

[1/2] fsnotify: Do not generate events for O_PATH file descriptors
      https://git.kernel.org/vfs/vfs/c/702eb71fd650
[2/2] vfs: generate FS_CREATE before FS_OPEN when ->atomic_open used.
      https://git.kernel.org/vfs/vfs/c/7d1cf5e624ef

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
