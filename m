Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B642DC433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 19:29:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00D993C902D
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 20:29:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F154D3C700C
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 20:29:26 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B2D2D100112B
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 20:29:25 +0100 (CET)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AFB8F3F1B2
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 19:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1638473362;
 bh=lzHHlKBP1intpFDdnj0ynmGZeNGaHkH3aiQiX7A5tNY=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=rDigGMt2pNpxVhuKhZaydBg2ZZ5KTCO1UNLFfjLfKIuMZzKJ+uPKfr/VSoOiR+3Hm
 Kg0Vxe/BHshAb3kPfbF4X7H7wG3ECVWCapEplYY1DAUGIFvg36csON3jI7RKTUWNDG
 yGl2fogTCzdvXe69xscEXd6qpwlTwbNX6d9Fk3Y3vzTGeS8ZXUzQy7gmNpQp86IDou
 rBglHzZ63JVirb5DIqMPnUeqlOT3MDDqt4ytYw2CcCxiX3TWJFDp21+7uqLMepK9KH
 jKeMRTv8HzCiQfbYiNUqwcrEIc8NNUbvIsb/bFMSiEzuwLbcXGZ0u3Px0re+ZlWSrR
 rz/9A1SRwxOzQ==
Received: by mail-ed1-f70.google.com with SMTP id
 bx28-20020a0564020b5c00b003e7c42443dbso446821edb.15
 for <ltp@lists.linux.it>; Thu, 02 Dec 2021 11:29:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lzHHlKBP1intpFDdnj0ynmGZeNGaHkH3aiQiX7A5tNY=;
 b=ONyrtBqKHnhvZ0ceQA5Mxda0N2HgCVKacMV1E05b6NujU0rAKKusMSMf5EetIMx8tp
 tY3nmp4J61osB7kXMPdeSxaIht0F18oNKuCYNOYXxp+H7eMwiemYe1niHn/Vqizl6duq
 ZH5imP2daicyFnLfIkkO29d0dhuW3EFvP6Zb6MJXRcKBC/eFau33+rZYYF51THzjgz3o
 xwWgIpay7E8UScI31SWUmJsLQznRhE1EyysHZHY7YU0yXh+6GiKmgWPZdNo3czhUKaG3
 yI7UkIjO4A+ZOZmevu0arKUQgkryGyYaCAjZ6UE7gcYhyLP//ReVvqayRlgC9uuFRKE7
 c+Bg==
X-Gm-Message-State: AOAM5304mTlTryPJ7LPFCuVx18GuHpDbOm2TVUCEIjSqxq9tk1tfzk51
 NZ7Z3ZDPbznRBj1Opq4X5rksEDYS0JVvsihoVEaNgSsCdp3FgSfi93K04KKwMNukrgZ8Tb1tLwZ
 ndV+0rOGk3jRh37uMh54R8lzYNTInD+WSINpDVp0uqOrx
X-Received: by 2002:a17:906:4fc4:: with SMTP id
 i4mr18556609ejw.81.1638473362342; 
 Thu, 02 Dec 2021 11:29:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwh/CURnbyI4oihBkxwR/pLLKqdnskJUTBccBbTucH2l3ahBxb9ksLPeSm01b/ydHZ9Ivt+UX4763yROi1JRhI=
X-Received: by 2002:a17:906:4fc4:: with SMTP id
 i4mr18556595ejw.81.1638473362136; 
 Thu, 02 Dec 2021 11:29:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
 <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
 <87pmqfcp4j.fsf@suse.de>
In-Reply-To: <87pmqfcp4j.fsf@suse.de>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Thu, 2 Dec 2021 11:28:45 -0800
Message-ID: <CADS1e3dXhKJ0NK0OSWYfu-KB__7OsOkRcGmTH66+Ah-tMW8ijA@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0894489068=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0894489068==
Content-Type: multipart/alternative; boundary="000000000000b97dff05d22ecec5"

--000000000000b97dff05d22ecec5
Content-Type: text/plain; charset="UTF-8"

Hi Richard and Li,

