From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Dec 2018 10:25:21 +0100
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <CAEemH2cD71UjUJ-b3HeTyf58JSUCcb+iCo9Om9Vez=L7UYwKmg@mail.gmail.com>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
 <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
 <20181204173542.GD30799@dell5510>
 <CAEemH2cD71UjUJ-b3HeTyf58JSUCcb+iCo9Om9Vez=L7UYwKmg@mail.gmail.com>
Message-ID: <20181205092521.GA7618@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li, Jan,

> > > Alternative would be link time failure, with a symbol name suggesting what went wrong.
> > Not sure, how exactly you want to do it, but seems to be more portable than
> > requiring specific gcc version (although 4.3 is very old and __attribute__
> > format is supported by clang as well).

> I took an rough look at the kernel method, maybe we can achieve that
> conditionally?

> --- a/include/tst_common.h
> +++ b/include/tst_common.h
> @@ -65,4 +65,23 @@
>         ERET;                                                           \
>  })

> +#define GCC_VERSION (__GNUC__ * 10000          \
> +                    + __GNUC_MINOR__ * 100     \
> +                    + __GNUC_PATCHLEVEL__)
> +
> +#if GCC_VERSION >= 40300
Didn't you mean reverse?
#if GCC_VERSION < 40300

But this idea does not work for clang, which always use same version:
__GNUC__: 4
__GNUC_MINOR__: 2
__GNUC_PATCHLEVEL__: 1
(tested on clang 3.9, 5.0, 6.0)

There should be also CLANG_VERSION
__clang_major__
__clang_minor__
__clang_patchlevel__

Not sure, which clang version is compiled, even clang 4.0 works well:
https://travis-ci.org/pevik/ltp/builds/463734307
Maybe we could afford to skip check (searching for __clang__).

> +# define BUILD_BUG_ON_MSG(cond, msg) \
> +       compiletime_assert(!(cond), msg, tst_brk_detect_)
...


Kind regards,
Petr
