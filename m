Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PLVUg-0004uA-9K
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 06:39:46 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLVUe-0005OF-Rq
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 06:39:46 +0000
Date: Thu, 25 Nov 2010 01:39:38 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <986274267.439511290667178978.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <309535663.439391290666931720.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix the SEGBUS signal error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2712023701731712302=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2712023701731712302==
Content-Type: multipart/alternative; 
	boundary="----=_Part_24187_1858774968.1290667178977"

------=_Part_24187_1858774968.1290667178977
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi,all 
when I run this test program : 
#./hugemmap04 -I 3600 -H /var/hugetlbfs 
I found it returned quickly. 
I used gdb tool to debug it, it returned error with the 'SEGBUS' signal error, 
and the error occurred in the 178 lines '*(int*)addr = 0;'. 
it's okay when I add this line 
write(fildes, "write some words to the TEMPFILE file\n",40); 
you can run this c program to find this error. 
$cat test.c 

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
if ((fd = open(TEMPFILE, O_RDWR | O_CREAT | O_TRUNC,0666)) < 0) { 
printf("open error\n"); 
return -2; 
} 
freepages = 100; 
mapsize = (long long)freepages * 2048 * 1024; 
printf("mapsize is %lld \n",mapsize); 
addr = (long *)mmap(NULL,mapsize, PROT_READ | PROT_WRITE, MAP_SHARED, fd,0); 
if (addr == MAP_FAILED) { 
printf("mmap error\n"); 
return -1; 
} 
/* if you enable this line,there will be no error. */ 
//write(fd,"I don't know\n",20); 
*(int *)addr = 0; 
sleep(10); 
close(fd); 
return 0; 
} 

$./test 
mapsize is 209715200 
Bus error (core dumped) 
$ 

Signed-off-by: Zhouping Liu < zliu@ redhat > 

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c 
index 485b465..cc7b249 100644 
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c 
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c 
@@ -174,6 +174,8 @@ main(int ac, char **av) 
continue; 
} else { 
tst_resm(TPASS, "Succeeded mapping file using %d pages",freepages); 
+ /* the write function just do initalization */ 
+ write(fildes, "write some words to the TEMPFILE file\n",40); 
/* force to allocate page and change HugePages_Free */ 
*(int*)addr = 0; 
} 


------=_Part_24187_1858774968.1290667178977
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: Times New Roman; font-size: 12pt; color: #000000'=
>Hi,all<br>when I run this test program :<br>#./hugemmap04 -I 3600 -H /var/=
hugetlbfs<br>I found it returned quickly.<br>I used gdb&nbsp; tool to debug=
 it, it returned error with the 'SEGBUS' signal error,<br>and the error occ=
urred in the 178 lines '*(int*)addr =3D 0;'.<br>it's okay when I add this l=
ine <br>write(fildes, "write some words to the TEMPFILE file\n",40);<br>you=
 can run this c program to find this error.<br>$cat test.c<br><br>#include =
&lt;stdio.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;fcntl.h&gt;<br=
>#include &lt;sys/mman.h&gt;<br>char * TEMPFILE=3D"mmapfile";<br>int freepa=
ges =3D 0;<br>int main() <br>{<br>&nbsp;&nbsp;&nbsp; long *addr;<br>&nbsp;&=
nbsp;&nbsp; int fd;<br>&nbsp;&nbsp;&nbsp; long long mapsize;<br>&nbsp;&nbsp=
;&nbsp; if ((fd =3D open(TEMPFILE, O_RDWR | O_CREAT | O_TRUNC,0666)) &lt; 0=
) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("open error\n");<br>&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -2;<br>&nbsp;&nbsp;&nbsp; }<br>&n=
bsp;&nbsp;&nbsp; freepages =3D 100;<br>&nbsp;&nbsp;&nbsp; mapsize =3D (long=
 long)freepages * 2048 * 1024;<br>&nbsp;&nbsp;&nbsp; printf("mapsize is %ll=
d \n",mapsize);<br>&nbsp;&nbsp;&nbsp; addr =3D (long *)mmap(NULL,mapsize, P=
ROT_READ | PROT_WRITE, MAP_SHARED, fd,0);<br>&nbsp;&nbsp;&nbsp; if (addr =
=3D=3D MAP_FAILED) {<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf("mmap =
error\n");<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -1;<br>&nbsp;&nb=
sp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp; /*&nbsp; if you enable this line,th=
ere will be no error. */<br>&nbsp;&nbsp;&nbsp; //write(fd,"I don't know\n",=
20);<br>&nbsp;&nbsp;&nbsp; *(int *)addr =3D 0;<br>&nbsp;&nbsp;&nbsp; sleep(=
10);<br>&nbsp;&nbsp;&nbsp; close(fd);<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<=
br><br>$./test <br>mapsize is 209715200 <br>Bus error (core dumped)<br>$<br=
><br>Signed-off-by: Zhouping Liu &lt;<span class=3D"Object" id=3D"OBJ_PREFI=
X_DWT574"><span class=3D"Object" id=3D"OBJ_PREFIX_DWT575">zliu@<span class=
=3D"Object" id=3D"OBJ_PREFIX_DWT621">redhat</span></span></span>&gt;<br><br=
>diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c b/testcase=
s/kernel/mem/hugetlb/hugemmap/hugemmap04.c<br>index 485b465..cc7b249 100644=
<br>--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c<br>+++ b/testc=
ases/kernel/mem/hugetlb/hugemmap/hugemmap04.c<br>@@ -174,6 +174,8 @@ main(i=
nt ac, char **av)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; continue;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_resm(TPASS, "Succeeded mapping =
file using %d pages",freepages);<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* the write function just do initalization */<br>+&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write(fildes, "write =
some words to the TEMPFILE file\n",40);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* force to allocate page and change HugePa=
ges_Free */<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *(int*)addr =3D 0;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br></div></body></html>
------=_Part_24187_1858774968.1290667178977--


--===============2712023701731712302==
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
--===============2712023701731712302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2712023701731712302==--

