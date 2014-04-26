Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1We0mf-0002Eh-Ez
	for ltp-list@lists.sourceforge.net; Sat, 26 Apr 2014 11:28:41 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1We0md-0005XZ-Ti
	for ltp-list@lists.sourceforge.net; Sat, 26 Apr 2014 11:28:41 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s3QBSVDg011912
	for <ltp-list@lists.sourceforge.net>; Sat, 26 Apr 2014 19:28:31 +0800
Message-ID: <535B9829.3080601@cn.fujitsu.com>
Date: Sat, 26 Apr 2014 19:27:37 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1398423247-17525-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1398423247-17525-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3] pipeio/pipeio.c: cleanup and add it to run
	default
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On 04/25/2014 06:54 PM, Xiaoguang Wang wrote:
> Delete some useless comments and fix some.
> 
> Use SAFE_* macros.
> 
> Make a re-arrangement on original code: let parent process
> work in do_parent(), child process work in do_child(), and
> arguments parse and initialization work in setup().
> 
> Delete several useless or pointless options:
>   Option C: this option is not supported and has no effect to this test.
> 
>   Option B: if this option is specified, the parent process will always
> return 0, which won't reflect the correct test results. I think it does
> not make much sense and remove it.
> 
>   Option d: this option is used to specify a directory, where named pipe
> is created, other than the current directory. Since tst_tmpdir() will
> create a temporary directory, so I think "-d" option can be removed.
> 
> printf() is not async-signal-safe, so use write(2) in signal handler directly.
> 
> Some cleanup.
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  scenario_groups/default              |   1 +
>  testcases/kernel/ipc/pipeio/pipeio.c | 963 ++++++++++++++++-------------------
>  2 files changed, 441 insertions(+), 523 deletions(-)


Applied, thank you.


Wanlong Gao


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
