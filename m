Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FAE4C76196
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 19:29:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3ACDC3CD0C8
	for <ltp@archiver.kernel.org>; Fri, 31 Mar 2023 21:29:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7D803CB7C3
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 21:29:13 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BA9C91401122
 for <ltp@lists.linux.it>; Fri, 31 Mar 2023 21:29:12 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD65625A4;
 Fri, 31 Mar 2023 19:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665FCC433EF;
 Fri, 31 Mar 2023 19:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680290949;
 bh=kURHul4auGR8M6m90Q301pdcMms74Y2fanL+rVG1mBI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZGxy1d9vV1MDv1IEqdXTL3lexUKeyI3Y9CgQHAkKTyu7RfbHINTr+c463CGMmRceq
 7zuvRLrglWhSC3ai0wftteH+2S5O08SrG1zQVpfHfGTb/DdEDgwplW4DnRcqOrOA1n
 /Ku+D+meSvMzg+Idlq6HUn5oTgKTnF2eecx5+py+V8GaHNfoGh8RYCLOUUz7PBxSl+
 fhIZwWyp8cXKLADSbl2LtUCPcAxyhSnci4/KGgW2k19sGgiLw9xwJUVs8mAjA9PLKM
 csBQMjI3weOsQncfqrr3r5QeUt/XHVpn48oJcpnCLaD5Dcv1HBwdN0ztW/23LvYAEt
 e8cyFDegdO22g==
Date: Fri, 31 Mar 2023 19:29:07 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <ZCc0gyy9QvGLlUPv@gmail.com>
References: <1680164569-12114-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680164569-12114-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230330164653.GA881@sol.localdomain>
 <a9a441b0-1774-a15c-14ec-b155bfe88152@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a9a441b0-1774-a15c-14ec-b155bfe88152@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] syscalls/statx10: Add basic test for
 STATX_DIOALIGN
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

On Fri, Mar 31, 2023 at 12:56:47PM +0000, xuyang2018.jy@fujitsu.com wrote:
> > Thanks for writing a test for STATX_DIOALIGN!
> > 
> > However, the above code isn't actually a valid test, since stx_dio_mem_align and
> > stx_dio_offset_align will be 0 if the file doesn't support DIO.  This is
> > documented in the statx(2) manual page. 
> 
>   I have reported TCONF in setup when fail to open a file with O_DIRECT.

Unfortunately that does not work either, as the behavior for when direct I/O is
unsupported is not standardized.  Some filesystems do indeed return -EINVAL for
open(O_DIRECT).  However, others just treat O_DIRECT as a hint and fall back to
buffered I/O.  And some filesystems even implement the former behavior for some
files and the latter behavior for other files...

Note that this was actually one of the motivations for STATX_DIOALIGN.
STATX_DIOALIGN tells you whether direct I/O is "really" supported, as opposed to
being "supported" with a buffered I/O fallback.

> > Filesystems aren't guaranteed to
> > support DIO, if they do, they aren't guaranteed to support it on all files.
> 
> In this case, I only test a regular file.

It is possible that on a single filesystem, direct I/O is supported on some
regular files but not others.  It is also possible that files on the same
filesystem have different direct I/O alignment restrictions.

Likewise, this was part of the motivation for STATX_DIOALIGN.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
