From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 19 Sep 2018 15:23:34 +0200
Subject: [LTP] [PATCH v3 1/2] lib/tst_test.c: add 'needs_drivers' option
 with tst_check_drivers cmd
In-Reply-To: <1536937329-13902-1-git-send-email-alexey.kodanev@oracle.com>
References: <1536937329-13902-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <20180919132334.GA31335@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> The drivers are checked with modprobe. If modprobe is not available
> on the system, the checks are silently skipped.

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

> ---
> v3: * Changed the docs according to the Cyril's comment
>     * Added curly braces in tst_check_drivers.c
>     * Added dry-run option to modprobe
I like this change as it allows to load module with parameters later.


Kind regards,
Petr
