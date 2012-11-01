Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linliangjie@huawei.com>) id 1TTkFz-0005JV-8R
	for ltp-list@lists.sourceforge.net; Thu, 01 Nov 2012 02:11:43 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TTkFv-0002qG-Sw
	for ltp-list@lists.sourceforge.net; Thu, 01 Nov 2012 02:11:42 +0000
From: Linliangjie <linliangjie@huawei.com>
Date: Thu, 1 Nov 2012 02:10:07 +0000
Message-ID: <D7504F77ECABB0449431598E06DDF6E9179A600C@szxeml526-mbx.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Subject: [LTP] ioctl01 failed when checking the ioctl bad command return
	value.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5551615153865562663=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Cc: shyju pv <shyju.pv@huawei.com>, Sanil kumar <sanil.kumar@huawei.com>, "Maxiansheng (Max)" <max.maxiansheng@huawei.com>

--===============5551615153865562663==
Content-Language: zh-CN
Content-Type: multipart/alternative;
	boundary="_000_D7504F77ECABB0449431598E06DDF6E9179A600Cszxeml526mbxchi_"

--_000_D7504F77ECABB0449431598E06DDF6E9179A600Cszxeml526mbxchi_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SXNzdWUgZGVzY3JpcHRpb246DQotLS0tLS0tLS0tLS0tLS0tLS0tDQpLZXJuZWwgVmVyc2lvbiA6
IDMuNy1yYzINClN5c3RlbSBjYWxsIDogaW9jdGwNCkxUUCBUZXN0Y2FzZSA6IGlvY3RsMDENCkxU
UCBWZXJzaW9uIDogMjAxMjA5MDMNClBsYXRmb3JtIDogeDg2XzY0ICggSFAgODIwMCBQQyApDQpU
ZXN0Y2FzZSBEZXNjcmlwdGlvbiA6IFRlc3RjYXNlIHRvIGNoZWNrIHRoZSBlcnJub3Mgc2V0IGJ5
IHRoZSBpb2N0bCgyKSBzeXN0ZW0NCmNhbGwuDQpQcmV2aW91cyBrZXJuZWwgdmVyc2lvbiBpbiB3
aGljaCB0ZXN0Y2FzZSBwYXNzZWQgOiAzLjIuOQ0KDQpFeGVjdXRpbmcgbG9nOg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KW3Jvb3RAbGludXgtcWY0Z10tWy90bXAvbHRwL2x0cC90ZXN0Y2Fz
ZXMvYmluXQ0KKDApIyAuL2lvY3RsMDEgLUQgL2Rldi90dHkNCmlvY3RsMDEgICAgIDEgIFRQQVNT
ICA6ICBmYWlsZWQgYXMgZXhwZWN0ZWQ6IFRFU1RfRVJSTk89RUJBREYoOSk6IEJhZCBmaWxlDQpk
ZXNjcmlwdG9yDQppb2N0bDAxICAgICAyICBUUEFTUyAgOiAgZmFpbGVkIGFzIGV4cGVjdGVkOiBU
RVNUX0VSUk5PPUVGQVVMVCgxNCk6IEJhZCBhZGRyZXNzDQppb2N0bDAxICAgICAzICBURkFJTCAg
OiAgZmFpbGVkIHVuZXhwZWN0ZWRseTsgZXhwZWN0ZWQgMjIgLSBJbnZhbGlkIGFyZ3VtZW50Og0K
VEVTVF9FUlJOTz1FTk9UVFkoMjUpOiBJbmFwcHJvcHJpYXRlIGlvY3RsIGZvciBkZXZpY2UNCmlv
Y3RsMDEgICAgIDQgIFRQQVNTICA6ICBmYWlsZWQgYXMgZXhwZWN0ZWQ6IFRFU1RfRVJSTk89RU5P
VFRZKDI1KToNCkluYXBwcm9wcmlhdGUgaW9jdGwgZm9yIGRldmljZQ0KaW9jdGwwMSAgICAgNSAg
VFBBU1MgIDogIGZhaWxlZCBhcyBleHBlY3RlZDogVEVTVF9FUlJOTz1FRkFVTFQoMTQpOiBCYWQg
YWRkcmVzcw0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KVGhlIHJldHVybiB2YWx1ZSBvZiB0
aGUgY29kZSBpcyBleHBlY3RlZCB0byBiZSAyMiBidXQgMjQgaXMgcmV0dXJuZWQgYW5kDQpoZW5j
ZSB0aGUgTFRQIHRlc3QgZmFpbGVkLg0KDQpGcm9tIHYzLjIuOSwga2VybmVsIGhhcyBjaGFuZ2Vk
IHRoZSByZXR1cm4gdmFsdWUgZm9yIGJhZCBjb21tYW5kLg0KVGhlIHBhdGNoIGNvbW1pdCBubzow
N2QxMDZkMGEzM2Q2MDYzZDIwNjEzMDU5MDNkZWIwMjQ4OWViYTIwDQoNCkJlbG93IGlzIHBhcnQg
b2YgdGhlIHBhdGNoOg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpkaWZm
IC0tZ2l0IGEvZnMvaW9jdGwuYyBiL2ZzL2lvY3RsLmMNCg0KaW5kZXggMWQ5YjlmYy4uMDY2ODM2
ZSAxMDA2NDQNCi0tLSBhL2ZzL2lvY3RsLmMNCisrKyBiL2ZzL2lvY3RsLmMNCg0KQEAgLTQyLDcg
KzQyLDcgQEAgc3RhdGljIGxvbmcgdmZzX2lvY3RsKHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25l
ZA0KDQogaW50IGNtZCwNCg0KICAgICAgICBlcnJvciA9IGZpbHAtPmZfb3AtPnVubG9ja2VkX2lv
Y3RsKGZpbHAsIGNtZCwgYXJnKTsNCiAgICAgICAgaWYgKGVycm9yID09IC1FTk9JT0NUTENNRCkN
Ci0gICAgICAgICAgICAgICBlcnJvciA9IC1FSU5WQUw7DQorICAgICAgICAgICAgICAgZXJyb3Ig
PSAtRU5PVFRZOw0KDQoNCmRpZmYgLS1naXQgYS9ibG9jay9pb2N0bC5jIGIvYmxvY2svaW9jdGwu
Yw0KaW5kZXggY2E5MzlmYy4uZDUxMGMyYSAxMDA2NDQNCi0tLSBhL2Jsb2NrL2lvY3RsLmMNCisr
KyBiL2Jsb2NrL2lvY3RsLmMNCkBAIC0xODAsNiArMTgwLDI2IEBAIGludCBfX2Jsa2Rldl9kcml2
ZXJfaW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBtb2RlLA0KIEVYUE9S
VF9TWU1CT0xfR1BMKF9fYmxrZGV2X2RyaXZlcl9pb2N0bCk7DQoNCiAvKg0KKyAqIElzIGl0IGFu
IHVucmVjb2duaXplZCBpb2N0bD8gVGhlIGNvcnJlY3QgcmV0dXJucyBhcmUgZWl0aGVyDQorICog
RU5PVFRZIChmaW5hbCkgb3IgRU5PSU9DVExDTUQgKCJJIGRvbid0IGtub3cgdGhpcyBvbmUsIHRy
eSBhDQorICogZmFsbGJhY2siKS4gRU5PSU9DVExDTUQgZ2V0cyB0dXJuZWQgaW50byBFTk9UVFkg
YnkgdGhlIGlvY3RsDQorICogY29kZSBiZWZvcmUgcmV0dXJuaW5nLg0KKyAqDQorICogQ29uZnVz
ZWQgZHJpdmVycyBzb21ldGltZXMgcmV0dXJuIEVJTlZBTCwgd2hpY2ggaXMgd3JvbmcuIEl0DQor
ICogbWVhbnMgIkkgdW5kZXJzdG9vZCB0aGUgaW9jdGwgY29tbWFuZCwgYnV0IHRoZSBwYXJhbWV0
ZXJzIHRvDQorICogaXQgd2VyZSB3cm9uZyIuDQorICoNCisgKiBXZSBzaG91bGQgYWltIHRvIGp1
c3QgZml4IHRoZSBicm9rZW4gZHJpdmVycywgdGhlIEVJTlZBTCBjYXNlDQorICogc2hvdWxkIGdv
IGF3YXkuDQorICovDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQoNCldl
IGNhbiBzZWUgdGhhdCBrZXJuZWwgaGFzIG1vZGlmaWVkIHRoZSByZXR1cm4gdmFsdWUgb2YgYmFk
IGNvbW1hbmQgZnJvbSBFSU5WQUwNCnRvIEVOT1RUWS4gU28gSSB0aGluayB3ZSBzaG91bGQgdXBk
YXRlIHRoZSBsdHAgY29kZSB0byBjb3BlIHdpdGggdGhlIGxhdGVzdA0Ka2VybmVsLg0KDQoNCg0K
DQpKYWNrDQo=

