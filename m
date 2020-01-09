From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2020 14:59:26 +0800
Subject: [LTP] [PATCH] tst_device: add new tst_dev_sync
In-Reply-To: <20200108114545.GA28867@dell5510>
References: <20200107071324.29492-1-liwang@redhat.com>
 <20200107101119.GA22967@rei.lan>
 <CAEemH2fmmQ2a0EVHoqkMwMOjy5EZoiNT+02yYRz-TnWpTQ__0A@mail.gmail.com>
 <20200108112537.GA22954@dell5510> <20200108113535.GA17272@rei.lan>
 <CAEemH2dZ0pVqpaecjO06stw8RiK-hmSUWwo=kndm3EsvoXCW2w@mail.gmail.com>
 <20200108114141.GB17272@rei.lan> <20200108114545.GA28867@dell5510>
Message-ID: <CAEemH2dUhpixZoorh_-H1CHenk9-XG9ZocjHB30RqzW_Kb0dCw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jan 8, 2020 at 7:45 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li, Cyril,
>
> > Hi
> > > Btw I just pushed a simple fix to include unistd.h, it seems not works.
>
> > You would need to define _GNU_SOURCE at the top of each test that uses
> > it otherwise the definition is not exposed.
> Yep :(. I join to Cyril's vote for raw syscall.
> BTW please test it with travis or locally build.sh script (which adds
> -Werror=implicit-function-declaration).
>

I'd go with syscall(__NR_syncfs, fd) in the tst_device.h and
define _GNU_SOURCE in relevant test cases.

The reason why not use tst_syscall() is that involves a new compile error
of tst_brk, and it can not get rid of errors only via include tst_test.h
file.


>
> I guess we should work on travis CI integration so we don't have to push
> it to
> travis manually [1].
>

That's a good proposal. I feel so sorry for pushing without a compiling in
Travis this time, because I thought the code is good enough but ...

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200109/b045fbe0/attachment-0001.htm>
