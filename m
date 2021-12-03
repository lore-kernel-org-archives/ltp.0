Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F623C433F5
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 10:25:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 657273C9050
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 11:25:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F59E3C093B
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 11:25:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DADC21401264
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 11:25:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638527144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fb7dUOs5zV15YiB/PGPcoMhGDGIEnjWecAdHqPh0KTg=;
 b=cW6B1DxGHG4MBVyuuOERyslgRiAfZ5A+p8lNFqHGB1l8EjWiMGE8NJ4k68lceIpcQtECOU
 qagyB9ecAbYggMwA9PzkDejihGTYHiTOXpHcmm9O+HbPc9seaD5j9RJ53LE2wuyDwrRh9d
 mieQkGUKAf/s/hwMCq/IkPxZtR+FDaY=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-t60L-BVoNU--AyAtGZIX8Q-1; Fri, 03 Dec 2021 05:25:42 -0500
X-MC-Unique: t60L-BVoNU--AyAtGZIX8Q-1
Received: by mail-yb1-f199.google.com with SMTP id
 q198-20020a25d9cf000000b005f7a6a84f9fso5581087ybg.6
 for <ltp@lists.linux.it>; Fri, 03 Dec 2021 02:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fb7dUOs5zV15YiB/PGPcoMhGDGIEnjWecAdHqPh0KTg=;
 b=3Lu7+t5JxU0BQTkJoav8121lSp6DemXucM8RxoHn1f6I+kMRHl0/AGHrrFtpcXE6B9
 h8EHoFyOcNGDQvEcTI9CynVo5Amr95pKQmD2SQd/WmN/W1n4ggZkcwJyyWDj9L0g1XBH
 zOTIW4IW7YlYT9fmvzAGA7pMQSASdObe5234OjrSVsC6vCnFjH3lb3iu8dex/HTUpK1B
 F77mJuM+rSLSb9mvvwnBSQ/9TD9eX6rBVSrE0PcDt1m4y5C6B7ZEZTxlADmcHn7jCuuy
 2kGurxGCdkdxgIvc0iAnHaH2ZQcj6czk3BTxOyFe0zHNhIU9972+7iQAbHGFc3o70/WI
 k+YQ==
X-Gm-Message-State: AOAM531J5OpMCIZdcpRkLNuOAM7p1/mysRuQh6+M4JXACHPjWyDgsIfS
 5XcABap3lODImp7OZc42oUFoO1PZjtB8SPzunODMa3UT6AkaF5ZbnzW9C0QESAZW2AseWV1CM9i
 BQ/sV+yZYolUbBKs1YLxuNihx1tY=
X-Received: by 2002:a25:f621:: with SMTP id t33mr22233929ybd.576.1638527142114; 
 Fri, 03 Dec 2021 02:25:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZ5oxTyDmsq6LzmdQmBKTocn9uto7/zPIkayOg2P4UuRsXsA4Eh/UR4L/dTxe85EYBg4hQY9CcbJb96+TWLVQ=
X-Received: by 2002:a25:f621:: with SMTP id t33mr22233907ybd.576.1638527141912; 
 Fri, 03 Dec 2021 02:25:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
 <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
 <87pmqfcp4j.fsf@suse.de>
 <CADS1e3dXhKJ0NK0OSWYfu-KB__7OsOkRcGmTH66+Ah-tMW8ijA@mail.gmail.com>
In-Reply-To: <CADS1e3dXhKJ0NK0OSWYfu-KB__7OsOkRcGmTH66+Ah-tMW8ijA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Dec 2021 18:25:28 +0800
Message-ID: <CAEemH2cT76bRmeQQPQrALUjjK9VNaGRLY4jOYPNrMjkA4FF7_g@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] controllers/memcg: update stress test to work
 under cgroup2
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
Content-Type: multipart/mixed; boundary="===============2027981587=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============2027981587==
Content-Type: multipart/alternative; boundary="0000000000003fbe7b05d23b54f8"

--0000000000003fbe7b05d23b54f8
Content-Type: text/plain; charset="UTF-8"

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:

>
> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
>>
>> Actually we can use the C API. This would avoid a whole bunch of
>> issues. It requires creating a utility which we can use from shell
>> (e.g. tst_cgctl).
>>
>
+1 This is a good idea.



>
>> We *may* have to track state somehow. Either we could run the utility as
>> a daemon initially and communicate with a socket to execute commands. Or
>> we could save/serialise some state to environment/shell
>> variables. Alternatively we can probably rescan the system each
>> time. The only state really required is the test's PID which is needed
>> to find the correct CGroup in the LTP sub-hierarchy.
>>
>> Still that is probably easier than dealing with all of the corner cases
>> twice.
>>
>> I rather like this idea. If I understand you correctly we could use it in
> an RPC sort of way which would make a lot of things simpler and use the
> existing C API which is nice.
>
> My one question would be if we would want this daemon to run as a test
> suite utility, like it seems you are suggesting, or as a per process
> utility.
>

