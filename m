From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 28 Feb 2020 10:21:07 +0100
Subject: [LTP] netns_netlink test failure
In-Reply-To: <MAXPR0101MB14681590CE13BB4E2ED97CFEEEE80@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB14681590CE13BB4E2ED97CFEEEE80@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <20200228092107.GB31181@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> <<<test_output>>>
> open: No such file or directory
> netns_netlink    1  TBROK  :  netns_netlink.c:143: system() failed
                                                 ^
						 This is a line number,
						 if you look a the
						 source code of the
						 test, you see:

        if (WEXITSTATUS(system("ip tuntap add dev dummy0 mode tap")))
                tst_brkm(TBROK, cleanup, "system() failed");

So that the failed command was "ip tuntap add dev dummy0 mode tap", it's up to
you to figure out why...

-- 
Cyril Hrubis
chrubis@suse.cz
