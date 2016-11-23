From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Nov 2016 10:21:07 +0100
Subject: [LTP] [PATCH v2 1/1] testcases: bashisms: s/==/=/
In-Reply-To: <20161122164824.2pb7ekiy4srrk2ce@dell5510>
References: <20161121205300.28375-1-petr.vorel@gmail.com>
 <20161122142828.GB8384@rei.lan>
 <20161122164824.2pb7ekiy4srrk2ce@dell5510>
Message-ID: <20161123092106.GA839@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I've dropped the part that fixed mv_test.sh since that test was
> > rewritten by the big patchset I've just commited and pushed, thanks.
> Thanks! I hoped not to clash with your work, sorry! There are still some bashisms left,
> are you planning any big rewrite, so I should wait for fixing them?

Nah, that happens all the time. That is one of the joys of developing on
larger project.

> BTW there is a file pushed with my commit
> testcases/kernel/controllers/memcg/functional/memcg_getpagesize, IMHO it shouldn't
> (it was removed in 5e65d837ee4e3390c885db1d2eb340c80c2b6c36).

Grr, my bad, I will get rid of it.

> OT: testcases/kernel/controllers/memcg/README seems to be outdated.

I guess that it's just another candidate for deletion, since there is
not much useful information left.

-- 
Cyril Hrubis
chrubis@suse.cz
