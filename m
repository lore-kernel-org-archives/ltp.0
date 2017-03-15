From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Mar 2017 10:18:54 +0100
Subject: [LTP] [PATCH] ltp: detect the test id automatically
In-Reply-To: <CAEemH2e=GzAU5U9AMbzmw2BaSD7YvrOMNutS5ZOrHNOvMa2F=g@mail.gmail.com>
References: <20170314072529.24567-1-liwang@redhat.com>
 <20170314164947.GA9183@rei.lan>
 <CAEemH2e=GzAU5U9AMbzmw2BaSD7YvrOMNutS5ZOrHNOvMa2F=g@mail.gmail.com>
Message-ID: <20170315091854.GB17204@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +static void get_tid(char *argv[])
> >> +{
> >> +     char *p;
> >> +
> >> +     tst_test->tid = (p = strrchr(argv[0], '/')) ? p+1 : argv[0];
> >> +}
> >
> > This is interesting idea, but this oneliner is ugly and does not work
> > when you execute the testcase by full path, i.e.
> > /opt/ltp/testcases/bin/foo01 would end up with
> > opt/ltp/testcases/bin/foo01 in tid.
> 
> Really?
> 
> This words is cut from strrchr() Manual page.
> 
> "DESCRIPTION
> 
>        The strrchr() function returns a pointer to the last occurrence
>  of  the  character  c  in  the
>        string s.
> "

Ah, I was blind and missed the r in the middle, indeed the strrchr()
returns the last occurence.

> Actually I have tested some kind of situation and compile the whole
> LTP with this change, I didn't find any abnormal things which involved
> by this path :)

It will work fine I guess. But the standard allows argv[0] to be empty
string though and you can pass any string as argv[0] to the execve() as
well.

So if we go this way we should add sanity checks if there is something
sensible in the argv[0].

> > And I wonder if we can avoid runtime detection, which is always tricky.
> > Maybe we can just do:
> >
> > struct tst_test test = {
> >         .id = __FILE__,
> > };
> >
> > And strip the .c suffix in the test library if present. That way we
> > would avoid this kind of copy&paste errors.
> 
> Hmm, I have no objection with this method, but it seems still need the
> author to write ".tid = __FILE__" each time. To strip the .c suffix is
> also need additional work in some place.

I think that this is just a little more robust solution, but yes it's
less elegant one.

Anyway looking at the code the tid is only used when creating temporary
directory/shm so that it's clear which testcase these global resources
belongs to. So as far as we can easily identify which test has created
the temp directory given it's name it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
