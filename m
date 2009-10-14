Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1MxtZ6-0004wx-I0
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 02:26:12 +0000
Received: from gateway-1237.mvista.com ([63.81.120.158])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MxtYw-0001bN-VM
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 02:26:12 +0000
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CA4C75.709E5941"
Date: Tue, 13 Oct 2009 19:25:18 -0700
Message-ID: <8368651DACC1964480F951191B94A0780153D3FC@svexch01.mvista.com>
In-Reply-To: <364299f40910131221h7f9acf01te65be5b462281463@mail.gmail.com>
References: <8368651DACC1964480F951191B94A0780142442B@svexch01.mvista.com>
	<200910050018.12711.jpalecek@web.de>
	<8368651DACC1964480F951191B94A0780153CC19@svexch01.mvista.com>
	<1255445017.8438.66.camel@subratamodak.linux.ibm.com>
	<364299f40910131220x162b5e02u65bae87e349f7dda@mail.gmail.com>
	<364299f40910131221h7f9acf01te65be5b462281463@mail.gmail.com>
From: "Henry Yei" <hyei@mvista.com>
Subject: Re: [LTP] [PATCH][openfile] file descriptors not cleaned up
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
To: Garrett Cooper <yanegomi@gmail.com>, subrata@linux.vnet.ibm.com
Cc: jpalecek@web.de, LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA4C75.709E5941
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

All,

Here is the openfile patch without the Makefile changes as they are not =
needed with the new Makefile changes.
I regenerated and tested the patch with the latest version of the ltp =
from CVS.

I had trouble compiling LTP without autoconf 2.61 even after following =
instructions from the README.mk-users file to try to build without =
autoconf. Most of our test hosts are running autoconf 2.59. Does anyone =
have updated instructions?


-----Original Message-----
From: Garrett Cooper [mailto:yanegomi@gmail.com]=20
Sent: Tuesday, October 13, 2009 12:22 PM
To: subrata@linux.vnet.ibm.com
Cc: Henry Yei; jpalecek@web.de; LTP Mailing List
Subject: Re: [LTP] [PATCH][openfile] file descriptors not cleaned up

