From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 10 Nov 2017 04:41:19 -0500 (EST)
Subject: [LTP] [PATCH 2/6] mm: mallocstress: use safe macros wherever
 possible
In-Reply-To: <20171109003438.130802-3-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
 <20171109003438.130802-3-sspatil@google.com>
Message-ID: <1815772652.38721463.1510306879320.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> The test is currently doesn't use the test library at all and instead
> is a standlone program. While the conversion is being done, there is no
> reason why the program can't use SAFE_ macros. Make necessary changes
> to the program for the same, reducing the error check paths a lot.
> 
> Signed-off-by: Sandeep Patil <sspatil@google.com>
> ---
>  testcases/kernel/mem/mtest07/mallocstress.c | 75
>  ++++++++++++++---------------
>  1 file changed, 35 insertions(+), 40 deletions(-)
> 
> diff --git a/testcases/kernel/mem/mtest07/mallocstress.c
> b/testcases/kernel/mem/mtest07/mallocstress.c
> index 9588fb495..78d8ace8a 100644
> --- a/testcases/kernel/mem/mtest07/mallocstress.c
> +++ b/testcases/kernel/mem/mtest07/mallocstress.c
> @@ -73,6 +73,10 @@
>  #include <sys/ipc.h>
>  #include <sys/sem.h>
>  
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "tst_safe_pthread.h"

This doesn't look entirely OK, because it's mixing oldlib and newlib.
Some SAFE macros won't end up calling cleanup().

Would you care to create patch that converts it all to newlib?
Using checkpoints is of course OK and preferred.

Regards,
Jan
