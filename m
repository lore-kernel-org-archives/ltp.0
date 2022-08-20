Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD5BC28D13
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 02:37:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 392FB3CA1E2
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 04:37:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 490F83C98BF
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 04:37:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 79C311A00148
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 04:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660963057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpBpfhD0vw8itVy/DiRy3QvX7txnsO4Lr65kKx4K57M=;
 b=Xl+FTFiW/LLy7IOa5+0mUJi65TYQkq1m+MkkKDTtMj/O+8kXl20a8uyWirTiNqOeVyReY3
 nrLYuZNOKQqTazK8F7htuRB97q4zw4QzH1zjzBZt8ARItDtroOZxsAZfHUwn0YkgF4a7H2
 f3OVkbMwTb0dKJQSWH1m29EzdkDUuLw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-215-CZfuHZUePyKR1ZUj0JJuVw-1; Fri, 19 Aug 2022 22:37:35 -0400
X-MC-Unique: CZfuHZUePyKR1ZUj0JJuVw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-334370e5ab9so105012467b3.22
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 19:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=TpBpfhD0vw8itVy/DiRy3QvX7txnsO4Lr65kKx4K57M=;
 b=rOJ5DCEwIeI2W9uN0dXlNciYN0aojt41tgqmoTyvwzYUXoINVa1SfDjXTymJE13v3f
 LRLG9ypD0F7IZRnshZyZDhC82wmejLLicdOkfRiq+vJcERm1EaNGvOBGr+UKJRZrZhXg
 8IRuXdDZ34bWesTDbzQ66r3HVJ5HDNcTqoeZ8YIbB1v3d0WOWeWxG4/WPdzKpJRo3icK
 TlM/D5eu6f1BKjLZLflhfFemQ3qSxkeNNhZYfhzo6g/39vvWmfcNHMQSqdLy/y4ZqnS4
 paujcydAkiWE9hN7q0uyqTgtgmBYuwmRlKVp/zCufdvB34x0MLaIE3+d6Dz3Vf99VJMj
 hMfA==
X-Gm-Message-State: ACgBeo21YWqP8QGO95xk+GDRfyrmeAIST12MwGvAjkD8Tz/L/WqOtHIW
 vOpRraPXg0efifZhGrwnSxu8zsEfwmmy3okK2pVwWN9/73YLdMSqqUpcgdsM0Aso/GQa1QToHlJ
 GlpIIBBzsRtSevCQHYl+s23FupTo=
X-Received: by 2002:a25:bf86:0:b0:671:3607:1381 with SMTP id
 l6-20020a25bf86000000b0067136071381mr10459057ybk.355.1660963055416; 
 Fri, 19 Aug 2022 19:37:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4TTWOVSyIZuZkoXJomxLnNZ229bgnqB3d3KpP8lHEfkOcs/0A4GwzGo7MkhYp8GTbB0L3kEIjq7D0Ksk796+4=
X-Received: by 2002:a25:bf86:0:b0:671:3607:1381 with SMTP id
 l6-20020a25bf86000000b0067136071381mr10459045ybk.355.1660963055173; Fri, 19
 Aug 2022 19:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220817204015.31420-1-pvorel@suse.cz> <Yv4MBF79PnJKJbwm@yuki>
 <Yv4eiT5L+M7dMkQ5@pevik> <Yv4i0gWiHTkfWB5m@yuki>
 <CAMuHMdUMBjCTwPu7wxrnagXnbyVxxmXN+vHmML0Lr=SyrTw0nQ@mail.gmail.com>
 <Yv/kVXSK0xJGb3RO@pevik>
In-Reply-To: <Yv/kVXSK0xJGb3RO@pevik>
From: Li Wang <liwang@redhat.com>
Date: Sat, 20 Aug 2022 10:37:24 +0800
Message-ID: <CAEemH2ehh1+WPtwjzere-JEHeBUpg27w4nZs6_QG71ZTAkUzpA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [RFC PATCH 1/1] API: Allow to use xfs
 filesystems < 300 MB
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
Cc: "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, automated-testing@yoctoproject.org,
 LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: multipart/mixed; boundary="===============0152339265=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0152339265==
Content-Type: multipart/alternative; boundary="000000000000e3a2f705e6a318b1"

--000000000000e3a2f705e6a318b1
Content-Type: text/plain; charset="UTF-8"

Hi Petr, All,

