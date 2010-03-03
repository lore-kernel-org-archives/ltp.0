Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NmhZO-0000lw-3n
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 05:56:30 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NmhZN-0006uq-6R
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 05:56:30 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o235suJ0021618
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 22:54:56 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o235uNDt117264
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 22:56:23 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o235uMkj002925
	for <ltp-list@lists.sourceforge.net>; Tue, 2 Mar 2010 22:56:23 -0700
Date: Wed, 3 Mar 2010 11:26:19 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100303055619.GA19084@linux.vnet.ibm.com>
References: <OF3DD1AE6A.65D45C56-ON652576DA.002F585D-652576DA.00384F54@in.ibm.com>
	<20100302152135.GA6691@us.ibm.com>
	<B02F7096-7406-4AAE-8BBF-AD16D5228F47@gmail.com>
	<20100302173535.GA14556@us.ibm.com>
	<5EEDD2C4-6C6C-4008-81AA-65B78FA3E7C8@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5EEDD2C4-6C6C-4008-81AA-65B78FA3E7C8@gmail.com>
Subject: Re: [LTP] LTP's filecaps test gives false positive results
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
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Iranna D Ankad <iranna.ankad@in.ibm.com>

On Tue, Mar 02, 2010 at 10:25:23AM -0800, Garrett Cooper wrote:
> On Mar 2, 2010, at 9:35 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> > Quoting Garrett Cooper (yanegomi@gmail.com):
> >>
> >> That would be from me; I do that via autoconf and they probably
> >> fubared the headers on Redhat or something... Do you have
> >
> > Oh, ok.  Well I suspect we can ditch the check_simple_capset.c
> > altogether if autoconf is (eventually :) doing the detection for
> > us.  The only point of check_simple_capset.c was to check whether
> > libcap is there and whether we should run the real tests.
> >
> >> libcap-devel installed?
> >
> > yup:
> >
> > [root@oracer4b ltp-dev]# rpm -qa|grep libcap
> > libcap-2.10-2.fc10.x86_64
> > libcap-devel-2.10-2.fc10.x86_64
> >
> > [root@oracer4b ltp-dev]# grep CAP_LIB *
> > config.log:CAP_LIBS=''
> > config.status:S["CAP_LIBS"]=""
> > configure:CAP_LIBS'
> > configure:                    CAP_LIBS="-lcap"
> >
> > so somehow -lcap was not detected by configure?
> 
> Well some of the definitions are there but maybe not all of them.  
> config.log would help...
> 

Here is the config.log snapshot, it seems it has some error:

...
configure:5543: checking whether CAP_BSET_DROP is declared
configure:5574: gcc -c -g -O2  conftest.c >&5
conftest.c: In function 'main':
conftest.c:38: error: 'CAP_BSET_DROP' undeclared (first use in this
function)
conftest.c:38: error: (Each undeclared identifier is reported only once
conftest.c:38: error: for each function it appears in.)
configure:5581: $? = 1
configure: failed program was:
| /* confdefs.h.  */
| #define PACKAGE_NAME "ltp"
| #define PACKAGE_TARNAME "ltp"
| #define PACKAGE_VERSION "LTP_VERSION"
| #define PACKAGE_STRING "ltp LTP_VERSION"
| #define PACKAGE_BUGREPORT "ltp-results@lists.sourceforge.net"
| #define PACKAGE "ltp"
| #define VERSION "LTP_VERSION"
| #define YYTEXT_POINTER 1
| #define STDC_HEADERS 1
| #define HAVE_SYS_TYPES_H 1
| #define HAVE_SYS_STAT_H 1
| #define HAVE_STDLIB_H 1
| #define HAVE_STRING_H 1
| #define HAVE_MEMORY_H 1
| #define HAVE_STRINGS_H 1
| #define HAVE_INTTYPES_H 1
| #define HAVE_STDINT_H 1
| #define HAVE_UNISTD_H 1
| #define HAVE_IFADDRS_H 1
| #define HAVE_PTHREAD_H 1
| #define HAVE_LINUX_GENETLINK_H 1
| #define HAVE_LINUX_MEMPOLICY_H 1
| #define HAVE_LINUX_NETLINK_H 1
| #define HAVE_SYS_EPOLL_H 1
| #define HAVE_SYS_INOTIFY_H 1
| #define HAVE_SYS_PRCTL_H 1
| #define HAVE_SYS_CAPABILITY_H 1
| #define HAVE_ATTR_XATTR_H 1
| /* end confdefs.h.  */
| #include <sys/capability.h>
|
|
| int
| main ()
| {
| #ifndef CAP_BSET_DROP
|   (void) CAP_BSET_DROP;
| #endif
|
|   ;
|   return 0;
                                                                                                                                                          2879,13

Which file will contains this macro definition ?

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

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
