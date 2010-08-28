Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1OpBD0-00008f-KU
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 02:31:54 +0000
Received: from mail-qy0-f175.google.com ([209.85.216.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OpBCz-0004zm-LX
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 02:31:54 +0000
Received: by qyk8 with SMTP id 8so1380724qyk.13
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Aug 2010 19:31:48 -0700 (PDT)
MIME-Version: 1.0
From: Henry Yei <hyei@mvista.com>
Date: Fri, 27 Aug 2010 19:31:28 -0700
Message-ID: <AANLkTimbmgK15xY-3d-S4GHpKVMEjXpzbkUdMS-aTGZn@mail.gmail.com>
Content-Type: multipart/mixed; boundary=0015175cd2c07b9672048ed90824
Subject: [LTP] [PATCH] {kernel/syscalls] fix signalfd4 tests to use
 SIGSETSIZE instead of 8
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

--0015175cd2c07b9672048ed90824
Content-Type: text/plain; charset=ISO-8859-1

The signalfd4 tests have a hardcoded value of 8 instead of using SIGSETSIZE.

Signed-off-by: Henry Yei <hyei@mvista.com>

Henry Yei <hyei@mvista.com>

--0015175cd2c07b9672048ed90824
Content-Type: text/x-patch; charset=US-ASCII; name="signalfd4.patch"
Content-Disposition: attachment; filename="signalfd4.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gddupcjb0

ZGlmZiAtTnVycCAteCBDVlMgLXggTWFrZWZpbGUgbHRwLTIwMDkwNTMxL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc2lnbmFsZmQ0L3NpZ25hbGZkNF8wMS5jIGx0cC13ZGlyL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvc2lnbmFsZmQ0L3NpZ25hbGZkNF8wMS5jCi0tLSBsdHAtMjAwOTA1MzEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zaWduYWxmZDQvc2lnbmFsZmQ0XzAxLmMJMjAwOS0w
My0yMyAwNjozNjowNi4wMDAwMDAwMDAgLTA3MDAKKysrIGx0cC13ZGlyL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc2lnbmFsZmQ0L3NpZ25hbGZkNF8wMS5jCTIwMDktMTEtMTkgMTQ6NDg6NDgu
ODg0Mzg0MjE0IC0wODAwCkBAIC0xNjEsNyArMTYzLDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKmFyZ3ZbXSkKIAkJZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVz
dG5vKSB7CiAJCQlzaWdlbXB0eXNldCgmc3MpOwogCQkJc2lnYWRkc2V0KCZzcywgU0lHVVNSMSk7
Ci0JCQlmZCA9IHN5c2NhbGwoX19OUl9zaWduYWxmZDQsIC0xLCAmc3MsIDgsIDApOworCQkJZmQg
PSBzeXNjYWxsKF9fTlJfc2lnbmFsZmQ0LCAtMSwgJnNzLCBTSUdTRVRTSVpFLCAwKTsKIAkJCWlm
IChmZCA9PSAtMSkgewogCQkJCXRzdF9yZXNtKFRGQUlMLCAic2lnbmFsZmQ0KDApIGZhaWxlZCIp
OwogCQkJCWNsZWFudXAoKTsKQEAgLTE4MCw3ICsxODIsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqYXJndltdKQogCQkJfQogCQkJY2xvc2UoZmQpOwogCi0JCQlmZCA9IHN5c2NhbGwoX19O
Ul9zaWduYWxmZDQsIC0xLCAmc3MsIDgsIFNGRF9DTE9FWEVDKTsKKwkJCWZkID0gc3lzY2FsbChf
X05SX3NpZ25hbGZkNCwgLTEsICZzcywgU0lHU0VUU0laRSwgU0ZEX0NMT0VYRUMpOwogCQkJaWYg
KGZkID09IC0xKSB7CiAJCQkJdHN0X3Jlc20oVEZBSUwsCiAJCQkJCSAic2lnbmFsZmQ0KFNGRF9D
TE9FWEVDKSBmYWlsZWQiKTsKZGlmZiAtTnVycCAteCBDVlMgLXggTWFrZWZpbGUgbHRwLTIwMDkw
NTMxL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lnbmFsZmQ0L3NpZ25hbGZkNF8wMi5jIGx0
cC13ZGlyL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lnbmFsZmQ0L3NpZ25hbGZkNF8wMi5j
Ci0tLSBsdHAtMjAwOTA1MzEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zaWduYWxmZDQvc2ln
bmFsZmQ0XzAyLmMJMjAwOS0wMy0yMyAwNjozNjowNi4wMDAwMDAwMDAgLTA3MDAKKysrIGx0cC13
ZGlyL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lnbmFsZmQ0L3NpZ25hbGZkNF8wMi5jCTIw
MDktMTEtMTkgMTQ6NDk6MDUuMDEyMzg0Mzg5IC0wODAwCkBAIC0xNTMsNyArMTU1LDcgQEAgaW50
IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8g
PCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7CiAJCQlzaWdlbXB0eXNldCgmc3MpOwogCQkJc2lnYWRk
c2V0KCZzcywgU0lHVVNSMSk7Ci0JCQlmZCA9IHN5c2NhbGwoX19OUl9zaWduYWxmZDQsIC0xLCAm
c3MsIDgsIDApOworCQkJZmQgPSBzeXNjYWxsKF9fTlJfc2lnbmFsZmQ0LCAtMSwgJnNzLCBTSUdT
RVRTSVpFLCAwKTsKIAkJCWlmIChmZCA9PSAtMSkgewogCQkJCXRzdF9yZXNtKFRGQUlMLCAic2ln
bmFsZmQ0KDApIGZhaWxlZCIpOwogCQkJCWNsZWFudXAoKTsKQEAgLTE3Miw3ICsxNzQsNyBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQkJfQogCQkJY2xvc2UoZmQpOwogCi0J
CQlmZCA9IHN5c2NhbGwoX19OUl9zaWduYWxmZDQsIC0xLCAmc3MsIDgsIFNGRF9OT05CTE9DSyk7
CisJCQlmZCA9IHN5c2NhbGwoX19OUl9zaWduYWxmZDQsIC0xLCAmc3MsIFNJR1NFVFNJWkUsIFNG
RF9OT05CTE9DSyk7CiAJCQlpZiAoZmQgPT0gLTEpIHsKIAkJCQl0c3RfcmVzbShURkFJTCwKIAkJ
CQkJICJzaWduYWxmZDQoU0ZEX05PTkJMT0NLKSBmYWlsZWQiKTsK
--0015175cd2c07b9672048ed90824
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
--0015175cd2c07b9672048ed90824
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0015175cd2c07b9672048ed90824--

