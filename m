Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1Op7SV-0007dy-9S
	for ltp-list@lists.sourceforge.net; Fri, 27 Aug 2010 22:31:39 +0000
Received: from mail-qy0-f174.google.com ([209.85.216.174])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Op7SS-0004cR-Td
	for ltp-list@lists.sourceforge.net; Fri, 27 Aug 2010 22:31:39 +0000
MIME-Version: 1.0
From: Henry Yei <hyei@mvista.com>
Date: Fri, 27 Aug 2010 15:05:06 -0700
Message-ID: <AANLkTi==cD1PmyzusPB-8_Bfj2fy2WoSFgpdSFm_BgdQ@mail.gmail.com>
Content-Type: multipart/mixed; boundary=0016e68ce6f2e10874048ed54fd1
Subject: [LTP] [PATCH] [commands] apply relevant fixes to at_deny01 to
 at_allow01 script
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
To: ltp-list <ltp-list@lists.sf.net>

--0016e68ce6f2e10874048ed54fd1
Content-Type: text/plain; charset=ISO-8859-1

I've prepared a patch for at_allow01 that essentially duplicates the
fixes that were checked in for at_deny01. This fixes the script to
actually run the test when the at utility in stead of returning TCONF,
correcting test environment, and let the script run normally without
changing the password. See commit
a589d12b0b49287d10f43b1a1fb72950819588eb for more details.

Signed-off-by: Henry Yei <hyei@mvista.com>

Henry Yei <hyei@mvista.com>

--0016e68ce6f2e10874048ed54fd1
Content-Type: text/x-patch; charset=US-ASCII; name="at_allow01.patch"
Content-Disposition: attachment; filename="at_allow01.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gddkby260

LS0tIGx0cC1kZXYvdGVzdGNhc2VzL2NvbW1hbmRzL2F0L2F0X2FsbG93MDEJMjAxMC0wNC0zMCAx
NTozMzoxMC4wMDAwMDAwMDAgLTA3MDAKKysrIGx0cC1kZXYtd2Rpci90ZXN0Y2FzZXMvY29tbWFu
ZHMvYXQvYXRfYWxsb3cwMQkyMDEwLTA4LTI2IDE5OjM4OjA1Ljk2MDQ0MDQwMSAtMDcwMApAQCAt
NzMsNiArNzMsMTIgQEAgZG9fc2V0dXAoKQogCSMgdXNlcnMnIGhvbWUgZGlyZWN0b3JpZXMsIGFu
ZCBydW4gaXQgZnJvbSB0aGVyZS4KIAljcCAiJDAiICIke3Rlc3RfdXNlcjFfaG9tZX0vLiIKIAlj
cCAiJDAiICIke3Rlc3RfdXNlcjJfaG9tZX0vLiIKKwllY2hvICJleHBvcnQgTFRQUk9PVD0nJExU
UFJPT1QnIiA+ICIke3Rlc3RfdXNlcjFfaG9tZX0vY2FjaGVkX2x0cHJvb3QiCisJZWNobyAiZXhw
b3J0IExUUFJPT1Q9JyRMVFBST09UJyIgPiAiJHt0ZXN0X3VzZXIyX2hvbWV9L2NhY2hlZF9sdHBy
b290IgorCWlmIFsgJD8gLW5lIDAgXTsgdGhlbgorCQl0c3RfcmVzbSBUQlJPSyAiQ291bGRuJ3Qg
Y29weSBvdmVyIHJlcSdkIGZpbGVzIGZvciB0ZXN0IHVzZXJzIgorCQlleGl0IDEKKwlmaQkKIAog
CSMgUmVzdGFydCBhdGQgZGFlbW9uLgogCS9ldGMvaW5pdC5kL2F0ZCByZXN0YXJ0CkBAIC05OCw3
ICsxMDQsMTAgQEAgZG9fY2xlYW51cCgpCiAjLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHJ1bl90ZXN0KCkKIHsK
LQlpZiBbICQod2hvYW1pKSA9ICIke3Rlc3RfdXNlcjF9IiBdOyB0aGVuIAorCWlmIFsgJCh3aG9h
bWkpID0gIiR7dGVzdF91c2VyMX0iIF07IHRoZW4KKwkJLiAiJHt0ZXN0X3VzZXIxX2hvbWV9L2Nh
Y2hlZF9sdHByb290IiB8fCBleGl0IDEKKwkJZXhwb3J0IFBBVEg9IiRQQVRIOiRMVFBST09UL3Rl
c3RjYXNlcy9iaW4iCisKIAkJZWNobyAiVEVTVDogJGFsbG93IHNob3VsZCBhbGxvdyBvbmx5IHRo
b3NlIHdobyBpbiB0aGUgZmlsZSB0byBydW4gam9icy4iCiAJCWVjaG8gIigxKSBURVNUIFRIQVQg
UEVSU09OIElOICR7YWxsb3d9IElTIEFCTEUgVE8gUlVOIEpPQi4iCiAJCWVjaG8gImVjaG8gJ1RF
U1QgSk9CIFJBTicgPj5cIiR7dG1wZmlsZX1cIiAyPiYxIiB8CkBAIC0xMjEsNiArMTMwLDEwIEBA
IHJ1bl90ZXN0KCkKIAkJZXhpdCAke2V4aXRfY29kZX0KIAogCWVsaWYgWyAkKHdob2FtaSkgPSAi
JHt0ZXN0X3VzZXIyfSIgXTsgdGhlbgorCisJCS4gIiR7dGVzdF91c2VyMl9ob21lfS9jYWNoZWRf
bHRwcm9vdCIgfHwgZXhpdCAxCisJCWV4cG9ydCBQQVRIPSIkUEFUSDokTFRQUk9PVC90ZXN0Y2Fz
ZXMvYmluIgorCiAJCWVjaG8gIigyKSBURVNUIFBFUlNPTiBUSEFUIElTIE5PVCBJTiAke2FsbG93
fSBJUyBOT1QgQUJMRSBUTyBSVU4gSk9CLiIKIAkJZWNobyAiZWNobyAnVEVTVCBKT0IgUkFOJyA+
PlwiJHt0bXBmaWxlfVwiIDI+JjEiIHwKIAkJaWYgISBhdCAtbSBub3cgKyAxIG1pbnV0ZXM7IHRo
ZW4KQEAgLTE0NSw3ICsxNTgsNyBAQCBydW5fdGVzdCgpCiAjLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICMgRlVO
Q1RJT046IG1haW4KICMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQotaWYgdHlwZSBhdCA+IC9kZXYvbnVsbDsgdGhl
bgoraWYgISB0eXBlIGF0ID4gL2Rldi9udWxsOyB0aGVuCiAJdHN0X3Jlc20gVENPTkYgImF0IGNv
bW1hbmQgbm90IGZvdW5kIG9uIHN5c3RlbSIKIGVsaWYgWyAiJChpZCAtcnUpIiA9IDAgXTsgdGhl
bgogCWlmIGRvX3NldHVwOyB0aGVuCg==
--0016e68ce6f2e10874048ed54fd1
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
--0016e68ce6f2e10874048ed54fd1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016e68ce6f2e10874048ed54fd1--

