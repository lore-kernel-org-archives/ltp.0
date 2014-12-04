Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rapiteanu.catalin@gmail.com>) id 1XwWa5-0001cW-ID
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 13:36:29 +0000
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XwWa4-0003vI-NG
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 13:36:29 +0000
Received: by mail-wi0-f178.google.com with SMTP id em10so8409200wid.11
	for <ltp-list@lists.sourceforge.net>;
	Thu, 04 Dec 2014 05:36:22 -0800 (PST)
Received: from [128.224.168.147] ([89.121.200.106])
	by mx.google.com with ESMTPSA id bj3sm18234459wib.3.2014.12.04.05.36.21
	for <ltp-list@lists.sourceforge.net>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 04 Dec 2014 05:36:21 -0800 (PST)
Message-ID: <548063A8.4060104@gmail.com>
Date: Thu, 04 Dec 2014 15:37:44 +0200
From: =?UTF-8?B?VmlvcmVsLUPEg3TEg2xpbiBSxINwacibZWFudQ==?=
	<rapiteanu.catalin@gmail.com>
MIME-Version: 1.0
Subject: [LTP]  min_free_kbytes incorrect results
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

I've been running 'min_free_kbytes' from 'runtest/mm', but everytime I'm 
getting an incorrect value on read. I've tried this test on different 
machines (different architectures) and with different versions of ltp, 
but I'm getting the same error on read. I've looked at the test, but the 
code seems fine. If anybody has any ideea why this isn't working please 
let me know.

The following log was generated using an up-to-date Arch Linux x64 using 
kernel: 3.17.4-1
-------------------------------------------------------------------------------------------------
min_free_kbytes    0  TINFO  :  set overcommit_memory to 2
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 67584
min_free_kbytes    1  TBROK  :  min_free_kbytes = 6, but expect 67584
min_free_kbytes    2  TBROK  :  Remaining cases broken
min_free_kbytes    0  TINFO  :  set min_free_kbytes to 67584
min_free_kbytes    0  TINFO  :  set overcommit_memory to 0
incrementing stop
--------------------------------------------------------------------------------------------------
Please let me know if I can be of any assistance.

Kind regards,
Catalin

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
