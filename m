Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1VdssX-0002gm-TF
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 02:29:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VdssU-0000SY-FW
	for ltp-list@lists.sourceforge.net; Wed, 06 Nov 2013 02:29:57 +0000
Message-ID: <5279A979.3020302@cn.fujitsu.com>
Date: Wed, 06 Nov 2013 10:29:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <005301ceda93$558302a0$008907e0$@gyu.kim@lge.com>
In-Reply-To: <005301ceda93$558302a0$008907e0$@gyu.kim@lge.com>
Subject: Re: [LTP] [PATCH v2] acct01: add a check routine for acct
	implementation
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Honggyu Kim <hong.gyu.kim@lge.com>
Cc: ltp-list@lists.sourceforge.net

On 11/06/2013 09:55 AM, Honggyu Kim wrote:
> A check routine for acct implementation is added at the beginning of the test.
> check_acct_in_kernel function calls acct(NULL) and checks if errno is ENOSYS.
> It means that acct system call is not implemented in kernel.
> The other ENOSYS check routines in setup are removed.
> 
> This patch prevents from unintentional calling acct again in cleanup, which
> makes TCONF to TBROK and helps configuration problems stay as TCONF.
> 
> Previous test output: (becomes TBROK in the end)
> acct01      1  TCONF  :  BSD process accounting is not configured in this kernel
> acct01      2  TCONF  :  Remaining cases not appropriate for configuration
> acct01      3  TBROK  :  acct(NULL) failed: errno=ENOSYS(38): Function not implemented
> 
> Fixed test output: (stays as TCONF)
> acct01      1  TCONF  :  BSD process accounting is not configured in this kernel
> 
> Signed-off-by: Honggyu Kim <hong.gyu.kim@lge.com>
> ---
>  testcases/kernel/syscalls/acct/acct01.c |   32 +++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)


Applied with removing the unnecessary braces, thank you.

Wanlong Gao


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
