Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1352C433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 21:38:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA84B3CA31E
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 22:38:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 397863C97A4
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 22:38:08 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5BEC61000BD9
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 22:38:06 +0100 (CET)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7EA9E3F07E
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 21:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646257084;
 bh=fFC8FEhiOt5YbKwSiUsNeIDoDtppWw9s9Ho/04DWsfU=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=PGFX0zUh7nWLBhSjjQ+fMigOjO1ZBystuntYmt7LubegggwZMHDhx+lIEzJsmR8Uf
 PpjAT25Xzq2XZjX+ydAkN/OzrME9KYumSOmnCXb1V9csIGmrjtsw+INCU+cf2gs8Be
 N3dBkNkjMfyzM7rQh5v/J8gkp6We08fb2IsVeTMlOTXjasQ4rt8whuhu92IQCa9lGu
 3l9bgv0TYSMa28WVToyv8f4E6bmKNGwsCGgwysU9tgvK7VCuNEHQS+Ah13tCBtaKx3
 de8wfoa3mcmNmdTVh2wMGoR9sX4QNRTmGOY83CYm8hMKATDJGuNseGbBwNVsfO655u
 YpdVANXGo+V8A==
Received: by mail-ed1-f70.google.com with SMTP id
 z24-20020a50cd18000000b00414d5314c35so1686679edi.21
 for <ltp@lists.linux.it>; Wed, 02 Mar 2022 13:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fFC8FEhiOt5YbKwSiUsNeIDoDtppWw9s9Ho/04DWsfU=;
 b=fszFOP7XuZXj3R4zf/tLv2y7LkmIP82QDc5Th3KIVQIsqTEMokrQ57mJXsz39chc6J
 a7fH7DsChFvZUTwXjfk7yu2TitZv8ljfbdKkCfdAmu4pEOKZgfDg3mNoHhNkQDngRP2I
 inwjS9WRENcbMZwSf6eh5foPrFZsmOCFAJi/Ff3ma66uCApOZeU8wXxILMT8sWL4NMZ1
 TeB305MfipMeAPmC2tQXdCc7EGJKauFqogxhPaJpykBUG7sv0Factk5rwd+3cfFYqgDn
 UPuHaMpFNeE+JSBe9jeSOVX2r+0NH0XDzgehYYeHOnJsfikWZj+sRi50Ph/Gx8NM65zu
 KA7g==
X-Gm-Message-State: AOAM532WL6EJXBePtzvXpvniLEMqXcZvJn2DZ+7d1E6xjlG4F/+PfHCa
 /ZOJFh9dMx0wZkd60SRZ17MAkLwKKjkgTyGqh/va5qeFK8CW5EtDSX2bWwsDxFVKy9Q1C7Rm3Tq
 v5GNmhjQ1EVmkQMZZnPJEtF4j26CcU9nOoyr7UzFkA969
X-Received: by 2002:a17:907:8692:b0:6da:866c:6355 with SMTP id
 qa18-20020a170907869200b006da866c6355mr1336333ejc.174.1646257084018; 
 Wed, 02 Mar 2022 13:38:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmp5MWlJYHG3qYhkOicUy0m7ONGYvL9nYRoqNJrTgKA3fk4eYO/cAbwi5ug3H2xQPEobbCTFRDIO5KhM6pKGg=
X-Received: by 2002:a17:907:8692:b0:6da:866c:6355 with SMTP id
 qa18-20020a170907869200b006da866c6355mr1336322ejc.174.1646257083828; Wed, 02
 Mar 2022 13:38:03 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <3b78e25c8eba247d0ce2d99cbbdcaeba7994e26c.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2fDx-KejrtrmY_N9c+7Fbe1Btvpxe65rUPyC8Atw_=+nA@mail.gmail.com>
In-Reply-To: <CAEemH2fDx-KejrtrmY_N9c+7Fbe1Btvpxe65rUPyC8Atw_=+nA@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 2 Mar 2022 13:37:27 -0800
Message-ID: <CADS1e3cs3P-LYkKQr8T-263H5YW0WX1gsHTo3BAhYpJZuLf-=w@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 10/16] controllers: Update memcg_control_test to
 newer test lib and cgroup lib
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
Content-Type: multipart/mixed; boundary="===============1812268833=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1812268833==
Content-Type: multipart/alternative; boundary="000000000000b0eaf905d9431832"

