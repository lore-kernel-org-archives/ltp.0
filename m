Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C792C021A0
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739355583; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Tl/spSh7PyWrcECLLte9xI2ePHn7zl+nWjSmJfE85uw=;
 b=jf15Ar5y+yRGIRVJ9P2FbUFZeIizhCiNwzXyoqgb0S25qbrv+hpLL2huJQWttDKeiYwBM
 A7N/qpgMN0ct3DAHadtb05Ny1cOSrwpGbiJKxMK2RUGlzjqtoXzfgEynU8y5jodsWyGCXoP
 HvrrnGNFdtEE/HoYBiG2lw7REr4xA1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8153D3C99D5
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 11:19:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2423C0277
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 19:35:36 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=sj@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 645EB1002890
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 19:35:36 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5ED685C4D46;
 Tue, 11 Feb 2025 18:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7A7C4CEDD;
 Tue, 11 Feb 2025 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739298933;
 bh=/GDgxa2V50tFPQOr9OXJ/5PrkxuGxrhpmwMTgMzj/T0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kl+DX5igmocajTRVwBOsdZaBjIkP6B6H3j2G+72XnR5gu5LDvnJzhET+0Vb1TMSD6
 A2JJP0TP1FLV+XAsv0hHXSjSVvmEa9pb6Aq69DOXfje6W4aQvorDhKm+HheB9iwZk0
 HuKXXpkcwLgd97YlZP+3rVJgybJj/l5FR2DN9O8+m+fzpo18vRtEJF4U3KODj2pDqk
 5Y4+pUbVH2gHNtjDAj9Di2bjvymszhio/t1iBscgngU+cs1w6NolRNEgvJOkRh/XYU
 fLOI0ULS1WWzZnBE83kphBPURC+LTNVtCov0hoitU4GLBR2kBgB0FgKhKc+Y6s6q+5
 vUSGvKMQjmT/A==
To: "Arnd Bergmann" <arnd@arndb.de>
Date: Tue, 11 Feb 2025 10:35:31 -0800
Message-Id: <20250211183531.4359-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <fa1a7a10-f892-4e7e-acb4-0b058aa53d88@app.fastmail.com>
References: 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 12 Feb 2025 11:18:57 +0100
Subject: Re: [LTP] next-20250210: WARNING: at include/linux/rwsem.h:85
 madvise_unlock
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
From: SeongJae Park via ltp <ltp@lists.linux.it>
Reply-To: SeongJae Park <sj@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 "Paul E. McKenney" <paulmck@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 rcu <rcu@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 11 Feb 2025 10:32:55 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Feb 11, 2025, at 10:23, Naresh Kamboju wrote:
> > Regressions on arm64 Juno-r2 device while running LTP syscalls tests
> > madvise01 warnings on the Linux next-20250210 tag.
> >
> > First seen on next-20250210
> > Good: next-20250207
> > Bad: next-20250210
> 
> Cc SeongJae Park <sj@kernel.org>
[...]
> This is mmap_write_unlock() triggering
> rwsem_assert_held_write(&mm->mmap_lock);
> 
> That code was changed in these commits:
> 
> 415553982a1e mm-madvise-remove-redundant-mmap_lock-operations-from-process_madvise-fix
> ec68fbd9e99f mm/madvise: remove redundant mmap_lock operations from process_madvise()
> f19c9d7b57cf mm/madvise: split out madvise() behavior execution
> a4d5a73cdc14 mm/madvise: split out madvise input validity check
> 948a0a9ea070 mm/madvise: split out mmap locking operations for madvise()
> 
> You could try reverting them to see if that fixes it again.

Thank you for kindly Cc-ing me and further providing this nice information,
Arnd!  I posted a fix and continuing discussion there:
https://lore.kernel.org/20250211063201.5106-1-sj@kernel.org


Thanks,
SJ

[...]

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
