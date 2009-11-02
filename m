Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N4xbb-0005b9-1W
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 14:09:59 +0000
Date: Mon, 2 Nov 2009 15:09:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091102140939.GB16607@schrodinger.suse.cz>
References: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] Build Fails on some archs
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi!
> # uname -a
> Linux 2.6.18-164.el5 #1 SMP Tue Aug 18 15:53:50 EDT 2009 s390x s390x
> s390x GNU/Linux
> # cat /etc/issue
> Red Hat Enterprise Linux Server release 5.4 (Tikanga)
> Kernel \r on an \m
>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> -I../../../../../include -I../../../../../include
> -L/root/subrata/ltp/ltp-full-20091031/testcases/kernel/controllers/cpuset/cpuset_syscall_test/../cpuset_lib -L../../../../../lib  cpuset_syscall_test.c   -lltp -lcpu_set -o cpuset_syscall_test
> cpuset_syscall_test.c: In function 'get_mempolicy':
> cpuset_syscall_test.c:67: error: '__NR_get_mempolicy' undeclared (first
> use in this function)
> cpuset_syscall_test.c:67: error: (Each undeclared identifier is reported
> only once
> cpuset_syscall_test.c:67: error: for each function it appears in.)
> cpuset_syscall_test.c: In function 'mbind':
> cpuset_syscall_test.c:73: error: '__NR_mbind' undeclared (first use in
> this function)
> cpuset_syscall_test.c: In function 'set_mempolicy':
> cpuset_syscall_test.c:78: error: '__NR_set_mempolicy' undeclared (first
> use in this function)
> cpuset_syscall_test.c: In function 'process_options':
> cpuset_syscall_test.c:100: warning: unused variable 'file'
> cpuset_syscall_test.c: In function 'test_mbind':
> cpuset_syscall_test.c:177: warning: format '%lx' expects type 'long
> unsigned int', but argument 2 has type 'void *'
> make[5]: *** [cpuset_syscall_test] Error 1

Looks like set_mempolicy get_mempolicy and mbind are missing in
testcases/kernel/include/s390x.in.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
