Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051B5C433F5
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 10:46:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B7C53CAB0B
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 12:46:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1B223C001D
 for <ltp@lists.linux.it>; Fri, 20 May 2022 12:46:26 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8A9CC1A00923
 for <ltp@lists.linux.it>; Fri, 20 May 2022 12:46:25 +0200 (CEST)
Received: by mail-qt1-x836.google.com with SMTP id fu47so6632121qtb.5
 for <ltp@lists.linux.it>; Fri, 20 May 2022 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=7VBvSSWjqr6GO7sA7JLoHce1FZfdKpDgrI0g6s7NMwQ=;
 b=KPO+IM9+UE0HdmqhEAhYIm/XQtq99Uf7pOmwNv7vwsZli3m7pn3gdy0znZzqMeyW7/
 qZnh2qVt5bjD5kyCaWTd9gz4Eq0PZGF5Uf4roP1Lu+yNiVOkogPwvMtpD9OVei7B6eON
 GK0IfwARNa5Xm9sByVTWs9BkhTQwcNFMjFLDJJ1DLccp3Ki4+3JB/MJ6e8gBk/DBycNd
 JLogNaDAZt5xJd7e9PXc7tOJbdeLO4dngRdpoyrHs1RExK0SlBHTmQbiiVj3rTQVKvTK
 NK3n6asHnaLFkQT7OwVSW2ZacoNYxZ4U9reByMsjCrFEjVL41LWDqTr3OP1aNsNFP6bb
 HGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=7VBvSSWjqr6GO7sA7JLoHce1FZfdKpDgrI0g6s7NMwQ=;
 b=ue4WZbsQCoW3XQy0jtnE8XJd3aeL/YtHtexklP0e3cf6LlFXaF+7Hkb90R/LFVrt9X
 h99nCP3ot6eGQ2hG9/T1B8PmBDKtJxMtdctNfpuGa3jy7L3qCjwjmlb1T62ppebj4B8t
 qFY0f6xPA31P7m6hOKvMh7DJcn7u9kPgttKil+Fg6wQuOIPCZpjzuwT5w3T7/5UvHgbl
 Yoxlb55Z6FCXDJgQBSc5TABu6CnZI7xCEWovwygzh17jUutc1+JOFcnU+2/4a2p8ZNO1
 6m+J5Nma03UZOZNAHtJ5abq6g1rHhPqL8+1A8QIt8cY4MJJ8IIUUCiup1OAEHVWr+XTn
 9LuQ==
X-Gm-Message-State: AOAM533q3qc9yrTYg7/CQLefs6DQMjw0Ap/z0rFfFR352sxqr+DCNt15
 AdVogZCl7nuuo/+fm6rTOLevPoWQtLHm1X/Tz+9RvgxNOgvlSg==
X-Google-Smtp-Source: ABdhPJyYe0t75hdKAZo8vDAnIaORhfpLmzJEjMOOJG4q1KIX56mpsAcEHq/iq7e0D5Jw9+tIarwto6Votodg7Qgp24k=
X-Received: by 2002:a05:622a:6082:b0:2f1:1f9c:251e with SMTP id
 hf2-20020a05622a608200b002f11f9c251emr7114106qtb.230.1653043584121; Fri, 20
 May 2022 03:46:24 -0700 (PDT)
MIME-Version: 1.0
From: samir mulani <samirmulani93@gmail.com>
Date: Fri, 20 May 2022 16:16:13 +0530
Message-ID: <CADqa+6x0pWEC3LSZiCqBqJ1pTDfU_nPjAGCwPHjC-K=jS+gbpw@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP build failure with 5.14 on ppc64le
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
Content-Type: multipart/mixed; boundary="===============2133871790=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2133871790==
Content-Type: multipart/alternative; boundary="000000000000a13d7705df6f3312"

--000000000000a13d7705df6f3312
Content-Type: text/plain; charset="UTF-8"

Hi Team,

If anyone is help me with below build error message,

git clone https://github.com/linux-test-project/ltp.git
$ cd ltp
$ make autotools
$ ./configure
$ make


Log,

