Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1P1BuK-00056S-Kc
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 05:42:16 +0000
Received: from out15.sjc.mx.trendmicro.com ([216.99.131.72])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P1BuI-0005VD-BZ
	for ltp-list@lists.sourceforge.net; Thu, 30 Sep 2010 05:42:16 +0000
From: "Mitani" <mitani@ryobi.co.jp>
References: <000001cb5fa4$3def0160$b9cd0420$@co.jp>
	<AANLkTikD7h4KtrtUkCkOWciQ9EKG5eL6g-dj_5=Ode62@mail.gmail.com>
In-Reply-To: <AANLkTikD7h4KtrtUkCkOWciQ9EKG5eL6g-dj_5=Ode62@mail.gmail.com>
Date: Thu, 30 Sep 2010 14:42:05 +0900
Message-ID: <000a01cb6062$36b9aa30$a42cfe90$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] POSIX some testsets failed by permission error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Thursday, September 30, 2010 12:16 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] POSIX some testsets failed by permission error
> =

> On Wed, Sep 29, 2010 at 12:02 AM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> >
> > I noticed that following POSIX testsets failed with "Permission
> denied".
> > =A0- pthread_attr_getschedparam/2-1
> > =A0- pthread_attr_setschedparam/2-1
> > =A0- pthread_rwlock_destroy/2-1
> >
> > ------------
> > conformance/interfaces/pthread_attr_getschedparam/2-1: execution:
> FAILED:
> > Output:
> > Unable to run child application: Permission denied
> > [...]
> > conformance/interfaces/pthread_attr_setschedparam/2-1: execution:
> FAILED:
> > Output:
> > Unable to run child application: Permission denied
> > [...]
> > conformance/interfaces/pthread_rwlock_destroy/2-1: execution:
> FAILED:
> > Output:
> > Unable to run child application: Permission denied
> > ------------
> >
> > They are shell scripts, but they weren't given rights of execution.
> >
> > It is necessary to give them rights of execution and to make them
> > into package, I think.
> =

> How did you execute the tests?
> -Garrett


I build and run tests as follows:
------------
  - tar -zxvf ltp-git-XXXX.tar.gz
  - make distclean
  - make all
  - make test
------------


I confirmed their permission:
------------
[root@RHEL55-LTP-x86 pthread_attr_getschedparam]# ls -l
total 36
-rw-rw-r-- 1 root root 2752 Sep 20 23:22 1-1.c
-rwxr-xr-x 1 root root 6742 Sep 21 11:48 1-1.run-test
-rw-rw-r-- 1 root root  453 Sep 20 23:22 2-1.sh
-rw-rw-r-- 1 root root   10 Sep 20 23:22 LDLIBS
-rw-r--r-- 1 root root 1700 Sep 21 11:47 Makefile
-rw-rw-r-- 1 root root  552 Sep 20 23:22 assertions.xml
-rw-rw-r-- 1 root root  120 Sep 20 23:22 coverage.txt
-rwxr-xr-x 1 root root  105 Sep 21 11:55 run.sh

[root@RHEL55-LTP-x86 pthread_attr_setschedparam]# ls -l
total 76
-rw-rw-r-- 1 root root 2194 Sep 20 23:22 1-1.c
-rwxr-xr-x 1 root root 6926 Sep 21 11:48 1-1.run-test
-rw-rw-r-- 1 root root 2184 Sep 20 23:22 1-2.c
-rwxr-xr-x 1 root root 6926 Sep 21 11:48 1-2.run-test
-rw-rw-r-- 1 root root 2801 Sep 20 23:22 1-3.c
-rwxr-xr-x 1 root root 6911 Sep 21 11:48 1-3.run-test
-rw-rw-r-- 1 root root 2904 Sep 20 23:22 1-4.c
-rwxr-xr-x 1 root root 7013 Sep 21 11:48 1-4.run-test
-rw-rw-r-- 1 root root  453 Sep 20 23:22 2-1.sh
-rw-rw-r-- 1 root root   10 Sep 20 23:22 LDLIBS
-rw-r--r-- 1 root root 3005 Sep 21 11:47 Makefile
-rw-rw-r-- 1 root root  802 Sep 20 23:22 assertions.xml
-rw-rw-r-- 1 root root  323 Sep 20 23:22 coverage.txt
-rwxr-xr-x 1 root root  118 Sep 21 11:55 run.sh
drwxrwxr-x 2 root root 4096 Sep 21 11:47 speculative

[root@RHEL55-LTP-x86 pthread_rwlock_destroy]# ls -l
total 48
-rw-rw-r-- 1 root root 1113 Sep 20 23:22 1-1.c
-rwxr-xr-x 1 root root 5390 Sep 21 11:48 1-1.run-test
-rw-rw-r-- 1 root root  397 Sep 20 23:22 2-1.sh
-rw-rw-r-- 1 root root 1395 Sep 20 23:22 3-1.c
-rwxr-xr-x 1 root root 5707 Sep 21 11:48 3-1.run-test
-rw-rw-r-- 1 root root   10 Sep 20 23:22 LDLIBS
-rw-r--r-- 1 root root 2128 Sep 21 11:47 Makefile
-rw-rw-r-- 1 root root  782 Sep 20 23:22 assertions.xml
-rw-rw-r-- 1 root root  156 Sep 20 23:22 coverage.txt
-rwxr-xr-x 1 root root  114 Sep 21 12:48 run.sh
------------

Aren't they given execution permission because they aren't implemented?

I tried to execute them with permission, and successed.
------------
[root@centos5-5 open_posix_testsuite]# chmod 775
conformance/interfaces/pthread_attr_getschedparam/2-1.sh
[root@centos5-5 open_posix_testsuite]# chmod 775
conformance/interfaces/pthread_attr_setschedparam/2-1.sh
[root@centos5-5 open_posix_testsuite]# chmod 775
conformance/interfaces/pthread_rwlock_destroy/2-1.sh
[root@centos5-5 open_posix_testsuite]# make test > make_test_2.txt 2>&1
[root@centos5-5 open_posix_testsuite]# echo $?
2
[root@centos5-5 open_posix_testsuite]# grep Permission
logfile.conformance-test
[root@centos5-5 open_posix_testsuite]#
[root@centos5-5 open_posix_testsuite]# grep
conformance/interfaces/pthread_attr_getschedparam/2-1
logfile.conformance-test
conformance/interfaces/pthread_attr_getschedparam/2-1: execution: PASS
[root@centos5-5 open_posix_testsuite]# grep
conformance/interfaces/pthread_attr_setschedparam/2-1
logfile.conformance-test
conformance/interfaces/pthread_attr_setschedparam/2-1: execution: PASS
[root@centos5-5 open_posix_testsuite]# grep
conformance/interfaces/pthread_rwlock_destroy/2-1 logfile.conformance-test
conformance/interfaces/pthread_rwlock_destroy/2-1: execution: PASS
------------


Thank you--

-Tomonori Mitani




---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
