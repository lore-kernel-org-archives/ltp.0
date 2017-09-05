From: Sandeep Patil <sspatil@google.com>
Date: Tue, 5 Sep 2017 14:30:27 -0700
Subject: [LTP] [RFC PATCH 1/6] android: cve: Disable building
 cve-2017-5669
In-Reply-To: <20170902005926.15923-2-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-2-petr.vorel@gmail.com>
Message-ID: <20170905213027.GP84377@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sat, Sep 02, 2017 at 02:59:21AM +0200, Petr Vorel wrote:
> shmat() is not available on Android/Binder
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
> ---
>  testcases/cve/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
> index 04abc1f9c..5119c67cf 100644
> --- a/testcases/cve/Makefile
> +++ b/testcases/cve/Makefile
> @@ -28,4 +28,8 @@ cve-2014-0196:  LDLIBS += -lrt -lutil
>  cve-2017-2671:	CFLAGS += -pthread
>  cve-2017-2671:	LDLIBS += -lrt
>  
> +ifeq ($(ANDROID),1)
> +FILTER_OUT_MAKE_TARGETS	+= cve-2017-5669
> +endif
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk

Do you have pointers to how you are build + testing with this? There seem to
be some duplication of effort that I would like to avoid and make sure there
is only 1 way in which tests like this are disabled out of build.

I am currently working through a list[1] of disabled tests to make sure
nothing has changed and will love to have a unified way of maintaining that
list instead of doing it out-of-tree.

- ssp

1. https://android.googlesource.com/platform/external/ltp/+/master/android/tools/disabled_tests.txt
