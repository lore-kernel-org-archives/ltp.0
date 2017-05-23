From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 May 2017 13:49:47 +0200
Subject: [LTP] [PATCH] tst_test.c: set the test id automatically
In-Reply-To: <CAEemH2eXNxvG8nJqagABb6x+iinSOcTxTC9XUDHU+NzUcW=WJA@mail.gmail.com>
References: <20170522141611.19386-1-chrubis@suse.cz>
 <CAEemH2eXNxvG8nJqagABb6x+iinSOcTxTC9XUDHU+NzUcW=WJA@mail.gmail.com>
Message-ID: <20170523114947.GB19602@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 14a47d6..0bbcbf7 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -616,6 +616,22 @@ static void copy_resources(void)
> >                 TST_RESOURCE_COPY(NULL, tst_test->resource_files[i], NULL);
> >  }
> >
> > +static void get_tid(char *argv[])
> 
> Ah, forgot to mention that the return type should be "char *".

My bad, I did last minute changes to the patch. I will fix that before
pushing.

-- 
Cyril Hrubis
chrubis@suse.cz
