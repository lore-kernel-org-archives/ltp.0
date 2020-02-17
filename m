From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Feb 2020 14:36:38 +0100
Subject: [LTP] [PATCH 2/7] syscalls/fsopen: New tests
In-Reply-To: <CAEemH2emOw=Abnvk-3EOVFyCoY=c6HtC_1o0gih5n+aL-WfXLw@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <e4955c8edfb29c1d0f74a8cd24b1dcc68f3b6814.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2emOw=Abnvk-3EOVFyCoY=c6HtC_1o0gih5n+aL-WfXLw@mail.gmail.com>
Message-ID: <20200217133638.GB14410@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +       SAFE_CLOSE(TST_RET);
> > +
> > +       TEST(umount(MNTPOINT));
> > +
> > +       tst_res(TPASS, "fsopen() passed");
> > +
> > +out:
> > +       SAFE_CLOSE(fd);
> > +}
> > +
> > +static struct tst_test test = {
> > +       .min_kver = "5.2",
> >
> 
> I suggest removing .min_kver check in all of the tests to let they can be
> running on many distributions(which backport the features).

If we do that we have to explicitely check for ENOSYS errno in each
test, quite possibly with a dummy call to the tested syscall in test
setup, because once these calls gets libc wrappers we will no longer
call the tst_syscall() that checks for it.

-- 
Cyril Hrubis
chrubis@suse.cz
