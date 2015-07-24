Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <manjeet.p@samsung.com>) id 1ZIUHZ-0001nz-S7
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2015 04:08:25 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZIUHX-0006ig-Kx
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2015 04:08:25 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout2.samsung.com (Oracle Communications Messaging Server
	7.0.5.31.0 64bit (built May  5 2014))
	with ESMTP id <0NRZ02JTT4TRFVB0@mailout2.samsung.com> for
	ltp-list@lists.sourceforge.net; Fri, 24 Jul 2015 13:08:15 +0900 (KST)
Date: Fri, 24 Jul 2015 04:07:45 +0000 (GMT)
From: Manjeet Pawar <manjeet.p@samsung.com>
MIME-version: 1.0
MIME-version: 1.0
Message-id: <1292620122.336321437710865744.JavaMail.weblogic@epmlwas09d>
Subject: [LTP]  Regarding memcg control  testcase (mem_process.c)
Reply-To: manjeet.p@samsung.com
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
Cc: "ajeet.y@samsung.com" <ajeet.y@samsung.com>, pankaj.m@samsung.com

Hi,

I am trying to run memcg control testcase using script memcg_control_test.sh. This script calls a memory hog process 'mem_process'. 
The condition for this testcase to pass is 'when the memory hog process is killed on crossing boundary'. please check the below function.

<taken from memcg_control_test.sh>
-----------------------------
# Check if the test process is killed on crossing boundary
test_proc_kill()
{
    ( cd $TMP && mem_process -m $PROC_MEM & )
    sleep 1
    echo $! > tasks

    #Instruct the test process to start acquiring memory
    echo m > $STATUS_PIPE 
    sleep 5

    #Check if killed
    ps -p $! > /dev/null 2> /dev/null    ----> at this point the process 'mem_process' must have terminated so that last return value ($?) can be non-zero.
    if [ $? -eq 0 ]; then
        echo m > $STATUS_PIPE
        echo x > $STATUS_PIPE
    else
        : $((KILLED_CNT += 1))
    fi
}
-------------------------
In my case: 'mem_process' does not terminate until we pass 'x' to it, but the expected behaviour according to testcase  that the memory hog process 
must be killed on crossing bounday. 
Inputs taken by testcase are : "./memcg_control_test.sh 4096 4096 8192"
If I change the inputs from 8192 to other (1024,10MB,100MB etc) . In all situation memory hog process does not terminate.
So what is the ideal condition for this process to terminate to make whole testcase pass. ?

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
