Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCD6C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 15:15:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B20D73C927D
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 16:15:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C78413C2BA4
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 16:14:51 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D25906010A9
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 16:14:50 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4972C61947;
 Wed, 22 Dec 2021 15:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F409C36AE5;
 Wed, 22 Dec 2021 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640186086;
 bh=nUjCwmf8SSNTMrQzrlXBhIUByzrrLSrL9RF1vc6ABZI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Qg2YDKXd4x4ayyEcBa8Yk+IfpuFrlCaR/yYgFhQoa6/3ivGRBqtIgVs1codtcTa/z
 oP6z2IfRUhtRjE2DGe63Dfedidxn7Q2lq4B12rg28Dp/VzQ8oWth1mBtrL++aRxYCj
 fghMdtmyEsKf9YrQUVDhQamYMdCiwenQS0zMNyb4GGo6t8OMk8s2NtKAD972GMK5wh
 G8nhx+eeFi8QgJHvPK2a5Num/TVormPiJptZdtOcIIKcHVMFj/f8cr3VrJUD1+30mO
 WOX8MbMKQOAdcIYZBGDJtZBi+I9X3EU7hgfnA5NkhrVRJrSRcCniw7BbpuWhQr9jM0
 kbTvGdoCHuauw==
Date: Wed, 22 Dec 2021 09:14:43 -0600
From: Eric Biggers <ebiggers@kernel.org>
To: Yael Tiomkin <yaelt@google.com>
Message-ID: <YcNA4w6mof+zKIak@quark>
References: <20211221023721.129689-1-yaelt@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211221023721.129689-1-yaelt@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/keyctl09: test encrypted keys.
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Dec 20, 2021 at 09:37:21PM -0500, Yael Tiomkin wrote:
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl09.c b/testcases/kernel/syscalls/keyctl/keyctl09.c
> new file mode 100644
> index 000000000..507cd5628
> --- /dev/null
> +++ b/testcases/kernel/syscalls/keyctl/keyctl09.c
> @@ -0,0 +1,58 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Google, Inc.
> + */
> +
> +/*\
> + * [Description]
> + * Test that encrypted keys can be instantiated using user-provided decrypted
> + * data (plaintext), and separately, using kernel-generated key material.
> + */
> +

This test doesn't seem to work as intended.

First, it fails if CONFIG_ENCRYPTED_KEYS is unset (it should be skipped):

	keyctl09.c:33: TFAIL: Failed to instantiate encrypted key using payload decrypted data

Second, I don't have your patch "Instantiate key with user-provided decrypted
data" (https://lore.kernel.org/r/20211213192030.125091-1-yaelt@google.com) in my
kernel, so instantiating a key using "user-provided decrypted data" is not
implemented by the kernel.  However, the test still passes regardless:

	keyctl09.c:49: TPASS: Encrypted keys were successfully instantiated and read    

The test should detect when "user-provided decrypted data" is not supported by
the kernel, and report that the test of that is being skipped in that case.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
