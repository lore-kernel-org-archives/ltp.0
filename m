From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Thu, 24 Jan 2019 15:26:07 -0200
Subject: [LTP] vma05.sh issues
Message-ID: <BF5EE541-6259-45D4-9555-78BFCE044606@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

We are getting false positives with vma05.sh tests:

Bug: https://bugs.linaro.org/show_bug.cgi?id=4256#c2

Original commit for vma05 test, has stated that:

"
Second part of the test checks regression of vdso permissions bug
(fixed with b6558c4a2378 ("fix [vdso] page permissions") and
e5b97dde514f ("add VM_ALWAYSDUMP")). As a consequence of this bug, vdso
pages were not included in core dumps which caused incomplete
backtraces:

    Program terminated with signal 11, Segmentation fault.
    #0  0x005f0402 in ?? ()

    Thread 1 (process 14859):
    #0  0x005f0402 in ?? ()
    #1  0x00336366 in ?? () from /lib/i686/nosegneg/libc.so.6
    #2  0x0804845f in handle_alrm (signo=14) at small.c:9
    #3  0x005f0420 in ?? ()
    #4  0x0000000e in ?? ()
    #5  0x00000033 in ?? ()
    #6  0x00000000 in ?? ()
"

But the existing test seems to have a small issue...


	rm -rf core*
	{ vma05_vdso; } > /dev/null 2>&1
	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
		vma05_vdso ./core* 2> /dev/null)
	if echo "$TRACE" | grep -qF "??"; then
		tst_res TFAIL "[vdso] bug not patched"
	else
		tst_res TPASS "[vdso] backtrace complete"
	fi

It simply checks if there was ANY incomplete backtrace for a given
generated main() { } core dump. Since there is no linked shared library,
or function called, it assumes there will be no symbols to be solved and
any incomplete symbol will be related to the missing vDSO missing page.

This doesn’t seem accurate to me :\. There are no vDSO symbols in the
stack frames I’m getting from vma05_vdso.c. 

Besides,

Unfortunately, a stripped vma05_vdso binary will also cause incomplete
backtraces, causing a false positive for this test, and it would be
impossible to know if it was due to a missing vDSO page or not.

Thoughts ?

Cheers o/

--
Rafael D. Tinoco
Linaro Kernel Validation

