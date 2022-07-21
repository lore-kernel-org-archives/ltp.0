Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC87EC433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 21:01:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86E323C9CED
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 23:01:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EA173C97FA
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 23:01:42 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 90CF16009F9
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 23:01:41 +0200 (CEST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A02D03F0ED
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 21:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658437300;
 bh=syIXYmU4X0TmBtOIa9/yTtCmbcBdK1kLK/aajNuXYWQ=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=vB4WSoP56zuTCq1TjYt57Et3JiFIlqMzI4Kcuey0vMBdu2VDdRPGYLX6B45zgl7TM
 SKOtrgFYC61puQXL1pF+6w5ymwQhd6oFYRf4fUlKS7F+WdziE6J21dJ2i7cfISZmiV
 VRzWi9TWfFCteXdHbU36pXeMJJ2/pYB7pDtmH4+asZ5YiL9f7n7XMwGDR+Yu8OB9+C
 OGPQ2lZ8wXmDEP9t3FjqrYi+44GUsgongSqsEt4hTERIF+IyWFkxcpuSzhFWhNJL64
 dzL5bWI7mSpZrQZ3OO29tcFI1x9CQrS53OMp16PIOKLRvV/Tl0BLlZnyiDYvxfjgSK
 qdGeNUu+Cyegg==
Received: by mail-ed1-f69.google.com with SMTP id
 w13-20020a05640234cd00b0043a991fb3f3so1810087edc.3
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 14:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=syIXYmU4X0TmBtOIa9/yTtCmbcBdK1kLK/aajNuXYWQ=;
 b=clt7JxKvgWE7VQfMP0AmFZVSy9SMIdidHmNA5cit00RbigQCVCJDsTxTuIAVJ8vSq9
 WQEkE3mX9fhu5nxEWXVjCVg6TqTIF8QTjzycXp9jiZGjzwyvwMJZyE/snD4Ez/NB0zuP
 WHdbdX0QPQpzx+0GGEKYndJtKkypQWLeViMSuz5VlR/6Lj4cAH8DrlGKrpu5nWt9DsQn
 l4siE5eSkzKQuSf/TMQIJ5ACU7OMPNGK1PyxgiHGuXGGWw7/Gpw5kYI10WpMs+ypSu0v
 Y0QsIzPNJCRagCykvR7esCyEvjeQZJR5N4kB4lP3dBTQ5WE2igQyn9Fb0OUt96aOZ+bX
 p7WA==
X-Gm-Message-State: AJIora+3wDNNFgTRr/1Jgo3JK5UviWHOL5Pq+TzEjaQY52eqxJdvbCYH
 dyTBZyppusl9XlAUMoA7rENHIY/gHaJhWwKT0izpUceCjU+DToSFIP9MMTohoB2YWfMNFytKv2y
 bhZRB8y7XB+JJP4ZEMgauhyrgh+l27Rl3OpB5t9A9n+mL
X-Received: by 2002:a50:cdc2:0:b0:43b:bb93:3a5f with SMTP id
 h2-20020a50cdc2000000b0043bbb933a5fmr264933edj.122.1658437299433; 
 Thu, 21 Jul 2022 14:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1verNikZTe6yXpnLjDyvAswkDmfQSSqvOQOFhc6BrY0F00EA66OqDtcqqlfdxtSLNKw1DwKhduSxsOxn2W/nEQ=
X-Received: by 2002:a50:cdc2:0:b0:43b:bb93:3a5f with SMTP id
 h2-20020a50cdc2000000b0043bbb933a5fmr264921edj.122.1658437299263; Thu, 21 Jul
 2022 14:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <3d85635f6b87c73a2389627bc94c847c52165dc7.1651176646.git.luke.nowakowskikrijger@canonical.com>
 <YnOH4h8rTbg1NzCO@pevik> <YnPW0gfMAUGZYPSM@yuki> <YnpKSTal7IG3jtAx@pevik>
 <CADS1e3ehEbnh+wwS-sfS0zWSw4t6Znz_wVmETox2QDCgKaL-Fg@mail.gmail.com>
In-Reply-To: <CADS1e3ehEbnh+wwS-sfS0zWSw4t6Znz_wVmETox2QDCgKaL-Fg@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Thu, 21 Jul 2022 14:01:03 -0700
Message-ID: <CADS1e3cFjUDHB0tF+hcBtosgQs=bVbeM4KKs9Z25mP5aYqQ-EA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 11/19] controllers: Expand cgroup_lib shell
 library
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
Content-Type: multipart/mixed; boundary="===============0278868308=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0278868308==
Content-Type: multipart/alternative; boundary="0000000000001af67f05e457069c"

--0000000000001af67f05e457069c
Content-Type: text/plain; charset="UTF-8"

Hi Petr and Cyril,

On Fri, May 13, 2022 at 1:15 PM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:

> Hi Petr and Cyril,
>
> On Tue, May 10, 2022 at 4:19 AM Petr Vorel <pvorel@suse.cz> wrote:
>
>> Hi Luke, Cyril,
>>
>> > Hi!
>> > > > +_cgroup_check_return()
>> > > > +{
>> > > > + local ret="$1"
>> > > > + local msg="$2"
>> > > > +
>> > > > + tst_flag2mask TBROK
>> > > > + [ "$ret" = "$?" ] && tst_brk TBROK "$msg"
>> > > > +
>> > > > + tst_flag2mask TCONF
>> > > > + [ "$ret" = "$?" ] && tst_brk TCONF "$msg"
>> > > > +}
>> > > As I wrote in previous patch likely we can avoid tst_flag2mask in new
>> API.
>>
>>
I submitted a new version of the changes, however I found that ROD does not
seem to play nice with sending output to a variable (e.g. var=$(command)).

