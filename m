Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <fhe@novell.com>) id 1MRh5N-0006aW-Uq
	for ltp-list@lists.sourceforge.net; Fri, 17 Jul 2009 06:38:25 +0000
Received: from [61.14.130.200] (helo=hefan.site)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MRh5H-0005SD-99
	for ltp-list@lists.sourceforge.net; Fri, 17 Jul 2009 06:38:25 +0000
From: hefan <fhe@novell.com>
In-Reply-To: <364299f40907162234g1df374d4xda8a74bf61f34057@mail.gmail.com>
References: <1247803650.4917.12.camel@hefan.site>
	<364299f40907162234g1df374d4xda8a74bf61f34057@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-Aqndgeq4V3MveLUgWY9/"
Date: Fri, 17 Jul 2009 14:37:55 +0800
Message-Id: <1247812675.4917.14.camel@hefan.site>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/1] openposix_mmap_11_4
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
Cc: ltp-list@lists.sf.net


--=-Aqndgeq4V3MveLUgWY9/
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=EF=BB=BFhi,

*[Patch 1/1] Patch for fixing the =EF=BB=BFfailed =EF=BB=BFtestcase openpos=
ix_mmap_11_4

-modified the file
*testcases/open_posix_testsuite/conformance/interfaces/=EF=BB=BFmmap/11-4.c


=EF=BB=BFSigned-off-by:  fredrick he <fhe@novell.com>

---
ltp.orig/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c =
     2009-07-17 11:53:36.000000000 +0800
+++
ltp/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c
2009-07-17 11:57:09.000000000 +0800
@@ -130,7 +130,9 @@ int main()
   flag =3D MAP_SHARED;=20
   off =3D 0;=20
   pa =3D mmap(addr, len, prot, flag, fd_2, off);
-  pa_2 =3D mmap(addr, len, prot, flag, fd_2, off);
+  addr =3D pa;
+  memset(addr,0,len*2);
+  pa_2 =3D mmap(addr, len, prot, flag|MAP_FIXED, fd_2, off);
   if (pa_2 =3D=3D MAP_FAILED)
   {
     printf("Test FAIL: " TNAME " Error at 2nd mmap(): %s\n",

--=20
=EF=BB=BF
Fan Fredrick He
R&D OPS QA Beijing PRC
=EF=BB=BFRoom 3603, Beijing Fortune Plaza, Office Tower A, No.7 Dongsanhuan=
 Zhonglu, Chaoyang District, Beijing, P.R., 100020
SUSE LINUX Products
fhe@novell.com
Mainland-Mobile (86) 13661278596

--=-Aqndgeq4V3MveLUgWY9/
Content-Disposition: attachment; filename=open_posix_mmap_11-4.diff
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=open_posix_mmap_11-4.diff; charset=utf-8

LS0tIGx0cC5vcmlnL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9p
bnRlcmZhY2VzL21tYXAvMTEtNC5jCTIwMDktMDctMTcgMTE6NTM6MzYuMDAwMDAwMDAwICswODAw
DQorKysgbHRwL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRl
cmZhY2VzL21tYXAvMTEtNC5jCTIwMDktMDctMTcgMTE6NTc6MDkuMDAwMDAwMDAwICswODAwDQpA
QCAtMTMwLDcgKzEzMCw5IEBAIGludCBtYWluKCkNCiAgIGZsYWcgPSBNQVBfU0hBUkVEOyANCiAg
IG9mZiA9IDA7IA0KICAgcGEgPSBtbWFwKGFkZHIsIGxlbiwgcHJvdCwgZmxhZywgZmRfMiwgb2Zm
KTsNCi0gIHBhXzIgPSBtbWFwKGFkZHIsIGxlbiwgcHJvdCwgZmxhZywgZmRfMiwgb2ZmKTsNCisg
IGFkZHIgPSBwYTsNCisgIG1lbXNldChhZGRyLDAsbGVuKjIpOw0KKyAgcGFfMiA9IG1tYXAoYWRk
ciwgbGVuLCBwcm90LCBmbGFnfE1BUF9GSVhFRCwgZmRfMiwgb2ZmKTsNCiAgIGlmIChwYV8yID09
IE1BUF9GQUlMRUQpDQogICB7DQogICAgIHByaW50ZigiVGVzdCBGQUlMOiAiIFROQU1FICIgRXJy
b3IgYXQgMm5kIG1tYXAoKTogJXNcbiIsDQo=


--=-Aqndgeq4V3MveLUgWY9/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--=-Aqndgeq4V3MveLUgWY9/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-Aqndgeq4V3MveLUgWY9/--