On Thu, Dec 2, 2021 at 1:50 AM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Li and Luke
> Li Wang <liwang@redhat.com> writes:
>
> > On Thu, Dec 2, 2021 at 6:24 AM Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com> wrote:
> >
> >  Hi Li,
> >
> >  On Wed, Dec 1, 2021 at 1:13 AM Li Wang <liwang@redhat.com> wrote:
> >
> >  Hi Luke,
> >
> >  Thanks for looking into this.
> >
> >  On Sat, Nov 27, 2021 at 8:05 AM Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com> wrote:
> >
> >  Update tests to be able to work when memory controller is mounted under
> >  cgroup2 hierarchy.
> >
> >  I'm thinking whether we could achieve these setup functions
> >  more generic in cgroup_lib.sh, which to avoid the redundancy
> >  behavior over and over again in each cgroup sub-test.
>
> +1 this is very necessary IMO
>
> Actually we can use the C API. This would avoid a whole bunch of
> issues. It requires creating a utility which we can use from shell
> (e.g. tst_cgctl).
>
> We *may* have to track state somehow. Either we could run the utility as
> a daemon initially and communicate with a socket to execute commands. Or
> we could save/serialise some state to environment/shell
> variables. Alternatively we can probably rescan the system each
> time. The only state really required is the test's PID which is needed
> to find the correct CGroup in the LTP sub-hierarchy.
>
> Still that is probably easier than dealing with all of the corner cases
> twice.
>
> I rather like this idea. If I understand you correctly we could use it in
an RPC sort of way which would make a lot of things simpler and use the
existing C API which is nice.

My one question would be if we would want this daemon to run as a test
suite utility, like it seems you are suggesting, or as a per process
utility.

The nice part of having a daemon that we could fork off for every test that
uses it would be that the cleanup / tracking of sub-groups would get
cleaned up in the normal way when we want to close the daemon and just call
tst_cgroup_cleanup(). The daemons state would be tied to the test that's
issuing commands to it. We could also send out the commands via a shared
buffer or pipe that we read and write to.

But is a daemon per test (that uses the cgroup shell api) overkill? It
seems it would spare us from having to track the test PID to sub-hierarchy
like you were mentioning. Or maybe there are some other drawbacks to the
per-test daemon idea that I'm not seeing?

Looking forward to hearing what you think.

> >
> > TBH, I even think to skip the handling on mixed mounting with V1
> > and V2, that is too messy/overthinking and not suggested using way.
> >
> > We'd better face the future and ideally as myself hoping,
> > V2 will replace V1 everywhere someday:).
>
> There are still controllers/features that don't exist on V2. Meanwhile
> there are features that only exist on V2. So if someone wants both, then
> they have to mount both. Regardless, this was the default in systemd, so
> we are stuck with it for about 20 years and can't ignore it ;-)
>
> >
> >
> >  Maybe something mimicking the tst_cgroup_require() from the C api would
> be useful here? I imagine this is where we would
> >  do the checking and mounting logic that you were describing. We would
> just also have to include checking if the controllers
> >  we are requiring can be mounted / already exist together.
> >
> >  For example I am imaging something mimicking the C api something like:
> >  tst_cgroup_require "cpu"
> >  tst_cgroup_require "cpuset"
> >  root_mount_point =$(tst_cgroup_get_mountpoint)
> >
> > I prefer this one a bit, not only it's consistent with C API but it also
> > can do CGroup mounting in tst_cgroup_require for a system without
> > V1 nor V2 mounting. Then I'd suggest having tst_cgroup_cleanup to
> > help umount that which makes things more clear to understand.
> >
> > Anyway, it depends on the details achieve, maybe there is a better
> > solution we haven't found.
>
> Yes, or if it is a utility then
>
> $ test_cpu_cg_dir = $(tst_cgroup require cpu)
> $ test_cpu_cg_dir = $(tst_cgroup require memory)
>
> maybe with an option to pass the PID to indetify the test. I guess there
> might be some existing env variable the shell API sets we could use as
> well.
>
> $ tst_cgroup cleanup --pid $MAIN_PID
>
> --
> Thank you,
> Richard.
>

 Thanks,
- Luke

