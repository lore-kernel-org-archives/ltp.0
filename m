Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oqhig-0005F0-Kh
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 07:26:54 +0000
Received: from mail-bw0-f46.google.com ([209.85.214.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oqhif-0001eH-Eq
	for ltp-list@lists.sourceforge.net; Wed, 01 Sep 2010 07:26:54 +0000
MIME-Version: 1.0
In-Reply-To: <1283219506.1778.2.camel@PEK-RLIANG-D1>
References: <1282116783.4855.8.camel@PEK-RLIANG-D1>
	<AANLkTikrFeTSbiWY4EhotU7siB_vw8hVF_FWtSNREr8x@mail.gmail.com>
	<1283219506.1778.2.camel@PEK-RLIANG-D1>
Date: Wed, 1 Sep 2010 00:26:47 -0700
Message-ID: <AANLkTin=MTu4QGB-+zyYQh=qMLprgjx6txisF4r_5xPT@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=001636c5a522cfa3ac048f2d9e83
Subject: Re: [LTP] [Patch] Fix mtest06 failure: caught unexpected signal -
 11 --- exiting
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
To: renxiu liang <renxiu.liang@windriver.com>
Cc: ltp-list@lists.sf.net

--001636c5a522cfa3ac048f2d9e83
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 30, 2010 at 6:51 PM, renxiu liang
<renxiu.liang@windriver.com> wrote:
> On Wed, 2010-08-25 at 20:36 -0700, Garrett Cooper wrote:
>> On Wed, Aug 18, 2010 at 12:33 AM, renxiu liang
>> <renxiu.liang@windriver.com> wrote:
>> > Hi,
>> >
>> > We met the mtest06 failure several times; this is because in
>> > mtest06/mmap1.c, when handling the signal 11 in sig_handler, it doesn'=
t
>> > cover another two race conditions:
>> > one is si_code equals "SEGV_MAPERR" but si_address does not equal to
>> > map_address; and one is si_code equals to "SEGV_ACCERR";
>> >
>> > see below error log:
>> >
>> > <<<test_start>>>
>> > tag=3Dmtest06 stime=3D1270902396
>> > cmdline=3D" =A0mmap1 -x 0.05"
>> > contacts=3D""
>> > analysis=3Dexit
>> > initiation_status=3D"ok"
>> > <<<test_output>>>
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0pid[5456]: map, change contents, u=
nmap files
>> > 1000 times
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0created thread[1216369840]
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0pid[5456] - read contents of memor=
y 0x48002000
>> > 1000 times
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>> > ......
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>> > mmap1 =A0 =A0 =A0 0 =A0INFO =A0: =A0page fault occurred at 0x48002000
>> > caught unexpected signal - 11 --- exiting
>> > <<<execution_status>>>
>> > duration=3D1 termination_type=3Dexited termination_id=3D255 corefile=
=3Dno
>> > cutime=3D0 cstime=3D4
>> > <<<test_end>>>
>> >
>> > I made a patch to cover all the three race conditions in one case in
>> > sig_handler(),
>> > then run mtest06 repeatedly on different archs, test will not fail by
>> > catching signal 11.
>>
>> Could you print out what the value of info->si_code and info->si_addr
>> are at the time of the fault? Also, which architecture(s) are you
>> running into this issue on?
> Hi Garrett,
>
> Sorry for the late reply; See attached mtest06 logs, I printed out the
> values of si_code, si_addr, map_address;
> it is reproducible on arm, x86, ppc and mips; though it is not
> reproducible every time, but can be reproducible if run the case
> repeatedly.

Nothing is jumping out at me as being incorrect, so I think it's best
that I bring in a better pair of eyes, just in case.

Suzuki-san,
    Could you please help review this patch?
Thanks!
-Garrett

--001636c5a522cfa3ac048f2d9e83
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-Fix-sig_handler-for-SIGSEGV-in-mmap1.c.patch"
Content-Disposition: attachment; 
	filename="0001-Fix-sig_handler-for-SIGSEGV-in-mmap1.c.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdjv52x11

RnJvbSBjYjNhMzAzMmFjZjgxOGE2OWU2ZDdiZDAyOGQ0YjBjOTI3YjBmYWM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogUmVueGl1IExpYW5nIDxyZW54aXUubGlhbmdAd2luZHJpdmVy
LmNvbT4NCkRhdGU6IE1vbiwgMTYgQXVnIDIwMTAgMTk6NTc6NTQgLTA3MDANClN1YmplY3Q6IFtQ
QVRDSCAxLzFdIEZpeCBzaWdfaGFuZGxlcigpIGZvciBTSUdTRUdWIGluIG1tYXAxLmMNCg0KIm10
ZXN0MDYiIGlzIGFpbWVkIGF0IHN0cmVzc2luZyB0aGUgbWVtb3J5IG1hbmFnZXIgYnkgc2ltdWx0
YW5pb3VzDQptYXAvdW5tYXAvcmVhZCBieSBsaWdodCB3ZWlnaHQgcHJvY2Vzc2VzOyBpdCB0cmll
cyB0byBoYW5kbGUNClNJR1NFR1Ygc2lnbmFsIGluIHNpZ19oYW5kbGVyIGluc3RlYWQgb2YgZG9p
bmcgc3luY2hyb25pemF0aW9ucw0KYmV0d2VlbiByZWFkIGFuZCB3cml0ZSB0aHJlYWRzOyB0d28g
bW9yZSByYWNlIGNvbmRpdGlvbnMgYXJlDQpub3QgY292ZXJlZDogb25lIGlzIHNpX2NvZGUgZXF1
YWxzICJTRUdWX01BUEVSUiIgYnV0IHNpX2FkZHJlc3MNCmRvZXMgbm90IGVxdWFsIHRvIG1hcF9h
ZGRyZXNzOyB0aGUgb3RoZXIgaXMgc2lfY29kZSBlcXVhbHMgdG8NCiJTRUdWX0FDQ0VSUiI7IHRy
eSB0byBjb3ZlciB0aGUgdGhyZWUgY29uZGl0aW9ucyBpbiBvbmUgY2FzZQ0KdG8gcmVkdWNlIHRo
ZSBjb21wbGV4aXR5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSZW54aXUgTGlhbmcgPHJlbnhpdS5saWFu
Z0B3aW5kcml2ZXIuY29tPg0KLS0tDQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vbXRlc3QwNi9tbWFw
MS5jIHwgICAgOCArKy0tLS0tLQ0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbXRlc3Qw
Ni9tbWFwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbXRlc3QwNi9tbWFwMS5jDQppbmRleCA0
N2FiNDlhLi43ZWIzNTQ3IDEwMDY0NA0KLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbXRlc3Qw
Ni9tbWFwMS5jDQorKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9tdGVzdDA2L21tYXAxLmMNCkBA
IC0xNjgsMTQgKzE2OCwxMCBAQCBzaWdfaGFuZGxlcihpbnQgc2lnbmFsLAkJLyogc2lnbmFsIG51
bWJlciwgc2V0IHRvIGhhbmRsZSBTSUdBTFJNICAgICAgICovDQogICAgICAgICAgICAgIF9leGl0
KDApOw0KIA0KICAgICAgICAgY2FzZSBTSUdTRUdWOg0KLSAgICAgICAgICAgICBpZiAoaW5mby0+
c2lfY29kZSA9PSBTRUdWX01BUEVSUiAmJg0KLSAgICAgICAgICAgICAgICAgICAgICBpbmZvLT5z
aV9hZGRyID09IG1hcF9hZGRyZXNzKQ0KLSAgICAgICAgICAgICB7DQotICAgICAgICAgICAgICAg
ICAgdHN0X3Jlc20oVElORk8sDQorICAgICAgICAgICAgIHRzdF9yZXNtKFRJTkZPLA0KICAgICAg
ICAgICAgICAgICAgICAgInBhZ2UgZmF1bHQgb2NjdXJyZWQgYXQgJXAiLA0KICAgICAgICAgICAg
ICAgICAgICAgbWFwX2FkZHJlc3MpOw0KLSAgICAgICAgICAgICAgICAgIGxvbmdqbXAoam1wYnVm
LCAxKTsNCi0gICAgICAgICAgICAgfQ0KKyAgICAgICAgICAgICBsb25nam1wKGptcGJ1ZiwgMSk7
DQogICAgICAgICBkZWZhdWx0Og0KICAgICAgICAgICAgIGZwcmludGYoc3RkZXJyLCAiY2F1Z2h0
IHVuZXhwZWN0ZWQgc2lnbmFsIC0gJWQgLS0tIGV4aXRpbmdcbiIsDQogICAgICAgICAgICAgICAg
ICAgICAgc2lnbmFsKTsNCi0tIA0KMS42LjENCg0K
--001636c5a522cfa3ac048f2d9e83
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
--001636c5a522cfa3ac048f2d9e83
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001636c5a522cfa3ac048f2d9e83--

