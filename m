Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41467C28D13
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 02:03:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A387C3CA2BD
	for <ltp@archiver.kernel.org>; Sat, 20 Aug 2022 04:03:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C7C63C136F
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 04:03:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8AB9A2000A9
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 04:03:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660960996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wZ8kWEcjdqljQcZ51MdXIGb/VHDmNvY0jFenJYgb3qM=;
 b=PZo3ZCqSjs7YhyNLtAvvCIm3m4kJkR3FL6BoLb0SI34qSxLpXpP4A9M7ZAWBybky0JpRs1
 VUfunWGSj9bS96wq6Om30382sQr9vsOY5Rl0OlnBBJn3MbFLe13yQHRFPYD95AIGpj0Lyi
 /rvwi3JZZ6jD341S2tcGG1gYN6grq8E=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-73-dBp-jBypPnKPj7hm7Jn_8w-1; Fri, 19 Aug 2022 22:03:14 -0400
X-MC-Unique: dBp-jBypPnKPj7hm7Jn_8w-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-337ed9110c2so60456257b3.15
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 19:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=wZ8kWEcjdqljQcZ51MdXIGb/VHDmNvY0jFenJYgb3qM=;
 b=ntRwn5gFYRinOXhv608sGP+Cfryd49N9ovmw4yIebpXRgCkmAUrzFsNBPb5lmmwHnf
 Qt1RlP+QhuDA0HmirjApj/rv8JihrF7Ej6JDKLirPyb1usgrOde4wCShrtbP/jmwekhv
 dsGct5fvzRh9qRdThAX4FrVDlABcBwhLjPnnkyW4KuigtVJ1c816yCkSFjePm1d3xqW7
 32/fKPHiqi3CINAv0XLoZsid7vUWcvqrflNRWOm2l+IaGk76v13+1ghqBNs8j/vhhryI
 IAKyNligG1kV+ZxCla3kFbzWcXvkSS5JYvbztYEC4wDOl1uJufy6bD8zq55RkDp3veH6
 7S1A==
X-Gm-Message-State: ACgBeo1EvAUaVEAhM3j+3WVo8fUgasfg164q4YTIJmRzzlQc5c0/xLLX
 CE2lO9mvjPxLIqjScbEOcNqGdwrArNf7Z5lrY4Mtu5zfFXsaj4w+r71bxQSSlYYdmG6jQXj8XZo
 WXqSOsmXH00K3MQUp0UCw9XZDrtQ=
X-Received: by 2002:a05:6902:1003:b0:676:f857:2adc with SMTP id
 w3-20020a056902100300b00676f8572adcmr10746709ybt.186.1660960994091; 
 Fri, 19 Aug 2022 19:03:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7x2LiDsg6jJf32Ok8Y8bGBAGaL4v7JOTRowyW7zZ5bYVKcbjET9kngJ4A+1VsFxrxK5171yGn160mQVf4wI/8=
X-Received: by 2002:a05:6902:1003:b0:676:f857:2adc with SMTP id
 w3-20020a056902100300b00676f8572adcmr10746695ybt.186.1660960993830; Fri, 19
 Aug 2022 19:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220819090704.17219-1-pvorel@suse.cz>
 <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
 <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com>
 <CAEemH2d97boX8x3+XKS23djO93S3+og+5r9RDFp3gzo97mMp+A@mail.gmail.com>
 <75b595dd-fdcb-73db-0e71-d36d665bbad8@fujitsu.com> <Yv+fBabMjCy3CLlo@pevik>
In-Reply-To: <Yv+fBabMjCy3CLlo@pevik>
From: Li Wang <liwang@redhat.com>
Date: Sat, 20 Aug 2022 10:03:02 +0800
Message-ID: <CAEemH2ddjBnyWXt5J-u7qb7DJmQbehVAHXYF50CTWtm74DiFOA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] statx04: Remove kernel comments in docparse
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============0290138250=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0290138250==
Content-Type: multipart/alternative; boundary="000000000000060a9505e6a29e22"

--000000000000060a9505e6a29e22
Content-Type: text/plain; charset="UTF-8"

Hi Xu, Petr,

Petr Vorel <pvorel@suse.cz> wrote:

> I remember Amir also added a similar feature[1] to xfstests when he
> > become xfs 5.10 stable kernel maintainer.
>
> > So maybe we can add a third colume in tst_test struct's tag field  to
> > cover kernel commit title? Then this kernel comment can be removed.
>

We can achieve that but the complexity outweighs the benefits (for LTP).


