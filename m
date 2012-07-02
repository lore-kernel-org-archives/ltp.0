Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SlepE-00006N-HF
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 11:29:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SlepA-00011Q-6E
	for ltp-list@lists.sourceforge.net; Mon, 02 Jul 2012 11:29:52 +0000
Message-ID: <4FF18618.3040509@cn.fujitsu.com>
Date: Mon, 02 Jul 2012 19:29:28 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1341226390-16789-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1341226390-16789-1-git-send-email-eguan@redhat.com>
Subject: Re: [LTP] [PATCH] syscalls/setxattr03: turn off immutable and
 append bit only if already set
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
To: Eryu Guan <eguan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 07/02/2012 06:53 PM, Eryu Guan wrote:
> 
> Turn off immutable and append-only attribute in cleanup() only if they
> are already turned on. Otherwise bogus WARNING would fail test case when
> no xattr support in fs or mount without user_xattr option.
> 
> setxattr03    1  TCONF  :  No xattr support in fs or fs mounted without user_xattr option
> setxattr03    2  TCONF  :  Remaining cases not appropriate for configuration
> setxattr03    0  TWARN  :  Unset setxattr03immutable immutable failed: errno=EINVAL(22): Invalid argument
> setxattr03    0  TWARN  :  Unset setxattr03appendonly append-only failed: errno=EINVAL(22): Invalid argument
> 
> (The check-fd-value way is not perfect, but I think it's much more
> easier and could cover the most common case.)

pushed, thanks,


Wanlong Gao

> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  testcases/kernel/syscalls/setxattr/setxattr03.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
