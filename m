From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Mar 2017 11:12:50 +0200
Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit
 programs	on 64bit
In-Reply-To: <1888940677.16511157.1490776585392.JavaMail.zimbra@redhat.com>
References: <20170328100114.29730-1-chrubis@suse.cz>
 <1888940677.16511157.1490776585392.JavaMail.zimbra@redhat.com>
Message-ID: <20170329091250.GC7089@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > * Configure test if compiler supports -m32
> >   TODO: Does 32bit compiler accept -m32?
> >         If so, we should fail the test on 32bit
> > 	platforms by default.
> > 
> > * The directory lib32 contains symlinks of minimal set of sources
> >   needed to link newlib testcase + Makefile.
> > 
> > * The testcases.mk builds 32bit library as well if
> >   32bit compiler was installed (-m32 configure test was succesful)
> > 
> > * And finally the env_post.mk switches between lib and lib32 depeding
> >   on if -m32 was passed in the CFLAGS
> > 
> 
> One issue I ran into is that configure checks can vary
> between default and -m32. Here's one exception from RHEL5.6:
> 
> # cat 1.c 
> int main(void) {
>         int i = 0;
>         return __sync_add_and_fetch(&i, 1);
> }
> 
> # gcc 1.c 
> # gcc -m32 1.c 
> /tmp/ccwrlcJi.o: In function `main':
> 1.c:(.text+0x27): undefined reference to `__sync_add_and_fetch_4'
> collect2: ld returned 1 exit status

Right, we would have to check for atomic operations with -m32 as well.

I guess that we can add -DUSE_M32 into the lib32/Makefile and add a few
ifdefs into the tst_atomic.h something as:

#if (defined(USE_M32) && HAVE_SYNC_AND_FETCH32 == 1) || \
    (!defined(USE_M32) && HAVE_SYNC_AND_FETCH == 1)
...
#elif ...
...

> > TODO: Check if LTP works with -m32 in CFLAGS passed to configure as well
> 
> This fails for me on RHEL7:
> 
> # make
> make[1]: Entering directory `/root/ltp/lib/newlib_tests'
> gcc -m32 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -W -Wall  -I../../include -I../../include -I../../include/old/   -L../../lib32  test14.c   -lltp -o test14
> /tmp/ccPZUDSr.o: In function `cleanup':
> /root/ltp/lib/newlib_tests/test14.c:31: undefined reference to `safe_fopen'
> /root/ltp/lib/newlib_tests/test14.c:32: undefined reference to `safe_socket'
> collect2: error: ld returned 1 exit status
> make[1]: *** [test14] Error 1
> make[1]: Leaving directory `/root/ltp/lib/newlib_tests'
> make: *** [all] Error 2

This is likely because we try to link against lib32 since -m32 is passed
in CFLAGS but lib32/ directory links only subset of the C sources. I
would like to disable all the lib32 machinery either when we run on
32bit machine or if -m32 was passed to the configure and use lib32 only
in a case that we run on 64 bit machine and want to link 32 bit binary.

-- 
Cyril Hrubis
chrubis@suse.cz
