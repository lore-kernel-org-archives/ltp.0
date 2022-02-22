Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4490CC433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 07:38:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AE253CA1B3
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 08:38:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C10193CA18C
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:38:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B1CAD2005E0
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:38:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645515504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=puA39ij6AUxd5EzWIEKnuoJoSmXPRIZZak5Vy9ysOe4=;
 b=EWknmTQrsK/rB6DkDMQAhhfTlIKG0g1QGj8cjrtiJTChHPGDN2JMBt4H0cDAC1XItLqRA6
 vSmvtMfSb17XHAFHT6GOmYqT5aow2/e1woBHpyIoozaXFwyRYV0ukoOePoJkcpHTTVlJ7+
 6JtiLWUs9qHq5a12BGU7s4cK5eQ9rxY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-9WLP8PdrMky0VwVSRU28uw-1; Tue, 22 Feb 2022 02:38:21 -0500
X-MC-Unique: 9WLP8PdrMky0VwVSRU28uw-1
Received: by mail-yb1-f197.google.com with SMTP id
 b64-20020a256743000000b0061e169a5f19so23341236ybc.11
 for <ltp@lists.linux.it>; Mon, 21 Feb 2022 23:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=puA39ij6AUxd5EzWIEKnuoJoSmXPRIZZak5Vy9ysOe4=;
 b=gqPw1Qogw1u6UqTk+NPk07ciLV4G+QQ0XltrH8L8MMUNRrLt0qD6olGZbNGGP5AB94
 k373iXwt5TICaYpO7z+fIjwjeoHy+f7SzlRw6Oksu05v9oKJc4zzcy+jTP89HAPRqOOG
 /MGcLrL+GyOGSs8o9F9yYlcgeFeOvl1TUyjjV2rzhVFbqyq3eJtOaC3MdrkwkMqyUqvg
 xROT3mMBoNHcs/ct+y/p/JVQDnlWYrzv/c8/VomNFha8csHzqQFLN+4xa1li1n32ool9
 gzjVuVUDGgHhD7kP1nNe2FPI5Cv7ATa5bItOCzfzVvsj2rBqNm1Edg11dOtzHzXBjWn3
 85KQ==
X-Gm-Message-State: AOAM533TBuz9XU5Szll13eWundfWX+9JZzoztDqEHeHjbvVfJb9ODYZ9
 AuCCTjY7Jbxxg1DBO06K7WYReedB9yOjPucmClwHJvhxR/+WRWVuRKzY9H2LIEmdmYToe0KAIgt
 2+1PGuAInshXy57NkR2v+HD5P4B8=
X-Received: by 2002:a25:b87:0:b0:61c:dc67:2c69 with SMTP id
 129-20020a250b87000000b0061cdc672c69mr22404573ybl.161.1645515500902; 
 Mon, 21 Feb 2022 23:38:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3wmSiXc7rg1VxUBtWKUm45be5Ba37J/EGxkEiK8DxOGyO7UWc+TrkxSf09f/cr7VOFzp93B2j+qO4ABQyhnE=
X-Received: by 2002:a25:b87:0:b0:61c:dc67:2c69 with SMTP id
 129-20020a250b87000000b0061cdc672c69mr22404557ybl.161.1645515500586; Mon, 21
 Feb 2022 23:38:20 -0800 (PST)
MIME-Version: 1.0
References: <b32ed0e56099520bc3e75455e2472841aa0b3020.1645096642.git.jstancek@redhat.com>
In-Reply-To: <b32ed0e56099520bc3e75455e2472841aa0b3020.1645096642.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 22 Feb 2022 15:38:04 +0800
Message-ID: <CAEemH2cM9-qHgu2F1=H9W0sWZFkGu1BvWdNvGyREsf+s9kHSSQ@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/perf_event_open03: skip test on slower
 systems
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
Content-Type: multipart/mixed; boundary="===============1092343168=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1092343168==
Content-Type: multipart/alternative; boundary="000000000000e2a4f905d8966ea4"

--000000000000e2a4f905d8966ea4
Content-Type: text/plain; charset="UTF-8"

Jan Stancek <jstancek@redhat.com> wrote:

Some systems (specially with combination of -debug kernel
> with KASAN enabled) have trouble completing this test
> in specified timeout.
>
> Lowering number of iterations would make the test condition
> less accurate as it's based on global counter.
>
> Instead, calculate the rate of iterations system can do in
> first 5 seconds and used that to decide whether to continue
> to run the test. If the rate is too slow, TCONF after 5
> seconds.
>

Generally, this method looks good, but maybe better to limit this
check_progress() only perform on -debug kernel?  Otherwise,

Reviewed-by: Li Wang <liwang@redhat.com>


