From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Nov 2019 14:04:12 +0100
Subject: [LTP] [PATCH 2/2] fanotify: Rename fanotify_event_info_fid
 struct
In-Reply-To: <20191105005341.19033-3-petr.vorel@gmail.com>
References: <20191105005341.19033-1-petr.vorel@gmail.com>
 <20191105005341.19033-3-petr.vorel@gmail.com>
Message-ID: <20191105130412.GC8511@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> To fix build on musl, which also defines fanotify_event_info_fid,
> but uses fsid_t type for fsid instead of __kernel_fsid_t.
> 
> This fixes errors:
> 
> fanotify13.c: In function ???do_test???:
> fanotify13.c:278:20: error: ???fsid_t??? {aka ???struct __fsid_t???} has no member named ???val???; did you mean ???__val????
>     event_fid->fsid.val[0],
>                     ^~~
> ../../../../include/tst_test.h:49:53: note: in definition of macro ???tst_res???
>   tst_res_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__)
>                                                      ^~~~~~~~~~~
> fanotify13.c:279:20: error: ???fsid_t??? {aka ???struct __fsid_t???} has no member named ???val???; did you mean ???__val????
>     event_fid->fsid.val[1],
> 
> musl (unlike glibc and uclibc-ng) defines fanotify_event_info_fid in
> fanotify.h and uses fsid_t as type for fanotify_event_info_fid.fsid
> member, which defines __val[2] (unlike val[2] in __kernel_fsid_t).

I don't know, this really sounds like a bug in musl.

-- 
Cyril Hrubis
chrubis@suse.cz
