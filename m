Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A5FECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 13:08:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51B7E3C9FB1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 15:08:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C29683C04D1
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 15:08:24 +0200 (CEST)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 14BE260070E
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 15:08:24 +0200 (CEST)
Received: by mail-vk1-xa33.google.com with SMTP id x64so2443224vka.13
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OTSU39vH3bv/szfZwOpZmWCcJ+0cGmcKIYwA8nsAGVo=;
 b=bncUd60ljGUn0ddO8TBRfQZJzW8+43F8Yt7FwBUGo2AtlT3bfpCiqFIXwtz0rd2dU9
 Q/2qqnYwQiUkZVrwPcxxDvE2keA2C0mZPes/BGB0sM/9eiqTl8FeEpGSTsuM9m0TIix+
 eP56XvTtCbVzFPMN/P7SMxO2/T+Md4v5Tdpi5gmpHaBnkeSkHKfQcd1e7nhM6K/zrRWn
 j/hNBWHfLy4gwm8lR5B6dR3xnTuQJsDrPqTXZv/WlHMVsWWYdKuDJgX+M2FOP0OtxXMf
 MgBKDvqrHFL6fadU1ksM/nFMAx38fOqOjCHRT0clfkxf+FrV1vaOeAESYi8pIOcGNSzw
 Y59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OTSU39vH3bv/szfZwOpZmWCcJ+0cGmcKIYwA8nsAGVo=;
 b=2D8APAJOvVL+JPfh6Rq5xd3E/pSwV7gCbfjMdBr7/2nHdej3jd58m/0+1RnQRnq6jk
 IPPNEFoRAG1BwwAEjSEWZg1yaPUfEj3BX1Mpn8+mmDAsiM0QjdP0FcOEmQC0VIIWFVzM
 ERmgFHv8IcYISHBPNgLCExcDl3W3JyF/vo9oA1Af/oKy/F6Q5LWW3DIOp763/PQsnASJ
 8hrKQt2xMh6fJYh4958BAMHwRa6jAn4ebd46x0avNmCgUc2UDa2Uh4shyvrkiXYMvZDS
 rn9YrPfqhx4imjnrCNQaFfmwjYcsZO65G2xmx9fRvTrGuqgJgfE86NQVWiqDGJPuNFAH
 K5JA==
X-Gm-Message-State: ACrzQf1WIOiCPI0ijmvSFtoxuwcthoxeyDVhZQ20p8J4QbKMvhWFfHvE
 RtkAzgYZnHhkoFzv7s1ckgG6eLlmErnW46M98po=
X-Google-Smtp-Source: AMsMyM4TdfHq+EoNjIbg49YoyWjB4RrfkzuGZQQ2p3mrg8QRm/ngBXjvsimcBxmM6ID/1HhnhlJ9rh5XXdhlAdaVOlA=
X-Received: by 2002:a1f:a004:0:b0:398:3e25:d2a7 with SMTP id
 j4-20020a1fa004000000b003983e25d2a7mr18237912vke.36.1666616902733; Mon, 24
 Oct 2022 06:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
In-Reply-To: <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Oct 2022 16:08:10 +0300
Message-ID: <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: multipart/mixed; boundary="===============1892334374=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1892334374==
Content-Type: multipart/alternative; boundary="00000000000076d82405ebc77c02"

--00000000000076d82405ebc77c02
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 24, 2022, 12:03 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 21. 10. 22 21:03, Amir Goldstein wrote:
> > I don't have a vision of what you are proposing.
> > Make a proposal and I will see if it is correct.
> >
> > I must say I don't understand what it is that you are trying to improve.
> > All the test needs to know is if the specific combinations of flags that
> > the test uses are supported by the kernel/fs.
> >
> > Trying to figure out which of the bits from a specific combination is
> > not supported? how does that help users?
> > Maybe in kernel 5.10 flag X is supported and in kernel 5.11 flag
> > Y is also supported, but only in kernel 5.12 the combination X | Y
> > is supported? Do you see why your generic function doesn't make
> > much sense? or is just too complex to be worth the trouble
> > for an informational print?
>
> The function I'm trying to write is supposed to check whether a
> particular flag is implemented by the kernel. Whether a particular
> combination of implemented flags is also *allowed* is out of scope.
>
> Note that the test I'm writing this for is fanotify14, which checks that
> various invalid combinations of flags will correctly return error. But
> since the error code for "this flag is not implemented" and "this flag
> was used incorrectly" is the same, I need to somehow get the fanotify
> feature set so that I can skip test cases which are not compatible with
> the running kernel. I don't really care about which specific flag is not
> implemented, comparing flags against a bitmask is just a quick and
> convenient way to check that running the test case makes sense.
>


