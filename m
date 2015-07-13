Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mawentao@inspur.com>) id 1ZEZBz-0005NQ-8Z
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 08:34:27 +0000
Received: from vip.corpemail.net ([162.243.126.186])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZEZBr-0000ZQ-CM
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 08:34:27 +0000
Received: from sg02.corpemail.net ([128.199.154.28])
	by vip.corpemail.net ((O)) with ESMTP (SSL) id BHW00107
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jul 2015 16:34:07 +0800
Received: from unicom154.biz-email.net ([112.65.243.252])
	by sg02.corpemail.net ((B_Out)) with ESMTP (SSL) id BHV00051
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jul 2015 16:33:51 +0800
Received: from unicom145.biz-email.net ([192.168.0.69])
	by unicom154.biz-email.net ((Trust)) with ESMTP (SSL) id BHV00139
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Jul 2015 16:33:39 +0800
Date: Mon, 13 Jul 2015 16:33:31 +0800
From: "mawentao@inspur.com" <mawentao@inspur.com>
References: <1436426857-7322-1-git-send-email-mawentao@inspur.com>, 
	<55A3610F.5000703@cn.fujitsu.com>
MIME-Version: 1.0
Message-ID: <2015071316333140061425@inspur.com>
Subject: Re: [LTP] [PATCH] acls: Solve a problem from acl_test01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3219352404613589463=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: "wunan@inspur.com" <wunan@inspur.com>

--===============3219352404613589463==
Content-Type: multipart/alternative;
	boundary="----=_001_NextPart763781636720_=----"

------=_001_NextPart763781636720_=----
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

