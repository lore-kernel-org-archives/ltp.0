Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MW4Ni-00086g-0u
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 08:19:26 +0000
Received: from fg-out-1718.google.com ([72.14.220.153])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MW4Ng-0002RO-3g
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 08:19:25 +0000
Received: by fg-out-1718.google.com with SMTP id e12so881580fga.9
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2009 01:19:17 -0700 (PDT)
Message-ID: <4A700600.3000004@petalogix.com>
Date: Wed, 29 Jul 2009 10:19:12 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
Subject: [LTP] getcontext, add_key, fcntl24, fcntl25, fcntl26, open10
Reply-To: michal.simek@petalogix.com
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
To: "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>, LTP <ltp-list@lists.sourceforge.net>

Hi All,

I am seeing with latest LTP code that some test failed but in result log
are labeled as PASS.
For example some tests below.
The next thing is that some tests PASS when function is not implemented
in kernel which seems to me wrong.

Regards,
Michal

add_key01    1  TFAIL  :  add_key01 failed - errno = 38 : Function not
implemented
add_key02    0  TINFO  :  call add_key() with wrong args got UNEXPECTED
errno:38
add_key02    1  TFAIL  :  add_key02 failed - errno = 38 : Function not
implemented

clock_getres01    0  TINFO  :  (case00) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
clock_getres01    0  TINFO  :  (case00) END => OK
clock_getres01    0  TINFO  :  (case01) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
clock_getres01    0  TINFO  :  (case01) END => OK
clock_getres01    0  TINFO  :  (case02) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
clock_getres01    0  TINFO  :  (case02) END => NG
clock_getres01    0  TINFO  :  (case03) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
clock_getres01    0  TINFO  :  (case03) END => NG
clock_getres01    0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
clock_getres01    0  TINFO  :  (case04) END => OK
clock_getres01    0  TINFO  :  (case05) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
clock_getres01    0  TINFO  :  (case05) END => OK
clock_getres01    1  TFAIL  :  clock_getres01 failed - errno = 0 : Success
NG


clock_nanosleep01    0  TINFO  :  (case00) START
clock_nanosleep01    0  TINFO  :  check sleep time: (min:480) < 505 <
(max:520) (msec)
clock_nanosleep01    0  TINFO  :  remain time: 268439676 268439664
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
clock_nanosleep01    0  TINFO  :  (case00) END => OK
clock_nanosleep01    0  TINFO  :  (case01) START
clock_nanosleep01    0  TINFO  :  check sleep time: (min:480) < 508 <
(max:520) (msec)
clock_nanosleep01    0  TINFO  :  remain time: 268439676 268439664
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=0 errno=0 (Success)
clock_nanosleep01    0  TINFO  :  (case01) END => OK
clock_nanosleep01    0  TINFO  :  (case02) START
clock_nanosleep01    0  TINFO  :  remain time: 268439676 268439664
EXPECT: return value(ret)=22 errno=0 (Success)
RESULT: return value(ret)=22 errno=0 (Success)
clock_nanosleep01    0  TINFO  :  (case02) END => OK
clock_nanosleep01    0  TINFO  :  (case03) START
clock_nanosleep01    0  TINFO  :  remain time: 268439676 268439664
EXPECT: return value(ret)=22 errno=0 (Success)
RESULT: return value(ret)=22 errno=0 (Success)
clock_nanosleep01    0  TINFO  :  (case03) END => OK
clock_nanosleep01    0  TINFO  :  (case04) START
clock_nanosleep01    1  TFAIL  :  iclock_gettime failed - errno = 22 :
Invalid argument
clock_nanosleep01    0  TINFO  :  (case04) END => NG
clock_nanosleep01    0  TINFO  :  (case05) START
clock_nanosleep01    0  TINFO  :  remain time: 9 491900032
EXPECT: return value(ret)=4 errno=0 (Success)
RESULT: return value(ret)=4 errno=0 (Success)
clock_nanosleep01    0  TINFO  :  (case05) END => OK
clock_nanosleep01    2  TFAIL  :  clock_nanosleep01 failed - errno = 0 :
Success
clock_nanosleep01    0  TINFO  :  NG

