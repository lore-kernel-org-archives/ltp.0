Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9D8C27C77
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 05:45:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E9533D0C7D
	for <ltp@archiver.kernel.org>; Fri, 14 Jun 2024 07:45:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40B783CE649
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 07:45:39 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=lists.linux.it)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8E09E60132B
 for <ltp@lists.linux.it>; Fri, 14 Jun 2024 07:45:38 +0200 (CEST)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D008868CFE; Fri, 14 Jun 2024 07:45:34 +0200 (CEST)
Date: Fri, 14 Jun 2024 07:45:34 +0200
From: "hch@lst.de" <hch@lst.de>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
Message-ID: <20240614054534.GA9969@lst.de>
References: <20240607190607.17705-1-gulam.mohamed@oracle.com>
 <202406112130.a572f72-oliver.sang@intel.com>
 <IA1PR10MB7240B2686664744DB0D8867F98C12@IA1PR10MB7240.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <IA1PR10MB7240B2686664744DB0D8867F98C12@IA1PR10MB7240.namprd10.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH V4 for-6.10/block] loop: Fix a race between loop
 detach and loop open
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "lkp@intel.com" <lkp@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
 kernel test robot <oliver.sang@intel.com>,
 "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, "hch@lst.de" <hch@lst.de>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 13, 2024 at 09:10:37PM +0000, Gulam Mohamed wrote:
> I looked at the LTP test case failure and also the function tst_detach_device_by_fd() which failed. Our kernel patch will defer all the attempts to detach a loop device to the last close, to fix an issue.
> The tst_detach_device_by_fd() in LTP test case will open the loop device and repeatedly checks for error code ENXIO. As the new approach, as I mentioned above, will defer the detach to last close and the last close happens *only* when the LTP test function tst_detach_device_by_fd() returns, the test will obviously fail. So, Can you please modify the LTP test case to accommodate the new behaviour of kernel code for loop detach?
> Please let us know your comments.

I still think simply setting the rundown state is the better approach..


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
