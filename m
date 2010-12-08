Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <huruomu@gmail.com>) id 1PQGLH-0004Hf-5x
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:29:43 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQGLG-0008VN-8V
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:29:43 +0000
Received: by wyb40 with SMTP id 40so860825wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Dec 2010 01:29:36 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 8 Dec 2010 17:29:36 +0800
Message-ID: <AANLkTi=1byd4Aef1uwOKKBFVoGKFMkPm7bBTGJBigT+R@mail.gmail.com>
From: Romu <huruomu@gmail.com>
Subject: [LTP] Failed to build ltp 20101031 on RHEL5u6
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

I failed to build ltp 20101031 on RHEL5u6 beta (i686):

./configure
make all

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
-I/root/ltp-full-20101031/testcases/realtime/include
-I../../../../include -I../../../../include
-L/root/ltp-full-20101031/testcases/realtime/lib -L../../../../lib
async_handler.c   -lrealtime -lpthread -lrt -lm -o async_handler
/root/ltp-full-20101031/testcases/realtime/lib/librealtime.a(librttest.o):
In function `atomic_add':
/root/ltp-full-20101031/testcases/realtime/lib/../include/librttest.h:117:
undefined reference to `__sync_add_and_fetch_4'
collect2: ld returned 1 exit status
make[4]: *** [async_handler] Error 1
make[4]: Leaving directory
`/root/ltp-full-20101031/testcases/realtime/func/async_handler'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/root/ltp-full-20101031/testcases/realtime/func'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/ltp-full-20101031/testcases/realtime'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ltp-full-20101031/testcases'
make: *** [testcases-all] Error 2

I googled and some people said "-march=i686" should be used.  I tried:

CFLAGS="-march=i686" ./configure
CFLAGS="-march=i686" make all

still got the same error.

Any idea?

Regards,
Romu

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
