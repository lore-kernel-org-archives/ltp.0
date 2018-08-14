From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Aug 2018 19:06:27 +0200
Subject: [LTP] [PATCH RFC 1/4] lib/tst_test.c: add 'needs_drivers'
 option with tst_check_drivers cmd
In-Reply-To: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180814170627.GA30905@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The drivers are checked with modprobe. If modrpobe is not available
                                            ^ typo modrpobe
> on the system, the checks are silently skipped.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Acked-by: Petr Vorel <pvorel@suse.cz>

> ---
>  include/tst_test.h                |    5 +++++
>  lib/tst_test.c                    |   26 ++++++++++++++++++++++++++
>  testcases/lib/.gitignore          |    1 +
>  testcases/lib/Makefile            |    2 +-
>  testcases/lib/tst_check_drivers.c |   24 ++++++++++++++++++++++++
>  5 files changed, 57 insertions(+), 1 deletions(-)
>  create mode 100644 testcases/lib/tst_check_drivers.c

It'd be nice to add some docs into doc/test-writing-guidelines.txt.


Kind regards,
Petr
