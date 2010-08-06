Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Yingang.Fu@windriver.com>) id 1OhKfj-0005ej-I5
	for ltp-list@lists.sourceforge.net; Fri, 06 Aug 2010 11:01:07 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OhKfg-0007K5-3X
	for ltp-list@lists.sourceforge.net; Fri, 06 Aug 2010 11:01:07 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CB354D.17E46D30"
Date: Fri, 6 Aug 2010 11:52:31 +0200
Message-ID: <52CF90264091A14888078A031D780F43062CA316@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <4C56CAAF020000E800067098@sinclair.provo.novell.com>
References: <4C56CAAF020000E800067098@sinclair.provo.novell.com>
From: "Fu, Yingang" <Yingang.Fu@windriver.com>
Subject: [LTP] [Patch] The sysctl system call will return EACCES error
	number on the new kernel
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB354D.17E46D30
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

     The sysctl system call will return EACCES error number on the new
kernel when
    the user try to change the system parameter under
/proc/sys/kernel/ostype and
    some other readonly parameters, but sysctl03 expected EPERM which
will cause
    the test fail.

Thanks
Yingang

------_=_NextPart_001_01CB354D.17E46D30
Content-Type: application/octet-stream;
	name="sysctl03.patch"
Content-Transfer-Encoding: base64
Content-Description: sysctl03.patch
Content-Disposition: attachment;
	filename="sysctl03.patch"

