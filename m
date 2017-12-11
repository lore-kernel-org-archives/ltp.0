From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 11 Dec 2017 15:36:22 +0100
Subject: [LTP] [RFC PATCH 1/2] network/ipsec: Add trap to INT and
	require root
In-Reply-To: <20171211122317.GA7605@rei>
References: <20171206144214.27317-1-pvorel@suse.cz>
 <91d018e3-744f-ec0d-114a-05871d3a1205@oracle.com>
 <20171207121819.rojckr2gxgwng2aj@dell5510>
 <20171211122317.GA7605@rei>
Message-ID: <20171211143622.ofkcrb7gvi3dtzjd@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > > +trap "tst_brkm TBROK 'test interrupted'" INT

> > > Could we add it to test_net.sh?
> > Sure. I was even thinking about giving it into test_net.sh and test.sh (i.e. making it the
> > default settings), but that's maybe too aggressive.

> Unless we find a test that traps INT in order to attempt to cleanup
> doing tst_brkm on INT in test library is IMHO okay.
$ git grep -i  trap.*INT $(git grep -l -e '\. tst_test.sh' -e '\. test.sh')
testcases/kernel/device-drivers/locking/lock_torture.sh:trap cleanup INT
testcases/kernel/device-drivers/rcu/rcu_torture.sh:trap cleanup INT
testcases/kernel/tracing/ftrace_test/ftrace_lib.sh:	trap clean_up_exit INT

But do we need to care? Test will just silently redefine settings from library.

They are all using test.sh, so we can add
trap "tst_brk TBROK 'test interrupted'" INT
to tst_test.sh.


Kind regards,
Petr
