From: Zorro Lang <zlang@redhat.com>
Date: Thu, 3 Jun 2021 02:26:25 +0800
Subject: [LTP] [PATCH] ltp-aiodio: help aiodio test work normally
In-Reply-To: <YLdwYJ3Kw5qf64d2@yuki>
References: <20210601155427.996321-1-zlang@redhat.com> <YLdwYJ3Kw5qf64d2@yuki>
Message-ID: <20210602182625.GJ2978781@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 02, 2021 at 01:49:52PM +0200, Cyril Hrubis wrote:
> Hi!
> > ltp aiodio related cmdfiles (runtest/ltp-aio*.part*) can't be used,
> > due to they have unfixed path name. Before we run aiodio test, we
> > need to create some files (e.g. junkfile), and give it to the tests.
> > But current cmdfiles use too many $TMPDIR and aiodio.$$ things, e.g:
> > 
> >   AD022 time aiocp -b 1k -n 64 -f DIRECT -f SYNC $TMPDIR/aiodio.$$/junkfile $TMPDIR/aiodio.$$/ff2
> > 
> > TMPDIR is a directory created by `mktemp ${TMPBASE}/ltp-XXXXXXXXXX`,
> > it's not a fixed path. The aiodio.$$ is also can be sure before
> > running ltp. That cause we can't prepare files in the unfixed path.
> > Even the testscripts/ltp-aiodio.sh can't work well either, due to it
> > try to create files in $TMP/aiodio/..., the $TMP is $TMPBASE, not
> > $TMPDIR, and aiodio is not aiodio.$$.
> >
> > So this patch trys to help runtest/ltp-aio*.part* to use fixed path
> > name, and put all aiodio test related files in $TMPBASE/aiodio/, the
> > $TMPBASE is a fixed pathname comes from runltp -d <directory> option.
> > So after this fix, users will know where they should create files in,
> > no matter running ltp-aiodio.sh or runltp -f runtest/ltp-aio*.part*.
> 
> I do not like this solution. I think that we should instead fix the
> scripts. I think that the runltp should just export TMPDIR if it was
> passed on commandline and it should be the resposibility of the caller
> to set up a temporary directory somewhere in /tmp in that case.

Sorry I can't understand your solution, would you like to show me some
detailed code which can make the aiodio test pass, to explain what do
you really like to do?

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 

