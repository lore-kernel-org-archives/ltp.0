From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 Mar 2017 14:04:32 +0100
Subject: [LTP] [PATCH] ltp: detect the test id automatically
In-Reply-To: <CAEemH2cC6iU8psP7cH=snnZg7=nUR+WCWZ_i+c7FpedKdLx8pQ@mail.gmail.com>
References: <20170314072529.24567-1-liwang@redhat.com>
 <20170314164947.GA9183@rei.lan>
 <CAEemH2e=GzAU5U9AMbzmw2BaSD7YvrOMNutS5ZOrHNOvMa2F=g@mail.gmail.com>
 <20170315091854.GB17204@rei>
 <CAEemH2cC6iU8psP7cH=snnZg7=nUR+WCWZ_i+c7FpedKdLx8pQ@mail.gmail.com>
Message-ID: <20170323130432.GE351@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Ah, I was blind and missed the r in the middle, indeed the strrchr()
> > returns the last occurence.
> >
> >> Actually I have tested some kind of situation and compile the whole
> >> LTP with this change, I didn't find any abnormal things which involved
> >> by this path :)
> >
> > It will work fine I guess. But the standard allows argv[0] to be empty
> > string though and you can pass any string as argv[0] to the execve() as
> > well.
> 
> Yes! we should make sure that argv[0] is neither 'NULL' nor point to
> an empty string before assigned to tst_test->tid. And then no matter
> what the string it is like, we only using it as a string. I think that
> would be safe for LTP.
> 
> 
> Method_1:
> -------------
>  $cat tst_test.c
> 
> static void get_tid(char *argv[])
> {
>        char *p;
>        int chk = 1;
> 
>        chk = argv[0] == NULL ? 0 : strcmp(argv[0], "\0");
>        if (chk == 0)
>                tst_brk(TBROK, "No tid set in test structure");

Well, this is messy and unnecessarily uses strcmp where simple
comparsion would do. Also the error message is not really describing the
problem. So this should rather be something as:

	if (!argv[0] || !argv[0][0]) {
		tst_brk(TBROK,
			"No tid set in test structure and argv[0] is empty");
	}

>        tst_test->tid = (p = strrchr(argv[0], '/')) ? p+1 : argv[0];
> }
> 
> 
> static void do_setup(int argc, char *argv[])
> {
> ...
>         if (!tst_test->tid)
>                get_tid(argv);

This should be called set_tid(), get_tid() would probably mean that the
function returns a pointer to the string.

> ...
> }
> 
> >
> > So if we go this way we should add sanity checks if there is something
> > sensible in the argv[0].
> >
> >> > And I wonder if we can avoid runtime detection, which is always tricky.
> >> > Maybe we can just do:
> >> >
> >> > struct tst_test test = {
> >> >         .id = __FILE__,
> >> > };
> >> >
> >> > And strip the .c suffix in the test library if present. That way we
> >> > would avoid this kind of copy&paste errors.
> >>
> >> Hmm, I have no objection with this method, but it seems still need the
> >> author to write ".tid = __FILE__" each time. To strip the .c suffix is
> >> also need additional work in some place.
> >
> > I think that this is just a little more robust solution, but yes it's
> > less elegant one.
> 
> Not sure if I understand this way correctly, something achieved as:
> 
> Method_2:
> ------------
> 
> $ cat tst_test.h
> 
> struct tst_test {
>        char tid[128];
> ...
> }
> 
> 
> $ cat tst_test.c
> 
> static void get_tid(void)
> {
>        char *p;
> 
>        p = (strrchr(tst_test->tid, '.'));
>        if (p)
>                *p = '\0';
> }
> 
> static void do_setup(int argc, char *argv[])
> {
>        if (tst_test->tid[0] == '\0')
>                 tst_brk(TBROK, "No tid set in test structure");
>        else
>                get_tid();
> ...
> }
> 
> 
> $ cat ioctl06.c
> 
>  static struct tst_test test = {
>        .tid = __FILE__,
> ...
> }

Or we may just store the __FILE__ string as a const char * pointer in
the tst_test structure and copy part of it to a static array in the
do_setup() function in the library and replace the .tid with that.

> >
> > Anyway looking at the code the tid is only used when creating temporary
> > directory/shm so that it's clear which testcase these global resources
> > belongs to. So as far as we can easily identify which test has created
> > the temp directory given it's name it's fine.
> >
> 
> What we do to get tid is early than create a temp directory. Looking
> at function setup_ipc(), no matter if we need temp dir or not, the
> tst_test->tid should be available there. So this is a general demand
> to ltp testcase not specified.
>
> I drafted above two methods for comparison, I prefer to go method_1,
> because it makes LTP authors no need to consider ".tid=" any more.
> what do you think?

Still undecided. CCing Jan, Jan do you have a preference on which way
would be better?

-- 
Cyril Hrubis
chrubis@suse.cz
