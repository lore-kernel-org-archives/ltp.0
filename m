Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T3loX-0007SM-DA
	for ltp-list@lists.sourceforge.net; Tue, 21 Aug 2012 10:36:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T3loR-0006Am-OO
	for ltp-list@lists.sourceforge.net; Tue, 21 Aug 2012 10:36:01 +0000
Message-ID: <5033647F.8000904@redhat.com>
Date: Tue, 21 Aug 2012 12:35:43 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment fault
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng Zhao <Zhenfeng.Zhao@windriver.com>



----- Original Message -----
> From: "Kang Kai" <Kai.Kang@windriver.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net, "Zhenfeng Zhao" <Zhenfeng.Zhao@windriver.com>
> Sent: Tuesday, 21 August, 2012 11:59:19 AM
> Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment fault

<snip>

> Hi Jan,
> 
> Thanks.
> I am sorry that It doesn't work and still "segment fault".

Maybe we can narrow it down by running only subset of scenarios.
I would suggest trying to limit "sc" or "NSCENAR" and see which
one triggers it.

Another thing that looks suspicious are scenarios with altstack, there seems
to be small window where more than 1 thread can use same altstack.
Can you try to reproduce it without altstack scenarios?

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c b/testcases/open_posix_testsuite/conforman
index 5c15e93..63b6ee7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
@@ -162,6 +162,11 @@ static void *test(void *arg)
                output("Starting test with scenario (%i): %s\n",
                       sc, scenarii[sc].descr);
 #endif
+               if (scenarii[sc].altstack) {
+                       sc++;
+                       sc %= NSCENAR;
+                       continue;
+               }
 
                count_ope++;


Regards,
Jan

> 
> Regards,
> Kai
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
