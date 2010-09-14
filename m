Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OvOaH-0002ys-Sa
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:01:37 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OvOaH-0000lS-01
	for ltp-list@lists.sourceforge.net; Tue, 14 Sep 2010 06:01:37 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8E5gvRb001358
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 01:42:57 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8E61Vi5363420
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 02:01:31 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8E61Tu3010466
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Sep 2010 03:01:31 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C874E4F.7080506@linux.vnet.ibm.com>
References: <4C874E4F.7080506@linux.vnet.ibm.com>
Date: Tue, 14 Sep 2010 11:31:26 +0530
Message-Id: <1284444086.5001.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch suggested inside LTP memcg stress test
	case	'memcg_stress_test.sh'.
Reply-To: subrata@linux.vnet.ibm.com
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
To: Shubham <shubham@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, "iranna.ankad" <iranna.ankad@in.ibm.com>

Thanks. I have merged your patch. However you need to address the
following things in future:

     1. All patches need to have a DCO signoff like: Signed-off-by:
        Shubham <shubham@linux.vnet.ibm.com>,
     2. Create all your patches from LTP root: like:
diff -uprN ltp-*/testcases/*..*/file.orig ltp-*/testcases/*..*/file

Regards--
Subrata

On Wed, 2010-09-08 at 14:20 +0530, Shubham wrote:
> Hi,
>      We have found out a cgroup test case issue with
> 'ltp-full-20100331/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh'. The sniff of test case function is as below:-
> 
> Note: - Below code sniff is taken from latest LTP August month
> release.
> 
> run_stress()
> {
>         do_mount;
> 
>         for i in $(seq 0 $(($1-1)))
>         do
>                 mkdir /dev/memcg/$i 2> /dev/null
>                 ./memcg_process_stress $2 $3 &
>                 eval pid$i=$!
> 
>                 eval echo \$pid$i > /dev/memcg/$i/tasks
>         done
> 
>         for i in $(seq 0 $(($1-1)))
>         do
>                 eval /bin/kill -s SIGUSR1 \$pid$i 2> /dev/null
>         done
> 
>         sleep $4
> 
>         for i in $(seq 0 $(($1-1)))
>         do
>                 eval /bin/kill -s SIGINT \$pid$i 2> /dev/null
> <----send  SIGINT signal for a pid 
>                 eval wait \$pid$i
> 
>                 rmdir /dev/memcg/$i 2> /dev/null
>         done
> 
>         cleanup;
> }
> 
> 
> Basically, the test case is not doing a proper cleanup using SIGINT.It
> seems that the current test runs for much longer time than expected,
> thus affecting test performance. During this course of time, other
> dependent tests were also not proceeding further and system seemed to
> be in a process hang state. However we have found that SIGKILL does a
> better cleanup job compared to SIGINT, to overcome this situation.
> 
> So, I have created a patch to fix above test case issue. Kindly review
> this patch and acknowledge. I think this patch can be merged into
> latest LTP code to avoid this problem. 
> 
> Please let me know if you need any clarifications.
> 
> Regards,
> Shubham
> 
> ------------------------------------------------------------------------------
> This SF.net Dev2Dev email is sponsored by:
> 
> Show off your parallel programming skills.
> Enter the Intel(R) Threading Challenge 2010.
> http://p.sf.net/sfu/intel-thread-sfd
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
