Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZpBCr-0003Hu-1y
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2015 08:26:41 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZpBCp-0006RH-Rl
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2015 08:26:40 +0000
Message-ID: <1445501674.1125.32.camel@G08FNSTD140232>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 22 Oct 2015 16:14:34 +0800
In-Reply-To: <CAOVJa8HkBesYGEuEocDWgeSUpGxntKFEPnS7vU6xjR+4maWYsw@mail.gmail.com>
References: <CAOVJa8FYtVzST_sEkeWxaEVFCC1FBo_ASgDjncAy50AaYiFGhA@mail.gmail.com>
	<CANKSX+EC8p803DByyYE4ECw11gQk4a3Hr1SKZXpPPjw8aoz-fQ@mail.gmail.com>
	<CAOVJa8HkBesYGEuEocDWgeSUpGxntKFEPnS7vU6xjR+4maWYsw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [LTP] how to cross compile linux test project?
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
To: vichy <vichy.kuo@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hello,

On Thu, 2015-10-22 at 13:41 +0800, vichy wrote:
> hi Strik:
> 
> 2015-10-21 23:59 GMT+08:00 $rik@nth <srikanth007m@gmail.com>:
> > you need to run autoconf program with no arguments and then autoconf
> > processes `configure.ac' to generate configure file.
> when i use autoconf I get below error message
> # autoconf
> configure.ac:4: error: possibly undefined macro: AM_INIT_AUTOMAKE
>       If this token and others are legitimate, please use m4_pattern_allow.
>       See the Autoconf documentation.
> configure.ac:15: error: possibly undefined macro: AM_CONDITIONAL
> #

I think you should do like:
1. cd <ltp>
2. aclocal -I m4
3. autoconf
4. autoheader
5. automake -c -a

And you can do "make autotools" instead of "step 2, 3, 4, 5"

Thanks,
Zeng



> 
> I use ubuntu 14.04 64bit to cross compile linux test project.
> appreciate your kind help,
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list



------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
