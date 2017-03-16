From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Mar 2017 11:39:11 +0800
Subject: [LTP] [PATCH] ltp: detect the test id automatically
In-Reply-To: <20170315091854.GB17204@rei>
References: <20170314072529.24567-1-liwang@redhat.com>
 <20170314164947.GA9183@rei.lan>
 <CAEemH2e=GzAU5U9AMbzmw2BaSD7YvrOMNutS5ZOrHNOvMa2F=g@mail.gmail.com>
 <20170315091854.GB17204@rei>
Message-ID: <CAEemH2cC6iU8psP7cH=snnZg7=nUR+WCWZ_i+c7FpedKdLx8pQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 15, 2017 at 5:18 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> >> +static void get_tid(char *argv[])
>> >> +{
>> >> +     char *p;
>> >> +
>> >> +     tst_test->tid = (p = strrchr(argv[0], '/')) ? p+1 : argv[0];
>> >> +}
>> >
>> > This is interesting idea, but this oneliner is ugly and does not work
>> > when you execute the testcase by full path, i.e.
>> > /opt/ltp/testcases/bin/foo01 would end up with
>> > opt/ltp/testcases/bin/foo01 in tid.
>>
>> Really?
>>
>> This words is cut from strrchr() Manual page.
>>
>> "DESCRIPTION
>>
>>        The strrchr() function returns a pointer to the last occurrence
>>  of  the  character  c  in  the
>>        string s.
>> "
>
> Ah, I was blind and missed the r in the middle, indeed the strrchr()
> returns the last occurence.
>
>> Actually I have tested some kind of situation and compile the whole
>> LTP with this change, I didn't find any abnormal things which involved
>> by this path :)
>
> It will work fine I guess. But the standard allows argv[0] to be empty
> string though and you can pass any string as argv[0] to the execve() as
> well.

Yes! we should make sure that argv[0] is neither 'NULL' nor point to
an empty string before assigned to tst_test->tid. And then no matter
what the string it is like, we only using it as a string. I think that
would be safe for LTP.


Method_1:
-------------
 $cat tst_test.c

static void get_tid(char *argv[])
{
       char *p;
       int chk = 1;

       chk = argv[0] == NULL ? 0 : strcmp(argv[0], "\0");
       if (chk == 0)
               tst_brk(TBROK, "No tid set in test structure");

       tst_test->tid = (p = strrchr(argv[0], '/')) ? p+1 : argv[0];
}


static void do_setup(int argc, char *argv[])
{
...
        if (!tst_test->tid)
               get_tid(argv);
...
}

>
> So if we go this way we should add sanity checks if there is something
> sensible in the argv[0].
>
>> > And I wonder if we can avoid runtime detection, which is always tricky.
>> > Maybe we can just do:
>> >
>> > struct tst_test test = {
>> >         .id = __FILE__,
>> > };
>> >
>> > And strip the .c suffix in the test library if present. That way we
>> > would avoid this kind of copy&paste errors.
>>
>> Hmm, I have no objection with this method, but it seems still need the
>> author to write ".tid = __FILE__" each time. To strip the .c suffix is
>> also need additional work in some place.
>
> I think that this is just a little more robust solution, but yes it's
> less elegant one.

Not sure if I understand this way correctly, something achieved as:

Method_2:
------------

$ cat tst_test.h

struct tst_test {
       char tid[128];
...
}


$ cat tst_test.c

static void get_tid(void)
{
       char *p;

       p = (strrchr(tst_test->tid, '.'));
       if (p)
               *p = '\0';
}

static void do_setup(int argc, char *argv[])
{
       if (tst_test->tid[0] == '\0')
                tst_brk(TBROK, "No tid set in test structure");
       else
               get_tid();
...
}


$ cat ioctl06.c

 static struct tst_test test = {
       .tid = __FILE__,
...
}

>
> Anyway looking at the code the tid is only used when creating temporary
> directory/shm so that it's clear which testcase these global resources
> belongs to. So as far as we can easily identify which test has created
> the temp directory given it's name it's fine.
>

What we do to get tid is early than create a temp directory. Looking
at function setup_ipc(), no matter if we need temp dir or not, the
tst_test->tid should be available there. So this is a general demand
to ltp testcase not specified.


I drafted above two methods for comparison, I prefer to go method_1,
because it makes LTP authors no need to consider ".tid=" any more.
what do you think?

-- 
Regards,
Li Wang
Email: liwang@redhat.com
