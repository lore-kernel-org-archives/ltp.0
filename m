Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Tfmop-000670-Oo
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 07:21:27 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tfmol-0005Ka-3C
	for ltp-list@lists.sourceforge.net; Tue, 04 Dec 2012 07:21:27 +0000
Message-ID: <50BDA418.1090600@cn.fujitsu.com>
Date: Tue, 04 Dec 2012 15:19:52 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1354537197-5353-1-git-send-email-jstancek@redhat.com>
In-Reply-To: <1354537197-5353-1-git-send-email-jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] clone: increase stack size to 1M
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 12/03/2012 08:19 PM, Jan Stancek wrote:
> 16k is not enough for some LTP signal handlers:
> http://article.gmane.org/gmane.linux.ltp/16992
> 1M should be plenty for all architectures.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Applied, thank you.

Wanlong Gao

> ---
>  testcases/kernel/syscalls/clone/clone_platform.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/clone/clone_platform.h b/testcases/kernel/syscalls/clone/clone_platform.h
> index ae7ae1a..b5ba8c9 100644
> --- a/testcases/kernel/syscalls/clone/clone_platform.h
> +++ b/testcases/kernel/syscalls/clone/clone_platform.h
> @@ -17,4 +17,4 @@
>  /* Common platform specific defines for the clone system call tests */
>  
>  //#define CHILD_STACK_SIZE 8192
> -#define CHILD_STACK_SIZE 16384
> +#define CHILD_STACK_SIZE (1024*1024)
> 


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
