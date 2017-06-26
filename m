Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ankitrtk@gmail.com>) id 1dPMZK-0007Ry-1T
	for ltp-list@lists.sourceforge.net; Mon, 26 Jun 2017 05:28:14 +0000
Received: from mail-wr0-f178.google.com ([209.85.128.178])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dPMZJ-0004ot-0E
	for ltp-list@lists.sourceforge.net; Mon, 26 Jun 2017 05:28:14 +0000
Received: by mail-wr0-f178.google.com with SMTP id 77so136591364wrb.1
	for <ltp-list@lists.sourceforge.net>;
	Sun, 25 Jun 2017 22:28:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACUy5SN4anXf9wE+wCTjSHK5O6EXtTCTfL96tvJJHtcOS3KSBA@mail.gmail.com>
References: <CACUy5SN4anXf9wE+wCTjSHK5O6EXtTCTfL96tvJJHtcOS3KSBA@mail.gmail.com>
From: ankit gupta <ankitrtk@gmail.com>
Date: Mon, 26 Jun 2017 10:58:06 +0530
Message-ID: <CACUy5SMbQ2=+OfVxSNz_6E2dVK6VgGPD7MGS9DYc6WSUrUjkgQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary="001a113c0e863abdcf0552d6372e"
Subject: [LTP] Fwd: LTP Ipv6_lib failures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--001a113c0e863abdcf0552d6372e
Content-Type: multipart/alternative; boundary="001a113c0e863abdca0552d6372c"

--001a113c0e863abdca0552d6372c
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am executing the LTP(20160126) tests for one of my board, and in it
Ipv6_lib is failing. below is the tests results and logs.

Test Start Time: Thu Jun 22 18:22:27 2017
-----------------------------------------
Testcase                       Result     Exit Value
--------                       ------     ----------
in6_01                         PASS       0
in6_02                         FAIL       4
getaddrinfo_01                 FAIL       1
asapi_01                       FAIL       2
asapi_02                       FAIL       2
asapi_03                       FAIL       2

-----------------------------------------------
Total Tests: 6
Total Skipped Tests: 0
Total Failures: 5
Kernel Version: 4.1.29-4.1-1.0.x-imx-dms-ba16+g8eaed11
Machine Architecture: armv7l
Hostname: Development-board


In this* getaddrinfo_01* is passing after I make entry of my host name in
/etc/hosts file, but rest 4 tests are still failing. I did not find any
failure reason in LTP bugs list.

Please see the attachment for individual tests execution logs and let me
know if something else is required from my side?

Thanks & Regards,
Ankit Gupta

--001a113c0e863abdca0552d6372c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><br><div dir=3D"ltr">Hi All,<di=
v><br></div><div>I am executing the LTP(20160126) tests for one of my board=
, and in it Ipv6_lib is failing. below is the tests results and logs.</div>=
<div><br></div><div><div>Test Start Time: Thu Jun 22 18:22:27 2017</div><di=
v>------------------------------<wbr>-----------</div><div>Testcase =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Resul=
t =C2=A0 =C2=A0 Exit Value</div><div>-------- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ------ =C2=A0 =C2=A0 -----=
-----</div><div>in6_01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PASS =C2=A0 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0</=
div><div>in6_02 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 FAIL =C2=A0 =C2=A0 =C2=A0 4 =C2=A0 =C2=A0</div><di=
v>getaddrinfo_01 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FA=
IL =C2=A0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0</div><div>asapi_01 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL =C2=A0 =
=C2=A0 =C2=A0 2 =C2=A0 =C2=A0</div><div>asapi_02 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL =C2=A0 =C2=A0 =C2=
=A0 2 =C2=A0 =C2=A0</div><div>asapi_03 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FAIL =C2=A0 =C2=A0 =C2=A0 2 =C2=
=A0 =C2=A0</div><div><br></div><div>------------------------------<wbr>----=
-------------</div><div>Total Tests: 6</div><div>Total Skipped Tests: 0</di=
v><div>Total Failures: 5</div><div>Kernel Version: 4.1.29-4.1-1.0.x-imx-dms=
-ba16+<wbr>g8eaed11</div><div>Machine Architecture: armv7l</div></div><div>=
Hostname: Development-board<br></div><div><br></div><div><br></div><div>In =
this<b> getaddrinfo_01</b> is passing after I make entry of my host name in=
 /etc/hosts file, but rest 4 tests are still failing. I did not find any fa=
ilure reason in LTP bugs list.</div><div><br></div><div>Please see the atta=
chment for individual tests execution logs and let me know if something els=
e is required from my side?</div><div><br></div><div>Thanks &amp; Regards,<=
/div><div>Ankit Gupta</div><div><br></div></div>
</div><br></div>

--001a113c0e863abdca0552d6372c--

--001a113c0e863abdcf0552d6372e
Content-Type: application/octet-stream; name=ipv6_lib_console_logs
Content-Disposition: attachment; filename=ipv6_lib_console_logs
Content-Transfer-Encoding: base64
X-Attachment-Id: f_j49h2lrm0

