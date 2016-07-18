From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Jul 2016 16:49:29 +0200
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <123467926.6065614.1468851733409.JavaMail.zimbra@redhat.com>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160718140319.GA19087@rei.suse.cz>
 <123467926.6065614.1468851733409.JavaMail.zimbra@redhat.com>
Message-ID: <20160718144929.GB19087@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > What is the reason for using more than one page? Does that increase the
> > likehood of triggering the issue?
> 
> Because testcase faults in page by writing to it. After it does that, page
> is present and subsequent loops would always give you PASS.
> Multiple pages give you same starting state (page is swapped, currently
> test assumes they are), if madvise loaded it from swap already (I/O caught up),
> then write shouldn't change number of maj_faults.

Right. Now that I finished my coffe it's clear as a day :).

> > Another idea may be to utilize bitflags from /proc/self/pagemap which
> > would be non-destructive way to get the present/swapped information.
> 
> That is what I meant by "Testcase doesn't check buf[0] is swapped". You
> can check that page is swapped before calling madvise...

Hmm, looking at the test again, without this the patch makes the test
theoretically more fragile. Since it would pass if, by a chance, one of
these pages wasn't swapped out.

> > Then we can do a short loop that polls these flags with much shorter
> > sleep, but the code would likely end up more complicated than this...
> 
> ... but that page won't be present after madvise call (I checked),
> I'm assuming that's because madvise loads it only to page cache
> (in same style as readahead).

Ah, tricky. So it's in the swap page cache and only accesing it makes it
present, but page fault counter is increased only on major faults when
the page needs to be read from the disk.

-- 
Cyril Hrubis
chrubis@suse.cz
