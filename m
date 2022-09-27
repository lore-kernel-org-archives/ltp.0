Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A90C6FA82
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 20:09:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89C8C3C8772
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 22:09:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DD503C1BBA
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 22:08:52 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A84651A009BB
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 22:08:51 +0200 (CEST)
Received: by mail-pj1-x102f.google.com with SMTP id cp18so1595330pjb.2
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=dyypxq8VM87sUimClP3YKbnshyjwztOj+Zla/7QZz6Q=;
 b=CKBmQNClt5gjCSygOVYirGeyRsDAr82iWFmgk6X8Oaijz/I6JKRYoup4kRgr7vMSH6
 2s/8GlCa/qrFCCtgormXfDZrLMJ+0iVRCKPmzoZkUwBPyAiJF1g8iSAna2QVS60i/6cf
 yBrqRNjZrzifky9+LYmoGWA68PbbQ9A2AqS+8XytvuADFKILMSn+2iPEOKp4GYvjJMcx
 hs57sODVxT+j+7YQDtDyflguW5wBzgUYZiU0ZpK6apo4WN1an8vF2utN32mxm9m2x/GT
 XvBSFQSDrQgfsBiiyCA2u89O+9FVdGG7sfqg/97IThWSF8CAiw0hywmPJNS7+HuNFfBv
 a3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=dyypxq8VM87sUimClP3YKbnshyjwztOj+Zla/7QZz6Q=;
 b=DeAg3XyDtWFwvdkidXBCUbbPUEMAo4i+qOc49v4WeP8wkBIuy2/kkEkBfqS9rwZkyN
 u6tu2Qv+compZdRlhoM0X0Ag72AdnGh1JdOTuRniEBgs3LxchcEjEolvFDmT/OK30j1X
 VU9uuuyrEBh2g7Q2KY5UU8FAxITUiWnEJec3eiPABFdhTOdEnpYRAlMPsTQ2bk0KtWQW
 B2Dy+Ptlg09IOESZASuzjypBvk1Te2iWRNzq3EtoeIOeLWLEVy+M7jFVg0LlkucZ5U2n
 gZ/svPHts5CLFrH5/3LU6Aj1VEyO2FUmtBBnuZ4f5U7vPQTH81N1F3GmGZBrB85+Bkoe
 SGbQ==
X-Gm-Message-State: ACrzQf1Pl+NZOVZ0jMMzoW3E1ydBb5d+PHT2N/AnYPtMoIiwkRQMYhdf
 0a5waVkIp3bgbXwLaED56+Fh6DZqb08Qb1KHavs=
X-Google-Smtp-Source: AMsMyM7XxQmDTPT7VXbS0bRhBFNCupee65b5QnC3NLzSF7tnZWFvnoC3CwnNQPX4pHsAIzHrEc0eolZg1tb1UDx0pVE=
X-Received: by 2002:a17:903:18b:b0:176:afb8:b4ab with SMTP id
 z11-20020a170903018b00b00176afb8b4abmr29209593plg.80.1664309329926; Tue, 27
 Sep 2022 13:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220926165949.23407-1-mpdesouza@suse.com>
 <YzH86TOjFZj3cUwq@pevik>
 <20220926221732.xj7mcxswq4dixzcd@daedalus> <YzKhupSYwltx6P3N@pevik>
 <20220927131003.zhhct3c37p35tlax@daedalus>
In-Reply-To: <20220927131003.zhhct3c37p35tlax@daedalus>
From: Petr Vorel <petr.vorel@gmail.com>
Date: Tue, 27 Sep 2022 22:08:38 +0200
Message-ID: <CAB1t1Cxw0g8LfTn=Ym0vbthXn2W=XCSnoEKZUQiArx4c0BWHcQ@mail.gmail.com>
To: Marcos Paulo de Souza <mpdesouza@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: Fix redefinition of mount_attr by
 checking sys/mount.h
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1250666328=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1250666328==
Content-Type: multipart/alternative; boundary="000000000000681d6105e9ae366b"

--000000000000681d6105e9ae366b
Content-Type: text/plain; charset="UTF-8"

Hi Marcos,

>
> My bad. I had this repository for some months already, I might have
> forgotten to
> run "make autotools"... it now build as expected. Thanks and sorry about
> the
> noise.
>
> No problem. But Buildroot CI reports similar problem, I wonder if I find
some time in my after work time to look into it
http://autobuild.buildroot.net/results/ef429f764d7b017b37e4a1216a2b7b325bc1ea73/build-end.log