Hmm, why do we need that utility as a daemon in the background?
Isn't it easier to execute a binary utility to get the CGroup path
only when needed? Just like Richard mentioned the alternative
way, rescan system each time and only distinguish correct CGroup
path via the test PID.



>
>
> The nice part of having a daemon that we could fork off for every test
> that uses it would be that the cleanup / tracking of sub-groups would get
> cleaned up in the normal way when we want to close the daemon and just call
> tst_cgroup_cleanup(). The daemons state would be tied to the test that's
> issuing commands to it. We could also send out the commands via a shared
> buffer or pipe that we read and write to.
>
> But is a daemon per test (that uses the cgroup shell api) overkill? It
> seems it would spare us from having to track the test PID to sub-hierarchy
> like you were mentioning. Or maybe there are some other drawbacks to the
> per-test daemon idea that I'm not seeing?
>

I think yes, starting a daemon per test is not wise.

Another drawback I can think of is that will definitely affect paralleling
things,
we must guarantee the CGroup mounted by testA shouldn't be scanned/used
by testB, otherwise, it will fail in the cleanup phase. But, we can make
the LTP
test mounted CGroup path is transparent to others just by adding a special
string
like "ltp-cgroup".


-- 
Regards,
Li Wang

--0000000000003fbe7b05d23b54f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.=
nowakowskikrijger@canonical.com">luke.nowakowskikrijger@canonical.com</a>&g=
t; wrote:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div><br></div><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.d=
e" target=3D"_blank">rpalethorpe@suse.de</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><br></blockquote></div></div></bloc=
kquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
Actually we can use the C API. This would avoid a whole bunch of<br>
issues. It requires creating a utility which we can use from shell<br>
(e.g. tst_cgctl).<br></blockquote></div></div></blockquote><div><br></div><=
div><div class=3D"gmail_default" style=3D"font-size:small">+1 This is a goo=
d idea.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
We *may* have to track state somehow. Either we could run the utility as<br=
>
a daemon initially and communicate with a socket to execute commands. Or<br=
>
we could save/serialise some state to environment/shell<br>
variables. Alternatively we can probably rescan the system each<br>
time. The only state really required is the test&#39;s PID which is needed<=
br>
to find the correct CGroup in the LTP sub-hierarchy.<br>
<br>
Still that is probably easier than dealing with all of the corner cases<br>
twice.<br>
<br></blockquote><div>I rather like this idea. If I understand you correctl=
y we could use it in an RPC sort of way which would make a lot of things si=
mpler and use the existing C API which is nice. <br></div><div><br></div><d=
iv>My one question would be if we would want this daemon to run as a test s=
uite utility, like it seems you are suggesting, or as a per process utility=
.</div></div></div></blockquote><div><br></div><div><div class=3D"gmail_def=
ault" style=3D"font-size:small">Hmm, why do we need that utility as a daemo=
n in the background? </div><div class=3D"gmail_default" style=3D"font-size:=
small">Isn&#39;t it easier to execute a binary utility to get the CGroup pa=
th</div><div class=3D"gmail_default" style=3D"font-size:small">only when ne=
eded? Just like Richard mentioned the alternative</div></div><div class=3D"=
gmail_default" style=3D"font-size:small">way, rescan system each time and o=
nly distinguish correct CGroup</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">path via the test PID.</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>=
 <br></div><div><br></div><div>The nice part of having a daemon that we cou=
ld fork off for every test that uses it would be that the cleanup / trackin=
g of sub-groups would get cleaned up in the normal way when we want to clos=
e the daemon and just call tst_cgroup_cleanup(). The daemons state would be=
 tied to the test that&#39;s issuing commands to it. We could also send out=
 the commands via a shared buffer or pipe that we read and write to. <br></=
div><div><br></div><div>But is a daemon per test (that uses the cgroup shel=
l api) overkill? It seems it would spare us from having to track the test P=
ID to sub-hierarchy like you were mentioning. Or maybe there are some other=
 drawbacks to the per-test daemon idea that I&#39;m not seeing?<br></div></=
div></div></blockquote><div><br></div><div><div class=3D"gmail_default" sty=
le=3D"font-size:small">I think yes, starting a daemon per test is not wise.=
</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div=
 class=3D"gmail_default" style=3D"font-size:small">Another drawback I can t=
hink of is that will definitely affect paralleling things,</div><div class=
=3D"gmail_default" style=3D"font-size:small"><div class=3D"gmail_default">w=
e must guarantee the CGroup mounted by testA shouldn&#39;t be scanned/used<=
/div><div class=3D"gmail_default">by testB, otherwise, it will fail in the =
cleanup phase. But, we can make the=C2=A0LTP=C2=A0</div><div class=3D"gmail=
_default">test mounted CGroup path is transparent to=C2=A0others just by ad=
ding a special string</div><div class=3D"gmail_default">like &quot;ltp-cgro=
up&quot;.</div></div></div></div><br clear=3D"all"><div><br></div>-- <br><d=
iv dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br>=
</div><div>Li Wang<br></div></div></div></div>

--0000000000003fbe7b05d23b54f8--


--===============2027981587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============2027981587==--

