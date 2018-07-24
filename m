From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jul 2018 15:15:51 +0200
Subject: [LTP] [PATCH v2 1/1] tst_test.sh: Add test cmd helper
	tst_test_cmds()
In-Reply-To: <20180724125708.GA5894@x230>
References: <20180423091706.24154-1-pvorel@suse.cz>
 <20180724093537.GA19255@rei> <20180724125708.GA5894@x230>
Message-ID: <20180724131551.GA30730@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Hmm looking at this after a while I would expect the tst_test_cmds() to
> > exit the test while tst_check_cmds() to return a value, the question is
> > if this is worth of the work of renaming the current uses...
> Indeed, names would be better to be reversed. It's up to you.
> If you want, I'll first rename tst_check_cmds() to tst_test_cmds()
> and then add this new one as tst_check_cmds().

If it's easy enough, let's do that, otherwise I would keep it as it is.

-- 
Cyril Hrubis
chrubis@suse.cz
