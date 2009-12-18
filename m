Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NLX8C-0000wI-ER
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 07:20:08 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-3.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NLX87-0007Q5-03
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 07:20:08 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Dec 2009 16:19:52 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 18 Dec 2009 16:19:52 +0900
Message-ID: <000001ca7fb2$7e069fb0$7a13df10$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] Build error of "regress.c"
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
To: ltp-list@lists.sourceforge.net

Hi,

I ran "make" with "ltp-2009-12-16" and "ltp-2009-12-18" cvs, 
but it failed:
------------
[...]
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../include
-I../../../include
  -L../../../lib
-L/home/mitani/LTP/ltp-2009-12-18/testcases/kernel/syscalls/libevent/lib
 libevent/test/regress.c  -levent -o libevent/test/regress
libevent/test/regress.c:44:19: error: event.h: No such file or directory
libevent/test/regress.c: In function 'simple_read_cb':
libevent/test/regress.c:69: warning: implicit declaration of function
'event_add'
libevent/test/regress.c: In function 'multiple_write_cb':
libevent/test/regress.c:100: warning: implicit declaration of function
'event_del'
libevent/test/regress.c: In function 'signal_cb':
libevent/test/regress.c:159: warning: implicit declaration of function
'signal_del'
libevent/test/regress.c: At top level:
libevent/test/regress.c:164: error: field 'ev' has incomplete type
[...]
libevent/test/regress.c:455: warning: implicit declaration of function
'bufferevent_write'
libevent/test/regress.c:459: warning: implicit declaration of function
'bufferevent_free'
libevent/test/regress.c: In function 'main':
libevent/test/regress.c:473: warning: implicit declaration of function
'event_init'
make[3]: *** [libevent/test/regress] Error 1
make[3]: Leaving directory
`/home/mitani/LTP/ltp-2009-12-18/testcases/kernel/syscalls'
make[2]: *** [all] Error 2
[...]
------------

"regress.c" was not compiled before "ltp-2009-12-15" cvs.
It seems to have been compiled after "ltp-2009-12-16" cvs 
for the first time.


The results of "make" are various by environment as follows:

  (1) RHEL5.4(2.6.18-164.el5) x86    : succeeded
  (2) RHEL5.4(2.6.18-164.el5) x86_64 : failed
  (3) RHEL5.4(2.6.18-164.el5) ia64   : failed
  (4) RHEL4.8(2.6.9-89.ELsmp) x86    : succeeded

There is "/usr/local/include/event.h" file in the successful system.
There is not "/usr/local/include/event.h" file in the failed system.

"/usr/local/include/event.h" file completely accords with 
"${LTPROOT}/testcases/kernel/syscalls/libevent/event.h" file.
I think that "${LTPROOT}/testcases/kernel/syscalls/libevent/event.h"
copied to "/usr/local/include/event.h" when installed.

However, depending on system, there seems to be the case that 
this file isn't copied.


---

Instead of "/usr/local/include/event.h", I installed "libevent-devel"
(libevent-devel-1.1a-3.2.1.x86_64.rpm) to above (2) system.
Then "/usr/include/event.h" file was installed.
This "/usr/include/event.h" file does not completely accord with
"/usr/local/include/event.h".
But after that, "make" succeeded.

I don't think that this measure is right. This is the wrong way, I think.
Because, I judge that LTP is going to copy a "/usr/local/include/event.h"
file by oneself.



Thank you--

-Tomonori Mitani




------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
