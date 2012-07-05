Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Nitin.Yadav@mphasis.com>) id 1Smlkr-0004l4-7j
	for ltp-list@lists.sourceforge.net; Thu, 05 Jul 2012 13:05:57 +0000
Received: from mpmulip3.mphasis.com ([203.12.222.67])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Smlkh-0005Xd-Dw
	for ltp-list@lists.sourceforge.net; Thu, 05 Jul 2012 13:05:57 +0000
MIME-Version: 1.0
Content-class: urn:content-classes:message
Date: Thu, 5 Jul 2012 18:33:39 +0530
Message-ID: <E351E450E8B9F54684A699D42DC5ADF222597989@MPBAGVEX02.corp.mphasis.com>
From: "Nitin Yadav" <Nitin.Yadav@mphasis.com>
Subject: Re: [LTP] [PATCH] io_submit: uninitialized iocb may not
	return	-EINVAL
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0040896196461879376=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0040896196461879376==
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01CD5AAE.DF7208F2"
Content-class: urn:content-classes:message

This is a multi-part message in MIME format.

------_=_NextPart_001_01CD5AAE.DF7208F2
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi ,

 =


I getting below error because of io_submit return -1 EINVAL(after
appling the patch), while running the aio_tio in Linux 3.2 kernel.
 =


 ltp/testcases/kernel/io/aio/aio02# ./aio_tio

aio02/aio_tio    0  TINFO  :  Running test 1

 =


aio02/aio_tio    0  TINFO  :  Running test 2

 =


aio02/aio_tio    0  TINFO  :  Running test 3

 =


aio02/aio_tio    0  TINFO  :  Running test 4

 =


aio02/aio_tio    0  TINFO  :  Running test 5

 =


aio02/aio_tio    0  TINFO  :  Running test 6

 =


aio02/aio_tio    0  TINFO  :  Running test 7

 =


aio02/aio_tio    0  TINFO  :  myctx =3D 2843729920l

io_fsync write: Invalid argument

 =


while doing strace I came to know that io_submit returns -1 EINVAL,
please see the below trace for error(highlighted in RED) .

 =


ltp-full-20120614/testcases/kernel/io/aio/aio02# strace ./aio_tio

execve("./aio_tio", ["./aio_tio"], [/* 15 vars */]) =3D 0

brk(0)                                  =3D 0x1b0c000

access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or
directory)

mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x7fc145623000

access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or
directory)

open("/etc/ld.so.cache", O_RDONLY)      =3D 3

fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D30650, ...}) =3D 0

mmap(NULL, 30650, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7fc14561b000

close(3)                                =3D 0

access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or
directory)

open("/lib/libaio.so.1", O_RDONLY)      =3D 3

read(3,
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\300\5\0\0\0\0\0\0"...,
832) =3D 832

fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D4096, ...}) =3D 0

mmap(NULL, 2099936, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) =3D 0x7fc145207000

mprotect(0x7fc145208000, 2093056, PROT_NONE) =3D 0

mmap(0x7fc145407000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) =3D 0x7fc145407000

close(3)                                =3D 0

access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or
directory)

open("/lib/libc.so.6", O_RDONLY)        =3D 3

read(3,
"\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\240\355\1\0\0\0\0\0"...,
832) =3D 832

fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1437064, ...}) =3D 0

mmap(NULL, 3545160, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) =3D 0x7fc144ea5000

mprotect(0x7fc144ffe000, 2093056, PROT_NONE) =3D 0

mmap(0x7fc1451fd000, 20480, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x158000) =3D 0x7fc1451fd000

mmap(0x7fc145202000, 18504, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7fc145202000

close(3)                                =3D 0

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x7fc14561a000

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x7fc145619000

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x7fc145618000

arch_prctl(ARCH_SET_FS, 0x7fc145619700) =3D 0

mprotect(0x7fc1451fd000, 16384, PROT_READ) =3D 0

mprotect(0x7fc145625000, 4096, PROT_READ) =3D 0

munmap(0x7fc14561b000, 30650)           =3D 0

getpid()                                =3D 29055

mkdir("/tmp/aio12Pn7B", 0700)           =3D 0

brk(0)                                  =3D 0x1b0c000

brk(0x1b2d000)                          =3D 0x1b2d000

getgid()                                =3D 0

chown("/tmp/aio12Pn7B", 4294967295, 0)  =3D 0

chmod("/tmp/aio12Pn7B", 0777)           =3D 0

chdir("/tmp/aio12Pn7B")                 =3D 0

fstat(1, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(136, 2), ...}) =3D 0

mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x7fc145622000

write(1, "aio02/aio_tio    0  TINFO  :  Ru"..., 45aio02/aio_tio    0
TINFO  :  Running test 1

) =3D 45

write(1, "\n", 1

)                       =3D 1

open("file1", O_WRONLY|O_CREAT|O_TRUNC|O_DIRECT, 0644) =3D 3

io_setup(32, {140468069470208})         =3D 0

brk(0x1b5d000)                          =3D 0x1b5d000

brk(0x1b8d000)                          =3D 0x1b8d000

brk(0x1bae000)                          =3D 0x1bae000

brk(0x1bde000)                          =3D 0x1bde000

brk(0x1c0e000)                          =3D 0x1c0e000

brk(0x1c2f000)                          =3D 0x1c2f000

brk(0x1c5f000)                          =3D 0x1c5f000

brk(0x1c8f000)                          =3D 0x1c8f000

brk(0x1cb0000)                          =3D 0x1cb0000

brk(0x1ce0000)                          =3D 0x1ce0000

brk(0x1d10000)                          =3D 0x1d10000

brk(0x1d31000)                          =3D 0x1d31000

io_submit(140468069470208, 32, {...})   =3D 32

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 32

close(3)                                =3D 0

brk(0x1b2d000)                          =3D 0x1b2d000

io_destroy(140468069470208)             =3D 0

write(1, "aio02/aio_tio    0  TINFO  :  Ru"..., 46aio02/aio_tio    0
TINFO  :  Running test 2

 =


) =3D 46

open("file1", O_RDONLY|O_DIRECT)        =3D 3

io_setup(32, {140468069470208})         =3D 0

brk(0x1b5d000)                          =3D 0x1b5d000

brk(0x1b8d000)                          =3D 0x1b8d000

brk(0x1bae000)                          =3D 0x1bae000

brk(0x1bde000)                          =3D 0x1bde000

brk(0x1c0e000)                          =3D 0x1c0e000

brk(0x1c2f000)                          =3D 0x1c2f000

brk(0x1c5f000)                          =3D 0x1c5f000

brk(0x1c8f000)                          =3D 0x1c8f000

brk(0x1cb0000)                          =3D 0x1cb0000

brk(0x1ce0000)                          =3D 0x1ce0000

brk(0x1d10000)                          =3D 0x1d10000

brk(0x1d31000)                          =3D 0x1d31000

io_submit(140468069470208, 32, {...})   =3D 32

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 4

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 3

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 2

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 4

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 1

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 2

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 3

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 2

close(3)                                =3D 0

brk(0x1b2d000)                          =3D 0x1b2d000

io_destroy(140468069470208)             =3D 0

write(1, "aio02/aio_tio    0  TINFO  :  Ru"..., 46aio02/aio_tio    0
TINFO  :  Running test 3

 =


) =3D 46

open("file1", O_RDWR|O_TRUNC)           =3D 3

io_setup(32, {140468069470208})         =3D 0

brk(0x1b5d000)                          =3D 0x1b5d000

brk(0x1b8d000)                          =3D 0x1b8d000

brk(0x1bae000)                          =3D 0x1bae000

brk(0x1bde000)                          =3D 0x1bde000

brk(0x1c0e000)                          =3D 0x1c0e000

brk(0x1c2f000)                          =3D 0x1c2f000

brk(0x1c5f000)                          =3D 0x1c5f000

brk(0x1c8f000)                          =3D 0x1c8f000

brk(0x1cb0000)                          =3D 0x1cb0000

brk(0x1ce0000)                          =3D 0x1ce0000

brk(0x1d10000)                          =3D 0x1d10000

brk(0x1d31000)                          =3D 0x1d31000

io_submit(140468069470208, 32, {...})   =3D 32

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 32

close(3)                                =3D 0

brk(0x1b2d000)                          =3D 0x1b2d000

io_destroy(140468069470208)             =3D 0

