From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Wed, 6 Jun 2018 16:04:13 +0200
Subject: [LTP] [PATCH 1/2] testcase: lib: Create tst_getconf to replace
 "getconf"
In-Reply-To: <CAEemH2emKafpuN0XyftQ33N1X_=gpSq2JpQG3_QrsdTCqkF9mQ@mail.gmail.com>
References: <20180605140624.7114-1-mylene.josserand@bootlin.com>
 <20180605140624.7114-2-mylene.josserand@bootlin.com>
 <CAEemH2emKafpuN0XyftQ33N1X_=gpSq2JpQG3_QrsdTCqkF9mQ@mail.gmail.com>
Message-ID: <20180606160413.13e5f97c@dell-desktop.home>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hello,

On Wed, 6 Jun 2018 12:11:25 +0800
Li Wang <liwang@redhat.com> wrote:

> Mylène Josserand <mylene.josserand@bootlin.com> wrote:
> 
> > In some system, "getconf" application may not be installed.
> > Some tests are using it to retrieve some variables such as the
> > page size (PAGESIZE).
> >
> > Create a tst_getconf binary that use sysconf() function to retrieve
> > these variables instead of relying on "getconf" application that
> > may not be available.
> > Add also this new helper in the documentation.
> >
> > Example:
> > pagesize=`tst_getconf PAGESIZE`
> >
> > Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> > ​[...]
> > +
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +
> > +static void print_help(void)
> > +{
> > +       printf("Usage: tst_getconf variable\n\n");
> > +       printf("       variable: can be PAGESIZE or _NPROCESSORS_ONLN (for
> > the moment)\n");
> > +       printf("example: tst_getconf PAGESIZE\n");
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +       int opt;
> > +
> > +       while ((opt = getopt(argc, argv, ":h")) != -1) {
> > +               switch (opt) {
> > +               case 'h':
> > +                       print_help();
> > +                       return 0;
> > +               default:
> > +                       print_help();
> > +                       return 1;
> > +               }
> > +       }
> >  
> 
> ​What about set argc limitation here?​
> 
> ​    if (argc != 2) {
>         print_help();
>         return 1;
>     }
> 
> ​

Sure, I will add it in V2.

> 
> > +
> > +       if (optind >= argc) {
> > +               fprintf(stderr, "ERROR: Expected variable argument\n\n");
> > +               print_help();
> > +               return 1;
> > +       }
> > +
> > +       if (!strcmp(argv[optind], "_NPROCESSORS_ONLN"))
> > +               printf("%ld", sysconf(_SC_NPROCESSORS_ONLN));
> > +       else if (!strcmp(argv[optind],"PAGESIZE"))
> > +               printf("%ld", sysconf(_SC_PAGE_SIZE));
> >  
> 
> ​We'd better add a default check for invalid parameter here, assume that if
> someone gives
> a typo in use this tst_getconf, it's not easy to find the error.
> 
> # ./tst_getconf _NPROCESSORS_ONL  <--- typo here
> # echo $?
> 0
> 
> 

Exact, thank you for the review.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
