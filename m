Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O2qRr-0001Mq-U9
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 18:39:27 +0000
Received: from mail-pz0-f204.google.com ([209.85.222.204])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O2qRp-0004YS-LD
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 18:39:27 +0000
Received: by pzk42 with SMTP id 42so2206239pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Apr 2010 11:39:20 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1078)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <000a01cad7b9$2b1be350$8153a9f0$@co.jp>
Date: Fri, 16 Apr 2010 11:39:13 -0700
Message-Id: <88B386A8-E068-4FDB-A9FD-295BBFEBF0A8@gmail.com>
References: <000001cad173$3c32b200$b4981600$@co.jp>
	<20100401083510.GD13796@linux.vnet.ibm.com>
	<000101cad17c$ee4946d0$cadbd470$@co.jp>
	<20100401093511.GA25290@linux.vnet.ibm.com>
	<000001cad18d$ea091c60$be1b5520$@co.jp>
	<20100401152647.GH22648@us.ibm.com>
	<000301cad20b$2269c230$673d4690$@co.jp>
	<20100405132004.GA32049@us.ibm.com>
	<000a01cad7b9$2b1be350$8153a9f0$@co.jp>
Subject: Re: [LTP] cap_bounds_r.c build failure
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

On Apr 9, 2010, at 12:49 AM, Mitani wrote:

> Hi,
> 
> Thank you for your help.
> 
> I tried to "make" with Serge's patch in my system.
> But, sorry, it failed.
> 
> 
> ---
> 
> I did with following procedure:
> 
> 1) I did "make" and "make install" of "libcap-2.11" .
> 
> 2) I confirmed about following files.
> ------------
> [root@RHEL4-8 include]# pwd
> /usr/include
> [root@RHEL4-8 include]# ls -l sys/capability.h
> -rw-r--r--  1 root root 3345 Apr  9 15:44 sys/capability.h
> [root@RHEL4-8 include]# ls -l linux/capability.h
> -rw-r--r--  1 root root 8273 May 14  2008 linux/capability.h
> [root@RHEL4-8 include]#
> ------------
> "sys/capability.h" replased by "libcap-2.11" .
> 
> 3) I applied patch to "m4/ltp-cap.m4", and confirmed it.
> ------------
> ...
> AC_DEFUN([LTP_CHECK_CAPABILITY_SUPPORT],[
> AH_TEMPLATE(HAVE_LIBCAP,
> [Define to 1 if you have libcap-2 installed.])
> AC_CHECK_HEADERS(sys/capability.h,[
>        LTP_CAPABILITY_SUPPORT=yes
>        AC_CHECK_DECL(VFS_CAP_REVISION_2,[AC_DEFINE(HAVE_LIBCAP)
> CAP_LIBS="-lcap"],[CAP_LIBS=""],[#include "linux/capability.h"])
>        AC_CHECK_PROG(HAVE_SETCAP,setcap,setcap,false)
> ])]
> AC_SUBST(CAP_LIBS)
> )
> ------------
> 
> 4) I did "./configure", and confirmed "configure.log" .
> ------------
> ...
> | #define HAVE_SYS_CAPABILITY_H 1
> | #define HAVE_LIBCAP 1
> | #define HAVE_SYS_PRCTL_H 1
> | #define HAVE_DECL_PR_CAPBSET_DROP 0
> | #define HAVE_DECL_PR_CAPBSET_READ 0
> ...
> ------------
> "HAVE_LIBCAP" define was ON.
> 
> 5) I tried to "make", but it failed as foliows.
> ------------
> cap_bounds_r.c: In function `main':
> cap_bounds_r.c:46: error: `CAP_LAST_CAP' undeclared (first use in this
> function)
> cap_bounds_r.c:46: error: (Each undeclared identifier is reported only once
> cap_bounds_r.c:46: error: for each function it appears in.)
> make[4]: *** [cap_bounds_r] Error 1
> ------------
> 
> 
> I don't know about configure well, and I examine it.
> 
> 
> Thank you--
> 
> -Tomonori Mitani
> 
> 
>> -----Original Message-----
>> From: Serge E. Hallyn [mailto:serue@us.ibm.com]
>> Sent: Monday, April 05, 2010 10:20 PM
>> To: Mitani
>> Cc: Rishikesh K Rajak; Andrew Morgan; Garrett Cooper;
>> ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] cap_bounds_r.c build failure
>> 
>> Quoting Mitani (mitani@ryobi.co.jp):
>>> Hi,
>>> 
>>> 
>>> I tired to upgrade "libcap" from "libcap-1.0-20" to "libcap-2.11".
>>> My system is RHEL4.8 (x86) and kernel version is 2.6.9-89.ELsmp.
>> 
>> Oh, I'm sorry, I misunderstood from the first.  I thought you wanted
>> to test a modern kernel on an older distro.  So the real problem in
>> your original email wasn't that cap_bounds_r.c wouldn't compile, but
>> that it tried to compile.
>> 
>> Maybe the attached ltp patch will do a better job of not trying
>> to compile.  Though I'm not sure what is the best way to detect
>> both 64-bit caps in kernel and libcap2 userspace.
>> 
>> -serge
>> 
>> Date: Mon, 5 Apr 2010 08:17:46 -0500
>> Subject: [PATCH ltp] don't compile cap_bounds on older systems
>> 
>> Only define HAVE_LIBCAP for libcap2 and 64-bit caps.
>> 
>> Signed-off-by: Serge Hallyn <serue@us.ibm.com>
>> ---
>> m4/ltp-cap.m4 |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
>> index caa436f..6248ff3 100644
>> --- a/m4/ltp-cap.m4
>> +++ b/m4/ltp-cap.m4
>> @@ -27,7 +27,7 @@ AH_TEMPLATE(HAVE_LIBCAP,
>> [Define to 1 if you have libcap-2 installed.])
>> AC_CHECK_HEADERS(sys/capability.h,[
>> 	LTP_CAPABILITY_SUPPORT=yes
>> -	AC_CHECK_LIB(cap,cap_compare,[AC_DEFINE(HAVE_LIBCAP)
>> CAP_LIBS="-lcap"], [CAP_LIBS=""])
>> +	AC_CHECK_DECL(VFS_CAP_REVISION_2,[AC_DEFINE(HAVE_LIBCAP)
>> CAP_LIBS="-lcap"],[CAP_LIBS=""],[#include "linux/capability.h"])
>> 	AC_CHECK_PROG(HAVE_SETCAP,setcap,setcap,false)
>> ])]
>> AC_SUBST(CAP_LIBS)
>> --
>> 1.6.3.3

	All of the necessary details are in INSTALL.
HTH,
-Garrett


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
