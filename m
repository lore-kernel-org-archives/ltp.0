Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1NmTi0-0000Mj-2h
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 15:08:28 +0000
Received: from mail-px0-f203.google.com ([209.85.216.203])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmThz-0004me-7n
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 15:08:28 +0000
Received: by pxi41 with SMTP id 41so106388pxi.23
	for <ltp-list@lists.sourceforge.net>;
	Tue, 02 Mar 2010 07:08:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100302085046.GA27023@linux.vnet.ibm.com>
References: <f5a7b3811002250545x3d5288cfqd114d3bcd79581f2@mail.gmail.com>
	<20100302085046.GA27023@linux.vnet.ibm.com>
Date: Tue, 2 Mar 2010 20:38:20 +0530
Message-ID: <f5a7b3811003020708wdd0710fv4c3e1dcf1992935c@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [PATCH] Synchronization required before release the lock:
	sem_post/8-1.c
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, linux-kernel@vger.kernel.org

On Tue, Mar 2, 2010 at 2:20 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Thu, Feb 25, 2010 at 07:15:42PM +0530, naresh kamboju wrote:
>> Hi,
>>
>> I have found abnormal behavior of sem_post/8-1.c test case under posix.
>> This test case passes in some times and failed in many times :-(
>> Patch includes
>> 1. =A0 =A0Reverting back changes made by mreed on Sep 25 2006. Making su=
re
>> child has been waiting for the lock (below Refs).
>> 2. =A0 =A0using sleep in while loop is not a good idea, so sleep is remo=
ved
>> from while loop
>> 3. =A0 =A0For the synchronization I have added sleep before releasing th=
e lock.
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
> Looks good to me though i needed few clarification below.
>
> Acked-By: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
>
>> ---
>> =A0testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
>> | =A0 15 =A0 =A08 + =A0 =A0 7 - =A0 =A0 0 !
>> =A01 file changed, 8 insertions(+), 7 deletions(-)
>>
>> Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/=
8-1.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1=
.c
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1=
.c
>> @@ -161,7 +161,6 @@ int main()
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 fprintf(stderr, "P: child_1:%d forked\n", c_1);
>>
>> - =A0 =A0 =A0 sleep(1);
>> =A0 =A0 =A0 =A0 c_2 =3D fork();
>> =A0 =A0 =A0 =A0 if (c_2 =3D=3D 0)
>> =A0 =A0 =A0 =A0 {
>> @@ -176,13 +175,13 @@ int main()
>> =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 =A0 fprintf(stderr, "P: child_2: %d forked\n", c_2);
>>
>> + =A0 =A0 =A0 =A0/* Step 3 Implementation */
>> =A0 =A0 =A0 =A0 /* Make sure the two children has been waiting */
>> - =A0 =A0 =A0 /*do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sleep(1);
> I feel before getting semaphore value, we need to sync first so here
> sleep is require,though your point is valid that there is no use of
> using sleep inside while loop.
I agree with you.
AFAIU, we should call sleep() before calling getting semaphore
value.when we don't have while loop here. Because while loop condition
is depends on val so when ever we call sem_getvalue() it will get
latest value of val.
In addition to this, we are ensuring val is decremented before we do
unlock the sem by while loop condition.

Having sleep() in while loop will not effect the final output. IIUC

Best regards,
Naresh Kamboju
>> Please review this patch and let me know if you have any issues.
>>
>> Best regards
>> Naresh Kamboju
> --
> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
