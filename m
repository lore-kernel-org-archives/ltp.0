From: Li Wang <liwang@redhat.com>
Date: Thu, 6 Dec 2018 16:49:56 +0800
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <20181205092521.GA7618@dell5510>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181204173542.GD30799@dell5510>
 <CAEemH2cD71UjUJ-b3HeTyf58JSUCcb+iCo9Om9Vez=L7UYwKmg@mail.gmail.com>
 <20181205092521.GA7618@dell5510>
Message-ID: <CAEemH2f1xJnQV3dt_B1-coRgMRjggPXuHUPQLQq7fsTFkV9GMg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, Dec 5, 2018 at 5:25 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Li, Jan,
>
> > > > Alternative would be link time failure, with a symbol name suggesting what went wrong.
> > > Not sure, how exactly you want to do it, but seems to be more portable than
> > > requiring specific gcc version (although 4.3 is very old and __attribute__
> > > format is supported by clang as well).
>
> > I took an rough look at the kernel method, maybe we can achieve that
> > conditionally?
>
> > --- a/include/tst_common.h
> > +++ b/include/tst_common.h
> > @@ -65,4 +65,23 @@
> >         ERET;                                                           \
> >  })
>
> > +#define GCC_VERSION (__GNUC__ * 10000          \
> > +                    + __GNUC_MINOR__ * 100     \
> > +                    + __GNUC_PATCHLEVEL__)
> > +
> > +#if GCC_VERSION >= 40300
> Didn't you mean reverse?
> #if GCC_VERSION < 40300

No, I saw kernel gives this limitation so just use it as that.
See: https://github.com/torvalds/linux/blob/master/include/linux/build_bug.h#L55

>
> But this idea does not work for clang, which always use same version:
> __GNUC__: 4
> __GNUC_MINOR__: 2
> __GNUC_PATCHLEVEL__: 1
> (tested on clang 3.9, 5.0, 6.0)

Noticed the Travis CI Build #860 works fine with clang, did you config
anything special for that?  BTW, the remain error part of GCC is not
the same issue here, see below comments.

Build #860:
https://travis-ci.org/pevik/ltp/builds/463720369
https://github.com/pevik/ltp/commit/643bceea36c3447add142fcb5e7a3f79e9ac65a2

>
> There should be also CLANG_VERSION
> __clang_major__
> __clang_minor__
> __clang_patchlevel__
>
> Not sure, which clang version is compiled, even clang 4.0 works well:
> https://travis-ci.org/pevik/ltp/builds/463734307
> Maybe we could afford to skip check (searching for __clang__).

Per GCC compiling error, seems the root cause is tst_brk()
parameter(tst_test.c: line#355) not using in demanded, isn't that what
we expected?

In function ‘check_child_status’,
    inlined from ‘tst_reap_children’ at tst_test.c:371:4:
../include/tst_common.h:74:41: error: call to ‘tst_brk_detect_’
declared with attribute error: tst_brk(): invalid type, please use
TBROK/TCONF/TFAIL
        compiletime_assert(!(cond), msg, tst_brk_detect_)
                                         ^
../include/tst_common.h:79:24: note: in definition of macro ‘compiletime_assert’
                        funcname_();                            \
                        ^
../include/tst_test.h:74:16: note: in expansion of macro ‘BUILD_BUG_ON_MSG’
                BUILD_BUG_ON_MSG(!((ttype) & (TBROK | TCONF | TFAIL)), \
                ^
tst_test.c:355:3: note: in expansion of macro ‘tst_brk’
   tst_brk(ret, "Reported by child (%i)", pid);
   ^
make[1]: *** [tst_test.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make[1]: Leaving directory `/home/travis/build/pevik/ltp/lib'
make: *** [lib-all] Error 2

--
Regards,
Li Wang
