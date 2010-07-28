Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OeAXJ-0000FV-BE
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 17:35:21 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OeAXI-0002E3-8l
	for ltp-list@lists.sourceforge.net; Wed, 28 Jul 2010 17:35:21 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6SHRDep015076
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jul 2010 11:27:13 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o6SHYsil042080
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jul 2010 11:34:58 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6SHYr9S013570
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jul 2010 11:34:53 -0600
Received: from [9.77.215.32] ([9.77.215.32])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o6SHYoiS013379
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Jul 2010 11:34:51 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100506065747.23879.8338.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065747.23879.8338.sendpatchset@subratamodak.linux.ibm.com>
Date: Wed, 28 Jul 2010 23:04:39 +0530
Message-Id: <1280338481.9598.4.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [07/12 FAILURE] LTPE MEMORY CGROUP FUNCTION tests fails
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
To: Linus Test Project <ltp-list@lists.sourceforge.net>

This is no more reproducible.

Regards--
Subrata

On Thu, 2010-05-06 at 12:27 +0530, Subrata Modak wrote:
> Subject: LTPE MEMORY CGROUP FUNCTION tests fails
> 
> Issues Description Below:
> ==================================
> # vi runtest/memcg_function
> memcg_function          memcg_function_test.sh$PAGESIZE $((PAGESIZE * 2))
> <EOF>
> 
> Run LTP with the following command:
> # ./runltp -f memcg_function
> <<<test_start>>>
> tag=memcg_function stime=1271856934
> cmdline="       memcg_function_test.sh"
> contacts=""
> analysis=exit
> <<<test_output>>>
> memcg_function_test    1  TPASS  :  rss=4096/4096, cache=0/0
> memcg_function_test    2  TPASS  :  rss=0/0, cache=4096/4096
> memcg_function_test    3  TPASS  :  rss=0/0, cache=4096/4096
> memcg_function_test    4  TPASS  :  rss=4096/4096, cache=8192/8192
> memcg_function_test    5  TPASS  :  rss=4096/4096, cache=0/0
> memcg_function_test    6  TPASS  :  rss=4096/4096, cache=0/0
> memcg_function_test    6  TPASS  :  rss=0/0, cache=0/0
> memcg_function_test    7  TPASS  :  rss=0/0, cache=4096/4096
> memcg_function_test    7  TPASS  :  rss=0/0, cache=0/0
> memcg_function_test    8  TPASS  :  rss=0/0, cache=4096/4096
> memcg_function_test    8  TPASS  :  rss=0/0, cache=0/0
> memcg_function_test    9  TFAIL  :  rss=8192/4096, cache=8192/8192
> memcg_function_test    9  TFAIL  :  rss=4096/0, cache=0/0
> memcg_function_test   10  TPASS  :  rss=4096/4096, cache=0/0
> memcg_function_test   10  TPASS  :  rss=0/0, cache=0/0
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 106: 18335 Killed          
>        $TEST_PATH/memcg_process $1 -s $2
> memcg_function_test   11  TPASS  :  failcnt=8
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 106: 18351 Killed          
>        $TEST_PATH/memcg_process $1 -s $2
> memcg_function_test   12  TPASS  :  failcnt=8
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 106: 18367 Killed          
>        $TEST_PATH/memcg_process $1 -s $2
> memcg_function_test   13  TPASS  :  failcnt=8
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 143: 18385 Killed          
>        $TEST_PATH/memcg_process $2 -s $3
> memcg_function_test   14  TPASS  :  process 18385 is killed
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 143: 18398 Killed          
>        $TEST_PATH/memcg_process $2 -s $3
> memcg_function_test   15  TPASS  :  process 18398 is killed
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 143: 18414 Killed          
>        $TEST_PATH/memcg_process $2 -s $3
> memcg_function_test   16  TPASS  :  process 18414 is killed
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 143: 18432 Killed          
>        $TEST_PATH/memcg_process $2 -s $3
> memcg_function_test   17  TPASS  :  process 18432 is killed
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 143: 18450 Killed          
>        $TEST_PATH/memcg_process $2 -s $3
> memcg_function_test   18  TPASS  :  process 18450 is killed
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 143: 18467 Killed          
>        $TEST_PATH/memcg_process $2 -s $3
> memcg_function_test   19  TPASS  :  process 18467 is killed
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 143: 18482 Killed          
>        $TEST_PATH/memcg_process $2 -s $3
> memcg_function_test   20  TPASS  :  process 18482 is killed
> /opt/ltp/testcases/bin/memcg_function_test.sh: line 143: 18495 Killed          
>        $TEST_PATH/memcg_process $2 -s $3
> memcg_function_test   21  TPASS  :  process 18495 is killed
> memcg_function_test   22  TPASS  :  input=4095, limit_in_bytes=4096
> memcg_function_test   23  TPASS  :  input=4097, limit_in_bytes=8192
> memcg_function_test   24  TPASS  :  input=1, limit_in_bytes=4096
> memcg_function_test   25  TPASS  :  return value is 0
> memcg_function_test   26  TPASS  :  return value is 1
> memcg_function_test   27  TPASS  :  return value is 1
> memcg_function_test   28  TPASS  :  return value is 1
> memcg_function_test   29  TPASS  :  force memory succeeded
> memcg_function_test   30  TPASS  :  force memory failed as expected
> memcg_function_test   31  TPASS  :  return value is 0
> memcg_function_test   32  TPASS  :  return value is 0
> memcg_function_test   33  TPASS  :  return value is 0
> memcg_function_test   34  TPASS  :  return value is 0
> memcg_function_test   35  TPASS  :  return value is 1
> memcg_function_test   36  TPASS  :  rss=4096/4096, cache=0/0
> memcg_function_test   36  TPASS  :  rss=0/0, cache=0/0
> memcg_function_test   37  TPASS  :  rss=4096/4096, cache=0/0
> memcg_function_test   37  TPASS  :  rss=0/0, cache=0/0
> memcg_function_test   38  TPASS  :  rss=4096/4096, cache=0/0
> memcg_function_test   38  TPASS  :  rss=0/0, cache=0/0
> <<<execution_status>>>
> initiation_status="ok"
> duration=110 termination_type=exited termination_id=1 corefile=no
> cutime=15 cstime=282
> <<<test_end>>>
> 
> Regards--
> Subrata
> 


------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
