Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55F1C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 07:11:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1AF863CA360
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 08:11:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEB0C3CA2DA
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 08:11:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61100200DB4
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 08:11:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646377878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d5qMQJvjAxzwosjBd3TmHU6Bj/6ka/EHCiAsoao6p34=;
 b=cbOFVJk1AaiKabsTVh4IYAIv/Are+ON4fWhii0lB1/ZfPqoBVKqise5ouT+EsAFpXqu6kh
 RippS0OcSbUg7Xc6fXBJEo0aIPfkx1jy8jraCij/mUQOBZrFAqyjFscu4eTLaqqed2YST1
 jtD5WowHG4syeYlGQWSXq7HJaI0KuEk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-hf2jqN_UMPy5lVI_l2sYcQ-1; Fri, 04 Mar 2022 02:11:17 -0500
X-MC-Unique: hf2jqN_UMPy5lVI_l2sYcQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-2dbd3691096so63308567b3.7
 for <ltp@lists.linux.it>; Thu, 03 Mar 2022 23:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d5qMQJvjAxzwosjBd3TmHU6Bj/6ka/EHCiAsoao6p34=;
 b=CeJ4x5+OnoCv5JIhfcl3RpktzYujqTdnbynEAdJFl9bSHkPLchE2AIRXIraRH1+UTX
 7XB6PWuAoHzI5JWq5Gh/hqnrtUwoQCcdVjDRP6AaGo0t7wE9+Ca4I2fMA0dmWOo08VzW
 HX84ZuMwpe8EPmX/CHRif0VGr1kcvPMDmMJsz3KrouJTwzlrQXu+stAfKiAGXeBK5DLn
 X8c/rUveLylXJS4DdzZr1NtgPj971oCPaFRuBnxOFfBs2ExP8NwZ8p9zxS9q90ikBveQ
 pXnDiaZ6hMPayPB2aqFJjdTBeEHFQnsBJMQGezYX3NzcxEIg8LhISD7gMWJZwif22z0O
 lN4g==
X-Gm-Message-State: AOAM533zbVWh/qFGCu3+wwjrnX4w4sakF0DJNIwPIyvqHDuSGCNOmyBS
 +GwM8hK9fXjsMGfL03w6IwBfxf4Ho+lRUb/3do86g6UMxxgblfiqtQDa7f654GUofBTkYw0iipj
 Xx06XJX7oEHNPNr3xhjcAGDUkfis=
X-Received: by 2002:a81:3744:0:b0:2dc:370:8a0e with SMTP id
 e65-20020a813744000000b002dc03708a0emr13553005ywa.208.1646377876492; 
 Thu, 03 Mar 2022 23:11:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6uhazmcqkhnMeNOODsVbdyJP0c7kJVyGlttAzGOz8gmsZ3km1SlOsn3xqDESj6TkeMzuw/NmfWdC0FZTn6Oc=
X-Received: by 2002:a81:3744:0:b0:2dc:370:8a0e with SMTP id
 e65-20020a813744000000b002dc03708a0emr13552999ywa.208.1646377876308; Thu, 03
 Mar 2022 23:11:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <3b78e25c8eba247d0ce2d99cbbdcaeba7994e26c.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2fDx-KejrtrmY_N9c+7Fbe1Btvpxe65rUPyC8Atw_=+nA@mail.gmail.com>
 <CADS1e3cs3P-LYkKQr8T-263H5YW0WX1gsHTo3BAhYpJZuLf-=w@mail.gmail.com>
In-Reply-To: <CADS1e3cs3P-LYkKQr8T-263H5YW0WX1gsHTo3BAhYpJZuLf-=w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 4 Mar 2022 15:11:04 +0800
Message-ID: <CAEemH2eqf0whtQho7WAaVsVEOFdP-3rFr4ZNbWoazjXbS=3spw@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 10/16] controllers: Update memcg_control_test to
 newer test lib and cgroup lib
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
Content-Type: multipart/mixed; boundary="===============1431165229=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1431165229==
Content-Type: multipart/alternative; boundary="0000000000007bd9d805d95f38a5"

--0000000000007bd9d805d95f38a5
Content-Type: text/plain; charset="UTF-8"

Hi Luke,

Thanks for looking back and working on this.

On Thu, Mar 3, 2022 at 5:38 AM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:

> Hi Li,
>
> On Mon, Jan 24, 2022 at 1:44 AM Li Wang <liwang@redhat.com> wrote:
>
>> Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:
>>
>> As we already built the controller files mapping from V2 to V1
>> in C library and you actually add many new (in patch 5/16).
>>
>> I'm thinking maybe we could make use of it in tst_cgctl.c to
>> avoid handling these (in shell) separately.
>>
>> Something like:
>>
>>     # ./tst_cgctl  set  "$pid"  "cgroup.procs"  "$target_pid"
>>     # ./tst_cgctl  set  "$pid"  "memory.max"  "$ACTIVE_MEM_LIMIT"
>>
>> Otherwise, it seems to make no sense to add so many new
>> files mapping (like that patch 5/16) at this moment.
>>
>> What do you think?
>>
>>
>> I think this would be nice except that we would need to keep track of the
> tst_cg_cgroup structs if we wanted to use safe_cg_* functions in the C lib.
> This would be fine if we only wanted to use control files in the test_dir
> but it gets more complicated if there are other directories below it that
> we would want to set. At least as far as I understand it.
>

