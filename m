From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Mar 2019 13:06:45 +0100
Subject: [LTP] [PATCH v2] autodetect fts support and tests depending on
	it
In-Reply-To: <3601d849-46fa-b9cd-0a6d-882c8ed9c73f@synopsys.com>
References: <20190318181940.GA5494@dell5510>
 <1552938764-15101-1-git-send-email-vgupta@synopsys.com>
 <20190320223733.GA5619@dell5510>
 <3601d849-46fa-b9cd-0a6d-882c8ed9c73f@synopsys.com>
Message-ID: <20190321120645.GB17345@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Vineet,

> On 3/20/19 3:37 PM, Petr Vorel wrote:
> >> +# controllers/cpuset/cpuset_lib/libcpuset.c uses fts
> >> +# which may not be available/configured in the libc build
> >> +ifndef HAVE_FTS_H
> >> +FILTER_OUT_DIRS	+= cpuset
> >> +endif
> > Have you tested it? 

> Absolutely. I verified again. With this patch reverted locally I see errors due to
> it trying to build the file
I meant testing with glibc :). Because your patch would bring a regression:
ifndef HAVE_FTS_H is always true because HAVE_FTS_H as an autotools check is not
visible to make in this form, no matter what it's set to HAVE_FTS_H in
include/config.h :(.

We could solve previous problem to make HAVE_FTS_H visible with AC_SUBST, while
creating proper autotools function check in m4/. Planning to do that? (if not
I'll do).
My thoughts about dependency problem in shell scripts (TST_TEST_TCONF) was wrong
as these tests are also under cpuset directory.

> With my patch the build runs to completion.

> This will not work as HAVE_LIBAIO_H is in include/config.h,

> You mean HAVE_FTS_H (LIBAIO stuff is for different patch)

> > thus only for C. For Makefile it must be done via autotools (search for AC_SUBST
> > in m4/). I thought TST_TEST_TCONF usage, but you're right, that problematic
> > source is part of libcontrollers.a (i.e. part of a library, not normal C
> > binary).
> Umm not sure what u mean. Going to read the next msg in thread.
See up.

Kind regards,
Petr
