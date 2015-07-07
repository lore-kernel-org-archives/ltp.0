Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1ZCQWH-0008IS-OA
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 10:54:33 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZCQWG-0006Vy-Mf
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2015 10:54:33 +0000
Message-ID: <559BAD6F.3070206@cn.fujitsu.com>
Date: Tue, 7 Jul 2015 18:43:59 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] getrandom compilation broken in RHEL5.11GA
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>, ced.hnyda@gmail.com
Cc: LTP <ltp-list@lists.sourceforge.net>

hello Jan, Cedric,

When I compile ltp in RHEL5.11GA, I run into these errors:
---------------------------------------------------------------------------=
--------------------------------
[root@RHEL5U11ga_Intel64 getrandom]# make
make -C "/root/ltp/testcases/kernel/include" -f "/root/ltp/testcases/kernel=
/include/Makefile" all
make[1]: Entering directory `/root/ltp/testcases/kernel/include'
make[1]: Nothing to be done for `all'.
make[1]: Leaving directory `/root/ltp/testcases/kernel/include'
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-de=
finition -D_FORTIFY_SOURCE=3D2 -I/root/ltp/testcases/kernel/include -I../..=
/../../include -I../../../../include   -L../../../../lib  getrandom01.c   -=
lltp -o getrandom01
In file included from getrandom01.c:29:
/usr/include/linux/random.h:38: error: expected specifier-qualifier-list be=
fore =91__u32=92
/usr/include/linux/random.h:42: error: expected specifier-qualifier-list be=
fore =91__u32=92
make: *** [getrandom01] Error 1
---------------------------------------------------------------------------=
---------------------------------
I tried to add "#include <sys/types.h>" or "#include <linux/types.h>", neit=
her works. There maybe some bugs
in RHEL5.11GA's glibc. Given that we use ltp_syscall() and have "GRND_RANDO=
M  GRND_NONBLOCK" defined in
lapi/getrandom.h, what about we remove "#include <linux/random.h>" form the=
se these 4 test cases, then
they will compile correctly in RHEL5.

Regards,
Xiaoguang Wang

---------------------------------------------------------------------------=
---
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