Why is skipping the test better than passing the test?

The test wants to know that a specific flag combination is not allowed.

It is particarly not allowed also on old kernels that do not support either
individual flag.

What's the difference?

Who is going to gain anything from this change?

Sorry for being strict on this point
I may be missing something.

Please clarify what it is the problem use case is and I will suggest a
solution, because I disagree with this solution.

Thanks,
Amir.


> --
> Martin Doucha   mdoucha@suse.cz
> QA Engineer for Software Maintenance
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
>
>

--00000000000076d82405ebc77c02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, Oct 24, 2022, 12:03 PM Martin Doucha &lt;<a hr=
ef=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 21. 10. 22 21:03, Amir Goldstein wrote:<br>
&gt; I don&#39;t have a vision of what you are proposing.<br>
&gt; Make a proposal and I will see if it is correct.<br>
&gt; <br>
&gt; I must say I don&#39;t understand what it is that you are trying to im=
prove.<br>
&gt; All the test needs to know is if the specific combinations of flags th=
at<br>
&gt; the test uses are supported by the kernel/fs.<br>
&gt; <br>
&gt; Trying to figure out which of the bits from a specific combination is<=
br>
&gt; not supported? how does that help users?<br>
&gt; Maybe in kernel 5.10 flag X is supported and in kernel 5.11 flag<br>
&gt; Y is also supported, but only in kernel 5.12 the combination X | Y<br>
&gt; is supported? Do you see why your generic function doesn&#39;t make<br=
>
&gt; much sense? or is just too complex to be worth the trouble<br>
&gt; for an informational print?<br>
<br>
The function I&#39;m trying to write is supposed to check whether a <br>
particular flag is implemented by the kernel. Whether a particular <br>
combination of implemented flags is also *allowed* is out of scope.<br>
<br>
Note that the test I&#39;m writing this for is fanotify14, which checks tha=
t <br>
various invalid combinations of flags will correctly return error. But <br>
since the error code for &quot;this flag is not implemented&quot; and &quot=
;this flag <br>
was used incorrectly&quot; is the same, I need to somehow get the fanotify =
<br>
feature set so that I can skip test cases which are not compatible with <br=
>
the running kernel. I don&#39;t really care about which specific flag is no=
t <br>
implemented, comparing flags against a bitmask is just a quick and <br>
convenient way to check that running the test case makes sense.<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Why is skipping the test better than passing the test?</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">The test wants to know that =
a specific flag combination is not allowed.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto">It is particarly not allowed also on old kernels that d=
o not support either individual flag.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">What&#39;s the difference?</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Who is going to gain anything from this change?</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Sorry for being strict on this poi=
nt=C2=A0</div><div dir=3D"auto">I may be missing something.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Please clarify what it is the problem=
 use case is and I will suggest a solution, because I disagree with this so=
lution.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</d=
iv><div dir=3D"auto">Amir.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-- <br>
Martin Doucha=C2=A0 =C2=A0<a href=3D"mailto:mdoucha@suse.cz" target=3D"_bla=
nk" rel=3D"noreferrer">mdoucha@suse.cz</a><br>
QA Engineer for Software Maintenance<br>
SUSE LINUX, s.r.o.<br>
CORSO IIa<br>
Krizikova 148/34<br>
186 00 Prague 8<br>
Czech Republic<br>
<br>
</blockquote></div></div></div>

--00000000000076d82405ebc77c02--

--===============1892334374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1892334374==--
