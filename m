Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7F0C433EF
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 15:59:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 797DD3C98F7
	for <ltp@archiver.kernel.org>; Wed,  2 Feb 2022 16:59:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BC813C9892
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 16:58:56 +0100 (CET)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5D9991401397
 for <ltp@lists.linux.it>; Wed,  2 Feb 2022 16:58:12 +0100 (CET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: krisman) with ESMTPSA id 6C27E1F413B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1643817491;
 bh=gypxvvDKG8LXMYwRrXM6M5XchsdQhaATrUYKypq39Lc=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=EKLdZKGDedcRgYb/BC/1K/wgsNzp1E7DjKxZ9p+chHUwCU+bevsme1q8s86RVPAI6
 86/BI6gYmtRRA2ThhucjV7eIvpp00U0WBSmbPAsFaaQf+MokKE/XcSIswzsx02bTb8
 Jx/q3qD7mziMGoa6cQ9uUu47dcpo//sYFNUuFu0MObqwVhZjH3Ce3LkWtnBbFNM+xW
 Go0wquslPtbnhauIXzYjJEjkopIbi5r2/sVe3B53429wI7OW8cR9TOl765JaTcOqGg
 vLU2WTKuCSEdYfevD+nq/UXp98iYBannVs4zBzsV4T6351v8ie/jccZvnqvHbI4I6A
 VOBPT5ouNk8RA==
From: Gabriel Krisman Bertazi <krisman@collabora.com>
To: Petr Vorel <pvorel@suse.cz>
Organization: Collabora
References: <20220202142623.18926-1-pvorel@suse.cz>
Date: Wed, 02 Feb 2022 10:58:04 -0500
In-Reply-To: <20220202142623.18926-1-pvorel@suse.cz> (Petr Vorel's message of
 "Wed, 2 Feb 2022 15:26:23 +0100")
Message-ID: <87sft1gt0z.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fanotify22: Lower the timeout
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
Cc: Matthew Bobrowski <repnop@google.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> writes:

> kernel v5.17-rc1 has a regression which block until the timeout.
> Thus lower the timeout to 10s (runtime on laptop < 1s, on VM with 2
> cores < 2s).
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