Also reflecting on it, I think it would be better to propagate the TCONF
that comes from tst_cgroup.c so that the errors make a little more sense
instead of getting a TBROK when the error previous was TCONF. This also
makes sense as test frameworks (at canonical) usually parse TBROK as fails
and TCONF as skips in our testing framework, so having a TCONF would just
propagate the status in tst_cgctl and make things make a little more sense.

The only issue, like you said, is in hardcoding the 32 return value. If you
guys think its safe I think thats the best way to go.

Let me know. I submitted the patches to the ML. Sorry for the long hiatus
BTW :) Ive been lagging on getting these patches out forever.



> > > In few cases where needed we hardwired numbers (IMHO POSIX shell does
>> not
>> > > support constants, which would be better than variables which can be
>> changed).
>>
>> > > In this case you could probably use ROD() or EXPECT_PASS_BRK().
>>
>> > Or we can just passthrough the result, as long as it's non-zero we can
>> > do exit $ret and be done with it.
>> +1 (that would suggest to use ROD)
>>
>> Please, rebase the code for new version. You'll have to for cgroup_lib.sh
>> put
>> '. tst_test.sh' to the end and also '. cgroup_lib.sh' in the tests also
>> at the
>> end - required by 04021637f ("tst_test.sh: Cleanup getopts usage").
>>
>>
> Thank you for the reviews! I agree with the changes mentioned and will
> submit an update to these patches.
>
> Kind regards,
>> Petr
>>
>
> Thanks,
> - Luke
>

Best

- Luke

--0000000000001af67f05e457069c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Petr and Cyril, <br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 13, 2022 at 1:15 P=
M Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@cano=
nical.com">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi Pet=
r and Cyril, <br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Tue, May 10, 2022 at 4:19 AM Petr Vorel &lt;<a href=3D"=
mailto:pvorel@suse.cz" target=3D"_blank">pvorel@suse.cz</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Luke, Cyril,<br>
<br>
&gt; Hi!<br>
&gt; &gt; &gt; +_cgroup_check_return()<br>
&gt; &gt; &gt; +{<br>
&gt; &gt; &gt; + local ret=3D&quot;$1&quot;<br>
&gt; &gt; &gt; + local msg=3D&quot;$2&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; + tst_flag2mask TBROK<br>
&gt; &gt; &gt; + [ &quot;$ret&quot; =3D &quot;$?&quot; ] &amp;&amp; tst_brk=
 TBROK &quot;$msg&quot;<br>
&gt; &gt; &gt; +<br>
&gt; &gt; &gt; + tst_flag2mask TCONF<br>
&gt; &gt; &gt; + [ &quot;$ret&quot; =3D &quot;$?&quot; ] &amp;&amp; tst_brk=
 TCONF &quot;$msg&quot;<br>
&gt; &gt; &gt; +}<br>
&gt; &gt; As I wrote in previous patch likely we can avoid tst_flag2mask in=
 new API.<br>
<br></blockquote></div></div></blockquote><div><br></div><div>I submitted a=
 new version of the changes, however I found that ROD does not seem to play=
 nice with sending output to a variable (e.g. var=3D$(command)). <br></div>=
<div><br></div><div>Also reflecting on it, I think it would be better to pr=
opagate the TCONF that comes from tst_cgroup.c so that the errors make a li=
ttle more sense instead of getting a TBROK when the error previous was TCON=
F. This also makes sense as test frameworks (at canonical) usually parse TB=
ROK as fails and TCONF as skips in our testing framework, so having a TCONF=
 would just propagate the status in tst_cgctl and make things make a little=
 more sense. <br></div><div><br></div><div>The only issue, like you said, i=
s in hardcoding the 32 return value. If you guys think its safe I think tha=
ts the best way to go. <br></div><div><br></div><div>Let me know. I submitt=
ed the patches to the ML. Sorry for the long hiatus BTW :) Ive been lagging=
 on getting these patches out forever. <br></div><div>=C2=A0<br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt; &gt; In few cases where needed we hardwired numbers (IMHO POSIX shell =
does not<br>
&gt; &gt; support constants, which would be better than variables which can=
 be changed).<br>
<br>
&gt; &gt; In this case you could probably use ROD() or EXPECT_PASS_BRK().<b=
r>
<br>
&gt; Or we can just passthrough the result, as long as it&#39;s non-zero we=
 can<br>
&gt; do exit $ret and be done with it.<br>
+1 (that would suggest to use ROD)<br>
<br>
Please, rebase the code for new version. You&#39;ll have to for cgroup_lib.=
sh put<br>
&#39;. tst_test.sh&#39; to the end and also &#39;. cgroup_lib.sh&#39; in th=
e tests also at the<br>
end - required by 04021637f (&quot;tst_test.sh: Cleanup getopts usage&quot;=
).<br>
<br></blockquote><div><br></div><div>Thank you for the reviews! I agree wit=
h the changes mentioned and will submit an update to these patches. <br></d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Kind regards,<br>
Petr<br></blockquote><div><br></div><div>Thanks, <br></div><div>- Luke <br>=
</div></div></div></blockquote><div><br></div><div>Best</div><div><br></div=
><div>- Luke <br></div></div></div>

--0000000000001af67f05e457069c--

--===============0278868308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0278868308==--