write(1, "aio02/aio_tio    0  TINFO  :  Ru"..., 46aio02/aio_tio    0
TINFO  :  Running test 4

 =


) =3D 46

open("file1", O_RDWR)                   =3D 3

io_setup(32, {140468069470208})         =3D 0

brk(0x1b5d000)                          =3D 0x1b5d000

brk(0x1b8d000)                          =3D 0x1b8d000

brk(0x1bae000)                          =3D 0x1bae000

brk(0x1bde000)                          =3D 0x1bde000

brk(0x1c0e000)                          =3D 0x1c0e000

brk(0x1c2f000)                          =3D 0x1c2f000

brk(0x1c5f000)                          =3D 0x1c5f000

brk(0x1c8f000)                          =3D 0x1c8f000

brk(0x1cb0000)                          =3D 0x1cb0000

brk(0x1ce0000)                          =3D 0x1ce0000

brk(0x1d10000)                          =3D 0x1d10000

brk(0x1d31000)                          =3D 0x1d31000

io_submit(140468069470208, 32, {...})   =3D 32

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 32

close(3)                                =3D 0

brk(0x1b2d000)                          =3D 0x1b2d000

io_destroy(140468069470208)             =3D 0

write(1, "aio02/aio_tio    0  TINFO  :  Ru"..., 46aio02/aio_tio    0
TINFO  :  Running test 5

 =


) =3D 46

open("file1", O_WRONLY|O_TRUNC)         =3D 3

io_setup(32, {140468069470208})         =3D 0

brk(0x1b5d000)                          =3D 0x1b5d000

brk(0x1b8d000)                          =3D 0x1b8d000

brk(0x1bae000)                          =3D 0x1bae000

brk(0x1bde000)                          =3D 0x1bde000

brk(0x1c0e000)                          =3D 0x1c0e000

brk(0x1c2f000)                          =3D 0x1c2f000

brk(0x1c5f000)                          =3D 0x1c5f000

brk(0x1c8f000)                          =3D 0x1c8f000

brk(0x1cb0000)                          =3D 0x1cb0000

brk(0x1ce0000)                          =3D 0x1ce0000

brk(0x1d10000)                          =3D 0x1d10000

brk(0x1d31000)                          =3D 0x1d31000

io_submit(140468069470208, 32, {...})   =3D 32

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 32

close(3)                                =3D 0

brk(0x1b2d000)                          =3D 0x1b2d000

io_destroy(140468069470208)             =3D 0

write(1, "aio02/aio_tio    0  TINFO  :  Ru"..., 47aio02/aio_tio    0
TINFO  :  Running test 6

 =


) =3D 47

open("file1", O_RDONLY)                 =3D 3

io_setup(32, {140468069470208})         =3D 0

brk(0x1b5d000)                          =3D 0x1b5d000

brk(0x1b8d000)                          =3D 0x1b8d000

brk(0x1bae000)                          =3D 0x1bae000

brk(0x1bde000)                          =3D 0x1bde000

brk(0x1c0e000)                          =3D 0x1c0e000

brk(0x1c2f000)                          =3D 0x1c2f000

brk(0x1c5f000)                          =3D 0x1c5f000

brk(0x1c8f000)                          =3D 0x1c8f000

brk(0x1cb0000)                          =3D 0x1cb0000

brk(0x1ce0000)                          =3D 0x1ce0000

brk(0x1d10000)                          =3D 0x1d10000

brk(0x1d31000)                          =3D 0x1d31000

io_submit(140468069470208, 32, {...})   =3D 32

io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D 32

close(3)                                =3D 0

brk(0x1b2d000)                          =3D 0x1b2d000

io_destroy(140468069470208)             =3D 0

write(1, "aio02/aio_tio    0  TINFO  :  Ru"..., 47aio02/aio_tio    0
TINFO  :  Running test 7

 =


) =3D 47

open("file2", O_WRONLY|O_CREAT|O_TRUNC|O_DIRECT, 0644) =3D 3

io_setup(32, {140468069470208})         =3D 0

brk(0x1b5d000)                          =3D 0x1b5d000

brk(0x1b8d000)                          =3D 0x1b8d000

brk(0x1bae000)                          =3D 0x1bae000

brk(0x1bde000)                          =3D 0x1bde000

