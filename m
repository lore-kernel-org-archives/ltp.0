Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B1EC433EF
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 11:00:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74E8F3CAB0B
	for <ltp@archiver.kernel.org>; Fri, 20 May 2022 13:00:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62EFF3CAA69
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:00:24 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8AF1C1A000B3
 for <ltp@lists.linux.it>; Fri, 20 May 2022 13:00:23 +0200 (CEST)
Received: by mail-qk1-x736.google.com with SMTP id m1so6611128qkn.10
 for <ltp@lists.linux.it>; Fri, 20 May 2022 04:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=79n5vmTxIla7HzQimwxTkQvfNtWPuafxxmXgVf4vLiQ=;
 b=Uc80sJCL+IRNZA9WVT1yJQA4a4A4wVq6Aqt3CU+h10b4SjOVhujrLIeoUBoRrQuTXC
 h1OL648o2uexocSIjsXoUHhKuvB2XyxjDSs81j+Q9nuBDgPf3sMRZbZV0oQB0rhA2NLx
 K4zm8Z7pk7e6FcsmqJZiCyhqyF2MKidIjOuhNqcmPwz96bNbgF4pDr1GV5qsa5SDWYJ/
 EREKzFp/Z7v5i+KXARr/k7mBY2cE5AqFIz/LSFhBCNHuwOFQ+D3G3z3CSqlUPqRayNpt
 H9cfk8a2ANFd0Dp9L/RFpU8Ubs9Q/9xaZYy0KWrnrRQawx5a2T4iuyDnKCAgpawUig7v
 z9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=79n5vmTxIla7HzQimwxTkQvfNtWPuafxxmXgVf4vLiQ=;
 b=AiSlqkfTBfd8NWESbiGBASglYrr4qUJ/7oxLT0P5t/KLiX5J/qUH9zkFXu6F632xcf
 om42r1WnLjpbDtggB8xPTSmV8FWgCxciqAtpt4xm8v6BBRNzO3tXne2WQsJMaY3DArzr
 IwbAGd/7SR38dAFZxPd7+YMqpQV1+oJX+yokyeagLtvbF1n+/4+RHlU3IqTjHybSzFWF
 LZyZtD3jquJIICkaBgXKtzqJv14ynAwPxwpjskU+A9ZtTNE8vSWqHmtpf1r5MNisEp+v
 GzYvgMNcuAZKZSwyslMbwCmkxL9Qgs84oLmGOHIPgRxzaLpPkq5N3A3Tc+RhVojhqC3l
 cDng==
X-Gm-Message-State: AOAM530vMFIYAvgZDHZfwA2zG5TgHvr6g/dNZx2Q+2GLiC4Aj+wqW4g8
 NUvVxNx1+YzZVk3Bg+YeWYfLwjZYGrjhnzICCs0=
X-Google-Smtp-Source: ABdhPJx2V7Me6g9LZr8jKvP0JiamKquXgVtpTiV+Xale0gRkQsVJKQJDo8wiBSigJ92q9LhtfPPNUsMo43kYQe7Eu1M=
X-Received: by 2002:a37:a117:0:b0:6a3:4ac9:58e4 with SMTP id
 k23-20020a37a117000000b006a34ac958e4mr1653100qke.168.1653044422395; Fri, 20
 May 2022 04:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <CADqa+6x0pWEC3LSZiCqBqJ1pTDfU_nPjAGCwPHjC-K=jS+gbpw@mail.gmail.com>
 <Yod0ZMHdBbBIECVz@yuki>
In-Reply-To: <Yod0ZMHdBbBIECVz@yuki>
From: samir mulani <samirmulani93@gmail.com>
Date: Fri, 20 May 2022 16:30:11 +0530
Message-ID: <CADqa+6xU87=3x6zeHYXa4L56SZJzD1a4-_7okeefT4mrDQ17RA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP build failure with 5.14 on ppc64le
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
Content-Type: multipart/mixed; boundary="===============0149824888=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0149824888==
Content-Type: multipart/alternative; boundary="000000000000984b3605df6f653a"

--000000000000984b3605df6f653a
Content-Type: text/plain; charset="UTF-8"

Hi Cyril,

Thank you for the clarification.

Regards,
Samir M.

