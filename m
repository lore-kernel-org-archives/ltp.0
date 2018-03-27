From: Xiong Zhou <xzhou@redhat.com>
Date: Tue, 27 Mar 2018 20:12:09 +0800
Subject: [LTP] [PATCH] fcntl37: test posix lock across execve
In-Reply-To: <20180327101929.GA11658@rei>
References: <1522070895-2289-1-git-send-email-xzhou@redhat.com>
 <20180326143313.GE27423@rei>
 <20180327085043.e7hrrcho5xzkdh34@XZHOUW.usersys.redhat.com>
 <20180327101929.GA11658@rei>
Message-ID: <20180327121209.qnl5xxjezdyiu72f@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 27, 2018 at 12:19:29PM +0200, Cyril Hrubis wrote:
> Hi!
> > > > +fcntl37: LDLIBS += -lpthread
> > > > +fcntl37_64: LDLIBS += -lpthread
> > > 
> > > This is wrong, we should use CFLAGS += -pthread instead, also the rest
> > 				^ This is not working.
> > 
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -DTST_USE_NEWER64_SYSCALL=1 -pthread -D_FORTIFY_SOURCE=2 -I/home/xzhou/ltp/testcases/kernel/syscalls/fcntl -I/home/xzhou/ltp/testcases/kernel/syscalls/fcntl/../utils -D_GNU_SOURCE -I../../../../include -I../../../../include -I../../../../include/old/ -D_FILE_OFFSET_BITS=64  -c -o fcntl37_64.o fcntl37.c
> > gcc   -L../../../../lib  fcntl37_64.o   -lltp -o fcntl37_64
> > ../../../../lib/libltp.a(safe_pthread.o): In function `safe_pthread_create':
> > /home/xzhou/ltp/lib/safe_pthread.c:30: undefined reference to `pthread_create'
> > ../../../../lib/libltp.a(safe_pthread.o): In function `safe_pthread_join':
> > /home/xzhou/ltp/lib/safe_pthread.c:46: undefined reference to `pthread_join'
> > collect2: error: ld returned 1 exit status
> 
> Hmm, looks like something is wrong with the newer_64.mk. It picks up a
> linker rule that does not include CFLAGS. Following patch fixes that,
> but I'm not 100% sure that it's correct, I will look further into that.
> 
> diff --git a/testcases/kernel/syscalls/utils/newer_64.mk b/testcases/kernel/syscalls/utils/newer_64.mk
> index 8cd7e03c8..c70c2af53 100644
> --- a/testcases/kernel/syscalls/utils/newer_64.mk
> +++ b/testcases/kernel/syscalls/utils/newer_64.mk
> @@ -49,7 +49,9 @@ HAS_NEWER_64          := 0
>  endif
>  
>  %_64: CFLAGS += -D$(DEF_64)=1
> -# XXX (garrcoop): End section of code in question..
>  
>  %_64.o: %.c
>         $(COMPILE.c) $(OUTPUT_OPTION) $<
> +
> +%_64: %_64.o
> +       $(LINK.c) $(OUTPUT_OPTION) $< $(LDLIBS)

This patch works fine.

Thanks,
Xiong

> 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
