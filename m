From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jan 2017 14:47:23 +0100
Subject: [LTP] Building LTP despite failures
In-Reply-To: <1fa879f4-f31f-16d8-5728-44a292151d1e@synopsys.com>
References: <b375a149-eda4-7179-1e5e-99240494b321@synopsys.com>
 <20170118103758.GB29948@rei.lan>
 <1fa879f4-f31f-16d8-5728-44a292151d1e@synopsys.com>
Message-ID: <20170119134722.GB9193@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> However above still doesn't help answer my question.
> Some things are indeed provided in uClibc but just not configured by default and I
> would like to test whatever is currently present and build (make -k style) but
> that doesn't seem to be supported with current build system.

Hmm, maybe you can workaround that with ignoring the return value from
the compilation command line. You would have to write implicit pattern
rules to generic_leaf_target.inc and prepend them with hyphen.

Something like (beware untested):

diff --git a/include/mk/generic_leaf_target.inc b/include/mk/generic_leaf_target.inc
index a88586f..1e0d2a3 100644
--- a/include/mk/generic_leaf_target.inc
+++ b/include/mk/generic_leaf_target.inc
@@ -103,4 +103,10 @@ $(INSTALL_FILES): | $(INSTALL_DEPS)
 
 install: $(INSTALL_FILES)
 
+%.o : %.c
+       -$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@
+
+% : %.c
+       -$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $< $(LOADLIBES) $(LDLIBS) -o $@
+
 # vim: syntax=make

> There's another issue - we need to test various hardware configs, not all of which
> are available in silicon and only in slower FPGA targets (say 50 MHz). I would
> like to reduce the number of iterations for some of the tests (e.g. float_exp_log,
> hackbench01, fork13 ...). The easy way is to make a copy of corresponding runtest
> file but thn the issue is keeping it in sync etc. Is there a approach where we can
> optionally pass the reduced iters, based on some runtime env variable (akin to
> make flag UCLIBC for affecting build)

Most of the LTP testcases are as fast as possible, the fork13 for instance does
minimal amount of iterations that was guaranteed to trigger the bug it tests
for. So reducing it does not make much sense since it's close to disabling it
completely.

The best you can do here is to process the runtest files locally to
remove/adjust parameters for this kind of tests.

-- 
Cyril Hrubis
chrubis@suse.cz
