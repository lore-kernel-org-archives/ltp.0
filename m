From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Aug 2016 11:24:16 +0800
Subject: [LTP] [PATCH] mkswap: make the test device size is aligned to
 pagesize
In-Reply-To: <20160815123959.GD20680@rei.lan>
References: <1469613519-27167-1-git-send-email-liwang@redhat.com>
 <20160809164118.GA27028@rei.lan> <20160815092508.GB22440@gmail.com>
 <20160815123959.GD20680@rei.lan>
Message-ID: <20160816032416.GA28657@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Aug 15, 2016 at 02:39:59PM +0200, Cyril Hrubis wrote:
> Hi!
> > My version is:
> > 
> > # rpm -qf /sbin/mkswap 
> > util-linux-2.23.2-33.el7.ppc64
> > 
> > 
> > if (block_count) {
> > 	/* this silly user specified the number of blocks explicitly */
> > 		uint64_t blks = strtou64_or_err(block_count,
> > 					_("invalid block count argument"));
> > 		PAGES = blks / (pagesize / 1024);
> > 	}
> > 	sz = get_size(device_name);
> 
> There is no check here as well. The strtou64_or_err() just converts
> string to number, that's all it does. Then we do integer division, no
> checks at all.
> 
> > > Looking into util-linux-2.26.2 all it does with user specified number of
> > > blocks is:
> > > 
> > > ctl.npages = blks / (ctl.pagesize / 1024);
> > > 
> > > There is no check that blks is divideable by pagesize/1024.
> > 
> > I build util-linux-2.28 from upstrem source and also get the errors.
> > 
> > # mkswap -V
> > mkswap from util-linux 2.28.237-47bd89
> > 
> > # ./runltp -f commands
> > mkswap01 1 TINFO : Using test device LTP_DEV='/dev/loop0'
> > mkswap01 1 TFAIL : 'mkswap   /dev/loop0 ' failed, not expected.
> > mkswap01 2 TFAIL : 'mkswap   /dev/loop0 90000' failed, not expected.
> > mkswap01 3 TINFO : Can not do swapon on /dev/loop0.
> > mkswap01 3 TINFO : Device size specified by 'mkswap' greater than real size.
> > mkswap01 3 TINFO : Swapon failed expectedly.
> > mkswap01 3 TPASS : 'mkswap -f  /dev/loop0 110000' passed.
> 
> Hmm, what is the exact error message from mkfs here?
> 
> I guess that it would be a good idea to cat the temp file if mkswap
> failed unexpectedly so that we can see the mkswap error message.

Sorry for the vague description. To be honest, mkswap.c(util-linux) is innocent
here. The error maker is mkswap_verify() in mkswap01.sh(ltp) testcase.

The key point of problem is not only mkswap01.sh (ltp) doesn't guarantee
test-device(LTP_DEV) size is aligned to PAGE_SIZE on all arches, but also
it increse/decrease test-device size not aligned too.

# tail -15 mkswap01.sh
mkswap_test "" "" "$TST_DEVICE"
mkswap_test "" "" "$TST_DEVICE" "$((DEVICE_SIZE-10000))"     <---
mkswap_test "-f" "" "$TST_DEVICE" "$((DEVICE_SIZE+10000))"   <---
...


As we know that mkswap.c(util-linux) format test-device to aligned with its local
PAGE_SIZE by force. Therefore, the real 'filesize' of formated test-device will
be decreased in that phase. But final, the testcase just compare orignal 'filesize'
to 'diff'(swaptotal-after - swaptotal-before) and make conclusion to get PASS/FAIL.
That makes this test result is not reliable.

I temporally add some debug sentences in testcase to show the prblem:

mkswap01 1 TINFO : Using test device LTP_DEV='/dev/loop1'
mkswap01 1 TINFO : DEVICE_SIZE = 100000                  <--- should always give an aligned size here 
mkswap01 1 TINFO : ********DEBUG MSG: swapsize = 100000
mkswap01 1 TINFO : ********DEBUG MSG: diff = 99904
mkswap01 1 TINFO : ********DEBUG MSG: filesize = 99936
mkswap01 1 TFAIL : 'mkswap   /dev/loop1 ' failed, not expected.
mkswap01 2 TINFO : ********DEBUG MSG: swapsize = 90000   <--- here as well
mkswap01 2 TINFO : ********DEBUG MSG: diff = 89920
mkswap01 2 TINFO : ********DEBUG MSG: filesize = 89936
mkswap01 2 TFAIL : 'mkswap   /dev/loop1 90000' failed, not expected.
mkswap01 3 TINFO : ********DEBUG MSG: swapsize = 110000
mkswap01 3 TINFO : Can not do swapon on /dev/loop1.
mkswap01 3 TINFO : Device size specified by 'mkswap' greater than real size.
mkswap01 3 TINFO : Swapon failed expectedly.
mkswap01 3 TPASS : 'mkswap -f  /dev/loop1 110000' passed.


After fixing abvoe issues, we get test PASS correctly:

mkswap01 1 TINFO : Using test device LTP_DEV='/dev/loop1'
mkswap01 1 TINFO : DEVICE_SIZE = 102400
mkswap01 1 TINFO : ********DEBUG MSG: swapsize = 102400
mkswap01 1 TINFO : ********DEBUG MSG: diff = 102336
mkswap01 1 TINFO : ********DEBUG MSG: filesize = 102336
mkswap01 1 TPASS : 'mkswap   /dev/loop1 ' passed.
mkswap01 2 TINFO : ********DEBUG MSG: swapsize = 102336
mkswap01 2 TINFO : ********DEBUG MSG: diff = 102272
mkswap01 2 TINFO : ********DEBUG MSG: filesize = 102272
mkswap01 2 TPASS : 'mkswap   /dev/loop1 102336' passed.
mkswap01 3 TINFO : ********DEBUG MSG: swapsize = 102464
mkswap01 3 TINFO : Can not do swapon on /dev/loop1.
mkswap01 3 TINFO : Device size specified by 'mkswap' greater than real size.
mkswap01 3 TINFO : Swapon failed expectedly.
mkswap01 3 TPASS : 'mkswap -f  /dev/loop1 102464' passed.

> > Additionally, we'd better change the bs=1kB to bs=1024 in runltp file,
> > since it will get page aligned block device for all arches.
> > 
> > The original LTP_DEV size is 102400000 bytes:
> > 
> > # grep 'bs=' runltp  -n
> > 981:    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=102400
> > 
> > 
> > From dd manual:
> > N and BYTES may be followed by the following multiplicative suffixes:
> > c =1, w =2, b =512, kB  =1000,  K  =1024,  MB =1000*1000,  M  =1024*1024,
> > xM  =M  GB  =1000*1000*1000,  G =1024*1024*1024, and so on for T, P, E, Z, Y.
> 
> Or change it to uppercase KB. Sounds good, feel free to send a patch.

Ok, thanks for reviewing.

Regards,
Li Wang
