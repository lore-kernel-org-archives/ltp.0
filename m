Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1X9cdY-0007pW-Su
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 16:09:56 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X9cdX-0005wZ-Eb
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 16:09:56 +0000
Date: Tue, 22 Jul 2014 12:09:47 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <640822169.13701915.1406045387116.JavaMail.zimbra@redhat.com>
In-Reply-To: <53CDE4C7.9040007@casparzhang.com>
References: <CAE1O6mhHy9uLNsgAVhg0+h+vyECTmRVTPULhF1fpjUHxjc3B4w@mail.gmail.com>
	<53CDE4C7.9040007@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] fix hugemmap03 fails on s390x error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Li Wang <wangli.ahau@gmail.com>
Cc: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Li Wang" <wangli.ahau@gmail.com>, ltp-list@lists.sourceforge.net
> Sent: Tuesday, 22 July, 2014 6:12:55 AM
> Subject: Re: [LTP] fix hugemmap03 fails on s390x error
> 
> On 07/22/2014 11:24 AM, Li Wang wrote:
> > Hi all,
> >
> > LTP failed with mmap into high region on s390x:
> >
> > hugemmap03    0  TINFO  :  set nr_hugepages to 64
> > hugemmap03    1  TFAIL  :  mmap into high region succeeded unexpectedly
> > hugemmap03    0  TINFO  :  set nr_hugepages to 0
> > hugemmap03    0  TWARN  :  tst_rmdir: rmobj(/tmp/hugOr8owE) failed:
> > remove(/tmp/hugOr8owE) failed; errno=16: Device or resource busy
> >
> >
> > According to the test case, the failing code is:
> >
> > 103                 /* Attempt to mmap into highmem addr, should get ENOMEM
> > */
> > 104                 addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
> > 105                             MAP_SHARED | MAP_FIXED, fildes, 0);
> > 106                 if (addr != MAP_FAILED) {
> > 107                         tst_resm(TFAIL, "mmap into high region "
> > 108                                  "succeeded unexpectedly");
> > 109                         goto fail;
> > 110                 }
> >
> > with HIGH_ADDR defined as:
> >
> > #define HIGH_ADDR       (void *)(0x1000000000000)
> >
> > This is an 2^48 address... which is likely the maximum for amd64.  On
> > s390x, the address space is up to 2^53. So the mmap() in the test case
> > succeeds which is not expected.
> >
> >
> > ---------------------------------------------
> >
> > after increase the HIGH_ADDR value, test PASS.
> >
> > [root@ibm-z10-38 hugemmap]# cat hugemmap03.c |grep HIGH
> > #define HIGH_ADDR (void *)(0x100000000000000)      <----increase the value
> > addr = mmap(HIGH_ADDR, map_sz, PROT_READ,

I tested this on s390x, and can confirm that raising it to 2^53 or higher
gives -ENOMEM.
I posted a small patch and added your Sob.

Regards,
Jan

> >
> >
> > [root@ibm-z10-38 hugemmap]# ./hugemmap03 -s 1024
> > hugemmap03    0  TINFO  :  set nr_hugepages to 1024
> > hugemmap03    1  TPASS  :  mmap into high region failed as expected:
> > errno=ENOMEM(12): Cannot allocate memory
> > hugemmap03    0  TINFO  :  set nr_hugepages to 0
> >
> >
> >
> >
> 
> Looks good to me. Could you please make a patch for it?
> 
> Thanks,
> Caspar
> 
> 
> 
> ------------------------------------------------------------------------------
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
