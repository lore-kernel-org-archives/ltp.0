From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 May 2018 15:46:28 +0200
Subject: [LTP] [RFC PATCH v3 2/2] lib: Add tests
In-Reply-To: <20180522193430.20117-2-pvorel@suse.cz>
References: <20180522193430.20117-1-pvorel@suse.cz>
 <20180522193430.20117-2-pvorel@suse.cz>
Message-ID: <20180524134628.GB20945@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> This is not intended to be merged. It's just a helper which you can use
> for testing the previous patch.
>
> (Side note: if we ever want to test tst_test.sh, it'd be possible to
> dump it into file and compare with saved output. It'd require to remove
> lines with 'stime=')

That sounds like a good idea actually, I'm all for unit testing the
shell library.

I'm not that sure that we would want to put it into the runtest file
though, maybe we just need a runtest.sh script in the lib/ directory
that would loop over all *.sh file in a certain directory and compared
the output against corresponding file names without the .sh suffix.

We can then do something as lib/tests/ with runtest.sh that would loop
over subdirectories in lib/tests/ executing actual testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
