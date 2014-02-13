Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WDySJ-0006tX-NY
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 15:44:03 +0000
Date: Thu, 13 Feb 2014 16:43:53 +0100
From: chrubis@suse.cz
Message-ID: <20140213154353.GA17666@rei.suse.cz>
References: <1385101595.1552.11.camel@G08JYZSD130126>
	<20131209165309.GA20943@rei.suse.cz>
	<1390209846.6682.8.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1390209846.6682.8.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH v2] fchown/fchown04.c: cleanup
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
> Cleanup of fchown04.c
>
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>

Pushed with following cosmetic changes:

-static int fd2;
+static int fd2 = -1;


		tst_count = 0;

-               for (i = 0; i < TST_TOTAL; i++) {
-
+               for (i = 0; i < TST_TOTAL; i++)
                        fchown_verify(i);
-               }
        }

-       fd2 = -1;
-


And with changes to cleanup to avoid SAFE_MACROS().

(See the the Test Writing Guidelines[1] chapter 2.2.4 Safe macros.)

[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
