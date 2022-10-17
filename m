Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C5AC433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 10:49:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3175F3CAFEA
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 12:49:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA49D3CAD6A
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 12:49:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5D9986006F5
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 12:49:17 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 13F0F6102D;
 Mon, 17 Oct 2022 10:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBF9C433C1;
 Mon, 17 Oct 2022 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666003754;
 bh=hE1O72YfBfVtyXUSVk937ndAupFCSM8WNCJ0WPRvyV4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FReNFLZRWqyKX/BECMf5L8XNmowYwy9LcR6zYNEK8YYio8g+ul+eS2cydom0UhZ96
 rumlEyELzsxhd5EP8qM2or8hy9bSMFP7TtjuNX4C3xuvrNbANgCprNx7zBluw9DEzZ
 8FdWibrjEaP3SLpxmyBPrUK/DGjVoW4YRm6m5+n/zllnPXw6y4s5haAIPdHBgSGw7U
 LFN4oV16kk9aaP8pAldZilZf/7GFpRoDYkZLUFJPEdocBeacE8j3i2uoKnJW//owUN
 E6WxhSA/GAXW2QN3GScplft7ocRrUngWUD+fff6dJ+qDlVMByB/fy13zHVEiHETyc8
 +hv+Pf+XT5SFA==
Date: Mon, 17 Oct 2022 12:49:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20221017104910.owc6adviigultcmg@wittgenstein>
References: <1665996599-6420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1665996599-6420-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1665996599-6420-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 17, 2022 at 04:49:59PM +0800, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

The test logic looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

Thanks for writing all these tests, Yang.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
