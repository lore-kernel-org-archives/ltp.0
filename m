Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63353C54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 13:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5E493CB2AC
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 14:43:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC0283CB2AC
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 14:42:48 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=brauner@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A46CC1A00CDC
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 14:42:47 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 5A8F5616D5;
 Fri, 15 Mar 2024 13:42:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376D8C433F1;
 Fri, 15 Mar 2024 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710510165;
 bh=yQjjoHAXiCtUEgUO5PE3VGVY3a1Pjgr3XTej8GW/Mhk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Bbt2cRueQrFzlu5adTAhX82qM17+W0wzcYzfoZdlYx1J58zF77Ri4nQ0qKLP+CDg5
 fThVJKrH6ggcBsrhrxqNWPB31SC6yx7vEHhyL6IUgpxNE2YB+PY9jWm4ecbe2tGkUD
 VqXX0y6aP+Dwoot7lHy1opVGTe46Rf5Yhw5/SC5GYeRJHHf06EEKnEoVMX2Sd+Fv6f
 B8EYcRCQrGF4o0wqNfj3+Jao1fXLw3fCPEkEKU1AS0WZkm+D1QQMaLE8YLNuWTQWqO
 pXkCbLsd8j+oPPQ9xQa3lpoldYD05bZoRk2oVGIc9gRIDLD6wUNwPM3gKRurwDorcX
 P485iX30ZjkOQ==
Date: Fri, 15 Mar 2024 14:42:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <20240315-neufahrzeuge-kennt-317f2a903605@brauner>
References: <202403151507.5540b773-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202403151507.5540b773-oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [pidfd]  cb12fd8e0d: ltp.readahead01.fail
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
Cc: oe-lkp@lists.linux.dev, linux-fsdevel@vger.kernel.org, lkp@intel.com,
 ltp@lists.linux.it, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 15, 2024 at 04:16:33PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.readahead01.fail" on:
> 
> commit: cb12fd8e0dabb9a1c8aef55a6a41e2c255fcdf4b ("pidfd: add pidfs")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 65d287c7eb1d14e0f4d56f19cec30d97fc7e8f66]
> [test failed on linux-next/master a1184cae56bcb96b86df3ee0377cec507a3f56e0]
> 
> in testcase: ltp
> version: ltp-x86_64-14c1f76-1_20240309
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: f2fs
> 	test: syscalls-00/readahead01
> 
> 
> 
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

Yes, this is an expected failure.
Before moving pidfds to pidfs they were based on anonymous inodes.
Anonymous inodes have a strange property: yhey have no file type. IOW,
(stat.st_mode & S_IFMT) == 0.

The readhead code looks at the filetype and if it isn't a regular file
then you'll get EINVAL. This is the case for anonymous inode based
pidfds:

        /*
         * The readahead() syscall is intended to run only on files
         * that can execute readahead. If readahead is not possible
         * on this file, then we must return -EINVAL.
         */
        ret = -EINVAL;
        if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
            (!S_ISREG(file_inode(f.file)->i_mode) &&
            !S_ISBLK(file_inode(f.file)->i_mode)))
                goto out;

However, pidfs makes them regular files so they're not caught by that
check anymore.

However, pidfs doesn't implement any readahead support. Specifically,
it'll have sb->s_bdi == noop_backing_dev_info. Which will mean the
readahead request is just ignored:

        if (IS_DAX(inode) || (bdi == &noop_backing_dev_info)) {
                switch (advice) {
                case POSIX_FADV_NORMAL:
                case POSIX_FADV_RANDOM:
                case POSIX_FADV_SEQUENTIAL:
                case POSIX_FADV_WILLNEED:
                case POSIX_FADV_NOREUSE:
                case POSIX_FADV_DONTNEED:
                        /* no bad return value, but ignore advice */
                        break;
                default:
                        return -EINVAL;
                }
                return 0;
        }

So I'd just remove that test. It's meaningless for pseudo fses.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
