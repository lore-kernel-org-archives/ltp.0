Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1SUqkX-00012c-0H
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 02:47:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SUqkW-0005eN-0S
	for ltp-list@lists.sourceforge.net; Thu, 17 May 2012 02:47:32 +0000
Message-ID: <4FB466B6.8060508@cn.fujitsu.com>
Date: Thu, 17 May 2012 10:47:18 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <20120516145353.GA12228@saboteur.suse.cz>
	<1337219962-5782-1-git-send-email-penght@cn.fujitsu.com>
	<4FB45E98.3010506@cn.fujitsu.com>
	<CAGH67wSxwhPXQ_j5ryRQe4-en-wYf3iLUgrn9xtcQ54dR1FsaA@mail.gmail.com>
	<4FB46381.2010400@cn.fujitsu.com>
	<CAGH67wTa2Y6mXP9Wv229s8Wdzp57uN=hcB63eEvW6Ud0osdUOw@mail.gmail.com>
	<CAGH67wStJk_mqT46zqJ5FPNHLEeBjcyPo6i050xMwmpCm5aoBQ@mail.gmail.com>
In-Reply-To: <CAGH67wStJk_mqT46zqJ5FPNHLEeBjcyPo6i050xMwmpCm5aoBQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] ltp-pan.c: fix error of Total Tests
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net


Garrett Cooper said the following on 2012-5-17 10:40:
>> You can easily trigger this problem with the following spoofed runtest scenario:
>>
>> aok echo "hello"
>> donotexist donotexist
>> exit_quickly exit 1
>> true true
>>

The test log is as follows:

Running tests.......
<<<test_start>>>
tag=aok stime=1337251363
cmdline="echo "hello""
contacts=""
analysis=exit
<<<test_output>>>
hello
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=donotexist stime=1337251363
cmdline="donotexist"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(17520): execvp of 'donotexist' (tag donotexist) failed.                                                   errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=exit_quickly stime=1337251363
cmdline="exit 1"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="pan(17520): execvp of 'exit' (tag exit_quickly) failed.  errn                                                 o:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
cutime=0 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=true stime=1337251363
cmdline="true"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=0
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: 20120401-38-g3d3e94e

       ###############################################################

            Done executing testcases.
            LTP Version:  20120401-38-g3d3e94e
       ###############################################################


# cat results/LTP_RUN_ON-2012_May_17-18h_42m_42s.log
Test Start Time: Thu May 17 18:42:43 2012
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
aok                            PASS       0
donotexist                     FAIL       2
exit_quickly                   FAIL       2
true                           PASS       0

-----------------------------------------------
Total Tests: 4
Total Failures: 2
Kernel Version: 2.6.32-220.el6.x86_64
Machine Architecture: x86_64
Hostname: RHEL6U2-x86-64


Thanks.

-- 
Best Regards,
Peng Haitao

>> The first will fail success with "hello" output, the second should
> 
> s/fail success/pass/
> 
>> fail with ENOENT, the third will fail without output, and the fourth
>> should success with output.
>>
>> If this functions as I described above, I'll be more than happy to ACK
>> the patch.
>>
>> Thanks!
>> -Garrett
> 
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
