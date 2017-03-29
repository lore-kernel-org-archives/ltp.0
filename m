From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Mar 2017 04:42:43 -0400 (EDT)
Subject: [LTP] [PATCH v5 5/6] syscalls: added memfd_create dir and
 memfd_create/memfd_create01.c
In-Reply-To: <20170324152658.GB9961@rei.lan>
References: <1490292957-26941-1-git-send-email-jracek@redhat.com>
 <1490292957-26941-6-git-send-email-jracek@redhat.com>
 <20170324152658.GB9961@rei.lan>
Message-ID: <150812828.16512609.1490776963745.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> Patchset pushed with cosmetic chnages to this patch (see diff below),
> thanks.

Hi,

build on distro that doesn't define HAVE_FALLOCATE is now failing
for me:

# git describe
20170116-207-g16f4d56

# ./configure && make
...
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/root/ltp/testcases/kernel/include -I../../../../include -I../../../../include -I../../../../include/old/  -c -o memfd_create01.o memfd_create01.c
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/root/ltp/testcases/kernel/include -I../../../../include -I../../../../include -I../../../../include/old/  -c -o memfd_create_common.o memfd_create_common.c
In file included from memfd_create_common.c:21:
../../../../include/lapi/fallocate.h: In function ‘fallocate’:
../../../../include/lapi/fallocate.h:55: warning: implicit declaration of function ‘syscall’
../../../../include/lapi/fallocate.h:55: warning: implicit declaration of function ‘tst_brkm’
../../../../include/lapi/fallocate.h:55: error: ‘TCONF’ undeclared (first use in this function)
../../../../include/lapi/fallocate.h:55: error: (Each undeclared identifier is reported only once
../../../../include/lapi/fallocate.h:55: error: for each function it appears in.)
In file included from memfd_create_common.c:28:
/usr/include/unistd.h: At top level:
/usr/include/unistd.h:1011: error: conflicting types for ‘syscall’
../../../../include/lapi/fallocate.h:55: error: previous implicit declaration of ‘syscall’ was here
make[4]: *** [memfd_create_common.o] Error 1
make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/memfd_create'
make[3]: *** [all] Error 2
make[3]: Leaving directory `/root/ltp/testcases/kernel/syscalls'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/root/ltp/testcases/kernel'
make[1]: *** [all] Error 2
make[1]: Leaving directory `/root/ltp/testcases'
make: *** [testcases-all] Error 2

Regards,
Jan
