Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <a-fujita@rs.jp.nec.com>) id 1OPRfL-0003QE-Vl
	for ltp-list@lists.sourceforge.net; Fri, 18 Jun 2010 02:50:47 +0000
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OPRfK-0004wE-PV
	for ltp-list@lists.sourceforge.net; Fri, 18 Jun 2010 02:50:47 +0000
Message-ID: <4C1ADED5.4090800@rs.jp.nec.com>
Date: Fri, 18 Jun 2010 11:49:57 +0900
From: Akira Fujita <a-fujita@rs.jp.nec.com>
MIME-Version: 1.0
References: <1276809176.29789.9.camel@lucio-t400.br.ibm.com>
In-Reply-To: <1276809176.29789.9.camel@lucio-t400.br.ibm.com>
Subject: Re: [LTP] ffsb failures running ltp-ext4 new features test on
 SLES11sp1 PPC
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
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>

Hi Lucio,

Unfortunately, no I haven't.
I have run the ltp ext4-newfeat on FC13/REHL6 beta x86_64,
and it worked fine.

> write: No space left on device
I assume error messages you got are not related to
distro and arch but just a disk space shortage.

According to ffsb-config in ext4-newfeat,
we need 400MB (4KB * 100000 files) disk space at least.

And when I ran ext4-newfet, my ext4 size was 10GB.
Maybe you should check your disk space.

Regards,
Akira Fujita


(2010/06/18 6:12), Lucio Correia wrote:
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

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
