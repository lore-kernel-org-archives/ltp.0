Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <suzuki@in.ibm.com>) id 1MA3Nv-0002ug-7D
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 14:48:39 +0000
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MA3Nm-0003g8-BH
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 14:48:34 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4TDYNp5014852
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 07:34:23 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4TDYw7L146120
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 07:34:58 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4TDYu3U023852
	for <ltp-list@lists.sourceforge.net>; Fri, 29 May 2009 07:34:58 -0600
Message-ID: <4A1FE470.6090400@in.ibm.com>
Date: Fri, 29 May 2009 19:04:40 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
References: <4A1EC3AC.2080901@in.ibm.com>
	<1243601711.5188.40.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1243601711.5188.40.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------060305010606040302030401"
Subject: Re: [LTP] [RFC] Patch getcpu01 testcase
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, sharyath@in.ibm.com

This is a multi-part message in MIME format.
--------------060305010606040302030401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Subrata,

Good ! Then thats more suitable here :)

Refreshed the patch with TCONF and a better error message.

Thanks

Suzuki
Subrata Modak wrote:
> On Thu, 2009-05-28 at 22:32 +0530, Suzuki Poulose wrote:
>> Hi,
>>
>> The getcpu01 always exits with a non-zero exit code (indicating a 
>> Failure as per UNIX semantics) on non-NUMA machines.
>>
>> This is due to the following code :
>>
>>             tst_resm(TWARN,
>>                     "/sys not mounted or not a numa system. Assuming
>> one 
>> node: %s",
>>                          strerror(errno));
>>
>>
>> Being a non-NUMA machine is not a failure, but an info. So it should
>> not 
>> cause the test to have a non zero exit status.
> 
> Correct,
> 
>> I have attached a patch which could do the same and provide a more 
>> friendly o/p.
>>
>>
>> Please apply.
>>
>> Thanks
>> Suzuki
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>>
>> plain text
>> document
>> attachment
>> (fix-warning-getcpu01.diff)
>>
>>
>> Index: ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c
>> ===================================================================
>> ---
>> ltp-20081031.orig/testcases/kernel/syscalls/getcpu/getcpu01.c       2008-10-23 02:23:19.000000000 -0500
>> +++
>> ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c    2009-05-28
>> 11:52:54.000000000 -0500
>> @@ -47,6 +47,8 @@
>>   * HISTORY
>>   *     06/2008 written by Sharyathi Nagesh <sharyathi@in.ibm.com>
>>   *
>> + *     05/2009         Suzuki K P <suzuki@in.ibm.com>
>> + *                     Friendly messages for non-NUMA machines.
>>   * RESTRICTIONS
>>   *     none
>>   */
>> @@ -234,8 +236,10 @@
>>
>>          directory_parent = opendir("/sys/devices/system/node");
>>          if (!directory_parent)  {
>> -                tst_resm(TWARN,
>> -                   "/sys not mounted or not a numa system. Assuming
>> one node: %s",
>> +                tst_resm(TINFO,
>> +                        "/sys not mounted or not a numa system.
>> Assuming one node");
>> +               tst_resm(TINFO,
> 
> Use TCONF instead of TINFO. That reflects that some system configuration
> was missing, and, it will not return error value at all.
> 
> Regards--
> Subrata
> 
>> +                       "Reason /sys/devices/system/node :%s",
>>                          strerror(errno));
>>                         return 0; //By Default assume it to belong to
>> node Zero 
>>          } else {
>>
> 


--------------060305010606040302030401
Content-Type: text/plain;
 name="fix-warning-getcpu01.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-warning-getcpu01.diff"

Index: ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c
===================================================================
--- ltp-20081031.orig/testcases/kernel/syscalls/getcpu/getcpu01.c	2008-10-23 02:23:19.000000000 -0500
+++ ltp-20081031/testcases/kernel/syscalls/getcpu/getcpu01.c	2009-05-29 08:33:01.000000000 -0500
@@ -47,6 +47,9 @@
  * HISTORY
  *	06/2008 written by Sharyathi Nagesh <sharyathi@in.ibm.com>
  *
+ *	05/2009 	Suzuki K P <suzuki@in.ibm.com>
+ *			Use TCONF instead of TWARN for non-NUMA machines
+ *	
  * RESTRICTIONS
  *	none
  */
@@ -234,8 +237,10 @@
 
         directory_parent = opendir("/sys/devices/system/node");
         if (!directory_parent)  {
-                tst_resm(TWARN,
-                   "/sys not mounted or not a numa system. Assuming one node: %s",
+                tst_resm(TCONF,
+                   "/sys not mounted or not a numa system. Assuming one node");
+		tst_resm(TCONF,
+			"Error opening: /sys/devices/system/node :%s",
                         strerror(errno));
                	return 0; //By Default assume it to belong to node Zero 
         } else {

--------------060305010606040302030401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
--------------060305010606040302030401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------060305010606040302030401--

