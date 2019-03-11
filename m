From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 11 Mar 2019 17:04:41 +0100
Subject: [LTP] [PATCH] setpriority01: Skip only PRIO_USER when unable to
 add test user
In-Reply-To: <CAGETcx-yRfA+zmRScronhaVe6auMkzso6cHeDFtOaXzkE99Hwg@mail.gmail.com>
References: <20190306215859.66044-1-saravanak@google.com>
 <20190307105933.GA1040@rei.lan>
 <CAGETcx-07fGeAxXzD6Lo79XG-0OXJS8wzHztw4_72m2rO9Hpcw@mail.gmail.com>
 <CAGETcx-yRfA+zmRScronhaVe6auMkzso6cHeDFtOaXzkE99Hwg@mail.gmail.com>
Message-ID: <20190311160441.GB14497@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > But is the test that's broken if useradd fails for wherever reason? Isn't
> > it a configuration issue?
> >
> >
> Looking more into the definition of TBROK, TCONF and the code before my
> changes:
> 
> -       if (eaccess("/etc/passwd", W_OK))
> -               tst_brk(TCONF, "/etc/passwd is not accessible");
> -
> -       tst_run_cmd(cmd_useradd, NULL, NULL, 0);
> -       user_added = 1;
> -
> 
> Should an eaccess write failure have resulted in a TCONF? Shouldn't that
> have been a TBROK too?

Looking at the git log this seems to be handling very specific case
where the rootfs is read only, quite likely this test was failing on
some specific embedded hardware. As far as I can tell this sounds like a
reasonable solution to the problem.

> I'm fine with whatever way we go, except not wanting to fail the entire
> test case just because useradd isn't present in android. It's still very
> useful to run the other setpriority tests.

Sounds good, there is no point not to map missing useradd to TCONF, I
just want to avoid mapping segfaulting or otherwise faulty useradd to
TCONF as well.

-- 
Cyril Hrubis
chrubis@suse.cz
