From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Mar 2020 15:20:45 +0100
Subject: [LTP] [PATCH] syscalls/clone3: New tests
In-Reply-To: <20200313134215.GA7318@rei.lan>
References: <08f6f9f8af7b8f999136cc2a30744a8d678d2b5f.1584000268.git.viresh.kumar@linaro.org>
 <20200312134300.GB3803@rei.lan>
 <20200313041947.2ua6abqerhdo6wfv@vireshk-i7>
 <20200313134215.GA7318@rei.lan>
Message-ID: <20200313142045.GB24523@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > - pidfd: Kernel doesn't check this pointer and we get EFAULT.
> > - child_tid: Kernel checks for valid pointer and doesn't use the
> >   variable if NULL, so test passes unexpectedly.

> We do have tst_get_bad_addr() that produces PROT_NONE mapped page that
> should get you EFAULT in both cases here.
I was thinking about it, then didn't write it.

+ we should add tst_get_bad_addr() to doc/test-writing-guidelines.txt.
I'll try to remember to send patch on Monday.

Kind regards,
Petr
