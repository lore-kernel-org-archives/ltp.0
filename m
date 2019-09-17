From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 17 Sep 2019 16:01:19 +0200
Subject: [LTP] [PATCH] syscalls/acct02: Improve logging
In-Reply-To: <20190917112230.GA28255@rei>
References: <20190913205328.6049-1-pvorel@suse.cz> <20190917112230.GA28255@rei>
Message-ID: <20190917140119.GA20524@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > Problem with s390 is caused by big endianess:
> > ac_version != 3 (131)

> Hmm, 131 == 83 hex, so there is one more bit turned on.

> > I suspect a bug in UNPACK(), but don't know how to fix it.

> Isn't UNPACK() used only for the timestamps?
Yep, you're right.

> The ac_version is a char, so this really looks like some strange kernel
> bug.

> > Failures on x86_64:
> > * various recent kernels 5.2.9 / 5.3, 4.20 on Debian, using v3:
> > acct02.c:222: INFO: Verifying using 'struct acct_v3'
> > acct02.c:174: INFO: == loop 1 ==
> > acct02.c:81: INFO: ac_comm != 'acct02_helper' ('acct02')
> > acct02.c:174: INFO: == loop 2 ==
> > acct02.c:81: INFO: ac_comm != 'acct02_helper' ('acct02')
> > acct02.c:132: INFO: ac_exitcode != 65280 (0)
> > acct02.c:140: INFO: ac_ppid != 18029 (18028)
> > acct02.c:174: INFO: == loop 3 ==
> > acct02.c:81: INFO: ac_comm != 'acct02_helper' ('acct02')
> > acct02.c:132: INFO: ac_exitcode != 65280 (0)
> > acct02.c:140: INFO: ac_ppid != 18029 (18028)
> > acct02.c:187: INFO: Number of accounting file entries tested: 2
> > acct02.c:191: FAIL: acct() wrote incorrect file contents!

> > * 3.10 on CentOS using v3:
> > acct02.c:82: INFO: ac_comm != 'acct02_helper' ('')
> > acct02.c:88: INFO: ac_btime < 1568406976 (0)
> > acct02.c:133: INFO: ac_exitcode != 32768 (0)
> > acct02.c:141: INFO: ac_ppid != 19863 (0)
> > acct02.c:147: INFO: ac_version != 3 (0)
> > acct02.c:152: INFO: ac_pid < 1 (0)
> > acct02.c:188: INFO: Number of accounting file entries tested: 0
> > => this looks to be completely wrong.

> > Other distros using various kernels (both old and recent) using struct
> > acct_v3 works well, so the bug might be some specific kernel
> > configuration.

> That does look like the structure has been filled in by a kernel
> incorrectly.

...
> > @@ -123,26 +170,27 @@ static void run(void)
> >  	run_command();
> >  	acct(NULL);

> > -	entry_count = 0;
> >  	do {
> > +		tst_res(TINFO, "== loop %d ==", ++i);
> > +

> Maybe I would call this "== entry %d ==" or something like that.

Sure, that's better, I'll change it.

...
> Otherwise the patch looks good, at least we can see now which checks
> have failed.
If nobody objects, I'll merge it with previous change.


Kind regards,
Petr
