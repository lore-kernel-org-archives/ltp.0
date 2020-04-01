From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 1 Apr 2020 11:58:22 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <e9ea8c2a-7c00-26a7-fb1a-0db9ae093620@suse.cz>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
 <e9ea8c2a-7c00-26a7-fb1a-0db9ae093620@suse.cz>
Message-ID: <20200401095822.GB23773@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We cannot move that definition into tst_test.c beacuse that would mean
> > that old API test would end up with multiple definitions one in the
> > corresponding test and one in the new library library code.
> 
> But we can move it a few lines up in tst_main.h so that it gets defined
> only together with the default main(), not in every .c file that
> includes tst_test.h.

The problem here is that gcc10 forbids variables in headers, moving it
anywhere int the header wouldn't help.

-- 
Cyril Hrubis
chrubis@suse.cz
