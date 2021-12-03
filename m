Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE0CC433F5
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 20:45:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 491D23C90F3
	for <ltp@archiver.kernel.org>; Fri,  3 Dec 2021 21:45:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E8F73C907C
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 21:45:42 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 81A9E201737
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 21:45:41 +0100 (CET)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EC15A3F1B2
 for <ltp@lists.linux.it>; Fri,  3 Dec 2021 20:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1638564337;
 bh=ZPdrSSAtv5YTFMXSpAceBwL2nDuS7IVQIgTaev+3vR4=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=FOSgnJrbhFEyKBBisfCPh/WldmdK6bOhZMl8dlEZ47ScFOigqKAN3af1YPxN7yDYx
 DCCS5f8BYPUSxEeZHwTTYxxAbZ5pclq1jJ6euOKCTRKLDCXH2W3UsKgrVaaceWC4B3
 lID/+ymVy30t6btZwkSnywKnSX1HzrMhDh2WQMlB98rLF27Js6zkEwmSM6HVm4MKAc
 noOqa97QDM1h1IDNd2osKdRzX6XuYx0ifMIdYICN6e86wn8VVU//vnzL7t3VLS9v8K
 czhiyaT47MueK+PAWKG3VY8rSM4cLdWlH//HX+tIXesyzGAWFS7vyF2Kxsr2jTi6U+
 srgfbYaDD4nYQ==
Received: by mail-ed1-f72.google.com with SMTP id
 m12-20020a056402430c00b003e9f10bbb7dso3537138edc.18
 for <ltp@lists.linux.it>; Fri, 03 Dec 2021 12:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZPdrSSAtv5YTFMXSpAceBwL2nDuS7IVQIgTaev+3vR4=;
 b=RlFC+dbK8xy3EX91gs5nZID8cQhz88Zo8DpamSDVV1F3z7GY0QHJOU7dIvgz2XHLPL
 CQLd2Xb98QIEy3G2nuKJBboqESbwTD43K+i7tY3eEVGecJ6qQ3TZRtmrcTVrUUstarYc
 ErUONk+SKYPe2pKqSnTjwmkDKX0M6HJnp07IR3aDZ8HE1zv/ELT4IivOAdl5Lj2sJH6s
 dCzbPwrr/FfAx+u1sB1dPQjOREk8pGMsyDtYT1NiTj3a9mIhbLzdpoD1leuzNFZdav/a
 3Hm/ZR+CQ8jAX4BAiH7NsaW5kq+X4HSvidHp6ynYVbW5zh2JhTVG4LsZxSzjoI13iYcM
 WMAw==
X-Gm-Message-State: AOAM533XBPDWXXOLRRVv3i1OlmsNj3M/prVDL5b0PuQ3btIPKzOiSIMX
 keuKxKvREoK8kkpPGC5setaiWIsnDoVeOMWZdI09K+Vvoj4ZO5+JYtq3qmAJ4aWEMphSEYW+XIc
 30KCfJCdNmI0BoSE8dkSP+L/TwfM18Dy7hQow3HLz2FQf
X-Received: by 2002:a17:906:c109:: with SMTP id
 do9mr25965271ejc.48.1638564337156; 
 Fri, 03 Dec 2021 12:45:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKveFs7eg/0b6dEHJk5pcRMKS/0OXEkXJH0PSlcxfSzoJeBBDYh5mGh06Arp+4Ha5jvbJNo1CMftMV6MxMe7A=
X-Received: by 2002:a17:906:c109:: with SMTP id
 do9mr25965249ejc.48.1638564336981; 
 Fri, 03 Dec 2021 12:45:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
 <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
 <87pmqfcp4j.fsf@suse.de>
 <CADS1e3dXhKJ0NK0OSWYfu-KB__7OsOkRcGmTH66+Ah-tMW8ijA@mail.gmail.com>
 <CAEemH2cT76bRmeQQPQrALUjjK9VNaGRLY4jOYPNrMjkA4FF7_g@mail.gmail.com>