======= FYI ==========
I'm seeking a fair way to make a global evaluation of the test
system to reset timeout dynamically for the whole LTP.

My original design thoughts:

  Create the numbers of threads equal to CPUs and bind them to
  the corresponding cpu for running. Use mutex lock to sync up
  each thread launch at the same time to collect the basic data
  for their CPU. Then we can compare the CPU state under the idle or
  busy time to get a relatively stationary _value_ to measure the system
  performance.

But so far the test method is not stable&reliable as expected.

  // do float computing + dirty 10*pagesz memory  in a limited times
  one_unit_of_operation();

  // count the CPU looping numbers with (type = idel, calcu)
  // and call one_unit_opertaion() in 1 sec
  cpu_1sec_looping(int type);

  idlespeed_loops = cpu_1sec_looping(idel);
  calculate_loops = cpu_1sec_looping(calcu);
  ...
  // count the _value_ from all CPU average loops
  ratio = calculate_avg / idealspeed_avg;

-- 
Regards,
Li Wang

--000000000000e2a4f905d8966ea4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Jan Stancek &lt;<a href=3D"mailto:jstancek@redhat.com">jstanc=
ek@redhat.com</a>&gt; wrote:<br></div><div class=3D"gmail_default" style=3D=
"font-size:small"><br></div></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Some systems (specially with combinatio=
n of -debug kernel<br>
with KASAN enabled) have trouble completing this test<br>
in specified timeout.<br>
<br>
Lowering number of iterations would make the test condition<br>
less accurate as it&#39;s based on global counter.<br>
<br>
Instead, calculate the rate of iterations system can do in<br>
first 5 seconds and used that to decide whether to continue<br>
to run the test. If the rate is too slow, TCONF after 5<br>
seconds.<br></blockquote><div><br></div><div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">Generally, this method looks good, but maybe bette=
r to limit this</div><div class=3D"gmail_default" style=3D"font-size:small"=
>check_progress() only perform on=C2=A0-debug kernel?=C2=A0 Otherwise,</div=
><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a h=
ref=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt;<br></div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gma=
il_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default=
" style=3D"font-size:small">=3D=3D=3D=3D=3D=3D=3D FYI =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D</div><div class=3D"gmail_default" style=3D"font-size:small">I&#39=
;m seeking a fair way to make a global evaluation of the test</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">system to reset timeout dyna=
mically for the whole LTP.</div><div class=3D"gmail_default" style=3D"font-=
size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small=
">My original design thoughts:</div><div class=3D"gmail_default" style=3D"f=
ont-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">=C2=A0 Create the numbers of threads equal to CPUs and bind them to</=
div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 the corre=
sponding=C2=A0cpu=C2=A0for running. Use mutex lock to sync up</div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">=C2=A0 each thread launch at=
 the same time to collect the basic data</div><div class=3D"gmail_default" =
style=3D"font-size:small">=C2=A0 for their CPU. Then we can compare the CPU=
 state under the idle or</div><div class=3D"gmail_default" style=3D"font-si=
ze:small">=C2=A0 busy time to get a relatively stationary _value_ to measur=
e the system</div><div class=3D"gmail_default" style=3D"font-size:small">=
=C2=A0 performance.</div><div class=3D"gmail_default" style=3D"font-size:sm=
all"><br></div><div class=3D"gmail_default" style=3D"font-size:small"><div =
class=3D"gmail_default">But so far the test method is not stable&amp;reliab=
le as expected.</div><div class=3D"gmail_default"><br></div><div class=3D"g=
mail_default"></div></div><div class=3D"gmail_default" style=3D"font-size:s=
mall">=C2=A0 // do float computing + dirty 10*pagesz memory=C2=A0 in a limi=
ted times<br></div><div class=3D"gmail_default" style=3D"font-size:small">=
=C2=A0 one_unit_of_operation();</div><div class=3D"gmail_default" style=3D"=
font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:=
small">=C2=A0 // count the CPU looping numbers with (type =3D idel, calcu)<=
/div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0 // and c=
all one_unit_opertaion() in 1 sec</div><div class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 cpu_1sec_looping(int type);<br></div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gmail_=
default" style=3D"font-size:small">=C2=A0 idlespeed_loops =3D cpu_1sec_loop=
ing(idel);</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=
=A0 calculate_loops =3D cpu_1sec_looping(calcu);</div><div class=3D"gmail_d=
efault" style=3D"font-size:small">=C2=A0 ...</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">=C2=A0 // count the _value_ from all CPU aver=
age loops</div><div class=3D"gmail_default" style=3D"font-size:small">=C2=
=A0 ratio =3D calculate_avg / idealspeed_avg;</div></div></div><div><br></d=
iv>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Regards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000e2a4f905d8966ea4--


--===============1092343168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1092343168==--

