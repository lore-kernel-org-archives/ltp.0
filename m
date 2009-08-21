Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MeMSH-0000Tu-Fa
	for ltp-list@lists.sourceforge.net; Fri, 21 Aug 2009 05:14:25 +0000
Received: from mail-px0-f197.google.com ([209.85.216.197])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MeMS9-0001nI-KQ
	for ltp-list@lists.sourceforge.net; Fri, 21 Aug 2009 05:14:25 +0000
MIME-Version: 1.0
In-Reply-To: <4A861EA2.6070701@cn.fujitsu.com>
References: <d51f89b0908130131u5742ff3epf58617e3f4ab38a3@mail.gmail.com>
	<4A850550.7080109@cn.fujitsu.com>
	<d51f89b0908140134g18b7b34cr9858edad1242373a@mail.gmail.com>
	<4A861EA2.6070701@cn.fujitsu.com>
Date: Fri, 21 Aug 2009 10:44:10 +0530
Message-ID: <d51f89b0908202214l795ceb5bp5530fa4666f7ba87@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Content-Type: multipart/mixed; boundary=0016e64ea26235620104719ff0fa
Subject: Re: [LTP] utimes01 test case issue
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
To: subrata@linux.vnet.ibm.com, Wei Yongjun <yjwei@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sf.net>

--0016e64ea26235620104719ff0fa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Wang Yong,

I have changed the expected error for root user in case02 as following.

From tcase[2].err =3D EACCES to tcase[2].err =3D EPERM (For root user) .

Pls check the attached patch for the same.


On Sat, Aug 15, 2009 at 8:04 AM, Wei Yongjun<yjwei@cn.fujitsu.com> wrote:
> rohit verma wrote:
>> Hi Wang Yong,
>>
>> I am getting following =A0O/P for case02 :
>>
>> As root user:
>>
>> utimes01 =A0 =A00 =A0TINFO =A0: =A0(case02) START
>> EXPECT: return value(ret)=3D-1 errno=3D13 (Permission denied)
>> RESULT: return value(ret)=3D-1 errno=3D1 (Operation not permitted)
>> utimes01 =A0 =A00 =A0TINFO =A0: =A0(case02) END =3D> NG
>>
>> As non-root user:
>> utimes01 =A0 =A00 =A0TINFO =A0: =A0(case02) START
>> seteuid failed.
>> utimes01 =A0 =A00 =A0TINFO =A0: =A0(case02) END =3D> OK
>>
>> Are you getting the same?
>>
>>
>>
>
> yes, the same result.
>
>>
>> On Fri, Aug 14, 2009 at 12:03 PM, Wei Yongjun<yjwei@cn.fujitsu.com> wrot=
e:
>>
>>> rohit verma wrote:
>>>
>>>> Hi Wang Yong,
>>>>
>>>> I have observed the following thing in case02 of the test case
>>>> utimes01 in latest ltp release.
>>>>
>>>> Expected error value is =A0EACCES (In the code below)
>>>> But the actual error value is EPERM.I have checked this on =A02.6.27 a=
nd
>>>> 2.6.29 kernel.
>>>>
>>>>
>>> You can try root user and noroot user, the return error is different.
>>>
>>>
>>>> static struct test_case tcase[] =3D {
>>>>
>>>> =A0 =A0 =A0 =A0 { // case00
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>> =A0 =A0 =A0 =A0 },
>>>> =A0 =A0 =A0 =A0 { // case01
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>> =A0 =A0 =A0 =A0 },
>>>> =A0 =A0 =A0 =A0 { // case02
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ttype =A0 =A0 =A0 =A0 =A0=3D NORMAL,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .a_sec =A0 =A0 =A0 =A0=3D 1000,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .m_sec =A0 =A0 =A0 =3D 2000,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .user =A0 =A0 =A0 =A0 =A0=3D "nobody",
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .err =A0 =A0 =A0 =A0 =A0 =A0 =3D EACCE=
S, // RHEL4U1 + 2.6.18 returns EPERM
>>>> =A0 =A0 =A0 =A0 },
>>>> =A0 =A0 =A0 =A0 { // case03
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>> =A0 =A0 =A0 =A0 },
>>>>
>>>> =A0 =A0 =A0 =A0 { // case04
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ...
>>>> =A0 =A0 =A0 =A0 },
>>>> };
>>>>
>>>> Kindly confirm whether you are facing the same issue at your end.
>>>>
>>>>
>>>>
>>>
>>>
>>
>>
>>
>>
>
>
>



