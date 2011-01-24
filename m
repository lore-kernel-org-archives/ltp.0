Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <achender@us.ibm.com>) id 1PhOt2-00048z-9j
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 16:03:24 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PhOsz-00048i-TJ
	for ltp-list@lists.sourceforge.net; Mon, 24 Jan 2011 16:03:24 +0000
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0OFc7nw017365
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jan 2011 10:38:44 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 60F7B4DE803E
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Jan 2011 10:59:48 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0OG3FOw469858
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jan 2011 11:03:15 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0OG7kZc007472
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jan 2011 09:07:46 -0700
Received: from d03nm127.boulder.ibm.com (d03nm127.boulder.ibm.com
	[9.17.195.18])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	p0OG7k76007459
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jan 2011 09:07:46 -0700
MIME-Version: 1.0
Message-ID: <OF9AB4C7C7.EB1D7DBD-ON87257822.0057786A-07257822.00583026@us.ibm.com>
From: Allison C Henderson <achender@us.ibm.com>
Date: Mon, 24 Jan 2011 09:03:14 -0700
Content-Type: multipart/mixed; boundary="=_mixed 0058302307257822_="
Subject: [LTP] Fw: [Ltp Patch for ext4 punch hole 1/1] Added a new ext4 hole
 punch test case
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

--=_mixed 0058302307257822_=
Content-Type: multipart/alternative;
	boundary="=_alternative 0058302307257822_="


--=_alternative 0058302307257822_=
Content-Type: text/plain; charset="US-ASCII"

Hi all,

This is a re-submission of an earlier patch to add an ext4 testcase to 
ltp.  I've cleaned up the patch according to the stlye guide and attached 
a git friendly patch.  This is my first time doing one of these, so please 
let me know if I left anything out.  Thx!

Allison Henderson
eml: achender@us.ibm.com
ph:799-5761 (T/L 321)


This test case exercises the new punch hole flag in the fallocate system
call that we plan to use to implement punch hole support for ext4.
Currently, there is no punch hole support for ext4, so the test just 
returns
failed for now, but it will help verify that the new VFS changes to 
fallocate
are working.  Later when ext4 hole punching is implemented, the test case
will be able to verify if the hole punch is successful

Signed-off-by: Allison Henderson <achender@us.ibm.com>

:000000 100644 0000000... c9131aa... A 
testcases/kernel/fs/ext4-new-features/ext4-hole-punch/Makefile
:000000 100644 0000000... 146920f... A 
testcases/kernel/fs/ext4-new-features/ext4-hole-punch/ext4_hole_punch.c
:000000 100755 0000000... bdb1aac... A 
testcases/kernel/fs/ext4-new-features/ext4-hole-punch/ext4_hole_punch_test.sh
:100755 100755 534d2b9... a67b1be... M 
testcases/kernel/fs/ext4-new-features/run_ext4_test.sh


--=_alternative 0058302307257822_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi all,</font>
<br>
<br><font size=2 face="sans-serif">This is a re-submission of an earlier
patch to add an ext4 testcase to ltp. &nbsp;I've cleaned up the patch according
to the stlye guide and attached a git friendly patch. &nbsp;This is my
first time doing one of these, so please let me know if I left anything
out. &nbsp;Thx!</font>
<br>
<br><font size=2 face="sans-serif">Allison Henderson<br>
eml: achender@us.ibm.com<br>
ph:799-5761 (T/L 321)</font>
<br>
<br><tt><font size=2><br>
This test case exercises the new punch hole flag in the fallocate system<br>
call that we plan to use to implement punch hole support for ext4.<br>
Currently, there is no punch hole support for ext4, so the test just returns<br>
failed for now, but it will help verify that the new VFS changes to fallocate<br>
are working. &nbsp;Later when ext4 hole punching is implemented, the test
case<br>
will be able to verify if the hole punch is successful<br>
<br>
Signed-off-by: Allison Henderson &lt;achender@us.ibm.com&gt;<br>
<br>
:000000 100644 0000000... c9131aa... A &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; testcases/kernel/fs/ext4-new-features/ext4-hole-punch/Makefile<br>
:000000 100644 0000000... 146920f... A &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; testcases/kernel/fs/ext4-new-features/ext4-hole-punch/ext4_hole_punch.c<br>
:000000 100755 0000000... bdb1aac... A &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; testcases/kernel/fs/ext4-new-features/ext4-hole-punch/ext4_hole_punch_test.sh<br>
:100755 100755 534d2b9... a67b1be... M &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; testcases/kernel/fs/ext4-new-features/run_ext4_test.sh<br>
<br>
</font></tt>
--=_alternative 0058302307257822_=--

