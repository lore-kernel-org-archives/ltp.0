Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B76C433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 07:47:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2F233C8FDB
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 08:47:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B760C3C8DC3
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 08:47:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2BEA3600688
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 08:47:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638431224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qpv5jaTESQdW+W/umE/2JsKchUOdj4AD9hc3VixDA2g=;
 b=OEED6S3z4k9qviAIp/yV5ouuaCp8GTW2ee7L1k0BXjjpePbhkva/0Ol+7pGtTqhyBd2LKj
 PTyEjKqqxsqYt+crtK9TUOO6uRksxsD8vL2OEmjDEtK6t2Z71/ZFgCjIt6CSWXjkVoEplV
 fad4RlTJttUd4flo24N/8UE4EsqL4iQ=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-MfMVPlBROkabZ6q-Kv-NDA-1; Thu, 02 Dec 2021 02:47:01 -0500
X-MC-Unique: MfMVPlBROkabZ6q-Kv-NDA-1
Received: by mail-yb1-f200.google.com with SMTP id
 t24-20020a252d18000000b005c225ae9e16so41111365ybt.15
 for <ltp@lists.linux.it>; Wed, 01 Dec 2021 23:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qpv5jaTESQdW+W/umE/2JsKchUOdj4AD9hc3VixDA2g=;
 b=hJhzG6xOMVEZ6yr8KV0bvB4A1nUMkwP4JpQvo6F0bWF3rrCrp2z3BEg3xFUG5Itm9L
 8nIA3aOatl+dGKf1zc1IKqbtHrOJteekJljIYqoARYPEPEfzXtYKELku3WtsEMYqTE96
 9+RZ/+21ZTYiULqF27hLT3tGCADq7yVaFGXuzSUWzxoDvEf3afCLcCfpEOk0VB6ihBsG
 Ehp1EDreVZfAG+785618ly0dzo7b/UGmPeS96gi4R6oXNHhfArv3x8UwT8ujem49JO/u
 ZmrUTwRVMpSZ+W+EDqahYG2ZqhKLjh2rHHmyQF1zq8PVwxsyKr6P1SG6zu9clmGDMiSp
 yrtg==
X-Gm-Message-State: AOAM531Nl6e80uCvfdA+ksyNX+kHYmz63HJZm4rA+Hpaqnp1m0+UZpEl
 3yeotY31Z4/2dng0F43di7T6HbVmpwp8Wu9VAY5xSTvnDKKw/qALgsrRIYp+3ZWRqufdJ9yObTH
 FOpHGgvcPyYeh6+5wmZVQduiL2i8=
X-Received: by 2002:a25:f621:: with SMTP id t33mr13681237ybd.576.1638431221034; 
 Wed, 01 Dec 2021 23:47:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRqonk1nywilUZBNbZbPyCJ1qHfki7XHgy75qa9m3hSCKwl0dL7jOcyG37DCgQSYYd2xQyCxdO8RAfOOjAMQg=
X-Received: by 2002:a25:f621:: with SMTP id t33mr13681220ybd.576.1638431220740; 
 Wed, 01 Dec 2021 23:47:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
In-Reply-To: <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 2 Dec 2021 15:46:45 +0800
Message-ID: <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============1981732159=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1981732159==
Content-Type: multipart/alternative; boundary="000000000000e6d09f05d224fe15"

--000000000000e6d09f05d224fe15
Content-Type: text/plain; charset="UTF-8"

On Thu, Dec 2, 2021 at 6:24 AM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:

> Hi Li,
>
> On Wed, Dec 1, 2021 at 1:13 AM Li Wang <liwang@redhat.com> wrote:
>
>> Hi Luke,
>>
>> Thanks for looking into this.
>>
>> On Sat, Nov 27, 2021 at 8:05 AM Luke Nowakowski-Krijger <
>> luke.nowakowskikrijger@canonical.com> wrote:
>>
>>> Update tests to be able to work when memory controller is mounted under
>>> cgroup2 hierarchy.
>>>
>>
>> I'm thinking whether we could achieve these setup functions
>> more generic in cgroup_lib.sh, which to avoid the redundancy
>> behavior over and over again in each cgroup sub-test.
>>
>> Yes I agree. As I was doing the same things a few times I was beginning
> to wonder if there was a better way. I would be willing to look further into
> expanding the cgroup_lib.sh and resubmitting my recent patches with those
> changes.
>

Thanks a lot!


>
> About the compatibility of cgroup V1 and V2 in test, I'd suggest
>> following what the LTP C library did in include/tst_cgroup.h.
>>
>> https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L2024
>>
>> The solution may be briefly as:
>>
>>
>   1. scan system mounted CGroup path, and judge the situation as one of
>> below:
>>      * only CGroup V2 mounted
>>      * only CGroup V1 mounted
>>      * both CGroup V2 and V1 mounted
>>      * no CGroup mounted
>>   2. make use of the system mounted CGroup V2 or TSKIP
>>       * goto step 5
>>   3. make use of the system mounted CGroup V1
>>       * goto step 5
>>   4. do mount Cgroup as what we needed (V1 or V2) in test
>>       * goto step 5
>>   5. do cleanup
>>
>>
> Yes this would be the way to go through setting up a controller and
> checking everything.
> Going through the steps you mentioned for mounting a single controller and
> returning that path wouldn't be too hard but
> it seems to get more complicated when we want some guarantee of having
> multiple controllers in a hierarchy (if we even
> would want to support something like that, which for testing purposes
> wouldnt seem unheard of).
>

