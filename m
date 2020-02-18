From: Zorro Lang <zlang@redhat.com>
Date: Tue, 18 Feb 2020 14:19:06 +0800
Subject: [LTP] [PATCH 0/7] Add new LTP tests related to fsmount family
 of syscalls
In-Reply-To: <cover.1581680021.git.viresh.kumar@linaro.org>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
Message-ID: <20200218061906.GB14282@dhcp-12-102.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Feb 14, 2020 at 05:05:49PM +0530, Viresh Kumar wrote:
> Hello,
> 
> This series adds a bunch of LTP tests related to fsmount family of
> syscalls.

Hi Viresh,

Thanks for all these cases, that's really helpful.

Although you write cases for each new mount API, each xxxxx01.c case looks
nearly do same things.

That's why I only wrote one case for new-mount currently, due to basic mount
test already can through most of new APIs(except open_tree and fspick). I don't
know if we should write nearly same things in different directories.
Actually I prepared open_tree and fspick test cases(planned to name as newmount02
and newmount03. but the newmount01 has been changed to fsmount01 :), but didn't
sent out, due to I hope to the first case(which does basic changes) can be merged
at first.

All of your xxxxx02.c cases are great! I planned to test more different
parameters of fsconfig() later too. Your invalid parameters test are nice.
As you've sent these cases, I think these should be reviewed at first, avoid
we do same things:) I'll try to help to review V2 patchset too, if I can:-P

Thanks,
Zorro

> 
> Thanks
> 
> --
> viresh
> 
> Viresh Kumar (7):
>   lapi/fsmount: Add definitions for fsmount related syscalls
>   syscalls/fsopen: New tests
>   syscalls/fsconfig: New tests
>   syscalls/fsmount: New tests
>   syscalls/move_mount: New tests
>   syscalls/fspick: New tests
>   syscalls/open_tree: New tests
> 
>  configure.ac                                  |   6 +
>  include/lapi/fsmount.h                        | 134 ++++++++++++++++++
>  runtest/syscalls                              |  18 +++
>  testcases/kernel/syscalls/fsconfig/.gitignore |   2 +
>  testcases/kernel/syscalls/fsconfig/Makefile   |   6 +
>  .../kernel/syscalls/fsconfig/fsconfig01.c     |  77 ++++++++++
>  .../kernel/syscalls/fsconfig/fsconfig02.c     |  97 +++++++++++++
>  testcases/kernel/syscalls/fsmount/.gitignore  |   2 +
>  testcases/kernel/syscalls/fsmount/Makefile    |   6 +
>  testcases/kernel/syscalls/fsmount/fsmount01.c |  71 ++++++++++
>  testcases/kernel/syscalls/fsmount/fsmount02.c |  83 +++++++++++
>  testcases/kernel/syscalls/fsopen/.gitignore   |   2 +
>  testcases/kernel/syscalls/fsopen/Makefile     |   6 +
>  testcases/kernel/syscalls/fsopen/fsopen01.c   |  71 ++++++++++
>  testcases/kernel/syscalls/fsopen/fsopen02.c   |  56 ++++++++
>  testcases/kernel/syscalls/fspick/.gitignore   |   2 +
>  testcases/kernel/syscalls/fspick/Makefile     |   6 +
>  testcases/kernel/syscalls/fspick/fspick01.c   | 104 ++++++++++++++
>  testcases/kernel/syscalls/fspick/fspick02.c   | 110 ++++++++++++++
>  .../kernel/syscalls/move_mount/.gitignore     |   2 +
>  testcases/kernel/syscalls/move_mount/Makefile |   6 +
>  .../kernel/syscalls/move_mount/move_mount01.c |  82 +++++++++++
>  .../kernel/syscalls/move_mount/move_mount02.c | 102 +++++++++++++
>  .../kernel/syscalls/open_tree/.gitignore      |   2 +
>  testcases/kernel/syscalls/open_tree/Makefile  |   6 +
>  .../kernel/syscalls/open_tree/open_tree01.c   | 115 +++++++++++++++
>  .../kernel/syscalls/open_tree/open_tree02.c   | 110 ++++++++++++++
>  27 files changed, 1284 insertions(+)
>  create mode 100644 include/lapi/fsmount.h
>  create mode 100644 testcases/kernel/syscalls/fsconfig/.gitignore
>  create mode 100644 testcases/kernel/syscalls/fsconfig/Makefile
>  create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig01.c
>  create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig02.c
>  create mode 100644 testcases/kernel/syscalls/fsmount/.gitignore
>  create mode 100644 testcases/kernel/syscalls/fsmount/Makefile
>  create mode 100644 testcases/kernel/syscalls/fsmount/fsmount01.c
>  create mode 100644 testcases/kernel/syscalls/fsmount/fsmount02.c
>  create mode 100644 testcases/kernel/syscalls/fsopen/.gitignore
>  create mode 100644 testcases/kernel/syscalls/fsopen/Makefile
>  create mode 100644 testcases/kernel/syscalls/fsopen/fsopen01.c
>  create mode 100644 testcases/kernel/syscalls/fsopen/fsopen02.c
>  create mode 100644 testcases/kernel/syscalls/fspick/.gitignore
>  create mode 100644 testcases/kernel/syscalls/fspick/Makefile
>  create mode 100644 testcases/kernel/syscalls/fspick/fspick01.c
>  create mode 100644 testcases/kernel/syscalls/fspick/fspick02.c
>  create mode 100644 testcases/kernel/syscalls/move_mount/.gitignore
>  create mode 100644 testcases/kernel/syscalls/move_mount/Makefile
>  create mode 100644 testcases/kernel/syscalls/move_mount/move_mount01.c
>  create mode 100644 testcases/kernel/syscalls/move_mount/move_mount02.c
>  create mode 100644 testcases/kernel/syscalls/open_tree/.gitignore
>  create mode 100644 testcases/kernel/syscalls/open_tree/Makefile
>  create mode 100644 testcases/kernel/syscalls/open_tree/open_tree01.c
>  create mode 100644 testcases/kernel/syscalls/open_tree/open_tree02.c
> 
> -- 
> 2.21.0.rc0.269.g1a574e7a288b
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

