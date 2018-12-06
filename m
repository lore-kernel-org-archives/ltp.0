From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 Dec 2018 14:07:36 +0100
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <CAEemH2f1xJnQV3dt_B1-coRgMRjggPXuHUPQLQq7fsTFkV9GMg@mail.gmail.com>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181204173542.GD30799@dell5510>
 <CAEemH2cD71UjUJ-b3HeTyf58JSUCcb+iCo9Om9Vez=L7UYwKmg@mail.gmail.com>
 <20181205092521.GA7618@dell5510>
 <CAEemH2f1xJnQV3dt_B1-coRgMRjggPXuHUPQLQq7fsTFkV9GMg@mail.gmail.com>
Message-ID: <20181206130736.GB31874@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > > +#if GCC_VERSION >= 40300
> > Didn't you mean reverse?
> > #if GCC_VERSION < 40300

> No, I saw kernel gives this limitation so just use it as that.
> See: https://github.com/torvalds/linux/blob/master/include/linux/build_bug.h#L55
OK, I didn't get from Jan's "There's an __attribute__(error), but it's supported
only from gcc 4.3 as I recall.", that it is in 4.3 and older. First I thought
it's a new feature, but didn't find any reference.


> > But this idea does not work for clang, which always use same version:
> > __GNUC__: 4
> > __GNUC_MINOR__: 2
> > __GNUC_PATCHLEVEL__: 1
> > (tested on clang 3.9, 5.0, 6.0)

> Noticed the Travis CI Build #860 works fine with clang, did you config
> anything special for that?  BTW, the remain error part of GCC is not
> the same issue here, see below comments.
No.

> Build #860:
> https://travis-ci.org/pevik/ltp/builds/463720369
> https://github.com/pevik/ltp/commit/643bceea36c3447add142fcb5e7a3f79e9ac65a2
It's your commit from https://patchwork.ozlabs.org/patch/995203/#2045049

+  syscalls/mq: don't use TWARN with tst_brk()
https://patchwork.ozlabs.org/patch/995202/


Kind regards,
Petr
