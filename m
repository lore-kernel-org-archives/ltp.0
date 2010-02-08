Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NeQZJ-0001od-9I
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 10:10:13 +0000
Received: from mail-pz0-f183.google.com ([209.85.222.183])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NeQZI-0006bk-As
	for ltp-list@lists.sourceforge.net; Mon, 08 Feb 2010 10:10:13 +0000
Received: by pzk13 with SMTP id 13so4022210pzk.24
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Feb 2010 02:10:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B6FAA76.6000505@linux.vnet.ibm.com>
References: <4B6FA8F0.6050504@cn.fujitsu.com>
	<4B6FAA76.6000505@linux.vnet.ibm.com>
Date: Mon, 8 Feb 2010 02:10:05 -0800
Message-ID: <364299f41002080210l5c2f80dvab5b860d7cb6ecc4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Rishikesh <risrajak@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Sun, Feb 7, 2010 at 10:08 PM, Rishikesh <risrajak@linux.vnet.ibm.com> wr=
ote:
> On 02/08/2010 11:32 AM, Shi Weihua wrote:
>> An error occured on my i386 box.
>> =A0 (OS: Fedora8, Kernel: 2.6.33-rc6, libcap: libcap-2.16)
>> -------------
>> exec_without_inh =A0 =A01 =A0TFAIL =A0: =A0Failed to drop CAP_SYS_ADMIN =
from bounding set.
>> exec_without_inh =A0 =A00 =A0TINFO =A0: =A0(ret=3D-1, errno 38)
>> -------------
>> If the macro HAVE_DECL_CAP_BSET_DROP is 0, this error will occurs.
>> But the program should to be broken when f !=3D CAP_SET, like the simila=
r code
>> "if (ret || f !=3D CAP_SET) {" in exec_with_inh.c.
>>
>> The TBROK message will be outputted if my patch merged.
>> -------------
>> exec_without_inh =A0 =A01 =A0TBROK =A0: =A0Failed to add CAP_SYS_ADMIN t=
o pI
>>
> Looks good. I will include if others are not having any comment.
>
> Acked-by: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
>
> Thanks
> Rishi
>
>> -------------
>>
>> Signed-off-by: Shi Weihua<shiwh@cn.fujitsu.com>
>> ---
>> --- testcases/kernel/security/cap_bound/exec_without_inh.c.orig =A0 =A0 =
=A0 2010-02-08 11:54:22.000000000 -0500
>> +++ testcases/kernel/security/cap_bound/exec_without_inh.c =A0 =A02010-0=
2-08 11:55:00.000000000 -0500
>> @@ -80,6 +80,11 @@ int main(int argc, char *argv[])
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>> + =A0 =A0 else if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "Failed to add CAP_SYS_ADMIN t=
o pI\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
>> + =A0 =A0 }
>> +
>> =A0 #if HAVE_DECL_CAP_FREE
>> =A0 =A0 =A0 cap_free(cur);
>> =A0 #endif

Wow -- I really made a mess of that test a few months back... please do...

       else if (ret) {
               tst_brkm(TBROK | TERRNO, tst_exit, "Failed to add
CAP_SYS_ADMIN to pI");
       }

... instead.
Thanks for catching that one failure point ;)...!
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
