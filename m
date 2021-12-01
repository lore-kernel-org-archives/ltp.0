Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49FAC433EF
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 22:18:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A0EE3C8FC7
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 23:18:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE4823C8F8D
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 23:18:13 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9C3717F734C
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 23:18:10 +0100 (CET)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 465483F1B2
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 22:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1638397089;
 bh=As7+pd1cuQTzTAxnnHxWOnTvU5CFZ7fXnt9LphFnyz8=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=Q9VEiSUtN4H3MQ2geDPxiQmHKc0B1RiD/q9bJqQKd8WE8w8S61Ggy9A2MReGW1yDp
 G2WRfnUvrsF2UR7ZbZInFmN0NmPXLERYUd1wyS12QRVfQp4V9yLTUlep8DBBtEhfIt
 8iVTUy0WS0fNJRo1j1bFPR64uLuF9RnROU7EsZL01svAAd0s5yBQZl+bzOfdZr/Dnk
 6oW3NhX8ZoycwJiFJP7iOrqTzo0kt2zLGlBX49fZAL3Sc1MGN+cqdbYoRR+vONp3U+
 4XWI/qiewBkY0ZDRSwwUS947majcYn7yKH3LsBxyWwkGcLHBtc2eaRVvzuVVBuvk0R
 A5HU8cP2seFqw==
Received: by mail-ed1-f72.google.com with SMTP id
 n11-20020aa7c68b000000b003e7d68e9874so21641513edq.8
 for <ltp@lists.linux.it>; Wed, 01 Dec 2021 14:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=As7+pd1cuQTzTAxnnHxWOnTvU5CFZ7fXnt9LphFnyz8=;
 b=dFFJ/ZjLqfJzzwavDpFdh+hOyQGthUSH/qj9ebR0UJba18e9qrrAT3U2jlJIx1s5r1
 6nVk3xEU9ZSh/BoVDcGlylY0bZD9JOnQwcH5UXKUhky5TAFiOCO0eS9aW7bvithGSWAd
 5zuQR4UuGIZK9apJprJGhvlFVdmLaYxf1d8jSduVwnxndc99z1YFR+sXThUMiCKLs7t1
 SZjK1jczLdxS5DJaf0Pu1jIYaCfvNsSUa6Cvnc66JqKUnAZ8qUv3ILrxvFW5+bzxG9Cw
 b/49eids1eAJ/iMmn+rePDVqxgZF253oE1UEB0auPh1Gh0QjBjuyqAScrcFRS/h9zMww
 LSEg==
X-Gm-Message-State: AOAM530JCoDQLsLx2+6s+ZARdTfVTDudW738sKLBKwzSBmuBAycsUA2N
 JqD9fCKyJJotriDalty3VBnQLu1j1wshPuerhRmqUjehMRsmDHWsxDvunFyidRUZqMyOGrUGH/3
 A/Kc7Aq7xHU0cxJHLyZcVieQvz+iTXCPkPrCq2u752nF9
X-Received: by 2002:a17:907:1689:: with SMTP id
 hc9mr10026653ejc.445.1638397088968; 
 Wed, 01 Dec 2021 14:18:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxZBDL+C8mZSpnL5V8KDnnYTMCEZKUtMYFZBAFCFjph8tJrhJItQG8QiiyoBhFHHXmPU7foS5p5jJzfD6Mx3jY=
X-Received: by 2002:a17:907:1689:: with SMTP id
 hc9mr10026629ejc.445.1638397088709; 
 Wed, 01 Dec 2021 14:18:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
In-Reply-To: <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 1 Dec 2021 14:17:32 -0800
Message-ID: <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0908650411=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0908650411==
Content-Type: multipart/alternative; boundary="000000000000795d2305d21d0cb9"

--000000000000795d2305d21d0cb9
Content-Type: text/plain; charset="UTF-8"

Hi Li,

On Wed, Dec 1, 2021 at 1:13 AM Li Wang <liwang@redhat.com> wrote:

> Hi Luke,
>
> Thanks for looking into this.
>
> On Sat, Nov 27, 2021 at 8:05 AM Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com> wrote:
>
>> Update tests to be able to work when memory controller is mounted under
>> cgroup2 hierarchy.
>>
>
> I'm thinking whether we could achieve these setup functions
> more generic in cgroup_lib.sh, which to avoid the redundancy
> behavior over and over again in each cgroup sub-test.
>
> Yes I agree. As I was doing the same things a few times I was beginning to
wonder if there was a better way. I would be willing to look further into
expanding the cgroup_lib.sh and resubmitting my recent patches with those
changes.

> About the compatibility of cgroup V1 and V2 in test, I'd suggest
> following what the LTP C library did in include/tst_cgroup.h.
>
> https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L2024
>
> The solution may be briefly as:
>
>
  1. scan system mounted CGroup path, and judge the situation as one of
> below:
>      * only CGroup V2 mounted
>      * only CGroup V1 mounted
>      * both CGroup V2 and V1 mounted
>      * no CGroup mounted
>   2. make use of the system mounted CGroup V2 or TSKIP
>       * goto step 5
>   3. make use of the system mounted CGroup V1
>       * goto step 5
>   4. do mount Cgroup as what we needed (V1 or V2) in test
>       * goto step 5
>   5. do cleanup
>
>
Yes this would be the way to go through setting up a controller and
checking everything.
Going through the steps you mentioned for mounting a single controller and
returning that path wouldn't be too hard but
it seems to get more complicated when we want some guarantee of having
multiple controllers in a hierarchy (if we even
would want to support something like that, which for testing purposes
wouldnt seem unheard of).
Maybe something mimicking the tst_cgroup_require() from the C api would be
useful here? I imagine this is where we would
do the checking and mounting logic that you were describing. We would just
also have to include checking if the controllers
we are requiring can be mounted / already exist together.