VGhhbmtzIFdhbmxvbmcgR2FvLCB3ZSBzZXQgdGhlIFNFTGludXggbW9kZSB0byBwZXJtaXNzaXZl
IGFuZCB0aGUgdGVzdCBwYXNzZXMuIA0KdGhlIGVycm9yIGlzIGNhdXNlZCBieSB0aGUgU0VMaW51
eCwgZmluYWxseSB3ZSBtb2RpZnkgdGhlIHBhdGNoLg0KDQoNCj4gVGhlIGZhaWxlZCBpbmZvcm5h
bXRpb24gaXMgYXMgZm9sbG93Og0KPiB1c2VyYWRkOiBjYW5ub3Qgc2V0IFNFTGludXggY29udGV4
dCBmb3INCj4gaG9tZSBkaXJlY3RvcnkgL3RtcC90YWNsL21vdW50LWV4dDMvYWNsdGVzdDENCj4N
Cj4gdGhpcyBpcyBjYXVzZWQgYnkgU0VMaW51eCwgdGhlIFNFTGludXggbW9kZSBpcyBlbmZvcmNp
bmcNCj4gc2V0IHRoZSBtb2RlIHRvIHBlcm1pc3NpdmUgYmVmb3JlIGFkZGluZyB1c2VyIGFjbF90
ZXN0MQ0KPiB0aGVuIHNldCBpdCB0byB0aGUgZGVmYXVsdCBtb2RlIGVuZm9yY2luZy4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogV2VudGFvIE1hIDxtYXdlbnRhb0BpbnNwdXIuY29tPg0KPiAtLS0NCj4g
ICB0ZXN0Y2FzZXMva2VybmVsL2ZzL2FjbHMvYWNsX3Rlc3QwMSB8IDIgKysNCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL2ZzL2FjbHMvYWNsX3Rlc3QwMSBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNscy9hY2xfdGVz
dDAxDQo+IGluZGV4IDMyOGZmNzQuLmUzOGUzOWIgMTAwNzU1DQo+IC0tLSBhL3Rlc3RjYXNlcy9r
ZXJuZWwvZnMvYWNscy9hY2xfdGVzdDAxDQo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvYWNs
cy9hY2xfdGVzdDAxDQo+IEBAIC04Nyw3ICs4Nyw5IEBAIGRvX3NldHVwKCl7DQo+ICAgcm0gLXJm
ICRURVNUX1VTRVIxX0hPTUVESVINCj4gICB1c2VyZGVsICRURVNUX1VTRVIxID4gL2Rldi9udWxs
IDI+JjENCj4gICBzbGVlcCAxDQo+ICsgc2V0ZW5mb3JjZSAwDQo+ICAgdXNlcmFkZCAtZCAkVEVT
VF9VU0VSMV9IT01FRElSIC1tIC1nICRURVNUX1VTRVIxX0dST1VQICRURVNUX1VTRVIxIC1zIC9i
aW4vc2gNCj4gKyBzZXRlbmZvcmNlIDENCj4gIA0KPiAgIGlmIFsgJD8gLW5lIDAgXTsgdGhlbg0K
PiAgIHRzdF9icmttIFRCUk9LICJDb3VsZCBub3QgYWRkIHRlc3QgdXNlciAkVEVTVF9VU0VSMS4i
DQoNCg0KDQptYXdlbnRhb0BpbnNwdXIuY29tDQogDQpGcm9tOiBXYW5sb25nIEdhbw0KRGF0ZTog
MjAxNS0wNy0xMyAxNDo1Ng0KVG86IFdlbnRhbyBNYTsgbHRwLWxpc3RAbGlzdHMuc291cmNlZm9y
Z2UubmV0DQpDQzogd3VuYW5AaW5zcHVyLmNvbQ0KU3ViamVjdDogUmU6IFtMVFBdIFtQQVRDSF0g
YWNsczogU29sdmUgYSBwcm9ibGVtIGZyb20gYWNsX3Rlc3QwMQ0KT24gMDcvMDkvMjAxNSAwMzoy
NyBQTSwgV2VudGFvIE1hIHdyb3RlOg0KPiBUaGUgZmFpbGVkIGluZm9ybmFtdGlvbiBpcyBhcyBm
b2xsb3c6DQo+IHVzZXJhZGQ6IGNhbm5vdCBzZXQgU0VMaW51eCBjb250ZXh0IGZvcg0KPiBob21l
IGRpcmVjdG9yeSAvdG1wL3RhY2wvbW91bnQtZXh0My9hY2x0ZXN0MQ0KIA0KSXQgc2VlbXMgdGhh
dCB0aGUgZXJyb3IgaXMgY2F1c2VkIGJ5IFNFTGludXgsIHBsZWFzZSBkaXNhYmxlDQp5b3VyIFNF
TGludXggb3Igc2V0IGl0IHRvIHBlcm1pc3NpdmUgYW5kIHRlc3QgYWdhaW4uDQogDQpUaGFua3Ms
DQpXYW5sb25nIEdhbw0KIA0KPiANCj4gdGhpcyBpcyBjYXVzZWQgYnkgY29tYW5kICJybSAtcmYg
JFRFU1RfVVNFUjFfSE9NRURJUiIuDQo+IEJ1dCB0aGlzIGRpcmVjdG9yeSBpcyBuZWVkZWQgYnkg
bmV4dCBzdGVwLg0KPiBTbyBjcmVhdGUgdGhpcyBkcmllY3RvcnkgYWdhaW4uDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBXZW50YW8gTWEgPG1hd2VudGFvQGluc3B1ci5jb20+DQo+IC0tLQ0KPiAgdGVz
dGNhc2VzL2tlcm5lbC9mcy9hY2xzL2FjbF90ZXN0MDEgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvZnMv
YWNscy9hY2xfdGVzdDAxIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2xzL2FjbF90ZXN0MDENCj4g
aW5kZXggMzI4ZmY3NC4uZDA3OWFiZCAxMDA3NTUNCj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9m
cy9hY2xzL2FjbF90ZXN0MDENCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9hY2xzL2FjbF90
ZXN0MDENCj4gQEAgLTg3LDYgKzg3LDcgQEAgZG9fc2V0dXAoKXsNCj4gIHJtIC1yZiAkVEVTVF9V
U0VSMV9IT01FRElSDQo+ICB1c2VyZGVsICRURVNUX1VTRVIxID4gL2Rldi9udWxsIDI+JjENCj4g
IHNsZWVwIDENCj4gKyAgICAgICAgbWtkaXIgLXAgJFRFU1RfVVNFUjFfSE9NRURJUg0KPiAgdXNl
cmFkZCAtZCAkVEVTVF9VU0VSMV9IT01FRElSIC1tIC1nICRURVNUX1VTRVIxX0dST1VQICRURVNU
X1VTRVIxIC1zIC9iaW4vc2gNCj4gIA0KPiAgaWYgWyAkPyAtbmUgMCBdOyB0aGVuDQo+IA0KIA0K

