From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Jul 2016 10:22:13 -0400 (EDT)
Subject: [LTP] [PATCH] madvise06: wait a bit after madvise() call
In-Reply-To: <20160718140319.GA19087@rei.suse.cz>
References: <8eb6f485a46b9d9fb62eec232bf7bcb2d4cf4215.1468848169.git.jstancek@redhat.com>
 <20160718140319.GA19087@rei.suse.cz>
Message-ID: <123467926.6065614.1468851733409.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, liwan@redhat.com
> Sent: Monday, 18 July, 2016 4:03:19 PM
> Subject: Re: [LTP] [PATCH] madvise06: wait a bit after madvise() call
> 
> Hi!
> > madvise_willneed() only schedules I/O and does not
> > wait for completion, so there is possibility for this
> > testcase to fail occasionally.
> > 
> > This patch is introducing a small delay and checks the
> > effect of madvise on more pages.
> 
> Looks good.
> 
> What is the reason for using more than one page? Does that increase the
> likehood of triggering the issue?

Because testcase faults in page by writing to it. After it does that, page
is present and subsequent loops would always give you PASS.
Multiple pages give you same starting state (page is swapped, currently
test assumes they are), if madvise loaded it from swap already (I/O caught up),
then write shouldn't change number of maj_faults.

> 
> Another idea may be to utilize bitflags from /proc/self/pagemap which
> would be non-destructive way to get the present/swapped information.

That is what I meant by "Testcase doesn't check buf[0] is swapped". You
can check that page is swapped before calling madvise...

> Then we can do a short loop that polls these flags with much shorter
> sleep, but the code would likely end up more complicated than this...

... but that page won't be present after madvise call (I checked),
I'm assuming that's because madvise loads it only to page cache
(in same style as readahead).

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