--=_mixed 0058302307257822_=
Content-Type: application/octet-stream;
	name="0001-Added-a-new-ext4-hole-punch-test-case.patch"
Content-Disposition: attachment;
	filename="0001-Added-a-new-ext4-hole-punch-test-case.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvZnMvZXh0NC1uZXctZmVhdHVyZXMvZXh0NC1o
b2xlLXB1bmNoL01ha2VmaWxlIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9leHQ0LW5ldy1mZWF0dXJl
cy9leHQ0LWhvbGUtcHVuY2gvTWFrZWZpbGUNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAw
MDAwMDAwLi5jOTEzMWFhDQotLS0gL2Rldi9udWxsDQorKysgYi90ZXN0Y2FzZXMva2VybmVsL2Zz
L2V4dDQtbmV3LWZlYXR1cmVzL2V4dDQtaG9sZS1wdW5jaC9NYWtlZmlsZQ0KQEAgLTAsMCArMSwy
NSBAQA0KKyMgICAgQ29weXJpZ2h0IChDKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVz
ICBDb3JwLiwgMjAxMSANCisjDQorIyAgICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsg
eW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQ0KKyMgICAgaXQgdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkN
CisjICAgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2Yg
dGhlIExpY2Vuc2UsIG9yDQorIyAgICAoYXQgeW91ciBvcHRpb24pIGFueSBsYXRlciB2ZXJzaW9u
Lg0KKyMNCisjICAgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0
IGl0IHdpbGwgYmUgdXNlZnVsLA0KKyMgICAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRo
b3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCisjICAgIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUNCisjICAgIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuDQorIw0KKyMgICAgWW91IHNo
b3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgYWxvbmcNCisjICAgIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBG
cmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sDQorIyAgICA1MSBGcmFua2xpbiBTdHJlZXQs
IEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEgVVNBLg0KKyMNCisNCit0b3Bfc3Jj
ZGlyICAgICAgICAgICAgICA/PSAuLi8uLi8uLi8uLi8uLg0KKw0KK2luY2x1ZGUgJCh0b3Bfc3Jj
ZGlyKS9pbmNsdWRlL21rL3Rlc3RjYXNlcy5taw0KKw0KK0xETElCUyArPSAtbG0NCitJTlNUQUxM
X1RBUkdFVFMJCT89ICouc2gNCisNCitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9n
ZW5lcmljX2xlYWZfdGFyZ2V0Lm1rDQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9mcy9l
eHQ0LW5ldy1mZWF0dXJlcy9leHQ0LWhvbGUtcHVuY2gvZXh0NF9ob2xlX3B1bmNoLmMgYi90ZXN0
Y2FzZXMva2VybmVsL2ZzL2V4dDQtbmV3LWZlYXR1cmVzL2V4dDQtaG9sZS1wdW5jaC9leHQ0X2hv
bGVfcHVuY2guYw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjE0NjkyMGYN
Ci0tLSAvZGV2L251bGwNCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvZXh0NC1uZXctZmVhdHVy
ZXMvZXh0NC1ob2xlLXB1bmNoL2V4dDRfaG9sZV9wdW5jaC5jDQpAQCAtMCwwICsxLDEwMiBAQA0K
Ky8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKiovDQorLyogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCisvKiBD
b3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAuLCAyMDEx
ICAgICAgICAgICAgICAgICAqLw0KKy8qICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQorLyogVGhpcyBw
cm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3Ig
bW9kaWZ5ICAgICAgKi8NCisvKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSAgICAgICAqLw0KKy8qIHRoZSBGcmVlIFNv
ZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yICAg
ICAgICAgICovDQorLyogKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCisvKiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqLw0KKy8qIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0
IHdpbGwgYmUgdXNlZnVsLCAgICAgICAgICAgICovDQorLyogYnV0IFdJVEhPVVQgQU5ZIFdBUlJB
TlRZOyAgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mICAgICAgICAgICAgKi8N
CisvKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0Uu
ICBTZWUgICAgICAgICAgICAgICAgICAqLw0KKy8qIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBmb3IgbW9yZSBkZXRhaWxzLiAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQorLyog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKi8NCisvKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSAgICAgICAgICAqLw0KKy8qIGFsb25n
IHdpdGggdGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSAg
ICAgICAgICAgICAgICovDQorLyogRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBT
dWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EgICAgKi8NCisvKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAqLw0KKy8qIEF1dGhvcjogQWxsaXNvbiBIZW5kZXJzb24gIDxhY2hlbmRlckB1cy5p
Ym0uY29tPiAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQorLyogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKi8NCisvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqLw0KKw0KKyNpbmNsdWRlIDxsaW51eC9mYWxs
b2MuaD4NCisjaW5jbHVkZSA8ZmNudGwuaD4NCisjaW5jbHVkZSA8c3RkaW8uaD4NCisjaW5jbHVk
ZSA8c3RkbGliLmg+DQorI2luY2x1ZGUgPHVuaXN0ZC5oPg0KKw0KKyNkZWZpbmUgVVNBR0UgIlVT
QUdFOiBleHQ0LXB1bmNoLWhvbGUgLW8gb2Zmc2V0IC1sIGxlbmd0aCBmaWxlbmFtZVxuIg0KKw0K
K2ludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pDQorew0KKwlpbnQgbGVuZ3RoOw0KKwlp
bnQgb2Zmc2V0Ow0KKwlpbnQgb3B0Ow0KKwlpbnQgZmQ7DQorCWludCByYzsNCisJaW50IG1vZGU7
DQorCWNoYXIgKmZpbGVuYW1lOw0KKw0KKwlsZW5ndGggPSAtMTsNCisJb2Zmc2V0ID0gLTE7DQor
CW9wdCA9IDA7DQorCWZkID0gMDsNCisJcmMgPSAwOw0KKwltb2RlID0gMDsNCisJZmlsZW5hbWUg
PSBOVUxMOw0KKw0KKw0KKwlpZiAoYXJnYyAhPSA2KSB7DQorCQlmcHJpbnRmKHN0ZGVyciwgVVNB
R0UpOw0KKwkJcmV0dXJuIDE7DQorCX0NCisNCisJLyogUGFyc2UgYXJndW1lbnRzICovDQorCXdo
aWxlICgob3B0ID0gZ2V0b3B0KGFyZ2MsIGFyZ3YsICJvOmw6IikpICE9IEVPRikgew0KKwkJc3dp
dGNoIChvcHQpIHsNCisJCWNhc2UgJ28nOg0KKwkJCW9mZnNldCA9IGF0b2kob3B0YXJnKTsNCisJ
CQlicmVhazsNCisJCWNhc2UgJ2wnOg0KKwkJCWxlbmd0aCA9IGF0b2kob3B0YXJnKTsNCisJCQli
cmVhazsNCisJCWRlZmF1bHQ6DQorCQkJZnByaW50ZihzdGRlcnIsIFVTQUdFKTsNCisJCQlyZXR1
cm4gMTsNCisJCX0NCisJfQ0KKw0KKwlmaWxlbmFtZSA9IGFyZ3ZbNV07DQorDQorCWlmKG9mZnNl
dCA8IDAgfHwgbGVuZ3RoIDwgMCB8fCBmaWxlbmFtZSA9PSBOVUxMKXsNCisJCWZwcmludGYoc3Rk
ZXJyLCBVU0FHRSk7DQorCQlyZXR1cm4gMTsNCisJfQ0KKw0KKw0KKwkvKiBDaGVjayBmb3IgcHVu
Y2ggaG9sZSBzdXBwb3J0ICovDQorI2lmbmRlZiBGQUxMT0NfRkxfUFVOQ0hfSE9MRQ0KKwlmcHJp
bnRmKHN0ZGVyciwgIkVycm9yOiBmYWxsb2NhdGUgcHVuY2ggaG9sZSBub3Qgc3VwcG9ydGVkXG4i
KTsNCisJcmV0dXJuIDE7DQorI2Vsc2UNCisNCisJLyogT3BlbiBmaWxlICovDQorCWZkID0gb3Bl
bihmaWxlbmFtZSwgT19XUk9OTFksIDA3NTUpOw0KKwlpZihmZCA8PSAwKXsNCisJCXBlcnJvcigi
RXJyb3I6IEZhaWxlZCB0byBvcGVuIGZpbGUiKTsNCisJCXJldHVybiAxOw0KKwl9DQorDQorCS8q
IFB1bmNoIGhvbGUgKi8NCisJbW9kZSA9IEZBTExPQ19GTF9QVU5DSF9IT0xFIHwgRkFMTE9DX0ZM
X0tFRVBfU0laRTsNCisJcmMgPSBmYWxsb2NhdGUoZmQsIG1vZGUsIG9mZnNldCwgbGVuZ3RoKTsN
CisJaWYocmMgIT0gMCl7DQorCQlwZXJyb3IoIkVycm9yOiBQdW5jaCBob2xlIGZhaWxlZCIpOw0K
Kwl9DQorDQorCWNsb3NlKGZkKTsNCisjZW5kaWYNCisJcmV0dXJuIHJjOw0KK30NCisNCmRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2ZzL2V4dDQtbmV3LWZlYXR1cmVzL2V4dDQtaG9sZS1w
dW5jaC9leHQ0X2hvbGVfcHVuY2hfdGVzdC5zaCBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvZXh0NC1u
ZXctZmVhdHVyZXMvZXh0NC1ob2xlLXB1bmNoL2V4dDRfaG9sZV9wdW5jaF90ZXN0LnNoDQpuZXcg
ZmlsZSBtb2RlIDEwMDc1NQ0KaW5kZXggMDAwMDAwMC4uYmRiMWFhYw0KLS0tIC9kZXYvbnVsbA0K
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9leHQ0LW5ldy1mZWF0dXJlcy9leHQ0LWhvbGUtcHVu
Y2gvZXh0NF9ob2xlX3B1bmNoX3Rlc3Quc2gNCkBAIC0wLDAgKzEsOTYgQEANCisjIS9iaW4vYmFz
aA0KKw0KKyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQorIyMgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyMN
CisjIyBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENvcnAu
LCAyMDExICAgICAgICAgICAgICAgICAjIw0KKyMjICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMjDQorIyMg
VGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBh
bmQjb3IgbW9kaWZ5ICAgICAgIyMNCisjIyBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSAgICAgICAjIw0KKyMjIHRoZSBG
cmVlIFNvZnR3YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2Us
IG9yICAgICAgICAgICMjDQorIyMgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIyMNCisjIyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAjIw0KKyMjIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0
aGF0IGl0IHdpbGwgYmUgdXNlZnVsLCBidXQgICAgICAgICMjDQorIyMgV0lUSE9VVCBBTlkgV0FS
UkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZiBNRVJDSEFOVEFCSUxJ
VFkgIyMNCisjIyBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUg
R05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgICAjIw0KKyMjIGZvciBtb3JlIGRldGFpbHMuICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICMj
DQorIyMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIyMNCisjIyBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQg
YSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSAgICAgICAgICAjIw0KKyMj
IGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0
d2FyZSAgICAgICAgICAgICAgICMjDQorIyMgRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBs
YWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EgICAgIyMNCisjIyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAjIw0KKyMjIEF1dGhvcjogQWxsaXNvbiBIZW5kZXJzb24gPGFoZW5kZXJA
dXMuaWJtLi5jb20+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICMjDQorIyMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIyMNCisjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIw0KKw0KK2NkICRMVFBST09UL3Rl
c3RjYXNlcy9iaW4NCisNCisuIC4vZXh0NF9mdW5jcy5zaA0KKw0KK2V4cG9ydCBUQ0lEPSJleHQ0
LWhvbGUtcHVuY2giDQorZXhwb3J0IFRTVF9UT1RBTD0yDQorZXhwb3J0IFRTVF9DT1VOVD0xDQor
DQorIyAkMTogdGhlIHRlc3QgY29uZmlnDQorcmVhZF9jb25maWcgJDENCisNCitURVNUX0RJUj0k
UFdEDQorDQorIyBUZXN0IHRoYXQgZmlsZSBjYW4gYmUgaG9sZSBwdW5jaGVkDQorZXh0NF90ZXN0
X2hvbGVfcHVuY2goKQ0KK3sNCisJdHN0X3Jlc20gVElORk8gIlRlc3QgZmFsbG9jYXRlIHB1bmNo
IGhvbGUiDQorDQorCSNjcmVhdGUgdGhlIGZpbGUgc3lzdGVtDQorCW1rZnMuZXh0NCAgJEVYVDRf
REVWICY+IC9kZXYvbnVsbA0KKwlpZiBbICQ/IC1uZSAwIF07IHRoZW4NCisJCXRzdF9yZXNtIFRG
QUlMICJmYWlsZWQgdG8gY3JlYXRlIGV4dDQgZmlsZXN5c3RlbSINCisJCXJldHVybiAxDQorCWZp
DQorDQorCSNtb3VudCB0aGUgZmlsZSBzeXN0ZW0NCisJbW91bnQgLXQgZXh0NCAkRVhUNF9ERVYg
bW50X3BvaW50DQorCWlmIFsgJD8gLW5lIDAgXTsgdGhlbg0KKwkJdHN0X3Jlc20gVEZBSUwgImZh
aWxlZCB0byBtb3VudCBleHQ0IGZpbGVzeXN0ZW0iDQorCQlyZXR1cm4gMQ0KKwlmaQ0KKw0KKwkj
Y3JlYXRlIHRlc3QgZmlsZQ0KKwlybSBtbnRfcG9pbnQvdG1wX2ZpbGUNCisJdG91Y2ggbW50X3Bv
aW50L3RtcF9maWxlDQorCWRkIGlmPS9kZXYvemVybyBvZj1tbnRfcG9pbnQvdG1wX2ZpbGUgYnM9
MTAyNCBjb3VudD01MCAmPiAvZGV2L251bGwgICAgICAgDQorDQorCSNwdW5jaCBob2xlIGluIG1p
ZGRsZQ0KKwkuL2V4dDRfaG9sZV9wdW5jaCAtbyAgMjU2MDAgLWwgNjE0NCBtbnRfcG9pbnQvdG1w
X2ZpbGUNCisNCisJaWYgWyAkPyAtbmUgMCBdOyB0aGVuDQorCQl0c3RfcmVzbSBURkFJTCAiUHVu
Y2ggaG9sZSBmYWlsZWQiDQorCQl1bW91bnQgbW50X3BvaW50DQorCQlyZXR1cm4gMQ0KKwlmaQ0K
Kw0KKw0KKw0KKwkjdW5tb3VudCBmaWxlc3l0ZW0NCisJdW1vdW50IG1udF9wb2ludA0KKwlpZiBb
ICQ/IC1uZSAwIF07IHRoZW4NCisJCXRzdF9yZXNtIFRGQUlMICJmYWlsZWQgdG8gdW1vdW50IGV4
dDQgZmlsZXN5c3RlbSINCisJCXJldHVybiAxDQorCWZpDQorDQorCXRzdF9yZXNtIFRQQVNTICJF
eHQ0IHB1bmNoIGhvbGUgcGFzcyINCit9DQorDQorIyBtYWluDQorZXh0NF9zZXR1cA0KKw0KK1JF
VD0wDQorDQorZXh0NF90ZXN0X2hvbGVfcHVuY2gNCitpZiBbICQ/IC1uZSAwIF07IHRoZW4NCisJ
UkVUPTENCitmaQ0KKzogJCgoVFNUX0NPVU5UKyspKQ0KKw0KK2V4dDRfY2xlYW51cA0KK2V4aXQg
JFJFVA0KKw0KZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvZnMvZXh0NC1uZXctZmVhdHVy
ZXMvcnVuX2V4dDRfdGVzdC5zaCBiL3Rlc3RjYXNlcy9rZXJuZWwvZnMvZXh0NC1uZXctZmVhdHVy
ZXMvcnVuX2V4dDRfdGVzdC5zaA0KaW5kZXggNTM0ZDJiOS4uYTY3YjFiZSAxMDA3NTUNCi0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvZnMvZXh0NC1uZXctZmVhdHVyZXMvcnVuX2V4dDRfdGVzdC5zaA0K
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9mcy9leHQ0LW5ldy1mZWF0dXJlcy9ydW5fZXh0NF90ZXN0
LnNoDQpAQCAtMTc2LDQgKzE3NiwxOCBAQCBlbHNlDQogCVJFVD0xDQogZmkNCiANCisNCitlY2hv
ICIgIg0KK2VjaG8gIkV4dDQgZmFsbG9jYXRlIGhvbGUgcHVuY2ggdGVzdCINCitpZiBbIC1mICJl
eHQ0X2hvbGVfcHVuY2hfdGVzdC5zaCIgXTsgIHRoZW4NCisgICAgICAgIC4vZXh0NF9ob2xlX3B1
bmNoX3Rlc3Quc2ggLi9leHQ0LXRlc3QtY29uZmlnDQorICAgICAgICBpZiBbICQ/IC1uZSAwIF07
IHRoZW4NCisgICAgICAgICAgICAgICAgUkVUPTENCisgICAgICAgIGZpDQorZWxzZQ0KKyAgICAg
ICAgZWNobyAiU2hlbGwgZmlsZSBpcyBub3QgaW5zdGFsbGVkLi5QbGVhc2UgY2hlY2sgTWFrZWZp
bGUuLi4iDQorICAgICAgICBSRVQ9MQ0KK2ZpDQorDQorDQogZXhpdCAkUkVUDQo=

--=_mixed 0058302307257822_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
--=_mixed 0058302307257822_=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=_mixed 0058302307257822_=--

