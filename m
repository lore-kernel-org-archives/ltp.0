From: Li Wang <liwang@redhat.com>
Date: Mon, 15 Aug 2016 17:25:08 +0800
Subject: [LTP] [PATCH] mkswap: make the test device size is aligned to
 pagesize
In-Reply-To: <20160809164118.GA27028@rei.lan>
References: <1469613519-27167-1-git-send-email-liwang@redhat.com>
 <20160809164118.GA27028@rei.lan>
Message-ID: <20160815092508.GB22440@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 09, 2016 at 06:41:18PM +0200, Cyril Hrubis wrote:
> Hi!
> > We get failures like below because of 'DEVICE_SIZE-10000' makes the
> > loop device size is not aligned to system PAGE_SIZE any more.
> 
> What version of mkswap.c you have?

My version is:

# rpm -qf /sbin/mkswap 
util-linux-2.23.2-33.el7.ppc64


if (block_count) {
	/* this silly user specified the number of blocks explicitly */
		uint64_t blks = strtou64_or_err(block_count,
					_("invalid block count argument"));
		PAGES = blks / (pagesize / 1024);
	}
	sz = get_size(device_name);


> 
> Looking into util-linux-2.26.2 all it does with user specified number of
> blocks is:
> 
> ctl.npages = blks / (ctl.pagesize / 1024);
> 
> There is no check that blks is divideable by pagesize/1024.

I build util-linux-2.28 from upstrem source and also get the errors.

# mkswap -V
mkswap from util-linux 2.28.237-47bd89

# ./runltp -f commands
mkswap01 1 TINFO : Using test device LTP_DEV='/dev/loop0'
mkswap01 1 TFAIL : 'mkswap   /dev/loop0 ' failed, not expected.
mkswap01 2 TFAIL : 'mkswap   /dev/loop0 90000' failed, not expected.
mkswap01 3 TINFO : Can not do swapon on /dev/loop0.
mkswap01 3 TINFO : Device size specified by 'mkswap' greater than real size.
mkswap01 3 TINFO : Swapon failed expectedly.
mkswap01 3 TPASS : 'mkswap -f  /dev/loop0 110000' passed.

-----------------

Additionally, we'd better change the bs=1kB to bs=1024 in runltp file,
since it will get page aligned block device for all arches.

The original LTP_DEV size is 102400000 bytes:

# grep 'bs=' runltp  -n
981:    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=102400


From dd manual:
N and BYTES may be followed by the following multiplicative suffixes:
c =1, w =2, b =512, kB  =1000,  K  =1024,  MB =1000*1000,  M  =1024*1024,
xM  =M  GB  =1000*1000*1000,  G =1024*1024*1024, and so on for T, P, E, Z, Y.


Regards,
Li Wang
