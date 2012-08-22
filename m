Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T4BnQ-00059I-Al
	for ltp-list@lists.sourceforge.net; Wed, 22 Aug 2012 14:20:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T4BnK-0005oU-De
	for ltp-list@lists.sourceforge.net; Wed, 22 Aug 2012 14:20:36 +0000
Message-ID: <5034EAA5.3020405@redhat.com>
Date: Wed, 22 Aug 2012 16:20:21 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
References: <40249568.8900482.1345625939805.JavaMail.root@redhat.com>
In-Reply-To: <40249568.8900482.1345625939805.JavaMail.root@redhat.com>
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

On 08/22/2012 10:58 AM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> From: "Kang Kai" <Kai.Kang@windriver.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: gaowanlong@cn.fujitsu.com, ltp-list@lists.sourceforge.net, "Zhenfeng Zhao" <Zhenfeng.Zhao@windriver.com>
>> Sent: Wednesday, 22 August, 2012 10:28:59 AM
>> Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment fault
> 
>> Hi Jan,
>>
>>> Is the above output from mips or x86_64?
>>> Are you running it as root user?
>>
>> This was tested on x86_64 with unprivileged  user. I retest it with
>> root
>> and test passes.
> 
> Your unprivileged user is hitting some resource limit, I'd be interested
> to see how many threads are actually running at the same time. 
> 
>> It passes on routerstation(mips) with your patch too.
>> So it looks like a race condition issue about stack attribute between
>> threads, right?
> 
> I think so. We can try different way of signalling when threaded() is done
> and try it again with all scenarios.

I think this testcase is broken in more than 1 way. At least on my setup, I don't see
a single pthread_detach() while signals are firing - which is exactly goal of this test.

With following change:

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c b/testcases/open_posix_testsuite/conforman
index dfa6e19..48e1343 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_detach/4-3.c
@@ -277,6 +276,7 @@ int main(int argc, char *argv[])
                do_it1 = 0;
        } while (do_it1);
 
+       output("  %d thread detached while signals were firing.\n", count_ope);
        sleep(1);
 
        do {

I get:
[16:11:23]  1 thread detached while signals are firing.
[16:11:24]Test executed successfully.
[16:11:24]  77865 thread detached.

and that reported "1" is how many threads attempted to call pthread_detach, not how many actually
succeeded. Signals are firing so frequently that threaded() can't progress at all.

Regards,
Jan

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
