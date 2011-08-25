Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QwaFP-0006bM-02
	for ltp-list@lists.sourceforge.net; Thu, 25 Aug 2011 13:45:31 +0000
Date: Thu, 25 Aug 2011 15:50:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110825135041.GF12466@saboteur.suse.cz>
References: <4E1D1008.50503@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E1D1008.50503@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] set_thread_area: fix error with -m32 in x86_64
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> When making with -m32 in x86_64 kernel, the cases will fail.
> Please refer to the following log.
> 
> # ./set_thread_area01
> set_thread_area01    1  TFAIL  :  failed - errno = 22 : Invalid argument
> # ./set_thread_area02
> set_thread_area_02    1  TFAIL  :  call get_thread_area() failed: TEST_ERRNO=EINVAL(22): Invalid argument
> 
> Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

Thanks for pointing this out, however I have even better solution. If we
change the test to do set_thread_area() with entry_number -1, we would
get correct entry_number set by the syscall. I'll commit a patch for
this in a minute. Please test the change once it gets into git.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
EMC VNX: the world's simplest storage, starting under $10K
The only unified storage solution that offers unified management 
Up to 160% more powerful than alternatives and 25% more efficient. 
Guaranteed. http://p.sf.net/sfu/emc-vnx-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