brk(0x1c0e000)                          =3D 0x1c0e000

brk(0x1c2f000)                          =3D 0x1c2f000

brk(0x1c5f000)                          =3D 0x1c5f000

brk(0x1c8f000)                          =3D 0x1c8f000

brk(0x1cb0000)                          =3D 0x1cb0000

brk(0x1ce0000)                          =3D 0x1ce0000

brk(0x1d10000)                          =3D 0x1d10000

brk(0x1d31000)                          =3D 0x1d31000

io_submit(140468069470208, 32, {...})   =3D 32

write(1, "aio02/aio_tio    0  TINFO  :  my"..., 50aio02/aio_tio    0
TINFO  :  myctx =3D 1164054528l

) =3D 50

io_submit(140468069470208, 1, {...})    =3D -1 EINVAL (Invalid argument)

write(2, "io_fsync write: Invalid argument"..., 33io_fsync write:
Invalid argument

) =3D 33

 =


Could you please suggest me some pointer .

 =


Thanks!

Nitin =



Information transmitted by this e-mail is proprietary to MphasiS, its assoc=
iated companies and/ or its customers and is intended =

for use only by the individual or entity to which it is addressed, and may =
contain information that is privileged, confidential or =

exempt from disclosure under applicable law. If you are not the intended re=
cipient or it appears that this mail has been forwarded =

to you without proper authority, you are notified that any use or dissemina=
tion of this information in any manner is strictly =

prohibited. In such cases, please notify us immediately at mailmaster@mphas=
is.com and delete this mail from your records.

------_=_NextPart_001_01CD5AAE.DF7208F2
MIME-Version: 1.0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:x=3D"urn:schemas-microsoft-com:office:excel" xmlns:p=3D"urn:schemas-m=
icrosoft-com:office:powerpoint" xmlns:a=3D"urn:schemas-microsoft-com:office=
:access" xmlns:dt=3D"uuid:C2F41010-65B3-11d1-A29F-00AA00C14882" xmlns:s=3D"=
uuid:BDC6E3F0-6DA3-11d1-A2A3-00AA00C14882" xmlns:rs=3D"urn:schemas-microsof=
t-com:rowset" xmlns:z=3D"#RowsetSchema" xmlns:b=3D"urn:schemas-microsoft-co=
m:office:publisher" xmlns:ss=3D"urn:schemas-microsoft-com:office:spreadshee=
t" xmlns:c=3D"urn:schemas-microsoft-com:office:component:spreadsheet" xmlns=
:odc=3D"urn:schemas-microsoft-com:office:odc" xmlns:oa=3D"urn:schemas-micro=
soft-com:office:activation" xmlns:html=3D"http://www.w3.org/TR/REC-html40" =
xmlns:q=3D"http://schemas.xmlsoap.org/soap/envelope/" xmlns:rtc=3D"http://m=
icrosoft.com/officenet/conferencing" xmlns:D=3D"DAV:" xmlns:Repl=3D"http://=
schemas.microsoft.com/repl/" xmlns:mt=3D"http://schemas.microsoft.com/share=
point/soap/meetings/" xmlns:x2=3D"http://schemas.microsoft.com/office/excel=
/2003/xml" xmlns:ppda=3D"http://www.passport.com/NameSpace.xsd" xmlns:ois=
=3D"http://schemas.microsoft.com/sharepoint/soap/ois/" xmlns:dir=3D"http://=
schemas.microsoft.com/sharepoint/soap/directory/" xmlns:ds=3D"http://www.w3=
.org/2000/09/xmldsig#" xmlns:dsp=3D"http://schemas.microsoft.com/sharepoint=
/dsp" xmlns:udc=3D"http://schemas.microsoft.com/data/udc" xmlns:xsd=3D"http=
://www.w3.org/2001/XMLSchema" xmlns:sub=3D"http://schemas.microsoft.com/sha=
repoint/soap/2002/1/alerts/" xmlns:ec=3D"http://www.w3.org/2001/04/xmlenc#"=
 xmlns:sp=3D"http://schemas.microsoft.com/sharepoint/" xmlns:sps=3D"http://=
