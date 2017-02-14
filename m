From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Feb 2017 08:18:04 -0500 (EST)
Subject: [LTP] [PATCH 2/4] lib: Redirect to tst_brk_() early
In-Reply-To: <20170214122639.442-2-chrubis@suse.cz>
References: <20170214122639.442-1-chrubis@suse.cz>
 <20170214122639.442-2-chrubis@suse.cz>
Message-ID: <1949501488.4310106.1487078284316.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Tuesday, 14 February, 2017 1:26:37 PM
> Subject: [LTP] [PATCH 2/4] lib: Redirect to tst_brk_() early
> 
> This is first patch of a patchset that would allow us to use SAFE_MACROS() in
> newlib testcases. After the patch we redirect to tst_brk_() in case of newlib
> tests directly in the test library code.
> 
> This is needed since the tst_brkm_() from the old library is marked as
> attribute ((noreturn)) and because of that the return address is not
> saved on stack and hence we cannot return from the function. Removing
> the atrribute is not an option either since that generates ~1000
> "control reaches end of non-void function" warnings.
> 
> This commit redefines tst_brkm in test.h for the test library code so that we
> branch depending on if we are running oldlib/newlib testcase and call
> corresponding tst_brk_() or tst_brkm_() function directly instead of
> branching
> in the tst_brkm_() code.
> 
> We also had to add a few returns to various places in the test library so
> that
> we exit corresponding function in a case that tst_brkm() actually returned.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

1/4 and 2/4 look good to me, and match exactly what we discussed.
Reply to 3/4 and 4/4 will follow shortly.

Build on RHEL5.6 6.0 and 7.3 passes, but I noticed couple additional warnings:

tst_test.c: In function ‘print_result’:
tst_test.c:175: warning: ‘res’ may be used uninitialized in this function

test08.c: In function ‘worker’:
test08.c:54: warning: control reaches end of non-void function

netstress.c: In function ‘server_fn’:
netstress.c:539: warning: control reaches end of non-void function

Regards,
Jan