Petr

In file included from
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/fs.h:19,
                 from ../../../../include/lapi/fs.h:10,
                 from statx09.c:24:
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:95:6:
error: redeclaration of 'enum fsconfig_command'
   95 | enum fsconfig_command {
      |      ^~~~~~~~~~~~~~~~
In file included from statx09.c:21:
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:249:6:
note: originally defined here
  249 | enum fsconfig_command
      |      ^~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:96:9:
error: redeclaration of enumerator 'FSCONFIG_SET_FLAG'
   96 |         FSCONFIG_SET_FLAG       = 0,    /* Set parameter, supplying
no value */
      |         ^~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:251:3:
note: previous definition of 'FSCONFIG_SET_FLAG' with type 'enum
fsconfig_command'
  251 |   FSCONFIG_SET_FLAG       = 0,    /* Set parameter, supplying no
value */
      |   ^~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:97:9:
error: redeclaration of enumerator 'FSCONFIG_SET_STRING'
   97 |         FSCONFIG_SET_STRING     = 1,    /* Set parameter, supplying
a string value */
      |         ^~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:253:3:
note: previous definition of 'FSCONFIG_SET_STRING' with type 'enum
fsconfig_command'
  253 |   FSCONFIG_SET_STRING     = 1,    /* Set parameter, supplying a
string value */
      |   ^~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:98:9:
error: redeclaration of enumerator 'FSCONFIG_SET_BINARY'
   98 |         FSCONFIG_SET_BINARY     = 2,    /* Set parameter, supplying
a binary blob value */
      |         ^~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:255:3:
note: previous definition of 'FSCONFIG_SET_BINARY' with type 'enum
fsconfig_command'
  255 |   FSCONFIG_SET_BINARY     = 2,    /* Set parameter, supplying a
binary blob value */
      |   ^~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:99:9:
error: redeclaration of enumerator 'FSCONFIG_SET_PATH'
   99 |         FSCONFIG_SET_PATH       = 3,    /* Set parameter, supplying
an object by path */
      |         ^~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:257:3:
note: previous definition of 'FSCONFIG_SET_PATH' with type 'enum
fsconfig_command'
  257 |   FSCONFIG_SET_PATH       = 3,    /* Set parameter, supplying an
object by path */
      |   ^~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:100:9:
error: redeclaration of enumerator 'FSCONFIG_SET_PATH_EMPTY'
  100 |         FSCONFIG_SET_PATH_EMPTY = 4,    /* Set parameter, supplying
an object by (empty) path */
      |         ^~~~~~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:259:3:
note: previous definition of 'FSCONFIG_SET_PATH_EMPTY' with type 'enum
fsconfig_command'
  259 |   FSCONFIG_SET_PATH_EMPTY = 4,    /* Set parameter, supplying an
object by (empty) path */
      |   ^~~~~~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:101:9:
error: redeclaration of enumerator 'FSCONFIG_SET_FD'
  101 |         FSCONFIG_SET_FD         = 5,    /* Set parameter, supplying
an object by fd */
      |         ^~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:261:3:
note: previous definition of 'FSCONFIG_SET_FD' with type 'enum
fsconfig_command'
  261 |   FSCONFIG_SET_FD         = 5,    /* Set parameter, supplying an
object by fd */
      |   ^~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:102:9:
error: redeclaration of enumerator 'FSCONFIG_CMD_CREATE'
  102 |         FSCONFIG_CMD_CREATE     = 6,    /* Invoke superblock
creation */
      |         ^~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:263:3:
note: previous definition of 'FSCONFIG_CMD_CREATE' with type 'enum
fsconfig_command'
  263 |   FSCONFIG_CMD_CREATE     = 6,    /* Invoke superblock creation */
      |   ^~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:103:9:
error: redeclaration of enumerator 'FSCONFIG_CMD_RECONFIGURE'
  103 |         FSCONFIG_CMD_RECONFIGURE = 7,   /* Invoke superblock
reconfiguration */
      |         ^~~~~~~~~~~~~~~~~~~~~~~~
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:265:3:
note: previous definition of 'FSCONFIG_CMD_RECONFIGURE' with type 'enum
fsconfig_command'
  265 |   FSCONFIG_CMD_RECONFIGURE = 7,   /* Invoke superblock
reconfiguration */
      |   ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/fs.h:19,
                 from ../../../../include/lapi/fs.h:10,
                 from statx09.c:24:
/home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:129:8:
error: redefinition of 'struct mount_attr'
  129 | struct mount_attr {
      |        ^~~~~~~~~~
In file included from statx09.c:21:
/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:219:8:
note: originally defined here
  219 | struct mount_attr
      |        ^~~~~~~~~~
../../../../include/mk/rules.mk:45: recipe for target 'statx09' failed
make[5]: *** [statx09] Error 1
../../../include/mk/generic_trunk_target.inc:108: recipe for target 'all'
failed
make[4]: *** [all] Error 2
../../include/mk/generic_trunk_target.inc:108: recipe for target 'all'
failed
make[3]: *** [all] Error 2
../include/mk/generic_trunk_target.inc:108: recipe for target 'all' failed
make[2]: *** [all] Error 2
make[2]: Leaving directory
'/home/buildroot/autobuild/instance-0/output-1/build/ltp-testsuite-20220527/testcases'
Makefile:106: recipe for target 'testcases-all' failed
make[1]: *** [testcases-all] Error 2
make[1]: Leaving directory
'/home/buildroot/autobuild/instance-0/output-1/build/ltp-testsuite-20220527'
package/pkg-generic.mk:290: recipe for target
'/home/buildroot/autobuild/instance-0/output-1/build/ltp-testsuite-20220527/.stamp_built'
failed
make: ***
[/home/buildroot/autobuild/instance-0/output-1/build/ltp-testsuite-20220527/.stamp_built]
Error 2
make: Leaving directory '/home/buildroot/autobuild/instance-0/buildroot'

--000000000000681d6105e9ae366b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi Marcos,=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
My bad. I had this repository for some months already, I might have forgott=
en to<br>
run &quot;make autotools&quot;... it now build as expected. Thanks and sorr=
y about the<br>
noise.<br>
<br></blockquote><div>No problem. But Buildroot CI reports similar problem,=
 I wonder if I find some time in my after work time to look into it</div><d=
iv><a href=3D"http://autobuild.buildroot.net/results/ef429f764d7b017b37e4a1=
216a2b7b325bc1ea73/build-end.log">http://autobuild.buildroot.net/results/ef=
429f764d7b017b37e4a1216a2b7b325bc1ea73/build-end.log</a><br></div><div><br>=
</div><div>Petr</div><div><br></div><div>In file included from /home/buildr=
oot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/=
usr/include/linux/fs.h:19,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0from ../../../../include/lapi/fs.h:10,<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from statx09.c:24:<br>/home=
/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/s=
ysroot/usr/include/linux/mount.h:95:6: error: redeclaration of &#39;enum fs=
config_command&#39;<br>=C2=A0 =C2=A095 | enum fsconfig_command {<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~<br>In file included fr=
om statx09.c:21:<br>/home/buildroot/autobuild/instance-0/output-1/host/lib/=
gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:249:6: not=
e: originally defined here<br>=C2=A0 249 | enum fsconfig_command<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~<br>/home/buildroot/aut=
obuild/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/inc=
lude/linux/mount.h:96:9: error: redeclaration of enumerator &#39;FSCONFIG_S=
ET_FLAG&#39;<br>=C2=A0 =C2=A096 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSCONFIG_SET_=
FLAG =C2=A0 =C2=A0 =C2=A0 =3D 0, =C2=A0 =C2=A0/* Set parameter, supplying n=
o value */<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~=
~~~~~~~<br>/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch=
64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:251:3: note: previo=
us definition of &#39;FSCONFIG_SET_FLAG&#39; with type &#39;enum fsconfig_c=
ommand&#39;<br>=C2=A0 251 | =C2=A0 FSCONFIG_SET_FLAG =C2=A0 =C2=A0 =C2=A0 =
=3D 0, =C2=A0 =C2=A0/* Set parameter, supplying no value */<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 ^~~~~~~~~~~~~~~~~<br>/home/buildroot/autobuild/instance=
-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/moun=
t.h:97:9: error: redeclaration of enumerator &#39;FSCONFIG_SET_STRING&#39;<=
br>=C2=A0 =C2=A097 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSCONFIG_SET_STRING =C2=A0=
 =C2=A0 =3D 1, =C2=A0 =C2=A0/* Set parameter, supplying a string value */<b=
r>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~<br=
>/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildro=
ot-linux-gnu/11.3.0/include-fixed/sys/mount.h:253:3: note: previous definit=
ion of &#39;FSCONFIG_SET_STRING&#39; with type &#39;enum fsconfig_command&#=
39;<br>=C2=A0 253 | =C2=A0 FSCONFIG_SET_STRING =C2=A0 =C2=A0 =3D 1, =C2=A0 =
=C2=A0/* Set parameter, supplying a string value */<br>=C2=A0 =C2=A0 =C2=A0=
 | =C2=A0 ^~~~~~~~~~~~~~~~~~~<br>/home/buildroot/autobuild/instance-0/outpu=
t-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:98:9=
: error: redeclaration of enumerator &#39;FSCONFIG_SET_BINARY&#39;<br>=C2=
=A0 =C2=A098 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSCONFIG_SET_BINARY =C2=A0 =C2=
=A0 =3D 2, =C2=A0 =C2=A0/* Set parameter, supplying a binary blob value */<=
br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~<b=
r>/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildr=
oot-linux-gnu/11.3.0/include-fixed/sys/mount.h:255:3: note: previous defini=
tion of &#39;FSCONFIG_SET_BINARY&#39; with type &#39;enum fsconfig_command&=
#39;<br>=C2=A0 255 | =C2=A0 FSCONFIG_SET_BINARY =C2=A0 =C2=A0 =3D 2, =C2=A0=
 =C2=A0/* Set parameter, supplying a binary blob value */<br>=C2=A0 =C2=A0 =
=C2=A0 | =C2=A0 ^~~~~~~~~~~~~~~~~~~<br>/home/buildroot/autobuild/instance-0=
/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/mount.=
h:99:9: error: redeclaration of enumerator &#39;FSCONFIG_SET_PATH&#39;<br>=
=C2=A0 =C2=A099 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSCONFIG_SET_PATH =C2=A0 =C2=
=A0 =C2=A0 =3D 3, =C2=A0 =C2=A0/* Set parameter, supplying an object by pat=
h */<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~=
~<br>/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-bui=
ldroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:257:3: note: previous def=
inition of &#39;FSCONFIG_SET_PATH&#39; with type &#39;enum fsconfig_command=
&#39;<br>=C2=A0 257 | =C2=A0 FSCONFIG_SET_PATH =C2=A0 =C2=A0 =C2=A0 =3D 3, =
=C2=A0 =C2=A0/* Set parameter, supplying an object by path */<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 ^~~~~~~~~~~~~~~~~<br>/home/buildroot/autobuild/instance=
-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/linux/moun=
t.h:100:9: error: redeclaration of enumerator &#39;FSCONFIG_SET_PATH_EMPTY&=
#39;<br>=C2=A0 100 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSCONFIG_SET_PATH_EMPTY =
=3D 4, =C2=A0 =C2=A0/* Set parameter, supplying an object by (empty) path *=
/<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~=
~~~~<br>/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-=
buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:259:3: note: previous =
definition of &#39;FSCONFIG_SET_PATH_EMPTY&#39; with type &#39;enum fsconfi=
g_command&#39;<br>=C2=A0 259 | =C2=A0 FSCONFIG_SET_PATH_EMPTY =3D 4, =C2=A0=
 =C2=A0/* Set parameter, supplying an object by (empty) path */<br>=C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~<br>/home/buildroot/autobuild=
/instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/l=
inux/mount.h:101:9: error: redeclaration of enumerator &#39;FSCONFIG_SET_FD=
&#39;<br>=C2=A0 101 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSCONFIG_SET_FD =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =3D 5, =C2=A0 =C2=A0/* Set parameter, supplying an obj=
ect by fd */<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~=
~~~~~~~<br>/home/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch=
64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:261:3: note: previo=
us definition of &#39;FSCONFIG_SET_FD&#39; with type &#39;enum fsconfig_com=
mand&#39;<br>=C2=A0 261 | =C2=A0 FSCONFIG_SET_FD =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =3D 5, =C2=A0 =C2=A0/* Set parameter, supplying an object by fd */<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~~~~~~~<br>/home/buildroot/autobuild/=
instance-0/output-1/host/aarch64-buildroot-linux-gnu/sysroot/usr/include/li=
nux/mount.h:102:9: error: redeclaration of enumerator &#39;FSCONFIG_CMD_CRE=
ATE&#39;<br>=C2=A0 102 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSCONFIG_CMD_CREATE =
=C2=A0 =C2=A0 =3D 6, =C2=A0 =C2=A0/* Invoke superblock creation */<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~<br>/hom=
e/buildroot/autobuild/instance-0/output-1/host/lib/gcc/aarch64-buildroot-li=
nux-gnu/11.3.0/include-fixed/sys/mount.h:263:3: note: previous definition o=
f &#39;FSCONFIG_CMD_CREATE&#39; with type &#39;enum fsconfig_command&#39;<b=
r>=C2=A0 263 | =C2=A0 FSCONFIG_CMD_CREATE =C2=A0 =C2=A0 =3D 6, =C2=A0 =C2=
=A0/* Invoke superblock creation */<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~=
~~~~~~~~~~~~~<br>/home/buildroot/autobuild/instance-0/output-1/host/aarch64=
-buildroot-linux-gnu/sysroot/usr/include/linux/mount.h:103:9: error: redecl=
aration of enumerator &#39;FSCONFIG_CMD_RECONFIGURE&#39;<br>=C2=A0 103 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FSCONFIG_CMD_RECONFIGURE =3D 7, =C2=A0 /* Invok=
e superblock reconfiguration */<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~<br>/home/buildroot/autobuild/instance-0=
/output-1/host/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys=
/mount.h:265:3: note: previous definition of &#39;FSCONFIG_CMD_RECONFIGURE&=
#39; with type &#39;enum fsconfig_command&#39;<br>=C2=A0 265 | =C2=A0 FSCON=
FIG_CMD_RECONFIGURE =3D 7, =C2=A0 /* Invoke superblock reconfiguration */<b=
r>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 ^~~~~~~~~~~~~~~~~~~~~~~~<br>In file include=
d from /home/buildroot/autobuild/instance-0/output-1/host/aarch64-buildroot=
-linux-gnu/sysroot/usr/include/linux/fs.h:19,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from ../../../../include/lapi/fs.h:10=
,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0from sta=
tx09.c:24:<br>/home/buildroot/autobuild/instance-0/output-1/host/aarch64-bu=
ildroot-linux-gnu/sysroot/usr/include/linux/mount.h:129:8: error: redefinit=
ion of &#39;struct mount_attr&#39;<br>=C2=A0 129 | struct mount_attr {<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>In file inc=
luded from statx09.c:21:<br>/home/buildroot/autobuild/instance-0/output-1/h=
ost/lib/gcc/aarch64-buildroot-linux-gnu/11.3.0/include-fixed/sys/mount.h:21=
9:8: note: originally defined here<br>=C2=A0 219 | struct mount_attr<br>=C2=
=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~<br>../../../../in=
clude/mk/<a href=3D"http://rules.mk:45">rules.mk:45</a>: recipe for target =
&#39;statx09&#39; failed<br>make[5]: *** [statx09] Error 1<br>../../../incl=
ude/mk/generic_trunk_target.inc:108: recipe for target &#39;all&#39; failed=
<br>make[4]: *** [all] Error 2<br>../../include/mk/generic_trunk_target.inc=
:108: recipe for target &#39;all&#39; failed<br>make[3]: *** [all] Error 2<=
br>../include/mk/generic_trunk_target.inc:108: recipe for target &#39;all&#=
39; failed<br>make[2]: *** [all] Error 2<br>make[2]: Leaving directory &#39=
;/home/buildroot/autobuild/instance-0/output-1/build/ltp-testsuite-20220527=
/testcases&#39;<br>Makefile:106: recipe for target &#39;testcases-all&#39; =
failed<br>make[1]: *** [testcases-all] Error 2<br>make[1]: Leaving director=
y &#39;/home/buildroot/autobuild/instance-0/output-1/build/ltp-testsuite-20=
220527&#39;<br>package/<a href=3D"http://pkg-generic.mk:290">pkg-generic.mk=
:290</a>: recipe for target &#39;/home/buildroot/autobuild/instance-0/outpu=
t-1/build/ltp-testsuite-20220527/.stamp_built&#39; failed<br>make: *** [/ho=
me/buildroot/autobuild/instance-0/output-1/build/ltp-testsuite-20220527/.st=
amp_built] Error 2<br>make: Leaving directory &#39;/home/buildroot/autobuil=
d/instance-0/buildroot&#39;<br></div></div></div>

--000000000000681d6105e9ae366b--

--===============1250666328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1250666328==--
