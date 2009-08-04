Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MYJIa-0005NS-H8
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:39:24 +0000
Received: from mail-gx0-f209.google.com ([209.85.217.209])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYJIU-0007Qk-Gb
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:39:24 +0000
MIME-Version: 1.0
In-Reply-To: <1249387539.15587.24.camel@subratamodak.linux.ibm.com>
References: <d51f89b0907230130k158cbfbeo31f290cf207432b6@mail.gmail.com>
	<1248978557.5788.61.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040422o17ac20f6q36aaff23ea88e839@mail.gmail.com>
	<1249385096.15587.17.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040431w6208a47fgbe79b5df30c6268c@mail.gmail.com>
	<1249387539.15587.24.camel@subratamodak.linux.ibm.com>
Date: Tue, 4 Aug 2009 17:44:31 +0530
Message-ID: <d51f89b0908040514w188e9c2obceb53fdd266588a@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Content-Type: multipart/mixed; boundary=0016362839a62df5c104704fd4fe
Subject: Re: [LTP] waitid02 testcase fails on 2.6.29 kernel
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

--0016362839a62df5c104704fd4fe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

PFA the patch for waitid02

On Tue, Aug 4, 2009 at 5:35 PM, Subrata Modak<subrata@linux.vnet.ibm.com> w=
rote:
> On Tue, 2009-08-04 at 17:01 +0530, rohit verma wrote:
>> FYI
>
> unfortunately, you did not attach the patch itself ;-)
>
> Regards--
> Subrata
>
>>
>> ---------- Forwarded message ----------
>> From: Subrata Modak <subrata@linux.vnet.ibm.com>
>> Date: Tue, Aug 4, 2009 at 4:54 PM
>> Subject: Re: [LTP] waitid02 testcase fails on 2.6.29 kernel
>> To: rohit verma <rohit.170309@gmail.com>
>> Cc: maknayak@in.ibm.com, CAI Qian <caiqian@cclom.cn>
>>
>>
>> Rohit,
>>
>> Post this to ltp mailing list.
>>
>> Regards--
>> Subrata
>>
>> On Tue, 2009-08-04 at 16:52 +0530, rohit verma wrote:
>> > Dear Manas Kumar Nayak,
>> >
>> > Pls find attached patch for waitid02 test case.I have modified the
>> > test case.I have also added 2 test scenarios in the test case using
>> > WSTOPPED and WNOWAIT.
>> >
>> > Note:
>> > The testcase was failing in LTP July, 2009 release.
>> > The warning- "implicit declaration of function 'getpgid", has been rem=
oved
>> >
>> > Pls verify the patch.
>> >
>> > Regards--
>> > Rohit Verma
>> >
>> >
>> >
>> > On Thu, Jul 30, 2009 at 11:59 PM, Subrata
>> > Modak<subrata@linux.vnet.ibm.com> wrote:
>> > > Fixed this now.
>> > >
>> > > Regards--
>> > > Subrata
>> > >
>> > > On Thu, 2009-07-23 at 14:00 +0530, rohit verma wrote:
>> > >> Hi,
>> > >>
>> > >> I am running waitid02.c
>> > >> (ltp-full-20090630/testcases/kernel/syscalls/waitid/ ) test case on
>> > >> 2.6.29 kernel.
>> > >> Test case gives following error:
>> > >> "Error. is your system >2.6.9 ?";
>> > >>
>> > >> =A0Anybody facing the same issue?
>> > >>
>> > >> Code:
>> > >>
>> > >> TEST(waitid(P_ALL,0,&infop,WNOHANG));
>> > >> =A0 =A0 =A0 =A0 if(TEST_RETURN =3D=3D 0)
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TPASS,"Success !");
>> > >> =A0 =A0 =A0 =A0 else{
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("value of return is %d\n",TE=
ST_RETURN);
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TFAIL,"Error. is your syst=
em >2.6.9 ?");
>> > >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0errnochoose();
>> > >> =A0 =A0 =A0 =A0 }
>> > >>
>> > >>
>> > >> Regards,
>> > >> Rohit
>> > >>
>> > >> -------------------------------------------------------------------=
-----------
>> > >> _______________________________________________
>> > >> Ltp-list mailing list
>> > >> Ltp-list@lists.sourceforge.net
>> > >> https://lists.sourceforge.net/lists/listinfo/ltp-list
>> > >
>> > >
>> >
>> >
>> >
>>
>> ------------------------------------------------------------------------=
------
>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-=
Day
>> trial. Simplify your report design, integration and deployment - and foc=
us on
>> what you do best, core application coding. Discover what's new with
>> Crystal Reports now. =A0http://p.sf.net/sfu/bobj-july
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>



