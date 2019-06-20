From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Jun 2019 15:24:36 +0200
Subject: [LTP] [PATCH v5 0/4] syscalls/fanotify: FAN_REPORT_FID and
 Directory Modification Events
In-Reply-To: <cover.1561018312.git.mbobrowski@mbobrowski.org>
References: <cover.1561018312.git.mbobrowski@mbobrowski.org>
Message-ID: <20190620132436.GA9804@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir, Matthew,

LGTM. Just one of this commits fails on centos 6

https://api.travis-ci.org/v3/job/548162141/log.txt
https://travis-ci.org/pevik/ltp/jobs/548162141

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/usr/src/ltp/include -I/usr/src/ltp/../ltp-build/include -I/usr/src/ltp/include/old/   -L/usr/src/ltp/../ltp-build/lib  /usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify01.c   -lltp -o fanotify01
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/usr/src/ltp/include -I/usr/src/ltp/../ltp-build/include -I/usr/src/ltp/include/old/   -L/usr/src/ltp/../ltp-build/lib  /usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify02.c   -lltp -o fanotify02
In file included from /usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify01.c:21:
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:130: error: expected specifier-qualifier-list before '__kernel_fsid_t'
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:141: error: expected declaration specifiers or '...' before '__kernel_fsid_t'
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:142: warning: 'struct file_handle' declared inside parameter list
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:142: warning: its scope is only this definition or declaration, which is probably not what you want
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h: In function 'fanotify_get_fid':
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:150: error: 'fsid' undeclared (first use in this function)
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:150: error: (Each undeclared identifier is reported only once
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:150: error: for each function it appears in.)
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:144: warning: unused variable 'mount_id'
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:142: warning: unused parameter 'handle'
In file included from /usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify02.c:21:
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:130: error: expected specifier-qualifier-list before '__kernel_fsid_t'
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:141: error: expected declaration specifiers or '...' before '__kernel_fsid_t'
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:142: warning: 'struct file_handle' declared inside parameter list
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:142: warning: its scope is only this definition or declaration, which is probably not what you want
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h: In function 'fanotify_get_fid':
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:150: error: 'fsid' undeclared (first use in this function)
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:150: error: (Each undeclared identifier is reported only once
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:150: error: for each function it appears in.)
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:144: warning: unused variable 'mount_id'
/usr/src/ltp/testcases/kernel/syscalls/fanotify/fanotify.h:142: warning: unused parameter 'handle'

Kind regards,
Petr

> This patch series contains the changes needed to validate the new
> FAN_REPORT_FID flag and directory modification event functionality
> within the fanotify API.

> Changes since version 4:
> 	* Fixed problems with unbalanced file descriptor close.
> 	* Reorded functions in the test files fanotify13, fanotify14 and
> 	  fanotify15 so that they all follow a basic template i.e.

> 	  test()
> 	  ...
> 	  do_setup()
> 	  do_cleanup()

> Thank you Amir for your feedback. 

> Amir Goldstein (1):
>   syscalls/fanotify13: add test coverage for fsid cache bug

> Matthew Bobrowski (3):
>   syscalls/fanotify13: new test to verify FAN_REPORT_FID functionality
>   syscalls/fanotify14: new test to validate FAN_REPORT_FID interface
>     return values
>   syscalls/fanotify15: verify fid for dirent events

>  configure.ac                                    |   1 +
>  runtest/syscalls                                |   3 +
>  testcases/kernel/syscalls/fanotify/.gitignore   |   3 +
>  testcases/kernel/syscalls/fanotify/fanotify.h   |  81 +++++-
>  testcases/kernel/syscalls/fanotify/fanotify05.c |   1 +
>  testcases/kernel/syscalls/fanotify/fanotify13.c | 328 ++++++++++++++++++++++++
>  testcases/kernel/syscalls/fanotify/fanotify14.c | 176 +++++++++++++
>  testcases/kernel/syscalls/fanotify/fanotify15.c | 246 ++++++++++++++++++
>  8 files changed, 836 insertions(+), 3 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify13.c
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify14.c
>  create mode 100644 testcases/kernel/syscalls/fanotify/fanotify15.c
