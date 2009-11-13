Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1N8lPr-0006GW-Hc
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 01:57:35 +0000
Received: from [206.112.117.47] (helo=gateway-1237.mvista.com)
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1N8lPk-0003jQ-Tv
	for ltp-list@lists.sourceforge.net; Fri, 13 Nov 2009 01:57:35 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA6404.A1F78F9D"
Date: Thu, 12 Nov 2009 17:57:18 -0800
Message-ID: <8368651DACC1964480F951191B94A078017CB58B@svexch01.mvista.com>
In-Reply-To: <364299f40911120142y1c598494ha4172200704d2e48@mail.gmail.com>
References: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
	<8368651DACC1964480F951191B94A078016A1648@svexch01.mvista.com>
	<1257170357.4977.57.camel@subratamodak.linux.ibm.com>
	<8368651DACC1964480F951191B94A078016A1ACE@svexch01.mvista.com>
	<1257788375.7677.72.camel@subratamodak.linux.ibm.com>
	<8368651DACC1964480F951191B94A078017CB194@svexch01.mvista.com>
	<364299f40911092316q223d2073oc610dffc7474722b@mail.gmail.com>
	<8368651DACC1964480F951191B94A078017CB30A@svexch01.mvista.com>
	<364299f40911102212l2964e871r7477ae7959b566f6@mail.gmail.com>
	<8368651DACC1964480F951191B94A078017CB3C2@svexch01.mvista.com>
	<364299f40911120142y1c598494ha4172200704d2e48@mail.gmail.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1,
	5: pass correct valuefor sigset_t for mips
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA6404.A1F78F9D
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Thursday, November 12, 2009 1:43 AM
> To: Henry Yei
> Cc: subrata@linux.vnet.ibm.com; LTP Mailing List
> Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass correct
> valuefor sigset_t for mips
>=20
> >> -----Original Message-----
> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> Sent: Tuesday, November 10, 2009 10:13 PM
> >> To: Henry Yei
> >> Cc: subrata@linux.vnet.ibm.com; LTP Mailing List
> >> Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass correct
> >> valuefor sigset_t for mips
> >>
> >> On Tue, Nov 10, 2009 at 5:14 PM, Henry Yei <hyei@mvista.com> wrote:
> >> >> -----Original Message-----
> >> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> >> Sent: Monday, November 09, 2009 11:17 PM
> >> >> To: Henry Yei
> >> >> Cc: subrata@linux.vnet.ibm.com; LTP Mailing List
> >> >> Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass
> correct
> >> >> valuefor sigset_t for mips
> >> >>
> >> >> On Mon, Nov 9, 2009 at 2:12 PM, Henry Yei <hyei@mvista.com>
> wrote:
> >> >> >> -----Original Message-----
> >> >> >> From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]
> >> >> >> Sent: Monday, November 09, 2009 9:40 AM
> >> >> >> To: Henry Yei
> >> >> >> Cc: Garrett Cooper; LTP Mailing List
> >> >> >> Subject: RE: [LTP] [PATCH][ppoll01] fix testcase 1, 5: pass
> >> correct
> >> >> >> valuefor sigset_t for mips
> >> >> >>
> >> >> >> On Mon, 2009-11-02 at 14:09 -0800, Henry Yei wrote:
> >> >> >> > Subrata,
> >> >> >> >
> >> >> >> > I've included Nicolas Joly's suggested removal of progdir =
to
> >> force
> >> >> >> the test to create all test files in the temp directory in =
the
> >> >> attached
> >> >> >> patch.
> >> >> >> >
> >> >> >> > I'm not sure why tst_exit() is needed when calling
> cleanup(),
> >> as
> >> >> it
> >> >> >> would be called by cleanup(). I can add it back, if needed.
> Any
> >> >> other
> >> >> >> comments on the the appropriateness of "sizeof(sigmask)" =
would
> >> also
> >> >> be
> >> >> >> welcomed. There are a few other tests with similar issues.
> >> >> >> >
> >> >> >>
> >> >> >> Henry,
> >> >> >>
> >> >> >> Probably because of heavy changes recently, this patch is not
> >> >> applying
> >> >> >> properly. Can you please rebase your changes:
> >> >> >>
> >> >> >> patching file testcases/kernel/syscalls/ppoll/ppoll01.c
> >> >> >> Hunk #3 FAILED at 98.
> >> >> >> Hunk #4 FAILED at 127.
> >> >> >> Hunk #5 FAILED at 185.
> >> >> >> Hunk #6 FAILED at 252.
> >> >> >> 4 out of 6 hunks FAILED -- saving rejects to file
> >> >> >> testcases/kernel/syscalls/ppoll/ppoll01.c.rej
> >> >> >>
> >> >> >> Regards--
> >> >> >> Subrata
> >> >> >>
> >> >> >> > > -----Original Message-----
> >> >> >> > > From: Subrata Modak [mailto:subrata@linux.vnet.ibm.com]
> >> >> >> > > Sent: Monday, November 02, 2009 5:59 AM
> >> >> >> > > To: Henry Yei
> >> >> >> > > Cc: Garrett Cooper; LTP Mailing List
> >> >> >> > > Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, 5:
> pass
> >> >> correct
> >> >> >> > > valuefor sigset_t for mips
> >> >> >> > >
> >> >> >> > > Any further work on this patch ?
> >> >> >> > >
> >> >> >> > > Regards--
> >> >> >> > > Subrata
> >> >> >> > >
> >> >> >> > > On Wed, 2009-10-28 at 12:08 -0700, Henry Yei wrote:
> >> >> >> > > > > -----Original Message-----
> >> >> >> > > > > From: Garrett Cooper [mailto:yanegomi@gmail.com]
> >> >> >> > > > > Sent: Tuesday, October 27, 2009 7:57 PM
> >> >> >> > > > > To: Henry Yei
> >> >> >> > > > > Cc: LTP Mailing List
> >> >> >> > > > > Subject: Re: [LTP] [PATCH][ppoll01] fix testcase 1, =
5:
> >> pass
> >> >> >> correct
> >> >> >> > > > > value for sigset_t for mips
> >> >> >> > > > >
> >> >> >> > > > > On Tue, Oct 27, 2009 at 6:32 PM, Henry Yei
> >> <hyei@mvista.com>
> >> >> >> wrote:
> >> >> >> > > > > > All,
> >> >> >> > > > > >
> >> >> >> > > > > >
> >> >> >> > > > > >
> >> >> >> > > > > > The patch attached =A0for ppoll01:
> >> >> >> > > > > >
> >> >> >> > > > > > cleans up spacing and code style
> >> >> >> > > > > >
> >> >> >> > > > > > removes unneeded/broken debug option parsing
> >> >> >> > > > > >
> >> >> >> > > > > > if test fails, it prints out the last failed errno,
> >> rather
> >> >> >> than
> >> >> >> > > just
> >> >> >> > > > > the
> >> >> >> > > > > > last errno(which may have been successful)
> >> >> >> > > > > >
> >> >> >> > > > > > passes in correct size of sigset_t for mips
> >> >> >> > > > > >
> >> >> >> > > > > >
> >> >> >> > > > > >
> >> >> >> > > > > > Signed-off by: Henry Yei <hyei@mvista.com>
> >> >> >> > > > > >
> >> >> >> > > > > >
> >> >> >> > > > > >
> >> >> >> > > > > > This patch was tested/passed on x86, mips(little
> >> endian),
> >> >> and
> >> >> >> > > > > ppc_82xx .
> >> >> >> > > > >
> >> >> >> > > > > 1. Please keep tst_exit() at the bottom.
> >> >> >> > > > > 2. Why can't we do sizeof(sigsetmask) ?
> >> >> >> > > > >
> >> >> >> > > > > Thanks,
> >> >> >> > > > > -Garrett
> >> >> >> > > >
> >> >> >> > > > Garrett,
> >> >> >> > > >
> >> >> >> > > > You want me to put tst_exit() at the bottom, even =
though
> it
> >> is
> >> >> >> called
> >> >> >> > > within cleanup()?
> >> >> >> > > > You mean sizeof(sigmask) ~ sizeof(sigset_t), right? =
That
> >> code
> >> >> was
> >> >> >> > > commented out since version 1.1 which I thought was odd
> too,
> >> so
> >> >> I
> >> >> >> did
> >> >> >> > > check sizeof(sigmask).
> >> >> >> > > > However, sizeof(sigmask) on mips returns 128 which does
> not
> >> >> seem
> >> >> >> > > correct. I haven't checked the other architectures, but I
> >> >> suspect
> >> >> >> some
> >> >> >> > > might have a similar mismatch. Apparently sigset_t may
> have
> >> >> >> different
> >> >> >> > > values when returned from glibc vs kernel space. More
> >> >> information
> >> >> >> from
> >> >> >> > > this post:
> >> >> >> > > >
> >> >> >> > > > http://lists.uclibc.org/pipermail/uclibc/2009-
> >> >> January/041850.html
> >> >> >
> >> >> >
> >> >> > Subrata,
> >> >> >
> >> >> > I've included the ppoll01 patch which should apply cleanly to
> the
> >> >> latest in CVS.
> >> >> >
> >> >>
> >> >> Hi Henry,
> >> >> =A0 =A0 Could you change this line:
> >> >>
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
tst_resm(TFAIL, "%s failed - errno
> =3D
> >> %d : %s",
> >> >> TCID,
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 last_failed_errno,
> >> >> strerror(last_failed_errno));
> >> >>
> >> >> =A0 =A0 to this please?
> >> >>
> >> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
tst_resm(TFAIL | TTERRNO, "%s
> failed",
> >> TCID);
> >> >>
> >> >> =A0 =A0 last_failed_errno should become TEST_ERRNO if this =
change is
> >> done,
> >> >> IIRC.
> >> >>
> >> >
> >> > I've attached the ppoll01 patch with Garrett's suggested changes
> to
> >> use TEST_ERRNO.
> >>
> >> You could just completely zap last_failed_errno and make it
> test_errno
> >> instead. That's what I was suggesting with the previous reply.
>=20
> On Wed, Nov 11, 2009 at 11:25 AM, Henry Yei <hyei@mvista.com> wrote:
> > Wouldn't TEST_ERRNO be the errno of the last TEST() that was run,
> rather than the last failed one?
> >
> >
> >
>     Yup! The goal is to drop the additional variable
> (last_failed_errno) so that only TEST_ERRNO is required and then all
> you need to do is use TTERRNO and you're golden :).
> Thanks,
> -Garrett

