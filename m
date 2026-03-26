Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E944EEDB7CC
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 08:49:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE0B63E20D6
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 10:49:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CB133CC7C2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 16:44:05 +0100 (CET)
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3461F1A007EF
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 16:44:04 +0100 (CET)
Received: from localhost (108-141-067-156.ip-addr.inexio.net [156.67.141.108])
 by smtp05-ext.udag.de (Postfix) with ESMTPA id 0BF1FE036D;
 Thu, 26 Mar 2026 16:44:02 +0100 (CET)
Authentication-Results: smtp05-ext.udag.de;
 auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 26 Mar 2026 16:44:02 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <acVT7mE4MjBfNPOW@fedora>
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <202603261451.d2a4cd46-lkp@intel.com> <acVLK8F8i-eEZwLG@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acVLK8F8i-eEZwLG@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 07 Apr 2026 10:49:23 +0200
Subject: Re: [LTP] [PATCH] fuse: when copying a folio delay the mark dirty
 until the end
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
Cc: lkp@intel.com, Miklos Szeredi <miklos@szeredi.hu>,
 Bernd Schubert <bernd@bsbernd.com>, linux-kernel@vger.kernel.org,
 oe-lkp@lists.linux.dev, Horst Birthelmer <horst@birthelmer.com>,
 kernel test robot <oliver.sang@intel.com>,
 Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Horst Birthelmer <hbirthelmer@ddn.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 26, 2026 at 04:05:15PM +0100, Cyril Hrubis wrote:
> Hi!
> > commit: 47f8dde97f35e32a1003d54e387273bcdf014ddf ("[PATCH] fuse: when copying a folio delay the mark dirty until the end")
> > url: https://github.com/intel-lab-lkp/linux/commits/Horst-Birthelmer/fuse-when-copying-a-folio-delay-the-mark-dirty-until-the-end/20260316-234418
> > patch link: https://lore.kernel.org/all/20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com/
> > patch subject: [PATCH] fuse: when copying a folio delay the mark dirty until the end
> > 
> > in testcase: ltp
> > version: 
> > with following parameters:
> > 
> > 	disk: 1HDD
> > 	fs: ext4
> > 	test: fs-03
> 
> Looks like the test that has failed was fs_fill that runs several
> threads that attempt to fill the filesystem (until they get ENOSCP) then
> delete the files and try again. And apparently we managed to get EIO
> when file has been closed() by one of the threads after a few minutes of
> the runtime on NTFS mounted over FUSE.
> 
Probably nothing to do with the patch itself, but the patch will never
make it since it contains a wrong assumption.

Thanks for clarifying!

> -- 
> Cyril Hrubis
> chrubis@suse.cz

Horst

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
