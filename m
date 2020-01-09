From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 09:06:17 +0100
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <CAEemH2dUhpixZoorh_-H1CHenk9-XG9ZocjHB30RqzW_Kb0dCw@mail.gmail.com>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
 <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
 <20200108112537.GA22954@dell5510> <20200108113535.GA17272@rei.lan>
 <CAEemH2dZ0pVqpaecjO06stw8RiK-hmSUWwo=kndm3EsvoXCW2w@mail.gmail.com>
 <20200108114141.GB17272@rei.lan> <20200108114545.GA28867@dell5510>
 <CAEemH2dUhpixZoorh_-H1CHenk9-XG9ZocjHB30RqzW_Kb0dCw@mail.gmail.com>
Message-ID: <20200109080617.GA10609@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > > You would need to define _GNU_SOURCE at the top of each test that uses
> > > it otherwise the definition is not exposed.
> > Yep :(. I join to Cyril's vote for raw syscall.
> > BTW please test it with travis or locally build.sh script (which adds
> > -Werror=implicit-function-declaration).

> I'd go with syscall(__NR_syncfs, fd) in the tst_device.h and
> define _GNU_SOURCE in relevant test cases.

> The reason why not use tst_syscall() is that involves a new compile error
> of tst_brk, and it can not get rid of errors only via include tst_test.h
> file.
+1. (I already tested it and replied to that patch).

I wonder if this is a pattern (try to avoid _GNU_SOURCE code in the library, if
needed use syscall() instead).
I'm asking because I still plan to write v2 for library API writing guidelines
docs patch.

BTW you didn't update wiki after merging eca0fa3c3.
I did it :) (we need some maintainer docs as well, we keep with Cyril to update
wiki and (sometimes) maintain patchwork for other maintainers).
BTW there is git repository for each git on github (our [2]), I maintain it with
shell script.

> > I guess we should work on travis CI integration so we don't have to push
> > it to
> > travis manually [1].


> That's a good proposal. I feel so sorry for pushing without a compiling in
> Travis this time, because I thought the code is good enough but ...
No problem :).

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/1166786/
[2] https://github.com/linux-test-project/ltp.wiki.git