make -C /lib/modules/5.14.21-150400.19-default/build
M=/Workspace/ltp-master/testcases/kernel/device-drivers/acpi
  CC [M]  /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:
In function 'get_sysfs_path':
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:132:11:
error: implicit declaration of function 'acpi_bus_get_device'; did you
mean 'acpi_get_gpe_device'? [-Werror=implicit-function-declaration]
  status = acpi_bus_get_device(handle, &device);
           ^~~~~~~~~~~~~~~~~~~
           acpi_get_gpe_device
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:134:40:
error: dereferencing pointer to incomplete type 'struct acpi_device'
   sysfs_path = kobject_get_path(&device->dev.kobj, GFP_KERNEL);
                                        ^~
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:
In function 'acpi_test_bus':
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:407:11:
error: implicit declaration of function 'acpi_bus_update_power'; did
you mean 'acpi_os_trace_point'?
[-Werror=implicit-function-declaration]
  status = acpi_bus_update_power(device->handle, &state);
           ^~~~~~~~~~~~~~~~~~~~~
           acpi_os_trace_point
cc1: some warnings being treated as errors
make[7]: *** [/usr/src/linux-5.14.21-150400.19/scripts/Makefile.build:272:
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o]
Error 1
make[6]: *** [/usr/src/linux-5.14.21-150400.19/Makefile:1882:
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi] Error 2
make[5]: *** [../../../linux-5.14.21-150400.19/Makefile:220: __sub-make] Error 2
make[4]: [../../../../include/mk/module.mk:62: .dep_modules] Error 2 (ignored)
rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.symvers
CC testcases/kernel/device-drivers/block/block_dev_user/block_dev


Regards,
Samir M.

--000000000000a13d7705df6f3312
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"elementToProof" style=3D"margin:0px;padding:=
0px;border:0px;font-variant-numeric:inherit;font-variant-east-asian:inherit=
;font-stretch:inherit;font-size:12pt;line-height:inherit;font-family:Calibr=
i,Arial,Helvetica,sans-serif;vertical-align:baseline;color:rgb(0,0,0)">Hi T=
eam,</div><div class=3D"elementToProof" style=3D"margin:0px;padding:0px;bor=
der:0px;font-variant-numeric:inherit;font-variant-east-asian:inherit;font-s=
tretch:inherit;font-size:12pt;line-height:inherit;font-family:Calibri,Arial=
,Helvetica,sans-serif;vertical-align:baseline;color:rgb(0,0,0)"><br></div><=
div class=3D"elementToProof" style=3D"margin:0px;padding:0px;border:0px;fon=
t-variant-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inhe=
rit;font-size:12pt;line-height:inherit;font-family:Calibri,Arial,Helvetica,=
sans-serif;vertical-align:baseline;color:rgb(0,0,0)">If anyone is help me w=
ith below build error message,</div><div class=3D"elementToProof" style=3D"=
margin:0px;padding:0px;border:0px;font-variant-numeric:inherit;font-variant=
-east-asian:inherit;font-stretch:inherit;font-size:12pt;line-height:inherit=
;font-family:Calibri,Arial,Helvetica,sans-serif;vertical-align:baseline;col=
or:rgb(0,0,0)"><pre class=3D"gmail-c-mrkdwn__pre" style=3D"margin-top:4px;m=
argin-bottom:4px;padding:8px;font-size:12px;line-height:1.50001;font-varian=
t-ligatures:none;border-radius:4px;color:rgb(29,28,29);font-family:Monaco,M=
enlo,Consolas,&quot;Courier New&quot;,monospace">git clone <a target=3D"_bl=
ank" class=3D"gmail-c-link" href=3D"https://github.com/linux-test-project/l=
tp.git" rel=3D"noopener noreferrer" style=3D"margin:0px;padding:0px;border:=
0px;font:inherit;vertical-align:baseline">https://github.com/linux-test-pro=
ject/ltp.git</a>
$ cd ltp
$ make autotools
$ ./configure
$ make</pre></div><div class=3D"elementToProof" style=3D"margin:0px;padding=
:0px;border:0px;font-variant-numeric:inherit;font-variant-east-asian:inheri=
t;font-stretch:inherit;font-size:12pt;line-height:inherit;font-family:Calib=
ri,Arial,Helvetica,sans-serif;vertical-align:baseline;color:rgb(0,0,0)"><br=
></div><div class=3D"elementToProof" style=3D"margin:0px;padding:0px;border=
:0px;font-variant-numeric:inherit;font-variant-east-asian:inherit;font-stre=
tch:inherit;font-size:12pt;line-height:inherit;font-family:Calibri,Arial,He=
lvetica,sans-serif;vertical-align:baseline;color:rgb(0,0,0)">Log,</div><div=
 class=3D"elementToProof" style=3D"margin:0px;padding:0px;border:0px;font-v=
