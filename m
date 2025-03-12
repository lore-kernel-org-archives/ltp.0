Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5E8C28B28
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 05:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741755749; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=x9HiRVTHH9lsT4CDT28TTID4/c/UyI4MQJecZIDDric=;
 b=JyEB+Fnsmc1GFmfAfXahP6rOkTXrrk3YiAcYU6ryTOAzuiMi7T79MoiWWP0FtxvYQqtsM
 M1IvMpJ2WMa46MldUyVCxH752RndMmu0QzQtks0hfomS3YEHS2fLNUNmpVq4MQtQr1gNZus
 UzxQZ4kGCsXiC1bGIgY0N/nAjMv2nYg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA1873CA3E5
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 06:02:28 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 368AD3C0265
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:02:06 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 473071000467
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 06:02:05 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 671DA5C41B7;
 Wed, 12 Mar 2025 04:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5825C4CEE3;
 Wed, 12 Mar 2025 05:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741755723;
 bh=bq8xGoNfIm85Y5PQEZeKLy6enCpMHIQM0jHtMjVf+yw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GVn4q/sYV9ylcQQ31hsGpw0eMpmeanMZUqHnpJoQ0wnxN7zdqdU3uOaohnfM4iIcE
 8AGQQAW9qhI6tbXyb0gu9rG7UsAx8JhOhPx94EaELtYxwfANWlkUC0Nuxqoz12HmJR
 Jfv/zgE2n6KR6FC5IFc125rbt95brsVtWKwhSNnxAQVSKhbfPP5qvTzO0y5FDRn+Di
 38Z2RNFDfeIxg45vLKE1OYqQ5ctzgWSuckmG+z+Yr+ZVL0TKFE7v0IeMcO4vuXaxSa
 RAV48IEdHBEHxlbYte5dofl38JpMVtQiymzPYFQeJ6Gxgu7DfGfyQtRAXn0MH54V4h
 mstL2vDpLVJxg==
Date: Tue, 11 Mar 2025 22:02:02 -0700
To: Christian Brauner <brauner@kernel.org>
Message-ID: <Z9EVSj5SCsoCd6KA@bombadil.infradead.org>
References: <202503101536.27099c77-lkp@intel.com>
 <20250311-testphasen-behelfen-09b950bbecbf@brauner>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250311-testphasen-behelfen-09b950bbecbf@brauner>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [block/bdev] 3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: lkp@intel.com, John Garry <john.g.garry@oracle.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, linux-block@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, Hannes Reinecke <hare@suse.de>,
 oe-lkp@lists.linux.dev, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 11, 2025 at 01:10:43PM +0100, Christian Brauner wrote:
> On Mon, Mar 10, 2025 at 03:43:49PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/util.c" on:
> > 
> > commit: 3c20917120ce61f2a123ca0810293872f4c6b5a4 ("block/bdev: enable large folio support for large logical block sizes")
> > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> Is this also already fixed by:
> 
> commit a64e5a596067 ("bdev: add back PAGE_SIZE block size validation for sb_set_blocksize()")

Or this patch just posted:

https://lkml.kernel.org/r/20250312050028.1784117-1-mcgrof@kernel.org

  Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
