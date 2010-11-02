Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PD51f-0007fB-JK
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 00:46:59 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PD51e-0007pz-AG
	for ltp-list@lists.sourceforge.net; Tue, 02 Nov 2010 00:46:59 +0000
Received: by wya21 with SMTP id 21so6251115wya.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Nov 2010 17:46:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CCF5D84.3040709@cn.fujitsu.com>
References: <4CCE2C37.8050604@cn.fujitsu.com> <4CCF5D84.3040709@cn.fujitsu.com>
Date: Mon, 1 Nov 2010 17:46:52 -0700
Message-ID: <AANLkTi=56XrhzPNKp8wogkbv0_V5O2-C1nbn6zdW2foH@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH]fix a build error.
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
To: Gui Jianfeng <guijianfeng@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Nov 1, 2010 at 5:38 PM, Gui Jianfeng <guijianfeng@cn.fujitsu.com> w=
rote:
> Bian Naimeng wrote:
>> A build error is catched after applied commit da908058635ca58caf3e85814f=
2eba68febad1e1.
>>
>> --------------
>> Fix build error of kernel/syscalls/keyctl category.
>>
>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>
> Hi Garrett,
>
> Seems this patch has been applied, I think you'd better add the
> "Signed-off-by" who posted this patch. ;)
>
> Thanks,
> Gui
>
>>
>> ---
>> =A0testcases/kernel/syscalls/keyctl/keyctl01.c | =A0 =A03 +++
>> =A01 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/keyctl/keyctl01.c b/testcases/ker=
nel/syscalls/keyctl/keyctl01.c
>> index 0d3dc77..b8ab30e 100644
>> --- a/testcases/kernel/syscalls/keyctl/keyctl01.c
>> +++ b/testcases/kernel/syscalls/keyctl/keyctl01.c
>> @@ -38,10 +38,13 @@
>> =A0/* =A0 =A0 =A0 =A0 Manas Kumar Nayak maknayak@in.ibm.com> =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> =A0/********************************************************************=
**********/
>>
>> +#include <sys/types.h>
>> =A0#include <linux/keyctl.h>
>> =A0#include <errno.h>
>> =A0#include <limits.h>
>> =A0#include <stdio.h>
>> +#include <keyutils.h>
>> +
>> =A0/* Harness Specific Include Files. */
>> =A0#include "test.h"
>> =A0#include "usctest.h"

Yes! Full credit goes to Gui, Bian, Subrata, and Tamamori-san for
noting the issue and stupid me for not noticing it sooner :(...

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
