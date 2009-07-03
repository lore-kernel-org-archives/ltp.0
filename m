Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXIg-0000sg-6y
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:10:50 +0000
Received: from an-out-0708.google.com ([209.85.132.244])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXIb-0001UD-Q7
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:10:50 +0000
Received: by an-out-0708.google.com with SMTP id c38so873288ana.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:10:45 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 2 Jul 2009 17:41:28 -0700
Message-ID: <364299f40907021741l44726656y344a1adb42207179@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=0016368e1ee8bd5f70046dc26a0c
Subject: [LTP] [PATCH 2/10] config.mk not required for clean
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
To: LTP list <ltp-list@lists.sourceforge.net>

--0016368e1ee8bd5f70046dc26a0c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

In order to loosen the requirement of having config.mk for a clean /
distclean operation, we need to check for %clean in MAKECMDGOALS.

Other associated changes are:
1. Standardizing variables.
2. Adding missing GPLv2 copyright notices to tops of Makefiles.

        Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

--0016368e1ee8bd5f70046dc26a0c
Content-Type: application/octet-stream; 
	name="config.mk-not-reqd-for-clean.2.diff"
Content-Disposition: attachment; 
	filename="config.mk-not-reqd-for-clean.2.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwo6jkb10

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9zcmMvTWFrZWZp
bGUKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvbHRwL2x0cC90ZXN0Y2FzZXMva2VybmVs
L3NlY3VyaXR5L2ludGVncml0eS9pbWEvc3JjL01ha2VmaWxlLHYKcmV0cmlldmluZyByZXZpc2lv
biAxLjEKZGlmZiAtdSAtcjEuMSBNYWtlZmlsZQotLS0gdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0
eS9pbnRlZ3JpdHkvaW1hL3NyYy9NYWtlZmlsZQkzMSBNYXIgMjAwOSAxMzo1ODoxNCAtMDAwMAkx
LjEKKysrIHRlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS9zcmMvTWFrZWZp
bGUJMyBKdWwgMjAwOSAwMDozOTo1NCAtMDAwMApAQCAtMSwxMiArMSw0MSBAQAotaW5jbHVkZSAu
Li8uLi8uLi8uLi8uLi8uLi9jb25maWcubWsKKyMKKyMgICAgTWFrZWZpbGUgZm9yOiBrZXJuZWwv
c2VjdXJpdHkvaW50ZWdyaXR5L2ltYSB0ZXN0Y2FzZS4KKyMKKyMgICAgQ29weXJpZ2h0IChDKSAy
MDA5LCBDaXNjbyBTeXN0ZW1zIEluYy4KKyMKKyMgICAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyMgICAgaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNo
ZWQgYnkKKyMgICAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24g
MiBvZiB0aGUgTGljZW5zZSwgb3IKKyMgICAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVy
c2lvbi4KKyMKKyMgICAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRo
YXQgaXQgd2lsbCBiZSB1c2VmdWwsCisjICAgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0
aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisjICAgIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUKKyMgICAgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KKyMKKyMgICAgWW91IHNob3Vs
ZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
YWxvbmcKKyMgICAgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUg
U29mdHdhcmUgRm91bmRhdGlvbiwgSW5jLiwKKyMgICAgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0
aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQS4KKyMKKyMgR2FycmV0dCBDb29wZXIs
IEp1bHkgMjAwOQorIworIyBDb3B5cmlnaHQgKGMpIDIwMDkgYnkgQ2lzY28gU3lzdGVtcywgSW5j
LgorIyBBbGwgcmlnaHRzIHJlc2VydmVkCisjCisKK3NyY2RpcgkJCT89IC4uLy4uLy4uLy4uCisK
K2lmbmVxICgkKE1BS0VDTURHT0FMUyksY2xlYW4pCitpbmNsdWRlICQoc3JjZGlyKS9jb25maWcu
bWsKK2VuZGlmCiAKIGlmZXEgKCQoQ1JZUFRPX0xJQiksLWxjcnlwdG8pCi0JVEFSR0VUUz1pbWFf
bW1hcCBpbWFfbWVhc3VyZSBpbWFfYm9vdF9hZ2dyZWdhdGUKLQlMRExJQlMgKz0gJChDUllQVE9f
TElCKQotZWxzZQotCVRBUkdFVFM9aW1hX21tYXAKK1RBUkdFVFMJCQk6PSBpbWFfbWVhc3VyZSBp
bWFfYm9vdF9hZ2dyZWdhdGUKK0xETElCUwkJCSs9ICQoQ1JZUFRPX0xJQikKIGVuZGlmCiAKK1RB
UkdFVFMJCQkrPSBpbWFfbW1hcAorCiBhbGw6ICQoVEFSR0VUUykKIAogaW5zdGFsbDoK
--0016368e1ee8bd5f70046dc26a0c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--0016368e1ee8bd5f70046dc26a0c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016368e1ee8bd5f70046dc26a0c--

