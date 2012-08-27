Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T5xJf-0007F6-Db
	for ltp-list@lists.sourceforge.net; Mon, 27 Aug 2012 11:17:11 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T5xJZ-0002XG-LH
	for ltp-list@lists.sourceforge.net; Mon, 27 Aug 2012 11:17:11 +0000
Date: Mon, 27 Aug 2012 07:16:58 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1291748381.11026946.1346066218005.JavaMail.root@redhat.com>
In-Reply-To: <E061084CB90FCE4F89232A6CF839683B32BC7591@SZXEML507-MBS.china.huawei.com>
MIME-Version: 1.0
Subject: Re: [LTP] Test case send01 fails in kernel version 3.6-rc1,
 rc2 and rc3
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
To: shyju pv <shyju.pv@huawei.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "shyju pv" <shyju.pv@huawei.com>
> To: ltp-list@lists.sourceforge.net
> Cc: "shyju pv" <shyju.pv@huawei.com>
> Sent: Monday, 27 August, 2012 12:30:34 PM
> Subject: [LTP] Test case send01 fails in kernel version 3.6-rc1, rc2 and rc3
> 
> Hi,
> 
> sendt01 test cases fails from 3.6-rc1,rc2 and rc3
> 
> Bug descreption:
> -------------------------
> LTP_Version: 2012-06-14
> LTP Test case: send01
> Description : Verifies the send syscall errorno for various failure
> cases
> Failure Analysis :  when the invalid flag set , The system gives
> error no
> EOPNOTSUPP (95) whereas LTP expects EFAULT(14)
> Fix : Modify  the LTP code with respect the the system return values
> of the
> latest kernel(3.6-rc1)
> Test case passed in Kernel 3.5
> Failed from  3.6-rc1,rc2and rc3

Looks to be the same reason as sendto().
I'm thinking we can either remove that test or change it to UDP:

diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index ad64c70..c8dd9bd 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -126,8 +126,8 @@ struct test_case_t {                /* test case structure */
                    sizeof(sin1), -1, EPIPE, setup2, cleanup1,
                    "local endpoint shutdown"}
        , {
-       PF_INET, SOCK_STREAM, 0, buf, sizeof(buf), -1, &sin1,
-                   sizeof(sin1), 0, EPIPE, setup1, cleanup1,
+       PF_INET, SOCK_DGRAM, 0, buf, sizeof(buf), -1, &sin1,
+                   sizeof(sin1), -1, EOPNOTSUPP, setup1, cleanup1,
                    "invalid flags set"}
 };

this way it should hit:
        if (msg->msg_flags&MSG_OOB)     /* Mirror BSD error message compatibility */
                return -EOPNOTSUPP;

I see the check is there at least since 2.6.11.
Any thoughts?

Regards,
Jan

> 
> Execution Log
> ---------------------
> <<<test_output>>>
> incrementing stop
> send01      1  TPASS  :  bad file descriptor successful
> send01      2  TPASS  :  invalid socket successful
> send01      3  TPASS  :  invalid send buffer successful
> send01      4  TPASS  :  UDP message too big successful
> send01      5  TPASS  :  local endpoint shutdown successful
> send01      6  TFAIL  :  invalid flags set ; returned -1 (expected
> -1),
> errno
> 95 (expected 14)
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=1 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> INFO: ltp-pan reported some tests FAIL
> 
> Shyju
> 
> 
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond.
> Discussions
> will include endpoint security, mobile security and the latest in
> malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
