Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TOf38-0007kG-Uv
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 01:37:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TOf37-0000j6-4e
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 01:37:26 +0000
Message-ID: <507F5CE0.6050008@cn.fujitsu.com>
Date: Thu, 18 Oct 2012 09:35:28 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <20121017191549.24471.86119.stgit@localhost6.localdomain6>
In-Reply-To: <20121017191549.24471.86119.stgit@localhost6.localdomain6>
Subject: Re: [LTP] [PATCH] Add generated files to .gitignore
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
To: Chris Dearman <chris@mips.com>
Cc: ltp-list@lists.sourceforge.net

On 10/18/2012 03:15 AM, Chris Dearman wrote:
> Signed-off-by: Chris Dearman <chris@mips.com>

Pushed, thank you.

Wanlong Gao

> ---
>  .gitignore                                        |    2 ++
>  testcases/commands/.gitignore                     |    5 +++++
>  testcases/kernel/mem/.gitignore                   |    2 ++
>  testcases/kernel/syscalls/.gitignore              |    8 ++++++++
>  testcases/kernel/timers/leapsec/.gitignore        |    1 +
>  testcases/misc/tcore_patch_test_suites/.gitignore |    1 +
>  6 files changed, 19 insertions(+)
>  create mode 100644 testcases/commands/.gitignore
>  create mode 100644 testcases/kernel/timers/leapsec/.gitignore
>  create mode 100644 testcases/misc/tcore_patch_test_suites/.gitignore
> 
> 
> 
> ------------------------------------------------------------------------------
> Everyone hates slow websites. So do we.
> Make your web apps faster with AppDynamics
> Download AppDynamics Lite for free today:
> http://p.sf.net/sfu/appdyn_sfd2d_oct
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
