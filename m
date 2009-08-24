Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MfYc7-0005BR-P5
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 12:25:31 +0000
Received: from mail-px0-f181.google.com ([209.85.216.181])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MfYby-000071-Q9
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 12:25:31 +0000
MIME-Version: 1.0
Date: Mon, 24 Aug 2009 17:46:09 +0530
Message-ID: <d51f89b0908240516n1b4ca28m988feb00f077fbd7@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Content-Type: multipart/mixed; boundary=00504502dab6dfaf970471e22ee7
Subject: [LTP] Patch for smt_smp_affinity
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

--00504502dab6dfaf970471e22ee7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dear Subrata,

smt_smp_ affinity test case is passing on Fedora but fails on Ubuntu
for the same H/W.On Ubuntu system, after doing strace i observed that
system call sched_getaffinity was returning -1 [ERROR:EINVAL] due to
second argument.

sched_getaffinity(pid, sizeof(unsigned int), &mask1)

Please find attached herewith the patch which fixes the issue.

Thank you,

-- 
Regards,
Rohit

--00504502dab6dfaf970471e22ee7
Content-Type: text/plain; charset=US-ASCII; name="smt_smp_affinity_patch.txt"
Content-Disposition: attachment; filename="smt_smp_affinity_patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fymxch4a0

