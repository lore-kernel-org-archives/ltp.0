From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 9 Nov 2018 12:57:09 -0500 (EST)
Subject: [LTP] [PATCH 2/2] lib: build check parameters for tst_brk()
In-Reply-To: <5BE4E95E.4000303@cn.fujitsu.com>
References: <88db8a4def940c63ec2836cec1d0041db00ffd4c.1541710635.git.jstancek@redhat.com>
 <d3ce5d3247f7f09cfabd288b40893bb631fb190f.1541710635.git.jstancek@redhat.com>
 <5BE4E95E.4000303@cn.fujitsu.com>
Message-ID: <1582215982.71956713.1541786229415.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On 2018/11/09 4:59, Jan Stancek wrote:
> > This patch adds simple build-check that allows only
> > TFAIL, TBROK and TCONF as parameter for tst_brk().
> >
> > TFAIL is currently quite commonly used as a shortcut for
> > TFAIL + exit() by many tests. I kept it for now, since
> > it doesn't go against current doc description.
> >
> > Per kernel comments this approach works fine for simple
> > cases, which should be sufficient for LTP, e.g. we don't
> > pass TBROK as a paramter to inlined function, that passes
> > it further down to tst_brk().
> >
> > Signed-off-by: Jan Stancek<jstancek@redhat.com>
> > ---
> >   include/tst_common.h | 3 +++
> >   include/tst_test.h   | 7 +++++--
> >   2 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/tst_common.h b/include/tst_common.h
> > index 27924766ef6e..358f2a76ecda 100644
> > --- a/include/tst_common.h
> > +++ b/include/tst_common.h
> > @@ -65,4 +65,7 @@
> >   	ERET;								\
> >   })
> >
> > +#define BUILD_BUG_ON(condition) \
> > +	do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)
> > +
> >   #endif /* TST_COMMON_H__ */
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index 2ebf746eb720..cd936eb792bd 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -69,8 +69,11 @@ void tst_brk_(const char *file, const int lineno, int
> > ttype,
> >                 const char *fmt, ...)
> >                 __attribute__ ((format (printf, 4, 5)));
> >
> > -#define tst_brk(ttype, arg_fmt, ...) \
> > -	tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
> > +#define tst_brk(ttype, arg_fmt, ...)						\
> > +	({									\
> > +		BUILD_BUG_ON(!((ttype)&  (TBROK | TCONF | TFAIL)));		\
> > +		tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
> > +	})
> Hi Jan,
> 
> Perhaps, we could add some hints about the invalid ttype.
> e.g. "tst_brk(): invalid type, please use TBROK/TCONF/TFAIL"

Do you have suggestion how to achieve that?

There's an __attribute__(error), but it's supported only from gcc 4.3 as I recall.
Alternative would be link time failure, with a symbol name suggesting what went wrong.

Regards,
Jan

> 
> Other than that, this patch set looks good to me.
> 
> Best Regards,
> Xiao Yang
> 
> >
> >   /* flush stderr and stdout */
> >   void tst_flush(void);
> 
> 
> 
> 
