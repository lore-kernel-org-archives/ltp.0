From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Feb 2017 08:24:10 -0500 (EST)
Subject: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
In-Reply-To: <20170209120245.GD12673@rei.lan>
References: <1485870273-26990-1-git-send-email-chrubis@suse.cz>
 <845142934.836828.1485879246140.JavaMail.zimbra@redhat.com>
 <20170201094541.GA13898@rei.lan>
 <1372516698.1369615.1485946778720.JavaMail.zimbra@redhat.com>
 <20170202152242.GA11304@rei.lan> <20170208111055.GA16139@rei.lan>
 <20170209120245.GD12673@rei.lan>
Message-ID: <1788271290.2108729.1486646650050.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 9 February, 2017 1:02:45 PM
> Subject: Re: [LTP] [PATCH] [RFC] zram01: Fix on ppc64le
> 
> Hi!
> > There is still one unsolved problem since the TWARN messages from the
> > tst_device.c will trigger TBROK in tst_test.c since the IPC is not
> > initialized. I'm still unsure how to fix that, maybe we should allow to
> > allocate non-shared structure for the results in the special case that
> > the library code is being reused in shell helpers.
> 
> Maybe we should just add an API to redirect tst_brk() and tst_res() so
> that we could use library code in the various non-test utilities.

Or drop that TBROK?

diff --git a/lib/tst_test.c b/lib/tst_test.c
index e78b412cbd9b..52f85c7af891 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -146,10 +146,8 @@ void tst_reinit(void)
 
 static void update_results(const char *file, unsigned int lineno, int ttype)
 {
-       if (!results) {
-               tst_brk(TBROK,
-                       "%s: %d: Results IPC not initialized!", file, lineno);
-       }
+       if (!results)
+               return;
 
        switch (ttype) {
        case TCONF:

There's no way "results" can be NULL when in test:
main
 tst_run_tcases
  do_setup
   setup_ipc
    SAFE_MMAP

> Maybe
> we could patch things up so that we could use SAFE_MACROS() in cleanup
> as well...

This should be doable with some flag we set in do_test_cleanup(), to skip
further calls.

Regards,
Jan
