Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Shivakumar.Haravi@aricent.com>) id 1TxIb7-0004M9-2K
	for ltp-list@lists.sourceforge.net; Mon, 21 Jan 2013 14:43:41 +0000
Received: from jaguar.aricent.com ([180.151.2.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TxIb5-0001gJ-Ms
	for ltp-list@lists.sourceforge.net; Mon, 21 Jan 2013 14:43:41 +0000
From: Shivakumar Haravi <Shivakumar.Haravi@aricent.com>
Date: Mon, 21 Jan 2013 19:43:05 +0530
Message-ID: <C0DEA5E8FC36694CB7391338195EAAEB05DC9A2F37@GUREXMB02.ASIAN.AD.ARICENT.COM>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] LTP queries
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: "kumar_haravi@yahoo.com" <kumar_haravi@yahoo.com>

Greetings,

I am currently working on LTP.

My objective of using LTP.  LTP need to be run on target board (Ex: Panda board). I am able to run script as. /RUNLTP. As per my understanding RUNLTP does only do stress and some functional verification of system call. If I am wrong pls. correct me.

Our next objective is all driver code need to be executed on panda board.


Need your guidance to proceed further:
I). Under device driver folder, Each driver code need to be run independently.
Our objective is to automated the driver code also (Ex: run this script as ./runltp) device driver code also gets executed. Kindly guide us how to do this?

II )

Tried to run one driver code as "agp"

                      1. Able to compile the user_space folder
                      2. I am not able to compile the kernel_space folder.

Following error was getting displayed.
shivakumar@shivakumar-Latitude-E6420:~/LTP/LTP_X86/testcases/kernel/device-drivers/agp/kernel_space$ sudo make
make -C /lib/modules/3.2.0-23-generic/build  SUBDIRS=/home/shivakumar/LTP/LTP_X86/testcases/kernel/device-drivers/agp/kernel_space modules
make[1]: Entering directory `/usr/src/linux-headers-3.2.0-23-generic'
scripts/Makefile.build:49: *** CFLAGS was changed in "/home/shivakumar/LTP/LTP_X86/testcases/kernel/device-drivers/agp/kernel_space/Makefile". Fix it to use ccflags-y.  Stop.
make[1]: *** [_module_/home/shivakumar/LTP/LTP_X86/testcases/kernel/device-drivers/agp/kernel_space] Error 2
make[1]: Leaving directory `/usr/src/linux-headers-3.2.0-23-generic'
make: *** [default] Error 2
===============================================================================
III) How to integrated our new driver code
============================================================================

IV) S>>> ./runltp -a kumar_haravi@yahoo.com -f shiva > DEBUGLOG/testmail
NOTE: "shiva" is my command line file,
Following error getting displayed:
./runltp: 882: [: [: unexpected operator
tar: Removing leading `/' from member names
tar: Removing leading `/' from member names
./runltp: 945: ./runltp: ./runltp: 945: ./runltp: uuencode: not foundmail: not found
==============================================================================

V) I am not able to generate html report also.

Thanks for your advance guidance,
Shivakumar




===============================================================================
Please refer to http://www.aricent.com/legal/email_disclaimer.html
for important disclosures regarding this electronic communication.
===============================================================================

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
