Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1OpBUz-0007mq-Cr
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 02:50:29 +0000
Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OpBUy-00060N-Ib
	for ltp-list@lists.sourceforge.net; Sat, 28 Aug 2010 02:50:29 +0000
Received: by qwa26 with SMTP id 26so1384363qwa.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Aug 2010 19:50:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTimbmgK15xY-3d-S4GHpKVMEjXpzbkUdMS-aTGZn@mail.gmail.com>
References: <AANLkTimbmgK15xY-3d-S4GHpKVMEjXpzbkUdMS-aTGZn@mail.gmail.com>
From: Henry Yei <hyei@mvista.com>
Date: Fri, 27 Aug 2010 19:49:54 -0700
Message-ID: <AANLkTik8Vy691CGvtyK-MEwdFxLeNotdkpXkgOVP51W6@mail.gmail.com>
Content-Type: multipart/mixed; boundary=00163630f7b7686bb9048ed94ac6
Subject: Re: [LTP] [PATCH] {kernel/syscalls] fix signalfd4 tests to use
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

--00163630f7b7686bb9048ed94ac6
Content-Type: text/plain; charset=ISO-8859-1

Please ignore the last patch. I attached an earlier incomplete version).
Here is an updated patch which has the necessary  ltp_signal.h include
file for the SIGSETSIZE definition.

Henry Yei <hyei@mvista.com>





On Fri, Aug 27, 2010 at 7:31 PM, Henry Yei <hyei@mvista.com> wrote:
> The signalfd4 tests have a hardcoded value of 8 instead of using SIGSETSIZE.
>
> Signed-off-by: Henry Yei <hyei@mvista.com>
>
> Henry Yei <hyei@mvista.com>
>

--00163630f7b7686bb9048ed94ac6
Content-Type: text/x-patch; charset=US-ASCII; name="signalfd4.patch"
Content-Disposition: attachment; filename="signalfd4.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gddvh7rc1

