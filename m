From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Feb 2017 15:56:48 +0100
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <116936368.2235095.1486651688068.JavaMail.zimbra@redhat.com>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <20170201094541.GA13898@rei.lan>
 <1372516698.1369615.1485946778720.JavaMail.zimbra@redhat.com>
 <20170202152242.GA11304@rei.lan> <20170208111055.GA16139@rei.lan>
 <20170209120245.GD12673@rei.lan>
 <1788271290.2108729.1486646650050.JavaMail.zimbra@redhat.com>
 <20170209140042.GE12673@rei.lan>
 <116936368.2235095.1486651688068.JavaMail.zimbra@redhat.com>
Message-ID: <20170209145648.GF12673@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > It's especially there for code that defines TST_NO_DEFAULT_MAIN but one
> > can argue that this is special case and if you define that macro you
> > should know what you are doing anyway...
> > 
> > But still I prefer to throw error message instead of segfaulting while
> > trying to deference NULL pointer.
> 
> I was suggesting we skip update_results(), not to let it segfault.

Sorry I was blind. That makes much more sense. Let's go with that one,
instead of the:

"[LTP] [PATCH 1/6] tst_test: Allow priting TINFO without initialized IPC"

> > > > Maybe
> > > > we could patch things up so that we could use SAFE_MACROS() in cleanup
> > > > as well...
> > > 
> > > This should be doable with some flag we set in do_test_cleanup(), to skip
> > > further calls.
> > 
> > I'm nearly finished with RFC patch. The main problem is the
> > __attribute__((noreturn)) that has been added for various tst_brk*
> > variants. So in the end it looks like only solution is to do the
> > tst_brk_() redirection in the safe_macros.c, since we cannot return from
> > tst_brkm_() since the return address is not stored on stack because it
> > has noreturn attribute. And dropping the noreturn attribute from
> > tst_brkm_() is not an option either, since that generates a ton of
> > "control reaches end of non-void function" warnings.
> 
> Vast majority is from single header file:
> 
> $ grep "reaches end of non-void" log.txt | sort | uniq | wc -l
> 328
> 
> $ grep "reaches end of non-void" log.txt | sort | uniq | grep compat_16.h | wc -l
> 289

That is still 39 occurences to fix all over the place plus the
compat_16.h header. Have a look at the patch I've just send, I think
that it's a bit easier than patching all the tests to avoids warnings...

-- 
Cyril Hrubis
chrubis@suse.cz
