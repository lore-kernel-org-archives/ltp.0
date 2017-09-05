From: enh <enh@google.com>
Date: Tue, 5 Sep 2017 10:47:32 -0700
Subject: [LTP] [RFC PATCH 1/6] android: cve: Disable building
	cve-2017-5669
In-Reply-To: <20170902005926.15923-2-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-2-petr.vorel@gmail.com>
Message-ID: <CAJgzZorAbjhp7_eX87xRbKJ1PjM=uUdJrjHksUUQ-ot9KwYcrw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

(strictly, shmat is there in the c library, but (a) there's an selinux
neverallow for sysv ipc and (b) it's compiled out of the kernel.)

On Fri, Sep 1, 2017 at 5:59 PM, Petr Vorel <petr.vorel@gmail.com> wrote:
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
>  cve-2017-2671: CFLAGS += -pthread
>  cve-2017-2671: LDLIBS += -lrt
>
> +ifeq ($(ANDROID),1)
> +FILTER_OUT_MAKE_TARGETS        += cve-2017-5669
> +endif
> +
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> --
> 2.14.0
>



-- 
Elliott Hughes - http://who/enh - http://jessies.org/~enh/
Android native code/tools questions? Mail me/drop by/add me as a reviewer.
