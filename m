Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwan@redhat.com>) id 1ZL3jz-0001Sm-Dm
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 06:24:23 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZL3jx-0000O3-Uh
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2015 06:24:23 +0000
Received: from zmail22.collab.prod.int.phx2.redhat.com
	(zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id t6V6OFXL021800
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Jul 2015 02:24:15 -0400
Date: Fri, 31 Jul 2015 02:24:15 -0400 (EDT)
From: Li Wang <liwang@redhat.com>
Message-ID: <1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
In-Reply-To: <751019010.974973.1438321471218.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] How to compie a ltp-case into 32-bit on the 64bit system
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

Hi all,

I am going to add a new testcase: ltp/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c 
for regression test.

But the key point is that this program 'msgrcv08.c' should be compiled into 32-bit, 
if it is compiled as 64-bit application it doesn't work.


So, I try to add one line in the .../ipc/msgrcv/Makefile:

  msgrcv08: CFLAGS+=-m32

and I get some compile errors like:
-----
# make
make -C ../lib -f "/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib/Makefile" all
make[1]: Entering directory `/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/lib'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/lib'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -m32 -D_FORTIFY_SOURCE=2 -I/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/include -I/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib -I../../../../../include -I../../../../../include   -L/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib -L../../../../../lib  msgrcv08.c   -lltp -lipc -o msgrcv08
/usr/bin/ld: skipping incompatible ../../../../../lib/libltp.a when searching for -lltp
/usr/bin/ld: cannot find -lltp
/usr/bin/ld: skipping incompatible /mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib/libipc.a when searching for -lipc
/usr/bin/ld: cannot find -lipc
collect2: error: ld returned 1 exit status
make: *** [msgrcv08] Error 1
-----

these because the libltp.a is 64-bit.


Then, I came up with a idea that I don't include the ltp-lib file in 'msgrcv08.c', 
and just add two lines in the .../ipc/msgrcv/Makefile:

  msgrcv08:
	gcc -g -O2 -Wall -m32 msgrcv08.c -o msgrcv08

It works for me, but I know it's not appropriate for LTP management.

What should I do? or, Is there any good way to solve this problem?

Thanks~

-- 
Regards, 
Li Wang 
Email: liwang@redhat.com 



------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
