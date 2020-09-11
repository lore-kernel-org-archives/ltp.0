From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Sep 2020 05:06:16 +0300
Subject: [LTP] [PATCH 1/1] fanotify10: Treat ignore mask bug as TCONF
 for < v5.9
In-Reply-To: <20200910153035.GA12601@yuki.lan>
References: <20200910121628.18505-1-pvorel@suse.cz>
 <20200910153035.GA12601@yuki.lan>
Message-ID: <CAOQ4uxjaiT4N1uvwzh8Jer4wc3HR+pqxNM_CLzFWZDbxZDxEHA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Sep 10, 2020 at 6:30 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> >                       if (ret > 0) {
> > -                             tst_res(TFAIL, "group %d (%x) with %s and "
> > -                                     "%s ignore mask got event",
> > +                             tst_res((tst_kvercmp(5, 9, 0)) < 0 ? TCONF : TFAIL,
> > +                                     "group %d (%x) with %s and %s ignore mask got event",
> >                                       i, fanotify_class[p], mark->name, ignore_mark->name);
>
> I do not like that much, how the tst_kvercmp() is sandwitched inside of
> the tst_res() call, since it makes it easier to be overlooked.
>
> The question is how can we do better, maybe set a variable in test
> setup?
>

I apologize. I did not review this change carefully.

What I suggested was to skip only the test cases with non zero
tc->ignored_onchild for kernel < 5.9.

Those are the new test cases that are failing due to missing fix
"497b0c5a7c06 fsnotify: send event to parent and child with single"
Which is not likely to be backported.

I see no reason to run those test cases and then report the failure as
TCONF.
The TCONF message can say that ignored mask in combination with
flag FAN_EVENT_ON_CHILD have undefined behavior on kernel < 5.9.

While@it, please remove the stray line from header comment:
 *     497b0c5a7c06 fsnotify: send event to parent and child with single...
 *     eca4784cbb18 fsnotify: send event to parent and child with single...

And please remove commit id 497b0c5a7c06 from .tags, otherwise,
stable kernel maintainers are still going to be bothered by attempting
to find a backport if that test fails due to other reasons on a stable kernel.

Thanks,
Amir.
