From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 Sep 2018 19:53:34 +0200
Subject: [LTP] [PATCH v2 1/4] lib/tst_test.c: add 'needs_drivers' option
 with tst_check_drivers cmd
In-Reply-To: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
References: <1534764229-26993-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180906175334.GA30214@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The drivers are checked with modprobe. If modprobe is not available
> on the system, the checks are silently skipped.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> v2: * moved tst_check_driver() from tst_test.h to tst_kernel.h
>     * added the new option description to the doc and comment to tst_kernel.h
>     * iterating over the driver list moved out from tst_check_drivers(), the
>       function renamed accordingly.

>  doc/test-writing-guidelines.txt   |   10 ++++++++++
>  include/tst_kernel.h              |    8 ++++++++
>  include/tst_test.h                |    3 +++
>  lib/tst_kernel.c                  |    9 +++++++++
>  lib/tst_test.c                    |    9 +++++++++
>  testcases/lib/.gitignore          |    1 +
>  testcases/lib/Makefile            |    2 +-
>  testcases/lib/tst_check_drivers.c |   24 ++++++++++++++++++++++++
>  8 files changed, 65 insertions(+), 1 deletions(-)
>  create mode 100644 testcases/lib/tst_check_drivers.c

I'd like this whole patchset being merged before git freeze.
Do you plan it?


Kind regards,
Petr