--=20
Regards,
Rohit

--0016362839a62df5c104704fd4fe
Content-Type: text/plain; charset=US-ASCII; name="waitid02.txt"
Content-Disposition: attachment; filename="waitid02.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxylcfig0

U2lnbmVkLW9mZi1ieTogcm9oaXQgdmVybWEgKHJvaGl0MTcwMzA5QGdtYWlsLmNvbSkKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQpkaWZmIC1ydU5CIGx0cC1mdWxsLTIwMDkwNzMxX3AvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy93YWl0aWQvd2FpdGlkMDIuYyBsdHAtZnVsbC0yMDA5MDczMS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3dhaXRpZC93YWl0aWQwMi5jCi0tLSBsdHAtZnVsbC0yMDA5
MDczMV9wL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvd2FpdGlkL3dhaXRpZDAyLmMJMjAwOS0w
Ny0zMCAyMDo0NToyNS4wMDAwMDAwMDAgKzA1MzAKKysrIGx0cC1mdWxsLTIwMDkwNzMxL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvd2FpdGlkL3dhaXRpZDAyLmMJMjAwOS0wOC0wNCAxNTozNzo1
My4wMDAwMDAwMDAgKzA1MzAKQEAgLTU4LDcgKzU3LDcgQEAKIC8qIEdsb2JhbCBWYXJpYWJsZXMg
Ki8KIGNoYXIgKlRDSUQgPSAid2FpdGlkMDIiOyAgLyogVGVzdCBwcm9ncmFtIGlkZW50aWZpZXIu
Ki8KIGludCAgdGVzdG5vOwotaW50ICBUU1RfVE9UQUwgPSA3OyAgICAgICAgICAgICAgICAgICAv
KiB0b3RhbCBudW1iZXIgb2YgdGVzdHMgaW4gdGhpcyBmaWxlLiAgICovCitpbnQgIFRTVF9UT1RB
TCA9IDQ7ICAgICAgICAgICAgICAgICAgIC8qIHRvdGFsIG51bWJlciBvZiB0ZXN0cyBpbiB0aGlz
IGZpbGUuICAqLwogCiAvKiBFeHRlcm4gR2xvYmFsIEZ1bmN0aW9ucyAqLwogLyoqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKi8KQEAgLTEwNiwxMTQgKzEwNSwxNDUgQEAKIC8qICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICovCiAvKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqLwogdm9pZCBzZXR1cCgpIHsKLSAgICAgICAgLyog
Q2FwdHVyZSBzaWduYWxzIGlmIGFueSAqLwotICAgICAgICAvKiBDcmVhdGUgdGVtcG9yYXJ5IGRp
cmVjdG9yaWVzICovCi0gICAgICAgIFRFU1RfUEFVU0U7Ci0gICAgICAgIHRzdF90bXBkaXIoKTsK
KwkvKiBDYXB0dXJlIHNpZ25hbHMgaWYgYW55ICovCisJLyogQ3JlYXRlIHRlbXBvcmFyeSBkaXJl
Y3RvcmllcyAqLworCVRFU1RfUEFVU0U7CisJdHN0X3RtcGRpcigpOwogfQogCiAKIGludCBlcnJu
b2Nob29zZSh2b2lkKXsgICAvL2Nob29zZSB0aGUgcmVsYXRpdmUgZXJybm8KIAotICAgIHN3aXRj
aCAoVEVTVF9FUlJOTyl7Ci0gICAgICAgIGNhc2UgICAgRUNISUxEOiAgc3RyZXJyb3IoKGludCki
RUNISUxEIik7Ci0JCQlicmVhazsKLSAgICAgICAgY2FzZSAgICBFSU5UUjogIHN0cmVycm9yKChp
bnQpIkVJTlRSIik7Ci0JCQlicmVhazsKLSAgICAgICAgY2FzZSAgICBFSU5WQUw6IHN0cmVycm9y
KChpbnQpIkVJTlZBTCIpOwotCQkJYnJlYWs7Ci0gICAgICAgIGRlZmF1bHQ6ICAgICBzdHJlcnJv
cigoaW50KSJPdGhlciBFcnJvciIpOwotICAgfQotICAgICAgICB0c3RfZXhpdCgpIDsKKwlzd2l0
Y2ggKFRFU1RfRVJSTk8pIHsKKwljYXNlICAgIEVDSElMRDogIHN0cmVycm9yKChpbnQpIkVDSElM
RCIpOworCQlicmVhazsKKwljYXNlICAgIEVJTlRSOiAgc3RyZXJyb3IoKGludCkiRUlOVFIiKTsK
KwkJYnJlYWs7CisJY2FzZSAgICBFSU5WQUw6IHN0cmVycm9yKChpbnQpIkVJTlZBTCIpOworCQli
cmVhazsKKwlkZWZhdWx0OiAgICAgc3RyZXJyb3IoKGludCkiT3RoZXIgRXJyb3IiKTsKKwl9CisJ
dHN0X2V4aXQoKSA7CiB9CiAKIAogaW50IG1haW4oaW50IGFjLCBjaGFyICoqYXYpIHsKLQlpZF90
IGNwaWQ7Ci0gICAgICAgIGlkX3QgaWQxLGlkMixpZDM7Ci0JaWRfdCBnaWQxLGdpZDIsZ2lkMzsK
LSAgICAgICAgc2lnaW5mb190IGluZm9wOwotICAgICAgICBpbnQgaSA9IDA7CisJaWRfdCBwZ2lk
OworCWlkX3QgaWQxLCBpZDIsIGlkMzsKKwlzaWdpbmZvX3QgaW5mb3A7CisJaW50IGkgPSAwOwog
Ci0gICAgICAgIGludCBsYzsgICAgICAgICAgICAgICAgIC8qIGxvb3AgY291bnRlciAqLwotICAg
ICAgICBjaGFyICptc2c7ICAgICAgICAgICAgICAvKiBtZXNzYWdlIHJldHVybmVkIGZyb20gcGFy
c2Vfb3B0cyAqLworCWludCBsYzsgICAgICAgICAgICAgICAgIC8qIGxvb3AgY291bnRlciAqLwor
CWNoYXIgKm1zZzsgICAgICAgICAgICAgIC8qIG1lc3NhZ2UgcmV0dXJuZWQgZnJvbSBwYXJzZV9v
cHRzICovCiAJCiAgICAgICAgIC8qIHBhcnNlIHN0YW5kYXJkIG9wdGlvbnMgKi8KLSAgICAgICAg
aWYgKChtc2cgPSBwYXJzZV9vcHRzKGFjLCBhdiwgKG9wdGlvbl90ICopTlVMTCwgTlVMTCkpICE9
IChjaGFyICopTlVMTCl7Ci0gICAgICAgICAgICAgdHN0X2Jya20oVEJST0ssIGNsZWFudXAsICJP
UFRJT04gUEFSU0lORyBFUlJPUiAtICVzIiwgbXNnKTsKLSAgICAgICAgICAgICB0c3RfZXhpdCgp
OwotICAgICAgICAgICB9Ci0KLSAgICAgICAgc2V0dXAoKTsKLQotICAgICAgICAvKiBDaGVjayBs
b29waW5nIHN0YXRlIGlmIC1pIG9wdGlvbiBnaXZlbiAqLwotCi0gICAgICAgIGZvciAobGMgPSAw
OyBURVNUX0xPT1BJTkcobGMpOyArK2xjKSB7Ci0gICAgICAgICAgICAgICAgVHN0X2NvdW50ID0g
MDsKLSAgICAgICAgICAgICAgICBmb3IgKHRlc3RubyA9IDA7IHRlc3RubyA8IFRTVF9UT1RBTDsg
Kyt0ZXN0bm8pIHsKKwltc2cgPSBwYXJzZV9vcHRzKGFjLCBhdiwgKG9wdGlvbl90ICopTlVMTCwg
TlVMTCk7CisJaWYgKG1zZyAhPSAoY2hhciAqKU5VTEwpIHsKKwkJdHN0X2Jya20oVEJST0ssIGNs
ZWFudXAsICJPUFRJT04gUEFSU0lORyBFUlJPUiAtICVzIiwgbXNnKTsKKwkJdHN0X2V4aXQoKTsK
Kwl9CisKKwlzZXR1cCgpOworCisJLyogQ2hlY2sgbG9vcGluZyBzdGF0ZSBpZiAtaSBvcHRpb24g
Z2l2ZW4gKi8KKworCWZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyArK2xjKSB7CisJCVRz
dF9jb3VudCA9IDA7CisJCWZvciAodGVzdG5vID0gMDsgdGVzdG5vIDwgVFNUX1RPVEFMOyArK3Rl
c3RubykJewogICAgICAgICAgICAgICAgICAgICAgCi0JCi0JVEVTVCh3YWl0aWQoUF9BTEwsMCwm
aW5mb3AsV05PSEFORykpOwotCWlmKFRFU1RfUkVUVVJOID09IDApCi0gICAgICAgICAgICAgICAg
dHN0X3Jlc20oVFBBU1MsIlN1Y2Nlc3MgISIpOwotICAgICAgICBlbHNlewotICAgICAgICAgICAg
ICAgIHRzdF9yZXNtKFRGQUlMLCIlcyBmYWlsZWQiLCBUQ0lEKTsKLSAgICAgICAgICAgICAgICBl
cnJub2Nob29zZSgpOwotICAgICAgICB9Ci0KLS8vIG9wdGlvbiA9PSBXRVhJVEVEIHwgV0NPTlRJ
TlVFRCB8IFdTVE9QUEVEIHwgV05PSEFORyB8IFdOT1dBSVQgOwotCi0JVEVTVChmb3JrKCkpOwot
CWlmKFRFU1RfUkVUVVJOID09IDApewotICAgICAgICAgICAgICAgIHRzdF9yZXNtKFRJTkZPLCJJ
J20gYSBjaGlsZCxteSBpZCBpcyAlZCxncGlkIGlzICVkIixpZDE9Z2V0cGlkKCksZ2lkMT1nZXRw
Z2lkKDApKTsKKwlURVNUKHdhaXRpZChQX0FMTCwgMCwgJmluZm9wLCBXTk9IQU5HKSk7CisJaWYg
KFRFU1RfUkVUVVJOID09IC0xKQorCQl0c3RfcmVzbShUUEFTUywgIlN1Y2Nlc3MxIC4uLiAtMSBp
cyByZXR1cm5lZC4gZXJyb3IgaXMgJWQuIiwKKwkJVEVTVF9FUlJOTyk7CisJZWxzZSB7CisJCXRz
dF9yZXNtKFRGQUlMLCAiJXMgRmFpbGVkMSAuLi4iLCBUQ0lEKTsKKwl9CisKKwkvKiBvcHRpb24g
PT0gV0VYSVRFRCB8IFdDT05USU5VRUQgfCBXU1RPUFBFRCB8IFdOT0hBTkcgfCBXTk9XQUlUKi8K
KworCVRFU1QoaWQxID0gZm9yaygpKTsKKwlpZiAoVEVTVF9SRVRVUk4gPT0gMCkgeworCQl0c3Rf
cmVzbShUSU5GTywgIkknbSBhIGNoaWxkIDEsbXkgaWQgaXMgJWQsZ3BpZCBpcyAlZCIsCisJCWlk
MSA9IGdldHBpZCgpLCBfX2dldHBnaWQoMCkpOworCQlzbGVlcCgxKTsKIAkJZXhpdCg1KTsKLSAg
ICAgICAgfQotICAgICAgICAKLQlURVNUKGZvcmsoKSk7Ci0JaWYoVEVTVF9SRVRVUk4gPT0gMCl7
Ci0gICAgICAgICAgICAgICAgdHN0X3Jlc20oVElORk8sIkknbSBhIGNoaWxkLG15IGlkIGlzICVk
LGdwaWQgaXMgJWQiLGlkMj1nZXRwaWQoKSxnaWQyPWdldHBnaWQoMCkpOworCX0KKworCVRFU1Qo
aWQyID0gZm9yaygpKTsKKwlpZiAoVEVTVF9SRVRVUk4gPT0gMCkgeworCQlzbGVlcCgzKTsKKwkJ
dHN0X3Jlc20oVElORk8sICJJJ20gYSBjaGlsZCAyLG15IGlkIGlzICVkLGdwaWQgaXMgJWQiLAor
CQlpZDIgPSBnZXRwaWQoKSwgX19nZXRwZ2lkKDApKTsKIAkJZXhpdCg3KTsKLSAgICAgICAgfQor
CX0KIAotCVRFU1QoZm9yaygpKTsKLQlpZihURVNUX1JFVFVSTiA9PSAwKXsKLSAgICAgICAgICAg
ICAgICB0c3RfcmVzbShUSU5GTywiSSdtIGEgY2hpbGQsbXkgaWQgaXMgJWQsZ3BpZCBpcyAlZCIs
aWQzPWdldHBpZCgpLGdpZDM9Z2V0cGdpZCgwKSk7CisJVEVTVChpZDMgPSBmb3JrKCkpOworCWlm
IChURVNUX1JFVFVSTiA9PSAwKSB7CisJCXNsZWVwKDIpOworCQlURVNUKGtpbGwoaWQyLCBTSUdD
T05UKSk7CisJCXRzdF9yZXNtKFRJTkZPLCAiSSdtIGEgY2hpbGQgMyxteSBpZCBpcyAlZCxncGlk
IGlzICVkIiwKKwkJaWQzID0gZ2V0cGlkKCksIF9fZ2V0cGdpZCgwKSk7CiAJCWV4aXQoNik7Ci0g
ICAgICAgIH0KKwl9CisKKwlURVNUKHdhaXRpZChQX0FMTCwgMCwgJmluZm9wLCBXTk9IQU5HIHwg
V0VYSVRFRCkpOworCWlmIChURVNUX1JFVFVSTiA9PSAwKQorCQl0c3RfcmVzbShUUEFTUywgIlN1
Y2Nlc3MgMiAuLi4wIGlzIHJldHVybmVkLi4gZXJyb3IgaXMgJWQuIiwKKwkJVEVTVF9FUlJOTyk7
CisJZWxzZSB7CisJCXRzdF9yZXNtKFRGQUlMLCAiJXMgRmFpbGVkIDIiLCBUQ0lEKTsKKwkJZXJy
bm9jaG9vc2UoKTsKKwl9CiAKLSAgICAgICAgdHN0X3Jlc20oVElORk8sIkknbSBhIGZhdGhlciAl
ZCIsY3BpZD1nZXRwaWQoKSk7CisJdHN0X3Jlc20oVElORk8sICJJJ20gYSBQYXJlbnQsbXkgaWQg
aXMgJWQsZ3BpZCBpcyAlZCIsCisJCWdldHBpZCgpLCBwZ2lkID0gX19nZXRwZ2lkKDApKTsKIAot
ICAgICAgICBURVNUKHdhaXRpZChQX1BHSUQsY3BpZCwmaW5mb3AsV0VYSVRFRCkpOworCVRFU1Qo
d2FpdGlkKFBfUEdJRCwgcGdpZCwgJmluZm9wLCBXRVhJVEVEKSk7CiAJaWYoVEVTVF9SRVRVUk4g
PT0gMCl7CQkJCQotCSB0c3RfcmVzbShUUEFTUywiU3VjY2VzcyAuLi4gMCBpcyByZXR1cm5lZC4i
KTsKLSAgICAgICAgIHRzdF9yZXNtKFRJTkZPLCJzaV9waWQgPSAlZCA7IHNpX2NvZGUgPSAlZCA7
IHNpX3N0YXR1cyA9ICVkIixpbmZvcC5zaV9waWQsaW5mb3Auc2lfY29kZSxpbmZvcC5zaV9zdGF0
dXMpOwotCX1lbHNlIHsKLQkJdHN0X3Jlc20oVEZBSUwsIkZhaWwuLi4gICVkIGlzIHJldHVybmVk
IixURVNUX1JFVFVSTik7Ci0gICAgICAgICAgICAgICAgZXJybm9jaG9vc2UoKTsKLQkgICAgIH0K
LQotICAgICAgICBURVNUKHdhaXRpZChQX1BHSUQsaWQyLCZpbmZvcCxXRVhJVEVEKSk7Ci0JaWYo
VEVTVF9SRVRVUk4gPT0gMCl7CQkJCS8vTk9DSElMRAotICAgICAgICAgdHN0X3Jlc20oVElORk8s
InNpX3BpZCA9ICVkIDsgc2lfY29kZSA9ICVkIDsgc2lfc3RhdHVzID0gJWQiLGluZm9wLnNpX3Bp
ZCxpbmZvcC5zaV9jb2RlLGluZm9wLnNpX3N0YXR1cyk7Ci0JIHRzdF9yZXNtKFRQQVNTLCJTdWNj
ZXNzMiAuLi4gMCBpcyByZXR1cm5lZCIpOwotCX1lbHNlIHsKLQkJdHN0X3Jlc20oVEZBSUwsIkZh
aWwuLi4gICVkIGlzIHJldHVybmVkIixURVNUX1JFVFVSTik7Ci0gICAgICAgICAgICAgICAgZXJy
bm9jaG9vc2UoKTsKLQkgICAgIH0KLQotICAgICAgICBURVNUKGkgPSB3YWl0aWQoUF9QSUQsaWQx
LCZpbmZvcCxXQ09OVElOVUVEKSk7Ci0JaWYoVEVTVF9SRVRVUk4gPT0gMCl7CQkJCS8vRUlOVkFM
Ci0gICAgICAgICB0c3RfcmVzbShUSU5GTywic2lfcGlkID0gJWQgOyBzaV9jb2RlID0gJWQgOyBz
aV9zdGF0dXMgPSAlZCIsaW5mb3Auc2lfcGlkLGluZm9wLnNpX2NvZGUsaW5mb3Auc2lfc3RhdHVz
KTsKLQkgdHN0X3Jlc20oVFBBU1MsIlN1Y2Nlc3MzIC4uLiAwIGlzIHJldHVybmVkIik7Ci0JfWVs
c2UgewotCQl0c3RfcmVzbShURkFJTCwiRmFpbC4uLiAgJWQgaXMgcmV0dXJuZWQiLGkpOwotICAg
ICAgICAgICAgICAgIGVycm5vY2hvb3NlKCk7Ci0JICAgICB9Ci0gICAgICAgICAgfQotICAgICB9
CQotICAgICAgICBjbGVhbnVwKCk7CisJCXRzdF9yZXNtKFRQQVNTLCAiU3VjY2VzczMgLi4uIDAg
aXMgcmV0dXJuZWQuIik7CisJCXRzdF9yZXNtKFRJTkZPLCAic2lfcGlkID0gJWQgOyBzaV9jb2Rl
ID0gJWQgOyBzaV9zdGF0dXMgPSAlZCIsCisJCWluZm9wLnNpX3BpZCwgaW5mb3Auc2lfY29kZSwg
aW5mb3Auc2lfc3RhdHVzKTsKKwl9IGVsc2UgeworCQl0c3RfcmVzbShURkFJTCwgIkZhaWwzIC4u
LiAgJWQgaXMgcmV0dXJuZWQiLCBURVNUX1JFVFVSTik7CisJCWVycm5vY2hvb3NlKCk7CisJfQor
CisJVEVTVChraWxsKGlkMiwgU0lHU1RPUCkpOworCisJVEVTVChpID0gd2FpdGlkKFBfUElELCBp
ZDIsICZpbmZvcCwgV1NUT1BQRUQgfCBXTk9XQUlUKSk7CisJaWYgKFRFU1RfUkVUVVJOID09IDAp
IHsJLypFSU5WQUwqLworCQl0c3RfcmVzbShUSU5GTywgInNpX3BpZCA9ICVkLCBzaV9jb2RlID0g
JWQsIHNpX3N0YXR1cyA9ICVkIiwKKwkJaW5mb3Auc2lfcGlkLCBpbmZvcC5zaV9jb2RlLCBpbmZv
cC5zaV9zdGF0dXMpOworCQl0c3RfcmVzbShUUEFTUywgIlN1Y2Nlc3M0IC4uLiAwIGlzIHJldHVy
bmVkIik7CisJfSBlbHNlIHsKKwkJdHN0X3Jlc20oVEZBSUwsICJGYWlsNCAuLi4gICVkIGlzIHJl
dHVybmVkIiwgaSk7CisJCWVycm5vY2hvb3NlKCk7CisJfQorCisKKwlURVNUKHdhaXRpZChQX1BJ
RCwgaWQzLCAmaW5mb3AsIFdFWElURUQpKTsKKwlpZiAoVEVTVF9SRVRVUk4gPT0gMCkgewkvKk5P
Q0hJTEQqLworCQl0c3RfcmVzbShUSU5GTywgInNpX3BpZCA9ICVkLCBzaV9jb2RlID0gJWQsIHNp
X3N0YXR1cyA9ICVkIiwKKwkJaW5mb3Auc2lfcGlkLCBpbmZvcC5zaV9jb2RlLCBpbmZvcC5zaV9z
dGF0dXMpOworCQl0c3RfcmVzbShUUEFTUywgIlN1Y2Nlc3M1IC4uLiAwIGlzIHJldHVybmVkIik7
CisJfSBlbHNlIHsKKwkJdHN0X3Jlc20oVEZBSUwsICJGYWlsNSAuLi4gICVkIGlzIHJldHVybmVk
IiwgVEVTVF9SRVRVUk4pOworCQllcnJub2Nob29zZSgpOworCQl9CisKKwlURVNUKGkgPSB3YWl0
aWQoUF9QSUQsIGlkMiwgJmluZm9wLCBXQ09OVElOVUVEKSk7CisJaWYgKFRFU1RfUkVUVVJOID09
IDApIHsJLypFSU5WQUwqLworCQl0c3RfcmVzbShUSU5GTywgInNpX3BpZCA9ICVkLCBzaV9jb2Rl
ID0gJWQsIHNpX3N0YXR1cyA9ICVkIiwKKwkJaW5mb3Auc2lfcGlkLCBpbmZvcC5zaV9jb2RlLCBp
bmZvcC5zaV9zdGF0dXMpOworCQl0c3RfcmVzbShUUEFTUywgIlN1Y2Nlc3M2IC4uLiAwIGlzIHJl
dHVybmVkIik7CisJfSBlbHNlIHsKKwkJdHN0X3Jlc20oVEZBSUwsICJGYWlsNiAuLi4gICVkIGlz
IHJldHVybmVkIiwgaSk7CisJCWVycm5vY2hvb3NlKCk7CisJfQorCisJc2xlZXAoMyk7CisJfQor
CX0KKwljbGVhbnVwKCk7CiAJdHN0X2V4aXQoKTsKIH0KLQotCi0K
--0016362839a62df5c104704fd4fe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--0016362839a62df5c104704fd4fe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0016362839a62df5c104704fd4fe--

