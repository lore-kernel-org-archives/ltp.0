Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VlJRi-0005zy-II
	for ltp-list@lists.sourceforge.net; Tue, 26 Nov 2013 14:16:58 +0000
Date: Tue, 26 Nov 2013 15:16:29 +0100
From: chrubis@suse.cz
Message-ID: <20131126141629.GA13652@rei>
References: <1384180863-32569-1-git-send-email-alexey.kodanev@oracle.com>
	<20131125184033.GC32540@rei.suse.cz> <52947D46.3000109@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52947D46.3000109@oracle.com>
Subject: Re: [LTP] [PATCH v2] network: tcp_fastopen: add TCP Fast Open test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > The gettimeofday time measurement may break if someone happen to change
> > the time while the test was running (i.e. ntp client daemon).
> >
> > clock_gettime(CLOCK_MONOTONIC, &tp)
> >
> > should be better.
> The clock_gettime manual says that CLOCK_MONOTONIC_RAW similar to 
> _MONOTONIC, but is not subject to NTP adjustments. So CLOCK_MONOTONIC 
> can be adjusted, doesn't it?

Right, the CLOCK_MONOTONIC_RAW is better choice.

> >> +			tst_resm(TFAIL, "recv failed, sock '%d'", client_fd);
> >> +			break;
> >> +		}
> >> +
> >> +		offset += recv_len;
> >> +
> >> +		if (recv_msg[offset - 1] != end_byte) {
> >> +			tst_resm(TINFO, "msg is not complete, continue recv");
> >> +			continue;
> >> +		}
> >> +
> >> +		if (recv_msg[0] == start_fin_byte)
> >> +			tst_brkm(TBROK, cleanup, "client asks to terminate...");
> > Why is this TBROK?
> Thought about all in one function, which prints description messages, 
> calls cleanup function and exit the program.

I would say this is a misuse of the API as it is...

I suppose that you can do this in the server because the return value is
not checked, but it's confusing when reading the code.

> > guarded by locks, so in very unlikely case the value may be rewritten by
> > a tst_resm() for example. (Two threads enters tst_res and each of them
> > gets the value, modifies it and saves it and the result depends on the
> > order of these operations)
> >
> > And the problem is if we add a locks there, all tests would need to be
> > compiled with -lpthread, which is someting I do not want to do. :(
> >
> > One solution would be not using the tst_interface in this program at all
> > as it's executed by the shell script that prints the test messages and
> > returns exit value... And the same would simplify the propagation of the
> > result that is currently hacked around via the tfo_result file. You
> > could have simply printed the value into the stdout. But on the other
> > hand this will be more work on the testcase.
> What about built in gcc functions for atomic memory access like 
> |__sync_fetch_and_or()?|

That would be easy solution, but I doubt that these are available on
all platforms and slightly older compilers. Perpahs we can add configure
checks and enable it only when it's supported.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