ariant-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inherit=
;font-size:12pt;line-height:inherit;font-family:Calibri,Arial,Helvetica,san=
s-serif;vertical-align:baseline;color:rgb(0,0,0)"><pre class=3D"gmail-c-mrk=
dwn__pre" style=3D"margin-top:4px;margin-bottom:4px;padding:8px;font-size:1=
2px;line-height:1.50001;font-variant-ligatures:none;border-radius:4px;color=
:rgb(29,28,29);font-family:Monaco,Menlo,Consolas,&quot;Courier New&quot;,mo=
nospace">make -C /lib/modules/5.14.21-150400.19-default/build M=3D/Workspac=
e/ltp-master/testcases/kernel/device-drivers/acpi
=C2=A0 CC [M] =C2=A0/Workspace/ltp-master/testcases/kernel/device-drivers/a=
cpi/ltp_acpi_cmds.o
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:=
 In function &#39;get_sysfs_path&#39;:
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:=
132:11: error: implicit declaration of function &#39;acpi_bus_get_device&#3=
9;; did you mean &#39;acpi_get_gpe_device&#39;? [-Werror=3Dimplicit-functio=
n-declaration]
=C2=A0 status =3D acpi_bus_get_device(handle, &amp;device);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_get_gpe_device
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:=
134:40: error: dereferencing pointer to incomplete type &#39;struct acpi_de=
vice&#39;
=C2=A0 =C2=A0sysfs_path =3D kobject_get_path(&amp;device-&gt;dev.kobj, GFP_=
KERNEL);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:=
 In function &#39;acpi_test_bus&#39;:
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:=
407:11: error: implicit declaration of function &#39;acpi_bus_update_power&=
#39;; did you mean &#39;acpi_os_trace_point&#39;? [-Werror=3Dimplicit-funct=
ion-declaration]
=C2=A0 status =3D acpi_bus_update_power(device-&gt;handle, &amp;state);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_os_trace_point
cc1: some warnings being treated as errors
make[7]: *** [/usr/src/linux-5.14.21-150400.19/scripts/Makefile.build:272: =
/Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o]=
 Error 1
make[6]: *** [/usr/src/linux-5.14.21-150400.19/Makefile:1882: /Workspace/lt=
p-master/testcases/kernel/device-drivers/acpi] Error 2
make[5]: *** [../../../linux-5.14.21-150400.19/Makefile:220: __sub-make] Er=
ror 2
make[4]: [../../../../include/mk/<a href=3D"http://module.mk:62">module.mk:=
62</a>: .dep_modules] Error 2 (ignored)
rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.sy=
mvers
CC testcases/kernel/device-drivers/block/block_dev_user/block_dev</pre><br>=
</div><div class=3D"elementToProof" style=3D"margin:0px;padding:0px;border:=
0px;font-variant-numeric:inherit;font-variant-east-asian:inherit;font-stret=
ch:inherit;font-size:12pt;line-height:inherit;font-family:Calibri,Arial,Hel=
vetica,sans-serif;vertical-align:baseline;color:rgb(0,0,0)">Regards,</div><=
div class=3D"elementToProof" style=3D"margin:0px;padding:0px;border:0px;fon=
t-variant-numeric:inherit;font-variant-east-asian:inherit;font-stretch:inhe=
rit;font-size:12pt;line-height:inherit;font-family:Calibri,Arial,Helvetica,=
sans-serif;vertical-align:baseline;color:rgb(0,0,0)">Samir M.</div></div>

--000000000000a13d7705df6f3312--

--===============2133871790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2133871790==--