LS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N5c2N0bC9zeXNjdGwwMy5jIHwgICA1NyAr
KysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9u
cygrKSwgMjAgZGVsZXRpb25zKC0pCgotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N5
c2N0bC9zeXNjdGwwMy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3lzY3RsL3N5
c2N0bDAzLmMKQEAgLTExMywxNiArMTEzLDI1IEBAIGludCBtYWluKGludCBhYywgY2hhciAqKmF2
KQogCQkJdHN0X3Jlc20oVEZBSUwsICJzeXNjdGwoMikgc3VjY2VlZGVkIHVuZXhwZWN0ZWRseSIp
OwogCQl9IGVsc2UgewogCQkJVEVTVF9FUlJPUl9MT0coVEVTVF9FUlJOTyk7Ci0KLQkJCWlmIChU
RVNUX0VSUk5PICE9IEVQRVJNKSB7Ci0JCQkJdHN0X3Jlc20oVEZBSUwsCi0JCQkJCSAiRXhwZWN0
ZWQgRVBFUk0gKCVkKSwgZ290ICVkOiAlcyIsCi0JCQkJCSBFUEVSTSwgVEVTVF9FUlJOTywKLQkJ
CQkJIHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKLQkJCX0gZWxzZSB7Ci0JCQkJdHN0X3Jlc20oVFBB
U1MsICJHb3QgZXhwZWN0ZWQgRVBFUk0gZXJyb3IiKTsKKwkJCWlmICh0c3Rfa3ZlcmNtcCgyLDYs
MzQpPDApeworCQkJCWlmIChURVNUX0VSUk5PICE9IEVQRVJNKSB7CisJCQkJCXRzdF9yZXNtKFRG
QUlMLAorCQkJCQkJCSJFeHBlY3RlZCBFUEVSTSAoJWQpLCBnb3QgJWQ6ICVzIiwKKwkJCQkJCQlF
UEVSTSwgVEVTVF9FUlJOTywKKwkJCQkJCQlzdHJlcnJvcihURVNUX0VSUk5PKSk7CisJCQkJfSBl
bHNlIHsKKwkJCQkJdHN0X3Jlc20oVFBBU1MsICJHb3QgZXhwZWN0ZWQgRVBFUk0gZXJyb3IiKTsK
KwkJCQl9IGVsc2UgeworCQkJCQlpZiAoVEVTVF9FUlJOTyAhPSBFQUNDRVMpIHsKKwkJCQkJCXRz
dF9yZXNtKFRGQUlMLAorCQkJCQkJCQkiRXhwZWN0ZWQgRUFDQ0VTKCVkKSwgZ290ICVkOiAlcyIs
CisJCQkJCQkJCUVBQ0NFUywgVEVTVF9FUlJOTywKKwkJCQkJCQkJc3RyZXJyb3IoVEVTVF9FUlJO
TykpOworCQkJCQl9IGVsc2UgeworCQkJCQkJdHN0X3Jlc20oVFBBU1MsICJHb3QgZXhwZWN0ZWQg
RUFDQ0VTIGVycm9yIik7CisJCQkJCX0KKwkJCQl9CiAJCQl9Ci0JCX0KIAogCQlvc25hbWVsdGgg
PSBTSVpFKG9zbmFtZSk7CiAJCWlmICgobHRwdXNlciA9IGdldHB3bmFtKCJub2JvZHkiKSkgPT0g
TlVMTCkgewpAQCAtMTQ2LDIwICsxNTUsMjggQEAgaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYp
CiAJCQkJdHN0X3Jlc20oVEZBSUwsICJjYWxsIHN1Y2NlZWRlZCB1bmV4cGVjdGVkbHkiKTsKIAkJ
CX0gZWxzZSB7CiAJCQkJVEVTVF9FUlJPUl9MT0coVEVTVF9FUlJOTyk7Ci0KLQkJCQlpZiAoVEVT
VF9FUlJOTyAhPSBFUEVSTSkgewotCQkJCQl0c3RfcmVzbShURkFJTCwgIkV4cGVjdGVkIEVQRVJN
LCBnb3QgIgotCQkJCQkJICIlZCIsIFRFU1RfRVJSTk8pOwotCQkJCX0gZWxzZSB7Ci0JCQkJCXRz
dF9yZXNtKFRQQVNTLCAiR290IGV4cGVjdGVkIEVQRVJNICIKLQkJCQkJCSAiZXJyb3IiKTsKKwkJ
CQlpZiAodHN0X2t2ZXJjbXAoMiw2LDM0KTwwKXsKKwkJCQkJaWYgKFRFU1RfRVJSTk8gIT0gRVBF
Uk0pIHsKKwkJCQkJCXRzdF9yZXNtKFRGQUlMLCAiRXhwZWN0ZWQgRVBFUk0sIGdvdCAiCisJCQkJ
CQkJCSIlZCIsIFRFU1RfRVJSTk8pOworCQkJCQl9IGVsc2UgeworCQkJCQkJdHN0X3Jlc20oVFBB
U1MsICJHb3QgZXhwZWN0ZWQgRVBFUk0gIgorCQkJCQkJCQkiZXJyb3IiKTsKKwkJCQkJfSBlbHNl
eworCQkJCQkJaWYgKFRFU1RfRVJSTk8gIT0gRUFDQ0VTKSB7CisJCQkJCQkJdHN0X3Jlc20oVEZB
SUwsICJFeHBlY3RlZCBFQUNDRVMsIGdvdCAiCisJCQkJCQkJCQkiJWQiLCBURVNUX0VSUk5PKTsK
KwkJCQkJCX0gZWxzZSB7CisJCQkJCQkJdHN0X3Jlc20oVFBBU1MsICJHb3QgZXhwZWN0ZWQgRUFD
Q0VTIgorCQkJCQkJCQkJImVycm9yIik7CisJCQkJCQl9CisJCQkJCX0KIAkJCQl9Ci0JCQl9CiAK
LQkJCWNsZWFudXAoKTsKKwkJCQljbGVhbnVwKCk7CiAKLQkJfSBlbHNlIHsJLyogcGFyZW50ICov
Ci0JCQkvKiB3YWl0IGZvciB0aGUgY2hpbGQgdG8gZmluaXNoICovCisJCQl9IGVsc2UgewkvKiBw
YXJlbnQgKi8KKwkJCQkvKiB3YWl0IGZvciB0aGUgY2hpbGQgdG8gZmluaXNoICovCiAJCQl3YWl0
KCZzdGF0dXMpOwogCQl9CiAK

------_=_NextPart_001_01CB354D.17E46D30
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
------_=_NextPart_001_01CB354D.17E46D30
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CB354D.17E46D30--

