Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S5oMn-0002uy-Jj
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 01:11:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S5oMm-0005Mi-09
	for ltp-list@lists.sourceforge.net; Fri, 09 Mar 2012 01:11:33 +0000
Message-ID: <4F594DE2.4040603@cn.fujitsu.com>
Date: Fri, 09 Mar 2012 08:25:06 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F58E36E.5000306@casparzhang.com>
In-Reply-To: <4F58E36E.5000306@casparzhang.com>
Subject: Re: [LTP] [RFC] make mce-test a submodule
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: andi.kleen@intel.com, ying.huang@intel.com, shaohui.zheng@linux.intel.com, LTP list <ltp-list@lists.sourceforge.net>

On 03/09/2012 12:50 AM, Caspar Zhang wrote:

> Hi Garrett, Andi, and all:
> 
> When I looked into current LTP tree, I found it a little messy due to
> some mce-test stuff, such as
> 
>   - mce-test docs goes to $TOPDIR/README, and
>   - some mce-test files still lying under testcase/mce-test/.
> 
> I think we need a cleanup for it.


yes, I think so.

> 
> Also an idea comes to my mind, that we can try to make mce-test a
> submodule of LTP.


Not a bad idea.

> 
> I am also thinking about the pros and cons:
> 
> pro(s):
>   - easier for code maintenance, no need to sync periodically from
> maintainer side
> 
> con(s):
>   - two extra steps added for LTP users, they have to do:
>     $ git submodule init
>     $ git submodule update
> to enable using mce-test.
> 
> mce-test could no longer be found at kernel.org, so I cloned it from
> Andi's github repo, not sure if it is the right place:
> 
>     git://github.com/andikleen/mce-test.git


The tree seems just a few update every month now, I wonder why intel guys
didn't sync the commits to LTP ?

> 
> I have made this change to my personal LTP fork, you can review it here:
> 
>     https://github.com/casparant/ltp/commit/5cca17f633


The patch loooks good.

Thanks,
Wanlong Gao

> 
> Any comments are welcomed.
> 
> Thanks,
> Caspar



------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
