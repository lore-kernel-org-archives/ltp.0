Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Yk885-0006Kl-OM
	for ltp-list@lists.sourceforge.net; Mon, 20 Apr 2015 09:36:37 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Yk884-00045I-9T
	for ltp-list@lists.sourceforge.net; Mon, 20 Apr 2015 09:36:37 +0000
Date: Mon, 20 Apr 2015 05:36:26 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1099961102.2612844.1429522586213.JavaMail.zimbra@redhat.com>
In-Reply-To: <1429088656-683-1-git-send-email-alexey.kodanev@oracle.com>
References: <1429088656-683-1-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v3] syscalls/fallocate04: add new fallocate() test
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
> Sent: Wednesday, 15 April, 2015 11:04:16 AM
> Subject: [LTP] [PATCH v3] syscalls/fallocate04: add new fallocate() test
> 
> This is a new functional test of fallocate() syscall with the focus on
> FALLOC_FL_ZERO_RANGE (since Linux 3.14) and FALLOC_FL_COLLAPSE_RANGE
> (since Linux 3.15) modes.

Hi,

https://git.kernel.org/cgit/docs/man-pages/man-pages.git/tree/man2/fallocate.2
says both are supported since 3.15.

> 
> Steps of test-cases:
>   * allocate a file with specified size;
>   * make a hole in the middle of the file with FALLOC_FL_PUNCH_HOLE;
>   * fill the hole and adjacent space with FALLOC_FL_ZERO_RANGE;
>   * remove a block from a file with FALLOC_FL_COLLAPSE_RANGE
> 
> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> ---
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
>  testcases/kernel/syscalls/fallocate/fallocate04.c |  278
>  +++++++++++++++++++++
>  5 files changed, 300 insertions(+), 1 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/fallocate/fallocate04.c

I get a TFAIL on older kernel:
  # ./fallocate04 
  fallocate04    0  TINFO  :  allocate '12288' bytes
  fallocate04    1  TFAIL  :  fallocate04.c:123: fallocate() failed: errno=EOPNOTSUPP(95): Operation not supported
looking at fallocate01, it checks both ENOSYS and EOPNOTSUPP, when call fails.

The rest looks good to me, my only nit is that tests depend on each
other (state of the file), but it's not hard to follow.

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
