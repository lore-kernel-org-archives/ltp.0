Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MZE2G-0002e7-RT
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 01:14:20 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZE2C-00070W-Hr
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 01:14:20 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA16F9.19587ABA"
Date: Thu, 6 Aug 2009 17:50:45 -0700
Message-ID: <8368651DACC1964480F951191B94A078F8A312@svexch01.mvista.com>
In-Reply-To: <4A7A9DFB.7050305@petalogix.com>
References: <d51f89b0908032310k20c3843am7ea069d03436a7a@mail.gmail.com>	<1249387637.15587.29.camel@subratamodak.linux.ibm.com><d51f89b0908040516i7c65740bi3e30e0972c8374fa@mail.gmail.com>
	<4A7A9DFB.7050305@petalogix.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: [LTP] [PATCH]  Issue with rt_sigqueueinfo testcase in LTP.
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
To: michal.simek@petalogix.com, rohit verma <rohit.170309@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA16F9.19587ABA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yes, I had just noticed this as well.  Since it was "passing", it took =
awhile to spot.

Returning pass even with tst_resm(TFAIL,.. Being called must have =
something to do with the forking, but I'm not familiar with how the LTP =
framework deals with that.=20

In any case, I've create this patch for our internal tree that does the =
following:
- cleans up spacing for tabs, it was mix of two before
- removes the second testcase which is I think is invalid (this gets rid =
of the bad return code as well).
- removed the inner loop, it doesn't make sense as the tst_exit in the =
original code would never let it run past the first loop.
- moved cleanup() and setup() to the appropriate places where they will =
only be called in pairs.


-----Original Message-----
From: Michal Simek [mailto:michal.simek@petalogix.com]=20
Sent: Thursday, August 06, 2009 2:10 AM
To: rohit verma
Cc: ltp-list
Subject: Re: [LTP] Issue with rt_sigqueueinfo testcase in LTP.

I can confirm that fault too - on Microblaze and x86 too.
The funny thing is that this test failed but it is reported as passed in =
log.

Michal
> FYI...
>
>
> ---------- Forwarded message ----------
> From: Subrata Modak <subrata@linux.vnet.ibm.com>
> Date: Tue, Aug 4, 2009 at 5:37 PM
> Subject: Re: Issue with rt_sigqueueinfo testcase in LTP.
> To: rohit verma <rohit.170309@gmail.com>
> Cc: maknayak@in.ibm.com
>
>
> Hi Rohit,
>
> On Tue, 2009-08-04 at 11:40 +0530, rohit verma wrote:
>  =20
>> Dear Manas Kumar Nayak,
>>
>> I have found an issue with rt_sigqueueinfo test-case.
>>
>> Following is the test output:
>>
>> rt_sigqueueinfo01    1  PASS  :  Test Succeeded
>> rt_sigqueueinfo01    1  FAIL  :  Test Failed, errno=3D1 : Operation =
not permitted
>> rt_sigqueueinfo01    1  PASS  :  Test Succeeded
>> rt_sigqueueinfo01    1  FAIL  :  Test Failed, errno=3D1 : Operation =
not permitted
>> rt_sigqueueinfo01    0  WARN  :  tst_rmdir(): rmobj(/tmp/rt_3FaSpK)
>> failed: lstat(/tmp/rt_3FaSpK) failed; errno=3D2: No such file or=20
>> directory
>>
>> I think the following lines are causing the failures:
>>
>> (Line - 164)
>>
>> uinfo.si_errno =3D 0;
>> uinfo.si_code =3D 0;//SI_USER
>> TEST(retval =3D syscall(__NR_rt_sigqueueinfo, getpid(), 17, &uinfo));
>>
>> Reason -
>>
>> You can observe the following comment & source when you look at the=20
>> Linux source (v 2.6.29)
>> (linux-2.6.29/kernel/signal.c)
>>
>>           /* Not even root can pretend to send signals from the =
kernel.
>>            Nor can they impersonate a kill(), which adds source info. =
 */
>>         if (info.si_code >=3D 0)
>>                 return -EPERM;
>>
>> which implies that si_code cannot be set to ' 0 ' (SI_USER) when=20
>> invoking the rt_sigqueueinfo syscall.
>>
>>
>> I am not sure how to fix this issue. But, a possible fix would be to=20
>> remove the second set of fork & rt_sigqueueinfo invocations and use=20
>> the first set (with SI_QUEUE). If needed, the loop count can be=20
>> increased.
>>    =20
>
> Please propose this over to the mailing list. Manas has just ported=20
> the test case from Crackerjack to LTP. He may not be exactly aware of=20
> the issues, as it was a blind port, which in one way was good, as the=20
> porting generated issues, people interested discussed and solved them=20
> ;-)
>
> Regards--
> Subrata
>
>  =20
>>    =20
>
>
>
>
>  =20


