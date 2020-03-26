From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Mar 2020 07:36:38 +0100
Subject: [LTP] [PATCH] Add test for CVE 2018-1000199
In-Reply-To: <20200326055639.GA5206@dell5510>
References: <20200319162114.3967-1-mdoucha@suse.cz>
 <20200326055639.GA5206@dell5510>
Message-ID: <20200326063638.GB5206@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Martin,

> > +TST_TEST_CONF("This test is only supported on x86 systems")
> FYI there is TST_TEST_TCONF().
+ There needs to be semicolon after the macro (we could change this in the
library.
> > +#endif

I'd also put adding SAFE_PTRACE() into separate commit.

You can also use SAFE_FOPEN() for *fr.

On some machines I got TBROK, but we probably cannot avoid it.
ptrace08.c:119: BROK: Received unexpected event from child

The rest looks ok to me. Thanks, nice work!

Kind regards,
Petr
