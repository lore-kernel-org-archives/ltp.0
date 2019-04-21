From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 22 Apr 2019 00:10:30 +0200
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <aafe58ce-e74d-b350-4e91-445683c120fc@xiaopeng.com>
References: <20190411173755.GA9800@dell5510> <20190411234041.GB381@x230>
 <5bad3463-5c4f-2b70-6500-70d715fd3181@xiaopeng.com>
 <20190412062814.GA18106@dell5510>
 <ee797e09-e650-4869-60b7-f6e8e32844bb@xiaopeng.com>
 <20190412194809.GE124555@google.com>
 <11cb4fc5-c37a-adfd-831c-257c815849db@xiaopeng.com>
 <20190417163923.GG124555@google.com> <20190417170651.GA26229@x230>
 <aafe58ce-e74d-b350-4e91-445683c120fc@xiaopeng.com>
Message-ID: <20190421221030.GA11307@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Sandeep, Zhengwang,

> > I don't know why autotools fails preadv and pwritev detection with AC_CHECK_FUNCS.
> > I considered it as problem of my setup, but maybe it's an autotools bug.

> I also encountered this issue, but I temporarily walked around it by
> applying the following patch.

> ==================

> $ git diff testcases/
> diff --git a/testcases/commands/ldd/datafiles/Makefile
> b/testcases/commands/ldd/datafiles/Makefile
> index d8bcf5c..74fbe50 100644
> --- a/testcases/commands/ldd/datafiles/Makefile
> +++ b/testcases/commands/ldd/datafiles/Makefile
> @@ -30,7 +30,7 @@ CLEAN_TARGETS         += *.obj $(LDD_SO_FILES)
>         $(CC) $(CFLAGS) -shared -o $@ $^

>  lddfile.out: main.o $(LDD_SO_FILES)
> -       $(CC) $(CFLAGS) -O -o $@ $?
> +       $(CC) $(CFLAGS) $(LDFLAGS) -O -o $@ $?
What is this change for?

>  INSTALL_DIR            := testcases/data/ldd01

> diff --git a/testcases/kernel/syscalls/Makefile
> b/testcases/kernel/syscalls/Makefile
> index 45a00cf..27c2e7a 100644
> --- a/testcases/kernel/syscalls/Makefile
> +++ b/testcases/kernel/syscalls/Makefile
> @@ -43,6 +43,8 @@ FILTER_OUT_DIRS       += \
>         sched_getaffinity sched_setaffinity sendmsg setgroups setns sighold
> \
>         sigrelse sigsuspend sigtimedwait sigwait sigwaitinfo stime \
>         setdomainname sethostname symlinkat ulimit ustat vfork vhangup
> vmsplice
> +
> +FILTER_OUT_DIRS += preadv pwritev
Yes, that fixes build. But manually disabling features in config.h enables these
tests to be build.

Kind regards,
Petr
