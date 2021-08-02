From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Aug 2021 19:43:47 +0200
Subject: [LTP] [PATCH 1/1] openposix/pthread_cancel/3-1: Move sleep loop
 into separate function
In-Reply-To: <CAASaF6y+nGtyH_OGdcJAa-UmnKW_6+HE6ZB=kDyWNpHu_c-Nug@mail.gmail.com>
References: <20210802163007.2282-1-pvorel@suse.cz>
 <CAASaF6y+nGtyH_OGdcJAa-UmnKW_6+HE6ZB=kDyWNpHu_c-Nug@mail.gmail.com>
Message-ID: <YQgu0+DJ5V91sL4P@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> On Mon, Aug 2, 2021 at 6:30 PM Petr Vorel <pvorel@suse.cz> wrote:

> > to fix warning:
> > pthread_cancel/3-1.c:40:13: warning: variable ?waited_for_cancel_ms? might
> > be clobbered by ?longjmp? or ?vfork? [-Wclobbered]
> >    40 |         int waited_for_cancel_ms = 0;

> > Suggested-by: Martin Doucha <mdoucha@suse.cz>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>


>  Acked-by: Jan Stancek <jstancek@redhat.com>
Thanks a lot, merged!

Kind regards,
Petr
