Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7872C43334
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 03:34:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 139423C9FEA
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 05:34:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24DFC3C062C
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 05:34:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD3B8600A1C
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 05:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658806453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2KcP3VT3//wmSu/oeHGQlmQlMWiszl/yHTctxapw7FY=;
 b=KetFdX5mhtv0HR4HXoN0781Es1OqV71A4lD3m0cAd/dq4dA8RiqxeP/1I6Nf7SLL8cswmg
 UEXZndebiW9YYvlE+jYQ9bD5G/uxUbysonj3a+J7ckZmzbjrfodtTcQ977ZV86GwFvP4rZ
 r3/9AQuZ79VjCSniGxv/rvfwGSEWEEk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-I8OIlZVKP7yzXUkL0dkAxQ-1; Mon, 25 Jul 2022 23:33:58 -0400
X-MC-Unique: I8OIlZVKP7yzXUkL0dkAxQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-31e6a8e2674so100569997b3.4
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 20:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tyoZAzZEJiL4F/OybqyioN4472mPxi37L1mdFNkISvM=;
 b=uRZ92lhubRd6J1JV1UEpmi+KYvriZKw5TxH1W6idcqZSdjQMIh0DWjirpjyqyqD5bu
 1hFs0v+YwoUf1E4bXUyMDXMZVq0MUMvGXTjTW1nNoUWHrVTlsEqJkC4GzE+hMdvqoumz
 f5b5PqCw9L4ALODy07u9a4jKbx1uwEya4Yxxqf86y65pqJUsDKk0acDPlyWOahBrtPWq
 SXoFNUC/2rUZ5noOQkPcu6ijO7duSkbtont9xSQCowCT4W3pr0r8CsT2VaCpSzsu5vyp
 7e8VJ7yJ+OXTGCs5CD/NMiGHkQVe5QjX7S46AyGqo5FUDxqo+FF1/mmNqFdcYyawmmuJ
 YH2w==
X-Gm-Message-State: AJIora8wYB709m8mEO2Bn+pDQVHq1WZ6ILZ3NylhSZdVpIdyMSN4Hc+a
 ok4Cih1VVruG471WDKBndZlreUCWhY3+p+g0nMGUtpQRj0u3RsFbtJhqQNQH/cnFl9LaUX9Rwt0
 RuGeiYIY8gpO0otcafqPQW//evo4=
X-Received: by 2002:a25:bf86:0:b0:671:3607:1381 with SMTP id
 l6-20020a25bf86000000b0067136071381mr6601331ybk.355.1658806438193; 
 Mon, 25 Jul 2022 20:33:58 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t2rsuuYL3rtLN0MAz0GJP8DsnLakN4FVIvc0FiyY8V0x5y7kQhV0YTB9Ttk6lrrCjvf3FQDckS44k67I0zWt8=
X-Received: by 2002:a25:bf86:0:b0:671:3607:1381 with SMTP id
 l6-20020a25bf86000000b0067136071381mr6601315ybk.355.1658806437931; Mon, 25
 Jul 2022 20:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <d75ac3cf4d3202ac48139805e10e20575d0f53a3.1658433280.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <d75ac3cf4d3202ac48139805e10e20575d0f53a3.1658433280.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jul 2022 11:33:46 +0800
Message-ID: <CAEemH2e_RJGVud7W-D4G442PP-1YhVCyHExQ5KboAkrp9f1tBw@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 18/18] controllers: update
 cgroup_regression_test to use newer cgroup lib
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
Content-Type: multipart/mixed; boundary="===============0470214001=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0470214001==
Content-Type: multipart/alternative; boundary="0000000000007c08f005e4acf844"

--0000000000007c08f005e4acf844
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 22, 2022 at 4:53 AM Luke Nowakowski-Krijger <
luke.nowakowskikrijger@canonical.com> wrote:

> The older function in the cgroup lib 'get_cgroup_mountpoint' has been
> removed, so instead replace it with its old functionaility to get
> mountpoint.
>
> Also use the newer cgroup lib require operation to mount and cleanup a
> cpu controller.
>
> Signed-off-by: Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com>
> ---
> v2: Use cgroup_require "$subsys" instead of manual greping the path
> v3: fixed bug where the ouput of cgroup_get_mountpoint wasnt being
> captured
>
>  .../cgroup/cgroup_regression_test.sh          | 31 ++++++-------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> index 69b51773c..bfa9097ec 100755
> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>

This patch itself looks good.

Note:

But I got one failure from test7 that was caused by randomly picking up
'rdma' ctrl to test.

