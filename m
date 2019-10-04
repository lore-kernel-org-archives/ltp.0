From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Oct 2019 15:21:35 +0200
Subject: [LTP] [RFC PATCH 2/2] doc: Add user-guide.txt
In-Reply-To: <20191003164347.GA2061@dell5510>
References: <20190930115852.21672-1-pvorel@suse.cz>
 <20190930115852.21672-3-pvorel@suse.cz> <20191003114428.GC1858@rei>
 <20191003164347.GA2061@dell5510>
Message-ID: <20191004132129.GE5442@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > >  ```
> > > -$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
> > > +$ LTPROOT=/opt/ltp PATH="$PATH:$LTPROOT/bin:$LTPROOT/testcases/bin" testcases/bin/wc01.sh
> > >  ```
> 
> > This looks like an unrelated change at best and should probably be part
> > of a separate patch.
> 
> > Also the only thing that seems to be installed in $LTPROOT/bin/ that
> > could be potentially used by tests is the ffsb tool, that we are going
> > to get rid anyways. So I would have avoided including it in the example
> > anyways.
> 
> Yep, I'm aware ffsb is needed from $LTPROOT/bin. I haven't forced to send
> proposal about ffbs adding into separate repository, that why I included it.
> But sure, I'll drop this part.
> Ack the rest?

Yes, the rest is fine.

-- 
Cyril Hrubis
chrubis@suse.cz
