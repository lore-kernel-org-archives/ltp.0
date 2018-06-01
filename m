From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 1 Jun 2018 11:48:03 +0200
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: TCONF on basename error when
 setting TST_ID
In-Reply-To: <CAEemH2cGQt4SG4ec+-=ppSF6sywzZhhsK2aZ4fzMT8oObgC93Q@mail.gmail.com>
References: <20180502134553.5429-1-pvorel@suse.cz>
 <20180502144542.4wmenub3p3c7kega@dell5510>
 <CAEemH2cGQt4SG4ec+-=ppSF6sywzZhhsK2aZ4fzMT8oObgC93Q@mail.gmail.com>
Message-ID: <20180601094803.mvjyf7pwpc4ioe7x@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On Wed, May 2, 2018 at 10:45 PM, Petr Vorel <pvorel@suse.cz> wrote:

> > ...
> > >  if [ -z "$TST_ID" ]; then
> > > -     filename=$(basename $0)
> > > +     filename=$(basename $0) || \
> > > +             tst_brk TBROK "Failed to set TST_ID from \$0 ('$0'), fix
> > it with setting TST_ID before sourcing tst_test.sh"
> >                 ^
> > Here is going to be TCONF.


> Looks good to me.

Pushed.
Li, thanks for your review.


Kind regards,
Petr