--
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


-------------------------------------------------------------------------=
-----
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 =
30-Day=20
trial. Simplify your report design, integration and deployment - and =
focus on=20
what you do best, core application coding. Discover what's new with=20
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA16F9.19587ABA
Content-Type: application/octet-stream;
	name="rt_sigqueueinfo01.patch"
Content-Transfer-Encoding: base64
Content-Description: rt_sigqueueinfo01.patch
Content-Disposition: attachment;
	filename="rt_sigqueueinfo01.patch"

ZGlmZiAtTnVycCAteCBDVlMgbHRwLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
cnRfc2lncXVldWVpbmZvL3J0X3NpZ3F1ZXVlaW5mbzAxLmMgbHRwLXdkaXIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9ydF9zaWdxdWV1ZWluZm8vcnRfc2lncXVldWVpbmZvMDEuYw0KLS0tIGx0
cC0yMDA5MDUzMS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3F1ZXVlaW5mby9ydF9z
aWdxdWV1ZWluZm8wMS5jCTIwMDktMDUtMjEgMTE6MjU6NTguMDAwMDAwMDAwIC0wNzAwDQorKysg
bHRwLXdkaXIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdxdWV1ZWluZm8vcnRfc2ln
cXVldWVpbmZvMDEuYwkyMDA5LTA4LTA2IDE3OjM0OjI1Ljg2ODQ2NzU2NyAtMDcwMA0KQEAgLTQ2
LDIwICs0NiwxOSBAQA0KICNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPg0KICNpbmNsdWRlIDxzdHJp
bmcuaD4NCiANCi0NCiAvKiBIYXJuZXNzIFNwZWNpZmljIEluY2x1ZGUgRmlsZXMuICovDQogI2lu
Y2x1ZGUgInRlc3QuaCINCiAjaW5jbHVkZSAidXNjdGVzdC5oIg0KICNpbmNsdWRlICJsaW51eF9z
eXNjYWxsX251bWJlcnMuaCINCiANCiAvKiBFeHRlcm4gR2xvYmFsIFZhcmlhYmxlcyAqLw0KLWV4
dGVybiBpbnQgVHN0X2NvdW50OyAgICAgICAgICAgLyogY291bnRlciBmb3IgdHN0X3h4eCByb3V0
aW5lcy4gICAgICAgICAqLw0KLWV4dGVybiBjaGFyICpURVNURElSOyAgICAgICAgICAgLyogdGVt
cG9yYXJ5IGRpciBjcmVhdGVkIGJ5IHRzdF90bXBkaXIoKSAqLw0KK2V4dGVybiBpbnQgVHN0X2Nv
dW50OyAvKiBjb3VudGVyIGZvciB0c3RfeHh4IHJvdXRpbmVzLiAgICAgICAgICovDQorZXh0ZXJu
IGNoYXIgKlRFU1RESVI7IC8qIHRlbXBvcmFyeSBkaXIgY3JlYXRlZCBieSB0c3RfdG1wZGlyKCkg
Ki8NCiANCiAvKiBHbG9iYWwgVmFyaWFibGVzICovDQotY2hhciAqVENJRCA9ICJydF9zaWdxdWV1
ZWluZm8wMSI7ICAvKiBUZXN0IHByb2dyYW0gaWRlbnRpZmllci4qLw0KLWludCAgdGVzdG5vOw0K
LWludCAgVFNUX1RPVEFMID0gMjsgICAgICAgICAgICAgICAgICAgLyogdG90YWwgbnVtYmVyIG9m
IHRlc3RzIGluIHRoaXMgZmlsZS4gICAqLw0KK2NoYXIgKlRDSUQgPSAicnRfc2lncXVldWVpbmZv
MDEiOyAvKiBUZXN0IHByb2dyYW0gaWRlbnRpZmllci4qLw0KK2ludCB0ZXN0bm87DQoraW50IFRT
VF9UT1RBTCA9IDI7IC8qIHRvdGFsIG51bWJlciBvZiB0ZXN0cyBpbiB0aGlzIGZpbGUuICAgKi8N
CiANCiAvKiBFeHRlcm4gR2xvYmFsIEZ1bmN0aW9ucyAqLw0KIC8qKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KiovDQpAQCAtODAsMTIgKzc5LDEyIEBAIGludCAgVFNUX1RPVEFMID0gMjsgICAgICAgICAgICAg
ICAgICAgLyoNCiAvKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLw0KIC8qKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KiovDQogZXh0ZXJuIHZvaWQgY2xlYW51cCgpIHsNCi0gICAgICAgIC8qIFJlbW92ZSB0bXAgZGly
IGFuZCBhbGwgZmlsZXMgaW4gaXQgKi8NCi0gICAgICAgIFRFU1RfQ0xFQU5VUDsNCi0gICAgICAg
IHRzdF9ybWRpcigpOw0KKwkvKiBSZW1vdmUgdG1wIGRpciBhbmQgYWxsIGZpbGVzIGluIGl0ICov
DQorCVRFU1RfQ0xFQU5VUDsNCisJdHN0X3JtZGlyKCk7DQogDQotICAgICAgICAvKiBFeGl0IHdp
dGggYXBwcm9wcmlhdGUgcmV0dXJuIGNvZGUuICovDQotICAgICAgICB0c3RfZXhpdCgpOw0KKwkv
KiBFeGl0IHdpdGggYXBwcm9wcmlhdGUgcmV0dXJuIGNvZGUuICovDQorCXRzdF9leGl0KCk7DQog
fQ0KIA0KIC8qIExvY2FsICBGdW5jdGlvbnMgKi8NCkBAIC0xMDcsNzMgKzEwNiw1MCBAQCBleHRl
cm4gdm9pZCBjbGVhbnVwKCkgew0KIC8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQogLyoqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKi8NCiB2b2lkIHNldHVwKCkgew0KLSAgICAgICAgLyogQ2FwdHVyZSBzaWdu
YWxzIGlmIGFueSAqLw0KLSAgICAgICAgLyogQ3JlYXRlIHRlbXBvcmFyeSBkaXJlY3RvcmllcyAq
Lw0KLSAgICAgICAgVEVTVF9QQVVTRTsNCi0gICAgICAgIHRzdF90bXBkaXIoKTsNCisJLyogQ2Fw
dHVyZSBzaWduYWxzIGlmIGFueSAqLw0KKwkvKiBDcmVhdGUgdGVtcG9yYXJ5IGRpcmVjdG9yaWVz
ICovDQorCVRFU1RfUEFVU0U7DQorCXRzdF90bXBkaXIoKTsNCiB9DQogDQotDQogaW50IG1haW4o
aW50IGFjLCBjaGFyICoqYXYpIHsNCiAJaW50IHBpZCwgcmV0dmFsOw0KLSAgICAgICAgcGlkID0g
Z2V0cGlkKCk7DQotICAgICAgICBzaWdpbmZvX3QgdWluZm87DQotICAgICAgICBpbnQgbGM7ICAg
ICAgICAgICAgICAgICAvKiBsb29wIGNvdW50ZXIgKi8NCi0gICAgICAgIGNoYXIgKm1zZzsgICAg
ICAgICAgICAgIC8qIG1lc3NhZ2UgcmV0dXJuZWQgZnJvbSBwYXJzZV9vcHRzICovDQotCQ0KLSAg
ICAgICAgLyogcGFyc2Ugc3RhbmRhcmQgb3B0aW9ucyAqLw0KLSAgICAgICAgaWYgKChtc2cgPSBw
YXJzZV9vcHRzKGFjLCBhdiwgKG9wdGlvbl90ICopTlVMTCwgTlVMTCkpICE9IChjaGFyICopTlVM
TCl7DQotICAgICAgICAgICAgIHRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiT1BUSU9OIFBBUlNJ
TkcgRVJST1IgLSAlcyIsIG1zZyk7DQotICAgICAgICAgICAgIHRzdF9leGl0KCk7DQotICAgICAg
ICAgICB9DQotDQotICAgICAgICBzZXR1cCgpOw0KLQ0KLSAgICAgICAgLyogQ2hlY2sgbG9vcGlu
ZyBzdGF0ZSBpZiAtaSBvcHRpb24gZ2l2ZW4gKi8NCi0gICAgICAgIGZvciAobGMgPSAwOyBURVNU
X0xPT1BJTkcobGMpOyArK2xjKSB7DQotICAgICAgICAgICAgICAgIFRzdF9jb3VudCA9IDA7DQot
ICAgICAgICAgICAgICAgIGZvciAodGVzdG5vID0gMDsgdGVzdG5vIDwgVFNUX1RPVEFMOyArK3Rl
c3Rubykgew0KLQkJCVRFU1QocGlkID0gZm9yaygpKTsNCi0JCSAgICAgICAgaWYoVEVTVF9SRVRV
Uk4gPCAwKXsNCi0JCQkJdHN0X3Jlc20oVEZBSUwsImZvcmsoKSBGYWlsZWQsIGVycm5vPSVkIDog
JXMiLFRFU1RfRVJSTk8sIHN0cmVycm9yKFRFU1RfRVJSTk8pKTsNCi0gICAgICAgICAgICAgICAg
ICAgICAgICAJY2xlYW51cCgpOw0KLQkJCQl0c3RfZXhpdCgpOw0KLQkJICAgICAgICB9IGVsc2Ug
aWYgKFRFU1RfUkVUVVJOID09IDApew0KLQkJCQkgIHVpbmZvLnNpX2Vycm5vID0gMDsNCi0JCQkg
ICAgICAgICAgdWluZm8uc2lfY29kZSA9IC0xOw0KLQkJICAgICAgICAgICAgICAgICAgVEVTVChy
ZXR2YWwgPSBzeXNjYWxsKF9fTlJfcnRfc2lncXVldWVpbmZvLCBnZXRwaWQoKSwgMTcsICZ1aW5m
bykpOw0KLQkJCQkgICBpZihURVNUX1JFVFVSTiA9PSAwKXsNCi0JCQkJCXRzdF9yZXNtKFRQQVNT
LCJUZXN0IFN1Y2NlZWRlZCIpOw0KLQkJCQkJdHN0X2V4aXQoKTsNCi0JCQkgICAgICAgICAgfSBl
bHNlIHsNCi0JCQkJCXRzdF9yZXNtKFRGQUlMLCJUZXN0IEZhaWxlZCwgZXJybm89JWQgOiAlcyIs
VEVTVF9FUlJOTywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOw0KLQkgICAgICAgICAgICAgICAgICAg
ICAgICAJY2xlYW51cCgpOw0KLQkJCQkJdHN0X2V4aXQoKTsNCi0JCSAgICAgICAgICAgICAgICAg
ICAgfQ0KLQkJICAgICAgICB9DQotDQorCXBpZCA9IGdldHBpZCgpOw0KKwlzaWdpbmZvX3QgdWlu
Zm87DQorCWludCBsYzsgLyogbG9vcCBjb3VudGVyICovDQorCWNoYXIgKm1zZzsgLyogbWVzc2Fn
ZSByZXR1cm5lZCBmcm9tIHBhcnNlX29wdHMgKi8NCisNCisJLyogcGFyc2Ugc3RhbmRhcmQgb3B0
aW9ucyAqLw0KKwlpZiAoKG1zZyA9IHBhcnNlX29wdHMoYWMsIGF2LCAob3B0aW9uX3QgKikgTlVM
TCwgTlVMTCkpICE9IChjaGFyICopIE5VTEwpIHsNCisJCXRzdF9icmttKFRCUk9LLCB0c3RfZXhp
dCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0gJXMiLCBtc2cpOw0KKwl9DQorDQorCS8qIENoZWNr
IGxvb3Bpbmcgc3RhdGUgaWYgLWkgb3B0aW9uIGdpdmVuICovDQorCWZvciAobGMgPSAwOyBURVNU
X0xPT1BJTkcobGMpOyArK2xjKSB7DQorCQlUc3RfY291bnQgPSAwOw0KKwkJZm9yICh0ZXN0bm8g
PSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7DQogCQkJVEVTVChwaWQgPSBmb3Jr
KCkpOw0KLSAgICAgICAgICAgICAgICAgICAgICAgIGlmKFRFU1RfUkVUVVJOIDwgMCl7DQotICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfcmVzbShURkFJTCwiZm9yaygpIEZhaWxl
ZCwgZXJybm89JWQgOiAlcyIsVEVTVF9FUlJOTywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOw0KLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xlYW51cCgpOw0KLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdHN0X2V4aXQoKTsNCi0gICAgICAgICAgICAgICAgICAgICAgICB9
IGVsc2UgaWYgKFRFU1RfUkVUVVJOID09IDApew0KLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW5mby5zaV9lcnJubyA9IDA7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbmZvLnNpX2NvZGUgPSAwOw0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBURVNUKHJldHZhbCA9IHN5c2NhbGwoX19OUl9ydF9zaWdxdWV1ZWluZm8sIGdldHBpZCgp
LCAxNywgJnVpbmZvKSk7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpZihU
RVNUX1JFVFVSTiA9PSAwKXsNCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdHN0X3Jlc20oVFBBU1MsIlRlc3QgU3VjY2VlZGVkIik7DQotICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHRzdF9leGl0KCk7DQotICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIH0gZWxzZSB7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHRzdF9yZXNtKFRGQUlMLCJUZXN0IEZhaWxlZCwgZXJybm89JWQgOiAlcyIsVEVTVF9F
UlJOTywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOw0KLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBjbGVhbnVwKCk7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHRzdF9leGl0KCk7DQotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KLSAgICAgICAgICAgICAgICAgICAgICAgIH0NCi0NCi0gICAgICAgICAgICAgICAgfQ0K
LQlUc3RfY291bnQrKzsNCi0gICAgICAgIH0JDQotICAgICAgICB0c3RfZXhpdCgpOw0KKwkJCXNl
dHVwKCk7DQorCQkJaWYgKFRFU1RfUkVUVVJOIDwgMCkgew0KKwkJCQl0c3RfcmVzbShURkFJTCwg
ImZvcmsoKSBGYWlsZWQsIGVycm5vPSVkIDogJXMiLCBURVNUX0VSUk5PLA0KKwkJCQkJCXN0cmVy
cm9yKFRFU1RfRVJSTk8pKTsNCisJCQkJY2xlYW51cCgpOw0KKwkJCX0gZWxzZSBpZiAoVEVTVF9S
RVRVUk4gPT0gMCkgew0KKwkJCQl1aW5mby5zaV9lcnJubyA9IDA7DQorCQkJCXVpbmZvLnNpX2Nv
ZGUgPSBTSV9RVUVVRTsNCisJCQkJVEVTVChyZXR2YWwgPSBzeXNjYWxsKF9fTlJfcnRfc2lncXVl
dWVpbmZvLCBnZXRwaWQoKSwgMTcsDQorCQkJCQkJJnVpbmZvKSk7DQorCQkJCWlmIChURVNUX1JF
VFVSTiA9PSAwKSB7DQorCQkJCQl0c3RfcmVzbShUUEFTUywgIlRlc3QgU3VjY2VlZGVkIik7DQor
CQkJCX0gZWxzZSB7DQorCQkJCQl0c3RfcmVzbShURkFJTCwgIlRlc3QgRmFpbGVkLCBlcnJubz0l
ZCA6ICVzIiwgVEVTVF9FUlJOTywNCisJCQkJCQkJc3RyZXJyb3IoVEVTVF9FUlJOTykpOw0KKwkJ
CQl9DQorCQkJCWNsZWFudXAoKTsNCisJCQl9DQorCQkJdHN0X2V4aXQoKTsNCisJCX0NCisJCVRz
dF9jb3VudCsrOw0KKwl9DQogfQ0KIA0K

------_=_NextPart_001_01CA16F9.19587ABA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
------_=_NextPart_001_01CA16F9.19587ABA
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA16F9.19587ABA--

