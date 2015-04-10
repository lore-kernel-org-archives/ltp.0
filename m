Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YgZTB-0003A3-3Z
	for ltp-list@lists.sourceforge.net; Fri, 10 Apr 2015 13:59:41 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YgZT6-0001da-6T
	for ltp-list@lists.sourceforge.net; Fri, 10 Apr 2015 13:59:41 +0000
Message-ID: <5527D7D6.4030108@oracle.com>
Date: Fri, 10 Apr 2015 17:01:58 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1428581481-192136-1-git-send-email-cuibixuan@huawei.com>
In-Reply-To: <1428581481-192136-1-git-send-email-cuibixuan@huawei.com>
Subject: Re: [LTP] [PATCH] mv/mv_tests.sh: Add test02 to test "mv -b"
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
To: Cui Bixuan <cuibixuan@huawei.com>
Cc: ltp-list@lists.sourceforge.net, zhanyongming@huawei.com.lijinyue, huawei.com.zhuyanpeng@huawei.com

Hi!
On 04/09/2015 03:11 PM, Cui Bixuan wrote:
> Add test02 to test "mv -b".
> Run it in ubuntu 12.02:
>
> <<<test_start>>>
> tag=mv_tests01 stime=1428322533
> cmdline="mv_tests.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> incrementing stop
> mv          0  TINFO  :  INIT: Inititalizing tests.
> mv01        0  TINFO  :  Test #1: mv <dir1> <dir2> will move dir1 to dir2 and all its contents
> mv01        0  TINFO  :  Test #1: Creating 10 directories.
> mv01        0  TINFO  :  Test #1: filling each dir with 10 files.
> mv01        0  TINFO  :  Test #1: creating output file
> mv01        0  TINFO  :  Test #1: creating expected output file
> mv01        0  TINFO  :  Test #1: comparing expected out and actual output file
> mv01        0  TINFO  :  Test #1: expected same as actual
> mv01        1  TPASS  :  Test #1: mv success
> mv          0  TINFO  :  INIT: Inititalizing tests.
> mv02        0  TINFO  :  Test #2: mv -b <file1> <file2> will move dir1 to dir2 and backup the file2
> mv02        1  TPASS  :  Test #2: mv -b success
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=1 cstime=8
> <<<test_end>>>

It's not a good idea to include test output in the commit message. IMHO, 
there should be a general description of the new test-case. Also, please 
check the patch with 'checkpatch.pl' script, fix warnings and errors, 
then resend.

Thanks,
Alexey


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
