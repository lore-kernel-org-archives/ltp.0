Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1EAt-0007X0-Oi
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 11:53:23 +0000
Date: Thu, 9 Jan 2014 12:53:03 +0100
From: chrubis@suse.cz
Message-ID: <20140109115303.GC5125@rei.Home>
References: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
Subject: Re: [LTP] [PATCH v2] utils: sctp: Fix build for prefixed
 architectures
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
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
Unfortunatelly after the patch is applied the build on x86_64 fails
(you have to do a make clean before the test to get rid of object files)

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/home/metan/Work/git/ltp-dev/testcases/kernel/include -I/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/../include -I/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/../testlib -DLTP -I../../../include -I../../../include   -L/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/../lib -L/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/../testlib -L../../../lib  test_connectx.c   -lltp -lsctputil -lsctp -lpthread -o test_connectx
/tmp/cc8twJXc.o: In function `main':
/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/test_connectx.c:151: undefined reference to `sctp_connectx'
/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/test_connectx.c:163: undefined reference to `sctp_connectx'
/tmp/cc8twJXc.o: In function `test_connectx':
/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/../testlib/sctputil.h:175: undefined reference to `sctp_connectx'
/tmp/cc8twJXc.o: In function `main':
/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/test_connectx.c:234: undefined reference to `sctp_connectx'
/home/metan/Work/git/ltp-dev/utils/sctp/func_tests/test_connectx.c:245: undefined reference to `sctp_connectx'
collect2: error: ld returned 1 exit status
make[1]: *** [test_connectx] Error 1
make[1]: Leaving directory `/home/metan/Work/git/ltp-dev/utils/sctp/func_tests'
make: *** [all] Error 2

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
