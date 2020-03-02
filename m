From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Mon, 2 Mar 2020 04:32:31 +0000
Subject: [LTP] netns_netlink test failure
In-Reply-To: <20200228092107.GB31181@rei>
References: <MAXPR0101MB14681590CE13BB4E2ED97CFEEEE80@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>,
 <20200228092107.GB31181@rei>
Message-ID: <MAXPR0101MB1468032C8109347B258800B7EEE70@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
What could be the possible reason behind failing,any guess??
________________________________
From: Cyril Hrubis <chrubis@suse.cz>
Sent: Friday, February 28, 2020 2:51 PM
To: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Cc: ltp@lists.linux.it <ltp@lists.linux.it>
Subject: Re: [LTP] netns_netlink test failure

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
[EXT]
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200302/0c8c3fa8/attachment.htm>
