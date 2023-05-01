Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F943C77B73
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 17:45:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9866A3CD945
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 19:44:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 080AD3CB1B7
 for <ltp@lists.linux.it>; Mon,  1 May 2023 19:44:47 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CF37B200210
 for <ltp@lists.linux.it>; Mon,  1 May 2023 19:44:46 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D828F60FE8;
 Mon,  1 May 2023 17:44:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2E6C433EF;
 Mon,  1 May 2023 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682963084;
 bh=mjBqknl9EWpA8Mbd1M9IDJsCQ4vmilQHsHwBnLgI7vc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t09tdIwLhJbhokvJ3MCrIOP1hpdMdQYLFz7iJV0fj1pvf7afSjFs26LAhuFnhyc/h
 nmejmOWXoJpPrU92tUSM9p66P54GMFAAhcODD4a7dnYhy05wESv/Ppt82pom2OyvUw
 FMVbTg6W/gdMxrJmaBBcSo8ukOMs1JB2ReIc20uhax8au8reXqyg5kI+nG9dG1snMa
 EHpNykedDM+3TPMJlAZgCDhV9S8nZM88NGJxFaFNgqQPGCf6IvuKUejjMPrDz2jJg9
 JcoCvFDWcddN9M/CvDTvnP1jelIhvIdL5WJEU7txSLvL6jgn8TNjxRrMuMH2y2pfAt
 ONVgWvAeLjxAw==
Date: Mon, 1 May 2023 10:44:42 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20230501174442.GA1224@sol.localdomain>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426220654.GD58528@sol.localdomain>
 <b1f3f7ee-6f90-172c-520a-fd6ddc23363f@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1f3f7ee-6f90-172c-520a-fd6ddc23363f@fujitsu.com>
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

On Thu, Apr 27, 2023 at 03:03:23AM +0000, Yang Xu (Fujitsu) wrote:
> on 2023/04/27 6:06, Eric Biggers wrote:
> > On Thu, Apr 06, 2023 at 01:40:20PM +0800, Yang Xu wrote:
> >> + * On ext4, files that use certain filesystem features (data journaling,
> >> + * encryption, and verity) fall back to buffered I/O. But ltp doesn't use these
> >> + * features by default, So I think dio should not fall back to buffered I/O.
> > 
> > Does LTP create and mount the filesystem itself?
> 
> Yes, I have enabled mount_device in tst_test struct, mount_device usage 
> you can see the following url.
> https://github.com/linux-test-project/ltp/wiki/C-Test-API#115-testing-with-a-block-device
> 
> If we set block device to LTP_DEV environment, we use this block device 
> to mount. Otherwise, use loop device to simuate it.

Great, can you update the comment to make it clear that this test creates its
own filesystem?

> > 
> > If not, then it wouldn't have control over this.
> > 
> >> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
> >> +		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
> >> +		return;
> >> +	}
> > 
> > "Filesystem does not support STATX_DIOALIGN"
> 
> OK.
> > 
> >> +
> >> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN
> > 
> > This looks wrong.  If the system headers are missing this field, then the
> > definition in the LTP source tree should be used instead.
> 
> Yes, usually, if system headers miss this field, we should use ltp 
> definition ie some macro.  But here it has a little difference, it is a 
> member in a struct.
> 
> see include/lapi/stat.h
> 
> #if defined(HAVE_STRUCT_STATX)
> #include <sys/stat.h>
> #else
> struct statx {
>          /* 0x00 */
>          uint32_t        stx_mask;
>          uint32_t        stx_blksize;
>          uint64_t        stx_attributes;
>          /* 0x10 */
>          uint32_t        stx_nlink;
>          uint32_t        stx_uid;
>          uint32_t        stx_gid;
>          uint16_t        stx_mode;
>          uint16_t        __spare0[1];
>          /* 0x20 */
>          uint64_t        stx_ino;
>          uint64_t        stx_size;
>          uint64_t        stx_blocks;
>          uint64_t        stx_attributes_mask;
>          /* 0x40 */
>          const struct statx_timestamp    stx_atime;
>          const struct statx_timestamp    stx_btime;
>          const struct statx_timestamp    stx_ctime;
>          const struct statx_timestamp    stx_mtime;
>          /* 0x80 */
>          uint32_t        stx_rdev_major;
>          uint32_t        stx_rdev_minor;
>          uint32_t        stx_dev_major;
>          uint32_t        stx_dev_minor;
>          /* 0x90 */
>          uint64_t        __spare2[14];
>          /* 0x100 */
> };
> #endif
> 
> the ltp definition only can be used when <sys/stat.h> miss statx struct 
> instead of statx struct member.  It seems we don't have a better idea. 
> Or do you have some idea?
> 
> It seems we think this question more complex, if system header miss, 
> then use ltp definition, then we can not figure out whether fail or we 
> just on old kernel.  Except we add a mininl kernel check in  the beginning.
> 

As I said, if the system headers are missing the needed fields, then LTP should
use its in-tree definition.  I.e., the in-tree definition should only be used if
HAVE_STRUCT_STATX && HAVE_STRUCT_STATX_STX_MNT_ID && [all other tested fields].

> >> +	SAFE_FILE_PRINTF(TESTFILE, "AAAA");
> >> +	fd = open(TESTFILE, O_RDWR | O_DIRECT);
> >> +	if (fd == -1 && errno == EINVAL) {
> >> +		SAFE_CLOSE(fd);
> >> +		tst_brk(TCONF, "The regular file is not on a filesystem that support DIO");
> >> +	}
> >> +	SAFE_CLOSE(fd);
> > 
> > The open() is not checked for error in all cases.
> 
> how about the following code:
> 
> 
> fd = open(TESTFILE, O_RDWR | O_DIRECT);
> if (fd == -1) {
> 	if (errno == EINVAL)
> 		 tst_brk(TCONF, "The regular file is not on a filesystem that support 
> DIO");
> 	else
> 		tst_brk(TBROK | TERRNO, "The regular file was open with O_RDWR | 
> O_DIRECT failed");
> }
> SAFE_CLOSE(fd);

I think that's okay.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