On Tue, Oct 13, 2009 at 12:20 PM, Garrett Cooper <yanegomi@gmail.com> =
wrote:
> On Tue, Oct 13, 2009 at 7:43 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
>> On Mon, 2009-10-05 at 14:33 -0700, Henry Yei wrote:
>>> On Wednesday 04, October 2009 04:06:46 Jiri Palecek wrote:
>>>
>>> Hello,
>>>
>>> On Wednesday 30 September 2009 04:06:46 Henry Yei wrote:
>>> > This patch for openfile contains the following changes:
>>> > - test output to use tst_resm functions
>>> > - sets ups and cleans up tmp dir properly
>>> > - closes all opened file descriptors before thread exit(fixes nfs =
issues on removing tmp dir)
>>> >
>>> > Signed-off-by: Henry Yei <hyei@mvista.com>
>>> >
>>> >
>>> > This test opens multiple file descriptors to the same file. =
Perhaps the author meant to open file handles for separate files?
>>>
>>> This is suspicious, for me too. But maybe there is some logic behind =
opening the same file many times.
>>>
>>> I just have a small remark about your patch: Shouldn't you call =
close_files() here, too? (With a partially full fd_list array handled, =
of course)
>>>
>>> +void * threads(void* thread_id_) {
>>> + =A0 =A0 int thread_id =3D (uintptr_t) thread_id_;
>>> + =A0 =A0 char errmsg[80];
>>> + =A0 =A0 FILE *fd_list[MAXFILES];
>>> + =A0 =A0 int i;
>>> +
>>> + =A0 =A0 /* Open files */
>>> + =A0 =A0 for (i =3D 0; i < numfiles; i++) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (debug)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("Thread =A0%d : =
Opening file number %d \n", thread_id, i);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((fd_list[i] =3D fopen(filename, "rw")) =
=3D=3D NULL) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(errmsg, "FAIL - =
Couldn't open file #%d", i);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror(errmsg);
>>>
>>>
>>>
>>> Jiri,
>>>
>>> Thanks for reviewing the patch. Yes, that was an omission on my =
part. I have attached an updated patch. Let me know if there are any =
more comments.
>>>
>>
>> Henry,
>>
>> This patch is ineffective on the present Makefile(s). Please rebase =
them
>> over latest CVS and resend:
>>
>> patching file testcases/kernel/fs/openfile/Makefile
>> Hunk #1 FAILED at 1.
>> 1 out of 1 hunk FAILED -- saving rejects to file
>> testcases/kernel/fs/openfile/Makefile.rej
>> patching file testcases/kernel/fs/openfile/openfile.c
>
> =A0 =A0I'll gladly help if help is needed. Feel free to ping me and we
> can setup a rendezvous on IRC or something.

    I looked at the diff again and if you just omit the Makefile
change then the rest should go through.
HTH,
-Garrett

------_=_NextPart_001_01CA4C75.709E5941
Content-Type: application/octet-stream;
	name="openfile.patch"
Content-Transfer-Encoding: base64
Content-Description: openfile.patch
Content-Disposition: attachment;
	filename="openfile.patch"

LS0tIGx0cC90ZXN0Y2FzZXMva2VybmVsL2ZzL29wZW5maWxlL29wZW5maWxlLmMJMjAwOS0wMi0y
NiAwNDoxNDo1Mi4wMDAwMDAwMDAgLTA4MDAKKysrIGx0cC13ZGlyL3Rlc3RjYXNlcy9rZXJuZWwv
ZnMvb3BlbmZpbGUvb3BlbmZpbGUuYwkyMDA5LTEwLTA1IDE0OjI4OjIzLjU4NDA5NzgyNiAtMDcw
MApAQCAtMjksOTQgKzI5LDEwNyBAQAogICoKICAqLwogCi0KICNpbmNsdWRlIDxwdGhyZWFkLmg+
CiAjaW5jbHVkZSA8c3RkaW8uaD4KICNpbmNsdWRlIDxzdGRsaWIuaD4KICNpbmNsdWRlIDxzdGRp
bnQuaD4KICNpbmNsdWRlIDx1bmlzdGQuaD4KIAorI2luY2x1ZGUgInRlc3QuaCIKKyNpbmNsdWRl
ICJ1c2N0ZXN0LmgiCisKK2NoYXIgKlRDSUQgPSAib3BlbmZpbGUwMSI7CS8qIFRlc3QgcHJvZ3Jh
bSBpZGVudGlmaWVyLiAgICAqLworaW50IFRTVF9UT1RBTCA9IDE7CiAKICNkZWZpbmUgTUFYRklM
RVMgICAgICAgIDMyNzY4CiAjZGVmaW5lIE1BWFRIUkVBRFMgICAgICAxMAogCi0KIC8qIENvbnRy
b2wgU3RydWN0dXJlICovCiBzdHJ1Y3QgY2IgewogCXB0aHJlYWRfbXV0ZXhfdCBtOwotCXB0aHJl
YWRfY29uZF90ICBpbml0X2N2OwotCXB0aHJlYWRfY29uZF90ICB0aHJfY3Y7Ci0JaW50CQl0aHJf
c2xlZXBpbmc7CisJcHRocmVhZF9jb25kX3QgaW5pdF9jdjsKKwlwdGhyZWFkX2NvbmRfdCB0aHJf
Y3Y7CisJaW50IHRocl9zbGVlcGluZzsKIH0gYzsKIAotCiAvKiBHbG9iYWwgVmFyaWFibGVzICov
Ci1pbnQgICAgIG51bXRocmVhZHM9MTAsIG51bWZpbGVzPTEwOwotaW50ICAgICBkZWJ1Zz0wOwot
Y2hhciAqICBmaWxlbmFtZT0iRklMRVRPT1BFTiI7CitpbnQgbnVtdGhyZWFkcyA9IDEwLCBudW1m
aWxlcyA9IDEwOworaW50IGRlYnVnID0gMDsKK2NoYXIgKiBmaWxlbmFtZSA9ICJGSUxFVE9PUEVO
IjsKIAordm9pZCBzZXR1cCh2b2lkKQoreworCXRzdF90bXBkaXIoKTsKK30KIAotLyogUHJvY2Vk
dXJlcyAqLwotdm9pZCAqdGhyZWFkcyh2b2lkKiB0aHJlYWRfaWQpOwordm9pZCBjbGVhbnVwKHZv
aWQpCit7CisJdHN0X3JtZGlyKCk7CisJdHN0X2V4aXQoKTsKK30KIAogCisvKiBQcm9jZWR1cmVz
ICovCit2b2lkICp0aHJlYWRzKHZvaWQqIHRocmVhZF9pZCk7CiAKIC8qICoqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqCi0gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFJTiBQUk9DRURVUkUgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgKgotICAgKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiogKi8KKyAqICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFJTiBQUk9DRURVUkUgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKgorICoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqICovCiAKIGludCBtYWluKGludCBhcmdj
LCBjaGFyICphcmd2W10pCiB7Ci0JaW50IAkgICBpLG9wdCxiYWRvcHRzPTA7Ci0gICAgICAgIEZJ
TEUgCSAgICpmZDsKLQlwdGhyZWFkX3QgIHRoX2lkOwotCWNoYXIgICAgICAgbXNnWzgwXT0iIjsK
LSAgICAgICAgZXh0ZXJuIGNoYXIgKm9wdGFyZzsKLQotICAgICAgICB3aGlsZSgob3B0PWdldG9w
dChhcmdjLCBhcmd2LCAiZGY6dDpoIikpICE9IEVPRikgewotICAgICAgICAgIHN3aXRjaCgoY2hh
cikgb3B0KSB7Ci0gICAgICAgICAgICBjYXNlICdkJzoKLSAgICAgICAgICAgICAgZGVidWc9MTsK
LSAgICAgICAgICAgICAgYnJlYWs7Ci0gICAgICAgICAgICBjYXNlICdmJzoKLSAgICAgICAgICAg
ICAgbnVtZmlsZXM9YXRvaShvcHRhcmcpOwotICAgICAgICAgICAgICBpZihudW1maWxlcyA8PSAw
KQotICAgICAgICAgICAgICAgIGJhZG9wdHM9MTsKLSAgICAgICAgICAgICAgYnJlYWs7Ci0gICAg
ICAgICAgICBjYXNlICd0JzoKLSAgICAgICAgICAgICAgbnVtdGhyZWFkcz1hdG9pKG9wdGFyZyk7
Ci0gICAgICAgICAgICAgIGlmKG51bXRocmVhZHMgPD0gMCkKLSAgICAgICAgICAgICAgICBiYWRv
cHRzPTE7Ci0gICAgICAgICAgICAgIGJyZWFrOwotICAgICAgICAgICAgY2FzZSAnaCc6Ci0gICAg
ICAgICAgICBkZWZhdWx0OgotICAgICAgICAgICAgICBwcmludGYoIlVzYWdlOiBvcGVuZmlsZSBb
LWRdIC1mIEZJTEVTIC10IFRIUkVBRFNcbiIpOwotICAgICAgIAkgICAgICBfZXhpdCgxKTsKLSAg
ICAgICAgICB9Ci0gICAgICAgIH0KLSAgICAgICAgaWYoYmFkb3B0cykgewotICAgICAgICAgIHBy
aW50ZigiVXNhZ2U6IG9wZW5maWxlIFstZF0gLWYgRklMRVMgLXQgVEhSRUFEU1xuIik7Ci0gICAg
ICAgCSAgX2V4aXQoMSk7Ci0gICAgICAgIH0KLQotICAgIAkvKiBDaGVjayBpZiBudW10aHJlYWRz
IGlzIGxlc3MgdGhhbiBNQVhGSUxFUyAqLwotICAgIAlpZiAoIG51bWZpbGVzID4gTUFYRklMRVMg
KXsKLSAgICAgICAgICAJc3ByaW50Zihtc2csIiVzXG5DYW5ub3QgdXNlICVkIGZpbGVzIiwgbXNn
LCBudW1maWxlcyk7Ci0gICAgICAgICAgCXNwcmludGYobXNnLCIlcywgdXNlZCAlZCBmaWxlcyBp
bnN0ZWFkXG4iLCBtc2csIE1BWEZJTEVTKTsKLSAgICAgICAgICAJbnVtZmlsZXMgPSBNQVhGSUxF
UzsKLSAgICAJfQotCi0gICAgCS8qIENoZWNrIGlmIG51bXRocmVhZHMgaXMgbGVzcyB0aGFuIE1B
WFRIUkVBRFMgKi8KLSAgICAJaWYgKCBudW10aHJlYWRzID4gTUFYVEhSRUFEUyApewotICAgICAg
ICAgIAlzcHJpbnRmKG1zZywiJXNcbkNhbm5vdCB1c2UgJWQgdGhyZWFkcyIsIG1zZywgbnVtdGhy
ZWFkcyk7Ci0gICAgICAgICAgCXNwcmludGYobXNnLCIlcywgdXNlZCAlZCB0aHJlYWRzIGluc3Rl
YWRcbiIsIG1zZywgTUFYVEhSRUFEUyk7Ci0gICAgICAgICAgCW51bXRocmVhZHMgPSBNQVhUSFJF
QURTOworCWludCBpLCBvcHQsIGJhZG9wdHMgPSAwOworCUZJTEUgKmZkOworCXB0aHJlYWRfdCB0
aF9pZDsKKwljaGFyIG1zZ1s4MF0gPSAiIjsKKwlleHRlcm4gY2hhciAqb3B0YXJnOworCisJd2hp
bGUgKChvcHQgPSBnZXRvcHQoYXJnYywgYXJndiwgImRmOnQ6aCIpKSAhPSBFT0YpIHsKKwkJc3dp
dGNoICgoY2hhcikgb3B0KSB7CisJCWNhc2UgJ2QnOgorCQkJZGVidWcgPSAxOworCQkJYnJlYWs7
CisJCWNhc2UgJ2YnOgorCQkJbnVtZmlsZXMgPSBhdG9pKG9wdGFyZyk7CisJCQlpZiAobnVtZmls
ZXMgPD0gMCkKKwkJCQliYWRvcHRzID0gMTsKKwkJCWJyZWFrOworCQljYXNlICd0JzoKKwkJCW51
bXRocmVhZHMgPSBhdG9pKG9wdGFyZyk7CisJCQlpZiAobnVtdGhyZWFkcyA8PSAwKQorCQkJCWJh
ZG9wdHMgPSAxOworCQkJYnJlYWs7CisJCWNhc2UgJ2gnOgorCQlkZWZhdWx0OgorCQkJcHJpbnRm
KCJVc2FnZTogb3BlbmZpbGUgWy1kXSAtZiBGSUxFUyAtdCBUSFJFQURTXG4iKTsKKwkJCV9leGl0
KDEpOworCQl9CisJfQorCWlmIChiYWRvcHRzKSB7CisJCXByaW50ZigiVXNhZ2U6IG9wZW5maWxl
IFstZF0gLWYgRklMRVMgLXQgVEhSRUFEU1xuIik7CisJCV9leGl0KDEpOworCX0KKworCXNldHVw
KCk7CisKKwkvKiBDaGVjayBpZiBudW10aHJlYWRzIGlzIGxlc3MgdGhhbiBNQVhGSUxFUyAqLwor
CWlmIChudW1maWxlcyA+IE1BWEZJTEVTKSB7CisJCXNwcmludGYobXNnLCAiJXNcbkNhbm5vdCB1
c2UgJWQgZmlsZXMiLCBtc2csIG51bWZpbGVzKTsKKwkJc3ByaW50Zihtc2csICIlcywgdXNlZCAl
ZCBmaWxlcyBpbnN0ZWFkXG4iLCBtc2csIE1BWEZJTEVTKTsKKwkJbnVtZmlsZXMgPSBNQVhGSUxF
UzsKKwl9CisKKwkvKiBDaGVjayBpZiBudW10aHJlYWRzIGlzIGxlc3MgdGhhbiBNQVhUSFJFQURT
ICovCisJaWYgKG51bXRocmVhZHMgPiBNQVhUSFJFQURTKSB7CisJCXNwcmludGYobXNnLCAiJXNc
bkNhbm5vdCB1c2UgJWQgdGhyZWFkcyIsIG1zZywgbnVtdGhyZWFkcyk7CisJCXNwcmludGYobXNn
LCAiJXMsIHVzZWQgJWQgdGhyZWFkcyBpbnN0ZWFkXG4iLCBtc2csIE1BWFRIUkVBRFMpOworCQlu
dW10aHJlYWRzID0gTUFYVEhSRUFEUzsKIAl9CiAKIAkvKiBDcmVhdGUgZmlsZXMgKi8KLQlpZiAo
KGZkPWZvcGVuKGZpbGVuYW1lLCJ3IikpID09IE5VTEwpewotCQlwZXJyb3IgKCJGQUlMIC0gQ291
bGQgbm90IGNyZWF0ZSBmaWxlIik7Ci0JCV9leGl0KDEpOworCWlmICgoZmQgPSBmb3BlbihmaWxl
bmFtZSwgInciKSkgPT0gTlVMTCkgeworCQl0c3RfcmVzbShURkFJTCwgIkNvdWxkIG5vdCBjcmVh
dGUgZmlsZSIpOworCQljbGVhbnVwKCk7CiAJfQogCiAJLyogSW5pdGlhbGl6ZSB0aHJlYWQgY29u
dHJvbCB2YXJpYWJsZXMsIGxvY2sgJiBjb25kaXRpb24gKi8KQEAgLTEyNiwxMjAgKzEzOSwxMjYg
QEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAljLnRocl9zbGVlcGluZyA9IDA7
CiAKIAkvKiBHcmFiIG11dGV4IGxvY2sgKi8KLQlpZiAocHRocmVhZF9tdXRleF9sb2NrKCZjLm0p
KXsKLQkJcGVycm9yKCJGQUlMIC0gZmFpbGVkIHRvIGdyYWIgbXV0ZXggbG9jayIpOworCWlmIChw
dGhyZWFkX211dGV4X2xvY2soJmMubSkpIHsKKwkJdHN0X3Jlc20oVEZBSUwsICJmYWlsZWQgdG8g
Z3JhYiBtdXRleCBsb2NrIik7CiAJCWZjbG9zZShmZCk7CiAJCXVubGluayhmaWxlbmFtZSk7Ci0J
CV9leGl0KDEpOworCQljbGVhbnVwKCk7CiAJfQogCiAJcHJpbnRmKCJDcmVhdGluZyBSZWFkaW5n
IFRocmVhZHNcbiIpOwogCiAJLyogQ3JlYXRlIHRocmVhZHMgKi8KLQlmb3IgKGk9MDsgaTxudW10
aHJlYWRzOyBpKyspCi0JCWlmIChwdGhyZWFkX2NyZWF0ZSgmdGhfaWQsIChwdGhyZWFkX2F0dHJf
dCAqKU5VTEwsIHRocmVhZHMsCi0JCQkJKHZvaWQgKikodWludHB0cl90KWkpKSB7Ci0JCQlwZXJy
b3IoIkZBSUwgLSBmYWlsZWQgY3JlYXRpbmcgYSBwdGhyZWFkOyBpbmNyZWFzZSBsaW1pdHMiKTsK
Kwlmb3IgKGkgPSAwOyBpIDwgbnVtdGhyZWFkczsgaSsrKQorCQlpZiAocHRocmVhZF9jcmVhdGUo
JnRoX2lkLCAocHRocmVhZF9hdHRyX3QgKikgTlVMTCwgdGhyZWFkcywKKwkJCQkodm9pZCAqKSAo
dWludHB0cl90KSBpKSkgeworCQkJdHN0X3Jlc20oVEZBSUwsICJmYWlsZWQgY3JlYXRpbmcgYSBw
dGhyZWFkOyBpbmNyZWFzZSBsaW1pdHMiKTsKIAkJCWZjbG9zZShmZCk7CiAJCQl1bmxpbmsoZmls
ZW5hbWUpOwotCQkJX2V4aXQoMSk7CisJCQljbGVhbnVwKCk7CiAJCX0KIAogCS8qIFNsZWVwIHVu
dGlsIGFsbCB0aHJlYWRzIGFyZSBjcmVhdGVkICovCiAJd2hpbGUgKGMudGhyX3NsZWVwaW5nICE9
IG51bXRocmVhZHMpCi0JCWlmIChwdGhyZWFkX2NvbmRfd2FpdCgmYy5pbml0X2N2LCAmYy5tKSl7
Ci0JCQlwZXJyb3IoIkZBSUwgLSBlcnJvciB3aGlsZSB3YWl0aW5nIGZvciByZWFkaW5nIHRocmVh
ZHMiKTsKKwkJaWYgKHB0aHJlYWRfY29uZF93YWl0KCZjLmluaXRfY3YsICZjLm0pKSB7CisJCQl0
c3RfcmVzbShURkFJTCwgImVycm9yIHdoaWxlIHdhaXRpbmcgZm9yIHJlYWRpbmcgdGhyZWFkcyIp
OwogCQkJZmNsb3NlKGZkKTsKIAkJCXVubGluayhmaWxlbmFtZSk7Ci0JCQlfZXhpdCgxKTsKKwkJ
CWNsZWFudXAoKTsKIAkJfQogCiAJLyogV2FrZSB1cCBhbGwgdGhyZWFkcyAqLwotCWlmIChwdGhy
ZWFkX2NvbmRfYnJvYWRjYXN0KCZjLnRocl9jdikpewotCQlwZXJyb3IoIkZBSUwgLSBmYWlsZWQg
dHJ5aW5nIHRvIHdha2UgdXAgcmVhZGluZyB0aHJlYWRzIik7CisJaWYgKHB0aHJlYWRfY29uZF9i
cm9hZGNhc3QoJmMudGhyX2N2KSkgeworCQl0c3RfcmVzbShURkFJTCwgImZhaWxlZCB0cnlpbmcg
dG8gd2FrZSB1cCByZWFkaW5nIHRocmVhZHMiKTsKIAkJZmNsb3NlKGZkKTsKIAkJdW5saW5rKGZp
bGVuYW1lKTsKLQkJX2V4aXQoMSk7CisJCWNsZWFudXAoKTsKIAl9CiAJLyogUmVsZWFzZSBtdXRl
eCBsb2NrICovCiAJaWYgKHB0aHJlYWRfbXV0ZXhfdW5sb2NrKCZjLm0pKSB7Ci0JCXBlcnJvcigi
RkFJTCAtIGZhaWxlZCB0byByZWxlYXNlIG11dGV4IGxvY2siKTsKKwkJdHN0X3Jlc20oVEZBSUws
ICJmYWlsZWQgdG8gcmVsZWFzZSBtdXRleCBsb2NrIik7CiAJCWZjbG9zZShmZCk7CiAJCXVubGlu
ayhmaWxlbmFtZSk7Ci0JCV9leGl0KDEpOworCQljbGVhbnVwKCk7CiAJfQogCi0gICAgICAgIHBy
aW50ZigiUEFTUyAtIFRocmVhZHMgYXJlIGRvbmUgcmVhZGluZ1xuIik7CisJdHN0X3Jlc20oVFBB
U1MsICJUaHJlYWRzIGFyZSBkb25lIHJlYWRpbmciKTsKIAotICAgIAlwcmludGYoIiVzIiwgbXNn
KTsKIAlmY2xvc2UoZmQpOwogCXVubGluayhmaWxlbmFtZSk7CisJY2xlYW51cCgpOwogCV9leGl0
KDApOwogfQogCi0KLQogLyogKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKLSAgICoJCQkJT1RIRVIgUFJPQ0VE
VVJFUwkJCSAgICAqCi0gICAqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiAqLworICoJCQkJT1RIRVIgUFJPQ0VE
VVJFUwkJCSAgICAqCisgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiogKi8KKwordm9pZCBjbG9zZV9maWxlcyhG
SUxFICpmZF9saXN0W10sIGludCBsZW4pIHsKKwlpbnQgaTsKKwlmb3IgKGkgPSAwOyBpIDwgbGVu
OyBpKyspIHsKKwkJZmNsb3NlKGZkX2xpc3RbaV0pOworCX0KK30KIAogLyogdGhyZWFkczogRWFj
aCB0aHJlYWQgb3BlbnMgdGhlIGZpbGVzIHNwZWNpZmllZCAqLwotdm9pZCAqIHRocmVhZHModm9p
ZCogdGhyZWFkX2lkXykKLXsKLSAgaW50IHRocmVhZF9pZD0odWludHB0cl90KXRocmVhZF9pZF87
Ci0gICAgCWNoYXIgIGVycm1zZ1s4MF07Ci0gICAgICAgIEZJTEUgICpmZDsKLQlpbnQgICBpOwot
Ci0gICAgCS8qIE9wZW4gZmlsZXMgKi8KLSAgICAJZm9yIChpPTA7IGk8bnVtZmlsZXM7IGkrKykg
ewotICAgICAgICAgICAgICAgIGlmKGRlYnVnKQotICAgICAgIAkJICBwcmludGYoIlRocmVhZCAg
JWQgOiBPcGVuaW5nIGZpbGUgbnVtYmVyICVkIFxuIiwgdGhyZWFkX2lkLCBpKTsKLSAgICAgICAJ
CWlmICgoZmQgPSBmb3BlbihmaWxlbmFtZSwicnciKSkgPT0gTlVMTCkgewotICAgICAgICAgIAkJ
c3ByaW50ZihlcnJtc2csIkZBSUwgLSBDb3VsZG4ndCBvcGVuIGZpbGUgIyVkIixpKTsKLSAgICAg
ICAgICAJCXBlcnJvcihlcnJtc2cpOwordm9pZCAqIHRocmVhZHModm9pZCogdGhyZWFkX2lkXykg
eworCWludCB0aHJlYWRfaWQgPSAodWludHB0cl90KSB0aHJlYWRfaWRfOworCWNoYXIgZXJybXNn
WzgwXTsKKwlGSUxFICpmZF9saXN0W01BWEZJTEVTXTsKKwlpbnQgaTsKKworCS8qIE9wZW4gZmls
ZXMgKi8KKwlmb3IgKGkgPSAwOyBpIDwgbnVtZmlsZXM7IGkrKykgeworCQlpZiAoZGVidWcpCisJ
CQlwcmludGYoIlRocmVhZCAgJWQgOiBPcGVuaW5nIGZpbGUgbnVtYmVyICVkIFxuIiwgdGhyZWFk
X2lkLCBpKTsKKwkJaWYgKChmZF9saXN0W2ldID0gZm9wZW4oZmlsZW5hbWUsICJydyIpKSA9PSBO
VUxMKSB7CisJCQlzcHJpbnRmKGVycm1zZywgIkZBSUwgLSBDb3VsZG4ndCBvcGVuIGZpbGUgIyVk
IiwgaSk7CisJCQlwZXJyb3IoZXJybXNnKTsKKwkJCWlmIChpID4gMCkgeworCQkJCWNsb3NlX2Zp
bGVzKGZkX2xpc3QsIGktMSk7CisJCQl9CiAJCQl1bmxpbmsoZmlsZW5hbWUpOwotCQkJcHRocmVh
ZF9leGl0KCh2b2lkKikxKTsKLSAgICAgICAJCX0KLSAgICAJfQorCQkJcHRocmVhZF9leGl0KCh2
b2lkKikgMSk7CisJCX0KKwl9CiAKIAkvKiBHcmFiIG11dGV4IGxvY2sgKi8KIAlpZiAocHRocmVh
ZF9tdXRleF9sb2NrKCZjLm0pKSB7CiAJCXBlcnJvcigiRkFJTCAtIGZhaWxlZCB0byBncmFiIG11
dGV4IGxvY2siKTsKLSAgICAgICAJCWZjbG9zZShmZCk7CisJCWNsb3NlX2ZpbGVzKGZkX2xpc3Qs
IG51bWZpbGVzKTsKIAkJdW5saW5rKGZpbGVuYW1lKTsKLQkJcHRocmVhZF9leGl0KCh2b2lkKikx
KTsKKwkJcHRocmVhZF9leGl0KCh2b2lkKikgMSk7CiAJfQogCiAJLyogQ2hlY2sgaWYgeW91IHNo
b3VsZCB3YWtlIHVwIG1haW4gdGhyZWFkICovCi0gICAgICAgIGlmICgrK2MudGhyX3NsZWVwaW5n
ID09IG51bXRocmVhZHMpCi0gICAgICAgICAgICAgICAgaWYgKHB0aHJlYWRfY29uZF9zaWduYWwo
JmMuaW5pdF9jdikpeworCWlmICgrK2MudGhyX3NsZWVwaW5nID09IG51bXRocmVhZHMpCisJCWlm
IChwdGhyZWFkX2NvbmRfc2lnbmFsKCZjLmluaXRfY3YpKSB7CiAJCQlwZXJyb3IoIkZBSUwgLSBm
YWlsZWQgdG8gc2lnbmFsIG1haW4gdGhyZWFkIik7Ci0gICAgICAgCQkJZmNsb3NlKGZkKTsKKwkJ
CWNsb3NlX2ZpbGVzKGZkX2xpc3QsIG51bWZpbGVzKTsKIAkJCXVubGluayhmaWxlbmFtZSk7Ci0J
CQlwdGhyZWFkX2V4aXQoKHZvaWQqKTEpOworCQkJcHRocmVhZF9leGl0KCh2b2lkKikgMSk7CiAJ
CX0KIAogCS8qIFNsZWVwIHVudGlsIHdva2VuIHVwICovCi0gICAgICAgIGlmIChwdGhyZWFkX2Nv
bmRfd2FpdCgmYy50aHJfY3YsICZjLm0pKXsKKwlpZiAocHRocmVhZF9jb25kX3dhaXQoJmMudGhy
X2N2LCAmYy5tKSkgewogCQlwZXJyb3IoIkZBSUwgLSBmYWlsZWQgdG8gd2FrZSB1cCBjb3JyZWN0
bHkiKTsKLSAgICAgICAJCWZjbG9zZShmZCk7CisJCWNsb3NlX2ZpbGVzKGZkX2xpc3QsIG51bWZp
bGVzKTsKIAkJdW5saW5rKGZpbGVuYW1lKTsKLQkJcHRocmVhZF9leGl0KCh2b2lkKikxKTsKKwkJ
cHRocmVhZF9leGl0KCh2b2lkKikgMSk7CiAJfQogCiAJLyogUmVsZWFzZSBtdXRleCBsb2NrICov
Ci0gICAgICAgIGlmIChwdGhyZWFkX211dGV4X3VubG9jaygmYy5tKSl7CisJaWYgKHB0aHJlYWRf
bXV0ZXhfdW5sb2NrKCZjLm0pKSB7CiAJCXBlcnJvcigiRkFJTCAtIGZhaWxlZCB0byByZWxlYXNl
IG11dGV4IGxvY2siKTsKLSAgICAgICAJCWZjbG9zZShmZCk7CisJCWNsb3NlX2ZpbGVzKGZkX2xp
c3QsIG51bWZpbGVzKTsKIAkJdW5saW5rKGZpbGVuYW1lKTsKLQkJcHRocmVhZF9leGl0KCh2b2lk
KikxKTsKKwkJcHRocmVhZF9leGl0KCh2b2lkKikgMSk7CiAJfQogCi0JLyogQ2xvc2UgZmlsZSBh
bmQgZXhpdCAqLwotICAgICAgIAlmY2xvc2UoZmQpOworCS8qIENsb3NlIGZpbGUgaGFuZGxlcyBh
bmQgZXhpdCAqLworCWNsb3NlX2ZpbGVzKGZkX2xpc3QsIG51bWZpbGVzKTsKIAl1bmxpbmsoZmls
ZW5hbWUpOwotICAgICAgICBwdGhyZWFkX2V4aXQoKHZvaWQqKTApOworCXB0aHJlYWRfZXhpdCgo
dm9pZCopIDApOwogfQogCi0K

------_=_NextPart_001_01CA4C75.709E5941
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
------_=_NextPart_001_01CA4C75.709E5941
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------_=_NextPart_001_01CA4C75.709E5941--

