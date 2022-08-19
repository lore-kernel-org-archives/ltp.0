Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9F5C32789
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 11:23:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C31B63CA1BD
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 13:23:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15D5B3C54EC
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 13:23:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 867FE6000EC
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 13:22:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D26E12012A;
 Fri, 19 Aug 2022 11:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660908178;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2vULwVZoPT2OR/bg7I5Yr7E2wjPqO7DUrRnIK9CU4A=;
 b=MP3t+1Y/qXPbLPduB95RTk2D+BRRAv7RJCZzU4dlwXVpfyayxK2Uh41k3md16kSb+nK9px
 P2A09XKCCqBG22BhOHHrgCSWfUptXAfBsfM4KCzaQvmFo84qcO1hCeO/+HtLxaZb3iixh3
 CI54fne3ootxD+OVmCwxeFXGTKquzZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660908178;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2vULwVZoPT2OR/bg7I5Yr7E2wjPqO7DUrRnIK9CU4A=;
 b=7JTkEZUSPcr6sW5gaCp0dneTgmDMxgfIUMX0wCZ/90GbncaRNz14P54Wfb7pmfXgtDtAPi
 i/P25OQP7EVN1eDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B228D13AC1;
 Fri, 19 Aug 2022 11:22:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TjSJKZJy/2KsLAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Aug 2022 11:22:58 +0000
Date: Fri, 19 Aug 2022 13:22:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <Yv9ykCw5VDoXaCmD@pevik>
References: <20220819090704.17219-1-pvorel@suse.cz>
 <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
 <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr

> On my owner metadata.html, I don't see  commit title(I guess network 
> problem)

No, you need to set environment variable LINUX_GIT, LINUX_STABLE_GIT and
GLIBC_GIT. There is also warning:

$ unset LINUX_GIT LINUX_STABLE_GIT GLIBC_GIT
$ cd metadata && make
WARN: git repository linux-git not defined. Define it in $LINUX_GIT
WARN: git repository linux-stable-git not defined. Define it in $LINUX_STABLE_GIT
WARN: git repository glibc-git not defined. Define it in $GLIBC_GIT


> Tag	Info
> linux-git  93bc420ed41d

> linux-git 99652ea56a41

> linux-git  04a87e347282

> linux-git 5f955f26f3d4

> linux-git e408e695f5f1

> So for me, If remove kernel commit in description, then I only see
> useless commit id number, unless I go to search them in kernel org.

> I prefer to keep these kernel commit comment.

I would still suggest to have change them as normal C comments - that's enough
for reading C source. We already added released docs to
linux-test-project.github.io [1], I plan to add hook to to push master version
there after each commit and stable after release (after pushing tag).
Then we can add this link to README.md to propagate docs.

Kind regards,
Petr

[1] http://linux-test-project.github.io/metadata/metadata.stable.html

> Best Regards
> Yang Xu


> > Hi Petr

> > Oh, I see commit title in metadata that I don't see it before.

> > Tag	   Info
> > linux-git 93bc420ed41d ("ext2: support statx syscall")

> > linux-git 99652ea56a41 ("ext4: Add statx support")

> > linux-git 04a87e347282 ("Btrfs: add statx support")

> > linux-git 5f955f26f3d4 ("xfs: report crtime and attribute flags to statx")


> > But user that doesn't use metadata(miss this usage or miss dependent
> > package ie rubygem-asciidoctor), then they only see some numbers in tag
> > but know nothing.

> > IMO, it is not clear like min_kever.

> > Best Regards
> > Yang Xu
> >> They are defined in .tags, having in docparse results into poor
> >> formating in metadata.{html,pdf}.

> >> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> >> ---
> >> Hi Li,

> >> I've done cleanup like this in the past, but sending a patch just to
> >> make consensus about it. If we prefer to have git commits like this in
> >> the code (i.e. if being in .tags is not enough), they should be in
> >> normal comments /* ... */ so that they aren't in docparse.

> >> IMHO docparse can mention some commit if wanted to add some description,
> >> but just as 5f955f26f3d4 or 5f955f26f3d4 ("xfs: report crtime and
> >> attribute flags to statx") if the commit subject is a description
> >> itself.

> >> http://linux-test-project.github.io/metadata/metadata.stable.html#statx04

> >> Kind regards,
> >> Petr

> >>    testcases/kernel/syscalls/statx/statx04.c | 35 +----------------------
> >>    1 file changed, 1 insertion(+), 34 deletions(-)

> >> diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
> >> index 98f9a6315..6c562b3d7 100644
> >> --- a/testcases/kernel/syscalls/statx/statx04.c
> >> +++ b/testcases/kernel/syscalls/statx/statx04.c
> >> @@ -14,41 +14,8 @@
> >>     * - STATX_ATTR_NODUMP: File is not a candidate for backup when a backup
> >>     *                        program such as dump(8) is run.
> >>     *
> >> - * xfs filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
> >> + * XFS filesystem doesn't support STATX_ATTR_COMPRESSED flag, so we only test
> >>     * three other flags.
> >> - *
> >> - * ext2, ext4, btrfs, xfs and tmpfs support statx syscall since the following commit
> >> - *
> >> - *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
> >> - *  Author: yangerkun <yangerkun@huawei.com>
> >> - *  Date:   Mon Feb 18 09:07:02 2019 +0800
> >> - *
> >> - *  ext2: support statx syscall
> >> - *
> >> - *  commit 99652ea56a4186bc5bf8a3721c5353f41b35ebcb
> >> - *  Author: David Howells <dhowells@redhat.com>
> >> - *  Date:   Fri Mar 31 18:31:56 2017 +0100
> >> - *
> >> - *  ext4: Add statx support
> >> - *
> >> - *  commit 04a87e3472828f769a93655d7c64a27573bdbc2c
> >> - *  Author: Yonghong Song <yhs@fb.com>
> >> - *  Date:   Fri May 12 15:07:43 2017 -0700
> >> - *
> >> - *  Btrfs: add statx support
> >> - *
> >> - *  commit 5f955f26f3d42d04aba65590a32eb70eedb7f37d
> >> - *  Author: Darrick J. Wong <darrick.wong@oracle.com>
> >> - *  Date:   Fri Mar 31 18:32:03 2017 +0100
> >> - *
> >> - *  xfs: report crtime and attribute flags to statx
> >> - *
> >> - *  commit e408e695f5f1f60d784913afc45ff2c387a5aeb8
> >> - *  Author: Theodore Ts'o <tytso@mit.edu>
> >> - *  Date:   Thu Jul 14 21:59:12 2022 -0400
> >> - *
> >> - *  mm/shmem: support FS_IOC_[SG]ETFLAGS in tmpfs
> >> - *
> >>     */

> >>    #define _GNU_SOURCE


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
