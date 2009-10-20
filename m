Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1N0Jkt-0003qK-SM
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 18:48:23 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by 1b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N0Jkn-0004KJ-HM
	for ltp-list@lists.sourceforge.net; Tue, 20 Oct 2009 18:48:23 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA51B5.DF3C324C"
Date: Tue, 20 Oct 2009 11:50:16 -0700
Message-ID: <8368651DACC1964480F951191B94A0780153D9C0@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A0780153D7BE@svexch01.mvista.com>
	<364299f40910162217w545c9108rbdac6e26fa0cf563@mail.gmail.com>
	<1255890117.5359.17.camel@subratamodak.linux.ibm.com> 
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH][fs tests] modify tests to honor tmpdirectory
	passed into runltp, convert to LTP format
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
To: Henry Yei <hyei@mvista.com>, subrata@linux.vnet.ibm.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA51B5.DF3C324C
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Henry Yei
> Sent: Tuesday, October 20, 2009 11:49 AM
> To: 'subrata@linux.vnet.ibm.com'
> Cc: LTP Mailing List; Garrett Cooper
> Subject: RE: [LTP] [PATCH][fs tests] modify tests to honor =
tmpdirectory
> passed into runltp, convert to LTP format
>=20
> Subrata,
>=20
> Yes, please ignore the linker01.patch. I had created it before I
> realized there was a later check-in. It was accidentally included in =
my
> haste.
>=20
> I've attached the lftest patch that should apply to CVS. I had an =
issue
> with my eclipse IDE mangling the patches that I need to address.
>=20
>=20
> > -----Original Message-----
> > From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]
> > Sent: Sunday, October 18, 2009 11:22 AM
> > To: Henry Yei
> > Cc: LTP Mailing List; Garrett Cooper
> > Subject: Re: [LTP] [LTP{PATCH][fs tests] modify tests to honor
> > tmpdirectory passed into runltp, convert to LTP format
> >
> >
> > On Fri, 2009-10-16 at 22:17 -0700, Garrett Cooper wrote:
> > > On Fri, Oct 16, 2009 at 1:31 PM, Henry Yei <hyei@mvista.com> =
wrote:
> > > > This is a set of patches for tests in the fs runtest file which
> > make use of tst_tmpdir functions or alternatively, the base tmpdir
> set
> > by the user. Some of the tests have been converted to LTP test =
format
> > as well.
> > > >
> > > > Tests that are changed:
> > > > fs_di
> > > > fs_perms
> > > > lftest
> > > > linker01
> > > > quota_remount_test01
> > > > writetest
> > >
> > > Note: linker01 is a bourne shell script now.
> >
> > And as Garret said, and apart from that, the lftest.patch fails too:
> >
> > patching file testcases/kernel/fs/lftest/lftest.c
> > patch: **** malformed patch at line 94:
> >
> > can't find file to patch at input line 3
> > Perhaps you used the wrong -p or --strip option?
> > The text leading up to this was:
> > --------------------------
> > |--- ltp-20090531/testcases/kernel/fs/linktest/linktest.pl
> > 2008-07-30 06:18:22.000000000 -0700
> > |+++ ltp-wdir/testcases/kernel/fs/linktest/linktest.pl  2009-07-27
> > 20:59:55.370039414 -0700
> > --------------------------
> > File to patch:
> >
> > Regards--
> > Subrata
> >
> > > HTH,
> > > -Garrett
> > >
> > > =
-------------------------------------------------------------------

Actual patch attached.

------_=_NextPart_001_01CA51B5.DF3C324C
Content-Type: application/octet-stream;
	name="lftest.patch"
Content-Transfer-Encoding: base64
Content-Description: lftest.patch
Content-Disposition: attachment;
	filename="lftest.patch"

LS0tIGx0cC90ZXN0Y2FzZXMva2VybmVsL2ZzL2xmdGVzdC9sZnRlc3QuYwkyMDA2LTExLTI3IDA2
OjM0OjIxLjAwMDAwMDAwMCAtMDgwMAorKysgbHRwLXdkaXIvdGVzdGNhc2VzL2tlcm5lbC9mcy9s
ZnRlc3QvbGZ0ZXN0LmMJMjAwOS0xMC0yMCAxMDo1NzoxNS42MTkzMjQ2MjcgLTA3MDAKQEAgLTM2
LDEwICszNiwyNiBAQAogI2luY2x1ZGUgPGZjbnRsLmg+CiAjaW5jbHVkZSA8dGltZS5oPgogCisj
aW5jbHVkZSAidGVzdC5oIgorCitjaGFyICpUQ0lEID0gImxmdGVzdCI7CS8qIFRlc3QgcHJvZ3Jh
bSBpZGVudGlmaWVyLiAgICAqLworaW50IFRTVF9UT1RBTCA9IDE7CisKIC8qIHNldCB3cml0ZSBi
dWZmZXIgc2l6ZSB0byB3aGF0ZXZlciBmbG9hdHMgeW91ciBib2F0LiAgSSB1c3VhbGx5IHVzZSAx
TSAqLwogI2RlZmluZSBCU0laRSAxMDQ4NTc2TAogY2hhciBidWZbQlNJWkVdOwogCit2b2lkIHNl
dHVwKHZvaWQpCit7CisJdHN0X3RtcGRpcigpOworfQorCit2b2lkIGNsZWFudXAodm9pZCkKK3sK
Kwl0c3Rfcm1kaXIoKTsKKwl0c3RfZXhpdCgpOworfQorCiBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQogewogCW9mZl90IGk7CkBAIC01NCw4ICs3MCwxMSBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKQogCQlwcmludGYoInVzYWdlOjwjIG9mICVsZCBidWZmZXJzIHRv
IHdyaXRlPlxuIiwgQlNJWkUpOwogCQlleGl0KDMpOwogCX0KKworCXNldHVwKCk7CisKIAlidWZu
dW0gPSBzdHJ0b2woYXJndlsxXSwgTlVMTCwgMCk7Ci0JcHJpbnRmKCJTdGFydGVkIGJ1aWxkaW5n
IGEgJWx1IG1lZ2FieXRlIGZpbGUgQCAlc1xuIiwgYnVmbnVtLAorCXRzdF9yZXNtKFRJTkZPLCAi
U3RhcnRlZCBidWlsZGluZyBhICVsdSBtZWdhYnl0ZSBmaWxlIEAgJXNcbiIsIGJ1Zm51bSwKIAkg
ICAgICAgYXNjdGltZShsb2NhbHRpbWUoJnRpbWUxKSkpOwogCiAJYnVmWzBdID0gJ0EnOwpAQCAt
NjMsMzIgKzgyLDM4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJCWJ1Zltp
XSA9ICcwJzsKIAlidWZbQlNJWkUgLSAxXSA9ICdaJzsKIAotCWlmICgoZmQgPSBjcmVhdCgibGFy
Z2VfZmlsZSIsIDA3NTUpKSA9PSAtMSkKLQkJcGVycm9yKCJsZnRlc3Q6ICIpOwotCisJaWYgKChm
ZCA9IGNyZWF0KCJsYXJnZV9maWxlIiwgMDc1NSkpID09IC0xKSB7CisJCXRzdF9yZXNtKFRGQUlM
LCAiY3JlYXQgZmFpbGVkIik7CisJCWNsZWFudXAoKTsKKwl9CiAJZm9yIChpID0gMDsgaSA8IGJ1
Zm51bTsgaSsrKSB7Ci0JCWlmICh3cml0ZShmZCwgYnVmLCBCU0laRSkgPT0gLTEpCi0JCQlyZXR1
cm4gLTE7CisJCWlmICh3cml0ZShmZCwgYnVmLCBCU0laRSkgPT0gLTEpIHsKKwkJCXRzdF9yZXNt
KFRGQUlMLCAid3JpdGUgZmFpbGVkIik7CisJCQljbGVhbnVwKCk7CisJCX0KIAkJZWxzZSB7Ci0J
CQlwcmludGYoIi4iKTsKKwkJCXRzdF9yZXNtKFRJTkZPLCAiLiIpOwogCQkJd3JpdGVjbnQrKzsK
IAkJCWZmbHVzaChzdGRvdXQpOwogCQl9CiAJCWZzeW5jKGZkKTsKLQkJaWYgKGxzZWVrKGZkLCAo
aSArIDEpICogQlNJWkUsIDApID09IC0xKQotCQkJcmV0dXJuIC0xOworCQlpZiAobHNlZWsoZmQs
IChpICsgMSkgKiBCU0laRSwgMCkgPT0gLTEpIHsKKwkJCXRzdF9yZXNtKFRGQUlMLCAibHNlZWsg
ZmFpbGVkIGF0IHNpemU6ICVkIiwgKGkgKyAxICogQlNJWkUpKTsKKwkJCWNsZWFudXAoKTsKKwkJ
fQogCQllbHNlCiAJCQlzZWVrY250Kys7CiAJfQogCWNsb3NlKGZkKTsKIAl0aW1lMiA9IHRpbWUo
TlVMTCk7Ci0JcHJpbnRmKCJcbkZpbmlzaGVkIGJ1aWxkaW5nIGEgJWx1IG1lZ2FieXRlIGZpbGUg
QCAlc1xuIiwgYnVmbnVtLAorCXRzdF9yZXNtKFRQQVNTLCAiXG5GaW5pc2hlZCBidWlsZGluZyBh
ICVsdSBtZWdhYnl0ZSBmaWxlIEAgJXNcbiIsIGJ1Zm51bSwKIAkgICAgICAgYXNjdGltZShsb2Nh
bHRpbWUoJnRpbWUyKSkpOwogCWRpZmYgPSB0aW1lMiAtIHRpbWUxOwotCXByaW50ZigiTnVtYmVy
IG9mIFdyaXRlczogJWRcbiIKKwl0c3RfcmVzbShUSU5GTywgIk51bWJlciBvZiBXcml0ZXM6ICVk
XG4iCiAJICAgICAgICJOdW1iZXIgb2YgU2Vla3M6ICVkXG4iCiAJICAgICAgICJUb3RhbCB0aW1l
IGZvciB0ZXN0IHRvIHJ1bjogJWQgbWludXRlKHMpIGFuZCAlZCBzZWNvbmRzXG4iLAogCSAgICAg
ICB3cml0ZWNudCwgc2Vla2NudCwgZGlmZiAvIDYwLCBkaWZmICUgNjApOwogCisJY2xlYW51cCgp
OwogCXJldHVybiAwOwogfQo=

------_=_NextPart_001_01CA51B5.DF3C324C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
------_=_NextPart_001_01CA51B5.DF3C324C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA51B5.DF3C324C--

