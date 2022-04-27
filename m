Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075E8C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 17:38:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7881B3CA68F
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 19:38:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7B1D3C9482
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 19:38:42 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A30FD60086D
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 19:38:41 +0200 (CEST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C48403F1AE
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 17:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1651081116;
 bh=Q2JLoTT4oP8dTnThlt6cxVhnFpWV60yFh2QF6e8wRz8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=XqsvaxpWIR8PNJfAw0dYl0dOmtzFETcGRdb3NviHK6RFe04/7v8lBb8rT4joIrNlv
 WpGZqPGXjzv9/wdhfrMkaXJTtm14I2x+y00Za6PrhQV1Gi4Pb7TtnqSdbzDvftl8h1
 kfeekFThzl8xqGg2jVuZcpENUedjqpt6k4iYnZ8s+7SOhDymuZynlMFzT1obmvUOTb
 fzbx4ROm4iN+j+CNpsePshxSiQ4dBPERBn2RyWiaifSsPyDkQez5gQARVk5N31ju36
 TU6kwD8Y/JpEap5j232R2QBPn6V7kphXQWBGSnO2kZqs3AAb7CpcBRcjXnhbJcrQHU
 ZzudFbx/eaLaQ==
Received: by mail-ej1-f72.google.com with SMTP id
 hs26-20020a1709073e9a00b006f3b957ebb4so1558486ejc.7
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 10:38:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Q2JLoTT4oP8dTnThlt6cxVhnFpWV60yFh2QF6e8wRz8=;
 b=Q1EdE5VVGXWFwlOBPNivdeIsQ6Dsevjj/VYf0erZ5fPj3MM7nVY4kB3c0uwMEHPB7T
 g6V7/QHbEYMErvqCi1zZUE2uveroWAMrgGmI/NMsome++RRIHNryxXeSS7D4XcR5YsgM
 AcdXNewD0FfHABVy+6IVGO9uSKxYaCp+qe7vQ6hks/cg9uVqUP7+0kc42rdvJa0RajPW
 VSQA7TbFcg2D+ZWA7Tqzrm28l391DU9U9dgTMmRQeB2pwQMFlEwfEX4etO6leoEhqCtd
 cdYDeKDDlOq/gt/4i5R0fp43B2SB1S9LRRgTZAYiQxg+/QZluWVpHwwTIFWRv5wyW/at
 rXhQ==
X-Gm-Message-State: AOAM530WBq47K19O+P1GI2H4BaQOHZbV5b3jNZ0NhyWaJ0mayhVqq8i0
 PQlh1W5C3faT5LuqvRdL6rT9qcGp1YN7qKe7O4adCznPW78f7Dmi54HunQY8K3ChiK4P+cML1tY
 ewQOxntSd9US5f2LTfCAyIosqowRMBz8jFlbvD0gwA4Jq
X-Received: by 2002:a05:6402:3711:b0:425:d3d6:2b65 with SMTP id
 ek17-20020a056402371100b00425d3d62b65mr24654952edb.328.1651081116517; 
 Wed, 27 Apr 2022 10:38:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxstpH1AdbFILl1Nq5hitofsXMieaV3qfnJaZhhqk/QwpBrfBk2cfX1oQzFhHdDHeFi1HQ1duiuyZL+0u12ajM=
X-Received: by 2002:a05:6402:3711:b0:425:d3d6:2b65 with SMTP id
 ek17-20020a056402371100b00425d3d62b65mr24654933edb.328.1651081116329; Wed, 27
 Apr 2022 10:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <baec527891fe83e75958f9db3634f1a0a828bf07.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <871qzeniu7.fsf@suse.de>
 <CADS1e3ff7dnQe8zByitszNhKViiOLOF-UfNtSbMsFkkSX5Sy7Q@mail.gmail.com>
 <878rt958yz.fsf@suse.de>
In-Reply-To: <878rt958yz.fsf@suse.de>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 27 Apr 2022 10:38:00 -0700
Message-ID: <CADS1e3d+S-Lg436qb_AFSf1tiea1VzhbBj_BYD1qw-tSXH1J9w@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 04/16] API/cgroup: Implement tst_cg_load_config
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
Content-Type: multipart/mixed; boundary="===============0689744958=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0689744958==
Content-Type: multipart/alternative; boundary="0000000000006f452c05dda647b2"

--0000000000006f452c05dda647b2
Content-Type: text/plain; charset="UTF-8"

Hi Richard and Li,

