Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1Nefi9-0004aA-1V
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 02:20:21 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nefi6-0001ZF-8G
	for ltp-list@lists.sourceforge.net; Tue, 09 Feb 2010 02:20:20 +0000
Message-ID: <4B70C64D.20905@cn.fujitsu.com>
Date: Tue, 09 Feb 2010 10:19:57 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
References: <4B6FA8F0.6050504@cn.fujitsu.com>	
	<4B6FAA76.6000505@linux.vnet.ibm.com>
	<364299f41002080210l5c2f80dvab5b860d7cb6ecc4@mail.gmail.com>
In-Reply-To: <364299f41002080210l5c2f80dvab5b860d7cb6ecc4@mail.gmail.com>
Subject: Re: [LTP] [PATCH] cap_bound: should to TBROK if f != CAP_SET in
 exec_without_inh.c
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

at 2010-2-8 18:10, Garrett Cooper wrote:
> On Sun, Feb 7, 2010 at 10:08 PM, Rishikesh <risrajak@linux.vnet.ibm.com> wrote:
>> On 02/08/2010 11:32 AM, Shi Weihua wrote:
>>> An error occured on my i386 box.
>>>   (OS: Fedora8, Kernel: 2.6.33-rc6, libcap: libcap-2.16)
>>> -------------
>>> exec_without_inh    1  TFAIL  :  Failed to drop CAP_SYS_ADMIN from bounding set.
>>> exec_without_inh    0  TINFO  :  (ret=-1, errno 38)
>>> -------------
>>> If the macro HAVE_DECL_CAP_BSET_DROP is 0, this error will occurs.
>>> But the program should to be broken when f != CAP_SET, like the similar code
>>> "if (ret || f != CAP_SET) {" in exec_with_inh.c.
>>>
>>> The TBROK message will be outputted if my patch merged.
>>> -------------
>>> exec_without_inh    1  TBROK  :  Failed to add CAP_SYS_ADMIN to pI
>>>
>> Looks good. I will include if others are not having any comment.
>>
>> Acked-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
>>
>> Thanks
>> Rishi
>>
>>> -------------
>>>
>>> Signed-off-by: Shi Weihua<shiwh@cn.fujitsu.com>
>>> ---
>>> --- testcases/kernel/security/cap_bound/exec_without_inh.c.orig       2010-02-08 11:54:22.000000000 -0500
>>> +++ testcases/kernel/security/cap_bound/exec_without_inh.c    2010-02-08 11:55:00.000000000 -0500
>>> @@ -80,6 +80,11 @@ int main(int argc, char *argv[])
>>>                       tst_exit();
>>>               }
>>>       }
>>> +     else if (ret) {
>>> +             tst_resm(TBROK, "Failed to add CAP_SYS_ADMIN to pI\n");
>>> +             tst_exit();
>>> +     }
>>> +
>>>   #if HAVE_DECL_CAP_FREE
>>>       cap_free(cur);
>>>   #endif
> 
> Wow -- I really made a mess of that test a few months back... please do...
> 
>        else if (ret) {
>                tst_brkm(TBROK | TERRNO, tst_exit, "Failed to add
> CAP_SYS_ADMIN to pI");
>        }
> 
> ... instead.

ok. I fixed it based on your advice.

Signed-off-by: Shi Weihua<shiwh@cn.fujitsu.com>
---
--- testcases/kernel/security/cap_bound/exec_without_inh.c.orig	2010-02-08 11:54:22.000000000 -0500
+++ testcases/kernel/security/cap_bound/exec_without_inh.c	2010-02-09 10:11:15.000000000 -0500
@@ -80,6 +80,10 @@ int main(int argc, char *argv[])
 			tst_exit();
 		}
 	}
+	else if (ret) {
+		tst_brkm(TBROK | TERRNO, tst_exit, "Failed to add \
+			CAP_SYS_ADMIN to pI");
+	}
 #if HAVE_DECL_CAP_FREE
 	cap_free(cur);
 #endif

> Thanks for catching that one failure point ;)...!
> -Garrett
> 
> 

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
