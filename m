From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jun 2018 16:38:00 +0200
Subject: [LTP] [RFC PATCH v6 3/5] tst_test.sh: Filter out commented out
 lines from warnings
In-Reply-To: <20180604213420.GA2783@x230>
References: <20180601072838.13196-1-pvorel@suse.cz>
 <20180601072838.13196-4-pvorel@suse.cz>
 <20180604210628.GA19509@rei.lan> <20180604213420.GA2783@x230>
Message-ID: <20180605143800.GA6190@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > foo # run function foo
> Not sure what you expected. The behavior is:
> 
> * no warning for:
>   # _tst_foo run function _tst_foo
> 
> * warning for:
>   _tst_foo # run function _tst_foo

We will also get warning for:

tst_foo # we are not allowed to call _tst_foo

I was trying to point out that the solution is incomplete...

But anyway I see no point in proceeding further with the implemtation.

-- 
Cyril Hrubis
chrubis@suse.cz
