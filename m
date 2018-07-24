From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 24 Jul 2018 17:19:56 +0200
Subject: [LTP] [PATCH v2 1/1] tst_test.sh: Add test cmd helper
	tst_test_cmds()
In-Reply-To: <20180724131551.GA30730@rei>
References: <20180423091706.24154-1-pvorel@suse.cz>
 <20180724093537.GA19255@rei> <20180724125708.GA5894@x230>
 <20180724131551.GA30730@rei>
Message-ID: <20180724151956.GA1548@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > > Hmm looking at this after a while I would expect the tst_test_cmds() to
> > > exit the test while tst_check_cmds() to return a value, the question is
> > > if this is worth of the work of renaming the current uses...
> > Indeed, names would be better to be reversed. It's up to you.
> > If you want, I'll first rename tst_check_cmds() to tst_test_cmds()
> > and then add this new one as tst_check_cmds().

> If it's easy enough, let's do that, otherwise I would keep it as it is.
merged rename, updated version of now called tst_check_cmds() and it's initial
usage in IMA.
+ Updated wiki (+ updating changes to wiki from commit e11b7c036 tst_timer: Add
tst_timer_expired_ms()

Thanks for your time to review!


Kind regards,
Petr
