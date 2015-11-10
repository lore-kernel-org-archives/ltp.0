From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 10 Nov 2015 15:14:26 +0100
Subject: [LTP] [RFC] Getting rid of cleanup parameter
Message-ID: <20151110141426.GG23947@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I was looking into the LTP API expecially the tst_res* part to make it
cleaner and easier to use and one of the things I would like to change
is how we execute the cleanup function.

Currenlty we pass the cleanup as function parameter. The 99% of the time
we just pass the very same function to every call with the exception of
the calls in the cleanup function itself. And the callback function is
made in a way that it could be called at any point in the setup() as
well.

The common mistakes with that API is that people pass cleanup() paramter
to functions in cleanup() and to tst api in child processes. But as we
use it now the cleanup can be set exactly once and called from the test
library which could make sure that it's called exactly once, etc.

So my proposal is to add a call to set cleanup function,
tst_set_cleanup(void (*cleanup)(void)) that would be called once in the
setup and would store the function pointer, which would later be called
either when test exits prematurely or on tst_exit(). When the cleanup
function was set with this interface the cleanup paramter for all
functions would be ignored (we may create static inline wrappers that
sets it to NULL to be used from new code).

Does everybody agree with this change?

-- 
Cyril Hrubis
chrubis@suse.cz
