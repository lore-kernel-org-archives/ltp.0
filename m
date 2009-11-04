Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1N5UW2-00053p-2A
	for ltp-list@lists.sourceforge.net; Wed, 04 Nov 2009 01:18:26 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N5UVu-0006ax-SM
	for ltp-list@lists.sourceforge.net; Wed, 04 Nov 2009 01:18:25 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA5CEC.A48F4A6A"
Date: Tue, 3 Nov 2009 17:17:52 -0800
Message-ID: <8368651DACC1964480F951191B94A078016A1CD4@svexch01.mvista.com>
In-Reply-To: <1255890117.5359.17.camel@subratamodak.linux.ibm.com>
References: <8368651DACC1964480F951191B94A0780153D7BE@svexch01.mvista.com>
	<364299f40910162217w545c9108rbdac6e26fa0cf563@mail.gmail.com>
	<1255890117.5359.17.camel@subratamodak.linux.ibm.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [LTP{PATCH][fs tests] modify tests to honor tmpdirectory
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
To: subrata@linux.vnet.ibm.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA5CEC.A48F4A6A
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]
> Sent: Sunday, October 18, 2009 11:22 AM
> To: Henry Yei
> Cc: LTP Mailing List; Garrett Cooper
> Subject: Re: [LTP] [LTP{PATCH][fs tests] modify tests to honor
> tmpdirectory passed into runltp, convert to LTP format
>=20
>=20
> On Fri, 2009-10-16 at 22:17 -0700, Garrett Cooper wrote:
> > On Fri, Oct 16, 2009 at 1:31 PM, Henry Yei <hyei@mvista.com> wrote:
> > > This is a set of patches for tests in the fs runtest file which
> make use of tst_tmpdir functions or alternatively, the base tmpdir set
> by the user. Some of the tests have been converted to LTP test format
> as well.
> > >
> > > Tests that are changed:
> > > fs_di
> > > fs_perms
> > > lftest
> > > linker01
> > > quota_remount_test01
> > > writetest
> >
> > Note: linker01 is a bourne shell script now.
>=20
> And as Garret said, and apart from that, the lftest.patch fails too:
>=20
> patching file testcases/kernel/fs/lftest/lftest.c
> patch: **** malformed patch at line 94:
>=20
> can't find file to patch at input line 3
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |--- ltp-20090531/testcases/kernel/fs/linktest/linktest.pl
> 2008-07-30 06:18:22.000000000 -0700
> |+++ ltp-wdir/testcases/kernel/fs/linktest/linktest.pl  2009-07-27
> 20:59:55.370039414 -0700
> --------------------------
> File to patch:
>=20
> Regards--
> Subrata
>=20
> > HTH,
> > -Garrett
> >
> > =
---------------------------------------------------------------------
> ---------
> > Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> > is the only developer event you need to attend this year. Jumpstart
> your
> > developing skills, take BlackBerry mobile applications to market and
> stay
> > ahead of the curve. Join us from November 9 - 12, 2009. Register =
now!
> > http://p.sf.net/sfu/devconference
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list


Convert test to LTP format, make use of tst_* functions for =
cleanup/setup/tmp directory

Signed-off by: Henry Yei <hyei@mvista.com>




------_=_NextPart_001_01CA5CEC.A48F4A6A
Content-Type: application/octet-stream;
	name="lftest.patch"
Content-Transfer-Encoding: base64
Content-Description: lftest.patch
Content-Disposition: attachment;
	filename="lftest.patch"

LS0tIGx0cC0yMDA5MDUzMS90ZXN0Y2FzZXMva2VybmVsL2ZzL2xmdGVzdC9sZnRlc3QuYwkyMDA5
LTA3LTI3IDE2OjU2OjE0LjMwOTAwMDAwMCAtMDcwMAorKysgbHRwLXdkaXIvdGVzdGNhc2VzL2tl
cm5lbC9mcy9sZnRlc3QvbGZ0ZXN0LmMJMjAwOS0xMS0wMyAxNjo1MzoyOS41OTcxODU5NTggLTA4
MDAKQEAgLTM2LDEwICszNiwyNiBAQAogI2luY2x1ZGUgPGZjbnRsLmg+CiAjaW5jbHVkZSA8dGlt
ZS5oPgogCisjaW5jbHVkZSAidGVzdC5oIgorCitjaGFyICpUQ0lEID0gImxmdGVzdCI7CS8qIFRl
c3QgcHJvZ3JhbSBpZGVudGlmaWVyLiAgICAqLworaW50IFRTVF9UT1RBTCA9IDE7CisKIC8qIHNl
dCB3cml0ZSBidWZmZXIgc2l6ZSB0byB3aGF0ZXZlciBmbG9hdHMgeW91ciBib2F0LiAgSSB1c3Vh
bGx5IHVzZSAxTSAqLwogI2RlZmluZSBCU0laRSAxMDQ4NTc2TAogY2hhciBidWZbQlNJWkVdOwog
Cit2b2lkIHNldHVwKHZvaWQpCit7CisJdHN0X3RtcGRpcigpOworfQorCit2b2lkIGNsZWFudXAo
dm9pZCkKK3sKKwl0c3Rfcm1kaXIoKTsKKwl0c3RfZXhpdCgpOworfQorCiBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKQogewogCW9mZl90IGk7CkBAIC01NCw4ICs3MCwxMSBAQCBpbnQg
bWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQlwcmludGYoInVzYWdlOjwjIG9mICVsZCBi
dWZmZXJzIHRvIHdyaXRlPlxuIiwgQlNJWkUpOwogCQlleGl0KDMpOwogCX0KKworCXNldHVwKCk7
CisKIAlidWZudW0gPSBzdHJ0b2woYXJndlsxXSwgTlVMTCwgMCk7Ci0JcHJpbnRmKCJTdGFydGVk
IGJ1aWxkaW5nIGEgJWx1IG1lZ2FieXRlIGZpbGUgQCAlc1xuIiwgYnVmbnVtLAorCXRzdF9yZXNt
KFRJTkZPLCAiU3RhcnRlZCBidWlsZGluZyBhICVsdSBtZWdhYnl0ZSBmaWxlIEAgJXNcbiIsIGJ1
Zm51bSwKIAkgICAgICAgYXNjdGltZShsb2NhbHRpbWUoJnRpbWUxKSkpOwogCiAJYnVmWzBdID0g
J0EnOwpAQCAtNjMsMzIgKzgyLDM4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10p
CiAJCWJ1ZltpXSA9ICcwJzsKIAlidWZbQlNJWkUgLSAxXSA9ICdaJzsKIAotCWlmICgoZmQgPSBj
cmVhdCgibGFyZ2VfZmlsZSIsIDA3NTUpKSA9PSAtMSkKLQkJcGVycm9yKCJsZnRlc3Q6ICIpOwot
CisJaWYgKChmZCA9IGNyZWF0KCJsYXJnZV9maWxlIiwgMDc1NSkpID09IC0xKSB7CisJCXRzdF9y
ZXNtKFRGQUlMLCAiY3JlYXQgZmFpbGVkIik7CisJCWNsZWFudXAoKTsKKwl9CiAJZm9yIChpID0g
MDsgaSA8IGJ1Zm51bTsgaSsrKSB7Ci0JCWlmICh3cml0ZShmZCwgYnVmLCBCU0laRSkgPT0gLTEp
Ci0JCQlyZXR1cm4gLTE7CisJCWlmICh3cml0ZShmZCwgYnVmLCBCU0laRSkgPT0gLTEpIHsKKwkJ
CXRzdF9yZXNtKFRGQUlMLCAid3JpdGUgZmFpbGVkIik7CisJCQljbGVhbnVwKCk7CisJCX0KIAkJ
ZWxzZSB7Ci0JCQlwcmludGYoIi4iKTsKKwkJCXRzdF9yZXNtKFRJTkZPLCAiLiIpOwogCQkJd3Jp
dGVjbnQrKzsKIAkJCWZmbHVzaChzdGRvdXQpOwogCQl9CiAJCWZzeW5jKGZkKTsKLQkJaWYgKGxz
ZWVrKGZkLCAoaSArIDEpICogQlNJWkUsIDApID09IC0xKQotCQkJcmV0dXJuIC0xOworCQlpZiAo
bHNlZWsoZmQsIChpICsgMSkgKiBCU0laRSwgMCkgPT0gLTEpIHsKKwkJCXRzdF9yZXNtKFRGQUlM
LCAibHNlZWsgZmFpbGVkIGF0IHNpemU6ICVkIiwgKGkgKyAxICogQlNJWkUpKTsKKwkJCWNsZWFu
dXAoKTsKKwkJfQogCQllbHNlCiAJCQlzZWVrY250Kys7CiAJfQogCWNsb3NlKGZkKTsKIAl0aW1l
MiA9IHRpbWUoTlVMTCk7Ci0JcHJpbnRmKCJcbkZpbmlzaGVkIGJ1aWxkaW5nIGEgJWx1IG1lZ2Fi
eXRlIGZpbGUgQCAlc1xuIiwgYnVmbnVtLAorCXRzdF9yZXNtKFRQQVNTLCAiXG5GaW5pc2hlZCBi
dWlsZGluZyBhICVsdSBtZWdhYnl0ZSBmaWxlIEAgJXNcbiIsIGJ1Zm51bSwKIAkgICAgICAgYXNj
dGltZShsb2NhbHRpbWUoJnRpbWUyKSkpOwogCWRpZmYgPSB0aW1lMiAtIHRpbWUxOwotCXByaW50
ZigiTnVtYmVyIG9mIFdyaXRlczogJWRcbiIKKwl0c3RfcmVzbShUSU5GTywgIk51bWJlciBvZiBX
cml0ZXM6ICVkXG4iCiAJICAgICAgICJOdW1iZXIgb2YgU2Vla3M6ICVkXG4iCiAJICAgICAgICJU
b3RhbCB0aW1lIGZvciB0ZXN0IHRvIHJ1bjogJWQgbWludXRlKHMpIGFuZCAlZCBzZWNvbmRzXG4i
LAogCSAgICAgICB3cml0ZWNudCwgc2Vla2NudCwgZGlmZiAvIDYwLCBkaWZmICUgNjApOwogCisJ
Y2xlYW51cCgpOwogCXJldHVybiAwOwogfQo=

------_=_NextPart_001_01CA5CEC.A48F4A6A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
------_=_NextPart_001_01CA5CEC.A48F4A6A
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA5CEC.A48F4A6A--

