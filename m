Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZMBHN-0003Pz-UN
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 08:39:29 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZMBHM-000858-Q1
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2015 08:39:29 +0000
Date: Mon, 3 Aug 2015 10:39:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150803083908.GA31324@rei.suse.de>
References: <751019010.974973.1438321471218.JavaMail.zimbra@redhat.com>
	<1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1010625653.980528.1438323855616.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] How to compie a ltp-case into 32-bit on the 64bit system
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> # make
> make -C ../lib -f "/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib/Makefile" all
> make[1]: Entering directory `/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/lib'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/lib'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -m32 -D_FORTIFY_SOURCE=2 -I/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/include -I/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib -I../../../../../include -I../../../../../include   -L/mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib -L../../../../../lib  msgrcv08.c   -lltp -lipc -o msgrcv08
> /usr/bin/ld: skipping incompatible ../../../../../lib/libltp.a when searching for -lltp
> /usr/bin/ld: cannot find -lltp
> /usr/bin/ld: skipping incompatible /mnt/tests/kernel/distribution/ltp/generic/ltp-full-20150420/testcases/kernel/syscalls/ipc/msgrcv/../lib/libipc.a when searching for -lipc
> /usr/bin/ld: cannot find -lipc
> collect2: error: ld returned 1 exit status
> make: *** [msgrcv08] Error 1

That is because the rest of LTP has been compiled for 64 bit and the
linker fails. You have to compile _whole_ LTP with -m32 (pass
CFLAGS=-m32 to configure) so that the tests can be linked with the test
library.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
