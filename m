Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shubham@linux.vnet.ibm.com>) id 1OvOqO-00066J-Fa
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:18:16 +0000
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvOqK-0008Hd-TA
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:18:15 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.4/8.13.1) with ESMTP id o8E6I56K018478
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 16:18:05 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8E6I3Ka479242
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 16:18:05 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8E6I36K024327
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 16:18:03 +1000
Message-ID: <4C8F1399.7080203@linux.vnet.ibm.com>
Date: Tue, 14 Sep 2010 11:48:01 +0530
From: Shubham <shubham@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4C874E4F.7080506@linux.vnet.ibm.com>
	<1284444086.5001.13.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1284444086.5001.13.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] Patch suggested inside LTP memcg stress test case
	'memcg_stress_test.sh'.
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, "iranna.ankad" <iranna.ankad@in.ibm.com>

  Thanks Subrata,
                            I will take care of below mentioned points 
in future.

Regards
--Shubham

On Tuesday 14 September 2010 11:31 AM, Subrata Modak wrote:
> Thanks. I have merged your patch. However you need to address the
> following things in future:
>
>       1. All patches need to have a DCO signoff like: Signed-off-by:
>          Shubham<shubham@linux.vnet.ibm.com>,
>       2. Create all your patches from LTP root: like:
> diff -uprN ltp-*/testcases/*..*/file.orig ltp-*/testcases/*..*/file
>
> Regards--
> Subrata
>
> On Wed, 2010-09-08 at 14:20 +0530, Shubham wrote:
>> Hi,
>>       We have found out a cgroup test case issue with
>> 'ltp-full-20100331/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh'. The sniff of test case function is as below:-
>>
>> Note: - Below code sniff is taken from latest LTP August month
>> release.
>>
>> run_stress()
>> {
>>          do_mount;
>>
>>          for i in $(seq 0 $(($1-1)))
>>          do
>>                  mkdir /dev/memcg/$i 2>  /dev/null
>>                  ./memcg_process_stress $2 $3&
>>                  eval pid$i=$!
>>
>>                  eval echo \$pid$i>  /dev/memcg/$i/tasks
>>          done
>>
>>          for i in $(seq 0 $(($1-1)))
>>          do
>>                  eval /bin/kill -s SIGUSR1 \$pid$i 2>  /dev/null
>>          done
>>
>>          sleep $4
>>
>>          for i in $(seq 0 $(($1-1)))
>>          do
>>                  eval /bin/kill -s SIGINT \$pid$i 2>  /dev/null
>> <----send  SIGINT signal for a pid
>>                  eval wait \$pid$i
>>
>>                  rmdir /dev/memcg/$i 2>  /dev/null
>>          done
>>
>>          cleanup;
>> }
>>
>>
>> Basically, the test case is not doing a proper cleanup using SIGINT.It
>> seems that the current test runs for much longer time than expected,
>> thus affecting test performance. During this course of time, other
>> dependent tests were also not proceeding further and system seemed to
>> be in a process hang state. However we have found that SIGKILL does a
>> better cleanup job compared to SIGINT, to overcome this situation.
>>
>> So, I have created a patch to fix above test case issue. Kindly review
>> this patch and acknowledge. I think this patch can be merged into
>> latest LTP code to avoid this problem.
>>
>> Please let me know if you need any clarifications.
>>
>> Regards,
>> Shubham
>>
>> ------------------------------------------------------------------------------
>> This SF.net Dev2Dev email is sponsored by:
>>
>> Show off your parallel programming skills.
>> Enter the Intel(R) Threading Challenge 2010.
>> http://p.sf.net/sfu/intel-thread-sfd
>> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
