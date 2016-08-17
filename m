From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Aug 2016 11:39:46 +0800
Subject: [LTP] [PATCH] mkswap: make the test device size is aligned to
 pagesize
In-Reply-To: <20160816121552.GC25092@rei.lan>
References: <1469613519-27167-1-git-send-email-liwang@redhat.com>
 <20160809164118.GA27028@rei.lan> <20160815092508.GB22440@gmail.com>
 <20160815123959.GD20680@rei.lan> <20160816032416.GA28657@gmail.com>
 <20160816121552.GC25092@rei.lan>
Message-ID: <20160817033946.GA6430@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 16, 2016 at 02:15:52PM +0200, Cyril Hrubis wrote:
> Hi!
> > Sorry for the vague description. To be honest, mkswap.c(util-linux) is innocent
> > here. The error maker is mkswap_verify() in mkswap01.sh(ltp) testcase.
> > 
> > The key point of problem is not only mkswap01.sh (ltp) doesn't guarantee
> > test-device(LTP_DEV) size is aligned to PAGE_SIZE on all arches, but also
> > it increse/decrease test-device size not aligned too.
> > 
> > # tail -15 mkswap01.sh
> > mkswap_test "" "" "$TST_DEVICE"
> > mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"     <---
> > mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"   <---
> > ...
> > 
> > 
> > As we know that mkswap.c(util-linux) format test-device to aligned with its local
> > PAGE_SIZE by force. Therefore, the real 'filesize' of formated test-device will
> > be decreased in that phase. But final, the testcase just compare orignal 'filesize'
> > to 'diff'(swaptotal-after - swaptotal-before) and make conclusion to get PASS/FAIL.
> > That makes this test result is not reliable.
> 
> Now that makes sense.
> 
> But if that is the case we still have to align down the device size to
> the page size at the start of the test. Since the device can also be
> passed down to the runltp script as a parameter and we cannot make any
> assumptions about its size.

Hmm, yes, we have to face the problem.

A simple idea comes to my mind is that the loop device size should be
customized by specific testcase(mkswap01.sh).

That would be happy if function "tst_acquire_device() 'NUM'" can get
'NUM' MB block device for testing.

It means we have to modify another path which about tst_acquire_device().

What do you think? any proposals?

-----------
tst_acquire_device()
{
	local acq_dev_size=${1}

	if [ -z ${TST_TMPDIR} ]; then
		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
	fi

	if [ -n "${LTP_DEV}" ] && [ ! ${acq_dev_size} ]; then
		tst_resm TINFO "Using test device
		LTP_DEV='${LTP_DEV}'"
		if [ ! -b ${LTP_DEV} ]; then
			tst_brkm TBROK "${LTP_DEV} is not a block device"
		fi

		ROD_SILENT dd if=/dev/zero of="${LTP_DEV}" bs=1024 count=512 TST_DEVICE=${LTP_DEV}
		TST_DEVICE_FLAG=0
		return
	fi

	if [ ! ${acq_dev_size} ]; then
		ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
	else
		ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$((1024*$acq_dev_size))
	fi

	TST_DEVICE=$(losetup -f)
	if [ $? -ne 0 ]; then
		tst_brkm TBROK "Couldn't find free loop device"
	fi

	tst_resm TINFO "Found free device '${TST_DEVICE}'"

	ROD_SILENT losetup ${TST_DEVICE} test_dev.img

	TST_DEVICE_FLAG=1
}


Regards,
Li Wang
