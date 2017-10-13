From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Oct 2017 09:25:12 +0200
Subject: [LTP] [PATCH v2 0/4] ltp: add tests for some recently-fixed
 keyrings bugs
In-Reply-To: <20171012204227.116510-1-ebiggers3@gmail.com>
References: <20171012204227.116510-1-ebiggers3@gmail.com>
Message-ID: <20171013072512.wtblpsavplae4vuk@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Eric Biggers (4):
>   lapi/keyctl.h: add a few missing definitions
>   syscalls/keyctl06: new test for keyring_read() buffer overrun
>   syscalls/keyctl07: new test for oops when reading negative key
>   syscalls/add_key03: new test for forging user keyrings

>  include/lapi/keyctl.h                         | 20 ++++++
>  runtest/cve                                   |  1 +
>  runtest/syscalls                              |  3 +
>  testcases/kernel/syscalls/.gitignore          |  3 +
>  testcases/kernel/syscalls/add_key/add_key03.c | 98 +++++++++++++++++++++++++++
>  testcases/kernel/syscalls/keyctl/keyctl06.c   | 68 +++++++++++++++++++
>  testcases/kernel/syscalls/keyctl/keyctl07.c   | 89 ++++++++++++++++++++++++
...
This is going to create conflict with my patch-set v3 "Fix 32-bit cross compilation".
If you accept this first, I can rebase my patch-set for you.
BTW my patch-set is in github, if it's easier for you.
https://github.com/pevik/ltp/tree/autotools/fix-32bit-build.v3


Kind regards,
Petr
