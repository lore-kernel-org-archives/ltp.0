Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC60FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 08:26:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F33503E2D34
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 10:26:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C12DC3E1C11
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 10:26:26 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F002A1A00A5A
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 10:26:24 +0200 (CEST)
Date: Thu, 30 Apr 2026 16:26:13 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777537582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LOb7hIZdvsHd8mbWR4ezAAXtXfTQITAZ7wyCO2C9u5E=;
 b=ij2Cn7VrriFDovYB5uWjyP1E9BnmjPdYdhZDJw8Chtljq0mU7+vErTSD487jaPpTMeyFHz
 ii57aRvhan0vnftFFOQDQEGzFDAlj2RKaQm+XIMWqnbhkAMBrYbt7q2HPn3zzlgP8J0882
 S9qzNBj3Zg9bsrYHaxU4eYylJcFuX3w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <afMSJVvCI-HWpCtr@linux.dev>
Mail-Followup-To: Avinesh Kumar <avinesh.kumar@suse.com>,
	ltp@lists.linux.it
References: <20260430063326.53566-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260430063326.53566-1-avinesh.kumar@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fsmount02: fix invalid-flags test
 failure on Linux 7.1+
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

Avinesh Kumar via ltp wrote:

> Upstream Linux commit 5e8969bd1927 ("mount: add FSMOUNT_NAMESPACE") [1]
> introduced the `FSMOUNT_NAMESPACE` flag, which maps to `0x02`.
> This causes fsmount02 test failure as `0x02` value is no longer invalid.
> 
> fsmount02.c:56: TFAIL: invalid-flags: fsmount() succeeded unexpectedly (index: 1)
> 
> Use `0x80000000` as invalid flag value to adapt test for this upstream change.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5e8969bd1927
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>

Good catch.
Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