ZGlmZiAtTnVycCAtciBsdHAtZGV2L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lnbmFsZmQ0
L3NpZ25hbGZkNF8wMS5jIGx0cC1kZXYtd2Rpci90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Np
Z25hbGZkNC9zaWduYWxmZDRfMDEuYwotLS0gbHRwLWRldi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3NpZ25hbGZkNC9zaWduYWxmZDRfMDEuYwkyMDEwLTA0LTMwIDE0OjU3OjE3LjAwMDAwMDAw
MCAtMDcwMAorKysgbHRwLWRldi13ZGlyL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2lnbmFs
ZmQ0L3NpZ25hbGZkNF8wMS5jCTIwMTAtMDgtMjcgMTk6NDY6MDIuOTA4NDQyMTE0IC0wNzAwCkBA
IC02NSw2ICs2NSw3IEBACiAjaW5jbHVkZSAidGVzdC5oIgogI2luY2x1ZGUgInVzY3Rlc3QuaCIK
ICNpbmNsdWRlICJsaW51eF9zeXNjYWxsX251bWJlcnMuaCIKKyNpbmNsdWRlICJsdHBfc2lnbmFs
LmgiCiAKICNpZm5kZWYgT19DTE9FWEVDCiAjIGRlZmluZSBPX0NMT0VYRUMgMDIwMDAwMDAKQEAg
LTE2MSw3ICsxNjIsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQlmb3Ig
KHRlc3RubyA9IDA7IHRlc3RubyA8IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHsKIAkJCXNpZ2VtcHR5
c2V0KCZzcyk7CiAJCQlzaWdhZGRzZXQoJnNzLCBTSUdVU1IxKTsKLQkJCWZkID0gc3lzY2FsbChf
X05SX3NpZ25hbGZkNCwgLTEsICZzcywgOCwgMCk7CisJCQlmZCA9IHN5c2NhbGwoX19OUl9zaWdu
YWxmZDQsIC0xLCAmc3MsIFNJR1NFVFNJWkUsIDApOwogCQkJaWYgKGZkID09IC0xKSB7CiAJCQkJ
dHN0X3Jlc20oVEZBSUwsICJzaWduYWxmZDQoMCkgZmFpbGVkIik7CiAJCQkJY2xlYW51cCgpOwpA
QCAtMTgwLDcgKzE4MSw3IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJCQl9
CiAJCQljbG9zZShmZCk7CiAKLQkJCWZkID0gc3lzY2FsbChfX05SX3NpZ25hbGZkNCwgLTEsICZz
cywgOCwgU0ZEX0NMT0VYRUMpOworCQkJZmQgPSBzeXNjYWxsKF9fTlJfc2lnbmFsZmQ0LCAtMSwg
JnNzLCBTSUdTRVRTSVpFLCBTRkRfQ0xPRVhFQyk7CiAJCQlpZiAoZmQgPT0gLTEpIHsKIAkJCQl0
c3RfcmVzbShURkFJTCwKIAkJCQkJICJzaWduYWxmZDQoU0ZEX0NMT0VYRUMpIGZhaWxlZCIpOwpk
aWZmIC1OdXJwIC1yIGx0cC1kZXYvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zaWduYWxmZDQv
c2lnbmFsZmQ0XzAyLmMgbHRwLWRldi13ZGlyL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2ln
bmFsZmQ0L3NpZ25hbGZkNF8wMi5jCi0tLSBsdHAtZGV2L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvc2lnbmFsZmQ0L3NpZ25hbGZkNF8wMi5jCTIwMTAtMDQtMzAgMTQ6NTc6MTcuMDAwMDAwMDAw
IC0wNzAwCisrKyBsdHAtZGV2LXdkaXIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zaWduYWxm
ZDQvc2lnbmFsZmQ0XzAyLmMJMjAxMC0wOC0yNyAxOTo0NjowOS4zMzI0NDI5NjggLTA3MDAKQEAg
LTYxLDYgKzYxLDcgQEAKICNpbmNsdWRlICJ0ZXN0LmgiCiAjaW5jbHVkZSAidXNjdGVzdC5oIgog
I2luY2x1ZGUgImxpbnV4X3N5c2NhbGxfbnVtYmVycy5oIgorI2luY2x1ZGUgImx0cF9zaWduYWwu
aCIKIAogI2RlZmluZSBTRkRfTk9OQkxPQ0sgT19OT05CTE9DSwogCkBAIC0xNTMsNyArMTU0LDcg
QEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkJZm9yICh0ZXN0bm8gPSAwOyB0
ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7CiAJCQlzaWdlbXB0eXNldCgmc3MpOwogCQkJ
c2lnYWRkc2V0KCZzcywgU0lHVVNSMSk7Ci0JCQlmZCA9IHN5c2NhbGwoX19OUl9zaWduYWxmZDQs
IC0xLCAmc3MsIDgsIDApOworCQkJZmQgPSBzeXNjYWxsKF9fTlJfc2lnbmFsZmQ0LCAtMSwgJnNz
LCBTSUdTRVRTSVpFLCAwKTsKIAkJCWlmIChmZCA9PSAtMSkgewogCQkJCXRzdF9yZXNtKFRGQUlM
LCAic2lnbmFsZmQ0KDApIGZhaWxlZCIpOwogCQkJCWNsZWFudXAoKTsKQEAgLTE3Miw3ICsxNzMs
NyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQkJfQogCQkJY2xvc2UoZmQp
OwogCi0JCQlmZCA9IHN5c2NhbGwoX19OUl9zaWduYWxmZDQsIC0xLCAmc3MsIDgsIFNGRF9OT05C
TE9DSyk7CisJCQlmZCA9IHN5c2NhbGwoX19OUl9zaWduYWxmZDQsIC0xLCAmc3MsIFNJR1NFVFNJ
WkUsIFNGRF9OT05CTE9DSyk7CiAJCQlpZiAoZmQgPT0gLTEpIHsKIAkJCQl0c3RfcmVzbShURkFJ
TCwKIAkJCQkJICJzaWduYWxmZDQoU0ZEX05PTkJMT0NLKSBmYWlsZWQiKTsK
--00163630f7b7686bb9048ed94ac6
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
--00163630f7b7686bb9048ed94ac6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00163630f7b7686bb9048ed94ac6--