--000000000000b97dff05d22ecec5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard and Li,<br></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 2, 2021 at 1:50 AM =
Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@s=
use.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Hello Li and Luke<br>
Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@r=
edhat.com</a>&gt; writes:<br>
<br>
&gt; On Thu, Dec 2, 2021 at 6:24 AM Luke Nowakowski-Krijger &lt;<a href=3D"=
mailto:luke.nowakowskikrijger@canonical.com" target=3D"_blank">luke.nowakow=
skikrijger@canonical.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Hi Li, <br>
&gt;<br>
&gt;=C2=A0 On Wed, Dec 1, 2021 at 1:13 AM Li Wang &lt;<a href=3D"mailto:liw=
ang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Hi Luke,<br>
&gt;<br>
&gt;=C2=A0 Thanks for looking into this.<br>
&gt;<br>
&gt;=C2=A0 On Sat, Nov 27, 2021 at 8:05 AM Luke Nowakowski-Krijger &lt;<a h=
ref=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"_blank">luke.=
nowakowskikrijger@canonical.com</a>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Update tests to be able to work when memory controller is mounte=
d under<br>
&gt;=C2=A0 cgroup2 hierarchy.<br>
&gt;<br>
&gt;=C2=A0 I&#39;m thinking whether we could achieve these setup functions<=
br>
&gt;=C2=A0 more generic in cgroup_lib.sh, which to avoid the redundancy<br>
&gt;=C2=A0 behavior over and over again in each cgroup sub-test.<br>
<br>
+1 this is very necessary IMO<br>
<br>
Actually we can use the C API. This would avoid a whole bunch of<br>
issues. It requires creating a utility which we can use from shell<br>
(e.g. tst_cgctl).<br>
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
. <br></div><div><br></div><div>The nice part of having a daemon that we co=
uld fork off for every test that uses it would be that the cleanup / tracki=
ng of sub-groups would get cleaned up in the normal way when we want to clo=
se the daemon and just call tst_cgroup_cleanup(). The daemons state would b=
e tied to the test that&#39;s issuing commands to it. We could also send ou=
t the commands via a shared buffer or pipe that we read and write to. <br><=
/div><div><br></div><div>But is a daemon per test (that uses the cgroup she=
ll api) overkill? It seems it would spare us from having to track the test =
PID to sub-hierarchy like you were mentioning. Or maybe there are some othe=
r drawbacks to the per-test daemon idea that I&#39;m not seeing?<br></div><=
div><br></div><div>Looking forward to hearing what you think.<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; TBH, I even think to skip the handling on mixed mounting with V1<br>
&gt; and V2, that is too messy/overthinking and not suggested using way.<br=
>
&gt;<br>
&gt; We&#39;d better face the future and ideally as myself hoping,<br>
&gt; V2 will replace V1 everywhere someday:).<br>
<br>
There are still controllers/features that don&#39;t exist on V2. Meanwhile<=
br>
there are features that only exist on V2. So if someone wants both, then<br=
>
they have to mount both. Regardless, this was the default in systemd, so<br=
>
we are stuck with it for about 20 years and can&#39;t ignore it ;-)<br>
<br>
&gt;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 Maybe something mimicking the tst_cgroup_require() from the C ap=
i would be useful here? I imagine this is where we would<br>
&gt;=C2=A0 do the checking and mounting logic that you were describing. We =
would just also have to include checking if the controllers<br>
&gt;=C2=A0 we are requiring can be mounted / already exist together.<br>
&gt;<br>
&gt;=C2=A0 For example I am imaging something mimicking the C api something=
 like:<br>
&gt;=C2=A0 tst_cgroup_require &quot;cpu&quot;<br>
&gt;=C2=A0 tst_cgroup_require &quot;cpuset&quot;<br>
&gt;=C2=A0 root_mount_point =3D$(tst_cgroup_get_mountpoint)<br>
&gt;<br>
&gt; I prefer this one a bit, not only it&#39;s consistent with C API but i=
t also<br>
&gt; can do CGroup mounting in tst_cgroup_require for a system without<br>
&gt; V1 nor V2 mounting. Then I&#39;d suggest having tst_cgroup_cleanup to<=
br>
&gt; help umount that which makes things more clear to understand.<br>
&gt;<br>
&gt; Anyway, it depends on the details achieve, maybe there is a better<br>
&gt; solution we haven&#39;t found.<br>
<br>
Yes, or if it is a utility then<br>
<br>
$ test_cpu_cg_dir =3D $(tst_cgroup require cpu)<br>
$ test_cpu_cg_dir =3D $(tst_cgroup require memory)<br>
<br>
maybe with an option to pass the PID to indetify the test. I guess there<br=
>
might be some existing env variable the shell API sets we could use as well=
.<br>
<br>
$ tst_cgroup cleanup --pid $MAIN_PID<br>
<br>
-- <br>
Thank you,<br>
Richard.<br></blockquote><div><br></div><div>=C2=A0Thanks, <br></div><div>-=
 Luke<br></div></div></div>

--000000000000b97dff05d22ecec5--

--===============0894489068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0894489068==--
