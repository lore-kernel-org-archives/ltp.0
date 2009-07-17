Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <fhe@novell.com>) id 1MRfBU-0002Eo-Fn
	for ltp-list@lists.sourceforge.net; Fri, 17 Jul 2009 04:36:36 +0000
Received: from [61.14.130.200] (helo=hefan.site)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MRfBK-0005OJ-Go
	for ltp-list@lists.sourceforge.net; Fri, 17 Jul 2009 04:36:36 +0000
From: hefan <fhe@novell.com>
Content-Type: multipart/mixed; boundary="=-biQhncsb+PC4n+s4Y1m4"
Date: Fri, 17 Jul 2009 12:07:30 +0800
Message-Id: <1247803650.4917.12.camel@hefan.site>
Mime-Version: 1.0
Subject: [LTP]   [PATCH 1/1] openposix_mmap_11_4
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
To: ltp-list@lists.sf.net


--=-biQhncsb+PC4n+s4Y1m4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

hi,

*[Patch 1/1] Patch for fixing the =EF=BB=BFfailed =EF=BB=BFtestcase openpos=
ix_mmap_11_4

-modified the file
*testcases/open_posix_testsuite/conformance/interfaces/=EF=BB=BFmmap/11-4.c


---
ltp.orig/testcases/open_posix_testsuite/conformance/interfaces/mmap/11-4.c	=
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

--=-biQhncsb+PC4n+s4Y1m4
Content-Disposition: attachment; filename=open_posix_mmap_11-4.diff
Content-Type: text/x-patch; name=open_posix_mmap_11-4.diff; charset=UTF-8
Content-Transfer-Encoding: base64

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


--=-biQhncsb+PC4n+s4Y1m4
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
--=-biQhncsb+PC4n+s4Y1m4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-biQhncsb+PC4n+s4Y1m4--