Attached is the poll01 patch with last_failed_errno and associated code =
removed.


------_=_NextPart_001_01CA6404.A1F78F9D
Content-Type: application/octet-stream;
	name="ppoll01.patch"
Content-Transfer-Encoding: base64
Content-Description: ppoll01.patch
Content-Disposition: attachment;
	filename="ppoll01.patch"

LS0tIGx0cC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Bwb2xsL3Bwb2xsMDEuYwkyMDA5LTEw
LTE0IDEzOjIyOjQyLjAwMDAwMDAwMCAtMDcwMAorKysgbHRwLXdkaXIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9wcG9sbC9wcG9sbDAxLmMJMjAwOS0xMS0xMiAxNTozODoxNi41MTYzODk1NzMg
LTA4MDAKQEAgLTYxLDcgKzYxLDYgQEAKICNpbmNsdWRlIDxzaWduYWwuaD4KICNpbmNsdWRlICJh
c20vcG9sbC5oIgogCi0KICNpbmNsdWRlICIuLi91dGlscy9pbmNsdWRlX2pfaC5oIgogI2luY2x1
ZGUgIi4uL3V0aWxzL2NvbW1vbl9qX2guYyIKIApAQCAtNzEsMTMgKzcwLDEzIEBACiAjaW5jbHVk
ZSAibGludXhfc3lzY2FsbF9udW1iZXJzLmgiCiAKIC8qIEV4dGVybiBHbG9iYWwgVmFyaWFibGVz
ICovCi1leHRlcm4gaW50IFRzdF9jb3VudDsgICAgICAgICAgIC8qIGNvdW50ZXIgZm9yIHRzdF94
eHggcm91dGluZXMuICAgICAgICAgKi8KLWV4dGVybiBjaGFyICpURVNURElSOyAgICAgICAgICAg
LyogdGVtcG9yYXJ5IGRpciBjcmVhdGVkIGJ5IHRzdF90bXBkaXIoKSAqLworZXh0ZXJuIGludCBU
c3RfY291bnQ7IC8qIGNvdW50ZXIgZm9yIHRzdF94eHggcm91dGluZXMuICAgICAgICAgKi8KK2V4
dGVybiBjaGFyICpURVNURElSOyAvKiB0ZW1wb3JhcnkgZGlyIGNyZWF0ZWQgYnkgdHN0X3RtcGRp
cigpICovCiAKIC8qIEdsb2JhbCBWYXJpYWJsZXMgKi8KLWNoYXIgKlRDSUQgPSAicHBvbGwwMSI7
ICAvKiBUZXN0IHByb2dyYW0gaWRlbnRpZmllci4qLwotaW50ICB0ZXN0bm87Ci1pbnQgIFRTVF9U
T1RBTCA9IDE7ICAgICAgICAgICAgICAgICAgIC8qIHRvdGFsIG51bWJlciBvZiB0ZXN0cyBpbiB0
aGlzIGZpbGUuICAgKi8KK2NoYXIgKlRDSUQgPSAicHBvbGwwMSI7IC8qIFRlc3QgcHJvZ3JhbSBp
ZGVudGlmaWVyLiovCitpbnQgdGVzdG5vOworaW50IFRTVF9UT1RBTCA9IDE7IC8qIHRvdGFsIG51
bWJlciBvZiB0ZXN0cyBpbiB0aGlzIGZpbGUuICAgKi8KIAogLyogRXh0ZXJuIEdsb2JhbCBGdW5j
dGlvbnMgKi8KIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCkBAIC05OCwxNSArOTcsMTUgQEAgaW50
ICBUU1RfVE9UQUwgPSAxOyAgICAgICAgICAgICAgICAgICAvKgogLyogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgKi8KIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCiBleHRlcm4gdm9pZCBjbGVhbnVwKCkgewot
ICAgICAgICAvKiBSZW1vdmUgdG1wIGRpciBhbmQgYWxsIGZpbGVzIGluIGl0ICovCi0gICAgICAg
IFRFU1RfQ0xFQU5VUDsKLSAgICAgICAgdHN0X3JtZGlyKCk7CisJLyogUmVtb3ZlIHRtcCBkaXIg
YW5kIGFsbCBmaWxlcyBpbiBpdCAqLworCVRFU1RfQ0xFQU5VUDsKKwl0c3Rfcm1kaXIoKTsKIAot
ICAgICAgICAvKiBFeGl0IHdpdGggYXBwcm9wcmlhdGUgcmV0dXJuIGNvZGUuICovCi0gICAgICAg
IHRzdF9leGl0KCk7CisJLyogRXhpdCB3aXRoIGFwcHJvcHJpYXRlIHJldHVybiBjb2RlLiAqLwor
CXRzdF9leGl0KCk7CiB9CiAKLXZvaWQgc2lnaGFuZGxlcihpbnQgc2lnKTsgICAgICAgLyogc2ln
bmFscyBoYW5kbGVyIGZ1bmN0aW9uIGZvciB0aGUgdGVzdCAqLwordm9pZCBzaWdoYW5kbGVyKGlu
dCBzaWcpOyAvKiBzaWduYWxzIGhhbmRsZXIgZnVuY3Rpb24gZm9yIHRoZSB0ZXN0ICovCiAKIC8q
IExvY2FsICBGdW5jdGlvbnMgKi8KIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovCkBAIC0xMjcsNTgg
KzEyNiw1NyBAQCB2b2lkIHNpZ2hhbmRsZXIoaW50IHNpZyk7ICAgICAgIC8qIHNpZ25hCiAvKiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAqLwogLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIHZvaWQgc2V0dXAo
KSB7Ci0gICAgICAgIC8qIENhcHR1cmUgc2lnbmFscyBpZiBhbnkgKi8KKwkvKiBDYXB0dXJlIHNp
Z25hbHMgaWYgYW55ICovCiAJc2lnbmFsKFNJR0lOVCwgJnNpZ2hhbmRsZXIpOwogCi0gICAgICAg
IC8qIENyZWF0ZSB0ZW1wb3JhcnkgZGlyZWN0b3JpZXMgKi8KLSAgICAgICAgVEVTVF9QQVVTRTsK
LSAgICAgICAgdHN0X3RtcGRpcigpOworCS8qIENyZWF0ZSB0ZW1wb3JhcnkgZGlyZWN0b3JpZXMg
Ki8KKwlURVNUX1BBVVNFOworCXRzdF90bXBkaXIoKTsKIH0KIAotCiAvKgogICogTWFjcm9zCiAg
Ki8KICNkZWZpbmUgU1lTQ0FMTF9OQU1FICAgICJwcG9sbCIKIAogI2lmbmRlZiBQT0xMUkRIVVAK
LSMgIGRlZmluZSBQT0xMUkRIVVAgICAgIDB4MjAwMAorI2RlZmluZSBQT0xMUkRIVVAgICAgIDB4
MjAwMAogI2VuZGlmCiAKKyNpZiBkZWZpbmVkIChfX21pcHNfXykKKyNkZWZpbmUgU0lHU0VUU0la
RSAxNgorI2Vsc2UKKyNkZWZpbmUgU0lHU0VUU0laRSA4CisjZW5kaWYKIAogLyoKICAqIEdsb2Jh
bCB2YXJpYWJsZXMKICAqLwotc3RhdGljIGludCBvcHRfZGVidWc7Ci1zdGF0aWMgY2hhciAqcHJv
Z25hbWU7Ci1zdGF0aWMgY2hhciAqcHJvZ2RpcjsKIAogZW51bSB0ZXN0X3R5cGUgewogCU5PUk1B
TCwKLSAgICAgICAgTUFTS19TSUdOQUwsCi0gICAgICAgIFRJTUVPVVQsCi0gICAgICAgIEZEX0FM
UkVBRFlfQ0xPU0VELAotICAgICAgICBTRU5EX1NJR0lOVCwKLSAgICAgICAgU0VORF9TSUdJTlRf
UkFDRV9URVNULAotICAgICAgICBJTlZBTElEX05GRFMsCi0gICAgICAgIElOVkFMSURfRkRTLAot
ICAgICAgICBNSU5VU19OU0VDLAotICAgICAgICBUT09fTEFSR0VfTlNFQywKKwlNQVNLX1NJR05B
TCwKKwlUSU1FT1VULAorCUZEX0FMUkVBRFlfQ0xPU0VELAorCVNFTkRfU0lHSU5ULAorCVNFTkRf
U0lHSU5UX1JBQ0VfVEVTVCwKKwlJTlZBTElEX05GRFMsCisJSU5WQUxJRF9GRFMsCisJTUlOVVNf
TlNFQywKKwlUT09fTEFSR0VfTlNFQywKIAogfTsKIAotCiAvKgogICogRGF0YSBTdHJ1Y3R1cmUK
ICAqLwogc3RydWN0IHRlc3RfY2FzZSB7CiAJc2hvcnQgZXhwZWN0X3JldmVudHM7Ci0gICAgICAg
IGludCB0dHlwZTsKLSAgICAgICAgaW50IHJldDsKLSAgICAgICAgaW50IGVycjsKKwlpbnQgdHR5
cGU7CisJaW50IHJldDsKKwlpbnQgZXJyOwogfTsKIAotCiAvKiBUZXN0IGNhc2VzCiAgKgogICog
ICB0ZXN0IHN0YXR1cyBvZiBlcnJvcnMgb24gbWFuIHBhZ2UKQEAgLTE5Miw2NSArMTkwLDYyIEBA
IHN0cnVjdCB0ZXN0X2Nhc2UgewogICogICBFTk9NRU0gICAgICAgICAgICAgY2FuJ3QgY2hlY2sg
YmVjYXVzZSBpdCdzIGRpZmZpY3VsdCB0byBjcmVhdGUgbm8tbWVtb3J5CiAgKi8KIAotCiBzdGF0
aWMgc3RydWN0IHRlc3RfY2FzZSB0Y2FzZVtdID0gewotCXsgLy8gY2FzZTAwCi0gICAgICAgICAg
ICAgICAgLnR0eXBlICAgICAgICAgID0gTk9STUFMLAotICAgICAgICAgICAgICAgIC5leHBlY3Rf
cmV2ZW50cyA9IFBPTExJTiB8IFBPTExPVVQsCi0gICAgICAgICAgICAgICAgLnJldCAgICAgICAg
ICAgID0gMCwKLSAgICAgICAgICAgICAgICAuZXJyICAgICAgICAgICAgPSAwLAotICAgICAgICB9
LAotICAgICAgICB7IC8vIGNhc2UwMQotICAgICAgICAgICAgICAgIC50dHlwZSAgICAgICAgICA9
IE1BU0tfU0lHTkFMLAotICAgICAgICAgICAgICAgIC5leHBlY3RfcmV2ZW50cyA9IDAsIC8vIGRv
bid0IGNhcmUKLSAgICAgICAgICAgICAgICAucmV0ICAgICAgICAgICAgPSAwLAotICAgICAgICAg
ICAgICAgIC5lcnIgICAgICAgICAgICA9IDAsCi0gICAgICAgIH0sCi0gICAgICAgIHsgLy8gY2Fz
ZTAyCi0gICAgICAgICAgICAgICAgLnR0eXBlICAgICAgICAgID0gVElNRU9VVCwKLSAgICAgICAg
ICAgICAgICAuZXhwZWN0X3JldmVudHMgPSAwLCAvLyBkb24ndCBjYXJlCi0gICAgICAgICAgICAg
ICAgLnJldCAgICAgICAgICAgID0gMCwKLSAgICAgICAgICAgICAgICAuZXJyICAgICAgICAgICAg
PSAwLAotICAgICAgICB9LAotICAgICAgICB7IC8vIGNhc2UwMwotICAgICAgICAgICAgICAgIC50
dHlwZSAgICAgICAgICA9IEZEX0FMUkVBRFlfQ0xPU0VELAotICAgICAgICAgICAgICAgIC5leHBl
Y3RfcmV2ZW50cyA9IFBPTExOVkFMLAotICAgICAgICAgICAgICAgIC5yZXQgICAgICAgICAgICA9
IDAsCi0gICAgICAgICAgICAgICAgLmVyciAgICAgICAgICAgID0gMCwKLSAgICAgICAgfSwKLSAg
ICAgICAgeyAvLyBjYXNlMDQKLSAgICAgICAgICAgICAgICAudHR5cGUgICAgICAgICAgPSBTRU5E
X1NJR0lOVCwKLSAgICAgICAgICAgICAgICAucmV0ICAgICAgICAgICAgPSAtMSwKLSAgICAgICAg
ICAgICAgICAuZXJyICAgICAgICAgICAgPSBFSU5UUiwKLSAgICAgICAgfSwKLSAgICAgICAgeyAv
LyBjYXNlMDUKLSAgICAgICAgICAgICAgICAudHR5cGUgICAgICAgICAgPSBTRU5EX1NJR0lOVF9S
QUNFX1RFU1QsCi0gICAgICAgICAgICAgICAgLnJldCAgICAgICAgICAgID0gLTEsCi0gICAgICAg
ICAgICAgICAgLmVyciAgICAgICAgICAgID0gRUlOVFIsCi0gICAgICAgIH0sCi0gICAgICAgIHsg
Ly8gY2FzZTA2Ci0gICAgICAgICAgICAgICAgLnR0eXBlICAgICAgICAgID0gSU5WQUxJRF9ORkRT
LAotICAgICAgICAgICAgICAgIC5yZXQgICAgICAgICAgICA9IC0xLAotICAgICAgICAgICAgICAg
IC5lcnIgICAgICAgICAgICA9IEVJTlZBTCwKLSAgICAgICAgfSwKLSAgICAgICAgeyAvLyBjYXNl
MDcKLSAgICAgICAgICAgICAgICAudHR5cGUgICAgICAgICAgPSBJTlZBTElEX0ZEUywKLSAgICAg
ICAgICAgICAgICAucmV0ICAgICAgICAgICAgPSAtMSwKLSAgICAgICAgICAgICAgICAuZXJyICAg
ICAgICAgICAgPSBFRkFVTFQsCi0gICAgICAgIH0sCisJCXsgLy8gY2FzZTAwCisJCQkudHR5cGUg
PSBOT1JNQUwsCisJCQkuZXhwZWN0X3JldmVudHMgPSBQT0xMSU4gfCBQT0xMT1VULAorCQkJLnJl
dCA9IDAsCisJCQkuZXJyID0gMCwKKwkJfSwKKwkJeyAvLyBjYXNlMDEKKwkJCS50dHlwZSA9IE1B
U0tfU0lHTkFMLAorCQkJLmV4cGVjdF9yZXZlbnRzID0gMCwgLy8gZG9uJ3QgY2FyZQorCQkJLnJl
dCA9IDAsCisJCQkuZXJyID0gMCwKKwkJfSwKKwkJeyAvLyBjYXNlMDIKKwkJCS50dHlwZSA9IFRJ
TUVPVVQsCisJCQkuZXhwZWN0X3JldmVudHMgPSAwLCAvLyBkb24ndCBjYXJlCisJCQkucmV0ID0g
MCwKKwkJCS5lcnIgPSAwLAorCQl9LAorCQl7IC8vIGNhc2UwMworCQkJLnR0eXBlID0gRkRfQUxS
RUFEWV9DTE9TRUQsCisJCQkuZXhwZWN0X3JldmVudHMgPSBQT0xMTlZBTCwKKwkJCS5yZXQgPSAw
LCAuZXJyID0gMCwKKwkJfSwKKwkJeyAvLyBjYXNlMDQKKwkJCS50dHlwZSA9IFNFTkRfU0lHSU5U
LAorCQkJLnJldCA9IC0xLAorCQkJLmVyciA9IEVJTlRSLAorCQl9LAorCQl7IC8vIGNhc2UwNQor
CQkJLnR0eXBlID0gU0VORF9TSUdJTlRfUkFDRV9URVNULAorCQkJLnJldCA9IC0xLAorCQkJLmVy
ciA9IEVJTlRSLAorCQl9LAorCQl7IC8vIGNhc2UwNgorCQkJLnR0eXBlID0gSU5WQUxJRF9ORkRT
LAorCQkJLnJldCA9IC0xLAorCQkJLmVyciA9IEVJTlZBTCwKKwkJfSwKKwkJeyAvLyBjYXNlMDcK
KwkJCS50dHlwZSA9IElOVkFMSURfRkRTLAorCQkJLnJldCA9IC0xLAorCQkJLmVyciA9IEVGQVVM
VCwgfSwKICNpZiAwCi0gICAgICAgIHsgLy8gY2FzZTA4Ci0gICAgICAgICAgICAgICAgLnR0eXBl
ICAgICAgICAgID0gTUlOVVNfTlNFQywKLSAgICAgICAgICAgICAgICAucmV0ICAgICAgICAgICAg
PSAtMSwKLSAgICAgICAgICAgICAgICAuZXJyICAgICAgICAgICAgPSBFSU5WQUwsIC8vIFJIRUw0
VTEgKyAyLjYuMTggcmV0dXJucyBTVUNDRVNTCi0gICAgICAgIH0sCi0gICAgICAgIHsgLy8gY2Fz
ZTA5Ci0gICAgICAgICAgICAgICAgLnR0eXBlICAgICAgICAgID0gVE9PX0xBUkdFX05TRUMsCi0g
ICAgICAgICAgICAgICAgLnJldCAgICAgICAgICAgID0gLTEsCi0gICAgICAgICAgICAgICAgLmVy
ciAgICAgICAgICAgID0gRUlOVkFMLCAvLyBSSEVMNFUxICsgMi42LjE4IHJldHVybnMgU1VDQ0VT
UwotICAgICAgICB9LAorCQl7IC8vIGNhc2UwOAorCQkJLnR0eXBlID0gTUlOVVNfTlNFQywKKwkJ
CS5yZXQgPSAtMSwKKwkJCS5lcnIgPSBFSU5WQUwsIC8vIFJIRUw0VTEgKyAyLjYuMTggcmV0dXJu
cyBTVUNDRVNTCisJCX0sCisJCXsgLy8gY2FzZTA5CisJCQkudHR5cGUgPSBUT09fTEFSR0VfTlNF
QywKKwkJCS5yZXQgPSAtMSwKKwkJCS5lcnIgPSBFSU5WQUwsIC8vIFJIRUw0VTEgKyAyLjYuMTgg
cmV0dXJucyBTVUNDRVNTCisJCX0sCiAjZW5kaWYKLX07CisJCX07CiAKICNkZWZpbmUgTlVNX1RF
U1RfRkRTICAgIDEKIApAQCAtMjYyLDI2NiArMjU3LDIwMyBAQCBzdGF0aWMgc3RydWN0IHRlc3Rf
Y2FzZSB0Y2FzZVtdID0gewogICoKICAqLwogCi1zdGF0aWMgaW50IGRvX3Rlc3Qoc3RydWN0IHRl
c3RfY2FzZSAqdGMpCi17Ci0gICAgICAgIGludCBzeXNfcmV0OwotICAgICAgICBpbnQgc3lzX2Vy
cm5vOwotICAgICAgICBpbnQgcmVzdWx0ID0gUkVTVUxUX09LOwotCWludCBmZCA9IC0xICwgY21w
X29rID0gMTsKK3N0YXRpYyBpbnQgZG9fdGVzdChzdHJ1Y3QgdGVzdF9jYXNlICp0YykgeworCWlu
dCBzeXNfcmV0LCBzeXNfZXJybm87CisJaW50IHJlc3VsdCA9IFJFU1VMVF9PSzsKKwlpbnQgZmQg
PSAtMSwgY21wX29rID0gMTsKIAljaGFyIGZwYXRoW1BBVEhfTUFYXTsKIAlzdHJ1Y3QgcG9sbGZk
ICpwX2ZkcywgZmRzW05VTV9URVNUX0ZEU107Ci0gICAgICAgIHVuc2lnbmVkIGludCBuZmRzID0g
TlVNX1RFU1RfRkRTOwotICAgICAgICBzdHJ1Y3QgdGltZXNwZWMgKnBfdHMsIHRzOwotICAgICAg
ICBzaWdzZXRfdCAqcF9zaWdtYXNrLCBzaWdtYXNrOwotICAgICAgICBzaXplX3Qgc2lnc2V0c2l6
ZSA9IDA7Ci0gICAgICAgIHBpZF90IHBpZCA9IDA7Ci0KLQlURVNUKGZkID0gc2V0dXBfZmlsZShw
cm9nZGlyLCAidGVzdC5maWxlIiwgZnBhdGgpKTsKLSAgICAgICAgaWYgKGZkIDwgMCkKLSAgICAg
ICAgICAgICAgICByZXR1cm4gMTsKLSAgICAgICAgZmRzWzBdLmZkID0gZmQ7Ci0gICAgICAgIGZk
c1swXS5ldmVudHMgPSBQT0xMSU4gfCBQT0xMUFJJIHwgUE9MTE9VVCB8IFBPTExSREhVUDsKLSAg
ICAgICAgZmRzWzBdLnJldmVudHMgPSAwOwotICAgICAgICBwX2ZkcyA9IGZkczsKLSAgICAgICAg
cF90cyA9IE5VTEw7Ci0gICAgICAgIHBfc2lnbWFzayA9IE5VTEw7CisJdW5zaWduZWQgaW50IG5m
ZHMgPSBOVU1fVEVTVF9GRFM7CisJc3RydWN0IHRpbWVzcGVjICpwX3RzLCB0czsKKwlzaWdzZXRf
dCAqcF9zaWdtYXNrLCBzaWdtYXNrOworCXBpZF90IHBpZCA9IDA7CisKKwlURVNUKGZkID0gc2V0
dXBfZmlsZSgiLiIsICJ0ZXN0LmZpbGUiLCBmcGF0aCkpOworCWlmIChmZCA8IDApCisJCXJldHVy
biAxOworCWZkc1swXS5mZCA9IGZkOworCWZkc1swXS5ldmVudHMgPSBQT0xMSU4gfCBQT0xMUFJJ
IHwgUE9MTE9VVCB8IFBPTExSREhVUDsKKwlmZHNbMF0ucmV2ZW50cyA9IDA7CisJcF9mZHMgPSBm
ZHM7CisJcF90cyA9IE5VTEw7CisJcF9zaWdtYXNrID0gTlVMTDsKIAogCXN3aXRjaCAodGMtPnR0
eXBlKSB7Ci0gICAgICAgIGNhc2UgVElNRU9VVDoKLSAgICAgICAgICAgICAgICBuZmRzID0gMDsK
LSAgICAgICAgICAgICAgICB0cy50dl9zZWMgPSAwOwotICAgICAgICAgICAgICAgIHRzLnR2X25z
ZWMgPSA1MDAwMDAwMDsgIC8vIDUwbXNlYwotICAgICAgICAgICAgICAgIHBfdHMgPSAmdHM7Ci0g
ICAgICAgICAgICAgICAgYnJlYWs7CisJY2FzZSBUSU1FT1VUOgorCQluZmRzID0gMDsKKwkJdHMu
dHZfc2VjID0gMDsKKwkJdHMudHZfbnNlYyA9IDUwMDAwMDAwOyAvLyA1MG1zZWMKKwkJcF90cyA9
ICZ0czsKKwkJYnJlYWs7CiAJY2FzZSBGRF9BTFJFQURZX0NMT1NFRDoKLSAgICAgICAgICAgICAg
ICBURVNUKGNsb3NlKGZkKSk7Ci0gICAgICAgICAgICAgICAgZmQgPSAtMTsKLSAgICAgICAgICAg
ICAgICBURVNUKGNsZWFudXBfZmlsZShmcGF0aCkpOwotICAgICAgICAgICAgICAgIGJyZWFrOwot
ICAgICAgICBjYXNlIE1BU0tfU0lHTkFMOgotICAgICAgICAgICAgICAgIFRFU1Qoc2lnZW1wdHlz
ZXQoJnNpZ21hc2spKTsKLSAgICAgICAgICAgICAgICBURVNUKHNpZ2FkZHNldCgmc2lnbWFzaywg
U0lHSU5UKSk7Ci0gICAgICAgICAgICAgICAgcF9zaWdtYXNrID0gJnNpZ21hc2s7Ci0gICAgICAg
ICAgICAgICAgLy9zaWdzZXRzaXplID0gc2l6ZW9mKHNpZ21hc2spOwotICAgICAgICAgICAgICAg
IHNpZ3NldHNpemUgPSA4OwotICAgICAgICAgICAgICAgIG5mZHMgPSAwOwotICAgICAgICAgICAg
ICAgIHRzLnR2X3NlYyA9IDA7Ci0gICAgICAgICAgICAgICAgdHMudHZfbnNlYyA9IDMwMDAwMDAw
MDsgLy8gMzAwbXNlYyA9PiBuZWVkIHRvIGJlIGVub3VnaCBmb3IKLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAvLyAgIHdhaXRpbmcgdGhlIHNpZ25hbAotICAgICAgICAg
ICAgICAgIHBfdHMgPSAmdHM7Ci0gICAgICAgICAgICAgICAgLy8gZmFsbHRocm91Z2gKKwkJVEVT
VChjbG9zZShmZCkpOworCQlmZCA9IC0xOworCQlURVNUKGNsZWFudXBfZmlsZShmcGF0aCkpOwor
CQlicmVhazsKKwljYXNlIE1BU0tfU0lHTkFMOgorCQlURVNUKHNpZ2VtcHR5c2V0KCZzaWdtYXNr
KSk7CisJCVRFU1Qoc2lnYWRkc2V0KCZzaWdtYXNrLCBTSUdJTlQpKTsKKwkJcF9zaWdtYXNrID0g
JnNpZ21hc2s7CisJCW5mZHMgPSAwOworCQl0cy50dl9zZWMgPSAwOworCQl0cy50dl9uc2VjID0g
MzAwMDAwMDAwOyAvLyAzMDBtc2VjID0+IG5lZWQgdG8gYmUgZW5vdWdoIGZvcgorCQkvLyAgIHdh
aXRpbmcgdGhlIHNpZ25hbAorCQlwX3RzID0gJnRzOworCQkvLyBmYWxsdGhyb3VnaAogCWNhc2Ug
U0VORF9TSUdJTlQ6Ci0gICAgICAgICAgICAgICAgbmZkcyA9IDA7Ci0gICAgICAgICAgICAgICAg
cGlkID0gY3JlYXRlX3NpZ19wcm9jKDEwMDAwMCwgU0lHSU5ULCBVSU5UX01BWCk7IC8vIDEwMG1z
ZWMKLSAgICAgICAgICAgICAgICBpZiAocGlkIDwgMCkKLSAgICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAxOwotICAgICAgICAgICAgICAgIGJyZWFrOwotICBjYXNlIFNFTkRfU0lHSU5UX1JB
Q0VfVEVTVDoKLSAgICAvKiBibG9jayB0aGUgSU5UIHNpZ25hbCAqLwotICAgICAgICAgICAgICAg
IHNpZ2VtcHR5c2V0KCZzaWdtYXNrKTsKLSAgICAgICAgICAgICAgICBzaWdhZGRzZXQoJnNpZ21h
c2ssIFNJR0lOVCk7Ci0gICAgICAgICAgICAgICAgc2lncHJvY21hc2soU0lHX1NFVE1BU0ssICZz
aWdtYXNrLCBOVUxMKTsKLQotICAgICAgICAgICAgICAgIC8qIGFuZCBsZXQgaXQgYmUgdW5ibG9j
a2VkIHdoZW4gdGhlIHN5c2NhbGwgcnVucyAqLwotICAgICAgICAgICAgICAgIHNpZ2VtcHR5c2V0
KCZzaWdtYXNrKTsKLSAgICAgICAgICAgICAgICBwX3NpZ21hc2sgPSAmc2lnbWFzazsKLSAgICAg
ICAgICAgICAgICAvL3NpZ3NldHNpemUgPSBzaXplb2Yoc2lnbWFzayk7Ci0gICAgICAgICAgICAg
ICAgc2lnc2V0c2l6ZSA9IDg7Ci0gICAgICAgICAgICAgICAgbmZkcyA9IDA7Ci0gICAgICAgICAg
ICAgICAgdHMudHZfc2VjID0gMDsKLSAgICAgICAgICAgICAgICB0cy50dl9uc2VjID0gMzAwMDAw
MDAwOyAvLyAzMDBtc2VjID0+IG5lZWQgdG8gYmUgZW5vdWdoIGZvcgotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIC8vICAgd2FpdGluZyB0aGUgc2lnbmFsCi0gICAgICAg
ICAgICAgICAgcF90cyA9ICZ0czsKLSAgICAgICAgICAgICAgICBuZmRzID0gMDsKLSAgICAgICAg
ICAgICAgICBwaWQgPSBjcmVhdGVfc2lnX3Byb2MoMCwgU0lHSU5ULCAxKTsKLSAgICAgICAgICAg
ICAgICBpZiAocGlkIDwgMCkgewotICAgICAgICAgICAgICAgICAgcmVzdWx0PTE7Ci0gICAgICAg
ICAgICAgICAgICBnb3RvIGNsZWFudXA7Ci0gICAgICAgICAgICAgICAgfQotICAgICAgICAgICAg
ICAgIGJyZWFrOwotICAgICAgICBjYXNlIElOVkFMSURfTkZEUzoKLSAgICAgICAgICAgICAgICAv
L25mZHMgPSBSTElNSVRfTk9GSUxFICsgMTsgPT0+IFJIRUw0VTEgKyAyLjYuMTggcmV0dXJucyBT
VUNDRVNTCi0gICAgICAgICAgICAgICAgbmZkcyA9IC0xOwotICAgICAgICAgICAgICAgIGJyZWFr
OwotICAgICAgICBjYXNlIElOVkFMSURfRkRTOgotICAgICAgICAgICAgICAgIHBfZmRzID0gKHZv
aWQqKTB4YzAwMDAwMDA7Ci0gICAgICAgICAgICAgICAgYnJlYWs7Ci0gICAgICAgIGNhc2UgTUlO
VVNfTlNFQzoKLSAgICAgICAgICAgICAgICB0cy50dl9zZWMgPSAwOwotICAgICAgICAgICAgICAg
IHRzLnR2X25zZWMgPSAtMTsKLSAgICAgICAgICAgICAgICBwX3RzID0gJnRzOwotICAgICAgICAg
ICAgICAgIGJyZWFrOworCQluZmRzID0gMDsKKwkJcGlkID0gY3JlYXRlX3NpZ19wcm9jKDEwMDAw
MCwgU0lHSU5ULCBVSU5UX01BWCk7IC8vIDEwMG1zZWMKKwkJaWYgKHBpZCA8IDApCisJCQlyZXR1
cm4gMTsKKwkJYnJlYWs7CisJY2FzZSBTRU5EX1NJR0lOVF9SQUNFX1RFU1Q6CisJCS8qIGJsb2Nr
IHRoZSBJTlQgc2lnbmFsICovCisJCXNpZ2VtcHR5c2V0KCZzaWdtYXNrKTsKKwkJc2lnYWRkc2V0
KCZzaWdtYXNrLCBTSUdJTlQpOworCQlzaWdwcm9jbWFzayhTSUdfU0VUTUFTSywgJnNpZ21hc2ss
IE5VTEwpOworCisJCS8qIGFuZCBsZXQgaXQgYmUgdW5ibG9ja2VkIHdoZW4gdGhlIHN5c2NhbGwg
cnVucyAqLworCQlzaWdlbXB0eXNldCgmc2lnbWFzayk7CisJCXBfc2lnbWFzayA9ICZzaWdtYXNr
OworCQluZmRzID0gMDsKKwkJdHMudHZfc2VjID0gMDsKKwkJdHMudHZfbnNlYyA9IDMwMDAwMDAw
MDsgLy8gMzAwbXNlYyA9PiBuZWVkIHRvIGJlIGVub3VnaCBmb3IKKwkJLy8gICB3YWl0aW5nIHRo
ZSBzaWduYWwKKwkJcF90cyA9ICZ0czsKKwkJbmZkcyA9IDA7CisJCXBpZCA9IGNyZWF0ZV9zaWdf
cHJvYygwLCBTSUdJTlQsIDEpOworCQlpZiAocGlkIDwgMCkgeworCQkJcmVzdWx0ID0gMTsKKwkJ
CWdvdG8gY2xlYW51cDsKKwkJfQorCQlicmVhazsKKwljYXNlIElOVkFMSURfTkZEUzoKKwkJLy9u
ZmRzID0gUkxJTUlUX05PRklMRSArIDE7IC8vPT0+IFJIRUw0VTEgKyAyLjYuMTggcmV0dXJucyBT
VUNDRVNTCisJCW5mZHMgPSAtMTsKKwkJYnJlYWs7CisJY2FzZSBJTlZBTElEX0ZEUzoKKwkJcF9m
ZHMgPSAodm9pZCopIDB4YzAwMDAwMDA7CisJCWJyZWFrOworCWNhc2UgTUlOVVNfTlNFQzoKKwkJ
dHMudHZfc2VjID0gMDsKKwkJdHMudHZfbnNlYyA9IC0xOworCQlwX3RzID0gJnRzOworCQlicmVh
azsKIAljYXNlIFRPT19MQVJHRV9OU0VDOgotICAgICAgICAgICAgICAgIHRzLnR2X3NlYyA9IDA7
Ci0gICAgICAgICAgICAgICAgdHMudHZfbnNlYyA9IDEwMDAwMDAwMDA7Ci0gICAgICAgICAgICAg
ICAgcF90cyA9ICZ0czsKLSAgICAgICAgICAgICAgICBicmVhazsKLSAgICAgICAgfQorCQl0cy50
dl9zZWMgPSAwOworCQl0cy50dl9uc2VjID0gMTAwMDAwMDAwMDsKKwkJcF90cyA9ICZ0czsKKwkJ
YnJlYWs7CisJfQogCiAJLyoKLQkgICAqIEV4ZWN1dGUgc3lzdGVtIGNhbGwKLSAgICAgICAgICov
Ci0gICAgICAgIGVycm5vID0gMDsKLSAgICAgICAgVEVTVChzeXNfcmV0ID0gc3lzY2FsbChfX05S
X3Bwb2xsLCBwX2ZkcywgbmZkcywgcF90cywgcF9zaWdtYXNrLCBzaWdzZXRzaXplKSk7Ci0gICAg
ICAgIHN5c19lcnJubyA9IGVycm5vOwotICAgICAgICBpZiAoc3lzX3JldCA8PSAwIHx8IHRjLT5y
ZXQgPCAwKQotICAgICAgICAgICAgICAgIGdvdG8gVEVTVF9FTkQ7Ci0KLSAgICAgICAgY21wX29r
ID0gZmRzWzBdLnJldmVudHMgPT0gdGMtPmV4cGVjdF9yZXZlbnRzOwotICAgICAgICBpZiAob3B0
X2RlYnVnKSB7Ci0gICAgICAgICAgICAgICAgdHN0X3Jlc20oVElORk8sIkVYUEVDVDogcmV2ZW50
cz0weCUwNHgiLCB0Yy0+ZXhwZWN0X3JldmVudHMpOwotICAgICAgICAgICAgICAgIHRzdF9yZXNt
KFRJTkZPLCJSRVNVTFQ6IHJldmVudHM9MHglMDR4IiwgZmRzWzBdLnJldmVudHMpOwotICAgICAg
ICB9Ci0KLVRFU1RfRU5EOgotICAgICAgICAvKgotICAgICAgICAgKiBDaGVjayByZXN1bHRzCi0g
ICAgICAgICAqLwotICAgICAgICBpZih0Yy0+dHR5cGUgPT0gU0VORF9TSUdJTlRfUkFDRV9URVNU
KSB7Ci0gICAgICAgICAgaW50IHNpZzsKLSAgICAgICAgICBzaWdwcm9jbWFzayhTSUdfU0VUTUFT
SywgTlVMTCwgJnNpZ21hc2spOwotICAgICAgICAgIGZvcihzaWc9MTsgc2lnIDwgU0lHUlRNQVg7
IHNpZysrKSB7Ci0gICAgICAgICAgICAgIFRFU1Qoc2lnaXNtZW1iZXIoJnNpZ21hc2ssIHNpZykp
OwotICAgICAgICAgICAgICBpZihURVNUX1JFVFVSTiA8IDAgJiYgVEVTVF9FUlJOTyA9PSBFSU5W
QUwgJiYgc2lnICE9IFNJR0lOVCkKLSAgICAgICAgICAgICAgICBjb250aW51ZTsgLyogbGV0J3Mg
aWdub3JlIGVycm9ycyBpZiB0aGV5IGFyZSBmb3Igb3RoZXIgc2lnbmFsIHRoYW4gU0lHSU5UIHRo
YXQgd2Ugc2V0ICovCi0gICAgICAgICAgICAgIGlmKChzaWc9PVNJR0lOVCkgIT0gKFRFU1RfUkVU
VVJOIT0wKSkgewotICAgICAgICAgICAgICAgIHRzdF9yZXNtKFRGQUlMLCAiQmFkIHZhbHVlIG9m
IHNpZ25hbCBtYXNrLCBzaWduYWwgJWQgaXMgJXMiLCBzaWcsIFRFU1RfUkVUVVJOID8gIm9uIiA6
ICJvZmYiKTsKLSAgICAgICAgICAgICAgICBjbXBfb2sgfD0xOwotICAgICAgICAgICAgICB9Ci0g
ICAgICAgICAgICB9Ci0gICAgICAgIH0KLSAgICAgICAgcmVzdWx0IHw9IChzeXNfZXJybm8gIT0g
dGMtPmVycikgfHwgIWNtcF9vazsKLSAgICAgICAgUFJJTlRfUkVTVUxUX0NNUChzeXNfcmV0ID49
IDAsIHRjLT5yZXQsIHRjLT5lcnIsIHN5c19yZXQsIHN5c19lcnJubywKLSAgICAgICAgICAgICAg
ICAgICAgICAgICBjbXBfb2spOwotIGNsZWFudXA6Ci0gICAgICAgIGlmIChmZCA+PSAwKQotICAg
ICAgICAgICAgICAgIGNsZWFudXBfZmlsZShmcGF0aCk7Ci0KLSAgICAgICAgc2lnZW1wdHlzZXQo
JnNpZ21hc2spOwotICAgICAgICBzaWdwcm9jbWFzayhTSUdfU0VUTUFTSywgJnNpZ21hc2ssIE5V
TEwpOwotICAgICAgICBpZiAocGlkID4gMCkgewotICAgICAgICAgICAgICAgIGludCBzdDsKLSAg
ICAgICAgICAgICAgICBraWxsKHBpZCwgU0lHVEVSTSk7Ci0gICAgICAgICAgICAgICAgd2FpdCgm
c3QpOwotICAgICAgICB9CisJICogRXhlY3V0ZSBzeXN0ZW0gY2FsbAorCSAqLworCWVycm5vID0g
MDsKKwlURVNUKHN5c19yZXQgPSBzeXNjYWxsKF9fTlJfcHBvbGwsIHBfZmRzLCBuZmRzLCBwX3Rz
LCBwX3NpZ21hc2ssIFNJR1NFVFNJWkUpKTsKKwkJc3lzX2Vycm5vID0gZXJybm87CisJaWYgKHN5
c19yZXQgPD0gMCB8fCB0Yy0+cmV0IDwgMCkKKwkJZ290byBURVNUX0VORDsKKworCWNtcF9vayA9
IGZkc1swXS5yZXZlbnRzID09IHRjLT5leHBlY3RfcmV2ZW50czsKKwl0c3RfcmVzbShUSU5GTywg
IkVYUEVDVDogcmV2ZW50cz0weCUwNHgiLCB0Yy0+ZXhwZWN0X3JldmVudHMpOworCXRzdF9yZXNt
KFRJTkZPLCAiUkVTVUxUOiByZXZlbnRzPTB4JTA0eCIsIGZkc1swXS5yZXZlbnRzKTsKKworCVRF
U1RfRU5EOgorCS8qCisJICogQ2hlY2sgcmVzdWx0cworCSAqLworCWlmICh0Yy0+dHR5cGUgPT0g
U0VORF9TSUdJTlRfUkFDRV9URVNUKSB7CisJCWludCBzaWc7CisJCXNpZ3Byb2NtYXNrKFNJR19T
RVRNQVNLLCBOVUxMLCAmc2lnbWFzayk7CisJCWZvciAoc2lnID0gMTsgc2lnIDwgU0lHUlRNQVg7
IHNpZysrKSB7CisJCQlURVNUKHNpZ2lzbWVtYmVyKCZzaWdtYXNrLCBzaWcpKTsKKwkJCWlmIChU
RVNUX1JFVFVSTiA8IDAgJiYgVEVTVF9FUlJOTyA9PSBFSU5WQUwgJiYgc2lnICE9IFNJR0lOVCkK
KwkJCQljb250aW51ZTsgLyogbGV0J3MgaWdub3JlIGVycm9ycyBpZiB0aGV5IGFyZSBmb3Igb3Ro
ZXIgc2lnbmFsIHRoYW4gU0lHSU5UIHRoYXQgd2Ugc2V0ICovCisJCQlpZiAoKHNpZyA9PSBTSUdJ
TlQpICE9IChURVNUX1JFVFVSTiAhPSAwKSkgeworCQkJCXRzdF9yZXNtKFRGQUlMLCAiQmFkIHZh
bHVlIG9mIHNpZ25hbCBtYXNrLCBzaWduYWwgJWQgaXMgJXMiLAorCQkJCQkJc2lnLCBURVNUX1JF
VFVSTiA/ICJvbiIgOiAib2ZmIik7CisJCQkJY21wX29rIHw9IDE7CisJCQl9CisJCX0KKwl9CisJ
cmVzdWx0IHw9IChzeXNfZXJybm8gIT0gdGMtPmVycikgfHwgIWNtcF9vazsKKwlQUklOVF9SRVNV
TFRfQ01QKHN5c19yZXQgPj0gMCwgdGMtPnJldCwgdGMtPmVyciwgc3lzX3JldCwgc3lzX2Vycm5v
LCBjbXBfb2spOworCWNsZWFudXA6IGlmIChmZCA+PSAwKQorCQljbGVhbnVwX2ZpbGUoZnBhdGgp
OworCisJc2lnZW1wdHlzZXQoJnNpZ21hc2spOworCXNpZ3Byb2NtYXNrKFNJR19TRVRNQVNLLCAm
c2lnbWFzaywgTlVMTCk7CisJaWYgKHBpZCA+IDApIHsKKwkJaW50IHN0OworCQlraWxsKHBpZCwg
U0lHVEVSTSk7CisJCXdhaXQoJnN0KTsKKwl9CiAJcmV0dXJuIHJlc3VsdDsKIH0KIAotCiAvKgog
ICogc2lnaGFuZGxlcigpCiAgKi8KLXZvaWQgc2lnaGFuZGxlcihpbnQgc2lnKQotewotICAgICAg
ICBpZiAoc2lnID09IFNJR0lOVCkKLSAgICAgICAgICAgICAgICByZXR1cm47Ci0gICAgICAgIC8v
IE5PVFJFQUNIRUQKLSAgICAgICAgcmV0dXJuOwordm9pZCBzaWdoYW5kbGVyKGludCBzaWcpIHsK
KwlpZiAoc2lnID09IFNJR0lOVCkKKwkJcmV0dXJuOworCS8vIE5PVFJFQUNIRUQKKwlyZXR1cm47
CiB9CiAKLQotLyoKLSAqIHVzYWdlKCkKLSAqLwotCi1zdGF0aWMgdm9pZCB1c2FnZShjb25zdCBj
aGFyICpwcm9nbmFtZSkKLXsKLSAgICAgICAgdHN0X3Jlc20oVElORk8sInVzYWdlOiAlcyBbb3B0
aW9uc10iLCBwcm9nbmFtZSk7Ci0gICAgICAgIHRzdF9yZXNtKFRJTkZPLCJUaGlzIGlzIGEgcmVn
cmVzc2lvbiB0ZXN0IHByb2dyYW0gb2YgJXMgc3lzdGVtIGNhbGwuIixTWVNDQUxMX05BTUUpOwot
ICAgICAgICB0c3RfcmVzbShUSU5GTywib3B0aW9uczoiKTsKLSAgICAgICAgdHN0X3Jlc20oVElO
Rk8sIiAgICAtZCAtLWRlYnVnICAgICAgICAgICBTaG93IGRlYnVnIG1lc3NhZ2VzIik7Ci0gICAg
ICAgIHRzdF9yZXNtKFRJTkZPLCIgICAgLWggLS1oZWxwICAgICAgICAgICAgU2hvdyB0aGlzIG1l
c3NhZ2UiKTsKLSAgICAgICAgdHN0X3Jlc20oVElORk8sIk5HIik7Ci0gICAgICAgIGV4aXQoMSk7
Ci19Ci0KLQogLyoKICAqIG1haW4oKQogICovCiAKLQotCiBpbnQgbWFpbihpbnQgYWMsIGNoYXIg
KiphdikgewogCWludCByZXN1bHQgPSBSRVNVTFRfT0s7Ci0gICAgICAgIGludCBjOwotICAgICAg
ICBpbnQgaTsKLSAgICAgICAgaW50IGxjOyAgICAgICAgICAgICAgICAgLyogbG9vcCBjb3VudGVy
ICovCi0gICAgICAgIGNoYXIgKm1zZzsgICAgICAgICAgICAgIC8qIG1lc3NhZ2UgcmV0dXJuZWQg
ZnJvbSBwYXJzZV9vcHRzICovCi0KLQlzdHJ1Y3Qgb3B0aW9uIGxvbmdfb3B0aW9uc1tdID0gewot
ICAgICAgICAgICAgICAgIHsgImRlYnVnIiwgbm9fYXJndW1lbnQsIDAsICdkJyB9LAotICAgICAg
ICAgICAgICAgIHsgImhlbHAiLCAgbm9fYXJndW1lbnQsIDAsICdoJyB9LAotICAgICAgICAgICAg
ICAgIHsgTlVMTCwgMCwgTlVMTCwgMCB9Ci0gICAgICAgIH07Ci0KLQlwcm9nbmFtZSA9IHN0cmNo
cihhdlswXSwgJy8nKTsKLSAgICAgICAgcHJvZ25hbWUgPSBwcm9nbmFtZSA/IHByb2duYW1lICsg
MSA6IGF2WzBdOwkKLQotCXByb2dkaXIgPSBzdHJkdXAoYXZbMF0pOwotICAgICAgICBwcm9nZGly
ID0gZGlybmFtZShwcm9nZGlyKTsKLQkKLSAgICAgICAgLyogcGFyc2Ugc3RhbmRhcmQgb3B0aW9u
cyAqLwotICAgICAgICBpZiAoKG1zZyA9IHBhcnNlX29wdHMoYWMsIGF2LCAob3B0aW9uX3QgKilO
VUxMLCBOVUxMKSkgIT0gKGNoYXIgKilOVUxMKXsKLSAgICAgICAgICAgICB0c3RfYnJrbShUQlJP
SywgY2xlYW51cCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0gJXMiLCBtc2cpOwotICAgICAgICAg
ICAgIHRzdF9leGl0KCk7Ci0gICAgICAgICAgIH0KLQotICAgICAgICBzZXR1cCgpOwotCi0gICAg
ICAgIC8qIENoZWNrIGxvb3Bpbmcgc3RhdGUgaWYgLWkgb3B0aW9uIGdpdmVuICovCi0gICAgICAg
IGZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyArK2xjKSB7Ci0gICAgICAgICAgICAgICAg
VHN0X2NvdW50ID0gMDsKLSAgICAgICAgICAgICAgICBmb3IgKHRlc3RubyA9IDA7IHRlc3RubyA8
IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHsKLQkJCSBURVNUKGMgPSBnZXRvcHRfbG9uZyhhYywgYXYs
ICJkaCIsIGxvbmdfb3B0aW9ucywgTlVMTCkpOwotCQkJIHdoaWxlKFRFU1RfUkVUVVJOICE9IC0x
KSB7Ci0JCSAgICAgICAgICAgICAgICBzd2l0Y2ggKGMpIHsKLSAgICAgICAgICAgICAgICAJCWNh
c2UgJ2QnOgotCQkgICAgICAgICAgICAgICAgICAgICAgICBvcHRfZGVidWcgPSAxOwotICAgICAg
ICAgICAgICAgIAkJICAgICAgICBicmVhazsKLQkJICAgICAgICAgICAgICAgIGRlZmF1bHQ6Ci0g
ICAgICAgICAgICAgICAgCQkgICAgICAgIHVzYWdlKHByb2duYW1lKTsKLSAgICAgICAgICAgICAg
ICAgICAgICAgIAkJLy8gTk9UUkVBQ0hFRAotICAgICAgICAgICAgICAgIAkJfQotCQkgICAgICAg
IH0KLQotCi0JCWlmIChhYyAhPSBvcHRpbmQpIHsKLSAgICAgICAgCSAgICAgICAgdHN0X3Jlc20o
VElORk8sIk9wdGlvbnMgYXJlIG5vdCBtYXRjaC4iKTsKLSAgICAgICAgICAgICAgICAJdXNhZ2Uo
cHJvZ25hbWUpOwotICAgICAgICAgICAgICAgIAkvLyBOT1RSRUFDSEVECi0JICAgICAgICB9Ci0K
LQkJLyoKLQkJKiBFeGVjdXRlIHRlc3QKLSAgICAgICAgIAkqLwotCSAgICAgICAgZm9yIChpID0g
MDsgaSA8IChpbnQpKHNpemVvZih0Y2FzZSkgLyBzaXplb2YodGNhc2VbMF0pKTsgaSsrKSB7Ci0g
ICAgICAgIAkgICAgICAgIGludCByZXQ7Ci0JICAgICAgICAgICAgICAgIHRzdF9yZXNtKFRJTkZP
LCIoY2FzZSUwMmQpIFNUQVJUIiwgaSk7Ci0JICAgICAgICAgICAgICAgIHJldCA9IGRvX3Rlc3Qo
JnRjYXNlW2ldKTsKLQkgICAgICAgICAgICAgICAgdHN0X3Jlc20oVElORk8sIihjYXNlJTAyZCkg
RU5EID0+ICVzIiwgaSwgKHJldCA9PSAwKSA/ICJPSyIgOiAiTkciKTsKLQkgICAgICAgICAgICAg
ICAgcmVzdWx0IHw9IHJldDsKLSAgICAgICAgCX0KLQkJCi0JCS8qCi0gICAgICAgIAkgKiBDaGVj
ayByZXN1bHRzCi0gICAgICAgICAJKi8KLSAgICAgICAgCXN3aXRjaChyZXN1bHQpIHsKLQkgICAg
ICAgIGNhc2UgUkVTVUxUX09LOgotICAgICAgICAJCQl0c3RfcmVzbShUUEFTUywgInBwb2xsMDEg
Y2FsbCBzdWNjZWVkZWQgIik7Ci0JCSAgICAgICAgICAgICAgICBicmVhazsKLQotCSAgICAgICAg
ZGVmYXVsdDoKLSAgICAgICAgICAgICAgICAgCSAgIAl0c3RfcmVzbShURkFJTCwgIiVzIGZhaWxl
ZCAtIGVycm5vID0gJWQgOiAlcyIsIFRDSUQsIFRFU1RfRVJSTk8sIHN0cmVycm9yKFRFU1RfRVJS
Tk8pKTsKLSAgICAgICAgCQkgICAgICAgIFJQUklOVEYoIk5HIik7CisJaW50IGk7CisJaW50IGxj
OyAvKiBsb29wIGNvdW50ZXIgKi8KKwljaGFyICptc2c7IC8qIG1lc3NhZ2UgcmV0dXJuZWQgZnJv
bSBwYXJzZV9vcHRzICovCisKKwkvKiBwYXJzZSBzdGFuZGFyZCBvcHRpb25zICovCisJaWYgKCht
c2cgPSBwYXJzZV9vcHRzKGFjLCBhdiwgKG9wdGlvbl90ICopIE5VTEwsIE5VTEwpKSAhPSAoY2hh
ciAqKSBOVUxMKSB7CisJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiT1BUSU9OIFBBUlNJTkcg
RVJST1IgLSAlcyIsIG1zZyk7CisJfQorCisJc2V0dXAoKTsKKworCS8qIENoZWNrIGxvb3Bpbmcg
c3RhdGUgaWYgLWkgb3B0aW9uIGdpdmVuICovCisJZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhs
Yyk7ICsrbGMpIHsKKwkJVHN0X2NvdW50ID0gMDsKKwkJZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8g
PCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7CisJCQkvKgorCQkJICogRXhlY3V0ZSB0ZXN0CisJCQkg
Ki8KKwkJCWZvciAoaSA9IDA7IGkgPCAoaW50KSAoc2l6ZW9mKHRjYXNlKSAvIHNpemVvZih0Y2Fz
ZVswXSkpOyBpKyspIHsKKwkJCQlpbnQgcmV0OworCQkJCXRzdF9yZXNtKFRJTkZPLCAiKGNhc2Ul
MDJkKSBTVEFSVCIsIGkpOworCQkJCXJldCA9IGRvX3Rlc3QoJnRjYXNlW2ldKTsKKwkJCQl0c3Rf
cmVzbShUSU5GTywgIihjYXNlJTAyZCkgRU5EID0+ICVzIiwgaSwgKHJldCA9PSAwKSA/ICJPSyIK
KwkJCQkJCTogIk5HIik7CisJCQkJVEVTVF9FUlJPUl9MT0coVEVTVF9FUlJOTyk7CisJCQkJcmVz
dWx0IHw9IHJldDsKKwkJCX0KKworCQkJLyoKKwkJCSAqIENoZWNrIHJlc3VsdHMKKwkJCSAqLwor
CQkJc3dpdGNoIChyZXN1bHQpIHsKKwkJCWNhc2UgUkVTVUxUX09LOgorCQkJCXRzdF9yZXNtKFRQ
QVNTLCAicHBvbGwwMSBjYWxsIHN1Y2NlZWRlZCAiKTsKKwkJCQlicmVhazsKKworCQkJZGVmYXVs
dDoKKwkJCQl0c3RfcmVzbShURkFJTCB8IFRURVJSTk8sICIlcyBmYWlsZWQiLCBUQ0lEKTsKKwkJ
CQlSUFJJTlRGKCJORyIpOwogCQkJCWNsZWFudXAoKTsKLQkJCQl0c3RfZXhpdCgpOwotCQkgICAg
ICAgICAgICAgICAgYnJlYWs7Ci0gICAgICAgIAl9Ci0KLSAgICAgICAgICAgICAgICB9Ci0gICAg
ICAgIH0JCi0gICAgICAgIGNsZWFudXAoKTsKLQl0c3RfZXhpdCgpOworCQkJCWJyZWFrOworCQkJ
fQorCisJCX0KKwl9CisJY2xlYW51cCgpOworCXJldHVybiAwOwogfQogCg==

------_=_NextPart_001_01CA6404.A1F78F9D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
------_=_NextPart_001_01CA6404.A1F78F9D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA6404.A1F78F9D--

