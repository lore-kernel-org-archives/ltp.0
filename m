Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <srikanth007m@gmail.com>) id 1ZKRTP-00018T-KX
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 13:32:43 +0000
Received: from mail-qg0-f47.google.com ([209.85.192.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZKRTK-0003WH-1g
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 13:32:43 +0000
Received: by qgeu79 with SMTP id u79so4180255qge.1
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Jul 2015 06:32:32 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 29 Jul 2015 19:02:32 +0530
Message-ID: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
From: "$rik@nth " <srikanth007m@gmail.com>
Subject: [LTP] LTP make failed
Reply-To: srikanth007m@gmail.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3064127519816786564=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3064127519816786564==
Content-Type: multipart/alternative; boundary=001a113b557a7789fc051c039e30

--001a113b557a7789fc051c039e30
Content-Type: text/plain; charset=UTF-8

Hi,

I am trying to cross compile LTP and observing some issue. Any help or
suggestions to overcome from these errors. TIA


make[1]: Entering directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/hugetlb/hugemmap'
make -C "/local/mnt2/workspace2/LTP/ltp-full-20150420/lib" -f
"/local/mnt2/workspace2/LTP/ltp-full-20150420/lib/Makefile" all
make[2]: Entering directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/lib'
make[3]: Entering directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/lib/tests'
make[3]: Nothing to be done for `all'.
make[3]: Leaving directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/lib/tests'
make[2]: Leaving directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/lib'
make -C ../../../../../testcases/kernel/mem/lib -f
"/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib/Makefile"
all
make[2]: Entering directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib'
make -C /local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib
-f
"/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib/Makefile"
all
make[3]: Entering directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib'
if [ -z "numa_helper.o" ] ; then \
                echo "Cowardly refusing to create empty archive"; \
                exit 1; \
        fi
arm-linux-gnueabi-ar -rc "lib/libipc_hugetlb.a" numa_helper.o
arm-linux-gnueabi-ar: lib/libipc_hugetlb.a: No such file or directory
make[3]: *** [lib/libipc_hugetlb.a] Error 1
make[3]: Leaving directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib'
make[2]: ***
[/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/lib/libkerntest.a]
Error 2
make[2]: Leaving directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib'
make[1]: *** [../../../../../testcases/kernel/mem/lib/libmem.a] Error 2
make[1]: Leaving directory
`/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/hugetlb/hugemmap'
make: *** [all] Error 2

Here the file is there "ib/libipc_hugetlb.a: No such file or directory" but
still it showing the error.

-- 
Thanks & Regards,
M.Srikanth Kumar.

--001a113b557a7789fc051c039e30
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,=C2=A0</div><div><br></div><div>I am trying to cro=
ss compile LTP and observing some issue. Any help or suggestions to overcom=
e from these errors. TIA</div><div><br></div><div><br></div><div>make[1]: E=
ntering directory `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/k=
ernel/mem/hugetlb/hugemmap&#39;</div><div>make -C &quot;/local/mnt2/workspa=
ce2/LTP/ltp-full-20150420/lib&quot; -f &quot;/local/mnt2/workspace2/LTP/ltp=
-full-20150420/lib/Makefile&quot; all</div><div>make[2]: Entering directory=
 `/local/mnt2/workspace2/LTP/ltp-full-20150420/lib&#39;</div><div>make[3]: =
Entering directory `/local/mnt2/workspace2/LTP/ltp-full-20150420/lib/tests&=
#39;</div><div>make[3]: Nothing to be done for `all&#39;.</div><div>make[3]=
: Leaving directory `/local/mnt2/workspace2/LTP/ltp-full-20150420/lib/tests=
&#39;</div><div>make[2]: Leaving directory `/local/mnt2/workspace2/LTP/ltp-=
full-20150420/lib&#39;</div><div>make -C ../../../../../testcases/kernel/me=
m/lib -f &quot;/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kerne=
l/mem/lib/Makefile&quot; all</div><div>make[2]: Entering directory `/local/=
mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/lib&#39;</div><d=
iv>make -C /local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/li=
b -f &quot;/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/li=
b/Makefile&quot; all</div><div>make[3]: Entering directory `/local/mnt2/wor=
kspace2/LTP/ltp-full-20150420/testcases/kernel/lib&#39;</div><div>if [ -z &=
quot;numa_helper.o&quot; ] ; then \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;Cowardly refusing to create empty ar=
chive&quot;; \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 exit 1; \</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 fi</div><div>arm-lin=
ux-gnueabi-ar -rc &quot;lib/libipc_hugetlb.a&quot; numa_helper.o</div><div>=
arm-linux-gnueabi-ar: lib/libipc_hugetlb.a: No such file or directory</div>=
<div>make[3]: *** [lib/libipc_hugetlb.a] Error 1</div><div>make[3]: Leaving=
 directory `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/l=
ib&#39;</div><div>make[2]: *** [/local/mnt2/workspace2/LTP/ltp-full-2015042=
0/testcases/kernel/lib/libkerntest.a] Error 2</div><div>make[2]: Leaving di=
rectory `/local/mnt2/workspace2/LTP/ltp-full-20150420/testcases/kernel/mem/=
lib&#39;</div><div>make[1]: *** [../../../../../testcases/kernel/mem/lib/li=
bmem.a] Error 2</div><div>make[1]: Leaving directory `/local/mnt2/workspace=
2/LTP/ltp-full-20150420/testcases/kernel/mem/hugetlb/hugemmap&#39;</div><di=
v>make: *** [all] Error 2</div><div><br></div><div>Here the file is there &=
quot;ib/libipc_hugetlb.a: No such file or directory&quot; but still it show=
ing the error.<br></div><div><br></div>-- <br><div class=3D"gmail_signature=
">Thanks &amp; Regards,<br>M.Srikanth Kumar.</div>
</div>

--001a113b557a7789fc051c039e30--


--===============3064127519816786564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============3064127519816786564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3064127519816786564==--

