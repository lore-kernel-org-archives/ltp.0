Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y1DcF-0004IT-QI
	for ltp-list@lists.sourceforge.net; Wed, 17 Dec 2014 12:22:07 +0000
Date: Wed, 17 Dec 2014 13:21:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141217122145.GB29078@rei>
References: <ALsA3gAIAA4ZCtJwh2RbQao2.1.1418806958246.Hmail.qulei@ubuntukylin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ALsA3gAIAA4ZCtJwh2RbQao2.1.1418806958246.Hmail.qulei@ubuntukylin.com>
Subject: Re: [LTP] Realtime test error of LTP
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
To: ?????? <qulei@ubuntukylin.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> #./test_realtime.sh -t all -l 1
> Real-time tests run
> /home/eason/??????/ltp-full-20140828/testcases/realtime/lib /home/eason/??????/ltp-full-20140828/testcases/realtime /home/eason/??????/ltp-full-20140828
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -g -O2 -Wold-style-definition -D_GNU_SOURCE -I../include/  -I../../../include -I../../../include  -c -o libstats.o libstats.c
> In file included from libstats.c:47:0:
> ../include/librttest.h:59:29: fatal error: realtime_config.h: No such file or directory
>  #include "realtime_config.h"
>                              ^
> compilation terminated.
> <builtin>: recipe for target 'libstats.o' failed
> make: *** [libstats.o] Error 1
> 
>  make Failed

You have to run configure and with enabled realtime testsuite first.

I.e. do ./configure --with-realtime-testsuite in the top level LTP
directory.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
