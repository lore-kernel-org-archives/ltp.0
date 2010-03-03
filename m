Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NmkjI-0000B4-VV
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:18:56 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmkjI-0003X5-2L
	for ltp-list@lists.sourceforge.net; Wed, 03 Mar 2010 09:18:56 +0000
Received: by pvf33 with SMTP id 33so327259pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 03 Mar 2010 01:18:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100303070342.GB19084@linux.vnet.ibm.com>
References: <f5a7b3811002250545x3d5288cfqd114d3bcd79581f2@mail.gmail.com>
	<20100302085046.GA27023@linux.vnet.ibm.com>
	<f5a7b3811003020708wdd0710fv4c3e1dcf1992935c@mail.gmail.com>
	<20100303045624.GB10185@linux.vnet.ibm.com>
	<f5a7b3811003022200r32a0e108g8eaf5d9a2ce66b4a@mail.gmail.com>
	<20100303070342.GB19084@linux.vnet.ibm.com>
Date: Wed, 3 Mar 2010 01:18:50 -0800
Message-ID: <364299f41003030118x6136dda6u7017054febea4b96@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: naresh kamboju <naresh.kernel@gmail.com>, ltp-list@lists.sourceforge.net

Uh, hold on a sec before we call it good...

On Tue, Mar 2, 2010 at 11:03 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Wed, Mar 03, 2010 at 11:30:42AM +0530, naresh kamboju wrote:
>> On Wed, Mar 3, 2010 at 10:26 AM, Rishikesh K Rajak
>> <risrajak@linux.vnet.ibm.com> wrote:
>> > On Tue, Mar 02, 2010 at 08:38:20PM +0530, naresh kamboju wrote:
>> >> On Tue, Mar 2, 2010 at 2:20 PM, Rishikesh K Rajak
>> >> <risrajak@linux.vnet.ibm.com> wrote:
>> >> > I feel before getting semaphore value, we need to sync first so here
>> >> > sleep is require,though your point is valid that there is no use of
>> >> > using sleep inside while loop.
>> >> I agree with you.
>> >> AFAIU, we should call sleep() before calling getting semaphore
>> >> value.when we don't have while loop here. Because while loop condition
>> >> is depends on val so when ever we call sem_getvalue() it will get
>> >> latest value of val.
>> >> In addition to this, we are ensuring val is decremented before we do
>> >> unlock the sem by while loop condition.
>> >>
>> >> Having sleep() in while loop will not effect the final output. IIUC
>> >>
>> >
>> > Hi Naresh,
>> >
>> > I am not able to apply your patch against ltp next branch. can you
>> > please send me patch against next branch of ltp ?
>> Here I have posted and attached to this e-mail.
>
>
> Apllied to next branch . Thanks for your patch, i will test in
> production environment, if it is not creating any regression will merge
> with master branch and it will available to next month release.
>
> Thanks
> -Rishi
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>>
>> ---
>> =A0testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
>> | =A0 15 =A0 =A0 =A0 =A08 + =A0 =A0 7 - =A0 =A0 0 !
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
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 fprintf(stderr, "P: child_1:%d forked\n", c_1);
>>
>> - =A0 =A0 sleep(1);
>> =A0 =A0 =A0 c_2 =3D fork();
>> =A0 =A0 =A0 if (c_2 =3D=3D 0)
>> =A0 =A0 =A0 {
>> @@ -176,13 +175,13 @@ int main()
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 fprintf(stderr, "P: child_2: %d forked\n", c_2);
>>
>> + =A0 =A0 =A0 =A0/* Step 3 Implementation */
>> =A0 =A0 =A0 /* Make sure the two children has been waiting */
>> - =A0 =A0 /*do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 sleep(1);
>> + =A0 =A0 do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sem_getvalue(sem_1, &val);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 //printf("val =3D %d\n", val);
>> =A0 =A0 =A0 } while (val !=3D 1);
>> - =A0 =A0 */

Please provide another patch with a limit to this -- I get annoyed
with tests that have infinite loops in them because the underlying
functionality is broken. Some architectures like mips* will
potentially be affected by this depending on how buggy their
implementation of POSIX semaphores is (this was definitely a problem
with my previous group and certain semctl calls being made on Cavium
hardware with our version of glibc / linux kernel).

>> +
>> =A0 =A0 =A0 c_3 =3D fork();
>> =A0 =A0 =A0 if (c_3 =3D=3D 0)
>> =A0 =A0 =A0 {
>> @@ -191,13 +190,15 @@ int main()
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 fprintf(stderr, "P: child_3: %d forked\n", c_3);
>>
>> + =A0 =A0 =A0 =A0/* Step 3 Implementation */
>> =A0 =A0 =A0 /* Make sure child 3 has been waiting for the lock */
>> - =A0 =A0 /*do {
>> - =A0 =A0 =A0 =A0 =A0 =A0 sleep(1);
>> + =A0 =A0 do {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sem_getvalue(sem_1, &val);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 //printf("val =3D %d\n", val);
>> =A0 =A0 =A0 } while (val !=3D 0);
>> - =A0 =A0 */
>> +

Same as above.

>> + =A0 =A0 /* Synchronization required before release the lock */
>> + =A0 =A0 sleep(1);
>> =A0 =A0 =A0 /* Ok, let's release the lock */
>> =A0 =A0 =A0 fprintf(stderr, "P: release lock\n");
>> =A0 =A0 =A0 sem_post(sem);

Thanks,
-Garrett

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
