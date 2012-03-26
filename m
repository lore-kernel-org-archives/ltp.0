Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SC2XY-0000S3-Gv
	for ltp-list@lists.sourceforge.net; Mon, 26 Mar 2012 05:32:24 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SC2XW-00054K-Ut
	for ltp-list@lists.sourceforge.net; Mon, 26 Mar 2012 05:32:24 +0000
Message-ID: <4F6FFF25.3020707@cn.fujitsu.com>
Date: Mon, 26 Mar 2012 13:31:17 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <5d69c51b5c6d10f19b2b49332418ae6771e34a3f.1332511710.git.zliu@redhat.com>
In-Reply-To: <5d69c51b5c6d10f19b2b49332418ae6771e34a3f.1332511710.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH v2] mm/tunable: add a new testcase min_free_kbytes
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 03/23/2012 10:12 PM, Zhouping Liu wrote:

> 
> The tune is used to control free memory, and system always
> reserve > min_free_kbytes memory at least.
> 
> Since the tune is not too large or too little, which will
> lead to the system hang, so I choose two cases, and test them
> on all overcommit_memory policy (0, 1, 2), at the same time,
> compare the current free memory with the tunable value
> repeatedly.
> 
> a) default min_free_kbytes with all overcommit memory policy
> b) half of mem_free with all overcommit memory policy


pushed, thanks Liu, if has problems, please feel free to send
further fixing patches.

Regards,
Wanlong Gao

> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  runtest/mm                                     |    2 +
>  testcases/kernel/mem/tunable/min_free_kbytes.c |  237 ++++++++++++++++++++++++
>  2 files changed, 239 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/tunable/min_free_kbytes.c
> 
> thanks caspar's suggestions, I updated the patch.
> v1 -> v2:
>    1) using sig_handler to control the check_monitor thread,
>    2) moved tst_* funcs in child,
>    3) catch the return value in eatup_mem().



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