--_000_D7504F77ECABB0449431598E06DDF6E9179A600Cszxeml526mbxchi_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; ">Issue description: =0A=
------------------- =0A=
Kernel Version : 3.7-rc2=0A=
System call : ioctl=0A=
LTP Testcase : ioctl01=0A=
LTP Version : 20120903 =0A=
Platform : x86_64 ( HP 8200 PC ) =0A=
Testcase Description : Testcase to check the errnos set by the ioctl(2) sys=
tem=0A=
call.=0A=
Previous kernel version in which testcase passed : 3.2.9=0A=
=0A=
Executing log:=0A=
-------------------------=0A=
[root@linux-qf4g]-[/tmp/ltp/ltp/testcases/bin]=0A=
(0)# ./ioctl01 -D /dev/tty=0A=
ioctl01     1  TPASS  :  failed as expected: TEST_ERRNO=3DEBADF(9): Bad fil=
e=0A=
descriptor=0A=
ioctl01     2  TPASS  :  failed as expected: TEST_ERRNO=3DEFAULT(14): Bad a=
ddress=0A=
ioctl01     3  TFAIL  :  failed unexpectedly; expected 22 - Invalid argumen=
t:=0A=
TEST_ERRNO=3DENOTTY(25): Inappropriate ioctl for device=0A=
ioctl01     4  TPASS  :  failed as expected: TEST_ERRNO=3DENOTTY(25):=0A=
Inappropriate ioctl for device=0A=
ioctl01     5  TPASS  :  failed as expected: TEST_ERRNO=3DEFAULT(14): Bad a=
ddress=0A=
-------------------------=0A=
The return value of the code is expected to be 22 but 24 is returned and =
=0A=
hence the LTP test failed. =0A=
=0A=
From v3.2.9, kernel has changed the return value for bad command. =0A=
The patch commit no:07d106d0a33d6063d2061305903deb02489eba20=0A=
=0A=
Below is part of the patch:=0A=
----------------------------------</pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; ">diff --git a/fs/ioctl.c b/fs/io=
ctl.c</pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; ">index 1d9b9fc..066836e 100644=
=0A=
--- a/fs/ioctl.c=0A=
&#43;&#43;&#43; b/fs/ioctl.c</pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; ">@@ -42,7 &#43;42,7 @@ static lo=
ng vfs_ioctl(struct file *filp, unsigned</pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; "> int cmd,=0A=
=0A=
        error =3D filp-&gt;f_op-&gt;unlocked_ioctl(filp, cmd, arg);=0A=
        if (error =3D=3D -ENOIOCTLCMD)=0A=
-               error =3D -EINVAL;=0A=
&#43;               error =3D -ENOTTY;</pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; "><br></pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"width: 50em; =
"><font size=3D"3"><span style=3D"white-space: pre-wrap;">diff --git a/bloc=
k/ioctl.c b/block/ioctl.c=0A=
index ca939fc..d510c2a 100644=0A=
--- a/block/ioctl.c=0A=
&#43;&#43;&#43; b/block/ioctl.c=0A=
@@ -180,6 &#43;180,26 @@ int __blkdev_driver_ioctl(struct block_device *bde=
v, fmode_t mode,=0A=
 EXPORT_SYMBOL_GPL(__blkdev_driver_ioctl);=0A=
=0A=
 /*=0A=
&#43; * Is it an unrecognized ioctl? The correct returns are either=0A=
&#43; * ENOTTY (final) or ENOIOCTLCMD (&quot;I don't know this one, try a=
=0A=
&#43; * fallback&quot;). ENOIOCTLCMD gets turned into ENOTTY by the ioctl=
=0A=
&#43; * code before returning.=0A=
&#43; *=0A=
&#43; * Confused drivers sometimes return EINVAL, which is wrong. It=0A=
&#43; * means &quot;I understood the ioctl command, but the parameters to=
=0A=
&#43; * it were wrong&quot;.=0A=
&#43; *=0A=
&#43; * We should aim to just fix the broken drivers, the EINVAL case=0A=
&#43; * should go away.=0A=
&#43; */=0A=
=0A=
---------------------------------=0A=
<br></span></font></pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; ">We can see that kernel has modi=
fied the return value of bad command from EINVAL=0A=
to ENOTTY. So I think we should update the ltp code to cope with the latest=
=0A=
kernel.</pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; "><pre class=3D"bz_comment_text" =
id=3D"comment_text_2" style=3D"white-space: pre-wrap; width: 50em; "><br></=
pre></pre>
<pre class=3D"bz_comment_text" id=3D"comment_text_0" style=3D"font-size: me=
dium; white-space: pre-wrap; width: 50em; ">=0A=
=0A=
Jack</pre>
</div>
</body>
</html>

--_000_D7504F77ECABB0449431598E06DDF6E9179A600Cszxeml526mbxchi_--


--===============5551615153865562663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
--===============5551615153865562663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5551615153865562663==--