schemas.microsoft.com/sharepoint/soap/" xmlns:xsi=3D"http://www.w3.org/2001=
/XMLSchema-instance" xmlns:udcs=3D"http://schemas.microsoft.com/data/udc/so=
ap" xmlns:udcxf=3D"http://schemas.microsoft.com/data/udc/xmlfile" xmlns:udc=
p2p=3D"http://schemas.microsoft.com/data/udc/parttopart" xmlns:wf=3D"http:/=
/schemas.microsoft.com/sharepoint/soap/workflow/" xmlns:dsss=3D"http://sche=
mas.microsoft.com/office/2006/digsig-setup" xmlns:dssi=3D"http://schemas.mi=
crosoft.com/office/2006/digsig" xmlns:mdssi=3D"http://schemas.openxmlformat=
s.org/package/2006/digital-signature" xmlns:mver=3D"http://schemas.openxmlf=
ormats.org/markup-compatibility/2006" xmlns:m=3D"http://schemas.microsoft.c=
om/office/2004/12/omml" xmlns:mrels=3D"http://schemas.openxmlformats.org/pa=
ckage/2006/relationships" xmlns:spwp=3D"http://microsoft.com/sharepoint/web=
partpages" xmlns:ex12t=3D"http://schemas.microsoft.com/exchange/services/20=
06/types" xmlns:ex12m=3D"http://schemas.microsoft.com/exchange/services/200=
6/messages" xmlns:pptsl=3D"http://schemas.microsoft.com/sharepoint/soap/Sli=
deLibrary/" xmlns:spsl=3D"http://microsoft.com/webservices/SharePointPortal=
Server/PublishedLinksService" xmlns:Z=3D"urn:schemas-microsoft-com:" xmlns:=
st=3D"&#1;" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.5pt;
	font-family:Consolas;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:Consolas;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal>Hi ,<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<pre><span style=3D'font-size:10.5pt;font-family:Consolas'>I getting below =
error because of io_submit return -1 EINVAL(after appling the patch), while=
 running the </span>aio_tio<span
style=3D'font-size:10.5pt;font-family:Consolas'> in Linux 3.2 kernel.<o:p><=
/o:p></span></pre><pre><o:p>&nbsp;</o:p></pre>

<p class=3DMsoNormal><b>&nbsp;ltp/testcases/kernel/io/aio/aio02# ./aio_tio<=
o:p></o:p></b></p>

<p class=3DMsoNormal>aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&=
nbsp;
Running test 1<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&=
nbsp;
Running test 2<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&=
nbsp;
Running test 3<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&=
nbsp;
Running test 4<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&=
nbsp;
Running test 5<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&=
nbsp;
Running test 6<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&=
nbsp;
Running test 7<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO &nbsp;:&=
nbsp;
myctx =3D 2843729920l<o:p></o:p></p>

<p class=3DMsoNormal>io_fsync write: Invalid argument<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>while doing strace I came to know that io_submit retur=
ns <span
style=3D'font-size:10.5pt;font-family:Consolas'>-1 EINVAL, please see the b=
elow
trace for error(highlighted in RED) .<o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.5pt;font-family:Consolas'>=
<o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><b>ltp-full-20120614/testcases/kernel/io/aio/aio02# st=
race
./aio_tio<o:p></o:p></b></p>

<p class=3DMsoNormal>execve(&quot;./aio_tio&quot;, [&quot;./aio_tio&quot;],=
 [/*
15 vars */]) =3D 0<o:p></o:p></p>

<p class=3DMsoNormal>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b0c000<o:p></o:p></p>

<p class=3DMsoNormal>access(&quot;/etc/ld.so.nohwcap&quot;,
F_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or director=
y)<o:p></o:p></p>

<p class=3DMsoNormal>mmap(NULL, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fc145623000<o:p></o:p></p>

<p class=3DMsoNormal>access(&quot;/etc/ld.so.preload&quot;,
R_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or director=
y)<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;/etc/ld.so.cache&quot;, O_RDONLY)&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;
=3D 3<o:p></o:p></p>

<p class=3DMsoNormal>fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D30650, ...=
}) =3D 0<o:p></o:p></p>

<p class=3DMsoNormal>mmap(NULL, 30650, PROT_READ, MAP_PRIVATE, 3, 0) =3D
0x7fc14561b000<o:p></o:p></p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>access(&quot;/etc/ld.so.nohwcap&quot;,
F_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or director=
y)<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;/lib/libaio.so.1&quot;,
O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3<o:p></o:p></p>