For example I am imaging something mimicking the C api something like:
tst_cgroup_require "cpu"
tst_cgroup_require "cpuset"
root_mount_point =$(tst_cgroup_get_mountpoint)

or just combined them together

root_mount_point = $(tst_cgroup_get_mountpoint "cpu cpuset")

Again, most of the tests seem to only be testing individual controllers
from what I can see
so I don't know if this would be too useful. Let me know what you think.


> What do you think?
>
> --
> Regards,
> Li Wang
>

Best,
- Luke

--000000000000795d2305d21d0cb9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Li, <br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 1, 2021 at 1:13 AM Li Wang &lt=
;<a href=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv dir=3D"ltr"><div dir=3D"ltr"><div style=3D"font-size:small">Hi Luke,</di=
v></div><div><br></div><div><div style=3D"font-size:small">Thanks for looki=
ng into this.</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">On Sat, Nov 27, 2021 at 8:05 AM Luke Nowakowski-Krijger =
&lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"_blan=
k">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Update tests to be able to work when=
 memory controller is mounted under<br>
cgroup2 hierarchy.<br></blockquote><div><br></div><div><div style=3D"font-s=
ize:small">I&#39;m thinking whether we could achieve=C2=A0these setup funct=
ions</div><div style=3D"font-size:small">more generic in cgroup_lib.sh, whi=
ch to avoid=C2=A0the redundancy</div><div style=3D"font-size:small">behavio=
r over and over again in each cgroup sub-test.</div><br></div></div></div><=
/blockquote><div>Yes I agree. As I was doing the same things a few times I =
was beginning to wonder if there was a better way. I would be willing to lo=
ok further into</div><div>expanding the cgroup_lib.sh and resubmitting my r=
ecent patches with those changes. <br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div></div><=
div><div style=3D"font-size:small">About the compatibility=C2=A0of cgroup V=
1 and V2 in test, I&#39;d suggest</div><div style=3D"font-size:small">follo=
wing what the LTP C library did in include/tst_cgroup.h.</div><div style=3D=
"font-size:small"><a href=3D"https://github.com/linux-test-project/ltp/blob=
/master/doc/c-test-api.txt#L2024" target=3D"_blank">https://github.com/linu=
x-test-project/ltp/blob/master/doc/c-test-api.txt#L2024</a></div><br></div>=
<div><div style=3D"font-size:small">The solution may be briefly as:</div></=
div><div>=C2=A0</div></div></div></blockquote><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div style=
=3D"font-size:small"></div><div><div style=3D"font-size:small">=C2=A0 1. sc=
an system mounted CGroup path, and judge the situation as one of below:</di=
v><div style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0* only CGroup V2 mount=
ed</div><div style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0* only CGroup V1=
 mounted</div><div style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0* both CGr=
oup V2 and V1 mounted</div><div style=3D"font-size:small">=C2=A0 =C2=A0 =C2=
=A0* no CGroup mounted</div><div style=3D"font-size:small">=C2=A0 2. make u=
se of the system mounted CGroup V2 or TSKIP</div><div style=3D"font-size:sm=
all">=C2=A0 =C2=A0 =C2=A0 * goto step 5</div><div style=3D"font-size:small"=
>=C2=A0 3. make use of the system mounted CGroup V1=C2=A0</div><div style=
=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 * goto step 5</div><div style=3D"=
font-size:small">=C2=A0 4. do mount Cgroup as what we needed (V1 or V2) in =
test</div></div><div style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 * goto =
step 5<br></div><div style=3D"font-size:small">=C2=A0 5. do cleanup=C2=A0</=
div><div><br></div></div></div></blockquote><div><br></div><div>Yes this wo=
uld be the way to go through setting up a controller and checking everythin=
g.=C2=A0 <div>Going through the steps you mentioned for mounting a single c=
ontroller and returning that path wouldn&#39;t be too hard but <br></div><d=
iv>it seems to get more complicated when we want some guarantee of having m=
ultiple controllers in a hierarchy (if we even</div><div>would want to supp=
ort something like that, which for testing purposes wouldnt seem unheard of=
).<br> </div>Maybe something mimicking the tst_cgroup_require() from the C =
api would be useful here? I imagine this is where we would</div><div>do the=
 checking and mounting logic that you were describing. We would just also h=
ave to include checking if the controllers</div><div>we are requiring can b=
e mounted / already exist together.<br></div><div><br></div><div>For exampl=
e I am imaging something mimicking the C api something like:</div><div>tst_=
cgroup_require &quot;cpu&quot;</div><div>tst_cgroup_require &quot;cpuset&qu=
ot;</div><div>root_mount_point =3D$(tst_cgroup_get_mountpoint)</div><div><b=
r></div><div>or just combined them together<br></div><div><br></div><div>ro=
ot_mount_point =3D $(tst_cgroup_get_mountpoint &quot;cpu cpuset&quot;)</div=
><div><br></div><div>Again, most of the tests seem to only be testing indiv=
idual controllers from what I can see</div><div>so I don&#39;t know if this=
 would be too useful. Let me know what you think.<br></div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div cl=
ass=3D"gmail_quote"><div></div><div><div style=3D"font-size:small">What do =
you think?</div></div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=
=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></div></b=
lockquote><div><br></div><div>Best, <br></div><div>- Luke<br></div></div></=
div>

--000000000000795d2305d21d0cb9--

--===============0908650411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0908650411==--
