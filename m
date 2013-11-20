Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Date: Wed, 20 Nov 2013 11:14:41 +0100
From: chrubis@suse.cz
Message-ID: <20131120101441.GA2168@rei.nue.novell.com>
References: <CAO=8iAV97QG4YfcwtGpQopDbszJkt9gDp53vG3F4qnoX6XJkgA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAO=8iAV97QG4YfcwtGpQopDbszJkt9gDp53vG3F4qnoX6XJkgA@mail.gmail.com>
Subject: Re: [LTP] How to build/install and run with gcov enabled LTP
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: "yaneurabeya ." <yanegomi@gmail.com>, ltp-list <ltp-list@lists.sourceforge.net>, naresh.kamboju@linaro.org, ltp-coverage@lists.sourceforge.net

Hi!
> I am looking for (three years) old style of running tests in ltp ( like as
> runltp do not look for /ltp/bin or testcase/bin or /opt/bin for test
> binaries, just go to each testcase/kernel/syscall/each-dir-and-run). Not
> ready to go back and use old ltp version, instead i am looking a way to run
> test from its source directory which will benefits gcov/lcov to generate
> coverage report.

How exactly was this implemented? In the runltp script or was there a
diferent one?

There are many problems with such approach. Just to start:

* There are some programs that runs subprograms and path to them must be
  in PATH, this obviously works if LTP is installed and all binaries are
  in /opt/ltp/testcases/bin/

* Device drivers need to modprobe kernel modules, which are not always
  in local directory

* The testcases are described in runtest files by a binary name, not by
  a full path -> you have to find them somehow

...

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
