Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1S839w-0004bN-FB
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 05:23:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S839t-0002xl-UN
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 05:23:32 +0000
Message-ID: <4F617C80.1080604@redhat.com>
Date: Thu, 15 Mar 2012 13:22:08 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4F6169B5.9020205@casparzhang.com>
	<1331785975-20452-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1331785975-20452-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH V4] readlink03: fix return value for the syscall
 readlink()
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, jburke@redhat.com

On 03/15/2012 12:32 PM, Wanlong Gao wrote:
> Since commit http://git.kernel.org/linus/65cfc672
> which added O_PATH support to the *at() calls,
> the error return for readlink/readlinkat
> for the empty pathname has switched from
> ENOENT to EINVAL. And this patch merged to linux v2.6.39,
> So LTP commit https://github.com/linux-test-project/ltp/commit/0cc7514
> fix this with the kernel version v2.6.39 compared.
> 
> But recently, commit http://git.kernel.org/linus/1fa1e7f6
> which ensure we return ENOENT for the empty pathname
> for normal lookups.
> 
> Now, the patch whitch switch the return value back again
> is already queued for 3.0 and 3.1 stable release.
> 
> So, if the return value is EINVAL for empty pathname,
> it may be a kernel bug, so we needn't to check the kernel
> version but return the "kernel bug" warning  to LTP the users.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> Acked-by: Jan Stancek <jstancek@redhat.com>

Acked-by: Caspar Zhang <caspar@casparzhang.com>

> ---
>  testcases/kernel/syscalls/readlink/readlink03.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/readlink/readlink03.c b/testcases/kernel/syscalls/readlink/readlink03.c
> index 370bf7d..5ae8513 100644
> --- a/testcases/kernel/syscalls/readlink/readlink03.c
> +++ b/testcases/kernel/syscalls/readlink/readlink03.c
> @@ -173,11 +173,6 @@ int main(int ac, char **av)
>  				buf_size = sizeof(buffer);
>  			}
>  
> -			if (strncmp(test_desc, "Symlink Pathname is empty", 25) == 0) {
> -				if ((tst_kvercmp(2, 6, 39)) >= 0)
> -					Test_cases[i].exp_errno = EINVAL;
> -			}
> -
>  			/*
>  			 * Call readlink(2) to test different test conditions.
>  			 * verify that it fails with -1 return value and sets
> @@ -204,6 +199,10 @@ int main(int ac, char **av)
>  					 "errno=%d, expected errno=%d",
>  					 test_desc, TEST_ERRNO,
>  					 Test_cases[i].exp_errno);
> +				if ((strncmp(test_desc, "Symlink Pathname is empty", 25) == 0) &&
> +				     TEST_ERRNO == EINVAL)
> +					tst_resm(TWARN, "It may be a Kernel Bug, see the patch:"
> +						 "http://git.kernel.org/linus/1fa1e7f6");
>  			}
>  		}
>  	}


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
