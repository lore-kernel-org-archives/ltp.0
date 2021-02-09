From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Feb 2021 11:07:35 +0100
Subject: [LTP] ltp build error
In-Reply-To: <CAD5BMqCdJXgqu2kwaRjD7=SRORDGoxENnRXBG5UrwvsmtjOzrQ@mail.gmail.com>
References: <CAD5BMqCdJXgqu2kwaRjD7=SRORDGoxENnRXBG5UrwvsmtjOzrQ@mail.gmail.com>
Message-ID: <YCJe54ZzREDRJ+tQ@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
You should have just send the relevant part of the log which is:

CC testcases/kernel/syscalls/getpgrp/getpgrp01
In file included from ../../../../include/tst_test.h:14,
                 from ustat01.c:9:
/usr/include/x86_64-linux-gnu/bits/ustat.h:24:8: error: redefinition of ?~@~Xstruct statfs?~@~Y
 struct ustat
        ^~~~~
In file included from ../../../../include/tst_test.h:14,
                 from ustat02.c:10:
/usr/include/x86_64-linux-gnu/bits/ustat.h:24:8: error: redefinition of ?~@~Xstruct statfs?~@~Y
 struct ustat
        ^~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/statfs.h:25,
                 from /usr/include/x86_64-linux-gnu/sys/vfs.h:4,
                 from ../../../../include/tst_safe_macros.h:14,
                 from ../../../../include/tst_test.h:93,
                 from ustat01.c:9:
/usr/include/x86_64-linux-gnu/bits/statfs.h:24:8: note: originally defined here
 struct statfs
        ^~~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/statfs.h:25,
                 from /usr/include/x86_64-linux-gnu/sys/vfs.h:4,
                 from ../../../../include/tst_safe_macros.h:14,
                 from ../../../../include/tst_test.h:93,
                 from ustat02.c:10:
/usr/include/x86_64-linux-gnu/bits/statfs.h:24:8: note: originally defined here
 struct statfs
        ^~~~~~
In file included from ../../../../include/tst_test.h:14,
                 from ustat01.c:9:
/usr/include/x86_64-linux-gnu/sys/ustat.h:33:12: error: conflicting types for ?~@~Xstatfs?~@~Y
 extern int ustat (__dev_t __dev, struct ustat *__ubuf) __THROW;
            ^~~~~
In file included from ../../../../include/tst_test.h:14,
                 from ustat02.c:10:
/usr/include/x86_64-linux-gnu/sys/ustat.h:33:12: error: conflicting types for ?~@~Xstatfs?~@~Y
 extern int ustat (__dev_t __dev, struct ustat *__ubuf) __THROW;
            ^~~~~
In file included from /usr/include/x86_64-linux-gnu/sys/vfs.h:4,
                 from ../../../../include/tst_safe_macros.h:14,
                 from ../../../../include/tst_test.h:93,
                 from ustat01.c:9:
/usr/include/x86_64-linux-gnu/sys/statfs.h:31:12: note: previous declaration of ?~@~Xstatfs?~@~Y was here
 extern int statfs (const char *__file, struct statfs *__buf)
            ^~~~~~

This basically says that you have duplicate definitions of the statfs in your
system headers i.e. they are both in sys/statfs.h and sys/vfs.h.

And usually the vfs.h just includes statfs.h, so it really looks like your
system, more specifically libc headers are horribly broken.

-- 
Cyril Hrubis
chrubis@suse.cz
