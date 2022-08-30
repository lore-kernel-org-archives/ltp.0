Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D64ECAAA1
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 09:59:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFBE43CA68C
	for <ltp@archiver.kernel.org>; Tue, 30 Aug 2022 11:59:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42B983C9B48
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 11:59:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E3C81400DB3
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 11:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661853581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=47FF4rGSBX4kuONyUd6AsVdo62+FsuWul98UeUoYSak=;
 b=Ui5rQb/fdD4MTBaSuA5n0P20Y0x9X/7u2yVGkAPkTLKAsMa/PSnuvENkh/nCulbMoiQDAK
 xyPCS0fmNarwRH2FzgbMfmah3Hv1EAKfKFTuFxcaDTfpaT3hbe8Q3KoRoYhe4ix908GX3v
 XQzzyRkQ6dCyz28nVHqAj94tAX1QPIA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-400-T__e404tO4iLt3VyWhz-Qg-1; Tue, 30 Aug 2022 05:59:39 -0400
X-MC-Unique: T__e404tO4iLt3VyWhz-Qg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-33ef3e5faeeso163459267b3.0
 for <ltp@lists.linux.it>; Tue, 30 Aug 2022 02:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=47FF4rGSBX4kuONyUd6AsVdo62+FsuWul98UeUoYSak=;
 b=xAke3wO+/1YzMk02JQAzvC23qsxHHAG4YdFUSGFtZNpCokAWMmZbVRnRJP6UbaWQhZ
 BISdmJKJxiNPZD9uokCuYAly49eDGU3wA0yuH+Iixw0SpMPNnVATaQphojRqllwzp6k2
 8C59/Ray/NUbEgvdH6TfTSfmeamZWGDuIoLS327+qK3OLZIbGuZE59CK011QAhNu4O3+
 S6e4+0MuyY/kxfMSx+KyAMBiE+8wrte3NCo76feBpFdiI29YaYfJytaRXQ+ex2wc8KQa
 R0SIkcXjhhzimwifwfI11n4oGQntgRxdc+iR+5JiDbAJGRS/j2CMCG0IhFzhgwf3l16Y
 NUgQ==
X-Gm-Message-State: ACgBeo095qDojviQqFfEI+XEFyaAbP45KPuCnA0NMEVECiUnESwomFZG
 3kIkAENquWIo2XcLOYbxI8mzJmjpGd1DAVG1vwrAPAJt48H7Ws59OD37BsewlgRYyBXGZKamvy4
 fRdoHdb+mudeusRJxTB2jfGcuzgY=
X-Received: by 2002:a25:2586:0:b0:695:9529:c9a6 with SMTP id
 l128-20020a252586000000b006959529c9a6mr11005306ybl.591.1661853578619; 
 Tue, 30 Aug 2022 02:59:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6m6p8pZWix57viIWDBLdzYZMVQ4qNPPCDKJVZ4qkRvdZ9zuL8Zy8dS8ALPvphJAjaWSB3PTBque+WHudwOGsQ=
X-Received: by 2002:a25:2586:0:b0:695:9529:c9a6 with SMTP id
 l128-20020a252586000000b006959529c9a6mr11005291ybl.591.1661853578426; Tue, 30
 Aug 2022 02:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220727053307.3009235-1-lkml@jv-coder.de>
 <20220727053307.3009235-4-lkml@jv-coder.de>
 <YuQXnCgSjBT1mGFH@pevik> <87pmhkfm1p.fsf@suse.de>
In-Reply-To: <87pmhkfm1p.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 Aug 2022 17:59:27 +0800
Message-ID: <CAEemH2cMxW3Z7SnMpHBR1C4945pkQ-OfJE9JDnagt21pxiNTVw@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] configure: Integrate open posix testsuite
 configure
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
Cc: LTP List <ltp@lists.linux.it>, Joerg Vehlow <joerg.vehlow@aox.de>,
 automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============0743454514=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0743454514==
Content-Type: multipart/alternative; boundary="00000000000036111405e77270d4"

