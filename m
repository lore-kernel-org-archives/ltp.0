Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NfRAu-0000k8-1X
	for ltp-list@lists.sourceforge.net; Thu, 11 Feb 2010 05:01:12 +0000
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NfRAr-0002ZN-4U
	for ltp-list@lists.sourceforge.net; Thu, 11 Feb 2010 05:01:11 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp04.in.ibm.com (8.14.3/8.13.1) with ESMTP id o1B50sMJ031500
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 10:30:54 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1B50sDJ2330814
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 10:30:54 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1B50rk0002999
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 16:00:53 +1100
Message-ID: <4B738F05.5060804@linux.vnet.ibm.com>
Date: Thu, 11 Feb 2010 10:30:53 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <000101caaa19$f3feb220$dbfc1660$@co.jp>
	<D9EDA073-FF89-414B-B633-ADF2A5DE5A20@gmail.com>
In-Reply-To: <D9EDA073-FF89-414B-B633-ADF2A5DE5A20@gmail.com>
Subject: Re: [LTP] "check_netns_enabled.c" build failed with "2010-02-10" cvs
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
To: Garrett Cooper <yanegomi@gmail.com>, Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On 02/11/2010 04:55 AM, Garrett Cooper wrote:
> On Feb 9, 2010, at 10:26 PM, Mitani wrote:
>
>    
>> Hi,
>>
>> I tried to build with "2010-02-10" cvs in my systems.
>> I tried in RHEL5.4 (2.6.18-164.el5) and RHEL4.8 (2.6.9-89.ELsmp).
>> But "make" failed in "check_netns_enabled.c" as follows in RHEL4.8:
>> ------------
>> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>> -I/home/LTP/ltp-2010-02-10/testcases/kernel/include
>> -I/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/../libclone
>> -I../../../../include -I../../../../include
>> -L/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/../libclone
>> -L../../../../lib  check_netns_enabled.c   -lltp -o check_netns_enabled
>> check_netns_enabled.c: In function `main':
>> check_netns_enabled.c:40: warning: implicit declaration of function
>> `unshare'
>> /tmp/cciXlXlf.o(.text+0x2c): In function `main':
>> /home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns/check_netns_enabl
>> ed.c:40: undefined reference to `unshare'
>> collect2: ld returned 1 exit status
>> make[4]: *** [check_netns_enabled] Error 1
>> make[4]: Leaving directory
>> `/home/LTP/ltp-2010-02-10/testcases/kernel/containers/netns'
>> ------------
>>
>> "unshare()" function was supported after kernel 2.6.16.
>> Therefore, "make" of "check_netns_enabled.c" failed in RHEL4.8, I think.
>>
>> I made patch and "make" succeeded:
>> ============
>> --- ./testcases/kernel/containers/netns/check_netns_enabled.c   2008-09-19
>> 21:17:10.000000000 +0900
>> +++ ./testcases/kernel/containers/netns/check_netns_enabled.c.new
>> 2010-02-10 14:59:53.000000000 +0900
>> @@ -37,10 +37,12 @@
>>         if (tst_kvercmp(2,6,24)<  0)
>>                 return 1;
>>
>> +#ifdef HAVE_UNSHARE
>>          ret = unshare(flags);
>>         if ( ret<  0 ) {
>>                 printf ("Error:Unshare syscall failed for network
>> namespace\n");
>>                 return 3;
>>         }
>> +#endif
>>         return 0;
>> }
>> ============
>>
>> I'm glad if I could get some opinions.
>>      
> 	Should be fixed now.
>    
Thanks,
Rishi

> -Garrett
> ------------------------------------------------------------------------------
> SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
> Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
> http://p.sf.net/sfu/solaris-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>    


-- 
Thanks&  Regards
Rishi Kesh K Rajak
IBM LTC, Bangalore
LTP Maintainer
Please join IRC: #ltp @ freenode.net


------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
