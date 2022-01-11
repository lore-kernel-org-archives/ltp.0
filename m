Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E47C433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 12:18:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 144FB3C93FE
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 13:18:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 430593C12D0
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 13:18:36 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5A37601D15
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 13:18:35 +0100 (CET)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A5D03F207
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1641903509;
 bh=KmGqkJu//17F0SPtFApH0l7MVMVHDpE3/MlTklkslwY=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=gBR2sIFLze1Cf+Dm/8bxuKnktAjTJyiF3mzsqjzVsV99TtlrPjACWQqsQwtXZV+Pn
 irhF9ktcqcg2cj4ihYefT5IF2SL4tgkXk1rJaNhlEBTa9vUIIvPT2+w/P6KcfUZCOX
 XB6khUr64QhEvVeQBSEFUHavjgMgUAJU0lbKMaBKNOejCx06aM9AF5t7pjjb/jrPIa
 e5M2Y3uPwjGExp99aPPzLld/Z/RZ//T0cqLVD1PHf74yJQvAoj9Pps26tmQykW0Wvg
 3ZZ8zlRCmsydwGPFQioLaYid1T0WWkQstxkHuO7uyYtFKjDaU+jZxJQnzn+4e/TGef
 0I2TBfbd205Sw==
Received: by mail-ed1-f70.google.com with SMTP id
 ec25-20020a0564020d5900b003fc074c5d21so8742475edb.19
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 04:18:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KmGqkJu//17F0SPtFApH0l7MVMVHDpE3/MlTklkslwY=;
 b=LDLuD50g881qQNVkOoaRpSaVyMAmx2/ZWSLwIVc2q3RnG0dfBIx2VYv6m6Epw2D2Cs
 uYx6Bk4WDEyjbchb5tj8EMc2Nl3ovt19P05x4v9EpnSceSTg9DCyMWTSEBHA/8aWuIy3
 2/BcdoJktPiEpKM1PhWhJwHNDzpBt+KHPVlmAFDGl3drIVnoiv9Ia8iZS36eWehg4zee
 V1u18sWTw9WFnRP3UWXA8ZpmjBtVer0hVds7NoV298F7CX5iImWCjBH5oWMIDHGoKpwN
 sf6tI8VeyeB9WuABdOgoUI2COWInV3LfzQfrU+UiOPSdmMkS9e+lkC0vRtomsahCtEsg
 01rQ==
X-Gm-Message-State: AOAM531PEYf2v2cG/0Pt/W50jKlJut/JGGnM+Fd34YR7pvGvyOcJvWgb
 diaXZfPnLTYDO3hHye0VJsUydJFh5rCY6FYwtzrAY2IGLqLYhIrdo5GYk9xbXhi/qObxwPeKtK1
 /PddsGo1VamOtzVRtaFL+UDdiYjgUlQOM4w13/rMgBh5B
X-Received: by 2002:a17:906:9948:: with SMTP id
 zm8mr3384684ejb.396.1641903508516; 
 Tue, 11 Jan 2022 04:18:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyT2Rp9zSGr+aGWk+TttpeanMVokP3auIZJ7gFuY7G4+xnwoJdEsk0XzAPiCWwEVu1a4AQEkkYw6TUJAPYF4kM=
X-Received: by 2002:a17:906:9948:: with SMTP id
 zm8mr3384667ejb.396.1641903508252; 
 Tue, 11 Jan 2022 04:18:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <626fb72bcb83352d98e0df828f4b27a4ef5a1d6f.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2eW=4fpi=LqhzOxqNOJMgKn7K1qGOqBPWMSFuAvXX70WA@mail.gmail.com>
In-Reply-To: <CAEemH2eW=4fpi=LqhzOxqNOJMgKn7K1qGOqBPWMSFuAvXX70WA@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Tue, 11 Jan 2022 04:17:52 -0800
Message-ID: <CADS1e3dTePnjQqBBT+KvJ9goy4CzXUhCf9QR93q4+KOZv4TkqA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] controllers: Expand cgroup_lib shell library
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
Content-Type: multipart/mixed; boundary="===============1741509795=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1741509795==
Content-Type: multipart/alternative; boundary="0000000000005dc27205d54d7335"

--0000000000005dc27205d54d7335
Content-Type: text/plain; charset="UTF-8"

Hi Li,

On Tue, Jan 11, 2022 at 2:51 AM Li Wang <liwang@redhat.com> wrote:

