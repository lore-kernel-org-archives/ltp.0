Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1X6f29-0006DF-6g
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 12:07:05 +0000
Received: from e06smtp13.uk.ibm.com ([195.75.94.109])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X6f27-0002Cq-TQ
	for ltp-list@lists.sourceforge.net; Mon, 14 Jul 2014 12:07:05 +0000
Received: from /spool/local
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Mon, 14 Jul 2014 13:06:57 +0100
Message-ID: <53C3C7D9.4030405@linux.vnet.ibm.com>
Date: Mon, 14 Jul 2014 14:06:49 +0200
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <1405335583.552821152@apps.rackspace.com>
In-Reply-To: <1405335583.552821152@apps.rackspace.com>
Subject: Re: [LTP] [Ltp-coverage] NO .gcda files ERROR while running LCOV
 for LTP coverage
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
To: shinto.john@smartplayin.com, naresh.kamboju@linaro.org
Cc: ltp-list@lists.sourceforge.net, ltp-coverage@lists.sourceforge.net

On 14.07.2014 12:59, shinto.john@smartplayin.com wrote:
> Kernel version: 3.8.13
> 
> I am sending this mail to get your valuable inputs regarding an issue i
> am facing while running LCOV as part of an LTP activity.
> 
> Currently i am working on LTP and GCOV integration on TI J6 board.
> 
> I have enabled the GCOV in kernel using attached patch.
> 
> This patch works fine for Beagle bone black with same kernel version
> 3.8.13 and coverage results are captured for LTP.

The attached patch looks like it's a mix of ARM-enabling parts together
with an older version of the upstream version of the Linux kernel gcov
patch. It might be an idea to replace those latter parts with the
current upstream version (that is copy over all source files under
kernel/gcov from a current upstream kernel).

> Now in J6 i face below issue.
> 
> root@dra7xx-evm:/home/coverage# lcov -c -o coverage.info
> Auto-detecting gcov kernel support.
> Found upstream gcov kernel support at /sys/kernel/debug/gcov
> Copying data to temporary directory /tmp/D5EuajnqI8
> Capturing coverage data from /tmp/D5EuajnqI8
> Found gcov version: 4.7.2
> Scanning /tmp/D5EuajnqI8 for .gcda files ...
> *geninfo: ERROR: no .gcda files found in /tmp/D5EuajnqI8!*
> 
> But when i checked /sys/kernel/debug/gcov/, i could see .gcda and .gcno
> files in all the kernel folders. for eg

I don't see a situation in which lcov would silently fail to copy .gcda
files. Some ideas to try out:
1. Upgrade to the latest version of lcov [1]
2. Try to run gcov manually on one of the .gcda files [2]
3. Modify the lcov program to emit additional debugging output that
   might help in identifying the cause of the problem. For this, add
   the following statement as the last line of function
   lcov_copy_single() in the lcov program:

     print("from=$from to=$to len=".length($content)."\n");

> ls -l
> /sys/kernel/debug/gcov/home/dattatraya.patil/dar7xx/board-support/linux/kernel/wait.*
> 
> -rw-------    1 root     root             0 Jan  1  1970 wait.gcda
> lrwxrwxrwx    1 root     root             0 Jan  1  1970 wait.gcno ->
> /home/dattatraya.patil/dar7xx/board-support/linux/kernel/.tmp_wait.gcno
> 
> ls -l
> /home/dattatraya.patil/dar7xx/board-support/linux/kernel/.tmp_wait.gcno
> -rw-rw-r--    1 1001     1003         10748 Jul 14  2014
> /home/dattatraya.patil/dar7xx/board-support/linux/kernel/.tmp_wait.gcno
> 
> In /sys/kernel/debug/gcov  folder, the .gcda and .gcno files looks empty
> with 0kb.

A size of 0kb is expected since the files in debugfs are virtual
(content is only created when read from).

> can you please share your valid inputs to point out the possible issue?


Regards,
  Peter Oberparleiter


[1] http://ltp.sourceforge.net/coverage/lcov.php
[2] https://www.kernel.org/doc/Documentation/gcov.txt

-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck&#174;
Code Sight&#153; - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
