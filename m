Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1NtjQK-0002M7-KR
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 15:20:12 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NtjQJ-00027z-FB
	for ltp-list@lists.sourceforge.net; Mon, 22 Mar 2010 15:20:12 +0000
Received: by pwi2 with SMTP id 2so218165pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Mar 2010 08:20:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100322082528.GF20606@linux.vnet.ibm.com>
References: <f5a7b3811003022200r32a0e108g8eaf5d9a2ce66b4a@mail.gmail.com>
	<364299f41003030118x6136dda6u7017054febea4b96@mail.gmail.com>
	<20100303094541.GB23601@linux.vnet.ibm.com>
	<f5a7b3811003030333n4b0b4045sff5795d99cd7da00@mail.gmail.com>
	<364299f41003030342m7bf4a44ey897b7d2ca365a318@mail.gmail.com>
	<f5a7b3811003030349s2d279fcdx8b74cff2e3a875ab@mail.gmail.com>
	<364299f41003030355y5a921691vdde6baafbe8439cd@mail.gmail.com>
	<f5a7b3811003030545l30efa927tb377f113da30a0bd@mail.gmail.com>
	<f5a7b3811003080257n43d1af67o2942f4d8de2dc5b1@mail.gmail.com>
	<20100322082528.GF20606@linux.vnet.ibm.com>
Date: Mon, 22 Mar 2010 20:50:04 +0530
Message-ID: <f5a7b3811003220820u1fcd7784v13f771e4445d2c59@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd292884850680482653b52
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

--000e0cd292884850680482653b52
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 22, 2010 at 1:55 PM, Rishikesh K Rajak
<risrajak@linux.vnet.ibm.com> wrote:
> On Mon, Mar 08, 2010 at 04:27:36PM +0530, naresh kamboju wrote:
>> Hi Rishi and Garrett,
>>
>> On Wed, Mar 3, 2010 at 7:15 PM, naresh kamboju <naresh.kernel@gmail.com>=
 wrote:
>> > On Wed, Mar 3, 2010 at 5:25 PM, Garrett Cooper <yanegomi@gmail.com> wr=
ote:
>> >> On Wed, Mar 3, 2010 at 3:49 AM, naresh kamboju <naresh.kernel@gmail.c=
om> wrote:
>> >>> On Wed, Mar 3, 2010 at 5:12 PM, Garrett Cooper <yanegomi@gmail.com> =
wrote:
>> >>>> On Wed, Mar 3, 2010 at 3:33 AM, naresh kamboju <naresh.kernel@gmail=
.com> wrote:
>> >>>>> On Wed, Mar 3, 2010 at 3:15 PM, Rishikesh K Rajak
>> >>>>> <risrajak@linux.vnet.ibm.com> wrote:
>> >>>>>> On Wed, Mar 03, 2010 at 01:18:50AM -0800, Garrett Cooper wrote:
>> >>>>>>> Uh, hold on a sec before we call it good...
>> >>>>>>
>> >>>>>> oh ok, holiding on for bit.
>> >>>>>>
>> >>>>>> Naresh, can you please send a patch with incorporating garret's c=
omment
>> >>>>>> ?
>> >>>>>>>>> + =A0 =A0 =A0 =A0/* Step 3 Implementation */
>> >>>>>>>>> =A0 =A0 =A0 /* Make sure the two children has been waiting */
>> >>>>>>>>> - =A0 =A0 /*do {
>> >>>>>>>>> - =A0 =A0 =A0 =A0 =A0 =A0 sleep(1);
>> >>>>>>>>> + =A0 =A0 do {
>> >>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sem_getvalue(sem_1, &val);
>> >>>>>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 //printf("val =3D %d\n", val);
>> >>>>>>>>> =A0 =A0 =A0 } while (val !=3D 1);
>> >>>>>>>>> - =A0 =A0 */
>> >>>>>>>
>> >>>>>>> Please provide another patch with a limit to this --
>> >>>>>
>> >>>>> Garrett,
>> >>>>>
>> >>>>> When sem_wait is called 'val' value will be decremented by one.
>> >>>>> To ensure that sem_wait is called, we are checking 'val' value by
>> >>>>> calling sem_getvalue(). in this case we don=92t need to decrement =
the
>> >>>>> values by --. IIUC.
>> >>>>> (snip)
>> >>>>> OTOH,
>> >>>>>>> I get annoyed
>> >>>>>>> with tests that have infinite loops in them because the underlyi=
ng
>> >>>>>>> functionality is broken.
>> >>>>> I agree with you, having infinite loops in test case is not a good=
.
>> >>>>> However, in this patch while loop is not infinite loop. It is a
>> >>>>> conditional loop with finite value.
>> >>>>>
>> >>>>> Please let me know if you have any issues.
>> >>>>
>> >>>> =A0 =A0The problem was that it wasn't failing properly as stated in=
 the
