From: Rafael Tinoco <rafael.tinoco@linaro.org>
Date: Fri, 22 Mar 2019 06:25:34 -0300
Subject: [LTP] check_sync_file_range()
In-Reply-To: <CAFA6WYO5V9TaDvgNxSEHcq75KbsrUWf_OezqcY4oLq02akM0CQ@mail.gmail.com>
References: <2A02D5B5-F67F-43C4-BABA-B0C7EFF6C9F5@linaro.org>
 <CAFA6WYO5V9TaDvgNxSEHcq75KbsrUWf_OezqcY4oLq02akM0CQ@mail.gmail.com>
Message-ID: <CADtBP2DBdP9eRKBPuyt-3QuHZXR7=1ZXTWEh32u7kJ=Of=j_GQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, Mar 22, 2019, 1:42 AM Sumit Garg <sumit.garg@linaro.org> wrote:

> Hi Rafael,
>
> On Thu, 21 Mar 2019 at 01:34, Rafael David Tinoco
> <rafael.tinoco@linaro.org> wrote:
> >
> > I believe check_sync_file_range() logic, from commit
> c0dc8876fb1486ee85f6dd43e36ec5b3d9d9a4ed, should use a different names
> since glibc seems to be implementing the syscall wrapper in recent versions
> and a conflict exists for me at least:
> >
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W
> -Wold-style-definition -D_FORTIFY_SOURCE=2 -I../../../../include
> -I../../../../include -I../../../../include/old/   -L../../../../lib
> sync_file_range02.c   -lltp -o sync_file_range02
> > In file included from sync_file_range02.c:21:
> > ../../../../include/lapi/sync_file_range.h:24:20: error: conflicting
> types for ‘sync_file_range’
> >  static inline long sync_file_range(int fd, off64_t offset, off64_t
> nbytes,
> >                     ^~~~~~~~~~~~~~~
> > In file included from /usr/include/x86_64-linux-gnu/bits/fcntl.h:61,
> >                  from /usr/include/fcntl.h:35,
> >                  from ../../../../include/tst_safe_macros.h:27,
> >                  from ../../../../include/tst_test.h:90,
> >                  from sync_file_range02.c:20:
> > /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h:397:12: note: previous
> declaration of ‘sync_file_range’ was here
> >  extern int sync_file_range (int __fd, __off64_t __offset, __off64_t
> __count,
> >             ^~~~~~~~~~~~~~~
> >
>
> Did you ran configure check before building the test-case? Actually
> the commit you referred to adds functionality to use glibc syscall
> wrapper if present or else fallback to api defined in
> include/lapi/sync_file_range.h.
>
> See: "m4/ltp-sync_file_range.m4", "configure.ac" for configure check.
>

True, my bad. Thanks Submit. Sorry for the false warning.

>
> -Sumit
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190322/e4cf15ff/attachment.html>