Right, it is the complicated part and you can take a reference how
the current C API handles it.

TBH, I even think to skip the handling on mixed mounting with V1
and V2, that is too messy/overthinking and not suggested using way.

We'd better face the future and ideally as myself hoping,
V2 will replace V1 everywhere someday:).



> Maybe something mimicking the tst_cgroup_require() from the C api would be
> useful here? I imagine this is where we would
> do the checking and mounting logic that you were describing. We would just
> also have to include checking if the controllers
> we are requiring can be mounted / already exist together.
>
> For example I am imaging something mimicking the C api something like:
> tst_cgroup_require "cpu"
> tst_cgroup_require "cpuset"
> root_mount_point =$(tst_cgroup_get_mountpoint)
>

I prefer this one a bit, not only it's consistent with C API but it also
can do CGroup mounting in tst_cgroup_require for a system without
V1 nor V2 mounting. Then I'd suggest having tst_cgroup_cleanup to
help umount that which makes things more clear to understand.

Anyway, it depends on the details achieve, maybe there is a better
solution we haven't found.



>
> or just combined them together
>
> root_mount_point = $(tst_cgroup_get_mountpoint "cpu cpuset")
>

> Again, most of the tests seem to only be testing individual controllers
> from what I can see
> so I don't know if this would be too useful. Let me know what you think.
>

Yes, the existing legacy tests based on one controller should
just work well to use the new APIs you're going to achieve.
But eventually, I think, those tests also need further refactoring
or rewriting someday.

And, the most important part is that it (CGroup shell APIs) will be
recommended to be used when a new test is written in the future,
so now it requires interfaces that have good scalability and compatibility.
No matter the test target for CGroup itself or just as an auxiliary part,
these shell APIs will play a key ingredient.

-- 
Regards,
Li Wang

--000000000000e6d09f05d224fe15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Dec 2, 2021 at 6:24 AM Luke Nowakowski-Krij=
ger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"_=
blank">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hi Li, <br=
></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"=
>On Wed, Dec 1, 2021 at 1:13 AM Li Wang &lt;<a href=3D"mailto:liwang@redhat=
.com" target=3D"_blank">liwang@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">=
<div style=3D"font-size:small">Hi Luke,</div></div><div><br></div><div><div=
 style=3D"font-size:small">Thanks for looking into this.</div></div><br><di=
v class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 2=
7, 2021 at 8:05 AM Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowak=
owskikrijger@canonical.com" target=3D"_blank">luke.nowakowskikrijger@canoni=
cal.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Update tests to be able to work when memory controller is mounted un=
der<br>
cgroup2 hierarchy.<br></blockquote><div><br></div><div><div style=3D"font-s=
ize:small">I&#39;m thinking whether we could achieve=C2=A0these setup funct=
ions</div><div style=3D"font-size:small">more generic in cgroup_lib.sh, whi=
ch to avoid=C2=A0the redundancy</div><div style=3D"font-size:small">behavio=
r over and over again in each cgroup sub-test.</div><br></div></div></div><=
/blockquote><div>Yes I agree. As I was doing the same things a few times I =
was beginning to wonder if there was a better way. I would be willing to lo=
ok further into</div><div>expanding the cgroup_lib.sh and resubmitting my r=
ecent patches with those changes.</div></div></div></blockquote><div><br></=
div><div><div class=3D"gmail_default" style=3D"font-size:small">Thanks a lo=
t!</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div> <br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gma=
il_quote"><div></div><div><div style=3D"font-size:small">About the compatib=
ility=C2=A0of cgroup V1 and V2 in test, I&#39;d suggest</div><div style=3D"=
font-size:small">following what the LTP C library did in include/tst_cgroup=
.h.</div><div style=3D"font-size:small"><a href=3D"https://github.com/linux=
-test-project/ltp/blob/master/doc/c-test-api.txt#L2024" target=3D"_blank">h=
ttps://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L20=
24</a></div><br></div><div><div style=3D"font-size:small">The solution may =
be briefly as:</div></div><div>=C2=A0</div></div></div></blockquote><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_quote"><div style=3D"font-size:small"></div><div><div style=3D"font-si=
ze:small">=C2=A0 1. scan system mounted CGroup path, and judge the situatio=
n as one of below:</div><div style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0=
* only CGroup V2 mounted</div><div style=3D"font-size:small">=C2=A0 =C2=A0 =
=C2=A0* only CGroup V1 mounted</div><div style=3D"font-size:small">=C2=A0 =
=C2=A0 =C2=A0* both CGroup V2 and V1 mounted</div><div style=3D"font-size:s=
mall">=C2=A0 =C2=A0 =C2=A0* no CGroup mounted</div><div style=3D"font-size:=
small">=C2=A0 2. make use of the system mounted CGroup V2 or TSKIP</div><di=
v style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 * goto step 5</div><div st=
yle=3D"font-size:small">=C2=A0 3. make use of the system mounted CGroup V1=
=C2=A0</div><div style=3D"font-size:small">=C2=A0 =C2=A0 =C2=A0 * goto step=
 5</div><div style=3D"font-size:small">=C2=A0 4. do mount Cgroup as what we=
 needed (V1 or V2) in test</div></div><div style=3D"font-size:small">=C2=A0=
 =C2=A0 =C2=A0 * goto step 5<br></div><div style=3D"font-size:small">=C2=A0=
 5. do cleanup=C2=A0</div><div><br></div></div></div></blockquote><div><br>=
