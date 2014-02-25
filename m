Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WIHVd-0001UR-Tr
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 12:53:17 +0000
Date: Tue, 25 Feb 2014 13:53:02 +0100
From: chrubis@suse.cz
Message-ID: <20140225125302.GB12159@rei.Home>
References: <1389353374.2061.9.camel@G08JYZSD130126>
	<1389409991.2061.14.camel@G08JYZSD130126>
	<20140224193305.GC31562@rei>
	<1393309618.1952.52.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1393309618.1952.52.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v3] linkat/linkat02.c: add new error number tests
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +#include "test.h"
> +#include "usctest.h"
> +#include "linux_syscall_numbers.h"
> +#include "safe_macros.h"
> +#include "fcntl.h"

I've changed this to "lapi/fcntl.h". Note that ../../../../include/lapi/
is not passed to the compiler as -I so the lapi/fcntl.h is not found and
this include defaults to /usr/include/fcntl.h (because /usr/include/ is
is in the default search path).


Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
