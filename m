Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SYYHr-0001C2-7w
	for ltp-list@lists.sourceforge.net; Sun, 27 May 2012 07:53:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SYYHo-0005bZ-Qd
	for ltp-list@lists.sourceforge.net; Sun, 27 May 2012 07:53:15 +0000
Message-ID: <4FC1D8C5.4050804@cn.fujitsu.com>
Date: Sun, 27 May 2012 15:33:25 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CAGH67wQmnoUVOftT8=hL_T7Tv28WdGaQpmL09YQ5LWWqf=9U2w@mail.gmail.com>
In-Reply-To: <CAGH67wQmnoUVOftT8=hL_T7Tv28WdGaQpmL09YQ5LWWqf=9U2w@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Fix the fork/11-1 conformance testcase
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 05/26/2012 10:15 PM, Garrett Cooper wrote:

> The testcase tests to see whether or not locks are successfully
> inherited across forking processes, as the requirements for fork state
> that they should not be. The problem is that the test tests the negative
> case for ftrylockfile (!= 0) instead of the positive case, which creates


The ftrylockfile() function returns zero for success (the lock was obtained),
and nonzero for failure. 
So I think the origin is right.

Thanks,
Wanlong Gao

> an erroneous test failure as OUTPUT goes to /dev/stdout and the test
> hangs.
> 
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> 
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> index ffff125..632b0db 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/11-1.c
> @@ -85,7 +85,7 @@ void * threaded(void * arg)
>         int ret;
>         ret = ftrylockfile(stdout);
> 
> -       if (ret != 0)
> +       if (ret == 0)
>         {
>                 FAILED("The child process is owning the file lock.");
>         }
> @@ -168,4 +168,4 @@ int main(int argc, char * argv[])
>  #endif
> 
>         PASSED;
> -}
> \ No newline at end of file
> +}
> 
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and 
> threat landscape has changed and how IT managers can respond. Discussions 
> will include endpoint security, mobile security and the latest in malware 
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> 
> 
> 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
