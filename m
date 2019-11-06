From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 6 Nov 2019 19:42:30 +0100
Subject: [LTP] [PATCH 2/2] fanotify: Rename fanotify_event_info_fid
 struct
In-Reply-To: <20191105130412.GC8511@rei.lan>
References: <20191105005341.19033-1-petr.vorel@gmail.com>
 <20191105005341.19033-3-petr.vorel@gmail.com>
 <20191105130412.GC8511@rei.lan>
Message-ID: <20191106184230.GA10470@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
> > To fix build on musl, which also defines fanotify_event_info_fid,
> > but uses fsid_t type for fsid instead of __kernel_fsid_t.

> > This fixes errors:

> > fanotify13.c: In function ???do_test???:
> > fanotify13.c:278:20: error: ???fsid_t??? {aka ???struct __fsid_t???} has no member named ???val???; did you mean ???__val????
> >     event_fid->fsid.val[0],
> >                     ^~~
> > ../../../../include/tst_test.h:49:53: note: in definition of macro ???tst_res???
> >   tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
> >                                                      ^~~~~~~~~~~
> > fanotify13.c:279:20: error: ???fsid_t??? {aka ???struct __fsid_t???} has no member named ???val???; did you mean ???__val????
> >     event_fid->fsid.val[1],

> > musl (unlike glibc and uclibc-ng) defines fanotify_event_info_fid in
> > fanotify.h and uses fsid_t as type for fanotify_event_info_fid.fsid
> > member, which defines __val[2] (unlike val[2] in __kernel_fsid_t).

> I don't know, this really sounds like a bug in musl.
What would you propose to fix? Change fsid_t member to val[2]?
I'm a bit confused, which one is correct.
Or removing fanotify_event_info_fid struct?

In musl: 32b82cf5 ("fix the fsid_t structure to match name of __val")
changed it from val[2] to __val[2] in 2011 with comment:

    this is a case of poorly written man pages not matching the actual
    implementation, and why i hate implementing nonstandard interfaces
    with no actual documentation of how they're intended to work.

Kernel defines __kernel_fsid_t with val[2]
/* kernel include/uapi/asm-generic/posix_types.h */
#ifndef __kernel_fsid_t
typedef struct {
	int	val[2];
} __kernel_fsid_t;
#endif

And it was using val[2] at least in v2.6.31-rc1 - no sing to be __val[2].

glibc has __val[2] member. That's what triggered musl change I guess.
It looks to me it was here 2.3.1, before it used __u_quad_t
(typedef unsigned long long int __u_quad_t), but still with __val[2].

/* glibc posix/bits/types.h */
__STD_TYPE __FSID_T_TYPE __fsid_t;	/* Type of file system IDs.  */
/* glibc bits/typesizes.h */
#define __FSID_T_TYPE		struct { int __val[2]; }
/* glibc bits/statvfs.h */
struct statvfs
  {
...
    __fsid_t f_fsid;

Uclibc defines __kernel_fsid_t, sometimes defines it as val[2] and sometimes
have a condition __USE_ALL to have it val[2] (not sure if __USE_ALL is a
default, I haven't found any doc about it (is it uclibc specific or what?)

/* uclibc include/sys/types.h */
typedef __fsid_t fsid_t;

/* uclibc libc/sysdeps/linux/x86_64/bits/kernel_types.h */
typedef struct {
#ifdef __USE_ALL
	int val[2];
#else
	int __val[2];
#endif
} __kernel_fsid_t;

#endif
/* uclibc libc/sysdeps/linux/aarch64/bits/kernel_types.h */
typedef struct {
	int	val[2];
} __kernel_fsid_t;

But for __fsid_t uses the same code as glibc, with __val[2].

=> libc types use __val[2], kernel types __val.
The problem is really with mixing kernel and libc struct.
That's why I'd be to ask musl to remove it.

Kind regards,
Petr
