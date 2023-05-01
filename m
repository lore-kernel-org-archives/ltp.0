Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7E4C77B73
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 17:47:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 578283CDE2E
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 19:47:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF3EB3CBAFF
 for <ltp@lists.linux.it>; Mon,  1 May 2023 19:47:19 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2984520039B
 for <ltp@lists.linux.it>; Mon,  1 May 2023 19:47:18 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3219E61805;
 Mon,  1 May 2023 17:47:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A6CC433D2;
 Mon,  1 May 2023 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682963233;
 bh=DpfBDZ0G10cjP6fMfC2Jf/OfItC5pNQbW0oBQAg103Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kRdUqBQDJO3pIQu33mMZAsYljq7ETzK3zmlBAG31q6YU4OxJhfkT1cBQv4k6ir0aW
 llVQF3Cbc99Ec5Ldtu6SGjxakB8WWbFW5TorV8CVDt4K1gPYQ6mZyJJy/zd5gWMY/z
 54+9qLUe+BO9z+4dreZHHQCkN1Sxnpclab3Tg4+IsNKmTl8WHi/lh3eXwrk9qu6ELr
 g/CVMEqUW2Ht06cdKl60zlZgAC4lRNTIYAaRz5r7aD3J4xv8jZ7ZRG0X+IeyyZYbk1
 L+3BpP5uYH/Xmt+VGIGIaIiEsVPDoxKhInLn7t+95Hj/eWQhcEppRK7CZ+xaglgriP
 1SQ+2TdB6Xrhw==
Date: Mon, 1 May 2023 10:47:11 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20230501174711.GB1224@sol.localdomain>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426220654.GD58528@sol.localdomain>
 <b1f3f7ee-6f90-172c-520a-fd6ddc23363f@fujitsu.com>
 <20230501174442.GA1224@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230501174442.GA1224@sol.localdomain>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, May 01, 2023 at 10:44:42AM -0700, Eric Biggers wrote:
> As I said, if the system headers are missing the needed fields, then LTP should
> use its in-tree definition.  I.e., the in-tree definition should only be used if
> HAVE_STRUCT_STATX && HAVE_STRUCT_STATX_STX_MNT_ID && [all other tested fields].

"the in-tree definition should only be used" =>
"the system definition should only be used"

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
