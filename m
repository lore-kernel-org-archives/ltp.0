Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1NwYAs-0003Ac-Mz
	for ltp-list@lists.sourceforge.net; Tue, 30 Mar 2010 09:55:54 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NwYAp-0001dy-Er
	for ltp-list@lists.sourceforge.net; Tue, 30 Mar 2010 09:55:54 +0000
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o2U9tjZx012040
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Mar 2010 02:55:45 -0700 (PDT)
Message-ID: <4BB1CB41.40805@windriver.com>
Date: Tue, 30 Mar 2010 17:58:25 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
Subject: [LTP] about hugetlbfs
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
To: ltp-list@lists.sourceforge.net

Hi all,

I have some problem about hugetlbfs test.

In hugeshmat01.c
the attach address for shmat is 0x90000eee .
But for mips32_Linux system ,the user pthread space is 
0x00000000~0x7fffffff,
so 0x90000eee exceed the space ,the test will always failed on mips_32.

In hugemmap02.c
#define LOW_ADDR2      (void *)(0x90000000)
#define LOW_ADDR       (void *)(0x80000000)
addr = mmap(LOW_ADDR, PAGE_SIZE, PROT_READ,
                            MAP_SHARED | MAP_FIXED, nfildes, 0);
addr2 = mmap(LOW_ADDR2, MAP_SIZE, PROT_READ | PROT_WRITE,
                            MAP_SHARED, fildes, 0);

 /* 32-bit process */
                if (addr2 > 0){
                        tst_resm(TCONF, "huge mmap() failed to test the 
scenario");
                        continue;
                } else if (addr == 0) {
                        tst_resm(TPASS, "huge mmap() succeeded for 32-bit");
                } else {
                        tst_resm(TFAIL, "huge mmap() unexpectedly failed 
%s for 32-bit, errno=%d : %s",
                                TEMPFILE, errno, strerror(errno));
                }

the 0x90000000  and 0x80000000 also exceed mips32 user pthread space , 
so I changed them .
but add2 always return 717225984, no matter what I allocate to LOW_ADDR2.
at last ,I changed LOW_ADDR2 to NULL, it also returned 717225984.

in the function ,why addr2> 0 then error happens?
why addr should be 0? it is what exactly the LOW_ADDR assigns.

Thanks and Best Regards,
Lina

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
