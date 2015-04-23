Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1YlBo7-0006Sz-Oj
	for ltp-list@lists.sourceforge.net; Thu, 23 Apr 2015 07:44:23 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YlBo6-0006sh-9x
	for ltp-list@lists.sourceforge.net; Thu, 23 Apr 2015 07:44:23 +0000
Date: Thu, 23 Apr 2015 03:44:14 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <589021019.4782174.1429775054199.JavaMail.zimbra@redhat.com>
In-Reply-To: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
References: <1429621507-23503-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v4] syscalls/fallocate04: add new fallocate() test
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
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Alexey Kodanev" <alexey.kodanev@oracle.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
> Sent: Tuesday, 21 April, 2015 3:05:07 PM
> Subject: [LTP] [PATCH v4] syscalls/fallocate04: add new fallocate() test
> 
> This is a new functional test of fallocate() syscall with the focus on
> FALLOC_FL_ZERO_RANGE (since Linux 3.15) and FALLOC_FL_COLLAPSE_RANGE
> (since Linux 3.15) modes.
> 
> Steps of test-cases:
>   * allocate a file with specified size;
>   * make a hole in the middle of the file with FALLOC_FL_PUNCH_HOLE;
>   * fill the hole and adjacent space with FALLOC_FL_ZERO_RANGE;
>   * remove a block from a file with FALLOC_FL_COLLAPSE_RANGE
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
> v4: corrected Linux version for FALLOC_FL_ZERO_RANGE
>     removed second Linux version check in test04()
>     added 'EOPNOTSUPP' check for initial fallocate()
> v3: correctly indented second line in if blocks and tst_resm
> v2: replaced lseek, read, write, etc. with LTP safe macros
>     moved FALLOC_FL_* macros to fallocate.h
>     removed FALLOC_FL_KEEP_SIZE from fallocate03 (it is now in fallocate.h)
>     made one more test-case (split setup())
> 
>  runtest/syscalls                                  |    1 +
>  testcases/kernel/syscalls/.gitignore              |    1 +
>  testcases/kernel/syscalls/fallocate/fallocate.h   |   20 ++
>  testcases/kernel/syscalls/fallocate/fallocate03.c |    1 -
>  testcases/kernel/syscalls/fallocate/fallocate04.c |  273
>  +++++++++++++++++++++
>  5 files changed, 295 insertions(+), 1 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/fallocate/fallocate04.c
> 

v4 looks good, older kernels now end with TCONF. ACK

Regards,
Jan

------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