On Fri, 20 May 2022 at 16:26, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > make -C /lib/modules/5.14.21-150400.19-default/build
> > M=/Workspace/ltp-master/testcases/kernel/device-drivers/acpi
> >   CC [M]
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o
> >
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:
> > In function 'get_sysfs_path':
> >
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:132:11:
> > error: implicit declaration of function 'acpi_bus_get_device'; did you
> > mean 'acpi_get_gpe_device'? [-Werror=implicit-function-declaration]
> >   status = acpi_bus_get_device(handle, &device);
> >            ^~~~~~~~~~~~~~~~~~~
> >            acpi_get_gpe_device
> >
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:134:40:
> > error: dereferencing pointer to incomplete type 'struct acpi_device'
> >    sysfs_path = kobject_get_path(&device->dev.kobj, GFP_KERNEL);
> >                                         ^~
> >
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:
> > In function 'acpi_test_bus':
> >
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.c:407:11:
> > error: implicit declaration of function 'acpi_bus_update_power'; did
> > you mean 'acpi_os_trace_point'?
> > [-Werror=implicit-function-declaration]
> >   status = acpi_bus_update_power(device->handle, &state);
> >            ^~~~~~~~~~~~~~~~~~~~~
> >            acpi_os_trace_point
> > cc1: some warnings being treated as errors
> > make[7]: ***
> [/usr/src/linux-5.14.21-150400.19/scripts/Makefile.build:272:
> >
> /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cmds.o]
> > Error 1
> > make[6]: *** [/usr/src/linux-5.14.21-150400.19/Makefile:1882:
> > /Workspace/ltp-master/testcases/kernel/device-drivers/acpi] Error 2
> > make[5]: *** [../../../linux-5.14.21-150400.19/Makefile:220: __sub-make]
> Error 2
> > make[4]: [../../../../include/mk/module.mk:62: .dep_modules] Error 2
> (ignored)
> > rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd
> Module.symvers
> > CC testcases/kernel/device-drivers/block/block_dev_user/block_dev
>
> That's just a LTP kernel module build failure, the modules we have in
> LTP does not support all kernel versions and may fail to build. This is
> not treated as an error by the build system and when the module fails to
> build the test is skipped when tests are executed.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>

--000000000000984b3605df6f653a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0<font color=3D"#000000" style=3D"">Cyril,</fo=
nt></div><div><font color=3D"#000000" style=3D""><br></font></div>Thank you=
 for the clarification.<div>=C2=A0<br></div><div>Regards,</div><div>Samir M=
.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, 20 May 2022 at 16:26, Cyril Hrubis &lt;<a href=3D"mailto:chr=
ubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Hi!<br>
&gt; make -C /lib/modules/5.14.21-150400.19-default/build<br>
&gt; M=3D/Workspace/ltp-master/testcases/kernel/device-drivers/acpi<br>
&gt;=C2=A0 =C2=A0CC [M]=C2=A0 /Workspace/ltp-master/testcases/kernel/device=
-drivers/acpi/ltp_acpi_cmds.o<br>
&gt; /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cm=
ds.c:<br>
&gt; In function &#39;get_sysfs_path&#39;:<br>
&gt; /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cm=
ds.c:132:11:<br>
&gt; error: implicit declaration of function &#39;acpi_bus_get_device&#39;;=
 did you<br>
&gt; mean &#39;acpi_get_gpe_device&#39;? [-Werror=3Dimplicit-function-decla=
ration]<br>
&gt;=C2=A0 =C2=A0status =3D acpi_bus_get_device(handle, &amp;device);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_get_gpe_device<br>
&gt; /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cm=
ds.c:134:40:<br>
&gt; error: dereferencing pointer to incomplete type &#39;struct acpi_devic=
e&#39;<br>
&gt;=C2=A0 =C2=A0 sysfs_path =3D kobject_get_path(&amp;device-&gt;dev.kobj,=
 GFP_KERNEL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0^~<br>
&gt; /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cm=
ds.c:<br>
&gt; In function &#39;acpi_test_bus&#39;:<br>
&gt; /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cm=
ds.c:407:11:<br>
&gt; error: implicit declaration of function &#39;acpi_bus_update_power&#39=
;; did<br>
&gt; you mean &#39;acpi_os_trace_point&#39;?<br>
&gt; [-Werror=3Dimplicit-function-declaration]<br>
&gt;=C2=A0 =C2=A0status =3D acpi_bus_update_power(device-&gt;handle, &amp;s=
tate);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~~~~~~~~~<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_os_trace_point<br>
&gt; cc1: some warnings being treated as errors<br>
&gt; make[7]: *** [/usr/src/linux-5.14.21-150400.19/scripts/Makefile.build:=
272:<br>
&gt; /Workspace/ltp-master/testcases/kernel/device-drivers/acpi/ltp_acpi_cm=
ds.o]<br>
&gt; Error 1<br>
&gt; make[6]: *** [/usr/src/linux-5.14.21-150400.19/Makefile:1882:<br>
&gt; /Workspace/ltp-master/testcases/kernel/device-drivers/acpi] Error 2<br=
>
&gt; make[5]: *** [../../../linux-5.14.21-150400.19/Makefile:220: __sub-mak=
e] Error 2<br>
&gt; make[4]: [../../../../include/mk/<a href=3D"http://module.mk:62" rel=
=3D"noreferrer" target=3D"_blank">module.mk:62</a>: .dep_modules] Error 2 (=
ignored)<br>
&gt; rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Modu=
le.symvers<br>
&gt; CC testcases/kernel/device-drivers/block/block_dev_user/block_dev<br>
<br>
That&#39;s just a LTP kernel module build failure, the modules we have in<b=
r>
LTP does not support all kernel versions and may fail to build. This is<br>
not treated as an error by the build system and when the module fails to<br=
>
build the test is skipped when tests are executed.<br>
<br>
-- <br>
Cyril Hrubis<br>
<a href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a><br=
>
</blockquote></div>

--000000000000984b3605df6f653a--

--===============0149824888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0149824888==--
