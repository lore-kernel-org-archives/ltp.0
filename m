Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VfrbB-0001oK-8p
	for ltp-list@lists.sourceforge.net; Mon, 11 Nov 2013 13:32:13 +0000
Date: Mon, 11 Nov 2013 14:32:02 +0100
From: chrubis@suse.cz
Message-ID: <20131111133202.GB12164@rei>
References: <1383085243-5833-1-git-send-email-vincent.hsu@linaro.org>
	<1383085243-5833-2-git-send-email-vincent.hsu@linaro.org>
	<20131107132918.GE28961@rei.suse.cz>
	<CAARHBVvTfK3B6dMPXvwd0dajfFWv_cNX-DkV_fHUnZjuB04u+A@mail.gmail.com>
	<CAARHBVuOoFVrr7L_f=sMKykjYsawvuzG+wYWOrZDsLTBxpEcGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAARHBVuOoFVrr7L_f=sMKykjYsawvuzG+wYWOrZDsLTBxpEcGQ@mail.gmail.com>
Subject: Re: [LTP] [LNG][PATCH 1/9] ltp-networking/nfs: Setting the NFS to
 version 3 by default. NFSv3 is more compatibled with recent linux
 distributions.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, Linaro Networking <linaro-networking@linaro.org>

Hi!
> I forget to remark something about this patch.
> 
> Many linux distributions (ubuntu, centos) doesn't enable nfsv2 client
> support in default kernel config (CONFIG_NFS_V2=y). ref.
> http://kernel.ubuntu.com/~kernel-ppa/configs/natty/amd64-config.flavour.generic
> 
> Although Ubuntu disabled nfsv3 in nfsd initial script
> (/etc/init.d/nfs-kernel-server). I think configuring scripts is better than
> recompling kernel. So I suggest to set this test to nfsv3+. Maybe nfsv4 is
> the best option, it work fine in both client and server side in ubuntu. But
> I saw another test named nfsv4 test, it may confict. How do you think?

Making it nfsv3+ seems like safe default to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
