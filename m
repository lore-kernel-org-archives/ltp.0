Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSpt7-0003Zs-GG
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 10:46:45 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSpt6-00059T-N7
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 10:46:45 +0000
Received: by pzk31 with SMTP id 31so10810329pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Jan 2010 02:46:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B3AE366.9020300@cn.fujitsu.com>
References: <4B388C81.80903@linux.vnet.ibm.com>
	<4B39C9F4.1030708@cn.fujitsu.com>
	<4B3AD054.5090608@linux.vnet.ibm.com>
	<4B3AE366.9020300@cn.fujitsu.com>
Date: Thu, 7 Jan 2010 02:46:39 -0800
Message-ID: <364299f41001070246u519467c2h3dc8dcc018760be7@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/2] Added check for memory controller (
	functional, regression & stress )
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
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: risrajak@in.ibm.com, LTP <ltp-list@lists.sourceforge.net>, iranna.ankad@in.ibm.com

On Tue, Dec 29, 2009 at 9:21 PM, Li Zefan <lizf@cn.fujitsu.com> wrote:
> Rishikesh wrote:
>> On 12/29/2009 02:50 PM, Li Zefan wrote:
>>>> commit fe4599d210be37a7d1bb2d6a5523b9e29bbd87e1
>>>> Author: Rishikesh K Rajak<rishikesh@rishikesh.in.ibm.com>
>>>> Date: =A0 Mon Dec 28 15:11:54 2009 +0530
>>>>
>>>> =A0 =A0 =A0Added check for regression and funcitonal memcg test
>>>>
>>>>
>>> You should add your Signed-off-by.
>>>
>>
>> Sending a fresh patch with signed-off added. Also combined both the
>> patches in one & ported to latest intermediate ltp release.
>>
>
> Acked-by: Li Zefan <lizf@cn.fujitsu.com>

    These checks are wrong for positive cases. Please do something
like the following (I committed it to the regression script as an
example):

! if [ ! "grep -w memory /proc/cgroups | cut -f4" =3D=3D "1" ]
 then
!         echo "WARNING:";
!         echo "Either Kernel does not support for memory resource
controller or feature not enabled";
!         echo "Skipping all memcgroup testcases....";
         exit 0
 fi
--- 31,43 ----
 export TST_COUNT=3D1

! if [ "$(id -ru)" !=3D 0 ]; then
       tst_brkm TBROK ignored "Test must be run as root"
       exit 0
 fi

! if [ "$(grep -w memory /proc/cgroups | cut -f4)" !=3D "1" ]
 then
!       tst_resm TCONF "Either memory resource controller kernel support ab=
sent"
!       tst_resm TCONF "or feature is not enabled; skipping all
memcgroup testcases."
         exit 0
 fi

    Please ignore the id -ru noise.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