In-Reply-To: <CAEemH2cT76bRmeQQPQrALUjjK9VNaGRLY4jOYPNrMjkA4FF7_g@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Fri, 3 Dec 2021 12:44:58 -0800
Message-ID: <CADS1e3dkYtRibN7ADGh_c9T5uZ4BFTpjgPaXH1+xfBUS8xpKcA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1574468459=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1574468459==
Content-Type: multipart/alternative; boundary="0000000000003f6e6f05d243fd68"

--0000000000003f6e6f05d243fd68
Content-Type: text/plain; charset="UTF-8"

Hi Richard and Li,

Hmm, why do we need that utility as a daemon in the background?
> Isn't it easier to execute a binary utility to get the CGroup path
> only when needed? Just like Richard mentioned the alternative
> way, rescan system each time and only distinguish correct CGroup
> path via the test PID.
>
> Yes this would be easier if we only wanted to get access to the path. I
was getting ahead of myself and thinking about using the C-api to keep
track of creating sub-cgroups and all the state that comes with that. Which
we wouldn't want to do for a shell utility because creation/cleanup of
subgroups is for the test to take care of and that is more trivial in a
shell environment.

>
>
>>
>>
>> The nice part of having a daemon that we could fork off for every test
>> that uses it would be that the cleanup / tracking of sub-groups would get
>> cleaned up in the normal way when we want to close the daemon and just call
>> tst_cgroup_cleanup(). The daemons state would be tied to the test that's
>> issuing commands to it. We could also send out the commands via a shared
>> buffer or pipe that we read and write to.
>>
>> But is a daemon per test (that uses the cgroup shell api) overkill? It
>> seems it would spare us from having to track the test PID to sub-hierarchy
>> like you were mentioning. Or maybe there are some other drawbacks to the
>> per-test daemon idea that I'm not seeing?
>>
>
> I think yes, starting a daemon per test is not wise.
>
> Another drawback I can think of is that will definitely affect paralleling
> things,
> we must guarantee the CGroup mounted by testA shouldn't be scanned/used
> by testB, otherwise, it will fail in the cleanup phase. But, we can make
> the LTP
> test mounted CGroup path is transparent to others just by adding a special
> string
> like "ltp-cgroup".
>
> If I understand it correctly, all the cgroup tests are mounted and created
like "controller_mount_point/ltp/test-$PID" where every test shares the
mount_point and ltp dir. And when tst_cgroup_cleanup() gets called it only
cleans up its own test_dir and removes the ltp dir and unmounts the mount
point if it was the first test to do it. So none of the tests should be
touching each other's directories and so what you're describing should
already be taken care of. Maybe I'm not understanding you correctly.

I think the only problem with the binary utility approach where we rescan
every time we execute it is that
1) The test-$PID dir that the test would be created with the PID of the
program which if we were executing the utility could be different between
calls. This could be easily solved by adding an arg to tst_cgroup_opts for
a specific PID, which would be the test that is calling it.
2) We lose the reference between calls to the root->test_dir that is filled
in when we call tst_cgroup_require(), which is what does the cleanup of the
test specific dir. This is where I believe Richard was mentioning passing
the PID as "tst_cgroup cleanup --pid $MAIN_PID". Which if we wanted to use
the C api for this we would have to expose it to knowing about specific
PIDs? Or for the root->test_dir to be reset somewhere?


> --
> Regards,
> Li Wang
>

Let me know if this makes sense and what you think about it, I might be
getting confused somewhere. But if I understand you correctly I believe
that the binary utility approach where we rescan and call
tst_cgroup_require() or tst_cgroup_cleanup() is a good approach.

Best,
- Luke

--0000000000003f6e6f05d243fd68
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard and Li,<br></div><br><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv class=3D"gmail_quote"><div><div style=3D"font-size:small">Hmm, why do we=
 need that utility as a daemon in the background? </div><div style=3D"font-=
size:small">Isn&#39;t it easier to execute a binary utility to get the CGro=
up path</div><div style=3D"font-size:small">only when needed? Just like Ric=
hard mentioned the alternative</div></div><div style=3D"font-size:small">wa=
y, rescan system each time and only distinguish correct CGroup</div><div st=
yle=3D"font-size:small">path via the test PID.</div><div style=3D"font-size=
:small"><br></div></div></div></blockquote><div>Yes this would be easier if=
 we only wanted to get access to the path. I was getting ahead of myself an=