------=_001_NextPart763781636720_=----
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charse=
t=3DUTF-8"><style>body { line-height: 1.5; }blockquote { margin-top: 0px; =
margin-bottom: 0px; margin-left: 0.5em; }body { font-size: 12pt; font-fami=
ly: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; color: rgb(0, 0, 0); line-height=
: 1.5; }</style></head><body>=0A<div><span></span><div style=3D"font-famil=
y: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-hei=
ght: normal;">Thanks&nbsp;<span style=3D"font-family: =E5=BE=AE=E8=BD=AF=
=E9=9B=85=E9=BB=91; font-size: 12pt; line-height: 1.5; background-color: w=
indow;">Wanlong Gao, we </span><span style=3D"font-family: =E5=BE=AE=E8=BD=
=AF=E9=9B=85=E9=BB=91; font-size: 12pt; line-height: 1.5; background-color=
: window;">set the SELinux mode to permissive and the test passes.&nbsp;</=
span></div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91=
, Tahoma; font-size: 14px; line-height: normal;"><span style=3D"font-famil=
y: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; font-size: 12pt; line-height: 1.5=
; background-color: window;">the error is caused by the SELinux, finally w=
e modify the patch.</span></div><div style=3D"font-family: =E5=BE=AE=E8=BD=
=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-height: normal;"><spa=
n style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91; font-size: 1=
2pt; line-height: 1.5; background-color: window;"><br></span></div><div st=
yle=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-siz=
e: 14px; line-height: normal;"><br></div><div style=3D"font-family: =E5=BE=
=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-height: norm=
al;">&gt; The failed infornamtion is as follow:</div><div style=3D"font-fa=
mily: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-=
height: normal;">&gt; useradd: cannot set SELinux context for</div><div st=
yle=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-siz=
e: 14px; line-height: normal;">&gt; home directory /tmp/tacl/mount-ext3/ac=
ltest1</div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=
=91, Tahoma; font-size: 14px; line-height: normal;">&gt;</div><div style=
=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: =
14px; line-height: normal;">&gt; this is caused by SELinux, the SELinux mo=
de is enforcing</div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=
=85=E9=BB=91, Tahoma; font-size: 14px; line-height: normal;">&gt; set the =
mode to permissive before adding user acl_test1</div><div style=3D"font-fa=
mily: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-=
height: normal;">&gt; then set it to the default mode enforcing.</div><div=
 style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-=
size: 14px; line-height: normal;">&gt;</div><div style=3D"font-family: =E5=
=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-height: n=
ormal;">&gt; Signed-off-by: Wentao Ma &lt;mawentao@inspur.com&gt;</div><di=
v style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font=
-size: 14px; line-height: normal;">&gt; ---</div><div style=3D"font-family=
: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-heig=
ht: normal;">&gt;&nbsp;&nbsp; testcases/kernel/fs/acls/acl_test01 | 2 ++</=
div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahom=
a; font-size: 14px; line-height: normal;">&gt;&nbsp;&nbsp; 1 file changed,=
 2 insertions(+)</div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=
