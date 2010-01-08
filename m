Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <veeren@linux.vnet.ibm.com>) id 1NT7Vy-0005oM-1x
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 05:36:02 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NT7Vs-0006pQ-C3
	for ltp-list@lists.sourceforge.net; Fri, 08 Jan 2010 05:36:01 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o085ScYa030613
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 22:28:38 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o085ZZWm146338
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 22:35:35 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o085ZYOm007072
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 22:35:34 -0700
Message-ID: <4B46C422.7040303@linux.vnet.ibm.com>
Date: Fri, 08 Jan 2010 11:05:30 +0530
From: Veerendra C <veeren@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4B458B0A.9040304@linux.vnet.ibm.com>
	<1262864218.12213.38.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1262864218.12213.38.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] capset01 patch
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi Subrata

Including my signature as requested

Signed-off-by: Veerendra C<vechandr@in.ibm.com>


Thanks
Veerendra C

Subrata Modak wrote:
> Can you please Sign-Off this match with your Signature ?
>
> Regards--
> Subrata
>
> On Thu, 2010-01-07 at 12:49 +0530, Veerendra C wrote: 
>   
>> Hi
>>  Here is a patch/attachment to fix the  error number and error message , 
>> when the capset() syscall fails.
>>
>>
>> *After applying patch:*
>> capset01    1    TBROK    capget() failed: errno=???(38): Function not 
>> implemented
>>
>> *Before applying patch:*
>> capset01    1    TBROK    capget() failed: TEST_ERRNO=???(0): Success
>>
>>
>> Note: This is in the custom built linux kernel where the capset/capget 
>> syscall is not implemented. In normal linux kernel this testcase would 
>> just work fine without any errors.
>> *
>> Normal kernel:*
>> capset01    1  TPASS  :  capset() returned 0
>>
>>
>> Regards
>> Veerendra C
>>
>> plain text document attachment (capset01.patch)
>> --- testcases/kernel/syscalls/capset.orig/capset01.c	2010-01-06 13:29:07.000000000 +0530
>> +++ testcases/kernel/syscalls/capset/capset01.c	2010-01-06 13:50:12.000000000 +0530
>> @@ -89,6 +89,7 @@ static void cleanup();
>>  char *TCID = "capset01";	/* Test program identifier.    */
>>  int TST_TOTAL = 1;		/* Total number of test cases. */
>>  extern int Tst_count;		/* Test Case counter for tst_* routines */
>> +static int exp_enos[] = { EFAULT, EINVAL, EPERM, 0 };
>>
>>  static struct __user_cap_header_struct header;	/* cap_user_header_t is a pointer
>>  						   to __user_cap_header_struct */
>> @@ -143,6 +144,9 @@ void setup()
>>  	/* capture signals */
>>  	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>>
>> +        /* Set up the expected error numbers for -e option */
>> +        TEST_EXP_ENOS(exp_enos);
>> +
>>  	/* Pause if that option was specified */
>>  	TEST_PAUSE;
>>
>>
>> ------------------------------------------------------------------------------
>> This SF.Net email is sponsored by the Verizon Developer Community
>> Take advantage of Verizon's best-in-class app development support
>> A streamlined, 14 day to market process makes app distribution fast and easy
>> Join now and get one step closer to millions of Verizon customers
>> http://p.sf.net/sfu/verizon-dev2dev 
>> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list
>>     
>
>   



------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
