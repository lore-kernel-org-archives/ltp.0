Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1RfrAp-00061Z-He
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 10:55:55 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RfrAo-0006F7-Hn
	for ltp-list@lists.sourceforge.net; Wed, 28 Dec 2011 10:55:55 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBSAtmmY023966
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Dec 2011 02:55:48 -0800 (PST)
Message-ID: <4EFAF5BB.2030407@windriver.com>
Date: Wed, 28 Dec 2011 18:55:55 +0800
From: Kang Kai <Kai.Kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] Posix test case mmap/31-1 fails on Linux/eglibc
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

I run mmap/31-1 failed with ENOMEM on linux, with error message:
off: fffffffffffff000, len: fffffffffffff000
Test FAIL: expect EOVERFLOW but get other error: Cannot allocate memory

But compare to mmap/24-2, it mmap() the same length but pass. Its output:
available memory: 18446744073709551615
addr: 7f78c54fa000, len: ffffffffffffffff
addr: 7f78c54fa000, len: fffffffffffff000
Test Pass: mmap/24-2.c Get ENOMEM: Cannot allocate memory

So I suppose that mmap/31-1 may need update, but I don't know how to 
make mmap() overflow as expect.
Any suggestion is appreciated.

Regards,
Kai

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
