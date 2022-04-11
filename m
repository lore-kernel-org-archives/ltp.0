Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC8AC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 15:14:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C38913CA544
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 17:14:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A7B93CA3CF
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 17:14:08 +0200 (CEST)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EABEF2002D2
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 17:14:07 +0200 (CEST)
Received: by mail-ua1-x932.google.com with SMTP id az14so7216288uab.8
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 08:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TyqgWYlXzpoffSqFyQpmHr/km1/30jRNEBgbUMFzUM4=;
 b=YHiKUAdbTObSX6GWf/gUULnAags/clPDnWmWb6CCVQ3W0Q9uQtxvTrCmYUyqjbpBoE
 6Yn7AcAIJMyaeG2yRUxP5ad656Lmk7N/9e+kTvKaqnyT8cpkiKa8ieosKRiw2Ff7pGIq
 hfI7GSGaLKmi9DTJC74bsAnaM7BNdkCT4AE5lyhw9ETGEhSRr/WY2W8J6ywYSqKFUiQ7
 KZl2UaT3PZW0whl2pVB02PbdLYwmoTc8a/bVUBISZONPP6E/B9Y26VmQDY9Jo/wzcboV
 ZtteCZNapw503TsfBCrLe2RTpuW5S+YrxdNJXuLploBnpoW26MtBQ/eK1ewmqSUztoTB
 ZaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TyqgWYlXzpoffSqFyQpmHr/km1/30jRNEBgbUMFzUM4=;
 b=vcvkrbV30zC1rntkHTIhhjHE+6DJDkx8pHgTOtSNsx2cx7ucDhfBnkXl4Bf2zbDpF/
 XVa75Ye+rgXV0IRURGIsAPiGcgrAa/okMRFB34jsXpDcluvK11ehhUjyFBdhoCf2C8W5
 fuK1UTF7bz3oAOcS7y/ym5FlC07sWRMhKxhwQt9bf8956xobIA1jFw2OOb6PzMasHL/0
 YQTeH1IlwUOlGobC51RzzoBXc3rEowE1/h+d0sU9U6t+AJG0j6SnSBXgJevdzl2o3t1K
 1MWSW+Ujie/My1M8DQfK6JpueweCsulLMMEX7Z71AKMWX4t5I0BGxOX8rHwBqA/UaQkW
 3ZyQ==
X-Gm-Message-State: AOAM533HDU5+V75/SQIujMpcZqkjnnvfsA+JcyD/keUzY8dKMqq+K62e
 HklXoJUX7VaBScOqdHZE7W+XqWc/ErrKFCoGb0UGvQ==
X-Google-Smtp-Source: ABdhPJx2pK1PGyFWqPkBVcOfU9zs0/otQPjsG4RLNCiLt4xdS2TvLlNL/DkzX/u2H+mreNAEeXVF5njDNxkI+JxKwi0=
X-Received: by 2002:a05:6130:420:b0:359:aa0f:7e3c with SMTP id
 ba32-20020a056130042000b00359aa0f7e3cmr10132866uab.64.1649690046347; Mon, 11
 Apr 2022 08:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220405170607.3596657-1-edliaw@google.com>
 <CAEemH2dZiWZjHWMzrRuuiar5YQHF741TMu4p=uMtWgTPG4Oh+w@mail.gmail.com>
 <87sfqkggtq.fsf@suse.de>
 <CAEemH2eh=AX6-DMW1UaVs+MGtqFXq8HoJD41D3paB93vQZ9ZUw@mail.gmail.com>
 <87k0bwgebk.fsf@suse.de>
 <CAEemH2fkjkyYagLkThYRRwgwJk+oMg7fs5=Af6rimLf_kesJPw@mail.gmail.com>
In-Reply-To: <CAEemH2fkjkyYagLkThYRRwgwJk+oMg7fs5=Af6rimLf_kesJPw@mail.gmail.com>
Date: Mon, 11 Apr 2022 08:13:55 -0700
Message-ID: <CAG4es9Wvid4tHLNkV6E-JXfMjN0orUOxaSS_J6AceMM-WYq1Rw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fzsync: break inf loop with flag vs
 pthread_cancel
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1978247331=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1978247331==
Content-Type: multipart/alternative; boundary="0000000000003435f605dc62658a"

--0000000000003435f605dc62658a
Content-Type: text/plain; charset="UTF-8"

Hi Li, Richard,

On Mon, Apr 11, 2022, 2:36 AM Li Wang <liwang@redhat.com> wrote:

>
>
> On Mon, Apr 11, 2022 at 5:27 PM Richard Palethorpe <rpalethorpe@suse.de>
> wrote:
>
>> >  > +                       tst_atomic_store(1, &pair->exit);
>> >  > +                       usleep(100000);
>> >
>> >  Why do we need usleep?
>> >
>> > Seems not very needed.
>>
>> +1
>>
>
> @Edward,  It'd be appreciated if you can send a patch V2 base on
> the comments above. Or, do you have different thoughts?
>

Ok, will do!  I'm still new to using the mailing list so I wasn't sure how
to proceed :P

Thanks,
Edward

>

--0000000000003435f605dc62658a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"auto">Hi Li, Richard,<br><br><div class=3D"gma=
il_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 11=
, 2022, 2:36 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" rel=3D"nor=
eferrer" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gm=
ail_default" style=3D"font-size:small"><br></div></div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 11, 2022 at 5:=
27 PM Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de" rel=3D"=
noreferrer noreferrer" target=3D"_blank">rpalethorpe@suse.de</a>&gt; wrote:=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_atomic_store(1, &amp;pair-&gt;exit);<br>
&gt;=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0usleep(100000);<br>
&gt;<br>
&gt;=C2=A0 Why do we need usleep?<br>
&gt;<br>
&gt; Seems not very needed. <br>
<br>
+1<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">@Edward,=C2=A0 It&#39;d be appreciated if you can send a patc=
h V2 base on</div><div class=3D"gmail_default" style=3D"font-size:small">th=
e comments above. Or, do you have different thoughts?</div></div></div></bl=
ockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">Ok, will do!=
=C2=A0 I&#39;m still new to using the mailing list so I wasn&#39;t sure how=
 to proceed :P</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</=
div><div dir=3D"auto">Edward</div><div class=3D"gmail_quote" dir=3D"auto"><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
</blockquote></div></div>
</div>

--0000000000003435f605dc62658a--

--===============1978247331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1978247331==--
