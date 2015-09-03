Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <srikanth007m@gmail.com>) id 1ZXMCN-0005n4-6N
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2015 04:32:31 +0000
Received: from mail-qk0-f171.google.com ([209.85.220.171])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZXMCM-0004f0-Da
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2015 04:32:31 +0000
Received: by qkcj187 with SMTP id j187so16744458qkc.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 02 Sep 2015 21:32:25 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 3 Sep 2015 10:02:24 +0530
Message-ID: <CANKSX+FjoktkpNQ4tRkEKLv_XKuDHF57-TaO13bs2wYAJDcQiw@mail.gmail.com>
From: "$rik@nth " <srikanth007m@gmail.com>
Subject: [LTP]  Syscall/io_* tests failing to compile
Reply-To: srikanth007m@gmail.com
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

Hi All,


I am seeing below errors while compiling syscalls from the latest
available LTP tar ball from sourceforge. My system is having latest
libaio-dev library as well.

the same issue even observed for other io syscalls(io_getevents etc..)
as well. Do i need to setup any other environment to compile it
successfully.

/usr/bin/arm-linux-gnueabihf-gcc -static -g -O2 -fno-strict-aliasing
-pipe -Wall -W -static -Wold-style-definition
-I/home/LTP/ltp-full-20150420/testcases/kernel/include
-I../../../../include -I../../../../include -static -pthread
-L../../../../lib  io_destroy01.c   -lltp  -o io_destroy01
/tmp/cc0f3RO7.o: In function `main':
/home/LTP/ltp-full-20150420/testcases/kernel/syscalls/io_destroy/io_destroy01.c:77:
undefined reference to `io_destroy'
collect2: ld returned 1 exit status
make: *** [io_destroy01] Error 1

-- 
Thanks & Regards,
M.Srikanth Kumar.

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
