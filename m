Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SeMQz-00010A-7l
	for ltp-list@lists.sourceforge.net; Tue, 12 Jun 2012 08:26:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SeMQt-0000d3-2m
	for ltp-list@lists.sourceforge.net; Tue, 12 Jun 2012 08:26:41 +0000
Message-ID: <4FD6FCE4.6080700@cn.fujitsu.com>
Date: Tue, 12 Jun 2012 16:25:08 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1339464445-21694-1-git-send-email-vlee@twitter.com>
In-Reply-To: <1339464445-21694-1-git-send-email-vlee@twitter.com>
Subject: Re: [LTP] [PATCH] filecaps: Fix build.
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
To: Vinson Lee <vlee@twitter.com>
Cc: ltp-list@lists.sourceforge.net

On 06/12/2012 09:27 AM, Vinson Lee wrote:
> Fix build error that was introduced at commit
> 66ad27e08d774c572e99e97cc9b885295ec0aa55.
> 
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/tmp/ltp/testcases/kernel/include -D_GNU_SOURCE -I../../../../include
> -I../../../../include -L../../../../lib c.c -lltp -o c c.c:22:28: fatal
> error: sys/capability.h: No such file or directory
> 
> Signed-off-by: Vinson Lee <vlee@twitter.com>

pushed, thanks Vinson.

Wanlong Gao

> ---
>  testcases/kernel/security/filecaps/c.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/testcases/kernel/security/filecaps/c.c b/testcases/kernel/security/filecaps/c.c
> index 38c1516..fbd0365 100644
> --- a/testcases/kernel/security/filecaps/c.c
> +++ b/testcases/kernel/security/filecaps/c.c
> @@ -19,7 +19,9 @@
>  /******************************************************************************/
>  
>  #include <stdio.h>
> +#if HAVE_SYS_CAPABILITY_H
>  #include <sys/capability.h>
> +#endif
>  
>  int main()
>  {
> 



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
