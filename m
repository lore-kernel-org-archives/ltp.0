Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dthite@mvista.com>) id 1OqNR8-0000Y7-5h
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 09:47:26 +0000
Received: from mail-qy0-f175.google.com ([209.85.216.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OqNR7-0005zc-8S
	for ltp-list@lists.sourceforge.net; Tue, 31 Aug 2010 09:47:26 +0000
Received: by qyk31 with SMTP id 31so728318qyk.13
	for <ltp-list@lists.sourceforge.net>;
	Tue, 31 Aug 2010 02:47:19 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 31 Aug 2010 15:17:16 +0530
Message-ID: <AANLkTi=ShuJOPjaywptWgDaFFG9zhb_uk=_42bpwSavA@mail.gmail.com>
From: Deepti Thite <dthite@in.mvista.com>
Content-Type: multipart/mixed; boundary=000feaf115116640e5048f1b77a5
Subject: [LTP]  [PATCH] ld01
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
To: ltp-list@lists.sourceforge.net

--000feaf115116640e5048f1b77a5
Content-Type: multipart/alternative; boundary=000feaf115116640db048f1b77a3

--000feaf115116640db048f1b77a3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

ld01 test fails as native compilers don=92t match in the expected and outpu=
t
file.

The attached patch will grep expected results from the output file generate=
d
and will not create an expected results file.





Signed-off: Deepti Thite

--000feaf115116640db048f1b77a3
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>ld01 test
fails as native compilers don=92t match in the expected and output file.</s=
pan></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>The
attached patch will grep expected results from the output file generated an=
d
will not create an expected results file.</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>=A0</span></p>

<p class=3D"MsoNormal"><span style=3D"font-size: 10pt; font-family: Arial;"=
>Signed-off</span><code><span style=3D"font-size: 10pt;">: </span></code><s=
pan style=3D"font-size: 10pt; font-family: Arial;">Deepti Thite</span></p>

--000feaf115116640db048f1b77a3--

--000feaf115116640e5048f1b77a5
Content-Type: application/octet-stream; name="ld01.patch"
Content-Disposition: attachment; filename="ld01.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdikqsyx0

LS0tIGxkMDEgICAgICAgIDIwMTAtMDctMDMgMjM6NTk6MDYuMDAwMDAwMDAwICswNTMwDQorKysg
L21udC9ib3NjaC9vcHQvc3VpdGVzL2x0cC9sdHAtZnVsbC0yMDEwMDYzMC90ZXN0Y2FzZXMvY29t
bWFuZHMvYWRlL2xkL2xkMDEgIDIwMTAtMDgtMzEgMTI6MzU6MTYuMDAwMDAwMDAwICswNTMwDQpA
QCAtNzMsMTYgKzczLDI3IEBADQogI0NPREUNCiBlY2hvICJBc3NlcnRpb24gMiAuLi4uLi4uLi4u
Li4uLi4uLi4iDQogJENDIHgub2JqIHkub2JqIDI+ICRUQ3RtcC9lcnJtc2cub3V0DQotY2F0IDw8
RU9GID4gJFRDdG1wL2Vycm1zZy5leHANCi0kQ0M6IHgub2JqOiBObyBzdWNoIGZpbGUgb3IgZGly
ZWN0b3J5DQotJENDOiB5Lm9iajogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQ0KLSRDQzogTm8g
aW5wdXQgZmlsZXMNCi1FT0YNCg0KLWRpZmYgLWl3ICRUQ3RtcC9lcnJtc2cub3V0ICRUQ3RtcC9l
cnJtc2cuZXhwDQorZ3JlcCAiJENDOiIgJFRDdG1wL2Vycm1zZy5vdXQgfCBncmVwIHgub2JqIHwg
Z3JlcCAtcSAiTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSINCiBpZiBbICQ/IC1lcSAwIF0NCiB0
aGVuDQotICAgICAgIGVjaG8gICItKSINCisgICAgICAgZ3JlcCAiJENDOiIgJFRDdG1wL2Vycm1z
Zy5vdXQgfCBncmVwIHkub2JqIHwgZ3JlcCAtcSAiTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSIN
CisgICAgICAgaWYgWyAkPyAtZXEgMCBdDQorICAgICAgIHRoZW4NCisgICAgICAgICAgICAgICBn
cmVwICIkQ0M6IiAkVEN0bXAvZXJybXNnLm91dCB8IGdyZXAgLXEgIm5vIGlucHV0IGZpbGVzIg0K
KyAgICAgICAgICAgICAgIGlmIFsgJD8gLWVxIDAgXQ0KKyAgICAgICAgICAgICAgIHRoZW4NCisg
ICAgICAgICAgICAgICAgICAgICAgIGVjaG8gICItKSINCisgICAgICAgICAgICAgICBlbHNlDQor
ICAgICAgICAgICAgICAgICAgICAgICBlY2hvICJGQUlMIC0gIGxkIGZhaWxlZCB0byBnaXZlIGV4
cGVjdGVkIGVycm9yIG1zZyINCisgICAgICAgICAgICAgICAgICAgICAgIGRvX2NsZWFudXANCisg
ICAgICAgICAgICAgICAgICAgICAgIGV4aXQgMQ0KKyAgICAgICAgICAgICAgIGZpDQorICAgICAg
IGVsc2UNCisgICAgICAgICAgICAgICBlY2hvICJGQUlMIC0gIGxkIGZhaWxlZCB0byBnaXZlIGV4
cGVjdGVkIGVycm9yIG1zZyINCisgICAgICAgICAgICAgICAgICAgICAgIGRvX2NsZWFudXANCisg
ICAgICAgICAgICAgICBleGl0IDENCisgICAgICAgZmkNCiBlbHNlDQogICAgICAgIGVjaG8gIkZB
SUwgLSAgbGQgZmFpbGVkIHRvIGdpdmUgZXhwZWN0ZWQgZXJyb3IgbXNnIg0KICAgICAgICBkb19j
bGVhbnVwDQpAQCAtMTIwLDE1ICsxMzEsMTkgQEANCiAjQ09ERQ0KICAgICAgICBlY2hvICJBc3Nl
cnRpb24gNCAuLi4uLi4uLi4uLi4uLi4uLi4iDQogICAgICAgICRDQyBiYWQveC5vYmogMj4gJFRD
dG1wL2Vycm1zZy5vdXQNCi1jYXQgPDxFT0YgPiAkVEN0bXAvZXJybXNnLmV4cA0KLSRDQzogYmFk
L3gub2JqOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQotJENDOiBObyBpbnB1dCBmaWxlcw0K
LUVPRg0KDQotZGlmZiAtaXcgICRUQ3RtcC9lcnJtc2cub3V0ICRUQ3RtcC9lcnJtc2cuZXhwDQor
Y2F0ICRUQ3RtcC9lcnJtc2cub3V0IHwgZ3JlcCAiJENDOiIgfCBncmVwICJiYWQvW3h5XS5vYmo6
IiB8IGdyZXAgLXEgIk5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkiDQogaWYgWyAkPyAtZXEgMCBd
DQogdGhlbg0KLSAgICAgICBlY2hvICAiLSkiDQorICAgICAgIGNhdCAkVEN0bXAvZXJybXNnLm91
dCB8IGdyZXAgIiRDQzoiIHwgZ3JlcCAtcSAibm8gaW5wdXQgZmlsZXMiDQorICAgICAgIGlmIFsg
JD8gLWVxIDAgXQ0KKyAgICAgICB0aGVuDQorICAgICAgICAgICAgICAgZWNobyAgIi0pIg0KKyAg
ICAgICBlbHNlDQorICAgICAgICAgICAgICAgZWNobyAiRkFJTCAtICBsZCBmYWlsZWQgdG8gZ2l2
ZSBleHBlY3RlZCBlcnJvciBtc2ciDQorICAgICAgICAgICAgICAgZG9fY2xlYW51cA0KKyAgICAg
ICAgICAgICAgIGV4aXQgMQ0KKyAgICAgICBmaQ0KIGVsc2UNCiAgICAgICAgZWNobyAiRkFJTCAt
ICBsZCBmYWlsZWQgdG8gZ2l2ZSBleHBlY3RlZCBlcnJvciBtc2ciDQogICAgICAgIGRvX2NsZWFu
dXANCg0K
--000feaf115116640e5048f1b77a5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--000feaf115116640e5048f1b77a5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000feaf115116640e5048f1b77a5--

