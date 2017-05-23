From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 May 2017 10:29:27 +0200
Subject: [LTP] [PATCH] tst_test.c: set the test id automatically
In-Reply-To: <20170522141611.19386-1-chrubis@suse.cz>
References: <20170522141611.19386-1-chrubis@suse.cz>
Message-ID: <20170523082926.omouymv7sjmdtgd5@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Use the argv[0] to set the tst_test->tid automatically since we fail to
> update it commonly and we end up with wrong tid due to copy&paste.

> Now it's initialized in the test setup based on argv[0]. If argv[0] is a
> path we take last element in it.
I like it, any simplification of the setup is good :-).

I'm thinking about using similar for shell variable TCID (it should be possible to know
the path of sourcing script in shell libraries via $0).


Kind regards,
Petr
