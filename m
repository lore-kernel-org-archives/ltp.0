From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 9 Nov 2020 07:49:08 -0500 (EST)
Subject: [LTP] [PATCH] lib/tst_cgroup: fix short reads of mems/cpus
In-Reply-To: <CAEemH2f-okBCGktRfT5-RgkXziAu3FrFAN7Qih2vz=A9mfJzRw@mail.gmail.com>
References: <5d6e978c803e4e6449cabd89596729bfad996a17.1604408825.git.jstancek@redhat.com>
 <CAEemH2dHXYbmkbzccWNurYURZQJJ4GENRBr=6KfQaL5HJaBO2g@mail.gmail.com>
 <CAEemH2f-okBCGktRfT5-RgkXziAu3FrFAN7Qih2vz=A9mfJzRw@mail.gmail.com>
Message-ID: <69530275.22574785.1604926148605.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Wed, Nov 4, 2020 at 2:22 PM Li Wang <liwang@redhat.com> wrote:
> 
> > ...
> >> -       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "cpus", buf);
> >> +       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "cpus", buf,
> >> sizeof(buf));
> >>         tst_cgroup_cpuset_write_files(PATH_TMP_CG_CST, "cpus", buf);
> >> -       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "mems", mems);
> >> +       tst_cgroup_cpuset_read_files(PATH_TMP_CG_CST, "mems", mems,
> >> sizeof(buf));
> >>
> >
> > sizeof() is generally used to calculate the size (in bytes) of a data type,
> > e.g sizeof(char *).
> > I think here to pass 'BUFSIZ' directly is better than sizeof(buf).
> >
> 
> Jan, do you agree with this point?
> If yes, I can help to modify and apply this patch.

2nd line should have been sizeof(mems), but BUFSIZ will work too.