</div><div>Yes this would be the way to go through setting up a controller =
and checking everything.=C2=A0 <div>Going through the steps you mentioned f=
or mounting a single controller and returning that path wouldn&#39;t be too=
 hard but <br></div><div>it seems to get more complicated when we want some=
 guarantee of having multiple controllers in a hierarchy (if we even</div><=
div>would want to support something like that, which for testing purposes w=
ouldnt seem unheard of).<br></div></div></div></div></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">Right, it =
is the complicated part and you can take a reference how</div><div class=3D=
"gmail_default" style=3D"font-size:small">the current C API handles it.</di=
v><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">TBH, I even think to skip th=
e handling on mixed mounting with V1</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">and V2, that is too messy/overthinking and not sugges=
ted using way.</div><div class=3D"gmail_default" style=3D"font-size:small">=
<br></div><div class=3D"gmail_default" style=3D"font-size:small">We&#39;d b=
etter face the future and ideally as myself hoping,</div><div class=3D"gmai=
l_default" style=3D"font-size:small">V2 will replace V1 everywhere someday:=
).</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div><div> </div>May=
be something mimicking the tst_cgroup_require() from the C api would be use=
ful here? I imagine this is where we would</div><div>do the checking and mo=
unting logic that you were describing. We would just also have to include c=
hecking if the controllers</div><div>we are requiring can be mounted / alre=
ady exist together.<br></div><div><br></div><div>For example I am imaging s=
omething mimicking the C api something like:</div><div>tst_cgroup_require &=
quot;cpu&quot;</div><div>tst_cgroup_require &quot;cpuset&quot;</div><div>ro=
ot_mount_point =3D$(tst_cgroup_get_mountpoint)</div></div></div></blockquot=
e><div><div class=3D"gmail_default" style=3D"font-size:small"></div><br></d=
iv><div><div class=3D"gmail_default" style=3D"font-size:small">I prefer thi=
s one a bit, not only it&#39;s consistent with C API but it also</div><div =
class=3D"gmail_default" style=3D"font-size:small">can do CGroup mounting in=
 tst_cgroup_require for a system without</div><div class=3D"gmail_default" =
style=3D"font-size:small">V1 nor V2 mounting. Then I&#39;d suggest having t=
st_cgroup_cleanup to</div><div class=3D"gmail_default" style=3D"font-size:s=
mall">help umount that which makes things more clear to understand.</div><d=
iv class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Anyway, it depends on the deta=
ils achieve, maybe there is a better</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">solution we haven&#39;t found.</div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div class=3D"gmail_quote"><div><br></div><div>or just combined them to=
gether<br></div><div><br></div><div>root_mount_point =3D $(tst_cgroup_get_m=
ountpoint &quot;cpu cpuset&quot;)=C2=A0</div></div></div></blockquote><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D=
"gmail_quote"><div><br></div><div>Again, most of the tests seem to only be =
testing individual controllers from what I can see</div><div>so I don&#39;t=
 know if this would be too useful. Let me know what you think.<br></div></d=
iv></div></blockquote><div><br></div><div><div class=3D"gmail_default" styl=
e=3D"font-size:small">Yes, the existing legacy tests based on one controlle=
r should</div><div class=3D"gmail_default" style=3D"font-size:small">just w=
ork well to use the new APIs you&#39;re going to achieve.=C2=A0</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">But eventually, I think, t=
hose tests also need further refactoring</div><div class=3D"gmail_default" =
style=3D"font-size:small">or rewriting someday. </div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" st=
yle=3D"font-size:small">And, the most important part is that it (CGroup she=
ll APIs) will be=C2=A0</div><div class=3D"gmail_default" style=3D"font-size=
:small">recommended to=C2=A0be used when a new test is written in the futur=
e,</div><div class=3D"gmail_default" style=3D"font-size:small">so now it re=
quires interfaces that have good scalability and compatibility.</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">No matter the test target=
=C2=A0for CGroup itself or just as an auxiliary part,</div><div class=3D"gm=
ail_default" style=3D"font-size:small">these shell APIs will play a key ing=
redient.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div></div></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br><=
/div><div>Li Wang<br></div></div></div></div>

--000000000000e6d09f05d224fe15--


--===============1981732159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1981732159==--

