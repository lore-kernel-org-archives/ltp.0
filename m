Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VQeHa-0001E6-Ri
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 14:17:06 +0000
Date: Mon, 30 Sep 2013 16:17:29 +0200
From: chrubis@suse.cz
Message-ID: <20130930141729.GA4622@rei.suse.cz>
References: <20130926114604.GD14003@rei.suse.cz>
	<1380526462-27191-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1380526462-27191-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] controllers/cpuset: reogranization
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

Hi!
> Renamed cpuset01 to cpuset12.

I slightly preffere to keep the test ids constant if possible. Note that
there are databases of test results used for comparsions and changing
the test ids would confuse such systems.

So in this case I would just name the newly added cpuset tests
differently, either add some reasonable prefix or start the numbering
from some higher number.

>  . ./cpuset_funcs.sh

Drop the './' here. When LTP is executed the directory with the tests
binaries and scripts is in $PATH. When you run scripts from git the
files are found in $CWD. With './' the LTP tests must be executed
with CWD set to /opt/ltp/testcases/bin/, which is something I wan't to
get rid in the future.


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
