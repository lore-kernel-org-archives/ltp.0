Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2202C38A2D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 12:45:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D81D23C9A5D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 14:45:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FD153C04BF
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 14:45:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A56C41A00706
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 14:45:30 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id AF50B21EAC;
 Mon, 24 Oct 2022 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666615529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fu7QrsLlQg8JUU7m5KcoueBNOjoONZxIQtEbzlrNDDc=;
 b=bmW++/Air1uOr5QaSkckpJ+Z5qJW2qhYQLE+naEGtD93s9youOWZo/MPmmWINCgh5WJLua
 aergRxujdkHDYJiRR+BMg6N83uKMQp9Y1Pvjy8t+gcnqVTID96oI/3wbKPEngO8RU7yh30
 xc/8ZjFIPLXw+XEsY/rYwGFQ+p4Kbh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666615529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fu7QrsLlQg8JUU7m5KcoueBNOjoONZxIQtEbzlrNDDc=;
 b=Gn7fv0cE0rC86k3IqHhCNH/ovl3i3dSEyPBmXTNgz+XtzwlrFf5oIt/QEmsL2QJey7BUWb
 YvSjpA3mvcfoDZCA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 67E9B2C141;
 Mon, 24 Oct 2022 12:45:29 +0000 (UTC)
References: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
 <20221017014333.42180-4-luoxiaoyu9@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luo xiaoyu <luoxiaoyu9@huawei.com>
Date: Mon, 24 Oct 2022 13:44:11 +0100
In-reply-to: <20221017014333.42180-4-luoxiaoyu9@huawei.com>
Message-ID: <87wn8pxudz.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] signal03.c: Rewrite using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Luo xiaoyu via ltp <ltp@lists.linux.it> writes:

> Rewrite using new LTP API.
>
> Signed-off-by: Luo xiaoyu <luoxiaoyu9@huawei.com>

Merged with the addition of volatile to ign_handler, thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
