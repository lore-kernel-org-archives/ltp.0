Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SyCM4-0005yL-H7
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 01:43:36 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SyCM3-0001gE-37
	for ltp-list@lists.sourceforge.net; Mon, 06 Aug 2012 01:43:36 +0000
Message-ID: <501F20F5.3060301@cn.fujitsu.com>
Date: Mon, 06 Aug 2012 09:42:13 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1344032944-27019-1-git-send-email-vlee@twitter.com>
In-Reply-To: <1344032944-27019-1-git-send-email-vlee@twitter.com>
Subject: Re: [LTP] [PATCH] ltp_signal.h: Remove inline keyword from
	handler_h.
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

On 08/04/2012 06:29 AM, Vinson Lee wrote:
> This patch fixes this build error with clang.
> 
> testcases/kernel/syscalls/rt_sigaction/../../../../include/ltp_signal.h:85: undefined reference to `handler_h'

If you wanna build LTP with LLVM, why not make out "a path for LLVM building" and send
out it. I think this one line change can't do everything for LLVM building, although
untested. right?

Thanks,
Wanlong Gao

> 
> Signed-off-by: Vinson Lee <vlee@twitter.com>
> ---
>  include/ltp_signal.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/ltp_signal.h b/include/ltp_signal.h
> index 1ac6f70..093059f 100644
> --- a/include/ltp_signal.h
> +++ b/include/ltp_signal.h
> @@ -69,7 +69,7 @@ struct kernel_sigaction {
>  
>  void (*restore_rt) (void);
>  
> -inline void
> +void
>  handler_h (int signal)
>  {
>  	return;
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
