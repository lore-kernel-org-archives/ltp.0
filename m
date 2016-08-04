From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 4 Aug 2016 18:13:23 +0200
Subject: [LTP] [PATCH V3 2/6] tst_test: make reap_children() part of the
 test API
In-Reply-To: <1470320195-22145-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1470320195-22145-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470320195-22145-2-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160804161323.GC3367@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +void tst_reap_children(void);
> +-------------------------------------------------------------------------------
> +
> +The 'tst_reap_children()' function makes the process wait for all of its
> +children and exits with 'tst_brk(TBROK, ...)' if any of them returned
> +a non zero exit code. This function may be called only from the main
> +test process.

There is no reason to limit the function to the main test process only.
All it does it to reap all children and call tst_brk() in case that
someting went wrong.

We can for instance do:

[main test pid]
      fork()              --> [child]
      tst_reap_children()     fork()              -->[child]
                              tst_reap_children()    tst_brk(TBROK, ...)

In this case the second level child will simply call exit(TBROK), the
first level child will wait it and call exit(TBROK) because the second
level child exitted uncleanly. And finally the main test pid will exit
with TBROK, after a it's cleanup is called (if set).

And it's nearly the same in case of tst_brk(TCONF, ...) but the exit
value will be 0 and the TCONF is instead stored in the result structure
in the shared memory.

Maybe we should include this ascii art diagram in the documentation as
well.


The rest of the patchset is good, acked.

Let's commit it without the sentence that limits this function to the
main test process. I will do something about the documentation later.

-- 
Cyril Hrubis
chrubis@suse.cz
