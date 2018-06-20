From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 20 Jun 2018 02:41:06 -0400 (EDT)
Subject: [LTP] LTP cve-2017-5754 meltdown intermittent failure on
 mainline kernel
In-Reply-To: <CA+G9fYv8iPW3vtntqtatTLesf+StRkcP7AixVMPmEOSjTTtAwA@mail.gmail.com>
References: <CA+G9fYv8iPW3vtntqtatTLesf+StRkcP7AixVMPmEOSjTTtAwA@mail.gmail.com>
Message-ID: <2065442299.27693421.1529476866329.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it



----- Original Message -----
> LTP cve-2017-5754 meltdown test failed intermittently on qemu_x86_64
> running mainline kernel. Not easy to reproduce.

This has been reported by Li couple weeks back:
  http://lists.linux.it/pipermail/ltp/2018-April/007893.html

Conclusion at the time was we need to improve the testcase
to cope with 8c06c774 (x86/pti: Leave kernel text global for !PCID)=E2=80=
=8B.

>=20
> Linux kernel version: 4.18.0-rc1
> qemu-system-x86 version: 2.12
>=20
> Test output:
> tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
> meltdown.c:259: INFO:
>  access time: cached =3D 48, uncached =3D 378, threshold =3D 134
> meltdown.c:309: INFO: linux_proc_banner is at ffffffffaac00020
> meltdown.c:332: INFO: read ffffffffaac00020 =3D 0x21 !
> meltdown.c:332: INFO: read ffffffffaac00021 =3D 0x73 s
> meltdown.c:332: INFO: read ffffffffaac00022 =3D 0x20
> meltdown.c:332: INFO: read ffffffffaac00023 =3D 0x76 v
> meltdown.c:332: INFO: read ffffffffaac00024 =3D 0x5
> meltdown.c:332: INFO: read ffffffffaac00025 =3D 0x72 r
> meltdown.c:332: INFO: read ffffffffaac00026 =3D 0x53 S
> meltdown.c:332: INFO: read ffffffffaac00027 =3D 0x69 i
> meltdown.c:332: INFO: read ffffffffaac00028 =3D 0x61 a
> meltdown.c:332: INFO: read ffffffffaac00029 =3D 0x6e n
> meltdown.c:332: INFO: read ffffffffaac0002a =3D 0x20
> meltdown.c:332: INFO: read ffffffffaac0002b =3D 0x25 %
> meltdown.c:332: INFO: read ffffffffaac0002c =3D 0x73 s
> meltdown.c:342: FAIL: I was able to read your kernel memory!!!
> Summary:
> passed   0
> failed   1
> skipped  0
> warnings 0
>=20
> Failed full log can be found here in these links,
> https://lkft.validation.linaro.org/scheduler/job/261698#L8280
> https://lkft.validation.linaro.org/scheduler/job/290417#L10464
>=20
> Best regards
> Naresh Kamboju
>=20