On Sat, Aug 20, 2022 at 3:28 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> > Hi Cyril,
>
> > On Thu, Aug 18, 2022 at 1:28 PM Cyril Hrubis <chrubis@suse.cz> wrote:
> > > > > I'm starting to wonder if we should start tracking minimal FS size
> per
> > > > > filesystem since btrfs and xfs will likely to continue to grow and
> with
> > > > > that we will end up disabling the whole fs related testing on
> embedded
> > > > > boards with a little disk space. If we tracked that per filesystem
> we
> > > > > would be able to skip a subset of filesystems when there is not
> enough
> > > > > space. The downside is obviously that we would have to add a bit
> more
> > > > > complexity to the test library.
>
> > > > Maybe I could for start rewrite v2 (I've sent it without Cc kernel
> devs now it's
> > > > mainly LTP internal thing) as it just to have 300 MB for XFS and 256
> MB for the
> > > > rest. That would require to specify filesystem when acquiring device
> (NULL would
> > > > be for the default filesystem), that's would be worth if embedded
> folks counter
> > > > each MB. It'd be nice to hear from them.
>
> > > The 256MB limit was set previously due to btrfs, I bet that we can
> > > create smaller images for ext filesytems for example.
>
> Thanks for input, Geert!
>
> > Yeah, we used to have ext2 root file systems that fit on 1440 KiB
> floppies.
> These nice times when everything simple hadn't been solved yet ... :).
> > IIRC, ext3 does have a minimum size of 32 MiB or so.
> Interesting, I was able to create smaller.
>
> I did some testing minimal size (verified on chdir01 test):
> XFS: 300 MB, btrfs: 109 MB, ntfs: 2 MB, ext3: 2 MB, ext[24]: 1 MB, vfat: 1
> MB, exfat: 1 MB.
>
> I guess using XFS: 300 MB, btrfs: 109 MB and 16 MB for the rest could be
> enough.
>

I think so, tracking minimal FS size per FS is a practical idea.
But one thing we have to be aware of is that there may be different
minimal sizes for each FS version.
(so we'd better choose the maximum of minimal sizes).

16MB for general FS should be fine, I will help to test that if someone
works out the patch.



> But that would require to run all tests to see how many tests actually use
> bigger data.
>

Absolutely YES!

-- 
Regards,
Li Wang

--000000000000e3a2f705e6a318b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Petr, All,</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 20, 2022 at 3:28 AM Petr Vorel=
 &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
&gt; Hi Cyril,<br>
<br>
&gt; On Thu, Aug 18, 2022 at 1:28 PM Cyril Hrubis &lt;<a href=3D"mailto:chr=
ubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt; wrote:<br>
&gt; &gt; &gt; &gt; I&#39;m starting to wonder if we should start tracking =
minimal FS size per<br>
&gt; &gt; &gt; &gt; filesystem since btrfs and xfs will likely to continue =
to grow and with<br>
&gt; &gt; &gt; &gt; that we will end up disabling the whole fs related test=
ing on embedded<br>
&gt; &gt; &gt; &gt; boards with a little disk space. If we tracked that per=
 filesystem we<br>
&gt; &gt; &gt; &gt; would be able to skip a subset of filesystems when ther=
e is not enough<br>
&gt; &gt; &gt; &gt; space. The downside is obviously that we would have to =
add a bit more<br>
&gt; &gt; &gt; &gt; complexity to the test library.<br>
<br>
&gt; &gt; &gt; Maybe I could for start rewrite v2 (I&#39;ve sent it without=
 Cc kernel devs now it&#39;s<br>
&gt; &gt; &gt; mainly LTP internal thing) as it just to have 300 MB for XFS=
 and 256 MB for the<br>
&gt; &gt; &gt; rest. That would require to specify filesystem when acquirin=
g device (NULL would<br>
&gt; &gt; &gt; be for the default filesystem), that&#39;s would be worth if=
 embedded folks counter<br>
&gt; &gt; &gt; each MB. It&#39;d be nice to hear from them.<br>
<br>
&gt; &gt; The 256MB limit was set previously due to btrfs, I bet that we ca=
n<br>
&gt; &gt; create smaller images for ext filesytems for example.<br>
<br>
Thanks for input, Geert!<br>
<br>
&gt; Yeah, we used to have ext2 root file systems that fit on 1440 KiB flop=
pies.<br>
These nice times when everything simple hadn&#39;t been solved yet ... :).<=
br>
&gt; IIRC, ext3 does have a minimum size of 32 MiB or so.<br>
Interesting, I was able to create smaller.<br>
<br>
I did some testing minimal size (verified on chdir01 test):<br>
XFS: 300 MB, btrfs: 109 MB, ntfs: 2 MB, ext3: 2 MB, ext[24]: 1 MB, vfat: 1 =
MB, exfat: 1 MB.<br>
<br>
I guess using XFS: 300 MB, btrfs: 109 MB and 16 MB for the rest could be en=
ough.<br></blockquote><div><br></div><div><div class=3D"gmail_default" styl=
e=3D"font-size:small">I think so,  tracking minimal FS size per FS is a pra=
ctical=C2=A0idea.</div></div><div class=3D"gmail_default" style=3D"font-siz=
e:small">But one thing we have to be aware of is that there may be differen=
t</div><div class=3D"gmail_default" style=3D"font-size:small">minimal sizes=
 for each FS version.</div><div class=3D"gmail_default" style=3D"font-size:=
small">(so we&#39;d better choose the maximum of minimal sizes).</div><div =
class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"g=
mail_default" style=3D"font-size:small">16MB for general FS should be fine,=
 I will help to test that if someone works out the patch.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
But that would require to run all tests to see how many tests actually use<=
br>
bigger data.<br></blockquote><div><br></div><div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Absolutely YES!</div></div></div><div><br></di=
v>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>R=
egards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000e3a2f705e6a318b1--


--===============0152339265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0152339265==--

