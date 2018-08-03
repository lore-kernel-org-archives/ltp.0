From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Aug 2018 14:55:36 +0200
Subject: [LTP] [RFC PATCH] Testcase for statx syscall with
 AT_NO_AUTOMOUNT flag
In-Reply-To: <20180802133418.4789-1-sikkandarsulaiman@zilogic.com>
References: <20180802133418.4789-1-sikkandarsulaiman@zilogic.com>
Message-ID: <20180803125536.GB32272@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Added statx01.c testfile. Functionality of the file is provided in its description.

This conflicts with the initial batch of the statx testcases, this patch
should be based on LTP tree with that patch applied.

> Required inputs:
> 1. Is there any 'ltp' recommended way to create and use automount points from c program?

Just use the automount kernel API it's not really complicated one.

I looked into it and created example code, see the attached C source.

> 2. Is it recommended to invoke systemctl services from c program by system() call?

No as LTP runs also on systems without systemd it should not depend on
systemctl being installed on the system at all.

> Requesting suggestions for alternate methods if any
> non-recommended practices are available in the code.
> 
> Signed-off-by: Sikkandar Sulaiman A <sikkandarsulaiman@zilogic.com>
> Signed-off-by: Tarun TU <tarun@zilogic.com>
> Signed-off-by: Vaishnavi D <vaishnavi.d@zilogic.com>
> ---
>  confefYmE5/defines.awk                     |  144 +
>  confefYmE5/subs.awk                        |  160 +
>  confefYmE5/subs1.awk                       |  160 +
>  include/lapi/fs.h                          |   47 +
>  include/lapi/sys_statx.h                   |  264 +
>  include/lapi/syscalls/arm.in               |    1 +
>  include/lapi/syscalls/i386.in              |    1 +
>  include/lapi/syscalls/powerpc.in           |    1 +
>  include/lapi/syscalls/powerpc64.in         |    1 +
>  include/lapi/syscalls/s390.in              |    1 +
>  include/lapi/syscalls/sparc.in             |    1 +
>  include/lapi/syscalls/sparc64.in           |    1 +
>  include/lapi/syscalls/x86_64.in            |    1 +
>  m4/ltp-statx.m4                            |   25 +
>  runtest/syscalls                           |    9 +
>  testcases/kernel/syscalls/statx/.gitignore |    2 +
>  testcases/kernel/syscalls/statx/Makefile   |   26 +
>  testcases/kernel/syscalls/statx/statx01.c  |  245 +
>  utils/ffsb-6.0-rc2/config.h.in             |   49 +-
>  utils/ffsb-6.0-rc2/configure               | 5949 +++++++++-----------

There is a couple of files added here by a mistake, the conf*/ files and
the utils/*.

-- 
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: automount.c
Type: text/x-c
Size: 1499 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180803/6c2e3475/attachment.bin>
