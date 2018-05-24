From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 May 2018 16:00:57 +0200
Subject: [LTP] [RFC PATCH v3 2/2] lib: Add tests
In-Reply-To: <20180524134628.GB20945@rei>
References: <20180522193430.20117-1-pvorel@suse.cz>
 <20180522193430.20117-2-pvorel@suse.cz>
 <20180524134628.GB20945@rei>
Message-ID: <20180524140057.nwn3qpvjdxkeb7ya@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > This is not intended to be merged. It's just a helper which you can use
> > for testing the previous patch.

> > (Side note: if we ever want to test tst_test.sh, it'd be possible to
> > dump it into file and compare with saved output. It'd require to remove
> > lines with 'stime=')

> That sounds like a good idea actually, I'm all for unit testing the
> shell library.
I was inspired by recent change in kernel's kconfig. Masahiro Yamada added tests, which
compare output of various make calls with saved. It's in scripts/kconfig/tests/, using
python's pytest, you can see it by running 'make testconfig'.

> I'm not that sure that we would want to put it into the runtest file
> though, maybe we just need a runtest.sh script in the lib/ directory
> that would loop over all *.sh file in a certain directory and compared
> the output against corresponding file names without the .sh suffix.

> We can then do something as lib/tests/ with runtest.sh that would loop
> over subdirectories in lib/tests/ executing actual testcases.

Sounds reasonable. I added it into runtest file just to help myself to test. And publish
it just in case anyone wanted to use it for testing the patch.


Kind regards,
Petr
