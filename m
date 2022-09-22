Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC54C6FA86
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 09:25:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86B763CAD62
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 11:25:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E93703C91A6
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:25:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 615B3200DFA
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663838699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wOT8zChPAu1wq1V/ao4saD05jXhtv0iD4xo4wTTa97U=;
 b=e8fOC9aj6eTzLdymAQz3qf2qCBkmM1zkpTZQ9DDq3ObjWM75vsXJhytS5v59uONEq0pmWr
 AOODZOm+x+8OcNV3sqF5mrWzYslxORSfC03sfxOaBXyafZqW/BlGJbOygWB8jzutj/H/W1
 YVwhok9gaHprBs44pXq9APsTVqziKZw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-vszgVTBQO6Smwz8GcvMXxQ-1; Thu, 22 Sep 2022 05:24:56 -0400
X-MC-Unique: vszgVTBQO6Smwz8GcvMXxQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 g19-20020adfa493000000b0022a2ee64216so3086339wrb.14
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 02:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=wOT8zChPAu1wq1V/ao4saD05jXhtv0iD4xo4wTTa97U=;
 b=8Q0iOJm8aBRrTE9hOFPUAsFT9g/klkdtnsHJrDEFttcsmKSwItKeZX7u5f7Mp0xQ/c
 FwFCtLA0DF+tvw3HUFAG+azFamAUgnDyHaDgkQm6nBqyv0Cswa5VFbDBYh9NpfdJRtFx
 0tjoSINeHAAf7TeCSlOdCf7un/SyClOVuKL3wAwaV7FidyeTR64HmbwFw1Qjqu2kZGfV
 dx86WNvFfDU7PXxZhiVuF2TM70WiKHPFaCxNm/afRZPQFAnmZZ2cgs1d8vtcXJEctWP6
 TwnI+s3FW9jMfdaTe/GMmXWr97FvOrtrlsbxHHL4aECpWR/9wSi4+GPwqLHc1nPCi7n9
 r7CA==
X-Gm-Message-State: ACrzQf1cIiwSXFdGEhORDeD49HSV99HepaiAgpV2cwdU18bQA2Mx0ERj
 52HDLEAJ3752B7HfDnWWc9UBKpquIDCs1F60es641K0q0ktNiOGUG5RKSygkABnsuftLpAjAjE+
 5V4CjDnPTPccy6yMgRn77TMKSn+Q=
X-Received: by 2002:a05:600c:4e4f:b0:3b4:d6e7:168a with SMTP id
 e15-20020a05600c4e4f00b003b4d6e7168amr1622002wmq.168.1663838695223; 
 Thu, 22 Sep 2022 02:24:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5nQ8aDrMjzFK9htkBEOQYzJhd5kYKC78CTED4kcktvUlHPfVxetzIWL8LnVM3QwZIlTpUmJxHLQ+jvcOP1pfM=
X-Received: by 2002:a05:600c:4e4f:b0:3b4:d6e7:168a with SMTP id
 e15-20020a05600c4e4f00b003b4d6e7168amr1621990wmq.168.1663838695051; Thu, 22
 Sep 2022 02:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
 <YywknXj4nL48PaR6@pevik>
In-Reply-To: <YywknXj4nL48PaR6@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Sep 2022 17:24:43 +0800
Message-ID: <CAEemH2fy8zK1ABe5PrqFM=0J6s6oyPPva8pN9MF=2OrXEPcT2A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1345917085=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1345917085==
Content-Type: multipart/alternative; boundary="00000000000061f16905e940a241"

