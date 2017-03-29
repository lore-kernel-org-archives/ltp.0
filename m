From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Mar 2017 04:36:25 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit
 programs	on 64bit
In-Reply-To: <20170328100114.29730-1-chrubis@suse.cz>
References: <20170328100114.29730-1-chrubis@suse.cz>
Message-ID: <1888940677.16511157.1490776585392.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 28 March, 2017 12:01:14 PM
> Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit programs	on 64bit
> 
> This is proof of concept for building 32bit testcases on 64bit platform.
> 
> What we do is:
> 
> * Configure test if compiler supports -m32
>   TODO: Does 32bit compiler accept -m32?
>         If so, we should fail the test on 32bit
> 	platforms by default.
> 
> * The directory lib32 contains symlinks of minimal set of sources
>   needed to link newlib testcase + Makefile.
> 
> * The testcases.mk builds 32bit library as well if
>   32bit compiler was installed (-m32 configure test was succesful)
> 
> * And finally the env_post.mk switches between lib and lib32 depeding
>   on if -m32 was passed in the CFLAGS
> 

One issue I ran into is that configure checks can vary
between default and -m32. Here's one exception from RHEL5.6:

# cat 1.c 
int main(void) {
        int i = 0;
        return __sync_add_and_fetch(&i, 1);
}

# gcc 1.c 
# gcc -m32 1.c 
/tmp/ccwrlcJi.o: In function `main':
1.c:(.text+0x27): undefined reference to `__sync_add_and_fetch_4'
collect2: ld returned 1 exit status

> TODO: Check if LTP works with -m32 in CFLAGS passed to configure as well

This fails for me on RHEL7:

# make
make[1]: Entering directory `/root/ltp/lib/newlib_tests'
gcc -m32 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -W -Wall  -I../../include -I../../include -I../../include/old/   -L../../lib32  test14.c   -lltp -o test14
/tmp/ccPZUDSr.o: In function `cleanup':
/root/ltp/lib/newlib_tests/test14.c:31: undefined reference to `safe_fopen'
/root/ltp/lib/newlib_tests/test14.c:32: undefined reference to `safe_socket'
collect2: error: ld returned 1 exit status
make[1]: *** [test14] Error 1
make[1]: Leaving directory `/root/ltp/lib/newlib_tests'
make: *** [all] Error 2

I ran into one other problem, but I don't think that's relevant
for this patch. I'll follow up in separate email thread.

Regards,
Jan