>
> Amir got inspiration from LTP, but I'm not a big fan of adding manually git
> subject which is now added by script.  Also I'd like to address the change
> we
> agree also in fanotify sources.


> > Also, I don't have strong obejection to this patch because it seems
> > duplicate, but I just want to keep kernel commit title by using simple
> way.
>
> I also wonder why people add commits in this verbose form:
>

That's legacy way in writing comments, but obviously it need unify in format
for better management in future.



>
>  *  commit 93bc420ed41df63a18ae794101f7cbf45226a6ef
>  *  Author: yangerkun <yangerkun@huawei.com>
>  *  Date:   Mon Feb 18 09:07:02 2019 +0800
>  *
>  *  ext2: support statx syscall
>
> If commits are really necessary I'd add them inline, i.e.:
>
> $ git log --pretty=format:'%h ("%s")' -1 93bc420ed41d
> 93bc420ed41d ("ext2: support statx syscall")
>

+1, at most we add this format in normal C comments.
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fanotify/fanotify14.c#L17



> But again, having git hash at the bottom and then full commit on the top
> looks
> to me just a redundancy (I often want to see changes in kernel thus run
> git show
> hash anyway + there is that link in docparse.
>

me as well.

-- 
Regards,
Li Wang

--000000000000060a9505e6a29e22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Xu, Petr,</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Petr Vorel &lt;<a href=3D"mailto:pvorel@sus=
e.cz">pvorel@suse.cz</a>&gt; wrote:<br></div><div><br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
&gt; I remember Amir also added a similar feature[1] to xfstests when he <b=
r>
&gt; become xfs 5.10 stable kernel maintainer.<br>
<br>
&gt; So maybe we can add a third colume in tst_test struct&#39;s tag field=
=C2=A0 to <br>
&gt; cover kernel commit title? Then this kernel comment can be removed.<br=
></blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"fon=
t-size:small">We can achieve=C2=A0that but the complexity outweighs the ben=
efits (for LTP).<br></div></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
Amir got inspiration from LTP, but I&#39;m not a big fan of adding manually=
 git<br>
subject which is now added by script.=C2=A0 Also I&#39;d like to address th=
e change we<br>
agree also in fanotify sources.=C2=A0</blockquote><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
&gt; Also, I don&#39;t have strong obejection to this patch because it seem=
s <br>
&gt; duplicate, but I just want to keep kernel commit title by using simple=
 way.<br>
<br>
I also wonder why people add commits in this verbose form:<br></blockquote>=
<div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">=
That&#39;s legacy=C2=A0way in writing=C2=A0comments, but obviously=C2=A0it =
need unify in format</div><div class=3D"gmail_default" style=3D"font-size:s=
mall">for better management in future.</div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0*=C2=A0 commit 93bc420ed41df63a18ae794101f7cbf45226a6ef<br>
=C2=A0*=C2=A0 Author: yangerkun &lt;<a href=3D"mailto:yangerkun@huawei.com"=
 target=3D"_blank">yangerkun@huawei.com</a>&gt;<br>
=C2=A0*=C2=A0 Date:=C2=A0 =C2=A0Mon Feb 18 09:07:02 2019 +0800<br>
=C2=A0*<br>
=C2=A0*=C2=A0 ext2: support statx syscall<br>
<br>
If commits are really necessary I&#39;d add them inline, i.e.:<br>
<br>
$ git log --pretty=3Dformat:&#39;%h (&quot;%s&quot;)&#39; -1 93bc420ed41d<b=
r>
93bc420ed41d (&quot;ext2: support statx syscall&quot;)<br></blockquote><div=
><br></div><div class=3D"gmail_default" style=3D"font-size:small">+1, at mo=
st we add this format in normal C comments.</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small"><a href=3D"https://github.com/linux-test-proje=
ct/ltp/blob/master/testcases/kernel/syscalls/fanotify/fanotify14.c#L17">htt=
ps://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscall=
s/fanotify/fanotify14.c#L17</a></div><div class=3D"gmail_default" style=3D"=
font-size:small"><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
But again, having git hash at the bottom and then full commit on the top lo=
oks<br>
to me just a redundancy (I often want to see changes in kernel thus run git=
 show<br>
hash anyway + there is that link in docparse.<br></blockquote><div>=C2=A0</=
div><div><div class=3D"gmail_default" style=3D"font-size:small">me as well.=
</div></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div=
></div></div>

--000000000000060a9505e6a29e22--


--===============0290138250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0290138250==--

