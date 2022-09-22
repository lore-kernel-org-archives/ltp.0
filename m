Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB0CC6FA82
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 09:09:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA10B3CAD53
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 11:09:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFAC93C91A6
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:08:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 39976602461
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 11:08:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663837735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X0ueKc0FoCdxUiB0LMzuVt/JCSrAHbB2wjRbGt1VZ24=;
 b=JocGZg4cbXU7S1nca1ckeM6ymRmjr7A9gOSwE3wqKiwSQjfSPwu8xqreJfJ560er1Rdw82
 Sh656rRi8rEPQPdluLVsEL1zXYwhxUbAyuMzpazLdGmldm/iJg4pJN8hRVfj6jO1WcCmOZ
 uDgwaCe0Sy6MwgL9Fw3Gn6wTv+z71B4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-389-6_q1g1UXNMOraat8i7qpmQ-1; Thu, 22 Sep 2022 05:08:54 -0400
X-MC-Unique: 6_q1g1UXNMOraat8i7qpmQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 y15-20020a1c4b0f000000b003b47578405aso514227wma.5
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 02:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=X0ueKc0FoCdxUiB0LMzuVt/JCSrAHbB2wjRbGt1VZ24=;
 b=eVkfdQgp77bN9uWtrpRV7J+qR9gmpAZ0lbikj3iYzxcjssMzOuQtGQ/DRv38CamBu9
 X8Ub/SAG/9pQOVxuuKyKgk8KE5swO07idOo4xRxFx9lJgDd3mg17p33RtOQClYBbHph7
 mXw1UPrkgqF8/tNvfhCRWSzLtld8ot/wsgEUlXd5xTPp/+WMjUc9r6OdeCgnoKhwpB4D
 0OwVt5pebU+SKw8MR6lNJGYS1Tzbn6QewpAS8Y3jXAR5xzmjonGG7SAk5TOb7N8kJ6M1
 Dy/TIca6xGs1K0ohX1hb6vAZ3cjb7xZImA74uFnjXViDCB3FC8pibnsF8ku+A7rL2fCE
 tZng==
X-Gm-Message-State: ACrzQf0MnsYqa0OaxEno93+NKY9AA74jhVfCHCjWS0NIuiXHbB8uiyaU
 ybN6Tx6OFP2vXSHf5Nyw/eLfiLG1tqNLhHuU2thRMsBg3eP2lh2LctRVqAN09nESBXfQwI8yvCv
 N0WHU8pbmfijE6TZJbYB4zWs3jgw=
X-Received: by 2002:a5d:5a01:0:b0:229:3d5f:322f with SMTP id
 bq1-20020a5d5a01000000b002293d5f322fmr1311100wrb.707.1663837732836; 
 Thu, 22 Sep 2022 02:08:52 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zlgcDeeZVNcAmt73p+xzlzyOqjWpnncbfSa0cu/YJjiFl3cu40UQE52YzvMqUFKU7qNoFCJTrs8Spp82pXt8=
X-Received: by 2002:a5d:5a01:0:b0:229:3d5f:322f with SMTP id
 bq1-20020a5d5a01000000b002293d5f322fmr1311090wrb.707.1663837732625; Thu, 22
 Sep 2022 02:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
 <b1a19673-de0b-d6e0-0434-3eb457aaf69d@suse.cz> <YywgNSfv58iIvFbq@pevik>
In-Reply-To: <YywgNSfv58iIvFbq@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Sep 2022 17:08:40 +0800
Message-ID: <CAEemH2dcmX4uPHWUABO-UfYXP9rbQ4FT+CQzKFksnn0xQZ71ow@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1123877174=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1123877174==
Content-Type: multipart/alternative; boundary="000000000000047a6805e940695e"

--000000000000047a6805e940695e
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 22, 2022 at 4:44 PM Petr Vorel <pvorel@suse.cz> wrote:

> > On 22. 09. 22 6:16, Li Wang wrote:
> > >                      if (skiplist) {
> > >     -                       if (tst_fs_in_skiplist(argv[optind],
> (const char * const*)skiplist))
> > >     -                               tst_brk(TCONF, "%s is skipped",
> argv[optind]);
> > >     +                       if (tst_fs_in_skiplist(fsname, (const char
> * const*)skiplist))
> > >     +                               tst_brk(TCONF, "%s is skipped",
> fsname);
>
>
> > > TCONF does not means return 1, we might need explicitly 'return 1'
> here.
>
> > Yes, but that's a problem which already existed before my patch and
> affects
> > the other single-FS checks as well. The fix should go into a separate
> patch
> > after release.
>
> Yes, that's not related. I changed it in eb47b4497 ("tst_supported_fs:
> Support
> skip list when query single fs") as with 32 one can detect it's TCONF.
> As long as 0 is success, non-zero for failure.
>

Looks like there is no difference to use whatever 32 or 1, as long as
it's a non-zero, it will work well in the shell.

Ok, I agree to update the doc (also usage() should be updated) later.

Reviewed-by: Li Wang <liwang@redhat.com>



> But I forget to update doc.
>
> Thus I'll wait for feedback from others whether we should get back to 1 as
> error
> (thus use TINFO) or update doc to mention to exit 32 (or more generally
> non-zero
> exit).
> very nit: I'd use exit instead of return in docs.
>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang

--000000000000047a6805e940695e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Sep 22, 2022 at 4:44 PM Petr Vorel &lt;<a h=
ref=3D"mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; On 22. 0=
9. 22 6:16, Li Wang wrote:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (skiplist) {<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_fs_in_skiplist(argv[optind], =
(const char * const*)skiplist))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(T=
CONF, &quot;%s is skipped&quot;, argv[optind]);<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_fs_in_skiplist(fsname, (const=
 char * const*)skiplist))<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(T=
CONF, &quot;%s is skipped&quot;, fsname);<br>
<br>
<br>
&gt; &gt; TCONF does not means return 1, we might need explicitly &#39;retu=
rn 1&#39; here.<br>
<br>
&gt; Yes, but that&#39;s a problem which already existed before my patch an=
d affects<br>
&gt; the other single-FS checks as well. The fix should go into a separate =
patch<br>
&gt; after release.<br>
<br>
Yes, that&#39;s not related. I changed it in eb47b4497 (&quot;tst_supported=
_fs: Support<br>
skip list when query single fs&quot;) as with 32 one can detect it&#39;s TC=
ONF.<br>
As long as 0 is success, non-zero for failure.<br></blockquote><div><br></d=
iv><div><div class=3D"gmail_default" style=3D"font-size:small">Looks like t=
here is no difference to use whatever 32 or 1, as long as</div><div class=
=3D"gmail_default" style=3D"font-size:small">it&#39;s a non-zero, it will w=
ork well in the shell.</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Ok=
, I agree=C2=A0to update the doc (also usage() should be updated) later.</d=
iv><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Re=
viewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blan=
k">liwang@redhat.com</a>&gt;</div><br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
But I forget to update doc.<br>
<br>
Thus I&#39;ll wait for feedback from others whether we should get back to 1=
 as error<br>
(thus use TINFO) or update doc to mention to exit 32 (or more generally non=
-zero<br>
exit).<br>
very nit: I&#39;d use exit instead of return in docs.<br>
<br>
Kind regards,<br>
Petr<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--000000000000047a6805e940695e--


--===============1123877174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1123877174==--