> > +# Find mountpoint of the given controller
> > +# USAGE: cgroup_get_mountpoint CONTROLLER
> > +# RETURNS: Prints the mountpoint of the given controller
> > +# Must call cgroup_require before calling
> > +cgroup_get_mountpoint()
> > +{
> > +       local ctrl=$1
> > +       local mountpoint
> > +
> > +       [ $# -eq 0 ] && tst_brk TBROK "cgroup_get_mountpoint: controller
> not defined"
> > +       [ "$_cgroup_state" = "" ] && tst_brk TBROK
> "cgroup_get_mountpoint: No previous state found. Forgot to call
> cgroup_require?"
> > +
> > +       mountpoint=$(echo "$_cgroup_state" | grep -w "$ctrl" | awk '{
> print $4 }')
> > +       echo "$mountpoint"
> > +
> > +       return 0
> > +}
> > +
> > +# Get the test path of a given controller that has been created by the
> cgroup C API
> > +# USAGE: cgroup_get_test_path CONTROLLER
> > +# RETURNS: Prints the path to the test direcory
> > +# Must call cgroup_require before calling
> > +cgroup_get_test_path()
> > +{
> > +       local ctrl="$1"
> > +       local mountpoint
> > +       local test_path
> > +
> > +       [ $# -eq 0 ] && tst_brk TBROK "cgroup_get_test_path: controller
> not defined"
> > +       [ "$_cgroup_state" = "" ] && tst_brk TBROK
> "cgroup_get_test_path: No previous state found. Forgot to call
> cgroup_require?"
> > +
> > +       mountpoint=$(cgroup_get_mountpoint "$ctrl")
> > +
> > +       test_path="$mountpoint/ltp/test-$$"
> > +
> > +       [ ! -d "$test_path" ] && tst_brk TBROK "cgroup_get_test_path: No
> test path found. Forgot to call cgroup_require?"
> > +
> > +       echo "$test_path"
> > +
> > +       return 0
> > +}
> > +
> > +# Gets the cgroup version of the given controller
> > +# USAGE: cgroup_get_version CONTROLLER
> > +# RETURNS: "V1" if version 1 and "V2" if version 2
> > +# Must call cgroup_require before calling
> > +cgroup_get_version()
> > +{
> > +       local ctrl="$1"
> > +
> > +       [ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller
> not defined"
> > +       [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version:
> No previous state found. Forgot to call cgroup_require?"
> > +
> > +       version=$(echo "$_cgroup_state" | grep -w "$ctrl" | awk '{ print
> $2 }')
>
> This won't work on my x86_64 KVM platform, maybe we need: grep -w "^$ctrl".
>
> # echo $$
> 1801
>
> # ./tst_cgctl require memory 1801
> Detected Controllers:
> memory V1 @ /sys/fs/cgroup/memory Required
> cpu V1 @ /sys/fs/cgroup/cpu,cpuacct
> cpuset V1 @ /sys/fs/cgroup/cpuset
> Detected Roots:
> /sys/fs/cgroup/memory Mounted_Root=no Created_Ltp_Dir=no
> Created_Drain_Dir=no Test_Id=test-1801
> /sys/fs/cgroup/cpu,cpuacct Mounted_Root=no Created_Ltp_Dir=no
> Created_Drain_Dir=no Test_Id=NULL
> /sys/fs/cgroup/cpuset Mounted_Root=no Created_Ltp_Dir=no
> Created_Drain_Dir=no Test_Id=NULL
>
> # _cgroup_state=$(./tst_cgctl require memory 1801)
>
> # echo "$_cgroup_state" | grep -w "memory" | awk '{ print $2 }'
> V1
> Mounted_Root=no
>
> # echo "$_cgroup_state" | grep -w "memory" | awk '{ print $4 }'
> /sys/fs/cgroup/memory
> Created_Drain_Dir=no
>
> # ./tst_cgctl cleanup "$_cgroup_state"
> tst_cgroup.c:414: TBROK: Could not find root from config. Roots
> changing between calls?
>
>
> > +       [ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could
> not find controller $ctrl"
> > +
> > +       echo "$version"
> > +
> > +       return 0
> > +}
> > +
>
>
Ah I see that the grepping goes awry when there is already a V1 controller
which has the controller name in the mount path. Thank you for checking
this, I will fix this in the next version.


> --
> Regards,
> Li Wang
>
>
Thanks for the review,
- Luke

--0000000000005dc27205d54d7335
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Li, <br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 11, 2022 at 2:51 AM Li Wang &l=
t;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; +# Find mountp=
oint of the given controller<br>
&gt; +# USAGE: cgroup_get_mountpoint CONTROLLER<br>
&gt; +# RETURNS: Prints the mountpoint of the given controller<br>
&gt; +# Must call cgroup_require before calling<br>
&gt; +cgroup_get_mountpoint()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0local ctrl=3D$1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0local mountpoint<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ $# -eq 0 ] &amp;&amp; tst_brk TBROK &quo=
t;cgroup_get_mountpoint: controller not defined&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$_cgroup_state&quot; =3D &quot;&qu=
ot; ] &amp;&amp; tst_brk TBROK &quot;cgroup_get_mountpoint: No previous sta=
te found. Forgot to call cgroup_require?&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0mountpoint=3D$(echo &quot;$_cgroup_state&q=
uot; | grep -w &quot;$ctrl&quot; | awk &#39;{ print $4 }&#39;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;$mountpoint&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>
&gt; +}<br>
&gt; +<br>
&gt; +# Get the test path of a given controller that has been created by th=
e cgroup C API<br>
&gt; +# USAGE: cgroup_get_test_path CONTROLLER<br>
&gt; +# RETURNS: Prints the path to the test direcory<br>
&gt; +# Must call cgroup_require before calling<br>
&gt; +cgroup_get_test_path()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0local ctrl=3D&quot;$1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0local mountpoint<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0local test_path<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ $# -eq 0 ] &amp;&amp; tst_brk TBROK &quo=
t;cgroup_get_test_path: controller not defined&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$_cgroup_state&quot; =3D &quot;&qu=
ot; ] &amp;&amp; tst_brk TBROK &quot;cgroup_get_test_path: No previous stat=
e found. Forgot to call cgroup_require?&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0mountpoint=3D$(cgroup_get_mountpoint &quot=
;$ctrl&quot;)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0test_path=3D&quot;$mountpoint/ltp/test-$$&=
quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ ! -d &quot;$test_path&quot; ] &amp;&amp;=
 tst_brk TBROK &quot;cgroup_get_test_path: No test path found. Forgot to ca=
ll cgroup_require?&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;$test_path&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>
&gt; +}<br>
&gt; +<br>
&gt; +# Gets the cgroup version of the given controller<br>
&gt; +# USAGE: cgroup_get_version CONTROLLER<br>
&gt; +# RETURNS: &quot;V1&quot; if version 1 and &quot;V2&quot; if version =
2<br>
&gt; +# Must call cgroup_require before calling<br>
&gt; +cgroup_get_version()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0local ctrl=3D&quot;$1&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ $# -eq 0 ] &amp;&amp; tst_brk TBROK &quo=
t;cgroup_get_version: controller not defined&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$_cgroup_state&quot; =3D &quot;&qu=
ot; ] &amp;&amp; tst_brk TBROK &quot;cgroup_get_version: No previous state =
found. Forgot to call cgroup_require?&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0version=3D$(echo &quot;$_cgroup_state&quot=
; | grep -w &quot;$ctrl&quot; | awk &#39;{ print $2 }&#39;)<br>
<br>
This won&#39;t work on my x86_64 KVM platform, maybe we need: grep -w &quot=
;^$ctrl&quot;.<br>
<br>
# echo $$<br>
1801<br>
<br>
# ./tst_cgctl require memory 1801<br>
Detected Controllers:<br>
memory V1 @ /sys/fs/cgroup/memory Required<br>
cpu V1 @ /sys/fs/cgroup/cpu,cpuacct<br>
cpuset V1 @ /sys/fs/cgroup/cpuset<br>
Detected Roots:<br>
/sys/fs/cgroup/memory Mounted_Root=3Dno Created_Ltp_Dir=3Dno<br>
Created_Drain_Dir=3Dno Test_Id=3Dtest-1801<br>
/sys/fs/cgroup/cpu,cpuacct Mounted_Root=3Dno Created_Ltp_Dir=3Dno<br>
Created_Drain_Dir=3Dno Test_Id=3DNULL<br>
/sys/fs/cgroup/cpuset Mounted_Root=3Dno Created_Ltp_Dir=3Dno<br>
Created_Drain_Dir=3Dno Test_Id=3DNULL<br>
<br>
# _cgroup_state=3D$(./tst_cgctl require memory 1801)<br>
<br>
# echo &quot;$_cgroup_state&quot; | grep -w &quot;memory&quot; | awk &#39;{=
 print $2 }&#39;<br>
V1<br>
Mounted_Root=3Dno<br>
<br>
# echo &quot;$_cgroup_state&quot; | grep -w &quot;memory&quot; | awk &#39;{=
 print $4 }&#39;<br>
/sys/fs/cgroup/memory<br>
Created_Drain_Dir=3Dno<br>
<br>
# ./tst_cgctl cleanup &quot;$_cgroup_state&quot;<br>
tst_cgroup.c:414: TBROK: Could not find root from config. Roots<br>
changing between calls?<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0[ &quot;$version&quot; =3D &quot;&quot; ] =
&amp;&amp; tst_brk TBROK &quot;cgroup_get_version: Could not find controlle=
r $ctrl&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;$version&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0<br>
&gt; +}<br>
&gt; +<br>
<br></blockquote><div><br></div><div>Ah I see that the grepping goes awry w=
hen there is already a V1 controller which has the controller name in the m=
ount path. Thank you for checking this, I will fix this in the next version=
.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Regards,<br>
Li Wang<br>
<br></blockquote><div><br></div><div>Thanks for the review,</div><div>- Luk=
e<br></div></div></div>

--0000000000005dc27205d54d7335--

--===============1741509795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1741509795==--
