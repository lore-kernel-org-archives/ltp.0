Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SrPNA-0000SQ-7W
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 08:12:40 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SrPN5-0005LQ-Ca
	for ltp-list@lists.sourceforge.net; Wed, 18 Jul 2012 08:12:40 +0000
Message-ID: <50066FBF.9080209@cn.fujitsu.com>
Date: Wed, 18 Jul 2012 16:11:43 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1342194676-15275-1-git-send-email-marios.makris@gmail.com>
	<1342194676-15275-2-git-send-email-marios.makris@gmail.com>
In-Reply-To: <1342194676-15275-2-git-send-email-marios.makris@gmail.com>
Subject: Re: [LTP] [PATCH 2/6] Add mkdtemp check.
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
To: Marios Makris <marios.makris@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Cyril Hrubis <metan@ucw.cz>

On 07/13/2012 11:51 PM, Marios Makris wrote:
> From: Cyril Hrubis <metan@ucw.cz>
> 
> Added an m4 macro checking for mkdtemp()
> 
> Signed-off-by: Cyril Hrubis <metan@ucw.cz>
> Signed-off-by: Marios Makris <marios.makris@gmail.com>

Reviewed-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> ---
>  configure.ac      |    1 +
>  m4/ltp-mkdtemp.m4 |    2 ++
>  2 files changed, 3 insertions(+)
>  create mode 100644 m4/ltp-mkdtemp.m4
> 
> diff --git a/configure.ac b/configure.ac
> index 1696df0..f217f50 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -145,6 +145,7 @@ fi
>  
>  # END testsuites knobs
>  
> +LTP_CHECK_MKDTEMP
>  LTP_CHECK_CAPABILITY_SUPPORT
>  LTP_CHECK_CRYPTO
>  LTP_CHECK_LINUX_PTRACE
> diff --git a/m4/ltp-mkdtemp.m4 b/m4/ltp-mkdtemp.m4
> new file mode 100644
> index 0000000..94a6d49
> --- /dev/null
> +++ b/m4/ltp-mkdtemp.m4
> @@ -0,0 +1,2 @@
> +AC_DEFUN([LTP_CHECK_MKDTEMP],[
> +AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))])
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
