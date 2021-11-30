Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFECC433FE
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 15:53:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 515653C87BB
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 16:53:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92D893C58B0
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 16:52:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 01DED1400987
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 16:52:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 071C8217BA;
 Tue, 30 Nov 2021 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638287575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctiX4iXMhAjxEdJyLkMXN4B7spe/H+gmZb6EFghth04=;
 b=VSEdu0EsxNTmBwXnzYRibbJNXw9s+onmN7VARVRGd+XxnwqBA1WT9ukGiBftV70uCBBslC
 7JdO/HMcLJN2oJi6SQ6xs+uA4sAThsadGKhkdX5v8wxzWdJbG+iwivTlGglu+zGCSFu6nT
 aWw3D7gdO8Z2Nf0B6zyib6iPslHE1pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638287575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ctiX4iXMhAjxEdJyLkMXN4B7spe/H+gmZb6EFghth04=;
 b=UCGMLe5YAqGzggYnNO4ElGGEh7MIVMub/FHCY+oYa84Rco7ANTFQiD/erwTDYAoNhd0HeN
 IIYnB79UqjoomLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CA5AA13D5A;
 Tue, 30 Nov 2021 15:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id avG9L9ZIpmHMYgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 30 Nov 2021 15:52:54 +0000
Date: Tue, 30 Nov 2021 16:54:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YaZJHmY0hkfz491s@yuki>
References: <YaSYuLV+XPW/pQ5/@yuki>
 <1638256273-5208-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1638256273-5208-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1638256273-5208-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/statx: Add docparse formatting
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

