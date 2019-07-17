From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Jul 2019 03:56:45 -0400 (EDT)
Subject: [LTP] [PATCH v3.1] lib: add tst_no_corefile()
In-Reply-To: <CAEemH2dviTYAAcsOgotuOG5gicUVVP2g2RE3MomOp5NVG_4U+Q@mail.gmail.com>
References: <20190705051603.24599-1-liwang@redhat.com>
 <02ade9af1634c4681156dceecfd51721284044e3.1562591065.git.jstancek@redhat.com>
 <20190711123441.GA8709@rei>
 <1337100107.32641000.1562849136661.JavaMail.zimbra@redhat.com>
 <CAEemH2dviTYAAcsOgotuOG5gicUVVP2g2RE3MomOp5NVG_4U+Q@mail.gmail.com>
Message-ID: <32687581.576777.1563350205495.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> On Thu, Jul 11, 2019 at 8:45 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > ...
> > >
> > > because otherwise we will print the mesasge even in cases that the
> > > corefile is not in fact limited.
> >
> > Depends on setup of core_pattern, if it's core-to-file it's already
> > limited.
> > If it's core-to-pipe, then it's no limit, so I agree, we can move it above.
> >
> >
> I helped to push the v3.1 base on Cyril's suggestion. Since I'm going to
> apply the pkey testcase. Thanks.

Thanks Li.

> 
> --
> Regards,
> Li Wang
> 