--=20
Regards,
Rohit

--0016e64ea26235620104719ff0fa
Content-Type: text/plain; charset=US-ASCII; name="utimes01_patch.txt"
Content-Disposition: attachment; filename="utimes01_patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fymgktou0

U2lnbmVkLW9mZi1ieTogcm9oaXQgdmVybWEgKHJvaGl0MTcwMzA5QGdtYWlsLmNvbSkKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQpkaWZmIC1ydU5CIGx0cC1mdWxsLTIwMDkwNzMxL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvdXRpbWVzL3V0aW1lczAxLmMgbHRwLWZ1bGwtMjAwOTA3MzFfbmV3L3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVzL3V0aW1lczAxLmMKLS0tIGx0cC1mdWxsLTIw
MDkwNzMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdXRpbWVzL3V0aW1lczAxLmMJMjAwOS0w
Ny0yMSAxMjowNToyMy4wMDAwMDAwMDAgKzA1MzAKKysrIGx0cC1mdWxsLTIwMDkwNzMxX25ldy90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3V0aW1lcy91dGltZXMwMS5jCTIwMDktMDgtMjEgMDY6
MjQ6MDguMDAwMDAwMDAwICswNTMwCkBAIC0zMzgsNiArMzM4LDcgQEAKICAgICAgICAgaW50IGk7
CiAgICAgICAgIGludCBsYzsgICAgICAgICAgICAgICAgIC8qIGxvb3AgY291bnRlciAqLwogICAg
ICAgICBjaGFyICptc2c7ICAgICAgICAgICAgICAvKiBtZXNzYWdlIHJldHVybmVkIGZyb20gcGFy
c2Vfb3B0cyAqLworCXVpZF90IHVpZDsKIAogCXN0cnVjdCBvcHRpb24gbG9uZ19vcHRpb25zW10g
PSB7CiAgICAgICAgICAgICAgICAgeyAiZGVidWciLCBub19hcmd1bWVudCwgMCwgJ2QnIH0sCkBA
IC0zNTYsNyArMzU3LDEzIEBACiAKICAgICAgICAgc2V0dXAoKTsKIAotICAgICAgICAvKiBDaGVj
ayBsb29waW5nIHN0YXRlIGlmIC1pIG9wdGlvbiBnaXZlbiAqLworCS8qIEFzIGEgcm9vdCB1c2Vy
IGVycm9yIHZhbHVlIHNob3VsZCBiZSBFUEVSTSBmb3IgY2FzZTAyICovCisJdWlkID0gZ2V0dWlk
KCk7CisJaWYgKHVpZCA9PSAwKSB7CisJCXRjYXNlWzJdLmVyciA9IEVQRVJNOworCX0KKworCS8q
IENoZWNrIGxvb3Bpbmcgc3RhdGUgaWYgLWkgb3B0aW9uIGdpdmVuICovCiAgICAgICAgIGZvciAo
bGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyArK2xjKSB7CiAgICAgICAgICAgICAgICAgVHN0X2Nv
dW50ID0gMDsKICAgICAgICAgICAgICAgICBmb3IgKHRlc3RubyA9IDA7IHRlc3RubyA8IFRTVF9U
T1RBTDsgKyt0ZXN0bm8pIHsK
--0016e64ea26235620104719ff0fa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--0016e64ea26235620104719ff0fa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e64ea26235620104719ff0fa--