tst_cgroup.c:820: TBROK: 'rdma' controller is unknown to LTP
cgroup_regression_test 7 TBROK: cgroup_require: No state was set after call
to tst_cgctl require?

  # cat -n cgroup_regression_test.sh

   359 test7()
   360 {
                  ...
   371        subsys=`tail -n 1 /proc/cgroups | awk '{ print $1 }'`

   379 }

Because on my aarch64 (Cgroup V2) test box, the last one in /proc/cgroups:

# cat /proc/cgroups
#subsys_name hierarchy num_cgroups enabled
cpuset 3 3 1
cpu 2 82 1
cpuacct 2 82 1
blkio 9 82 1
memory 12 288 1
devices 4 82 1
freezer 11 3 1
net_cls 6 3 1
perf_event 8 3 1
net_prio 6 3 1
hugetlb 10 3 1
pids 5 110 1
rdma 7 1 1


Anyway, we can fix this by picking a supported cgroup ctrl in a separate
patch.


-- 
Regards,
Li Wang

--0000000000007c08f005e4acf844
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Jul 22, 2022 at 4:53 AM Luke Nowakowski-Kri=
jger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"=
_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">The older function in the cgrou=
p lib &#39;get_cgroup_mountpoint&#39; has been<br>
removed, so instead replace it with its old functionaility to get<br>
mountpoint.<br>
<br>
Also use the newer cgroup lib require operation to mount and cleanup a<br>
cpu controller.<br>
<br>
Signed-off-by: Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowsk=
ikrijger@canonical.com" target=3D"_blank">luke.nowakowskikrijger@canonical.=
com</a>&gt;<br>
---<br>
v2: Use cgroup_require &quot;$subsys&quot; instead of manual greping the pa=
th<br>
v3: fixed bug where the ouput of cgroup_get_mountpoint wasnt being<br>
captured<br>
<br>
=C2=A0.../cgroup/cgroup_regression_test.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 31 ++++++-------------<br>
=C2=A01 file changed, 9 insertions(+), 22 deletions(-)<br>
<br>
diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh =
b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh<br>
index 69b51773c..bfa9097ec 100755<br>
--- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh<br>
+++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh<br></bl=
ockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-siz=
e:small">This patch itself looks good.</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">Note:</div><div class=3D"gmail_default" style=3D"font-size:sm=
all"><br></div><div class=3D"gmail_default" style=3D"font-size:small">But I=
 got one failure from test7 that was caused by randomly picking up &#39;rdm=
a&#39; ctrl to test.</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><br></div><div class=3D"gmail_default" style=3D"font-size:small">tst_=
cgroup.c:820: TBROK: &#39;rdma&#39; controller is unknown to LTP<br>cgroup_=
regression_test 7 TBROK: cgroup_require: No state was set after call to tst=
_cgctl require?<br></div><br></div><div><div class=3D"gmail_default" style=
=3D"font-size:small">=C2=A0 # cat -n cgroup_regression_test.sh</div></div><=
div class=3D"gmail_default" style=3D"font-size:small"><br></div><div><div c=
lass=3D"gmail_default" style=3D"font-size:small">=C2=A0 =C2=A0359=09test7()=
</div>=C2=A0 =C2=A0360=09{<br><div class=3D"gmail_default" style=3D"font-si=
ze:small">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ..=
.</div>=C2=A0 =C2=A0371<span class=3D"gmail_default" style=3D"font-size:sma=
ll">=C2=A0 =C2=A0 =C2=A0 =C2=A0</span>=09=09subsys=3D`tail -n 1 /proc/cgrou=
ps | awk &#39;{ print $1 }&#39;`</div><div><br><div class=3D"gmail_default"=
 style=3D"font-size:small">=C2=A0 =C2=A0379=09}</div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">Because on my aarch64 (Cgro=
up V2) test box, the last one in /proc/cgroups:</div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"># cat /proc/cgroups</div>#s=
ubsys_name=09hierarchy=09num_cgroups=09enabled<br>cpuset=093=093=091<br>cpu=
=092=0982=091<br>cpuacct=092=0982=091<br>blkio=099=0982=091<br>memory=0912=
=09288=091<br>devices=094=0982=091<br>freezer=0911=093=091<br>net_cls=096=
=093=091<br>perf_event=098=093=091<br>net_prio=096=093=091<br>hugetlb=0910=
=093=091<br>pids=095=09110=091<br>rdma=097=091=091<br><div class=3D"gmail_d=
efault" style=3D"font-size:small"></div></div><div><br></div><div><br></div=
><div><div class=3D"gmail_default" style=3D"font-size:small">Anyway, we can=
 fix this by picking a supported cgroup ctrl in a separate patch.</div><br>=
</div></div><div><br></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Re=
gards,<br></div><div>Li Wang<br></div></div></div></div>

--0000000000007c08f005e4acf844--


--===============0470214001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0470214001==--

