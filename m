Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunyuan3@huawei.com>) id 1Z7xG2-00045i-Qk
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 02:51:18 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z7xFy-00063f-TT
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 02:51:18 +0000
Message-ID: <558B6C8C.5000202@huawei.com>
Date: Thu, 25 Jun 2015 10:50:52 +0800
From: Yuan Sun <sunyuan3@huawei.com>
MIME-Version: 1.0
Subject: [LTP] Cedric
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
To: ced.hnyda@gmail.com
Cc: ltp-list@lists.sourceforge.net

Hi Cedric,
     I encounter the following error in ubuntu14.04. Your patch
"syscall/getrandom: Add tests for getrandom" leads to the error.
     Do I need to install new libraries?
     Could you please check with the issue?
     Thanks.
         Yuan

make[4]: Entering directory 
`/home/s00318865/0625/ltp/testcases/kernel/syscalls/getrandom'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 
-Wold-style-definition 
-I/home/s00318865/0625/ltp/testcases/kernel/include 
-I../../../../include -I../../../../include   -L../../../../lib 
getrandom01.c   -lltp -o getrandom01
getrandom01.c:34:26: error: 'GRND_RANDOM' undeclared here (not in a 
function)
  static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
                           ^
getrandom01.c:34:39: error: 'GRND_NONBLOCK' undeclared here (not in a 
function)
  static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
                                        ^
In file included from ../../../../include/test.h:46:0,
                  from getrandom01.c:32:
getrandom01.c: In function 'main':
getrandom01.c:51:17: error: 'SYS_getrandom' undeclared (first use in 
this function)
     TEST(syscall(SYS_getrandom, NULL, 100, modes[i]));
                  ^
../../../../include/usctest.h:69:17: note: in definition of macro 'TEST'
    TEST_RETURN = SCALL; \
                  ^
getrandom01.c:51:17: note: each undeclared identifier is reported only 
once for each function it appears in
     TEST(syscall(SYS_getrandom, NULL, 100, modes[i]));
                  ^
../../../../include/usctest.h:69:17: note: in definition of macro 'TEST'
    TEST_RETURN = SCALL; \
                  ^
getrandom01.c:51:4: warning: passing argument 1 of 'syscall' makes 
integer from pointer without a cast [enabled by default]
     TEST(syscall(SYS_getrandom, NULL, 100, modes[i]));
     ^
In file included from ../../../../include/test.h:39:0,
                  from getrandom01.c:32:
/usr/include/unistd.h:1058:17: note: expected 'long int' but argument is 
of type 'int *'
  extern long int syscall (long int __sysno, ...) __THROW;
                  ^
make[4]: *** [getrandom01] Error 1
make[4]: Leaving directory 
`/home/s00318865/0625/ltp/testcases/kernel/syscalls/getrandom'
make[3]: *** [all] Error 2
make[3]: Leaving directory 
`/home/s00318865/0625/ltp/testcases/kernel/syscalls'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/s00318865/0625/ltp/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/s00318865/0625/ltp/testcases'
make: *** [testcases-all] Error 2

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
