From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Nov 2020 09:47:34 +0800
Subject: [LTP] [PATCH] lib/tst_cgroup: fix short reads of mems/cpus
In-Reply-To: <69530275.22574785.1604926148605.JavaMail.zimbra@redhat.com>
References: <5d6e978c803e4e6449cabd89596729bfad996a17.1604408825.git.jstancek@redhat.com>
 <CAEemH2dHXYbmkbzccWNurYURZQJJ4GENRBr=6KfQaL5HJaBO2g@mail.gmail.com>
 <CAEemH2f-okBCGktRfT5-RgkXziAu3FrFAN7Qih2vz=A9mfJzRw@mail.gmail.com>
 <69530275.22574785.1604926148605.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2eA1SdVjPk8=GEmWRt66ATX9pfktm8US0JtA=S7EDf9ig@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 9, 2020 at 8:49 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > On Wed, Nov 4, 2020 at 2:22 PM Li Wang <liwang@redhat.com> wrote:
> >
> > > ...
> > >> -       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "cpus", buf);
> > >> +       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "cpus", buf,
> > >> sizeof(buf));
> > >>         tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "cpus", buf);
> > >> -       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "mems", mems);
> > >> +       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "mems", mems,
> > >> sizeof(buf));
> > >>
> > >
> > > sizeof() is generally used to calculate the size (in bytes) of a data
> type,
> > > e.g sizeof(char *).
> > > I think here to pass 'BUFSIZ' directly is better than sizeof(buf).
> > >
> >
> > Jan, do you agree with this point?
> > If yes, I can help to modify and apply this patch.
>
> 2nd line should have been sizeof(mems), but BUFSIZ will work too.
>

Pushed, thanks!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201110/0ea7c10f/attachment-0001.htm>
