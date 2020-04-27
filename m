From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 27 Apr 2020 05:10:29 -0400 (EDT)
Subject: [LTP] [PATCH v2] lib: tst_taint: Ignore WARN taint flag if
 already set
In-Reply-To: <CAEemH2d_0PxgFM6cqQ8WRgaab-w1CmXbBHxkxDawQ+pUEtcMew@mail.gmail.com>
References: <7dd91d5aa2d64bcd0223120916c202f19c327237.1587471007.git.jstancek@redhat.com>
 <CAEemH2d_0PxgFM6cqQ8WRgaab-w1CmXbBHxkxDawQ+pUEtcMew@mail.gmail.com>
Message-ID: <437172135.10298956.1587978629703.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On Tue, Apr 21, 2020 at 8:15 PM Jan Stancek <jstancek@redhat.com> wrote:
> 
> > This commit changes the library so that it ignores the taint warn flag
> > if it was set prior to the test run. It turns out that the warn taint
> > flag is not well defined and could be easily set on a freshly booted
> > kernel for example when buggy BIOS is detected.
> >
> > Other recent example is disabling ip forward on kvm guests:
> >   https://github.com/containers/libpod/issues/5815
> >
> > https://lore.kernel.org/netdev/a47b6a3b-c064-2f53-7cf6-d0d0720e9d99@redhat.com/
> >
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > CC: Chang Yin <cyin@redhat.com>
> > CC: Li Wang <liwang@redhat.com>
> >
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

Pushed.

