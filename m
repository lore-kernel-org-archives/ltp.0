From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 17 Aug 2018 14:50:13 +0200
Subject: [LTP] [PATCH v2] pty: fix some issues in pty02
In-Reply-To: <CAEemH2enO9wzqL2AAeuNMwNS5VxQTgi+bxUPgTMujoeaQvMqDQ@mail.gmail.com>
References: <20180817022623.2657-1-liwang@redhat.com>
 <5B763508.2070504@cn.fujitsu.com>
 <CAEemH2enO9wzqL2AAeuNMwNS5VxQTgi+bxUPgTMujoeaQvMqDQ@mail.gmail.com>
Message-ID: <20180817125013.GB21254@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > +     if (TEST_RET == -1) {
> > > +             if (TEST_ERR == EINVAL)
> > > +                     tst_res(TCONF, "tcsetattr(, , EXTPROC | ICANON) is
> > not supported");
> > Hi Li,
> >
> > Should we use tst_brk(TCONF, ...) instead?
> 
> 
> Yes, right.

I fixed that, as well as TEST_RET -> TST_RET and TEST_ERR -> TST_ERR,
and applied, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
