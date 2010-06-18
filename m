Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OPUm2-0001rB-Kd
	for ltp-list@lists.sourceforge.net; Fri, 18 Jun 2010 06:09:54 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OPUm0-000897-AV
	for ltp-list@lists.sourceforge.net; Fri, 18 Jun 2010 06:09:54 +0000
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o5I5u60q028464
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Jun 2010 01:56:06 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5I69kck1880108
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Jun 2010 02:09:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5I69jBg019879
	for <ltp-list@lists.sourceforge.net>; Fri, 18 Jun 2010 03:09:46 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1276809176.29789.9.camel@lucio-t400.br.ibm.com>
References: <1276809176.29789.9.camel@lucio-t400.br.ibm.com>
Date: Fri, 18 Jun 2010 11:39:38 +0530
Message-Id: <1276841379.6391.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] ffsb failures running ltp-ext4 new features test
	on	SLES11sp1 PPC
Reply-To: subrata@linux.vnet.ibm.com
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
To: ljhc@br.ibm.com
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>, Akira Fujita <a-fujita@rs.jp.nec.com>

Hi Lucio,

Till now i did not detect any failure for the sdb2:

ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
0, Blocksize: 1024, isAuto_da_alloc: auto_da_alloc=1
ext4-delalloc-mballoc    1  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
0, Blocksize: 1024, isAuto_da_alloc: noauto_da_alloc
ext4-delalloc-mballoc    2  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc,
isDirectIO: 0, Blocksize: 1024, isAuto_da_alloc: auto_da_alloc=1
ext4-delalloc-mballoc    3  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc,
isDirectIO: 0, Blocksize: 1024, isAuto_da_alloc: noauto_da_alloc
ext4-delalloc-mballoc    4  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
1, Blocksize: 1024, isAuto_da_alloc: auto_da_alloc=1
ext4-delalloc-mballoc    5  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
1, Blocksize: 1024, isAuto_da_alloc: noauto_da_alloc
ext4-delalloc-mballoc    6  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc,
isDirectIO: 1, Blocksize: 1024, isAuto_da_alloc: auto_da_alloc=1
ext4-delalloc-mballoc    7  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: nodelalloc,
isDirectIO: 1, Blocksize: 1024, isAuto_da_alloc: noauto_da_alloc
ext4-delalloc-mballoc    8  TPASS  :  delalloc/mballoc test pass
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
0, Blocksize: 4096, isAuto_da_alloc: auto_da_alloc=1

I will continue to run the tests and update you again.

Regards--
Subrata

On Thu, 2010-06-17 at 18:12 -0300, Lucio Correia wrote:
> Hi Akira,
> 
> I've found some failures running ext4-newfeat with SLES11sp1 on POWER6.
> Have you seen that before? 
> 
> 
> 
> ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
> 0,
> Blocksize: 4096, isAuto_da_alloc: auto_da_alloc=1
> write: No space left on device
> ext4-delalloc-mballoc    9  TFAIL  :  ffsb returned failure
> 
> ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
> 1, 
> write: No space left on device
> write: No space left on device
> write: No space left on device
> write: No space left on device
> ext4-journal-checksum    1  TFAIL  :  ffsb returned failure
> 
> ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
> 100, 
> write: No space left on device
> write: No space left on device
> write: No space left on device
> ext4-journal-checksum    4  TFAIL  :  ffsb returned failure
> 
> ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
> 1, 
> write: Success
> write: Success
> write: No space left on device
> ext4-journal-checksum    7  TFAIL  :  ffsb returned failure
> 
> ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
> 100, 
> write: No space left on device
> write: No space left on device
> ext4-journal-checksum   10  TFAIL  :  ffsb returned failure
> 
> and so on 13, 16, 19, 22, 25, 28, 31, 34.
> ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
> 0,
> Blocksize: 4096, isAuto_da_alloc: auto_da_alloc=1
> write: No space left on device
> ext4-delalloc-mballoc    9  TFAIL  :  ffsb returned failure
> 
> ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
> 1, 
> write: No space left on device
> write: No space left on device
> write: No space left on device
> write: No space left on device
> ext4-journal-checksum    1  TFAIL  :  ffsb returned failure
> 
> ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
> 100, 
> write: No space left on device
> write: No space left on device
> write: No space left on device
> ext4-journal-checksum    4  TFAIL  :  ffsb returned failure
> 
> ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
> 1, 
> write: Success
> write: Success
> write: No space left on device
> ext4-journal-checksum    7  TFAIL  :  ffsb returned failure
> 
> ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
> 100, 
> write: No space left on device
> write: No space left on device
> ext4-journal-checksum   10  TFAIL  :  ffsb returned failure
> 
> and so on 13, 16, 19, 22, 25, 28, 31, 34.
> 
> 
> Regards,
> 
> 
> 
> Lucio Correia
> --------------
> Software Engineer
> IBM LTC
> 
> 
> ------------------------------------------------------------------------------
> ThinkGeek and WIRED's GeekDad team up for the Ultimate 
> GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
> lucky parental unit.  See the prize list and enter to win: 
> http://p.sf.net/sfu/thinkgeek-promo
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