On Tue, Nov 30, 2021 at 03:11:13PM +0800, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/statx/statx01.c | 31 +++++++++------------
>  testcases/kernel/syscalls/statx/statx02.c | 12 +++++----
>  testcases/kernel/syscalls/statx/statx03.c | 26 +++++++-----------
>  testcases/kernel/syscalls/statx/statx05.c |  8 +++---
>  testcases/kernel/syscalls/statx/statx06.c | 33 +++++++----------------
>  testcases/kernel/syscalls/statx/statx07.c | 21 ++++++++-------
>  6 files changed, 53 insertions(+), 78 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
> index 524acd273..b52bb2988 100644
> --- a/testcases/kernel/syscalls/statx/statx01.c
> +++ b/testcases/kernel/syscalls/statx/statx01.c
> @@ -4,35 +4,28 @@
>   * Email: code@zilogic.com
>   */
>  
> -/*
> - * Test statx
> +/*\
> + * [Description]
>   *
>   * This code tests the functionality of statx system call.
>   *
>   * TESTCASE 1:

Can we drop the TESTCASE 1: here and TESTCASE 2: below?

The rendered documentation looks better without these two.

>   * The metadata for normal file are tested against predefined values:
                                                        ^
							expected?

predefined sounds strange a bit strange.

> - * 1) gid
> - * 2) uid
> - * 3) mode
> - * 4) blocks
> - * 5) size
> - * 6) nlink
> - * 7) mnt_id
>   *
> - * A file is created and metadata values are set with
> - * predefined values.
> - * Then the values obtained using statx is checked against
> - * the predefined values.
> + * - gid
> + * - uid
> + * - mode
> + * - blocks
> + * - size
> + * - nlink
> + * - mnt_id
>   *
>   * TESTCASE 2:
>   * The metadata for device file are tested against predefined values:
> - * 1) MAJOR number
> - * 2) MINOR number
>   *
> - * A device file is created seperately using mknod(must be a root user).
> - * The major number and minor number are set while creation.
> - * Major and minor numbers obtained using statx is checked against
> - * predefined values.
> + * - MAJOR number
> + * - MINOR number
> + *
>   * Minimum kernel version required is 4.11.

We do have min_kver in the tst_test structure and it's in the parsed
metadata as well, so I wouldn't repeat it here.

>   */
>  
> diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
> index 63133a3b7..56577599c 100644
> --- a/testcases/kernel/syscalls/statx/statx02.c
> +++ b/testcases/kernel/syscalls/statx/statx02.c
> @@ -4,12 +4,13 @@
>   * Email: code@zilogic.com
>   */
>  
> -/*
> - * Test statx
> +/*\
> + * [Description]
> + *
> + * This code tests the following flags with statx syscall:
>   *
> - * This code tests the following flags:
> - * 1) AT_EMPTY_PATH
> - * 2) AT_SYMLINK_NOFOLLOW
> + * - AT_EMPTY_PATH
> + * - AT_SYMLINK_NOFOLLOW
>   *
>   * A test file and a link for it is created.
>   *
> @@ -19,6 +20,7 @@
>   * To check symlink no follow flag, the linkname is statxed.
>   * To ensure that link is not dereferenced, obtained inode is compared
>   * with test file inode.
> + *
>   * Minimum kernel version required is 4.11.

Here as well no need to repeat the minimal kernel version.

>   */
>  
> diff --git a/testcases/kernel/syscalls/statx/statx03.c b/testcases/kernel/syscalls/statx/statx03.c
> index c72d7fead..de2fe4d38 100644
> --- a/testcases/kernel/syscalls/statx/statx03.c
> +++ b/testcases/kernel/syscalls/statx/statx03.c
> @@ -4,25 +4,17 @@
>   * Email: code@zilogic.com
>   */
>  
> -/*
> - * Test statx
> +/*\
> + * [Description]
>   *
> - * This code tests if expected error values are returned for specific cases by
> - * statx.
> - * The error cases are simulated and the return value is checked against
> - * expected error number value.
> - * The following error values are tested:
> - * 1) EBADF - Bad file descriptor
> - * 2) EFAULT - Bad address
> - * 3) EINVAL - Invalid argument
> - * 4) ENOENT - No such file or directory
> - * 5) ENOTDIR - Not a directory
> - * 6) ENAMETOOLONG - Filename too long
> + * Test basic error handling of statx syscall:
>   *
> - * Error scenario is simulated for each listed flag by passing
> - * respective arguments.
> - * The obtained error flag is checked against the expected
> - * flag value for that scenario.
> + * - EBADF - Bad file descriptor
> + * - EFAULT - Bad address
> + * - EINVAL - Invalid argument
> + * - ENOENT - No such file or directory
> + * - ENOTDIR - Not a directory
> + * - ENAMETOOLONG - Filename too long
>   *
>   * Minimum Kernel version required is 4.11.

Here as well.

>   */
> diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
> index 81a5bcbf2..83c6c3ab5 100644
> --- a/testcases/kernel/syscalls/statx/statx05.c
> +++ b/testcases/kernel/syscalls/statx/statx05.c
> @@ -4,10 +4,12 @@
>   * Email: code@zilogic.com
>   */
>  
> -/*
> - * Test statx
> +/*\
> + * [Description]
> + *
> + * Test statx syscall with STATX_ATTR_ENCRYPTED flag
>   *
> - * 1) STATX_ATTR_ENCRYPTED - A key is required for the file to be encrypted by
> + * - STATX_ATTR_ENCRYPTEDL: A key is required for the file to be encrypted by
>   *                          the filesystem.

The list with single entry looks strange here. I would rewrite it as:

Test statx syscall with STATX_ATTR_ENCRYPTED flag, if set a key is
required for the file to be encrypted by the filesystem.

>   * e4crypt is used to set the encrypt flag (currently supported only by ext4).

And here as well, no need to repeat the minimal kernel version.

> diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
> index 0469d66c5..4a0685a65 100644
> --- a/testcases/kernel/syscalls/statx/statx06.c
> +++ b/testcases/kernel/syscalls/statx/statx06.c
> @@ -1,36 +1,21 @@
>  // SPDX-License-Identifier: GPL-2.0 or later
>  /*
> - *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> - *  Email : code@zilogic.com
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + * Email : code@zilogic.com
>   */
>  
> -/*
> - * DESCRIPTION :
> +/*\
> + * [Description]
>   *
> - * Test-Case 1 : Testing btime
> - * flow :       The time before and after the execution of the create
> - *              system call is noted.
> - *		It is checked whether the birth time returned by statx lies in
> - *              this range.
> + * Test the following file timestamps of statx syscall:
>   *
> - * Test-Case 2 : Testing mtime
> - * flow :       The time before and after the execution of the write
> - *              system call is noted.
> - *              It is checked whether the modification time returned
> - *              by statx lies in this range.
> + * - btime - The time before and after the execution of the create system call is noted.
>   *
> - * Test-Case 3 : Testing atime
> - * flow :       The time before and after the execution of the read
> - *              system call is noted.
> - *              It is checked whether the access time returned by statx lies in
> - *              this range.
> + * - mtime - The time before and after the execution of the write system call is noted.
>   *
> - * Test-Case 4 : Testing ctime
> - * flow :	The time before and after the execution of the chmod
> - *              system call is noted.
> - *              It is checked whether the status change time returned by statx
> - *              lies in this range.
> + * - atime - The time before and after the execution of the read system call is noted.
>   *
> + * - ctime - The time before and after the execution of the chmod system call is noted.
>   */
>  
>  #define _GNU_SOURCE
> diff --git a/testcases/kernel/syscalls/statx/statx07.c b/testcases/kernel/syscalls/statx/statx07.c
> index ec1cdd190..e7045edaa 100644
> --- a/testcases/kernel/syscalls/statx/statx07.c
> +++ b/testcases/kernel/syscalls/statx/statx07.c
> @@ -1,15 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *  Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> - *  Email : code@zilogic.com
> + * Copyright (c) Zilogic Systems Pvt. Ltd., 2018
> + * Email : code@zilogic.com
>   */
>  
> -/*
> - * Test statx
> +/*\
> + * [Description]
>   *
>   * This code tests the following flags:
> - * 1) AT_STATX_FORCE_SYNC
> - * 2) AT_STATX_DONT_SYNC
> + *
> + * - AT_STATX_FORCE_SYNC
> + * - AT_STATX_DONT_SYNC
>   *
>   * By exportfs cmd creating NFS setup.
>   *
> @@ -29,11 +30,11 @@
>   *
>   * The support for SYNC flags was implemented in NFS in:
>   *
> - * commit 9ccee940bd5b766b6dab6c1a80908b9490a4850d
> - * Author: Trond Myklebust <trond.myklebust@primarydata.com>
> - * Date:   Thu Jan 4 17:46:09 2018 -0500
> + *  commit 9ccee940bd5b766b6dab6c1a80908b9490a4850d
> + *  Author: Trond Myklebust <trond.myklebust@primarydata.com>
> + *  Date:   Thu Jan 4 17:46:09 2018 -0500
>   *
> - *     Support statx() mask and query flags parameters
> + *  Support statx() mask and query flags parameters
>   *
>   * Hence we skip the test on anything older than 4.16.

Here as well, no need to repeat the minimal kernel version.

> */
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
