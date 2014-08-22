Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XKibw-0008IC-Kx
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 06:46:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XKibv-0005oB-Bh
	for ltp-list@lists.sourceforge.net; Fri, 22 Aug 2014 06:46:08 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7M6jxvq011630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Aug 2014 02:46:00 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s7M6jweO011797
	for <ltp-list@lists.sourceforge.net>; Fri, 22 Aug 2014 02:45:59 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Aug 2014 08:45:56 +0200
Message-Id: <77268e159df98c56fa62012617a7c3f3b918f6b7.1408689882.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mmap15: don't fail if mmap returns EINVAL
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

T2xkZXIga2VybmVscyAoMi42LjMyKSBvbiBwcGM2NCByZXR1cm4gRUlOVkFMIGluc3RlYWQgb2Yg
RU5PTUVNLgoKTWFuIHBhZ2Ugc2F5czoKIkVJTlZBTCBXZSBkb27igJl0IGxpa2UgYWRkciwgbGVu
Z3RoLCBvciBvZmZzZXQgKGUuZy4sIHRoZXkgYXJlIHRvbyBsYXJnZSwKb3Igbm90IGFsaWduZWQg
b24gYSBwYWdlIGJvdW5kYXJ5KS4iLCB3aGljaCBzdWdnZXN0cyB0aGF0IGJvdGgKRU5PTUVNIGFu
ZCBFSU5WQUwgc2hvdWxkIGJlIGNvbnNpZGVyZWQuCgpTaWduZWQtb2ZmLWJ5OiBKYW4gU3RhbmNl
ayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21t
YXAvbW1hcDE1LmMgfCAgICA0ICsrLS0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bW1hcC9tbWFwMTUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTUuYwpp
bmRleCA0OWRiYmE0Li5mMWZjMjY3IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL21tYXAvbW1hcDE1LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21t
YXAxNS5jCkBAIC04MCwxMCArODAsMTAgQEAgaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpCiAJ
CQljb250aW51ZTsKIAkJfQogCi0JCWlmIChlcnJubyAhPSBFTk9NRU0pIHsKKwkJaWYgKGVycm5v
ICE9IEVOT01FTSAmJiBlcnJubyAhPSBFSU5WQUwpIHsKIAkJCXRzdF9yZXNtKFRGQUlMIHwgVEVS
Uk5PLCAibW1hcCBpbnRvIGhpZ2ggcmVnaW9uICIKIAkJCQkgImZhaWxlZCB1bmV4cGVjdGVkbHkg
LSBleHBlY3QgIgotCQkJCSAiZXJybm89RU5PTUVNLCBnb3QiKTsKKwkJCQkgImVycm5vPUVOT01F
TS9FSU5WQUwsIGdvdCIpOwogCQl9IGVsc2UgewogCQkJdHN0X3Jlc20oVFBBU1MgfCBURVJSTk8s
ICJtbWFwIGludG8gaGlnaCByZWdpb24gIgogCQkJCSAiZmFpbGVkIGFzIGV4cGVjdGVkIik7Ci0t
IAoxLjcuMQoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpTbGFzaGRvdCBUVi4gIApWaWRlbyBmb3Ig
TmVyZHMuICBTdHVmZiB0aGF0IG1hdHRlcnMuCmh0dHA6Ly90di5zbGFzaGRvdC5vcmcvCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxp
bmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
