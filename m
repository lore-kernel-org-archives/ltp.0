From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Feb 2017 15:00:42 +0100
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <1788271290.2108729.1486646650050.JavaMail.zimbra@redhat.com>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <845142934.836828.1485879246140.JavaMail.zimbra@redhat.com>
 <20170201094541.GA13898@rei.lan>
 <1372516698.1369615.1485946778720.JavaMail.zimbra@redhat.com>
 <20170202152242.GA11304@rei.lan> <20170208111055.GA16139@rei.lan>
 <20170209120245.GD12673@rei.lan>
 <1788271290.2108729.1486646650050.JavaMail.zimbra@redhat.com>
Message-ID: <20170209140042.GE12673@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > There is still one unsolved problem since the TWARN messages from the
> > > tst_device.c will trigger TBROK in tst_test.c since the IPC is not
> > > initialized. I'm still unsure how to fix that, maybe we should allow to
> > > allocate non-shared structure for the results in the special case that
> > > the library code is being reused in shell helpers.
> > 
> > Maybe we should just add an API to redirect tst_brk() and tst_res() so
> > that we could use library code in the various non-test utilities.
> 
> Or drop that TBROK?

It's especially there for code that defines TST_NO_DEFAULT_MAIN but one
can argue that this is special case and if you define that macro you
should know what you are doing anyway...

But still I prefer to throw error message instead of segfaulting while
trying to deference NULL pointer.

> > Maybe
> > we could patch things up so that we could use SAFE_MACROS() in cleanup
> > as well...
> 
> This should be doable with some flag we set in do_test_cleanup(), to skip
> further calls.

I'm nearly finished with RFC patch. The main problem is the
__attribute__((noreturn)) that has been added for various tst_brk*
variants. So in the end it looks like only solution is to do the
tst_brk_() redirection in the safe_macros.c, since we cannot return from
tst_brkm_() since the return address is not stored on stack because it
has noreturn attribute. And dropping the noreturn attribute from
tst_brkm_() is not an option either, since that generates a ton of
"control reaches end of non-void function" warnings.

But it's quite easy to define a macro or two that does the same
redirection as we do in tst_brkm_() so that we never reach the oldlib
code from safe_macros.c if newlib test is running.

-- 
Cyril Hrubis
chrubis@suse.cz
