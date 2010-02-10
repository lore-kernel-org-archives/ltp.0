Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NfLvw-00084b-QQ
	for ltp-list@lists.sourceforge.net; Wed, 10 Feb 2010 23:25:24 +0000
Received: from mail-yw0-f186.google.com ([209.85.211.186])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NfLvw-0003IV-12
	for ltp-list@lists.sourceforge.net; Wed, 10 Feb 2010 23:25:24 +0000
Received: by ywh16 with SMTP id 16so660978ywh.25
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Feb 2010 15:25:18 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000101caaa19$f3feb220$dbfc1660$@co.jp>
Date: Wed, 10 Feb 2010 15:25:14 -0800
Message-Id: <D9EDA073-FF89-414B-B633-ADF2A5DE5A20@gmail.com>
References: <000101caaa19$f3feb220$dbfc1660$@co.jp>
Subject: Re: [LTP] "check_netns_enabled.c" build failed with "2010-02-10" cvs
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Feb 9, 2010, at 10:26 PM, Mitani wrote:

> Hi,
> 
> I tried to build with "2010-02-10" cvs in my systems.
> I tried in RHEL5.4 (2.6.18-164.el5) and RHEL4.8 (2.6.9-89.ELsmp).
> But "make" failed in "check_netns_enabled.c" as follows in RHEL4.8:
> ------------
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/home/LTP/ltp-2010-02-10/testcases/kernel/include
> -I/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/../libclone
> -I../../../../include -I../../../../include
> -L/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/../libclone
> -L../../../../lib  check_netns_enabled.c   -lltp -o check_netns_enabled
> check_netns_enabled.c: In function `main':
> check_netns_enabled.c:40: warning: implicit declaration of function
> `unshare'
> /tmp/cciXlXlf.o(.text+0x2c): In function `main':
> /home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/check_netns_enabl
> ed.c:40: undefined reference to `unshare'
> collect2: ld returned 1 exit status
> make[4]: *** [check_netns_enabled] Error 1
> make[4]: Leaving directory
> `/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns'
> ------------
> 
> "unshare()" function was supported after kernel 2.6.16.
> Therefore, "make" of "check_netns_enabled.c" failed in RHEL4.8, I think.
> 
> I made patch and "make" succeeded:
> ============
> --- ./testcases/kernel/containers/netns/check_netns_enabled.c   2008-09-19
> 21:17:10.000000000 +0900
> +++ ./testcases/kernel/containers/netns/check_netns_enabled.c.new
> 2010-02-10 14:59:53.000000000 +0900
> @@ -37,10 +37,12 @@
>        if (tst_kvercmp(2,6,24) < 0)
>                return 1;
> 
> +#ifdef HAVE_UNSHARE
>         ret = unshare(flags);
>        if ( ret < 0 ) {
>                printf ("Error:Unshare syscall failed for network
> namespace\n");
>                return 3;
>        }
> +#endif
>        return 0;
> }
> ============
> 
> I'm glad if I could get some opinions.

	Should be fixed now.
-Garrett
------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