>> >>>> manpage on mips* (was decrementing past 0) and it was blocking
>> >>>> indefinitely. Hence I had to yank those tests from the default run.
>> >>> do you mean, after applying above patch you have noticed these kind =
of behavior?
>> >>
>> >> Not with this patch; I've seen this kind of behavior in general under
>> >> odd conditions with my former team's embedded setup running tests wit=
h
>> >> POSIX semaphores, so I don't doubt that others could run into the
>> >> similar functional issues given the right conditions.
>> >
>> > Hey Garrett,
>> >
>> > Thanks for you information :-)
>> >
>> > I have tested these on MIPS architecture and =A0reproduced infinite
>> > waiting situation after applying this patch. (with strace no issue
>> > found ex: #strace ./8-1.test)
>> > As you said there may be issues in MIPS-POSIX library. it may take
>> > some time to fix these issues or may not be fixed.
>> > However, I=92ll discuss this issue with MIPS folks in different thread=
.
>> >
>> > ATM, my patch is not a good idea for MIPS architectures.
>> > So, after your comments I have modified my patch and tested.
>> > Here in this latest patch i did not change any thing regarding while l=
oop.
>> > I replaced sleep() in an appropriate place.
>> > It is working fine on X86, ARM and MIPS.
>>
>> please review the patch.
>> I have tested this patch on X86, ARM and MIPS and results are good.
>>
>> If you feel ok. please commit. otherwise give me your comments.
>
> Hi Naresh,
>
Hi Rishi,
> can you send your patch against today's git ?

please find the patch below and attached to this e-mail.
Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

---
 testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
|    2 	1 +	1 -	0 !
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1=
.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.c
@@ -161,7 +161,6 @@ int main()
 	}
 	fprintf(stderr, "P: child_1:%d forked\n", c_1);
 =09
-	sleep(1);
 	c_2 =3D fork();
 	if (c_2 =3D=3D 0)
 	{
@@ -198,6 +197,7 @@ int main()
 		//printf("val =3D %d\n", val);
 	} while (val !=3D 0);
 	*/
+	sleep(1);
 	/* Ok, let's release the lock */
 	fprintf(stderr, "P: release lock\n");
 	sem_post(sem);


Best regards
Naresh Kamboju
>
> -Rishi
>>
>> Best regards
>> Naresh Kamboju
>> >
>> > Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>> > ---
>> > =A0testcases/open_posix_testsuite/conformance/interfaces/sem_post/8-1.=
c
>> > | =A0 =A02 =A01 + =A0 =A0 1 - =A0 =A0 0 !
>> > =A01 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > Index: b/testcases/open_posix_testsuite/conformance/interfaces/sem_pos=
t/8-1.c
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- a/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8=
-1.c
>> > +++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_post/8=
-1.c
>> > @@ -161,7 +161,6 @@ int main()
>> > =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0fprintf(stderr, "P: child_1:%d forked\n", c_1);
>> >
>> > - =A0 =A0 =A0 sleep(1);
>> > =A0 =A0 =A0 =A0c_2 =3D fork();
>> > =A0 =A0 =A0 =A0if (c_2 =3D=3D 0)
>> > =A0 =A0 =A0 =A0{
>> > @@ -198,6 +197,7 @@ int main()
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0//printf("val =3D %d\n", val);
>> > =A0 =A0 =A0 =A0} while (val !=3D 0);
>> > =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 sleep(1);
>> > =A0 =A0 =A0 =A0/* Ok, let's release the lock */
>> > =A0 =A0 =A0 =A0fprintf(stderr, "P: release lock\n");
>> > =A0 =A0 =A0 =A0sem_post(sem);
>> >
>> >
>> > please let me know if you have any issues.
>> >
>> > Best regards,
>> > Naresh Kamboju
>> >> Thanks,
>> >> -Garrett
>> >>
>> >
>
>
>
> --
> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net
>

--000e0cd292884850680482653b52
Content-Type: application/octet-stream; name="sem-post-unstable-8-1-fix.patch"
Content-Disposition: attachment; filename="sem-post-unstable-8-1-fix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g73f9hip0

LS0tDQogdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFj
ZXMvc2VtX3Bvc3QvOC0xLmMgfCAgICAyIAkxICsJMSAtCTAgIQ0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpJbmRleDogYi90ZXN0Y2FzZXMvb3Blbl9w
b3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zZW1fcG9zdC84LTEuYw0KPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KLS0tIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNl
L2ludGVyZmFjZXMvc2VtX3Bvc3QvOC0xLmMNCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rl
c3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL3NlbV9wb3N0LzgtMS5jDQpAQCAtMTYxLDcg
KzE2MSw2IEBAIGludCBtYWluKCkgDQogCX0NCiAJZnByaW50ZihzdGRlcnIsICJQOiBjaGlsZF8x
OiVkIGZvcmtlZFxuIiwgY18xKTsNCiAJDQotCXNsZWVwKDEpOw0KIAljXzIgPSBmb3JrKCk7DQog
CWlmIChjXzIgPT0gMCkNCiAJew0KQEAgLTE5OCw2ICsxOTcsNyBAQCBpbnQgbWFpbigpIA0KIAkJ
Ly9wcmludGYoInZhbCA9ICVkXG4iLCB2YWwpOw0KIAl9IHdoaWxlICh2YWwgIT0gMCk7DQogCSov
DQorCXNsZWVwKDEpOw0KIAkvKiBPaywgbGV0J3MgcmVsZWFzZSB0aGUgbG9jayAqLw0KIAlmcHJp
bnRmKHN0ZGVyciwgIlA6IHJlbGVhc2UgbG9ja1xuIik7DQogCXNlbV9wb3N0KHNlbSk7DQo=
--000e0cd292884850680482653b52
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--000e0cd292884850680482653b52
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd292884850680482653b52--