<p class=3DMsoNormal>read(3,
&quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\300\5\0\0\0\0\0\0&q=
uot;...,
832) =3D 832<o:p></o:p></p>

<p class=3DMsoNormal>fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D4096, ...}=
) =3D 0<o:p></o:p></p>

<p class=3DMsoNormal>mmap(NULL, 2099936, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7fc145207000<o:p></o:p></p>

<p class=3DMsoNormal>mprotect(0x7fc145208000, 2093056, PROT_NONE) =3D 0<o:p=
></o:p></p>

<p class=3DMsoNormal>mmap(0x7fc145407000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) =3D 0x7fc145407000<o:p></o:p></p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>access(&quot;/etc/ld.so.nohwcap&quot;,
F_OK)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file or director=
y)<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;/lib/libc.so.6&quot;,
O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3<o:p></o:p></p>

<p class=3DMsoNormal>read(3,
&quot;\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0&gt;\0\1\0\0\0\240\355\1\0\0\0\0\0=
&quot;...,
832) =3D 832<o:p></o:p></p>

<p class=3DMsoNormal>fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1437064, .=
..}) =3D 0<o:p></o:p></p>

<p class=3DMsoNormal>mmap(NULL, 3545160, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7fc144ea5000<o:p></o:p></p>

<p class=3DMsoNormal>mprotect(0x7fc144ffe000, 2093056, PROT_NONE) =3D 0<o:p=
></o:p></p>

<p class=3DMsoNormal>mmap(0x7fc1451fd000, 20480, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x158000) =3D 0x7fc1451fd000<o:p></=
o:p></p>

<p class=3DMsoNormal>mmap(0x7fc145202000, 18504, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7fc145202000<o:p></o:p></=
p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fc14561a000<o:p></o:p></p>

<p class=3DMsoNormal>mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fc145619000<o:p></o:p></p>

<p class=3DMsoNormal>mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fc145618000<o:p></o:p></p>

<p class=3DMsoNormal>arch_prctl(ARCH_SET_FS, 0x7fc145619700) =3D 0<o:p></o:=
p></p>

<p class=3DMsoNormal>mprotect(0x7fc1451fd000, 16384, PROT_READ) =3D 0<o:p><=
/o:p></p>

<p class=3DMsoNormal>mprotect(0x7fc145625000, 4096, PROT_READ) =3D 0<o:p></=
o:p></p>

<p class=3DMsoNormal>munmap(0x7fc14561b000,
30650)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:=
p></o:p></p>

<p class=3DMsoNormal>getpid()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 29055<o:p></o:p></p>

<p class=3DMsoNormal>mkdir(&quot;/tmp/aio12Pn7B&quot;,
0700)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:p=
></o:p></p>

<p class=3DMsoNormal>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b0c000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b2d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b2d000<o:p></o:p></p>

<p class=3DMsoNormal>getgid()&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>chown(&quot;/tmp/aio12Pn7B&quot;, 4294967295, 0)&nbsp;=
 =3D 0<o:p></o:p></p>

<p class=3DMsoNormal>chmod(&quot;/tmp/aio12Pn7B&quot;,
0777)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:p=
></o:p></p>

<p class=3DMsoNormal>chdir(&quot;/tmp/aio12Pn7B&quot;)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>fstat(1, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(13=
6, 2),
...}) =3D 0<o:p></o:p></p>

<p class=3DMsoNormal>mmap(NULL, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D 0x7fc145622000<o:p></o:p></p>

<p class=3DMsoNormal>write(1, &quot;aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Ru&quot;..., 45aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Running test 1<o:p></o:p></p>

<p class=3DMsoNormal>) =3D 45<o:p></o:p></p>

<p class=3DMsoNormal>write(1, &quot;\n&quot;, 1<o:p></o:p></p>

<p class=3DMsoNormal>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
=3D 1<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;file1&quot;, O_WRONLY|O_CREAT|O_TRUNC|O_DIR=
ECT,
0644) =3D 3<o:p></o:p></p>

<p class=3DMsoNormal>io_setup(32,
{140468069470208})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:=
p></o:p></p>

<p class=3DMsoNormal>brk(0x1b5d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b5d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b8d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b8d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bae000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D
0x1bae000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bde000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bde000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c0e000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c0e000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c2f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c2f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c5f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c5f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c8f000)&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D
0x1c8f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1cb0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1cb0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1ce0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1ce0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d10000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d10000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d31000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d31000<o:p></o:p></p>

<p class=3DMsoNormal>io_submit(140468069470208, 32, {...})&nbsp;&nbsp; =3D =
32<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 32<o:p></o:p></p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b2d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b2d000<o:p></o:p></p>

<p class=3DMsoNormal>io_destroy(140468069470208)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>write(1, &quot;aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Ru&quot;..., 46aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Running test 2<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>) =3D 46<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;file1&quot;,
O_RDONLY|O_DIRECT)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3<o:p></o:=
p></p>

<p class=3DMsoNormal>io_setup(32,
{140468069470208})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:=
p></o:p></p>

<p class=3DMsoNormal>brk(0x1b5d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b5d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b8d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b8d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bae000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bae000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bde000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bde000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c0e000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c0e000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c2f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c2f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c5f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c5f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c8f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c8f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1cb0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1cb0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1ce0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1ce0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d10000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d10000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d31000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d31000<o:p></o:p></p>

<p class=3DMsoNormal>io_submit(140468069470208, 32, {...})&nbsp;&nbsp; =3D =
32<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 4<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 3<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 2<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 4<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 1<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 2<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 3<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 2<o:p></o:p></p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b2d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b2d000<o:p></o:p></p>

<p class=3DMsoNormal>io_destroy(140468069470208)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>write(1, &quot;aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Ru&quot;..., 46aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Running test 3<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>) =3D 46<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;file1&quot;,
O_RDWR|O_TRUNC)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 3<o:p></o:p></p>

<p class=3DMsoNormal>io_setup(32,
{140468069470208})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:=
p></o:p></p>

<p class=3DMsoNormal>brk(0x1b5d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D
0x1b5d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b8d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b8d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bae000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bae000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bde000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bde000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c0e000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c0e000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c2f000)&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D
0x1c2f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c5f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c5f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c8f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c8f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1cb0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1cb0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1ce0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1ce0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d10000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d10000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d31000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d31000<o:p></o:p></p>

<p class=3DMsoNormal>io_submit(140468069470208, 32, {...})&nbsp;&nbsp; =3D =
32<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 32<o:p></o:p></p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b2d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D
0x1b2d000<o:p></o:p></p>

<p class=3DMsoNormal>io_destroy(140468069470208)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>write(1, &quot;aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Ru&quot;..., 46aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Running test 4<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>) =3D 46<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;file1&quot;,
O_RDWR)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 3<o:p></o:p></p>

