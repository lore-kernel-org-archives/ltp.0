From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 14 Feb 2017 14:22:44 +0100
Subject: [LTP] [PATCH 2/4] lib: Redirect to tst_brk_() early
In-Reply-To: <1949501488.4310106.1487078284316.JavaMail.zimbra@redhat.com>
References: <20170214122639.442-1-chrubis@suse.cz>
 <20170214122639.442-2-chrubis@suse.cz>
 <1949501488.4310106.1487078284316.JavaMail.zimbra@redhat.com>
Message-ID: <20170214132244.GB27516@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We also had to add a few returns to various places in the test library so
> > that
> > we exit corresponding function in a case that tst_brkm() actually returned.
> > 
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> 
> 1/4 and 2/4 look good to me, and match exactly what we discussed.
> Reply to 3/4 and 4/4 will follow shortly.
> 
> Build on RHEL5.6 6.0 and 7.3 passes, but I noticed couple additional warnings:
> 
> tst_test.c: In function ???print_result???:
> tst_test.c:175: warning: ???res??? may be used uninitialized in this function

What about adding an abort() after the tst_brk() in the switch?

> test08.c: In function ???worker???:
> test08.c:54: warning: control reaches end of non-void function

That should be fixed easily with return NULL; at the end of the
function.

> netstress.c: In function ???server_fn???:
> netstress.c:539: warning: control reaches end of non-void function

Dummy return NULL should fix this one as well.



These fixes should be part of 3/4 that removes the attribute noreturn
from the tst_brk_().

-- 
Cyril Hrubis
chrubis@suse.cz