d thinking about using the C-api to keep track of creating sub-cgroups and =
all the state that comes with that. Which we wouldn&#39;t want to do for a =
shell utility because creation/cleanup of subgroups is for the test to take=
 care of and that is more trivial in a shell environment. <br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_quote"><div style=3D"font-size:small"></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gma=
il_quote"><div> <br></div><div><br></div><div>The nice part of having a dae=
mon that we could fork off for every test that uses it would be that the cl=
eanup / tracking of sub-groups would get cleaned up in the normal way when =
we want to close the daemon and just call tst_cgroup_cleanup(). The daemons=
 state would be tied to the test that&#39;s issuing commands to it. We coul=
d also send out the commands via a shared buffer or pipe that we read and w=
rite to. <br></div><div><br></div><div>But is a daemon per test (that uses =
the cgroup shell api) overkill? It seems it would spare us from having to t=
rack the test PID to sub-hierarchy like you were mentioning. Or maybe there=
 are some other drawbacks to the per-test daemon idea that I&#39;m not seei=
ng?<br></div></div></div></blockquote><div><br></div><div><div style=3D"fon=
t-size:small">I think yes, starting a daemon per test is not wise.</div><di=
v style=3D"font-size:small"><br></div><div style=3D"font-size:small">Anothe=
r drawback I can think of is that will definitely affect paralleling things=
,</div><div style=3D"font-size:small"><div>we must guarantee the CGroup mou=
nted by testA shouldn&#39;t be scanned/used</div><div>by testB, otherwise, =
it will fail in the cleanup phase. But, we can make the=C2=A0LTP=C2=A0</div=
><div>test mounted CGroup path is transparent to=C2=A0others just by adding=
 a special string</div><div>like &quot;ltp-cgroup&quot;.</div></div></div><=
/div><br clear=3D"all"></div></blockquote><div>If I understand it correctly=
, all the cgroup tests are mounted and created like &quot;controller_mount_=
point/ltp/test-$PID&quot; where every test shares the mount_point and ltp d=
ir. And when tst_cgroup_cleanup() gets called it only cleans up its own tes=
t_dir and removes the ltp dir and unmounts the mount point if it was the fi=
rst test to do it. So none of the tests should be touching each other&#39;s=
 directories and so what you&#39;re describing should already be taken care=
 of. Maybe I&#39;m not understanding you correctly. <br></div><div><br></di=
v><div>I think the only problem with the binary utility approach where we r=
escan every time we execute it is that <br></div><div>1) The test-$PID dir =
that the test would be created with the PID of the program which if we were=
 executing the utility could be different between calls. This could be easi=
ly solved by adding an arg to tst_cgroup_opts for a specific PID, which wou=
ld be the test that is calling it. <br></div><div>2) We lose the reference =
between calls to the root-&gt;test_dir that is filled in when we call tst_c=
group_require(), which is what does the cleanup of the test specific dir. T=
his is where I believe Richard was mentioning passing the PID as &quot;tst_=
cgroup cleanup --pid $MAIN_PID&quot;. Which if we wanted to use the C api f=
or this we would have to expose it to knowing about specific PIDs? Or for t=
he root-&gt;test_dir to be reset somewhere?=C2=A0<font color=3D"#888888"><b=
> </b><br></font></div><div><br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div><br></div>-- <br><div dir=3D"ltr"><div d=
ir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div><=
/blockquote><div><br></div><div>Let me know if this makes sense and what yo=
u think about it, I might be getting confused somewhere. But if I understan=
d you correctly I believe that the binary utility approach where we rescan =
and call tst_cgroup_require() or tst_cgroup_cleanup() is a good approach.<b=
r></div><div><br></div><div>Best, <br></div><div>- Luke<br></div></div></di=
v>

--0000000000003f6e6f05d243fd68--

--===============1574468459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1574468459==--