=85=E9=BB=91, Tahoma; font-size: 14px; line-height: normal;">&gt;</div><di=
v style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font=
-size: 14px; line-height: normal;">&gt; diff --git a/testcases/kernel/fs/a=
cls/acl_test01 b/testcases/kernel/fs/acls/acl_test01</div><div style=3D"fo=
nt-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; =
line-height: normal;">&gt; index 328ff74..e38e39b 100755</div><div style=
=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: =
14px; line-height: normal;">&gt; --- a/testcases/kernel/fs/acls/acl_test01=
</div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tah=
oma; font-size: 14px; line-height: normal;">&gt; +++ b/testcases/kernel/fs=
/acls/acl_test01</div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=
=85=E9=BB=91, Tahoma; font-size: 14px; line-height: normal;">&gt; @@ -87,7=
 +87,9 @@ do_setup(){</div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=
=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-height: normal;">&gt;&nb=
sp;&nbsp; rm -rf $TEST_USER1_HOMEDIR</div><div style=3D"font-family: =E5=
=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-height: n=
ormal;">&gt;&nbsp;&nbsp; userdel $TEST_USER1 &gt; /dev/null 2&gt;&amp;1</d=
iv><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma=
; font-size: 14px; line-height: normal;">&gt;&nbsp;&nbsp; sleep 1</div><di=
v style=3D"font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font=
-size: 14px; line-height: normal;">&gt; +	setenforce 0</div><div style=3D"=
font-family: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px=
; line-height: normal;">&gt;&nbsp;&nbsp; useradd -d $TEST_USER1_HOMEDIR -m=
 -g $TEST_USER1_GROUP $TEST_USER1 -s /bin/sh</div><div style=3D"font-famil=
y: =E5=BE=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-hei=
ght: normal;">&gt; +	setenforce 1</div><div style=3D"font-family: =E5=BE=
=AE=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-height: norm=
al;">&gt;&nbsp;&nbsp;</div><div style=3D"font-family: =E5=BE=AE=E8=BD=AF=
=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-height: normal;">&gt;&nb=
sp;&nbsp; if [ $? -ne 0 ]; then</div><div style=3D"font-family: =E5=BE=AE=
=E8=BD=AF=E9=9B=85=E9=BB=91, Tahoma; font-size: 14px; line-height: normal;=
">&gt;&nbsp;&nbsp; tst_brkm TBROK "Could not add test user $TEST_USER1."</=
div></div>=0A<div><br></div><hr style=3D"width: 210px; height: 1px;" color=
=3D"#b5c4df" size=3D"1" align=3D"left">=0A<div><span><div style=3D"MARGIN:=
 10px; FONT-FAMILY: verdana; FONT-SIZE: 10pt"><div>mawentao@inspur.com</di=
v></div></span></div>=0A<blockquote style=3D"margin-top: 0px; margin-botto=
m: 0px; margin-left: 0.5em;"><div>&nbsp;</div><div style=3D"border:none;bo=
rder-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm 0cm 0cm"><div style=3D"PADD=
ING-RIGHT: 8px; PADDING-LEFT: 8px; FONT-SIZE: 12px;FONT-FAMILY:tahoma;COLO=
R:#000000; BACKGROUND: #efefef; PADDING-BOTTOM: 8px; PADDING-TOP: 8px"><di=
v><b>From:</b>&nbsp;<a href=3D"mailto:gaowanlong@cn.fujitsu.com">Wanlong G=
ao</a></div><div><b>Date:</b>&nbsp;2015-07-13&nbsp;14:56</div><div><b>To:<=
/b>&nbsp;<a href=3D"mailto:mawentao@inspur.com">Wentao Ma</a>; <a href=3D"=
mailto:ltp-list@lists.sourceforge.net">ltp-list@lists.sourceforge.net</a><=
/div><div><b>CC:</b>&nbsp;<a href=3D"mailto:wunan@inspur.com">wunan@inspur=
.com</a></div><div><b>Subject:</b>&nbsp;Re: [LTP] [PATCH] acls: Solve a pr=
oblem from acl_test01</div></div></div><div><div>On 07/09/2015 03:27 PM, W=
entao Ma wrote:</div>=0A<div>&gt; The failed infornamtion is as follow:</d=
iv>=0A<div>&gt; useradd: cannot set SELinux context for</div>=0A<div>&gt; =
home directory /tmp/tacl/mount-ext3/acltest1</div>=0A<div>&nbsp;</div>=0A<=
div>It seems that the error is caused by SELinux, please disable</div>=0A<=
div>your SELinux or set it to permissive and test again.</div>=0A<div>&nbs=
p;</div>=0A<div>Thanks,</div>=0A<div>Wanlong Gao</div>=0A<div>&nbsp;</div>=
=0A<div>&gt; </div>=0A<div>&gt; this is caused by comand "rm -rf $TEST_USE=
R1_HOMEDIR".</div>=0A<div>&gt; But this directory is needed by next step.<=
/div>=0A<div>&gt; So create this driectory again.</div>=0A<div>&gt; </div>=
=0A<div>&gt; Signed-off-by: Wentao Ma &lt;mawentao@inspur.com&gt;</div>=0A=
<div>&gt; ---</div>=0A<div>&gt;&nbsp; testcases/kernel/fs/acls/acl_test01 =
| 1 +</div>=0A<div>&gt;&nbsp; 1 file changed, 1 insertion(+)</div>=0A<div>=
&gt; </div>=0A<div>&gt; diff --git a/testcases/kernel/fs/acls/acl_test01 b=
/testcases/kernel/fs/acls/acl_test01</div>=0A<div>&gt; index 328ff74..d079=
abd 100755</div>=0A<div>&gt; --- a/testcases/kernel/fs/acls/acl_test01</di=
v>=0A<div>&gt; +++ b/testcases/kernel/fs/acls/acl_test01</div>=0A<div>&gt;=
 @@ -87,6 +87,7 @@ do_setup(){</div>=0A<div>&gt;&nbsp; 	rm -rf $TEST_USER1=
_HOMEDIR</div>=0A<div>&gt;&nbsp; 	userdel $TEST_USER1 &gt; /dev/null 2&gt;=
&amp;1</div>=0A<div>&gt;&nbsp; 	sleep 1</div>=0A<div>&gt; +&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; mkdir -p $TEST_USER1_HOMEDIR</div>=0A<div>&gt;=
&nbsp; 	useradd -d $TEST_USER1_HOMEDIR -m -g $TEST_USER1_GROUP $TEST_USER1=
 -s /bin/sh</div>=0A<div>&gt;&nbsp; </div>=0A<div>&gt;&nbsp; 	if [ $? -ne =
0 ]; then</div>=0A<div>&gt; </div>=0A<div>&nbsp;</div>=0A</div></blockquot=
e>=0A</body></html>
------=_001_NextPart763781636720_=------


--===============3219352404613589463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
--===============3219352404613589463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3219352404613589463==--