Right, but so far it seems we don't have more (than two) sub-layer
directories tests.
(or maybe I didn't aware that we have)

>
> And as Richard mentioned its probably a better idea to just only add the
> control files for controllers as we absolutely need them so this wouldn't
> be too useful. Plus I think it's easy enough from shell to do a version
> check and write to the right control file/directory directly.
>
> So I personally don't think its as important, but I could see in the
> future implementing something like this so it mimics the C api. What do you
> think?
>

Yes, it will be a little bit complex to achieve if we decide to
encapsulate more details in tst_cgctl.c.
But I just hope to provide a simple enough and intuitive way
to use CGroup to LTP shell users. Giving more flexible to shell
API also means giving more complexity to handle problem and
easy to make mistakes.

Anyway, I don't strongly insist on going like that, feel free to send
out the next patch version as you wanted. I believe we will keep
improving the API and tests later, or we can change to that if we
find it is really neccesary.

-- 
Regards,
Li Wang

--0000000000007bd9d805d95f38a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi Luke,</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Th=
anks for looking back and working on this.</div></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 3, 2022 at 5:38=
 AM Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@ca=
nonical.com">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi L=
i, <br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, Jan 24, 2022 at 1:44 AM Li Wang &lt;<a href=3D"mailto:liwang=
@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Luke Nowakowski-Krijger &lt=
;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"_blank">=
luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br>
<br>
As we already built the controller files mapping from V2 to V1<br>
in C library and you actually add many new (in patch 5/16).<br>
<br>
I&#39;m thinking maybe we could make use of it in tst_cgctl.c to<br>
avoid handling these (in shell) separately.<br>
<br>
Something like:<br>
<br>
=C2=A0 =C2=A0 # ./tst_cgctl=C2=A0 set=C2=A0 &quot;$pid&quot;=C2=A0 &quot;cg=
roup.procs&quot;=C2=A0 &quot;$target_pid&quot;<br>
=C2=A0 =C2=A0 # ./tst_cgctl=C2=A0 set=C2=A0 &quot;$pid&quot;=C2=A0 &quot;me=
mory.max&quot;=C2=A0 &quot;$ACTIVE_MEM_LIMIT&quot;<br>
<br>
Otherwise, it seems to make no sense to add so many new<br>
files mapping (like that patch 5/16) at this moment.<br>
<br>
What do you think?<br>
<br>
<br></blockquote><div>I think this would be nice except that we would need =
to keep track of the tst_cg_cgroup structs if we wanted to use safe_cg_* fu=
nctions in the C lib. This would be fine if we only wanted to use control f=
iles in the test_dir but it gets more complicated if there are other direct=
ories below it that we would want to set. At least as far as I understand i=
t.<br></div></div></div></blockquote><div><br></div><div class=3D"gmail_def=
ault" style=3D"font-size:small">Right, but so far it seems we don&#39;t hav=
e more (than two) sub-layer directories tests.</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">(or maybe I didn&#39;t aware that we have)<=
/div><div class=3D"gmail_default" style=3D"font-size:small"></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gma=
il_quote"><div></div><div><br></div><div>And as Richard mentioned its proba=
bly a better idea to just only add the control files for controllers as we =
absolutely need them so this wouldn&#39;t be too useful. Plus I think it&#3=
9;s easy enough from shell to do a version check and write to the right con=
trol file/directory directly.</div><div><br></div><div>So I personally don&=
#39;t think its as important, but I could see in the future implementing so=
mething like this so it mimics the C api. What do you think?</div></div></d=
iv></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Yes, it will be a little bit complex to achieve if we decide to<=
/div><div class=3D"gmail_default" style=3D"font-size:small">encapsulate mor=
e details in tst_cgctl.c.</div><div class=3D"gmail_default" style=3D"font-s=
ize:small">But I just hope to provide a simple enough and intuitive way</di=
v><div class=3D"gmail_default" style=3D"font-size:small">to use CGroup to L=
TP shell users. Giving more flexible to shell</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">API also means giving more complexity to han=
dle problem and</div><div class=3D"gmail_default" style=3D"font-size:small"=
>easy to make mistakes.</div><div class=3D"gmail_default" style=3D"font-siz=
e:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">A=
nyway, I don&#39;t strongly insist on going like that, feel free to send</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">out the next patc=
h version as you wanted. I believe we will keep</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">improving the API and tests later, or we c=
an change to that if we</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">find it is really neccesary.=C2=A0</div></div><div><br></div>-- <b=
r><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,=
<br></div><div>Li Wang<br></div></div></div></div>

--0000000000007bd9d805d95f38a5--


--===============1431165229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1431165229==--

