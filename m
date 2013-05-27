Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <R65777@freescale.com>) id 1UgvuL-0004sv-3F
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 11:48:09 +0000
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]
	helo=co9outboundpool.messaging.microsoft.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1UgvuI-00064d-AH
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 11:48:09 +0000
Received: from mail193-co9 (localhost [127.0.0.1])	by
	mail193-co9-R.bigfish.com (Postfix) with ESMTP id 99E09660221	for
	<ltp-list@lists.sourceforge.net>; Mon, 27 May 2013 11:32:53 +0000 (UTC)
Received: from CO9EHSMHS012.bigfish.com (unknown [10.236.132.254])	by
	mail193-co9.bigfish.com (Postfix) with ESMTP id A6E109A004E	for
	<ltp-list@lists.sourceforge.net>; Mon, 27 May 2013 11:32:51 +0000 (UTC)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Mon, 27 May 2013 11:32:32 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D070433E5@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] LTP: Compilation error for powerpc
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi All,

There are a number of good test cases which we run to test various features ( like ptrace/memory etc). I tried below steps and failed to compile successfully:

1)
cp include/mk/config.mk.default include/mk/config.mk

2)
vi include/mk/config.mk
-AR                      := ar
-CC                      := gcc
+AR                      := /opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/bin/powerpc-linux-gnu-ar
+CC                      := /opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/bin/powerpc-linux-gnu-gcc

3)
cp include/config.h.default include/config.h

4)
cd include/mk
cp generic_leaf_target.inc generic_leaf_target.mk cp generic_trunk_target.inc generic_trunk_target.mk cd ../../

5)
Make

Getting error :

make[4]: Entering directory `/home/r65777/LTP/try/testcases/kernel/containers/libclone'
/opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/bin/powerpc-linux-gnu-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/home/r65777/LTP/try/testcases/kernel/include  -c -o libclone.o libclone.c In file included from libclone.h:31:0,
                 from libclone.c:17:
/home/r65777/LTP/try/testcases/kernel/include/linux_syscall_numbers.h:18:21: fatal error: cleanup.c: No such file or directory compilation terminated.
make[4]: *** [libclone.o] Error 1
make[4]: Leaving directory `/home/r65777/LTP/try/testcases/kernel/containers/libclone'
make[3]: *** [libclone/libclone.a] Error 2
make[3]: Leaving directory `/home/r65777/LTP/try/testcases/kernel/containers'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/r65777/LTP/try/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/home/r65777/LTP/try/testcases'
make: *** [testcases-all] Error 2

-------------------------
 
Thanks
-Bharat


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
