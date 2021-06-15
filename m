From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jun 2021 18:40:44 +0200
Subject: [LTP] [PATCH 1/1] fs/racer: Fix LTP hang caused by fs_racer.sh
In-Reply-To: <CAEemH2f-=oW3PqJN6EsCvBzvPk2LvrwkLd1oVgHgv+_HHN_oTQ@mail.gmail.com>
References: <20210610175812.13730-1-ycliang@andestech.com>
 <CAEemH2f-=oW3PqJN6EsCvBzvPk2LvrwkLd1oVgHgv+_HHN_oTQ@mail.gmail.com>
Message-ID: <YMjYDEXWlD7M/Dfp@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Leo, Li,

> On Fri, Jun 11, 2021 at 1:58 AM Leo Yu-Chi Liang <ycliang@andestech.com> wrote:

> > fs_racer.sh test could cause LTP to hang if the file
> > gets removed when it's at time same time being renamed.

> > The if statement in mv source implemented by busybox is as follows:

> >         if (dest_exists) {
> >                 if (flags & OPT_NOCLOBBER)
> >                         goto RET_0;
> >                 if (!(flags & OPT_FORCE)           // OPT_FORCE is set by -f option
> >                  && ((access(dest, W_OK) < 0 && isatty(0))
> >                     || (flags & OPT_INTERACTIVE))  // this is set by -i option
> >                 ) {
> >                         if (fprintf(stderr, "mv: overwrite '%s'? ", dest) < 0) {
> >                                 goto RET_1;  /* Ouch! fprintf failed! */
> >                         }
> >                         if (!bb_ask_y_confirmation()) {
> >                                 goto RET_0;
> >                         }
> >                 }
> >         }

> > If somehow the dest_file exists when mv executes the first if "if (dest_exists)",
> > and gets removed when mv executes the third if "if (access(...))".
> > Then it is possible for mv to reach "bb_ask_y_confirmation" and to try to read from tty.

> > However, the mv process is executing in the background,
> > so when it tries to read from tty,
> > the processes in the same process group as mv would all receive SIGTTIN
> > and be changed into TASK_STOPPED state.

> > This would cause this testcase to hang, though happens rarely.

> > Add -f option to suppress the attempt to read from tty.

> > Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>

> Reviewed-by: Li Wang <liwang@redhat.com>

Fix is trivial enough to merge it => merged.

Kind regards,
Petr
