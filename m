Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PLYIS-0002nD-1O
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 09:39:20 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLYIQ-00016Q-Pu
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 09:39:20 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oAP9dCsU012187
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Nov 2010 04:39:12 -0500
Date: Thu, 25 Nov 2010 04:39:12 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <866793969.448021290677952870.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <410759402.447991290677851090.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24725_771721000.1290677952869"
Subject: [LTP] [PATCH v2]fix a SEGBUS signal error about hugemmap
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
To: ltp-list@lists.sourceforge.net

------=_Part_24725_771721000.1290677952869
Content-Type: multipart/alternative; 
	boundary="----=_Part_24726_1661102767.1290677952869"

------=_Part_24726_1661102767.1290677952869
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,all 
when I run the below test program : 
#./hugemmap04 -I 3600 -H /var/hugetlbfs 
I found it returned quickly. 
I used gdb tool to debug it, it returned error with the 'SEGBUS' signal error, 
and the error occurred in the 178 lines '*(int*)addr = 0;'. 
it's okay when I add this line 
write(fildes, "write some words to the TEMPFILE file\n",40); 
you can run this c program to find the error : 
$ cat test.c 
#include <stdio.h> 
#include <stdlib.h> 
#include <fcntl.h> 
#include <sys/mman.h> 
char * TEMPFILE="mmapfile"; 
int freepages = 0; 
int main() 
{ 
long *addr; 
int fd; 
long long mapsize; 
if ((fd = open(TEMPFILE, O_RDWR | O_CREAT | O_TRUNC,00777)) < 0) { 
printf("open error\n"); 
return -2; 
} 
freepages = 100; 
mapsize =(long long)freepages * 2048 * 1024; 
printf("mapsize is %lld \n",mapsize); 
addr = (long *)mmap(NULL,mapsize, 
PROT_READ | PROT_WRITE, MAP_SHARED, fd,0); 
if (addr == MAP_FAILED) { 
printf("mmap error\n"); 
return -1; 
} 
/* if you enable this line,there will be no error. */ 
//write(fd,"just write some words.\n",20); 
*(int *)addr = 0; 
printf("Successfully!\n"); 
close(fd); 
return 0; 
} 
$./test 
mapsize is 209715200 
Bus error (core dumped) 

-------------------------------------------------------------------------------- 
v2: modified the patch's format 
Signed-off-by: Zhouping Liu < zliu@redhat.com > 
--- 
------=_Part_24726_1661102767.1290677952869
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
>Hi,all <br>when I run the below test program : <br>#./hugemmap04 -I 3600 -=
H /var/hugetlbfs <br>I found it returned quickly. <br>I used gdb tool to de=
bug it, it returned error with the 'SEGBUS' signal error, <br>and the error=
 occurred in the 178 lines '*(int*)addr =3D 0;'. <br>it's okay when I add t=
his line <br>write(fildes, "write some words to the TEMPFILE file\n",40); <=
br>you can run this c program to find the error :<br>$ cat test.c <br>#incl=
ude &lt;stdio.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;fcntl.h&gt=
;<br>#include &lt;sys/mman.h&gt;<br>char * TEMPFILE=3D"mmapfile";<br>int fr=
eepages =3D 0;<br>int main() <br>{<br>&nbsp;&nbsp;&nbsp; long *addr;<br>&nb=
sp;&nbsp;&nbsp; int fd;<br>&nbsp;&nbsp;&nbsp; long long mapsize;<br>&nbsp;&=
nbsp;&nbsp; if ((fd =3D open(TEMPFILE, O_RDWR | O_CREAT | O_TRUNC,00777)) &=
lt; 0) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("open error\n");<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -2;<br>&nbsp;&nbsp;&nbsp; }<=
br>&nbsp;&nbsp;&nbsp; freepages =3D 100;<br>&nbsp;&nbsp;&nbsp; mapsize =3D(=
long long)freepages * 2048 * 1024;<br>&nbsp;&nbsp;&nbsp; printf("mapsize is=
 %lld \n",mapsize);<br>&nbsp;&nbsp;&nbsp; addr =3D (long *)mmap(NULL,mapsiz=
e, <br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; PROT_READ |=
 PROT_WRITE, MAP_SHARED, fd,0);<br>&nbsp;&nbsp;&nbsp; if (addr =3D=3D MAP_F=
AILED) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("mmap error\n");<b=
r>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nbsp;&nbsp; } =
<br>&nbsp;&nbsp;&nbsp; /* if you enable this line,there will be no error. *=
/<br>&nbsp;&nbsp;&nbsp; //write(fd,"just write some words.\n",20);<br>&nbsp=
;&nbsp;&nbsp; *(int *)addr =3D 0;<br>&nbsp;&nbsp;&nbsp; printf("Successfull=
y!\n");<br>&nbsp;&nbsp;&nbsp; close(fd);<br>&nbsp;&nbsp;&nbsp; return 0;<br=
>}<br>$./test <br>mapsize is 209715200 <br>Bus error (core dumped) <br><br>=
---------------------------------------------------------------------------=
-----<br>v2: modified the patch's format <br>Signed-off-by: Zhouping Liu &l=
t;<a href=3D"mailto:zliu@redhat.com" target=3D"_blank">zliu@redhat.com</a>&=
gt;<br>---</div></body></html>
------=_Part_24726_1661102767.1290677952869--

------=_Part_24725_771721000.1290677952869
Content-Type: text/x-patch;
	name=0001-fix-a-SEGBUS-signal-error-about-hugemmap.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0001-fix-a-SEGBUS-signal-error-about-hugemmap.patch

From 81b15a0b8a4de0aab5a9b5e720522681b41c70ca Mon Sep 17 00:00:00 2001
From: Zhouping Liu <zliu@redhat.com>
Date: Thu, 25 Nov 2010 17:08:54 +0800
Subject: [PATCH] fix a SEGBUS signal error about hugemmap


Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
index 485b465..8ec984b 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
@@ -174,6 +174,8 @@ main(int ac, char **av)
 			continue;
 		} else {
 			tst_resm(TPASS, "Succeeded mapping file using %d pages",freepages);
+			/* the write function just do initialization */
+			write(fildes, " write some words to the TEMPFILE file\n",40);
 			/* force to allocate page and change HugePages_Free */
 			*(int*)addr = 0;
 		}
-- 
1.7.2.3


------=_Part_24725_771721000.1290677952869
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
------=_Part_24725_771721000.1290677952869
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_24725_771721000.1290677952869--