--00000000000061f16905e940a241
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 22, 2022 at 5:03 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi all,
>
> > > Although the tst_fs_type_name() functions could use some improvements,
> > > e.g. ext4 must be specified in skiplist as "ext2/ext3/ext4" to get
> properly
>
> > Yes, that's true, we need to make it keep consistent with two
> > skipping ways. Otherwise below test output "ext2/ext3/ext4"
> > looks like a bit mess to remember.
>
> > Better going with a single FS for matching (i.e. "ext4" for both fs_type
> > and '-d path').
> > But we can solve this in a separate patch later.
>
> > $ df -T . | tail -1 | awk '{print $2}'
> > ext4
>
> > $ ./tst_supported_fs -s "ext4" ext4
> > tst_supported_fs.c:135: TCONF: ext4 is skipped
> > $ echo $?
> > 32
>
> > $ ./tst_supported_fs -s "ext4" -d .
> > tst_supported_fs.c:137: TINFO: ext2/ext3/ext4 is not skipped
> > $ echo $?
> > 0
>
> > $ ./tst_supported_fs -s "ext2/ext3/ext4" -d .
> > tst_supported_fs.c:135: TCONF: ext2/ext3/ext4 is skipped
> > $ echo $?
> > 32
>
> The same problem is for .skip_filesystems on tests which does not use
> .all_filesystems. We only haven't noticed, because there was no reason to
> skip
> ext[234] so far. I'm looking into this.
>

This seems a bit tricky to distinguish EXT2,3,4, from what I know,
they use the same magic number. It will be difficult to get the
FS block and extract smaller granularity of feature without
using fs helper tools.



>
> BTW .skip_filesystems without .all_filesystems have other problems, e.g.
> using
> filesystems which aren't in fs_type_whitelist[] array (e.g. ramfs, nfs).
> That'd be nice to fix after the release.
>

+1


-- 
Regards,
Li Wang

--00000000000061f16905e940a241
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Sep 22, 2022 at 5:03 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi all,<br>
<br>
&gt; &gt; Although the tst_fs_type_name() functions could use some improvem=
ents,<br>
&gt; &gt; e.g. ext4 must be specified in skiplist as &quot;ext2/ext3/ext4&q=
uot; to get properly<br>
<br>
&gt; Yes, that&#39;s true, we need to make it keep consistent with two<br>
&gt; skipping ways. Otherwise below test output &quot;ext2/ext3/ext4&quot;<=
br>
&gt; looks like a bit mess to remember.<br>
<br>
&gt; Better going with a single FS for matching (i.e. &quot;ext4&quot; for =
both fs_type<br>
&gt; and &#39;-d path&#39;).<br>
&gt; But we can solve this in a separate patch later.<br>
<br>
&gt; $ df -T . | tail -1 | awk &#39;{print $2}&#39;<br>
&gt; ext4<br>
<br>
&gt; $ ./tst_supported_fs -s &quot;ext4&quot; ext4<br>
&gt; tst_supported_fs.c:135: TCONF: ext4 is skipped<br>
&gt; $ echo $?<br>
&gt; 32<br>
<br>
&gt; $ ./tst_supported_fs -s &quot;ext4&quot; -d .<br>
&gt; tst_supported_fs.c:137: TINFO: ext2/ext3/ext4 is not skipped<br>
&gt; $ echo $?<br>
&gt; 0<br>
<br>
&gt; $ ./tst_supported_fs -s &quot;ext2/ext3/ext4&quot; -d .<br>
&gt; tst_supported_fs.c:135: TCONF: ext2/ext3/ext4 is skipped<br>
&gt; $ echo $?<br>
&gt; 32<br>
<br>
The same problem is for .skip_filesystems on tests which does not use<br>
.all_filesystems. We only haven&#39;t noticed, because there was no reason =
to skip<br>
ext[234] so far. I&#39;m looking into this.<br></blockquote><div><br></div>=
<div><div class=3D"gmail_default" style=3D"font-size:small">This seems a bi=
t tricky to distinguish EXT2,3,4, from what I know,</div><div class=3D"gmai=
l_default" style=3D"font-size:small">they use the same magic number. It wil=
l be difficult to get the</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">FS block and extract smaller granularity of feature without</div=
><div class=3D"gmail_default" style=3D"font-size:small">using fs helper too=
ls.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
BTW .skip_filesystems without .all_filesystems have other problems, e.g. us=
ing<br>
filesystems which aren&#39;t in fs_type_whitelist[] array (e.g. ramfs, nfs)=
.<br>
That&#39;d be nice to fix after the release.<br></blockquote><div><br></div=
><div class=3D"gmail_default" style=3D"font-size:small">+1</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Re=
gards,<br></div><div>Li Wang<br></div></div></div></div>

--00000000000061f16905e940a241--


--===============1345917085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1345917085==--