SU5GTzogY3JlYXRpbmcgL29wdC9sdHAvcmVzdWx0cyBkaXJlY3RvcnkKQ2hlY2tpbmcgZm9yIHJl
cXVpcmVkIHVzZXIvZ3JvdXAgaWRzCgonbm9ib2R5JyB1c2VyIGlkIGFuZCBncm91cCBmb3VuZC4K
J2JpbicgdXNlciBpZCBhbmQgZ3JvdXAgZm91bmQuCidkYWVtb24nIHVzZXIgaWQgYW5kIGdyb3Vw
IGZvdW5kLgpVc2VycyBncm91cCBmb3VuZC4KU3lzIGdyb3VwIGZvdW5kLgpSZXF1aXJlZCB1c2Vy
cy9ncm91cHMgZXhpc3QuCklmIHNvbWUgZmllbGRzIGFyZSBlbXB0eSBvciBsb29rIHVudXN1YWwg
eW91IG1heSBoYXZlIGFuIG9sZCB2ZXJzaW9uLgpDb21wYXJlIHRvIHRoZSBjdXJyZW50IG1pbmlt
YWwgcmVxdWlyZW1lbnRzIGluIERvY3VtZW50YXRpb24vQ2hhbmdlcy4KIAovZXRjL2lzc3VlOgpF
TE8gT1MgZGlzdHJpYnV0aW9uIGJhc2VkIG9uIFlvY3RvIDIuMS4xCkxpbnV4IERldmVsb3BtZW50
LUJvYXJkIDQuMS4yOS00LjEtMS4wLngtaW14LWRtcy1iYTE2K2c4ZWFlZDExICMxIFNNUCBQUkVF
TVBUIFdlZCBNYXkgMzEgMTc6NTU6MjYgSVNUIDIwMTcgYXJtdjdsIGFybXY3bCBhcm12N2wgR05V
L0xpbnV4CiAKR251IEMgICAgICAgICAgICAgICAgICBnY2MgKEdDQykgNS4zLjAKR251IG1ha2Ug
ICAgICAgICAgICAgICA0LjEKdXRpbC1saW51eCAgICAgICAgICAgICBsaW51eCAyLjI3LjEKbW91
bnQgICAgICAgICAgICAgICAgICBsaW51eCAyLjI3LjEgKGxpYm1vdW50IDIuMjcuMDogYXNzZXJ0
LCBkZWJ1ZykKbW9kdXRpbHMgICAgICAgICAgICAgICBkaXJlY3RvcnkKZTJmc3Byb2dzICAgICAg
ICAgICAgICAxLjQzLVdJUApMaW51eCBDIExpYnJhcnkgICAgICAgID4gbGliYy4yLjIzCkR5bmFt
aWMgbGlua2VyIChsZGQpICAgMi4yMwpMaW51eCBDKysgTGlicmFyeSAgICAgIDYuMC4yMQpQcm9j
cHMgICAgICAgICAgICAgICAgIDMuMy4xMQppcHJvdXRlMiAgICAgICAgICAgICAgaXByb3V0ZTIt
c3MxNjAxMTEKS2JkICAgICAgICAgICAgICAgICAgICA2OToKU2gtdXRpbHMgICAgICAgICAgICAg
ICA4LjI1Ck1vZHVsZXMgTG9hZGVkICAgICAgICAgY2RjX2V0aGVyIHVzYm5ldCBjZGNfYWNtIHVz
YmhpZCB1c2Jfc3RvcmFnZSBldmJ1ZyBjaV9oZHJjX2lteCBjaV9oZHJjIGVoY2lfaGNkIHVzYm1p
c2NfaW14IHVzYmNvcmUgbXhjX2RjaWMgdXNiX2NvbW1vbiBnYWxjb3JlCgpmcmVlIHJlcG9ydHM6
CiAgICAgICAgICAgICAgdG90YWwgICAgICAgIHVzZWQgICAgICAgIGZyZWUgICAgICBzaGFyZWQg
IGJ1ZmYvY2FjaGUgICBhdmFpbGFibGUKTWVtOiAgICAgICAgMjA2ODQ4OCAgICAgIDE1OTIwNCAg
ICAgMTg3MjUyMCAgICAgICAgNDI4NCAgICAgICAzNjc2NCAgICAgMTg4NDc0NApTd2FwOiAgICAg
ICAgICAgICAwICAgICAgICAgICAwICAgICAgICAgICAwCgovcHJvYy9jcHVpbmZvCnByb2Nlc3Nv
cgk6IDAKbW9kZWwgbmFtZQk6IEFSTXY3IFByb2Nlc3NvciByZXYgMTAgKHY3bCkKQm9nb01JUFMJ
OiA3LjU0CkZlYXR1cmVzCTogaGFsZiB0aHVtYiBmYXN0bXVsdCB2ZnAgZWRzcCBuZW9uIHZmcHYz
IHRscyB2ZnBkMzIgCkNQVSBpbXBsZW1lbnRlcgk6IDB4NDEKQ1BVIGFyY2hpdGVjdHVyZTogNwpD
UFUgdmFyaWFudAk6IDB4MgpDUFUgcGFydAk6IDB4YzA5CkNQVSByZXZpc2lvbgk6IDEwCgpwcm9j
ZXNzb3IJOiAxCm1vZGVsIG5hbWUJOiBBUk12NyBQcm9jZXNzb3IgcmV2IDEwICh2N2wpCkJvZ29N
SVBTCTogNy41NApGZWF0dXJlcwk6IGhhbGYgdGh1bWIgZmFzdG11bHQgdmZwIGVkc3AgbmVvbiB2
ZnB2MyB0bHMgdmZwZDMyIApDUFUgaW1wbGVtZW50ZXIJOiAweDQxCkNQVSBhcmNoaXRlY3R1cmU6
IDcKQ1BVIHZhcmlhbnQJOiAweDIKQ1BVIHBhcnQJOiAweGMwOQpDUFUgcmV2aXNpb24JOiAxMAoK
SGFyZHdhcmUJOiBGcmVlc2NhbGUgaS5NWDYgUXVhZC9EdWFsTGl0ZSAoRGV2aWNlIFRyZWUpClJl
dmlzaW9uCTogMDAwMApTZXJpYWwJCTogMDAwMDAwMDAwMDAwMDAwMApubyBiaWcgYmxvY2sgZGV2
aWNlIHdhcyBzcGVjaWZpZWQgb24gY29tbWFuZGxpbmUuClRlc3RzIHdoaWNoIHJlcXVpcmUgYSBi
aWcgYmxvY2sgZGV2aWNlIGFyZSBkaXNhYmxlZC4KWW91IGNhbiBzcGVjaWZ5IGl0IHdpdGggb3B0
aW9uIC16CkNPTU1BTkQ6ICAgIC9vcHQvbHRwL2Jpbi9sdHAtcGFuICAtZSAtUyAgIC1hIDMwMjI4
ICAgICAtbiAzMDIyOCAgLXAgIC1mIC90bXAvbHRwLXhCSGNKR01qNnQvYWxsdGVzdHMgLWwgL29w
dC9sdHAvcmVzdWx0cy9pcHY2X2xpYl9sb2dzICAtQyAvb3B0L2x0cC9vdXRwdXQvTFRQX1JVTl9P
Ti1pcHY2X2xpYl9sb2dzLmZhaWxlZCAtVCAvb3B0L2x0cC9vdXRwdXQvTFRQX1JVTl9PTi1pcHY2
X2xpYl9sb2dzLnRjb25mCkxPRyBGaWxlOiAvb3B0L2x0cC9yZXN1bHRzL2lwdjZfbGliX2xvZ3MK
RkFJTEVEIENPTU1BTkQgRmlsZTogL29wdC9sdHAvb3V0cHV0L0xUUF9SVU5fT04taXB2Nl9saWJf
bG9ncy5mYWlsZWQKVENPTkYgQ09NTUFORCBGaWxlOiAvb3B0L2x0cC9vdXRwdXQvTFRQX1JVTl9P
Ti1pcHY2X2xpYl9sb2dzLnRjb25mClJ1bm5pbmcgdGVzdHMuLi4uLi4uCjw8PHRlc3Rfc3RhcnQ+
Pj4KdGFnPWluNl8wMSBzdGltZT0xNDk4MjQwMjM2CmNtZGxpbmU9ImluNl8wMSIKY29udGFjdHM9
IiIKYW5hbHlzaXM9ZXhpdAo8PDx0ZXN0X291dHB1dD4+PgppbjZfMDEgICAgICAwICBUSU5GTyAg
OiAgdHlwZSBvZiBpbjYuczZfYWRkclswXSBpcyB1aW50OF90CmluNl8wMSAgICAgIDEgIFRQQVNT
ICA6ICBzaXplb2YoaW42LnM2X2FkZHIpID09IDE2CmluNl8wMSAgICAgIDIgIFRQQVNTICA6ICBh
bGwgc29ja2FkZHJfaW42IGZpZWxkcyBwcmVzZW50IGFuZCBjb3JyZWN0CmluNl8wMSAgICAgIDAg
IFRJTkZPICA6ICBJTjZBRERSX0FOWV9JTklUIHByZXNlbnQKaW42XzAxICAgICAgMCAgVElORk8g
IDogIGluNmFkZHJfYW55IHByZXNlbnQgYW5kIGNvcnJlY3QKaW42XzAxICAgICAgMCAgVElORk8g
IDogIElONkFERFJfTE9PUEJBQ0tfSU5JVCBwcmVzZW50CmluNl8wMSAgICAgIDAgIFRJTkZPICA6
ICBpbjZhZGRyX2xvb3BiYWNrIHByZXNlbnQgYW5kIGNvcnJlY3QKaW42XzAxICAgICAgMCAgVElO
Rk8gIDogIGluNmFkZHJfbG9vcGJhY2sgaW4gbmV0d29yayBieXRlIG9yZGVyCmluNl8wMSAgICAg
IDMgIFRQQVNTICA6ICBnbG9iYWwgaW42IGRlZmluaXRpb25zIHRlc3RzIHN1Y2NlZWQKaW42XzAx
ICAgICAgMCAgVElORk8gIDogIElONl9JU19BRERSX1Y0TUFQUEVEKCIyMDAyOjoxIikgMAppbjZf
MDEgICAgICAwICBUSU5GTyAgOiAgSU42X0lTX0FERFJfVjRNQVBQRUQoIjo6ZmZmZjoxMC4wLjAu
MSIpIDEKaW42XzAxICAgICAgMCAgVElORk8gIDogIElONl9JU19BRERSX1Y0TUFQUEVEKCI6OmZm
ZmU6MTAuMC4wLjEiKSAwCmluNl8wMSAgICAgIDAgIFRJTkZPICA6ICBJTjZfSVNfQUREUl9WNE1B
UFBFRCgiOjo3ZmZmOjEwLjAuMC4xIikgMAppbjZfMDEgICAgICAwICBUSU5GTyAgOiAgSU42X0lT
X0FERFJfVjRNQVBQRUQoIjA6MDowOjA6MDowOmZmZmY6MGEwMDEiKSAwCmluNl8wMSAgICAgIDAg
IFRJTkZPICA6ICBJTjZfSVNfQUREUl9WNE1BUFBFRCgiMDowOjE6MDowOjA6ZmZmZjowYTAwMSIp
IDAKaW42XzAxICAgICAgNCAgVFBBU1MgIDogIElONl9JU19BRERSX1Y0TUFQUEVEIHRlc3RzIHN1
Y2NlZWQKaW42XzAxICAgICAgMCAgVElORk8gIDogICIyMDAyOjoxIiBpcyBBRl9JTkVUNgppbjZf
MDEgICAgICAwICBUSU5GTyAgOiAgIjEwLjAuMC4xIiBpcyBBRl9JTkVUCmluNl8wMSAgICAgIDAg
IFRJTkZPICA6ICAiOjpmZmZmOjEwLjAuMC4xIiBpcyBBRl9JTkVUNgppbjZfMDEgICAgICAwICBU
SU5GTyAgOiAgIjo6MSIgaXMgQUZfSU5FVDYKaW42XzAxICAgICAgMCAgVElORk8gIDogICI6OiIg
aXMgQUZfSU5FVDYKaW42XzAxICAgICAgNSAgVFBBU1MgIDogIHNvY2thZGRyX3N0b3JhZ2UgdGVz
dHMgc3VjY2VlZAo8PDxleGVjdXRpb25fc3RhdHVzPj4+CmluaXRpYXRpb25fc3RhdHVzPSJvayIK
ZHVyYXRpb249MCB0ZXJtaW5hdGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlvbl9pZD0wIGNvcmVm
aWxlPW5vCmN1dGltZT0wIGNzdGltZT0wCjw8PHRlc3RfZW5kPj4+Cjw8PHRlc3Rfc3RhcnQ+Pj4K
dGFnPWluNl8wMiBzdGltZT0xNDk4MjQwMjM2CmNtZGxpbmU9ImluNl8wMiIKY29udGFjdHM9IiIK
YW5hbHlzaXM9ZXhpdAo8PDx0ZXN0X291dHB1dD4+PgppbjZfMDIgICAgICAwICBUSU5GTyAgOiAg
Z2V0IGludGVyZmFjZSBuYW1lIGZyb20gTEhPU1RfSUZBQ0VTIHZhcgppbjZfMDIgICAgICAwICBU
V0FSTiAgOiAgaW42XzAyLmM6MjY0OiBMSE9TVF9JRkFDRVMgbm90IGRlZmluZWQsIGRlZmF1bHQg
dG8gZXRoMAppbjZfMDIgICAgICAwICBUSU5GTyAgOiAgaWZfbmFtZXRvaW5kZXgoImxvIikgMQpp
bjZfMDIgICAgICAwICBUSU5GTyAgOiAgaWZfbmFtZXRvaW5kZXgoImV0aDAiKSAyCmluNl8wMiAg
ICAgIDAgIFRJTkZPICA6ICBpZl9uYW1ldG9pbmRleCgiaG9zZXI3NSIpIDAKaW42XzAyICAgICAg
MCAgVElORk8gIDogIGlmX25hbWV0b2luZGV4KCI2IikgMAppbjZfMDIgICAgICAxICBUUEFTUyAg
OiAgaWZfbmFtZXRvaW5kZXgoKSB0ZXN0cyBzdWNjZWVkCmluNl8wMiAgICAgIDAgIFRJTkZPICA6
ICBpZl9pbmRleHRvbmFtZSgwKSByZXR1cm5zIE5VTEwKaW42XzAyICAgICAgMCAgVElORk8gIDog
IGlmX2luZGV4dG9uYW1lKDEpIHJldHVybnMgImxvIgppbjZfMDIgICAgICAwICBUSU5GTyAgOiAg
aWZfaW5kZXh0b25hbWUoMikgcmV0dXJucyAiZXRoMCIKaW42XzAyICAgICAgMCAgVElORk8gIDog
IGlmX2luZGV4dG9uYW1lKDMpIHJldHVybnMgInNpdDAiCmluNl8wMiAgICAgIDAgIFRJTkZPICA6
ICBpZl9pbmRleHRvbmFtZSg0KSByZXR1cm5zIE5VTEwKaW42XzAyICAgICAgMCAgVElORk8gIDog
IGlmX2luZGV4dG9uYW1lKDUpIHJldHVybnMgTlVMTAppbjZfMDIgICAgICAwICBUSU5GTyAgOiAg
aWZfaW5kZXh0b25hbWUoNikgcmV0dXJucyBOVUxMCmluNl8wMiAgICAgIDAgIFRJTkZPICA6ICBp
Zl9pbmRleHRvbmFtZSg3KSByZXR1cm5zIE5VTEwKaW42XzAyICAgICAgMCAgVElORk8gIDogIGlm
X2luZGV4dG9uYW1lKDgpIHJldHVybnMgTlVMTAppbjZfMDIgICAgICAwICBUSU5GTyAgOiAgaWZf
aW5kZXh0b25hbWUoOSkgcmV0dXJucyBOVUxMCmluNl8wMiAgICAgIDAgIFRJTkZPICA6ICBpZl9p
bmRleHRvbmFtZSgxODA0Mjg5MzgzKSByZXR1cm5zIE5VTEwKaW42XzAyICAgICAgMCAgVElORk8g
IDogIGlmX2luZGV4dG9uYW1lKDg0NjkzMDg4NikgcmV0dXJucyBOVUxMCmluNl8wMiAgICAgIDAg
IFRJTkZPICA6ICBpZl9pbmRleHRvbmFtZSgxNjgxNjkyNzc3KSByZXR1cm5zIE5VTEwKaW42XzAy
ICAgICAgMCAgVElORk8gIDogIGlmX2luZGV4dG9uYW1lKDE3MTQ2MzY5MTUpIHJldHVybnMgTlVM
TAppbjZfMDIgICAgICAwICBUSU5GTyAgOiAgaWZfaW5kZXh0b25hbWUoMTk1Nzc0Nzc5MykgcmV0
dXJucyBOVUxMCmluNl8wMiAgICAgIDAgIFRJTkZPICA6ICBpZl9pbmRleHRvbmFtZSg0MjQyMzgz
MzUpIHJldHVybnMgTlVMTAppbjZfMDIgICAgICAwICBUSU5GTyAgOiAgaWZfaW5kZXh0b25hbWUo
NzE5ODg1Mzg2KSByZXR1cm5zIE5VTEwKaW42XzAyICAgICAgMCAgVElORk8gIDogIGlmX2luZGV4
dG9uYW1lKDE2NDk3NjA0OTIpIHJldHVybnMgTlVMTAppbjZfMDIgICAgICAwICBUSU5GTyAgOiAg
aWZfaW5kZXh0b25hbWUoNTk2NTE2NjQ5KSByZXR1cm5zIE5VTEwKaW42XzAyICAgICAgMCAgVElO
Rk8gIDogIGlmX2luZGV4dG9uYW1lKDExODk2NDE0MjEpIHJldHVybnMgTlVMTAppbjZfMDIgICAg
ICAyICBUUEFTUyAgOiAgaWZfaW5kZXh0b25hbWUoKSB0ZXN0cyBzdWNjZWVkCmluNl8wMiAgICAg
IDAgIFRJTkZPICA6ICBpZl9uYW1laW5kZXggaWR4IDEgbmFtZSAibG8iCmluNl8wMiAgICAgIDAg
IFRJTkZPICA6ICBpZl9uYW1laW5kZXggaWR4IDIgbmFtZSAiZXRoMCIKaW42XzAyICAgICAgMCAg
VElORk8gIDogIGlmX25hbWVpbmRleCBpZHggMyBuYW1lICJzaXQwIgppbjZfMDIgICAgICAwICBU
SU5GTyAgOiAgaWZfZnJlZW5hbWVpbmRleCBwYXNzZWQgNDA5NiBpdGVyYXRpb25zCmluNl8wMiAg
ICAgIDMgIFRQQVNTICA6ICBpZl9uYW1laW5kZXgoKSB0ZXN0cyBzdWNjZWVkCjw8PGV4ZWN1dGlv
bl9zdGF0dXM+Pj4KaW5pdGlhdGlvbl9zdGF0dXM9Im9rIgpkdXJhdGlvbj0wIHRlcm1pbmF0aW9u
X3R5cGU9ZXhpdGVkIHRlcm1pbmF0aW9uX2lkPTQgY29yZWZpbGU9bm8KY3V0aW1lPTMgY3N0aW1l
PTM2Cjw8PHRlc3RfZW5kPj4+Cjw8PHRlc3Rfc3RhcnQ+Pj4KdGFnPWdldGFkZHJpbmZvXzAxIHN0
aW1lPTE0OTgyNDAyMzYKY21kbGluZT0iZ2V0YWRkcmluZm9fMDEiCmNvbnRhY3RzPSIiCmFuYWx5
c2lzPWV4aXQKPDw8dGVzdF9vdXRwdXQ+Pj4KZ2V0YWRkcmluZm9fMDEgICAgMSAgVFBBU1MgIDog
IGdldGFkZHJpbmZvIElQdjQgYmFzaWMgbG9va3VwCmdldGFkZHJpbmZvXzAxICAgIDIgIFRQQVNT
ICA6ICBnZXRhZGRyaW5mbyBJUHY0IGNhbm9uaWNhbCBuYW1lCmdldGFkZHJpbmZvXzAxICAgIDMg
IFRQQVNTICA6ICBnZXRhZGRyaW5mbyBJUHY0IGhvc3Qrc2VydmljZQpnZXRhZGRyaW5mb18wMSAg
ICA0ICBUUEFTUyAgOiAgZ2V0YWRkcmluZm8gSVB2NCBob3N0K3NlcnZpY2UgUEFTU0lWRQpnZXRh
ZGRyaW5mb18wMSAgICA1ICBUUEFTUyAgOiAgZ2V0YWRkcmluZm8gSVB2NCBBSV9OVU1FUklDSE9T
VCB3LyBob3N0bmFtZQpnZXRhZGRyaW5mb18wMSAgICA2ICBUUEFTUyAgOiAgZ2V0YWRkcmluZm8g
SVB2NCAwK3NlcnZpY2UsIFBBU1NJVkUKZ2V0YWRkcmluZm9fMDEgICAgNyAgVFBBU1MgIDogIGdl
dGFkZHJpbmZvIElQdjQgMCtzZXJ2aWNlCmdldGFkZHJpbmZvXzAxICAgIDggIFRQQVNTICA6ICBn
ZXRhZGRyaW5mbyBJUHY0IGhvc3Qrc2VydmljZSwgQUlfTlVNRVJJQ1NFUlYKZ2V0YWRkcmluZm9f
MDEgICAgOSAgVFBBU1MgIDogIGdldGFkZHJpbmZvIElQdjQgU09DS19TVFJFQU0vSVBQUk9UT19V
RFAgaGludHMKZ2V0YWRkcmluZm9fMDEgICAxMCAgVFBBU1MgIDogIGdldGFkZHJpbmZvIElQdjQg
c29ja3R5cGUgMCw1MTMKZ2V0YWRkcmluZm9fMDEgICAxMSAgVFBBU1MgIDogIGdldGFkZHJpbmZv
IElQdjQgQUlfVjRNQVBQRUQKZ2V0YWRkcmluZm9fMDEgICAxMiAgVFBBU1MgIDogIGdldGFkZHJp
bmZvIElQdjYgYmFzaWMgbG9va3VwCmdldGFkZHJpbmZvXzAxICAgMTMgIFRQQVNTICA6ICBnZXRh
ZGRyaW5mbyBJUHY2IGNhbm9uaWNhbCBuYW1lCmdldGFkZHJpbmZvXzAxICAgMTQgIFRQQVNTICA6
ICBnZXRhZGRyaW5mbyBJUHY2IGhvc3Qrc2VydmljZQpnZXRhZGRyaW5mb18wMSAgIDE1ICBUUEFT
UyAgOiAgZ2V0YWRkcmluZm8gSVB2NiBob3N0K3NlcnZpY2UgUEFTU0lWRQpnZXRhZGRyaW5mb18w
MSAgIDE2ICBUUEFTUyAgOiAgZ2V0YWRkcmluZm8gSVB2NiBBSV9OVU1FUklDSE9TVCB3LyBob3N0
bmFtZQpnZXRhZGRyaW5mb18wMSAgIDE3ICBUUEFTUyAgOiAgZ2V0YWRkcmluZm8gSVB2NiAwK3Nl
cnZpY2UsIFBBU1NJVkUKZ2V0YWRkcmluZm9fMDEgICAxOCAgVFBBU1MgIDogIGdldGFkZHJpbmZv
IElQdjYgMCtzZXJ2aWNlCmdldGFkZHJpbmZvXzAxICAgMTkgIFRQQVNTICA6ICBnZXRhZGRyaW5m
byBJUHY2IGhvc3Qrc2VydmljZSwgQUlfTlVNRVJJQ1NFUlYKZ2V0YWRkcmluZm9fMDEgICAyMCAg
VFBBU1MgIDogIGdldGFkZHJpbmZvIElQdjYgU09DS19TVFJFQU0vSVBQUk9UT19VRFAgaGludHMK
Z2V0YWRkcmluZm9fMDEgICAyMSAgVFBBU1MgIDogIGdldGFkZHJpbmZvIElQdjYgc29ja3R5cGUg
MCw1MTMKZ2V0YWRkcmluZm9fMDEgICAyMiAgVFBBU1MgIDogIGdldGFkZHJpbmZvIElQdjYgQUlf
VjRNQVBQRUQKPDw8ZXhlY3V0aW9uX3N0YXR1cz4+Pgppbml0aWF0aW9uX3N0YXR1cz0ib2siCmR1
cmF0aW9uPTAgdGVybWluYXRpb25fdHlwZT1leGl0ZWQgdGVybWluYXRpb25faWQ9MCBjb3JlZmls
ZT1ubwpjdXRpbWU9MSBjc3RpbWU9MAo8PDx0ZXN0X2VuZD4+Pgo8PDx0ZXN0X3N0YXJ0Pj4+CnRh
Zz1hc2FwaV8wMSBzdGltZT0xNDk4MjQwMjM2CmNtZGxpbmU9ImFzYXBpXzAxIgpjb250YWN0cz0i
IgphbmFseXNpcz1leGl0Cjw8PHRlc3Rfb3V0cHV0Pj4+CmFzYXBpXzA0ICAgIDEgIFRQQVNTICA6
ICBJTjZfQVJFX0FERFJfRVFVQUwKYXNhcGlfMDQgICAgMiAgVFBBU1MgIDogICJob3BvcHQiIHBy
b3RvY29scyBlbnRyeQphc2FwaV8wNCAgICAzICBUUEFTUyAgOiAgImlwdjYiIHByb3RvY29scyBl
bnRyeQphc2FwaV8wNCAgICA0ICBUUEFTUyAgOiAgImlwdjYtcm91dGUiIHByb3RvY29scyBlbnRy
eQphc2FwaV8wNCAgICA1ICBUUEFTUyAgOiAgImlwdjYtZnJhZyIgcHJvdG9jb2xzIGVudHJ5CmFz
YXBpXzA0ICAgIDYgIFRQQVNTICA6ICAiZXNwIiBwcm90b2NvbHMgZW50cnkKYXNhcGlfMDQgICAg
NyAgVFBBU1MgIDogICJhaCIgcHJvdG9jb2xzIGVudHJ5CmFzYXBpXzA0ICAgIDggIFRQQVNTICA6
ICAiaXB2Ni1pY21wIiBwcm90b2NvbHMgZW50cnkKYXNhcGlfMDQgICAgOSAgVFBBU1MgIDogICJp
cHY2LW5vbnh0IiBwcm90b2NvbHMgZW50cnkKYXNhcGlfMDQgICAxMCAgVFBBU1MgIDogICJpcHY2
LW9wdHMiIHByb3RvY29scyBlbnRyeQphc2FwaV8wNCAgIDExICBUQlJPSyAgOiAgc2FmZV9uZXQu
YzoxNjI6IGFzYXBpXzAxLmM6MzY5OiBjb25uZWN0KDcsIDEyNy4wLjAuMTo0OTI2NiwgMTYpIGZh
aWxlZDogZXJybm89RU5FVFVOUkVBQ0goMTAxKTogTmV0d29yayBpcyB1bnJlYWNoYWJsZQphc2Fw
aV8wNCAgIDEyICBUQlJPSyAgOiAgc2FmZV9uZXQuYzoxNjI6IFJlbWFpbmluZyBjYXNlcyBicm9r
ZW4KPDw8ZXhlY3V0aW9uX3N0YXR1cz4+Pgppbml0aWF0aW9uX3N0YXR1cz0ib2siCmR1cmF0aW9u
PTAgdGVybWluYXRpb25fdHlwZT1leGl0ZWQgdGVybWluYXRpb25faWQ9MiBjb3JlZmlsZT1ubwpj
dXRpbWU9MCBjc3RpbWU9MQo8PDx0ZXN0X2VuZD4+Pgo8PDx0ZXN0X3N0YXJ0Pj4+CnRhZz1hc2Fw
aV8wMiBzdGltZT0xNDk4MjQwMjM2CmNtZGxpbmU9ImFzYXBpXzAyIgpjb250YWN0cz0iIgphbmFs
eXNpcz1leGl0Cjw8PHRlc3Rfb3V0cHV0Pj4+CmFzYXBpXzA1ICAgIDEgIFRCUk9LICA6ICBhc2Fw
aV8wMi5jOjExMDogSUNNUDZfRklMVEVSX1NFVFBBU1MgcyAyMCBmIDIwOiBzZW5kdG8gZmFpbGVk
OiBlcnJubz1FQUREUk5PVEFWQUlMKDk5KTogQ2Fubm90IGFzc2lnbiByZXF1ZXN0ZWQgYWRkcmVz
cwphc2FwaV8wNSAgICAyICBUQlJPSyAgOiAgYXNhcGlfMDIuYzoxMTA6IElDTVA2X0ZJTFRFUl9T
RVRQQVNTIHMgMjAgZiAyMTogc2VuZHRvIGZhaWxlZDogZXJybm89RUFERFJOT1RBVkFJTCg5OSk6
IENhbm5vdCBhc3NpZ24gcmVxdWVzdGVkIGFkZHJlc3MKYXNhcGlfMDUgICAgMyAgVEJST0sgIDog
IGFzYXBpXzAyLmM6MTEwOiBJQ01QNl9GSUxURVJfU0VUQkxPQ0sgcyAyMCBmIDIwOiBzZW5kdG8g
ZmFpbGVkOiBlcnJubz1FQUREUk5PVEFWQUlMKDk5KTogQ2Fubm90IGFzc2lnbiByZXF1ZXN0ZWQg
YWRkcmVzcwphc2FwaV8wNSAgICA0ICBUQlJPSyAgOiAgYXNhcGlfMDIuYzoxMTA6IElDTVA2X0ZJ
TFRFUl9TRVRCTE9DSyBzIDIwIGYgMjE6IHNlbmR0byBmYWlsZWQ6IGVycm5vPUVBRERSTk9UQVZB
SUwoOTkpOiBDYW5ub3QgYXNzaWduIHJlcXVlc3RlZCBhZGRyZXNzCmFzYXBpXzA1ICAgIDUgIFRC
Uk9LICA6ICBhc2FwaV8wMi5jOjExMDogSUNNUDZfRklMVEVSX1BBU1NBTEwgcyAyMDogc2VuZHRv
IGZhaWxlZDogZXJybm89RUFERFJOT1RBVkFJTCg5OSk6IENhbm5vdCBhc3NpZ24gcmVxdWVzdGVk
IGFkZHJlc3MKYXNhcGlfMDUgICAgNiAgVEJST0sgIDogIGFzYXBpXzAyLmM6MTEwOiBJQ01QNl9G
SUxURVJfUEFTU0FMTCBzIDIwOiBzZW5kdG8gZmFpbGVkOiBlcnJubz1FQUREUk5PVEFWQUlMKDk5
KTogQ2Fubm90IGFzc2lnbiByZXF1ZXN0ZWQgYWRkcmVzcwphc2FwaV8wNSAgICA3ICBUQlJPSyAg
OiAgYXNhcGlfMDIuYzoxMTA6IElDTVA2X0ZJTFRFUl9CTE9DS0FMTCBzIDIwOiBzZW5kdG8gZmFp
bGVkOiBlcnJubz1FQUREUk5PVEFWQUlMKDk5KTogQ2Fubm90IGFzc2lnbiByZXF1ZXN0ZWQgYWRk
cmVzcwphc2FwaV8wNSAgICA4ICBUQlJPSyAgOiAgYXNhcGlfMDIuYzoxMTA6IElDTVA2X0ZJTFRF
Ul9CTE9DS0FMTCBzIDIwOiBzZW5kdG8gZmFpbGVkOiBlcnJubz1FQUREUk5PVEFWQUlMKDk5KTog
Q2Fubm90IGFzc2lnbiByZXF1ZXN0ZWQgYWRkcmVzcwo8PDxleGVjdXRpb25fc3RhdHVzPj4+Cmlu
aXRpYXRpb25fc3RhdHVzPSJvayIKZHVyYXRpb249MCB0ZXJtaW5hdGlvbl90eXBlPWV4aXRlZCB0
ZXJtaW5hdGlvbl9pZD0yIGNvcmVmaWxlPW5vCmN1dGltZT0wIGNzdGltZT0wCjw8PHRlc3RfZW5k
Pj4+Cjw8PHRlc3Rfc3RhcnQ+Pj4KdGFnPWFzYXBpXzAzIHN0aW1lPTE0OTgyNDAyMzYKY21kbGlu
ZT0iYXNhcGlfMDMiCmNvbnRhY3RzPSIiCmFuYWx5c2lzPWV4aXQKPDw8dGVzdF9vdXRwdXQ+Pj4K
YXNhcGlfMDYgICAgMSAgVEJST0sgIDogIHNhZmVfbmV0LmM6MTE2OiBhc2FwaV8wMy5jOjI2MTog
YmluZCg2LCA6OjEsIDI4KSBmYWlsZWQ6IGVycm5vPUVBRERSTk9UQVZBSUwoOTkpOiBDYW5ub3Qg
YXNzaWduIHJlcXVlc3RlZCBhZGRyZXNzCmFzYXBpXzA2ICAgIDIgIFRCUk9LICA6ICBzYWZlX25l
dC5jOjExNjogUmVtYWluaW5nIGNhc2VzIGJyb2tlbgppbmNyZW1lbnRpbmcgc3RvcAo8PDxleGVj
dXRpb25fc3RhdHVzPj4+CmluaXRpYXRpb25fc3RhdHVzPSJvayIKZHVyYXRpb249MCB0ZXJtaW5h
dGlvbl90eXBlPWV4aXRlZCB0ZXJtaW5hdGlvbl9pZD0yIGNvcmVmaWxlPW5vCmN1dGltZT0wIGNz
dGltZT0wCjw8PHRlc3RfZW5kPj4+CklORk86IGx0cC1wYW4gcmVwb3J0ZWQgc29tZSB0ZXN0cyBG
QUlMCkxUUCBWZXJzaW9uOiAyMDE2MDEyNgoKICAgICAgICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwoKICAgICAgICAgICAgRG9u
ZSBleGVjdXRpbmcgdGVzdGNhc2VzLgogICAgICAgICAgICBMVFAgVmVyc2lvbjogIDIwMTYwMTI2
CiAgICAgICAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKCg==
--001a113c0e863abdcf0552d6372e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
--001a113c0e863abdcf0552d6372e
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001a113c0e863abdcf0552d6372e--