eventfd2_03 not show any information about test.

[2851] posting 1 on 5
[2851] waiting on 6
[2852] posting 1 on 6
[2851] wait completed on 6: count=1
[2851] posting 1 on 5
[2851] waiting on 6
[2852] waiting on 5
[2852] wait completed on 5: count=1
[2852] posting 1 on 6
[2851] wait completed on 6: count=1
[2851] posting 5 on 5
[2851] waiting 5 times on 6
[2852] waiting on 5
[2852] wait completed on 5: count=1
[2852] posting 5 on 6
[2851] wait completed on 6: count=1
[2851] wait completed on 6: count=1
[2851] wait completed on 6: count=1
[2851] wait completed on 6: count=1
[2851] wait completed on 6: count=1
[2852] waiting 5 times on 5
[2852] wait completed on 5: count=1
[2852] wait completed on 5: count=1
[2852] wait completed on 5: count=1
[2852] wait completed on 5: count=1
[2852] wait completed on 5: count=1


fcntl24     1  TFAIL  :  fcntl(tfile_3302, F_SETLEASE, F_WRLCK) Failed,
errno=11 : Resource temporarily unavailable
fcntl24     1  TFAIL  :  fcntl(tfile_3303, F_SETLEASE, F_WRLCK) Failed,
errno=11 : Resource temporarily unavailable
fcntl25     1  TFAIL  :  fcntl(tfile_3304, F_SETLEASE, F_WRLCK) Failed,
errno=11 : Resource temporarily unavailable
fcntl25     1  TFAIL  :  fcntl(tfile_3305, F_SETLEASE, F_WRLCK) Failed,
errno=11 : Resource temporarily unavailable
fcntl26     1  TFAIL  :  fcntl(tfile_3306, F_SETLEASE, F_WRLCK) Failed,
errno=11 : Resource temporarily unavailable
fcntl26     1  TFAIL  :  fcntl(tfile_3307, F_SETLEASE, F_WRLCK) Failed,
errno=11 : Resource temporarily unavailable


getcontext01    1  TFAIL  :  getcontext - Sanity test :  Fail errno=38 :
Function not implemented

get_mempolicy01    0  TINFO  :  (case00) START
get_mempolicy01    1  TFAIL  :  set_mempolicy() failed - errno = 38 :
Function not implemented


io_cancel01    1  TCONF  :  System doesn't support execution of the test
io_destroy01    1  TCONF  :  System doesn't support execution of the test
io_getevents01    1  TCONF  :  System doesn't support execution of the test
io_setup01    1  TCONF  :  System doesn't support execution of the test
io_submit01    1  TCONF  :  System doesn't support execution of the test


mbind01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case00) END => NG
mbind01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case01) END => NG
mbind01     0  TINFO  :  (case02) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case02) END => NG
mbind01     0  TINFO  :  (case03) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case03) END => NG
mbind01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case04) END => NG
mbind01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case05) END => NG
mbind01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case06) END => NG
mbind01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=0 errno=0 (Success)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case07) END => NG
mbind01     0  TINFO  :  (case08) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case08) END => NG
mbind01     0  TINFO  :  (case09) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case09) END => NG
mbind01     0  TINFO  :  (case10) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=38 (Function not implemented)
mbind01     0  TINFO  :  (case10) END => NG
mbind01     1  TFAIL  :  mbind01 failed - errno = 38 : Function not
implemented --NG--



open10      1  TPASS  :  Test passed in block0.
open10      2  TPASS  :  Test passed in block1.
open10      3  TFAIL  :  open10.testdir.B.1300/setgid: Incorrect modes,
setgid bit not set
open10      4  TFAIL  :  Test failed in block2.
open10      5  TPASS  :  Test passed in block3.
open10      0  TINFO  :  Warning: open10.testdir.A.1300 not removed
open10      0  TINFO  :  Warning: open10.testdir.B.1300 not removed
errno is 39
open10      6  TFAIL  :  Test failed because of above failures.



-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
