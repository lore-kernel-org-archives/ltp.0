Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PLiZu-0004rr-7K
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 20:38:02 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLiZt-0007Gv-8h
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 20:38:02 +0000
Received: by wyb40 with SMTP id 40so1200936wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Nov 2010 12:37:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <986274267.439511290667178978.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <309535663.439391290666931720.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<986274267.439511290667178978.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Thu, 25 Nov 2010 12:37:54 -0800
Message-ID: <AANLkTi=762-J95=W86tW3WNHk+K8NFAnMq+i8WYsu7m4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix the SEGBUS signal error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zhouping Liu <zliu@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Nov 24, 2010 at 10:39 PM, Zhouping Liu <zliu@redhat.com> wrote:
> Hi,all
> when I run this test program :
> #./hugemmap04 -I 3600 -H /var/hugetlbfs
> I found it returned quickly.
> I used gdb=A0 tool to debug it, it returned error with the 'SEGBUS' signal
> error,
> and the error occurred in the 178 lines '*(int*)addr =3D 0;'.
> it's okay when I add this line
> write(fildes, "write some words to the TEMPFILE file\n",40);
> you can run this c program to find this error.
> $cat test.c
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <sys/mman.h>
> char * TEMPFILE=3D"mmapfile";
> int freepages =3D 0;
> int main()
> {
> =A0=A0=A0 long *addr;
> =A0=A0=A0 int fd;
> =A0=A0=A0 long long mapsize;
> =A0=A0=A0 if ((fd =3D open(TEMPFILE, O_RDWR | O_CREAT | O_TRUNC,0666)) < =
0) {
> =A0=A0=A0 =A0=A0=A0 printf("open error\n");
> =A0=A0=A0 =A0=A0=A0 return -2;
> =A0=A0=A0 }
> =A0=A0=A0 freepages =3D 100;
> =A0=A0=A0 mapsize =3D (long long)freepages * 2048 * 1024;
> =A0=A0=A0 printf("mapsize is %lld \n",mapsize);
> =A0=A0=A0 addr =3D (long *)mmap(NULL,mapsize, PROT_READ | PROT_WRITE, MAP=
_SHARED,
> fd,0);
> =A0=A0=A0 if (addr =3D=3D MAP_FAILED) {
> =A0=A0=A0 =A0=A0=A0 printf("mmap error\n");
> =A0=A0=A0 =A0=A0=A0 return -1;
> =A0=A0=A0 }
> =A0=A0=A0=A0 /*=A0 if you enable this line,there will be no error. */
> =A0=A0=A0 //write(fd,"I don't know\n",20);
> =A0=A0=A0 *(int *)addr =3D 0;
> =A0=A0=A0 sleep(10);
> =A0=A0=A0 close(fd);
> =A0=A0=A0 return 0;
> }
>
> $./test
> mapsize is 209715200
> Bus error (core dumped)
> $
>
> Signed-off-by: Zhouping Liu <zliu@redhat>
>
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> index 485b465..cc7b249 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c
> @@ -174,6 +174,8 @@ main(int ac, char **av)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 con=
tinue;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tst=
_resm(TPASS, "Succeeded mapping file using %d
> pages",freepages);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* th=
e write function just do initalization */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 write=
(fildes, "write some words to the TEMPFILE
> file\n",40);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* =
force to allocate page and change HugePages_Free
> */
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *(i=
nt*)addr =3D 0;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

    That doesn't make sense (this test is junk in its current form
anyhow, but your conclusion doesn't make sense regardless), in
particular because this logic has worked on a number of other
platforms and OSes before this.
    Please dig deeper to figure out what the real error is.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
