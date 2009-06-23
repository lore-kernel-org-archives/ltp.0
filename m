Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MJCs2-0007wO-Ka
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:45:34 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJCry-0003zb-L7
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 20:45:34 +0000
Date: Tue, 23 Jun 2009 22:48:50 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Content-Type: multipart/mixed; boundary=----------W377DpSgEPbyoIuOhTUiTv
MIME-Version: 1.0
References: <200906220117.n5M1HTVJ004183@e2.ny.us.ibm.com>
	<1245768543.4860.65.camel@subratamodak.linux.ibm.com>
	<op.uvzhu1pnu2flwt@debian>
Message-ID: <op.uvzv3omsu2flwt@debian>
In-Reply-To: <op.uvzhu1pnu2flwt@debian>
Subject: Re: [LTP] [PATCH] Fix cleanup procedure in the setuid04 test
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
To: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>, subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

------------W377DpSgEPbyoIuOhTUiTv
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2009 17:41:15 +0200, Ji=F8=ED Pale=E8ek <jpalecek@web.de> =
wrote:

> On Tue, 23 Jun 2009 16:49:03 +0200, Subrata Modak =20
> <subrata@linux.vnet.ibm.com> wrote:
>
>> On Tue, 2009-05-12 at 19:06 +0200, Jiri Palecek wrote:
>>> Cleanup has to be made only once in the parent process; when the
>>>  child makes the cleanup itself, the parent has nothing to cleanup,
>>>  which makes him sad.
>>>
>>> Signed-off-by: Jiri Palecek <jpalecek@web.de>
>>
>> Thanks.
>
> Oh no, at the second sight I see I've posted a wrong (old) version of =20
> the patch. I'll send a correction shortly.

The correction is in the attachment. Please, apply.

Regards
     Jiri Palecek

>>> ---
>>>  testcases/kernel/syscalls/setuid/setuid04.c |    7 +++----
>>>  1 files changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/setuid/setuid04.c =20
>>> b/testcases/kernel/syscalls/setuid/setuid04.c
>>> index 18f1d90..26a3868 100644
>>> --- a/testcases/kernel/syscalls/setuid/setuid04.c
>>> +++ b/testcases/kernel/syscalls/setuid/setuid04.c
>>> @@ -114,7 +114,7 @@ void do_master_child()
>>>  	int status;
>>>
>>>  	if (setuid(ltpuser->pw_uid) =3D=3D -1) {
>>> -		tst_brkm(TBROK, cleanup,
>>> +		tst_brkm(TBROK, tst_exit,
>>>  			 "setuid failed to set the effective uid to %d",
>>>  			 ltpuser->pw_uid);
>>>  	}
>>> @@ -143,7 +143,7 @@ void do_master_child()
>>>
>>>  		pid =3D FORK_OR_VFORK();
>>>  		if (pid < 0)
>>> -			tst_brkm(TBROK, cleanup, "Fork failed");
>>> +			tst_brkm(TBROK, tst_exit, "Fork failed");
>>>
>>>  		if (pid =3D=3D 0) {
>>>  			int tst_fd2;
>>> @@ -160,13 +160,12 @@ void do_master_child()
>>>
>>>  			if (TEST_ERRNO =3D=3D EACCES) {
>>>  				tst_resm(TPASS, "open returned errno EACCES");
>>> -				exit(0);
>>>  			} else {
>>>  				tst_resm(TFAIL,
>>>  					 "open returned unexpected errno - %d",
>>>  					 TEST_ERRNO);
>>> -				exit(-1);
>>>  			}
>>> +			tst_exit();
>>>  		} else {
>>>  			/* Wait for son completion */
>>>  			waitpid(pid, &status, 0);
>>
>
>
>



--=20
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
------------W377DpSgEPbyoIuOhTUiTv
Content-Disposition: attachment;
	filename="[PATCH] Fix cleanup procedure in the setuid04
	test.mbs"
Content-Type: application/octet-stream;
	name="[PATCH] Fix cleanup procedure in the setuid04 test.mbs"
Content-Transfer-Encoding: Base64

RnJvbSA8amlya2FAZGViaWFuLiBUdWUgTWF5IDEyIDE3OjA2OjE1IDIwMDkKRnJv
bTogIkppcmkgUGFsZWNlayA+IiA8IjxqaXJrYSJAZGViaWFuLj4gKG5vbmUpDQpE
YXRlOiBUdWUsIDEyIE1heSAyMDA5IDE5OjA2OjE1ICswMjAwDQpTdWJqZWN0OiBb
UEFUQ0hdIEZpeCBjbGVhbnVwIHByb2NlZHVyZSBpbiB0aGUgc2V0dWlkMDQgdGVz
dA0KQ2M6IGx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldA0KDQogQ2xlYW51
cCBoYXMgdG8gYmUgbWFkZSBvbmx5IG9uY2UgaW4gdGhlIHBhcmVudCBwcm9jZXNz
OyB3aGVuIHRoZQ0KIGNoaWxkIG1ha2VzIHRoZSBjbGVhbnVwIGl0c2VsZiwgdGhl
IHBhcmVudCBoYXMgbm90aGluZyB0byBjbGVhbnVwLA0KIHdoaWNoIG1ha2VzIGhp
bSBzYWQuDQoNCkFkZCBhIHRzdF9leGl0IHRvIHRoZSBlbmQgb2YgdGhlIGNoaWxk
IHByb2NlZHVyZSwgdG8gbWFrZSBpdCBub3QgcmV0dXJuIGFuZCBjYWxsIGNsZWFu
dXAgKHdoaWNoIHdvdWxkIGJlIG90aGVyd2lzZSBjYWxsZWQgdHdpY2UpDQoNClNp
Z25lZC1vZmYtYnk6IEppcmkgUGFsZWNlayA8anBhbGVjZWtAd2ViLmRlPg0KLS0t
DQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXR1aWQvc2V0dWlkMDQuYyB8
ICAgIDEgKw0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zZXR1aWQvc2V0dWlkMDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvc2V0dWlkL3NldHVpZDA0LmMNCmluZGV4IDI2YTM4NjguLjk3ZWZiY2IgMTAw
NjQ0DQotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHVpZC9zZXR1
aWQwNC5jDQorKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHVpZC9z
ZXR1aWQwNC5jDQpAQCAtMTczLDYgKzE3Myw3IEBAIHZvaWQgZG9fbWFzdGVyX2No
aWxkKCkNCiAJCQkJZXhpdChXRVhJVFNUQVRVUyhzdGF0dXMpKTsNCiAJCX0NCiAJ
fQ0KKwl0c3RfZXhpdCgpOw0KIH0NCiANCiAvKg0KLS0gDQoxLjYuMy4xDQoNCg==

------------W377DpSgEPbyoIuOhTUiTv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

------------W377DpSgEPbyoIuOhTUiTv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------------W377DpSgEPbyoIuOhTUiTv--


