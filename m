Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0492C433FE
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 10:09:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EF633CD147
	for <ltp@archiver.kernel.org>; Tue, 15 Nov 2022 11:09:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 216523C94F3
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 11:08:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 25F1C10007AE
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 11:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668506932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yL1RU8xXSXNJrbTTLliJBI3pkp02KF823qZRwxn/aqg=;
 b=GWc21DRfpdXd7hRwSrl/YiLD2+X53IJDmWQo6FnlZh2oaXeOvDXJJMjATPQ65YoB0CSoy5
 CC/yTFJIgE3gkuQzONpJRaHF6RX1KW1TGU/OFx/DdKQRpqGwVSzOpS51WjM09rnWvNa2uC
 +6Otw8vkGEBhYOXolaZPtS52UrQhp0s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-324-UKP0-IrNM4mTVcBg07ElVw-1; Tue, 15 Nov 2022 05:08:50 -0500
X-MC-Unique: UKP0-IrNM4mTVcBg07ElVw-1
Received: by mail-wr1-f69.google.com with SMTP id
 s11-20020adfbc0b000000b0023659af24a8so2649325wrg.14
 for <ltp@lists.linux.it>; Tue, 15 Nov 2022 02:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yL1RU8xXSXNJrbTTLliJBI3pkp02KF823qZRwxn/aqg=;
 b=wprSfUuDwq1+UdtfIIFr245mVwWcBZA4bl+cl0VgB9ijadYqeu8EXETQEULcpwtGXS
 oEBlgzcAK1gWDQkRZMa3atW0CvJx5KAmFhN8uRKYB61InS5MgETyZI09Ki7LSx8lN1dT
 /Wgo+qDrIm1G6BC326o+3eEg/QexzRbnw10CgeEXfTGoGNSMlToEzqGpap4M/G66HV+D
 czgswazX9XmBVNSv/se9CN38DnN+7pdlypXgJW8fViOw5QMH+YxD0ZKYaLCJRAHJQPLf
 Exv6gNiWr5UX4f5gSHfkg4PKfpbxvBo9PqvQti7I2VgXcLQRLxcPC1lAYnty/hCQaHFl
 zjxQ==
X-Gm-Message-State: ANoB5pnG0ymh7N9pSwR8KEGTehtVhWzAULU1Yja55q7WASc2VnCseqL4
 f6TQ9UvU0TvILeRKpPEn1v0GIUUrfpjkpUz8M2UCs6mJ9M2/+TBhdb3l+lrXkhke24FqsNx6y3K
 V/OEd0OihAvUsgI877E+SXM9BHHU=
X-Received: by 2002:a05:600c:444a:b0:3b4:c00d:2329 with SMTP id
 v10-20020a05600c444a00b003b4c00d2329mr851214wmn.124.1668506929428; 
 Tue, 15 Nov 2022 02:08:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4Y38dQgG4c25WlexqFBNWE2jHAVms1FtwHPbnQYgmxUQ0PAxa+QxWlR8OI+3nfNTjlCE69hE65LR5+mLul6Zg=
X-Received: by 2002:a05:600c:444a:b0:3b4:c00d:2329 with SMTP id
 v10-20020a05600c444a00b003b4c00d2329mr851203wmn.124.1668506929220; Tue, 15
 Nov 2022 02:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20221112040107.3953862-1-liwang@redhat.com>
 <87pmdpsfdv.fsf@suse.de>
 <CAEemH2fJJ8Fv0=OMjdh3d8QaEdr1ivLUuHs_8=D6qV6-YZhbwQ@mail.gmail.com>
 <87h6z0sh8o.fsf@suse.de>
 <CAEemH2c-90baLEbom4yF8oVjh9n7O4uKkXS5SBmx2rSBRsZBBQ@mail.gmail.com>
In-Reply-To: <CAEemH2c-90baLEbom4yF8oVjh9n7O4uKkXS5SBmx2rSBRsZBBQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Nov 2022 18:08:37 +0800
Message-ID: <CAEemH2d=65BMhY4RFXHS1d5dkbq7v2QDskfE_5b_WnttDXT+Fg@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] setitimer01: add interval timer test
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1949320067=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1949320067==
Content-Type: multipart/alternative; boundary="000000000000d2720f05ed7f8a14"

--000000000000d2720f05ed7f8a14
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 15, 2022 at 6:00 PM Li Wang <liwang@redhat.com> wrote:

> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
>
>> >
>> >  Practically speaking we have to assume a large amount of time has
>> passed
>> >  when using ITIMER_REAL. It has to be *much* larger than a VM is likely
>> >  to be paused for and then successfully resumed. Or the amount of time a
>> >  clock may be corrected by (for e.g. with NTP).
>> >
>> > Hmm, not sure if I understand correctly above, will that
>> > timer value be out of the range but reasonable?
>> >
>> > Or is there any additional situation we should cover?
>>
>> Sorry that is confusing.
>>
>> The question is what happens if the clock jumps backwards?
>>
>> I don't see anything which says it_value.tv_sec can't go out of
>> range. OTOH I would expect it to compensate for large jumps in time.
>>
>> If the test randomly fails because it_value.tv_sec > time_sec then what
>> action will we take?
>>
>
Or, we do nothing on this, just let the test report TFAIL, because that
is not what this test can control.



>
> How about increasing the time_sec on virtual machine?
>
> Seems no perfect way to completely resolve but only reducing
> the odds of happening.
>
> Or do you have another better suggestion?
>
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -142,6 +142,11 @@ static void setup(void)
>
>         time_sec  = 9 + time_step / 1000;
>         time_usec = 3 * time_step;
> +
> +       if (tst_is_virt(VIRT_ANY)) {
> +               tst_res(TINFO, "Running in a VM, multiply the time_sec by
> 10.");
> +               time_sec *= 10;
> +       }
>  }
>
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Li Wang

--000000000000d2720f05ed7f8a14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Nov 15, 2022 at 6:00 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr"><div style=3D"font-size:small">Richard Palethorpe &lt;<a href=3D"mail=
to:rpalethorpe@suse.de" target=3D"_blank">rpalethorpe@suse.de</a>&gt; wrote=
:<br></div></div><div class=3D"gmail_quote"><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 <br>
&gt;=C2=A0 Practically speaking we have to assume a large amount of time ha=
s passed<br>
&gt;=C2=A0 when using ITIMER_REAL. It has to be *much* larger than a VM is =
likely<br>
&gt;=C2=A0 to be paused for and then successfully resumed. Or the amount of=
 time a<br>
&gt;=C2=A0 clock may be corrected by (for e.g. with NTP).<br>
&gt;<br>
&gt; Hmm, not sure if I understand correctly above, will that<br>
&gt; timer value be out of the range but reasonable?<br>
&gt;<br>
&gt; Or is there any additional situation we should cover?<br>
<br>
Sorry that is confusing.<br>
<br>
The question is what happens if the clock jumps backwards?<br>
<br>
I don&#39;t see anything which says it_value.tv_sec can&#39;t go out of<br>
range. OTOH I would expect it to compensate for large jumps in time.<br>
<br>
If the test randomly fails because it_value.tv_sec &gt; time_sec then what<=
br>
action will we take?<br></blockquote></div></div></blockquote><div><br></di=
v><div><div class=3D"gmail_default" style=3D"font-size:small">Or, we do not=
hing on this, just let the test report TFAIL, because that</div><div class=
=3D"gmail_default" style=3D"font-size:small">is not what this test can cont=
rol.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"></blockquote><div><br></div><div><div styl=
e=3D"font-size:small">How about increasing the time_sec on virtual machine?=
</div><div style=3D"font-size:small"><br></div><div style=3D"font-size:smal=
l">Seems no perfect way to completely resolve but only reducing</div><div s=
tyle=3D"font-size:small">the odds of happening.=C2=A0</div><div style=3D"fo=
nt-size:small"><br></div><div style=3D"font-size:small">Or do you have anot=
her better suggestion?</div><div style=3D"font-size:small"><br></div>--- a/=
testcases/kernel/syscalls/setitimer/setitimer01.c<br>+++ b/testcases/kernel=
/syscalls/setitimer/setitimer01.c<br>@@ -142,6 +142,11 @@ static void setup=
(void)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_sec =C2=A0=3D 9 + time=
_step / 1000;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 time_usec =3D 3 * time_step;<b=
r>+<br>+ =C2=A0 =C2=A0 =C2=A0 if (tst_is_virt(VIRT_ANY)) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quot;Running in a VM=
, multiply the time_sec by 10.&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 time_sec *=3D 10;<br>+ =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0}<=
br><div style=3D"font-size:small"></div><br></div><div>=C2=A0</div></div>--=
 <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<=
br></div></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--000000000000d2720f05ed7f8a14--


--===============1949320067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1949320067==--

