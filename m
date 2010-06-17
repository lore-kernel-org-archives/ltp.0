Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ljhc@br.ibm.com>) id 1OPMwO-00067K-Rn
	for ltp-list@lists.sourceforge.net; Thu, 17 Jun 2010 21:48:04 +0000
Received: from e24smtp04.br.ibm.com ([32.104.18.25])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OPMwJ-0004gR-Vz
	for ltp-list@lists.sourceforge.net; Thu, 17 Jun 2010 21:48:04 +0000
Received: from mailhub1.br.ibm.com (mailhub1.br.ibm.com [9.18.232.109])
	by e24smtp04.br.ibm.com (8.14.4/8.13.1) with ESMTP id o5HKuKgH016618
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jun 2010 17:56:20 -0300
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5HLHZ211069460
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jun 2010 18:17:37 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5HLD4ka020718
	for <ltp-list@lists.sourceforge.net>; Thu, 17 Jun 2010 18:13:04 -0300
From: Lucio Correia <ljhc@br.ibm.com>
Date: Thu, 17 Jun 2010 18:12:56 -0300
Message-ID: <1276809176.29789.9.camel@lucio-t400.br.ibm.com>
Mime-Version: 1.0
Subject: [LTP] ffsb failures running ltp-ext4 new features test on SLES11sp1
	PPC
Reply-To: ljhc@br.ibm.com
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
To: Akira Fujita <a-fujita@rs.jp.nec.com>
Cc: Linux Test Project <ltp-list@lists.sourceforge.net>

Hi Akira,

I've found some failures running ext4-newfeat with SLES11sp1 on POWER6.
Have you seen that before? 



ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
0,
Blocksize: 4096, isAuto_da_alloc: auto_da_alloc=1
write: No space left on device
ext4-delalloc-mballoc    9  TFAIL  :  ffsb returned failure

ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
1, 
write: No space left on device
write: No space left on device
write: No space left on device
write: No space left on device
ext4-journal-checksum    1  TFAIL  :  ffsb returned failure

ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
100, 
write: No space left on device
write: No space left on device
write: No space left on device
ext4-journal-checksum    4  TFAIL  :  ffsb returned failure

ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
1, 
write: Success
write: Success
write: No space left on device
ext4-journal-checksum    7  TFAIL  :  ffsb returned failure

ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
100, 
write: No space left on device
write: No space left on device
ext4-journal-checksum   10  TFAIL  :  ffsb returned failure

and so on 13, 16, 19, 22, 25, 28, 31, 34.
ext4-delalloc-mballoc    0  TINFO  :  isDelalloc: delalloc, isDirectIO:
0,
Blocksize: 4096, isAuto_da_alloc: auto_da_alloc=1
write: No space left on device
ext4-delalloc-mballoc    9  TFAIL  :  ffsb returned failure

ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
1, 
write: No space left on device
write: No space left on device
write: No space left on device
write: No space left on device
ext4-journal-checksum    1  TFAIL  :  ffsb returned failure

ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
100, 
write: No space left on device
write: No space left on device
write: No space left on device
ext4-journal-checksum    4  TFAIL  :  ffsb returned failure

ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
1, 
write: Success
write: Success
write: No space left on device
ext4-journal-checksum    7  TFAIL  :  ffsb returned failure

ext4-journal-checksum    0  TINFO  :  journal mode: writeback, commit interval:
100, 
write: No space left on device
write: No space left on device
ext4-journal-checksum   10  TFAIL  :  ffsb returned failure

and so on 13, 16, 19, 22, 25, 28, 31, 34.


Regards,



Lucio Correia
--------------
Software Engineer
IBM LTC


------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
