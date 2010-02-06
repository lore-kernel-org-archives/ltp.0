Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ndg7T-0001wt-8X
	for ltp-list@lists.sourceforge.net; Sat, 06 Feb 2010 08:34:23 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ndg7Q-0003Zj-Oi
	for ltp-list@lists.sourceforge.net; Sat, 06 Feb 2010 08:34:23 +0000
Received: by pxi38 with SMTP id 38so4929653pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 06 Feb 2010 00:34:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <42aa607e1002051526o463518eaka70bc787760db1e6@mail.gmail.com>
References: <42aa607e1002051526o463518eaka70bc787760db1e6@mail.gmail.com>
Date: Sat, 6 Feb 2010 00:34:15 -0800
Message-ID: <364299f41002060034m5ac530d4w600037e70bf76cfe@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][utimensat.sh] cd to tmp directory before copying
	to prevent deleting original utimensat binary
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Feb 5, 2010 at 3:26 PM, Henry Yei <hyei@mvista.com> wrote:
> This patch makes the test script cd into the tmp directory before running
> the tests. This makes sure the script does not delete the original utimensat
> binary, causing the test to fail on a second run.
>
> Signed-off-by: Henry Yei<hyei@mvista.com>

Committed -- thanks!
-Garrett

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