--000000000000b0eaf905d9431832
Content-Type: text/plain; charset="UTF-8"

Hi Li,

On Mon, Jan 24, 2022 at 1:44 AM Li Wang <liwang@redhat.com> wrote:

> Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:
>
> As we already built the controller files mapping from V2 to V1
> in C library and you actually add many new (in patch 5/16).
>
> I'm thinking maybe we could make use of it in tst_cgctl.c to
> avoid handling these (in shell) separately.
>
> Something like:
>
>     # ./tst_cgctl  set  "$pid"  "cgroup.procs"  "$target_pid"
>     # ./tst_cgctl  set  "$pid"  "memory.max"  "$ACTIVE_MEM_LIMIT"
>
> Otherwise, it seems to make no sense to add so many new
> files mapping (like that patch 5/16) at this moment.
>
> What do you think?
>
>
> I think this would be nice except that we would need to keep track of the
tst_cg_cgroup structs if we wanted to use safe_cg_* functions in the C lib.
This would be fine if we only wanted to use control files in the test_dir
but it gets more complicated if there are other directories below it that
we would want to set. At least as far as I understand it.

And as Richard mentioned its probably a better idea to just only add the
control files for controllers as we absolutely need them so this wouldn't
be too useful. Plus I think it's easy enough from shell to do a version
check and write to the right control file/directory directly.

So I personally don't think its as important, but I could see in the future
implementing something like this so it mimics the C api. What do you think?


> --
> Regards,
> Li Wang
>
>
Apologies for the hiatus,  I know it's not easy to get back into review
mode for patches you haven't thought about in a while.

Thanks,
- Luke

--000000000000b0eaf905d9431832
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Li, <br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 24, 2022 at 1:44 AM Li Wang &l=
t;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Luke Nowakowski-Kri=
jger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"=
_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br>
<br>
As we already built the controller files mapping from V2 to V1<br>
in C library and you actually add many new (in patch 5/16).<br>
<br>
I&#39;m thinking maybe we could make use of it in tst_cgctl.c to<br>
avoid handling these (in shell) separately.<br>
<br>
Something like:<br>
<br>
=C2=A0 =C2=A0 # ./tst_cgctl=C2=A0 set=C2=A0 &quot;$pid&quot;=C2=A0 &quot;cg=
roup.procs&quot;=C2=A0 &quot;$target_pid&quot;<br>
=C2=A0 =C2=A0 # ./tst_cgctl=C2=A0 set=C2=A0 &quot;$pid&quot;=C2=A0 &quot;me=
mory.max&quot;=C2=A0 &quot;$ACTIVE_MEM_LIMIT&quot;<br>
<br>
Otherwise, it seems to make no sense to add so many new<br>
files mapping (like that patch 5/16) at this moment.<br>
<br>
What do you think?<br>
<br>
<br></blockquote><div>I think this would be nice except that we would need =
to keep track of the tst_cg_cgroup structs if we wanted to use safe_cg_* fu=
nctions in the C lib. This would be fine if we only wanted to use control f=
iles in the test_dir but it gets more complicated if there are other direct=
ories below it that we would want to set. At least as far as I understand i=
t.<br></div><div><br></div><div>And as Richard mentioned its probably a bet=
ter idea to just only add the control files for controllers as we absolutel=
y need them so this wouldn&#39;t be too useful. Plus I think it&#39;s easy =
enough from shell to do a version check and write to the right control file=
/directory directly.</div><div><br></div><div>So I personally don&#39;t thi=
nk its as important, but I could see in the future implementing something l=
ike this so it mimics the C api. What do you think? <br></div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
Regards,<br>
Li Wang<br>
<br></blockquote><div><br></div><div>Apologies for the hiatus,=C2=A0 I know=
 it&#39;s not easy to get back into review mode for patches you haven&#39;t=
 thought about in a while. <br></div><div><br></div><div>Thanks, <br></div>=
<div>- Luke<br></div></div></div>

--000000000000b0eaf905d9431832--

--===============1812268833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1812268833==--