--00000000000036111405e77270d4
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Mon, Aug 1, 2022 at 3:41 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Petr Vorel <pvorel@suse.cz> writes:
>
> > Hi Joerg,
> >
> > [ Cc automated-testing@lists.yoctoproject.org ]
> >
> >> From: Joerg Vehlow <joerg.vehlow@aox.de>
> >
> >> This changes the default installation location
> >> of the open posix testsuite from
> >> $prefix
> >> to
> >> $prefix/testcases/open_posix_testsuite
> > I need to have a deeper look on this patchset next week.
> > But it looks to me strange, that running LTP top level configure causes
> > installation into /opt/ltp/testcases/open_posix_testsuite/, but after
> running
> > ./configure in testcases/open_posix_testsuite make install goes by
> default to
> > /opt/openposix_testsuite.
> >
> > Also openposix does not use LTP API, when we're touching it, wouldn't it
> make
> > more sense to put it into separate git repository? IMHO that would cause
> work
> > for other people (clone separate git, need to fix CI and tools which are
> using
> > it), but openposix embedded in LTP always looked strange to me.
>
> I wouldn't be against this based on my anecdotal experience.
>
> I don't recall a specific time these tests found a kernel bug. They
> sometimes find issues with glibc, but there is usually a debate as to
> how to interpret the spec instead of a clear error on glibc's part. Most
> often the test is broken.
>
> So I'd say these tests are almost useless for kernel testing. I also
> think they often misinterpret the POSIX spec or have some basic logic
> error.
>

I think so! And I don't against this patchset as well.

@Petr Vorel <pvorel@suse.cz>  feel free to merge the patches, it might
usefully to
someone who has a strong willingness on running them.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

--00000000000036111405e77270d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi All,</div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Mon, Aug 1, 2022 at 3:41 PM Richard Palethorp=
e &lt;<a href=3D"mailto:rpalethorpe@suse.de" target=3D"_blank">rpalethorpe@=
suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Hello,<br>
<br>
Petr Vorel &lt;<a href=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@s=
use.cz</a>&gt; writes:<br>
<br>
&gt; Hi Joerg,<br>
&gt;<br>
&gt; [ Cc <a href=3D"mailto:automated-testing@lists.yoctoproject.org" targe=
t=3D"_blank">automated-testing@lists.yoctoproject.org</a> ]<br>
&gt;<br>
&gt;&gt; From: Joerg Vehlow &lt;<a href=3D"mailto:joerg.vehlow@aox.de" targ=
et=3D"_blank">joerg.vehlow@aox.de</a>&gt;<br>
&gt;<br>
&gt;&gt; This changes the default installation location<br>
&gt;&gt; of the open posix testsuite from<br>
&gt;&gt; $prefix<br>
&gt;&gt; to<br>
&gt;&gt; $prefix/testcases/open_posix_testsuite<br>
&gt; I need to have a deeper look on this patchset next week.<br>
&gt; But it looks to me strange, that running LTP top level configure cause=
s<br>
&gt; installation into /opt/ltp/testcases/open_posix_testsuite/, but after =
running<br>
&gt; ./configure in testcases/open_posix_testsuite make install goes by def=
ault to<br>
&gt; /opt/openposix_testsuite.<br>
&gt;<br>
&gt; Also openposix does not use LTP API, when we&#39;re touching it, would=
n&#39;t it make<br>
&gt; more sense to put it into separate git repository? IMHO that would cau=
se work<br>
&gt; for other people (clone separate git, need to fix CI and tools which a=
re using<br>
&gt; it), but openposix embedded in LTP always looked strange to me.<br>
<br>
I wouldn&#39;t be against this based on my anecdotal experience.<br>
<br>
I don&#39;t recall a specific time these tests found a kernel bug. They<br>
sometimes find issues with glibc, but there is usually a debate as to<br>
how to interpret the spec instead of a clear error on glibc&#39;s part. Mos=
t<br>
often the test is broken.<br>
<br>
So I&#39;d say these tests are almost useless for kernel testing. I also<br=
>
think they often misinterpret the POSIX spec or have some basic logic<br>
error.<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D=
"font-size:small">I think so! And I don&#39;t against=C2=A0this patchset as=
 well.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small"><a class=3D"gmail_=
plusreply" id=3D"m_2252497587767376310plusReplyChip-0" href=3D"mailto:pvore=
l@suse.cz" target=3D"_blank">@Petr Vorel</a>=C2=A0 feel free to merge the p=
atches, it might usefully to<br></div><div class=3D"gmail_default" style=3D=
"font-size:small">someone who has a strong willingness on running them.</di=
v></div><div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" targe=
t=3D"_blank">liwang@redhat.com</a>&gt;</div><br></div>-- <br><div dir=3D"lt=
r"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></di=
v></div>

--00000000000036111405e77270d4--


--===============0743454514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0743454514==--