On Thu, Mar 17, 2022 at 12:33 AM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Luke,
>
> >
> > Thank you for pointing all these things out. I forgot about all the
> shenanigans that can happen when you don't sanity check string stuff :)
> >
> > A few solutions to creating the scanff format are:
> > 1) pre-processor trick to concatenate defines into a string, something
> like this
> > #define _tostr(str) #str
> > #define tostr(str) _tostr(str)
> > #define CONFIG_FORMAT "%" tostr(CTRL_NAME_MAX) "s\t%d\t%d\t%"
> tostr(PATH_MAX) "s\t%d\t%d\t%" tostr(NAME_MAX) "s"
> >
> > 2) just hardcode the lengths to avoid all of this nonsense above
>
> I would have done 2 in this case, but you figured out 1, so feel free to
> use that. In fact that would be a nice addition to LTP's standard macros
> (but with TST_ prefix).
>
> Just note that the maximum conversion length doesn't include
> the null character. scanf will write the null character after the
> maximum conversion length. Also I'm not sure the field length comes
> after '%' or that you use 's' with a length; possibly it should be
> '%c63' to scan a 64 byte null terminated string. However please double
> check the man page.
>
> You can use %s with a length which makes things easier and automatically
appends the null character.


> >
> > 3) just create the format at runtime
>
> IIRC this is considered unsafe and will result in warnings and errors.
>
> >
> > I'm more or less asking what you think is best to avoid sending out all
> of the patches and then discussing this / if there is a better way.
> >
>
>
Sorry for the delay on these patches, got caught up in many other things
again.

I have submitted a pull request for review, didn't want to spam 19 patches
on the ML. Its my first time doing a pull request.. are you guys able to
review and accept from there? If so here it is
https://github.com/linux-test-project/ltp/pull/933



> --
> Thank you,
> Richard.
>

Thanks,
- Luke

--0000000000006f452c05dda647b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard and Li, <br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 17, 2022 at 12:33 =
AM Richard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorp=
e@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hello Luke,<br>
<br>
&gt;<br>
&gt; Thank you for pointing all these things out. I forgot about all the sh=
enanigans that can happen when you don&#39;t sanity check string stuff :)<b=
r>
&gt;<br>
&gt; A few solutions to creating the scanff format are:<br>
&gt; 1) pre-processor trick to concatenate defines into a string, something=
 like this<br>
&gt; #define _tostr(str) #str<br>
&gt; #define tostr(str) _tostr(str)<br>
&gt; #define CONFIG_FORMAT &quot;%&quot; tostr(CTRL_NAME_MAX) &quot;s\t%d\t=
%d\t%&quot; tostr(PATH_MAX) &quot;s\t%d\t%d\t%&quot; tostr(NAME_MAX) &quot;=
s&quot;<br>
&gt;<br>
&gt; 2) just hardcode the lengths to avoid all of this nonsense above<br>
<br>
I would have done 2 in this case, but you figured out 1, so feel free to<br=
>
use that. In fact that would be a nice addition to LTP&#39;s standard macro=
s<br>
(but with TST_ prefix).<br>
<br>
Just note that the maximum conversion length doesn&#39;t include<br>
the null character. scanf will write the null character after the<br>
maximum conversion length. Also I&#39;m not sure the field length comes<br>
after &#39;%&#39; or that you use &#39;s&#39; with a length; possibly it sh=
ould be<br>
&#39;%c63&#39; to scan a 64 byte null terminated string. However please dou=
ble<br>
check the man page.<br>
<br></blockquote><div>You can use %s with a length which makes things easie=
r and automatically appends the null character.</div><div>=C2=A0<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
&gt;<br>
&gt; 3) just create the format at runtime<br>
<br>
IIRC this is considered unsafe and will result in warnings and errors.<br>
<br>
&gt;<br>
&gt; I&#39;m more or less asking what you think is best to avoid sending ou=
t all of the patches and then discussing this / if there is a better way. <=
br>
&gt;<br>
<br></blockquote><div><br></div><div>Sorry for the delay on these patches, =
got caught up in many other things again.</div><div><br></div><div>I have s=
ubmitted a pull request for review, didn&#39;t want to spam 19 patches on t=
he ML. Its my first time doing a pull request.. are you guys able to review=
 and accept from there? If so here it is <a href=3D"https://github.com/linu=
x-test-project/ltp/pull/933">https://github.com/linux-test-project/ltp/pull=
/933</a></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
-- <br>
Thank you,<br>
Richard.<br></blockquote><div><br></div><div>Thanks, <br></div><div>- Luke =
<br></div></div></div>

--0000000000006f452c05dda647b2--

--===============0689744958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0689744958==--
