From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 21:12:27 +0100
Subject: [LTP] [PATCH v2 2/5] fanotify: Handle supported features checks
 in setup()
In-Reply-To: <CAOQ4uxhWOaarVWE6r_EgvtqSV83WeVghp+crAMo5UpC4KxeP9Q@mail.gmail.com>
References: <20201113155123.5959-1-pvorel@suse.cz>
 <20201113155123.5959-3-pvorel@suse.cz>
 <CAOQ4uxixL6f2hApFUjgO2d1ZOstftQwn8-y4dN6Qcd6RE-oyWA@mail.gmail.com>
 <CAOQ4uxhWOaarVWE6r_EgvtqSV83WeVghp+crAMo5UpC4KxeP9Q@mail.gmail.com>
Message-ID: <20201113201227.GA92818@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > > +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> > > @@ -212,28 +212,23 @@ static int setup_mark(unsigned int n)
> > >         char *const files[] = {fname, FILE_EXEC_PATH};

> > >         tst_res(TINFO, "Test #%d: %s", n, tc->tname);
> > > +
> > > +       if (support_exec_events != 0 && tc->mask & FAN_OPEN_EXEC_PERM) {
> > > +               tst_res(TCONF | TERRNO, "FAN_OPEN_EXEC_PERM not supported in kernel?");
> > > +               return -1;
> > > +       }
> > > +

> Please remove the comment above tcases[] definition:
> "Ensure to keep the first..."

> It is no longer needed after this change.
+1 (this one is easy).
FYI I've sent v3, but that does not address your comments
(just fixes failure).

I'll have look into your comments next week.

> Thanks,
> Amir.

Kind regards,
Petr
