Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1R8VNn-0006Au-UZ
	for ltp-list@lists.sourceforge.net; Tue, 27 Sep 2011 10:59:27 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1R8VNj-0001l5-Pk
	for ltp-list@lists.sourceforge.net; Tue, 27 Sep 2011 10:59:27 +0000
Received: by wyh5 with SMTP id 5so9679949wyh.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 27 Sep 2011 03:59:17 -0700 (PDT)
Message-ID: <4E81A4D1.7030502@casparzhang.com>
Date: Tue, 27 Sep 2011 18:26:25 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <CANoG8sWBQBjVej__oW0HSWB3wiXBU0HrdFE=5DpUeFABtoF5wQ@mail.gmail.com>
In-Reply-To: <CANoG8sWBQBjVej__oW0HSWB3wiXBU0HrdFE=5DpUeFABtoF5wQ@mail.gmail.com>
Subject: Re: [LTP] proc01 failed on 2.6.39 kernel
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
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 09/27/2011 05:49 PM, Romu wrote:
> Hi,
>
> proc01 in ltp-20110915 failed on 2.6.39 kernel:
>
> <<<test_start>>>
> tag=proc01 stime=1317119259
> cmdline="proc01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> proc01      0  TINFO  :  /proc/sysrq-trigger: is write-only.
> proc01      0  TINFO  :  /proc/kmsg: known issue: errno=EAGAIN(11):
> Resource temporarily unavailable
> proc01      0  TINFO  :  /proc/acpi/event: known issue:
> errno=EBUSY(16): Device or resource busy
> proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
> proc01      1  TFAIL  :  read failed: /proc/self/task/6144/ns/net:
> errno=EINVAL(22): Invalid argument
> proc01      2  TFAIL  :  read failed: /proc/self/task/6144/ns/uts:
> errno=EINVAL(22): Invalid argument
> proc01      3  TFAIL  :  read failed: /proc/self/task/6144/ns/ipc:
> errno=EINVAL(22): Invalid argument
> proc01      0  TINFO  :  /proc/self/task/6144/mem: known issue:
> errno=EIO(5): Input/output error
> proc01      0  TINFO  :  /proc/self/task/6144/clear_refs: is write-only.
> proc01      4  TFAIL  :  read failed: /proc/self/ns/net:
> errno=EINVAL(22): Invalid argument
> proc01      5  TFAIL  :  read failed: /proc/self/ns/uts:
> errno=EINVAL(22): Invalid argument
> proc01      6  TFAIL  :  read failed: /proc/self/ns/ipc:
> errno=EINVAL(22): Invalid argument
> proc01      0  TINFO  :  /proc/self/mem: known issue: errno=EIO(5):
> Input/output error
> proc01      0  TINFO  :  /proc/self/clear_refs: is write-only.
> proc01      7  TFAIL  :  readproc() failed with 6 errors.
> <<<execution_status>>>
> initiation_status="ok"
> duration=940 termination_type=exited termination_id=1 corefile=no
> cutime=1652 cstime=92280
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20110915
>
> I have no clue about the failure.  Any help would be great, thanks in advance.
>

looks like it was caused by the namespace support in 2.6.39:

http://thread.gmane.org/gmane.linux.kernel/1039644

LTP proc test seems couldn't handle them yet.

Thanks,
Caspar


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
