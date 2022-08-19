Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAABC32771
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 12:42:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8EA383CA255
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 14:42:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9BC73C2A8C
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 14:42:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BBC561A0024E
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 14:42:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660912960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cnBAOiGZdpZKmBG2YuaNcCj9W85kZ/fBgboGY2V5Qwg=;
 b=fPu+krcQ0zlxFb4pTVND1lepAVr4X5rXOIW8EmCShAWVxVHJc4WnfskPj0WV1QfmPPWixe
 /OMUw+wQ7yzfR3x6xkdJyiYQtPj0GQB9ZRhB7IeL1TrbGkIVXo/Sw6j2nAGhL4zEsJtE5S
 TuTsqqcRXiA+r1qKcUrSlYRy9b/dIFE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-3xzUrL11PpC_j40Ej0JTiA-1; Fri, 19 Aug 2022 08:42:39 -0400
X-MC-Unique: 3xzUrL11PpC_j40Ej0JTiA-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-3339532b6a8so75556727b3.1
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 05:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=cnBAOiGZdpZKmBG2YuaNcCj9W85kZ/fBgboGY2V5Qwg=;
 b=yNoNQjkfgOS4YbZ3W6EuU16ewNdbj9xVxTWi+r9tkEuaN7vfO94OVRE3YSBkD+Muyy
 OZJXO/62u02c5YBuH3aBkm9x9aibsq5DI9QyJepDWYZlFgvOZF+1LDWzZG8EnZcvwHbI
 DQHCl4nbJOh42Lk6CaTT2P+XwbLrmUx7hp6BkrC8VjOBoDo0Jr4tdBZSqzqgfPYT72Nn
 1jedfF63NlX6NQsbm3qixJVjQ5tqArxtZPyLLyMGNupv3QFkEv1EsBFmg18dtaBrRs+/
 FDgZt4nPh63cr3XC2UYtYcFyzoQOq12e7+Sk0A2qUGdhSyW/TV+iDwhvIFHkDGVKByTz
 8pCA==
X-Gm-Message-State: ACgBeo0E5BckDbhMT5umtCqPy7ZWDvfHZfYGI6Ynaicz8tp4zO0KCSGE
 QVVKvyVYq65O94SmQEyYXxptsVyQmyeqO858t/SKzXSyruOINqp1LBasQRfbFQfe+KsOuQZgnpx
 fzG8pwj6pQHPWFz5pr0GMHy+c4co=
X-Received: by 2002:a25:bf86:0:b0:671:3607:1381 with SMTP id
 l6-20020a25bf86000000b0067136071381mr7492730ybk.355.1660912958058; 
 Fri, 19 Aug 2022 05:42:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4Sxl0s3tqDqyD5545Wb6IbmlClZHxts6Rarxb1Z/KfHbfdQbh50hhj0VcjvkhrY5ypTSeDIf7D9bgoR8XKC4k=
X-Received: by 2002:a25:bf86:0:b0:671:3607:1381 with SMTP id
 l6-20020a25bf86000000b0067136071381mr7492716ybk.355.1660912957809; Fri, 19
 Aug 2022 05:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220819090704.17219-1-pvorel@suse.cz>
 <950bbc2f-1af9-581b-c7a2-e6d39fc276ec@fujitsu.com>
 <269bbc89-2a89-9eac-e4f9-69b66a862a23@fujitsu.com> <Yv9ykCw5VDoXaCmD@pevik>
In-Reply-To: <Yv9ykCw5VDoXaCmD@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Aug 2022 20:42:26 +0800
Message-ID: <CAEemH2eHrBkwZBVyM7Rxnxt7c3U7dh5-AjL9GhDDh4JWspTjQA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1038020146=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1038020146==
Content-Type: multipart/alternative; boundary="000000000000da7f4405e6976e8f"

--000000000000da7f4405e6976e8f
Content-Type: text/plain; charset="UTF-8"

Hi Xu, Petr,

On Fri, Aug 19, 2022 at 7:23 PM Petr Vorel <pvorel@suse.cz> wrote:


> > So for me, If remove kernel commit in description, then I only see
> > useless commit id number, unless I go to search them in kernel org.
>
> > I prefer to keep these kernel commit comment.
>

If so, adding normal C comments should be a workaround
(as Petr proposed), but I doubt how much value for reserving that:).


>
> I would still suggest to have change them as normal C comments - that's
> enough
> for reading C source. We already added released docs to
> linux-test-project.github.io [1], I plan to add hook to to push master
> version
> there after each commit and stable after release (after pushing tag).
> Then we can add this link to README.md to propagate docs.
>

+1, sounds good to me, thanks!

-- 
Regards,
Li Wang

--000000000000da7f4405e6976e8f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Xu, Petr,</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 19, 2022 at 7:23 PM Petr Vorel =
&lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; So for me, If remove kernel commit in description, then I only see<br>
&gt; useless commit id number, unless I go to search them in kernel org.<br=
>
<br>
&gt; I prefer to keep these kernel commit comment.<br></blockquote><div><br=
></div><div><div class=3D"gmail_default" style=3D"font-size:small">If so, a=
dding normal C comments should be a workaround</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">(as Petr proposed), but I doubt how much va=
lue for reserving that:).</div></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
I would still suggest to have change them as normal C comments - that&#39;s=
 enough<br>
for reading C source. We already added released docs to<br>
<a href=3D"http://linux-test-project.github.io" rel=3D"noreferrer" target=
=3D"_blank">linux-test-project.github.io</a> [1], I plan to add hook to to =
push master version<br>
there after each commit and stable after release (after pushing tag).<br>
Then we can add this link to README.md to propagate docs.<br></blockquote><=
div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">+=
1, sounds good to me, thanks!</div></div></div><div><br></div>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></di=
v><div>Li Wang<br></div></div></div></div>

--000000000000da7f4405e6976e8f--


--===============1038020146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1038020146==--

