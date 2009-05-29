Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MA3rY-0001ok-Ub
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 15:19:16 +0000
Received: from yx-out-1718.google.com ([74.125.44.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MA3rU-0003Kt-Sd
	for ltp-list@lists.sourceforge.net; Fri, 29 May 2009 15:19:16 +0000
Received: by yx-out-1718.google.com with SMTP id 6so2953946yxn.82
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 May 2009 08:19:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1243601702.5188.38.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810905280814gad8b6a4h9c161af8d58a739d@mail.gmail.com>
	<1243601702.5188.38.camel@subratamodak.linux.ibm.com>
Date: Fri, 29 May 2009 20:49:11 +0530
Message-ID: <f5a7b3810905290819j2eff2629kfda4e11cd4766427@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f0c803d6e8b046b0e991e
Subject: Re: [LTP] open posix sigaction/10-1.c test fix
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
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>

--001e680f0c803d6e8b046b0e991e
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Subrata,

Here i have attached patch file sigaction_10-1.patch.
i am able to patch this by using the command
as
#pwd
/home/naresh/ltp
ltp#patch -p1<  /patch/sigaction_10-1.patch
ltp#

I come across with this kernel issue in 2.6.27
http://lkml.org/lkml/2008/9/23/218
http://lkml.org/lkml/2008/9/23/228
http://lkml.org/lkml/2008/9/24/180
http://lkml.org/lkml/2008/9/24/186
http://lkml.org/lkml/2008/9/24/193
http://lkml.org/lkml/2008/9/24/243
http://lkml.org/lkml/2008/9/24/247


Test cases modification noticed for
ltp/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
I have modified patch and submitting fix patch.
This test case is passed now.

Previous log:

-bash-3.2# pwd
/tmp/open_posix_testsuite/conformance/interfaces/sigaction
-bash-3.2# ./10-1.test
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
--> Sending SIGSTOP
--> Sending SIGCONT
Test FAILED
-bash-3.2#


Current log:
-bash-3.2# pwd
/tmp/open_posix_testsuite/conformance/interfaces/sigaction
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
--> Sending SIGSTOP
Child has been stopped
--> Sending SIGCONT
Child has been continued
Test PASSED
-bash-3.2#


Original changes done by Oleg Nesterov and Joe Korty
Modified by: Naresh Kamboju
 < naresh.kernel@gmail.com >

Signed-off-by: Naresh Kamboju
< naresh.kernel@gmail.com >

Regards
Naresh

On Fri, May 29, 2009 at 6:25 PM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Thu, 2009-05-28 at 20:44 +0530, naresh kamboju wrote:
>> Hi,
>>
>> Original changes done by Oleg Nesterov and Joe Korty
>> Modified by: Naresh Kamboju < naresh.kernel@gmail.com >
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>
> Sorry, this fails to apply on the latest CVS.
>
> patching file
> testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
> Hunk #1 FAILED at 19.
>
> Please resend containing the same description.
>
> Regards--
> Subrata
>
>>
>> diff -Naurb ltp-full-20090430/testcases/open_posix_testsuite/conformance=
/interfaces/sigaction/10-1.c
>> ltp-full-20090430_mod/testcases/open_posix_testsuite/conformance/interfa=
ces/sigaction/10-1.c
>> --- ltp-full-20090430/testcases/open_posix_testsuite/conformance/interfa=
ces/sigaction/10-1.c =A02005-06-03
>> 22:04:51.000000000 +0530
>> +++ ltp-full-20090430_mod/testcases/open_posix_testsuite/conformance/int=
erfaces/sigaction/10-1.c =A0 =A0 =A02009-05-28
>> 19:25:03.000000000 +0530
>> @@ -19,19 +19,42 @@
>> =A0#define NUMSTOPS 10
>>
>> =A0int child_stopped =3D 0;
>> -int waiting =3D 1;
>> +int child_continued =3D 0;
>> +int notification;
>>
>> =A0void handler(int signo, siginfo_t *info, void *context)
>> =A0{
>> - =A0 =A0 if (info && info->si_code =3D=3D CLD_STOPPED) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!info)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 notification =3D info->si_code;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (notification) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case CLD_STOPPED:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("Child has been stopped\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 waiting =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 child_stopped++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case CLD_CONTINUED:
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf("Child has been continued\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 child_continued++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +void wait_for_notification(int val)
>> +{
>> + struct timeval tv;
>>
>> -int main()
>> + while (notification !=3D val) {
>> + tv.tv_sec =3D 1;
>> + tv.tv_usec =3D 0;
>> + if (!select(0, NULL, NULL, NULL, &tv))
>> + break;
>> + }
>> +}
>> +
>> +int main(void)
>> =A0{
>> =A0 =A0 =A0 pid_t pid;
>> =A0 =A0 =A0 struct sigaction act;
>> @@ -58,25 +81,25 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int i;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < NUMSTOPS; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 waiting =3D 1;
>> -
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("--> Sending SIGSTOP\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notification =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kill(pid, SIGSTOP);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Don't let the kernel opt=
imize away queued
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SIGSTOP/SIGCONT signals.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (waiting) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv.tv_sec =3D =
1;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tv.tv_usec =3D=
 0;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!select(0,=
 NULL, NULL, NULL, &tv))
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait_for_notification(CLD_STOP=
PED);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("--> Sending SIGCONT\=
n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notification =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kill(pid, SIGCONT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SIGCHLD doesn't queue, make=
 sure CLD_CONTINUED
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0doesn't mask the next CLD_S=
TOPPED
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wait_for_notification(CLD_C=
ONTINUED);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* POSIX specifies default action to be abno=
rmal termination */
>> @@ -84,7 +107,7 @@
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 waitpid(pid, &s, 0);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (child_stopped =3D=3D NUMSTOPS) {
>> + =A0 =A0 if (child_stopped =3D=3D NUMSTOPS && child_continued =3D=3D NU=
MSTOPS) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("Test PASSED\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0 =A0 =A0 }
>> @@ -92,4 +115,3 @@
>> =A0 =A0 =A0 printf("Test FAILED\n");
>> =A0 =A0 =A0 return -1;
>> =A0}
>> -
>> Best regards,
>> Naresh Kamboju
>
>

--001e680f0c803d6e8b046b0e991e
Content-Type: application/octet-stream; name="sigaction_10-1.patch"
Content-Disposition: attachment; filename="sigaction_10-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvb1fnbd0

ZGlmZiAtTmF1cmIgbHRwLWEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1h
bmNlL2ludGVyZmFjZXMvc2lnYWN0aW9uLzEwLTEuYyBsdHAtYi90ZXN0Y2FzZXMvb3Blbl9wb3Np
eF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zaWdhY3Rpb24vMTAtMS5jCi0tLSBs
dHAtYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNl
cy9zaWdhY3Rpb24vMTAtMS5jCTIwMDUtMDYtMDMgMjI6MDQ6NTEuMDAwMDAwMDAwICswNTMwCisr
KyBsdHAtYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJm
YWNlcy9zaWdhY3Rpb24vMTAtMS5jCTIwMDktMDUtMjkgMjA6MTE6MDguMDAwMDAwMDAwICswNTMw
CkBAIC0xOSwxOSArMTksNDIgQEAKICNkZWZpbmUgTlVNU1RPUFMgMTAKIAogaW50IGNoaWxkX3N0
b3BwZWQgPSAwOwotaW50IHdhaXRpbmcgPSAxOworaW50IGNoaWxkX2NvbnRpbnVlZCA9IDA7Citp
bnQgbm90aWZpY2F0aW9uOwogCiB2b2lkIGhhbmRsZXIoaW50IHNpZ25vLCBzaWdpbmZvX3QgKmlu
Zm8sIHZvaWQgKmNvbnRleHQpIAogewotCWlmIChpbmZvICYmIGluZm8tPnNpX2NvZGUgPT0gQ0xE
X1NUT1BQRUQpIHsKKwkJaWYgKCFpbmZvKQorCQlyZXR1cm47CisKKwkJCisJCW5vdGlmaWNhdGlv
biA9IGluZm8tPnNpX2NvZGU7CisKKwkJc3dpdGNoIChub3RpZmljYXRpb24pIHsKKwkJY2FzZSBD
TERfU1RPUFBFRDoKIAkJcHJpbnRmKCJDaGlsZCBoYXMgYmVlbiBzdG9wcGVkXG4iKTsKLQkJd2Fp
dGluZyA9IDA7CiAJCWNoaWxkX3N0b3BwZWQrKzsKKwkJYnJlYWs7CisJCWNhc2UgQ0xEX0NPTlRJ
TlVFRDoKKwkJcHJpbnRmKCJDaGlsZCBoYXMgYmVlbiBjb250aW51ZWRcbiIpOworCQljaGlsZF9j
b250aW51ZWQrKzsKKwkJYnJlYWs7CiAJfQogfQogCit2b2lkIHdhaXRfZm9yX25vdGlmaWNhdGlv
bihpbnQgdmFsKQoreworIHN0cnVjdCB0aW1ldmFsIHR2OwogCi1pbnQgbWFpbigpCisgd2hpbGUg
KG5vdGlmaWNhdGlvbiAhPSB2YWwpIHsKKyB0di50dl9zZWMgPSAxOworIHR2LnR2X3VzZWMgPSAw
OworIGlmICghc2VsZWN0KDAsIE5VTEwsIE5VTEwsIE5VTEwsICZ0dikpCisgYnJlYWs7CisgfQor
fQorCitpbnQgbWFpbih2b2lkKQogewogCXBpZF90IHBpZDsKIAlzdHJ1Y3Qgc2lnYWN0aW9uIGFj
dDsKQEAgLTU4LDI1ICs4MSwyNSBAQAogCQlpbnQgaTsKIAogCQlmb3IgKGkgPSAwOyBpIDwgTlVN
U1RPUFM7IGkrKykgewotCQkJd2FpdGluZyA9IDE7Ci0KIAkJCXByaW50ZigiLS0+IFNlbmRpbmcg
U0lHU1RPUFxuIik7CisJCQlub3RpZmljYXRpb24gPSAwOwogCQkJa2lsbChwaWQsIFNJR1NUT1Ap
OwogCiAJCQkvKgogCQkJICBEb24ndCBsZXQgdGhlIGtlcm5lbCBvcHRpbWl6ZSBhd2F5IHF1ZXVl
ZAogCQkJICBTSUdTVE9QL1NJR0NPTlQgc2lnbmFscy4KIAkJCSovCi0JCQl3aGlsZSAod2FpdGlu
ZykgewotCQkJCXR2LnR2X3NlYyA9IDE7Ci0JCQkJdHYudHZfdXNlYyA9IDA7Ci0JCQkJaWYgKCFz
ZWxlY3QoMCwgTlVMTCwgTlVMTCwgTlVMTCwgJnR2KSkKLQkJCQkgIGJyZWFrOwotCQkJfQogCisJ
CQl3YWl0X2Zvcl9ub3RpZmljYXRpb24oQ0xEX1NUT1BQRUQpOwogCiAJCQlwcmludGYoIi0tPiBT
ZW5kaW5nIFNJR0NPTlRcbiIpOworCQkJbm90aWZpY2F0aW9uID0gMDsKIAkJCWtpbGwocGlkLCBT
SUdDT05UKTsKKwkJCS8qCisJCQkgU0lHQ0hMRCBkb2Vzbid0IHF1ZXVlLCBtYWtlIHN1cmUgQ0xE
X0NPTlRJTlVFRAorCQkJIGRvZXNuJ3QgbWFzayB0aGUgbmV4dCBDTERfU1RPUFBFRAorCQkJICov
CisJCQkgd2FpdF9mb3Jfbm90aWZpY2F0aW9uKENMRF9DT05USU5VRUQpOwogCQl9CiAJCQogCQkv
KiBQT1NJWCBzcGVjaWZpZXMgZGVmYXVsdCBhY3Rpb24gdG8gYmUgYWJub3JtYWwgdGVybWluYXRp
b24gKi8KQEAgLTg0LDcgKzEwNyw3IEBACiAJCXdhaXRwaWQocGlkLCAmcywgMCk7CiAJfQogCi0J
aWYgKGNoaWxkX3N0b3BwZWQgPT0gTlVNU1RPUFMpIHsKKwlpZiAoY2hpbGRfc3RvcHBlZCA9PSBO
VU1TVE9QUyAmJiBjaGlsZF9jb250aW51ZWQgPT0gTlVNU1RPUFMpIHsKIAkJcHJpbnRmKCJUZXN0
IFBBU1NFRFxuIik7CiAJCXJldHVybiAwOwogCX0KQEAgLTkyLDQgKzExNSwzIEBACiAJcHJpbnRm
KCJUZXN0IEZBSUxFRFxuIik7CiAJcmV0dXJuIC0xOwogfQotCg==
--001e680f0c803d6e8b046b0e991e
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
--001e680f0c803d6e8b046b0e991e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f0c803d6e8b046b0e991e--