U2lnbmVkLW9mZi1ieTogcm9oaXQgdmVybWEgKHJvaGl0MTcwMzA5QGdtYWlsLmNvbSkKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQpkaWZmIC1ydU5CIGx0cC1mdWxsLTIwMDkwNzMxX29sZC90ZXN0Y2Fz
ZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0X2FmZmluaXR5L0hUYWZmaW5pdHkuYyBs
dHAtZnVsbC0yMDA5MDczMS90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0
X2FmZmluaXR5L0hUYWZmaW5pdHkuYwotLS0gbHRwLWZ1bGwtMjAwOTA3MzFfb2xkL3Rlc3RjYXNl
cy9rZXJuZWwvc2NoZWQvaHlwZXJ0aHJlYWRpbmcvaHRfYWZmaW5pdHkvSFRhZmZpbml0eS5jCTIw
MDktMDYtMjMgMTk6MjM6NTUuMDAwMDAwMDAwICswNTMwCisrKyBsdHAtZnVsbC0yMDA5MDczMS90
ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2h5cGVydGhyZWFkaW5nL2h0X2FmZmluaXR5L0hUYWZmaW5p
dHkuYwkyMDA5LTA4LTIxIDE3OjEwOjUzLjAwMDAwMDAwMCArMDUzMApAQCAtMTYsNiArMTYsNyBA
QAogI2luY2x1ZGUgPHN5cy9zeXNjYWxsLmg+CiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAjaW5j
bHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8c3lzL3dhaXQuaD4KICNpbmNsdWRlIDxzdGRpby5o
PgogI2luY2x1ZGUgPHN0ZGxpYi5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgpAQCAtNDcsNyArNDgs
NyBAQAogCiBpbnQgSFRfU2V0QWZmaW5pdHkoKQogewotCXVuc2lnbmVkIG1hc2s7CisJdW5zaWdu
ZWQgaW50IG1hc2s7CiAJcGlkX3QgcGlkOwogCWludCByZXN1bHQ9MTsKIAlpbnQgY3B1X2NvdW50
LCBpLCBqLCBrLCBjcHVpZDsKQEAgLTE2MSwzMCArMTYyLDMwIEBACiAKIGludCBIVF9HZXRBZmZp
bml0eSgpCiB7Ci0JdW5zaWduZWQgbG9uZyBtYXNrLCBtYXNrMTsKKwl1bnNpZ25lZCBpbnQgbWFz
a1syXSwgbWFzazFbMl07CiAJcGlkX3QgcGlkOwogCi0JbWFzaz0weDE7Ci0JcGlkPWdldHBpZCgp
OworCW1hc2tbMF0gPSAweDE7CisJcGlkID0gZ2V0cGlkKCk7CiAKIAl0c3RfcmVzbShUSU5GTywg
IkdldCBhZmZpbml0eSB0aHJvdWdoIHN5c3RlbSBjYWxsLlxuIik7CiAKLQlzY2hlZF9zZXRhZmZp
bml0eShwaWQsIHNpemVvZih1bnNpZ25lZCBpbnQpLCAmbWFzayk7CisJc2NoZWRfc2V0YWZmaW5p
dHkocGlkLCBzaXplb2YobWFzayksIG1hc2spOwogCiAJc2xlZXAoMSk7CiAKLQlzY2hlZF9nZXRh
ZmZpbml0eShwaWQsIHNpemVvZih1bnNpZ25lZCBpbnQpLCAmbWFzazEpOworCXNjaGVkX2dldGFm
ZmluaXR5KHBpZCwgc2l6ZW9mKG1hc2spLCBtYXNrMSk7CiAKLQlpZiAobWFzayA9PSAweDEgJiYg
bWFzayA9PSBtYXNrMSkKKwlpZiAobWFza1swXSA9PSAweDEgJiYgbWFza1swXSA9PSBtYXNrMVsw
XSkKIAl7Ci0JCW1hc2s9MHgyOwotCQlzY2hlZF9zZXRhZmZpbml0eShwaWQsIHNpemVvZih1bnNp
Z25lZCBsb25nKSwgJm1hc2spOworCQltYXNrWzBdID0gMHgyOworCQlzY2hlZF9zZXRhZmZpbml0
eShwaWQsIHNpemVvZihtYXNrKSwgbWFzayk7CiAKIAkJc2xlZXAoMSk7CiAKLQkJc2NoZWRfZ2V0
YWZmaW5pdHkocGlkLCBzaXplb2YodW5zaWduZWQgaW50KSwgJm1hc2sxKTsKKwkJc2NoZWRfZ2V0
YWZmaW5pdHkocGlkLCBzaXplb2YobWFzayksIG1hc2sxKTsKIAotCQlpZiAobWFzayA9PSAweDIg
JiYgbWFzayA9PSBtYXNrMSkKKwkJaWYgKG1hc2tbMF0gPT0gMHgyICYmIG1hc2tbMF0gPT0gbWFz
azFbMF0pCiAJCQlyZXR1cm4gMTsKIAkJZWxzZQogCQkJcmV0dXJuIDA7CkBAIC0xOTUsMjkgKzE5
NiwzNSBAQAogCiBpbnQgSFRfSW5oZXJpdEFmZmluaXR5KCkKIHsKLQl1bnNpZ25lZCBsb25nIG1h
c2s7CisJdW5zaWduZWQgaW50IG1hc2tbMl07CiAJcGlkX3QgcGlkOworCWludCBzdGF0dXM7CisJ
bWFza1swXSA9IDB4MjsKKwlwaWQgPSBnZXRwaWQoKTsKIAotCW1hc2s9MHgyOwotCXBpZD1nZXRw
aWQoKTsKLQotCXRzdF9yZXNtKFRJTkZPLCAiSW5oZXJpdCBhZmZpbml0eSBmcm9tIHBhcmVudCBw
cm9jZXNzLlxuIik7Ci0KLQlzY2hlZF9zZXRhZmZpbml0eShwaWQsIHNpemVvZih1bnNpZ25lZCBp
bnQpLCAmbWFzayk7CisJc2NoZWRfc2V0YWZmaW5pdHkocGlkLCBzaXplb2YobWFzayksIG1hc2sp
OwogCiAJc2xlZXAoMSk7Ci0KLQlpZigocGlkPWZvcmsoKSk9PTApCisJcGlkID0gZm9yaygpOwor
CWlmIChwaWQgID09IDApCiAJewogCQlzbGVlcCgxKTsKLQkJc3lzdGVtKCJwcyA+IC9kZXYvbnVs
bCIpOwotCQlleGl0KDApOwotCX0KKwkJc2NoZWRfZ2V0YWZmaW5pdHkocGlkLCBzaXplb2YobWFz
ayksIG1hc2spOworCQlpZiAobWFza1swXSA9PSAweDIpCisJCQlleGl0KDApOwogCi0Jc2NoZWRf
Z2V0YWZmaW5pdHkocGlkLCBzaXplb2YodW5zaWduZWQgaW50KSwgJm1hc2spOworCQllbHNlCisJ
CQlleGl0KDEpOworCX0gZWxzZSBpZiAocGlkIDwgMCkgeworCQl0c3RfcmVzbShUSU5GTywgIklu
aGVyaXQgYWZmaW5pdHk6Zm9yayBmYWlsZWQhIC5cbiIpOworCQlyZXR1cm4gMDsKKwl9CisJd2Fp
dHBpZChwaWQsICZzdGF0dXMsIDApOwogCi0JaWYobWFzaz09MHgyKQorCWlmIChXRVhJVFNUQVRV
UyhzdGF0dXMpID09IDApIHsKKwkJdHN0X3Jlc20oVElORk8sICJJbmhlcml0ZWQgYWZmaW5pdHkg
ZnJvbSBwYXJlbnQgcHJvY2Vzcy5cbiIpOwogCQlyZXR1cm4gMTsKKwl9CiAJZWxzZQogCQlyZXR1
cm4gMDsKIH0K
--00504502dab6dfaf970471e22ee7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--00504502dab6dfaf970471e22ee7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00504502dab6dfaf970471e22ee7--