<p class=3DMsoNormal>io_setup(32,
{140468069470208})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:=
p></o:p></p>

<p class=3DMsoNormal>brk(0x1b5d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b5d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b8d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b8d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bae000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bae000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bde000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bde000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c0e000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c0e000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c2f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c2f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c5f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c5f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c8f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c8f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1cb0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1cb0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1ce0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1ce0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d10000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d10000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d31000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d31000<o:p></o:p></p>

<p class=3DMsoNormal>io_submit(140468069470208, 32, {...})&nbsp;&nbsp; =3D =
32<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 32<o:p></o:p></p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b2d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b2d000<o:p></o:p></p>

<p class=3DMsoNormal>io_destroy(140468069470208)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>write(1, &quot;aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Ru&quot;..., 46aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Running test 5<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>) =3D 46<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;file1&quot;,
O_WRONLY|O_TRUNC)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3<o:p=
></o:p></p>

<p class=3DMsoNormal>io_setup(32,
{140468069470208})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:=
p></o:p></p>

<p class=3DMsoNormal>brk(0x1b5d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b5d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b8d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b8d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bae000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bae000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bde000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=3D
0x1bde000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c0e000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c0e000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c2f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c2f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c5f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c5f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c8f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c8f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1cb0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1cb0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1ce0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1ce0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d10000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d10000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d31000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d31000<o:p></o:p></p>

<p class=3DMsoNormal>io_submit(140468069470208, 32, {...})&nbsp;&nbsp; =3D =
32<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 32<o:p></o:p></p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b2d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b2d000<o:p></o:p></p>

<p class=3DMsoNormal>io_destroy(140468069470208)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>write(1, &quot;aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Ru&quot;..., 47aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Running test 6<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>) =3D 47<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;file1&quot;,
O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 3<o:p></o:p></p>

<p class=3DMsoNormal>io_setup(32,
{140468069470208})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:=
p></o:p></p>

<p class=3DMsoNormal>brk(0x1b5d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b5d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b8d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b8d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bae000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;=3D
0x1bae000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bde000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bde000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c0e000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c0e000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c2f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c2f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c5f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c5f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c8f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=3D
0x1c8f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1cb0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1cb0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1ce0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1ce0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d10000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d10000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d31000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d31000<o:p></o:p></p>

<p class=3DMsoNormal>io_submit(140468069470208, 32, {...})&nbsp;&nbsp; =3D =
32<o:p></o:p></p>

<p class=3DMsoNormal>io_getevents(140468069470208, 1, 32, {...}{30, 0}) =3D=
 32<o:p></o:p></p>

<p class=3DMsoNormal>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b2d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b2d000<o:p></o:p></p>

<p class=3DMsoNormal>io_destroy(140468069470208)&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0<o:p></o:p></p>

<p class=3DMsoNormal>write(1, &quot;aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Ru&quot;..., 47aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp;
TINFO&nbsp; :&nbsp; Running test 7<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>) =3D 47<o:p></o:p></p>

<p class=3DMsoNormal>open(&quot;file2&quot;, O_WRONLY|O_CREAT|O_TRUNC|O_DIR=
ECT,
0644) =3D 3<o:p></o:p></p>

<p class=3DMsoNormal>io_setup(32,
{140468069470208})&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0<o:=
p></o:p></p>

<p class=3DMsoNormal>brk(0x1b5d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b5d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1b8d000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1b8d000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bae000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bae000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1bde000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1bde000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c0e000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c0e000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c2f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c2f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c5f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c5f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1c8f000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1c8f000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1cb0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1cb0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1ce0000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1ce0000<o:p></o:p></p>

<p class=3DMsoNormal>brk(0x1d10000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d10000<o:p></o:p></p>

<p class=3DMsoNormal><b><span style=3D'color:red'>brk(0x1d31000)&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
=3D 0x1d31000<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'color:red'>io_submit(140468069470208=
, 32,
{...})&nbsp;&nbsp; =3D 32<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'color:red'>write(1,
&quot;aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; my&quot;.=
..,
50aio02/aio_tio&nbsp;&nbsp;&nbsp; 0&nbsp; TINFO&nbsp; :&nbsp; myctx =3D
1164054528l<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'color:red'>) =3D 50<o:p></o:p></span=
></b></p>

<p class=3DMsoNormal><b><span style=3D'color:red'>io_submit(140468069470208=
, 1,
{...})&nbsp;&nbsp;&nbsp; =3D -1 EINVAL (Invalid argument)<o:p></o:p></span>=
</b></p>

<p class=3DMsoNormal><b><span style=3D'color:red'>write(2, &quot;io_fsync w=
rite:
Invalid argument&quot;..., 33io_fsync write: Invalid argument<o:p></o:p></s=
pan></b></p>

<p class=3DMsoNormal>) =3D 33<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Could you please suggest me some pointer .<o:p></o:p><=
/p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks!<o:p></o:p></p>

<p class=3DMsoNormal>Nitin <o:p></o:p></p>

</div>

<p><br>
Information transmitted by this e-mail is proprietary to MphasiS, its assoc=
iated companies and/ or its customers and is intended <br>
for use only by the individual or entity to which it is addressed, and may =
contain information that is privileged, confidential or <br>
exempt from disclosure under applicable law. If you are not the intended re=
cipient or it appears that this mail has been forwarded <br>
to you without proper authority, you are notified that any use or dissemina=
tion of this information in any manner is strictly <br>
prohibited. In such cases, please notify us immediately at mailmaster@mphas=
is.com and delete this mail from your records.</p></body>

</html>

------_=_NextPart_001_01CD5AAE.DF7208F2--



--===============0040896196461879376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============0040896196461879376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0040896196461879376==--


