Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1X9Ro6-0003fM-6C
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 04:36:06 +0000
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1X9Ro4-0000VO-8I
	for ltp-list@lists.sourceforge.net; Tue, 22 Jul 2014 04:36:06 +0000
Received: by mail-pa0-f46.google.com with SMTP id lj1so11118613pab.5
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 Jul 2014 21:35:58 -0700 (PDT)
Message-ID: <53CDE4C7.9040007@casparzhang.com>
Date: Tue, 22 Jul 2014 12:12:55 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <CAE1O6mhHy9uLNsgAVhg0+h+vyECTmRVTPULhF1fpjUHxjc3B4w@mail.gmail.com>
In-Reply-To: <CAE1O6mhHy9uLNsgAVhg0+h+vyECTmRVTPULhF1fpjUHxjc3B4w@mail.gmail.com>
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
To: Li Wang <wangli.ahau@gmail.com>, ltp-list@lists.sourceforge.net

On 07/22/2014 11:24 AM, Li Wang wrote:
> Hi all,
>
> LTP failed with mmap into high region on s390x:
>
> hugemmap03    0  TINFO  :  set nr_hugepages to 64
> hugemmap03    1  TFAIL  :  mmap into high region succeeded unexpectedly
> hugemmap03    0  TINFO  :  set nr_hugepages to 0
> hugemmap03    0  TWARN  :  tst_rmdir: rmobj(/tmp/hugOr8owE) failed:
> remove(/tmp/hugOr8owE) failed; errno=16: Device or resource busy
>
>
> According to the test case, the failing code is:
>
> 103                 /* Attempt to mmap into highmem addr, should get ENOMEM */
> 104                 addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
> 105                             MAP_SHARED | MAP_FIXED, fildes, 0);
> 106                 if (addr != MAP_FAILED) {
> 107                         tst_resm(TFAIL, "mmap into high region "
> 108                                  "succeeded unexpectedly");
> 109                         goto fail;
> 110                 }
>
> with HIGH_ADDR defined as:
>
> #define HIGH_ADDR       (void *)(0x1000000000000)
>
> This is an 2^48 address... which is likely the maximum for amd64.  On
> s390x, the address space is up to 2^53. So the mmap() in the test case
> succeeds which is not expected.
>
>
> ---------------------------------------------
>
> after increase the HIGH_ADDR value, test PASS.
>
> [root@ibm-z10-38 hugemmap]# cat hugemmap03.c |grep HIGH
> #define HIGH_ADDR (void *)(0x100000000000000)      <----increase the value
> addr = mmap(HIGH_ADDR, map_sz, PROT_READ,
>
>
> [root@ibm-z10-38 hugemmap]# ./hugemmap03 -s 1024
> hugemmap03    0  TINFO  :  set nr_hugepages to 1024
> hugemmap03    1  TPASS  :  mmap into high region failed as expected:
> errno=ENOMEM(12): Cannot allocate memory
> hugemmap03    0  TINFO  :  set nr_hugepages to 0
>
>
>
>

Looks good to me. Could you please make a patch for it?

Thanks,
Caspar



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
