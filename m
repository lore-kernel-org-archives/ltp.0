Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ashagow@gmail.com>) id 1WpzC9-0005Pr-3M
	for ltp-list@lists.sourceforge.net; Thu, 29 May 2014 12:12:29 +0000
Received: from mail-we0-f177.google.com ([74.125.82.177])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WpzC7-0002CW-C3
	for ltp-list@lists.sourceforge.net; Thu, 29 May 2014 12:12:29 +0000
Received: by mail-we0-f177.google.com with SMTP id x48so283613wes.8
	for <ltp-list@lists.sourceforge.net>;
	Thu, 29 May 2014 05:12:21 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 29 May 2014 17:42:20 +0530
Message-ID: <CADqC_HoU+5qBqER44UzD-0mX=x-H8QP0zsTB3WMcH8kptLqHBg@mail.gmail.com>
From: Asha Gowda <ashagow@gmail.com>
Subject: [LTP] ltp for android
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1282211285044602916=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1282211285044602916==
Content-Type: multipart/alternative; boundary=f46d043be03845a83204fa88d763

--f46d043be03845a83204fa88d763
Content-Type: text/plain; charset=UTF-8

Hi ,
I am able to cross compile for android but not able to execute it on
android platform.
I if execute any of the binaries i am getting " no such file or directory"
I checked that the issue with dynamic linker :


readelf --program

Elf file type is EXEC (Executable file)
Entry point 0x87e8
There are 8 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  EXIDX          0x000a7c 0x00008a7c 0x00008a7c 0x00048 0x00048 R   0x4
  PHDR           0x000034 0x00008034 0x00008034 0x00100 0x00100 R E 0x4
  INTERP         0x000134 0x00008134 0x00008134 0x00013 0x00013 R   0x1
      [Requesting program interpreter: /lib/ld-linux.so.3]
  LOAD           0x000000 0x00008000 0x00008000 0x00ac8 0x00ac8 R E 0x8000
  LOAD           0x000ac8 0x00010ac8 0x00010ac8 0x00148 0x00158 RW  0x8000
  DYNAMIC        0x000ad4 0x00010ad4 0x00010ad4 0x000f0 0x000f0 RW  0x4
  NOTE           0x000148 0x00008148 0x00008148 0x00020 0x00020 R   0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10

Its taking default linker file as /lib/ld-linux, it should be
/system/bin/linker for android i guess.
Can someone suggest me hoe to change this.

Thanks,

--f46d043be03845a83204fa88d763
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi ,</div><div>I am able to cross compile for android=
 but not able to execute it on android platform.</div><div>I if execute any=
 of the binaries i am getting &quot; no such file or directory&quot;</div>
<div>I checked that the issue with dynamic linker :</div><div><br></div><di=
v><br></div><div>readelf --program</div><div><br></div><div>Elf file type i=
s EXEC (Executable file)</div><div>Entry point 0x87e8</div><div>There are 8=
 program headers, starting at offset 52</div>
<div><br></div><div>Program Headers:</div><div>=C2=A0 Type =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Offset =C2=A0 VirtAddr =C2=A0 PhysAddr =C2=A0 FileSiz =
MemSiz =C2=A0Flg Align</div><div>=C2=A0 EXIDX =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A00x000a7c 0x00008a7c 0x00008a7c 0x00048 0x00048 R =C2=A0 0x4</div><div=
>=C2=A0 PHDR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000034 0x00008034 0x00008=
034 0x00100 0x00100 R E 0x4</div>
<div>=C2=A0 INTERP =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000134 0x00008134 0x000081=
34 0x00013 0x00013 R =C2=A0 0x1</div><div>=C2=A0 =C2=A0 =C2=A0 [Requesting =
program interpreter: /lib/ld-linux.so.3]</div><div>=C2=A0 LOAD =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 0x000000 0x00008000 0x00008000 0x00ac8 0x00ac8 R E=
 0x8000</div>
<div>=C2=A0 LOAD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000ac8 0x00010ac8 0x0=
0010ac8 0x00148 0x00158 RW =C2=A00x8000</div><div>=C2=A0 DYNAMIC =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x000ad4 0x00010ad4 0x00010ad4 0x000f0 0x000f0 RW =C2=A00x=
4</div><div>=C2=A0 NOTE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x000148 0x00008=
148 0x00008148 0x00020 0x00020 R =C2=A0 0x4</div>
<div>=C2=A0 GNU_STACK =C2=A0 =C2=A0 =C2=A00x000000 0x00000000 0x00000000 0x=
00000 0x00000 RW =C2=A00x10</div><div><br></div><div>Its taking default lin=
ker file as /lib/ld-linux, it should be /system/bin/linker for android i gu=
ess.</div><div>Can someone suggest me hoe to change this.</div>
<div><br></div><div>Thanks,</div></div>

--f46d043be03845a83204fa88d763--


--===============1282211285044602916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
--===============1282211285044602916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1282211285044602916==--

