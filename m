Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NxWVS-0006tf-MP
	for ltp-list@lists.sourceforge.net; Fri, 02 Apr 2010 02:21:10 +0000
Received: from out02.sjc.mx.trendmicro.com ([216.99.131.6])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NxWVQ-0007j1-AC
	for ltp-list@lists.sourceforge.net; Fri, 02 Apr 2010 02:21:10 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cad173$3c32b200$b4981600$@co.jp>
	<20100401083510.GD13796@linux.vnet.ibm.com>
	<000101cad17c$ee4946d0$cadbd470$@co.jp>
	<20100401093511.GA25290@linux.vnet.ibm.com>
	<000001cad18d$ea091c60$be1b5520$@co.jp>
	<20100401152647.GH22648@us.ibm.com>
In-Reply-To: <20100401152647.GH22648@us.ibm.com>
Date: Fri, 2 Apr 2010 11:20:59 +0900
Message-ID: <000301cad20b$2269c230$673d4690$@co.jp>
MIME-Version: 1.0
Content-Language: ja
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
To: "'Serge E. Hallyn'" <serue@us.ibm.com>, Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi,


I tired to upgrade "libcap" from "libcap-1.0-20" to "libcap-2.11".
My system is RHEL4.8 (x86) and kernel version is 2.6.9-89.ELsmp.

I downloaded "libcap-2.11.tar.gz" from following URL :
ftp://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2

I extended it, and I confirmed that there are ".../libcap/include/
linux/capability.h" and ".../libcap/include/sys/capability.h" .
".../libcap/include/linux/capability.h" has "CAP_LAST_CAP" definition.

I did "make" and "make install".
But "/usr/include/linux/capability.h" was not changed.

the "README" of "libcap-2.11" shows follows:
------------
# INSTALLATION

        Linux-Caps % make

                builds the library and the programs

        Linux-Caps % make install

                installs the library libcap.XX.Y in /lib/
                the binaries in /sbin/
                the <sys/capability.h> file in /usr/include
------------
It doesn't mention about "/usr/include/linux/capability.h" .
In fact, "/usr/include/sys/capability.h" was replaced, but 
"/usr/include/linux/capability.h" was not.


I checked where <linux/capability.h> came from, and knew that 
"/usr/include/linux/capability.h" is from "glibc-kernheaders" :
------------
[root@RHEL4-8 cap_bound]# rpm -qf /usr/include/linux/capability.h
glibc-kernheaders-2.4-9.1.103.EL
[root@RHEL4-8 cap_bound]#
------------


There are two ways to upgrade "/usr/include/linux/capability.h" in
RHEL system, I think.
1) Upgrade "glibc-kernheaders".
2) Replace manually "/usr/include/sys/capability.h" with 
   "linux/capability.h" of "libcap-2.11".

1) "glibc-kernheaders" is referenced from many modules of kernel.
   If I want to upgrade "glibc-kernheaders", kernel upgrade is needed, 
   I think.
   It deviates from an original purpose (I want to test RHEL4.8 system).
2) Manually replace is not an original way and it is dangerous.


First of all, I replaced manually "/usr/include/linux/capability.h" .
And I succeeded to build "cap_bounds_r.c" and "cap_bounds_r.c".


But upgrading "libcap" in RHEL system still includes the above 
problems, I think


------
After this, another build failed.
But it is different from above problems, I think.
Therfore, I will report it another thread.


Regards--

-Tomonori Mitani

> -----Original Message-----
> From: Serge E. Hallyn [mailto:serue@us.ibm.com]
> Sent: Friday, April 02, 2010 12:27 AM
> To: Mitani
> Cc: 'Rishikesh K Rajak'; ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] cap_bounds_r.c build failure
> 
> Quoting Mitani (mitani@ryobi.co.jp):
> > Hi Rishi,
> >
> > I installed "libcap-devel", but after configure, build failed, too.
> >
> > ------------
> > [root@RHEL4-8 mitani]# rpm -qa | grep libcap
> > libcap-devel-1.10-20
> > libcap-1.10-20
> > [root@RHEL4-8 mitani]#
> > ------------
> >
> > "libcap-1.10-20" version is normal version in my system (RHEL4.8
> > 2.6.9-89.ELsmp).
> > In this version, capability.h doesn't have CAP_LAST_CAP definition.
> > I try to upgrade version "2.11".
> 
> Yeah, you need libcap2 for these tests.  I guess we could stand
> to add a rule to m4/ltp-cap.m4 to check for the existance of
> libcap.so.2.X, X > oh say 12.
> 
> -serge



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
