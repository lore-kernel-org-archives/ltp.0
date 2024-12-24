Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D556E7718B
	for <ltp@archiver.kernel.org>; Tue, 24 Dec 2024 02:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1735008072; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GhPhqMYDdJRoZhzljaXshg84JTTVHKJNTOH+uX8jXHk=;
 b=D7i9qT9AfvKj497nYh4eKyHeCuRSmDYDDufe/tcDwInC0eque+wutcDfj1HMoDh0OLAdP
 6OLMMDdFExJyFjYjGnTflPAFpg9Ag4btCdA3KVGB4+gsY3QfBO5N7GKGxQtS+4hGDEx6QAQ
 zhsH6wnrIOvObIkYPJ8zAwRTyuYGz0w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D0C93EEFF0
	for <ltp@archiver.kernel.org>; Tue, 24 Dec 2024 03:41:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6091F3EEFE9
 for <ltp@lists.linux.it>; Tue, 24 Dec 2024 03:40:50 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 59996648F7D
 for <ltp@lists.linux.it>; Tue, 24 Dec 2024 03:40:48 +0100 (CET)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5d3ea065b79so6860791a12.3
 for <ltp@lists.linux.it>; Mon, 23 Dec 2024 18:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1735008048; x=1735612848; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zxHAhatwqLZ7sYIeUPNfYxuZAG7sQkElKMbNXDwAl10=;
 b=MlXq2S/Hkhd2UOezTQMRmOc9Suod16yCF5lubmlmxud4dQBaqPTK2hfo4ADF1RGWAe
 LzfFRpniiRJ8I8cF4yZUxJ9s8w8pVmmpEMjwAp9wuM/CjIY+FiT/8P5iLSMTHnnp1t0u
 uoxBYxB+xjQzuvyIycjVTukAVYYbTxPu7IwFh3VjC08ihbOWC17xTf9auc/JK1CEOpQy
 KbdJSArMQnQzWhzJYXcWTkvRWjhGAyhSIPzVlhGgpjkmr2C8wusptkB35sWqU+HVjFyJ
 uKm4LZxsmh+SQzbM7ihJPRbV9tGC9k9lmLno5ujwobzDNEdrGEMiwo4nDY5RPpW8ONbI
 ngjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735008048; x=1735612848;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zxHAhatwqLZ7sYIeUPNfYxuZAG7sQkElKMbNXDwAl10=;
 b=jwc+Zy1qenW8xlFRN8umRhUWaPKgx8+hHlIZIJTF/CTGYXc+PdhZ79vMtjfDG8czq+
 joSIU3FivTEMZ80178UFkYuQ2QZAWZ/fIPgxHRimzDR2VEqn16mAgsulu9DWDlsQe7mZ
 lxX1jzQSMbHD8o7KMJh5BA0bj4PkfQHs4hLH6AcOVVN3MGOBw4BK1qUOnBYWnL2JhUCB
 rt7I624k/8zoIW8t/c1nVcGE6Sj2IP/DpvzVrSh1/W5V7j3rXvRIShfcKsy6SPxsKWH1
 opA4m/EDhtgYxkjUS1pjM4ojKunWq42UypGhJNa8wbUDRodBr4pFnnKp5smAEnuCENeU
 0cjg==
X-Gm-Message-State: AOJu0YwztxXZruX5jad/b72lqUfjVBr1ebBnR14ajIQCUWlx+MIZ33oe
 VIF8d6fEb1+w4KRN41h1kwbaTWjCzj3aMK9uYUeWZ0ymCaMGCt7zQznjM1R6zg==
X-Gm-Gg: ASbGncsOj3SkxDDVJOppcfK53XhrRgCOkRp1MLCiQRVXvO0RMMd9EcckGwWsQTlOS7/
 rge4n2TvS+gc6eshKrEUo81fpxT9GF0PQvxsJNfLnno3etRhjrc2jbAaDoPwcSxjcVIBJDxcpoK
 FKJfeFzKz6btj+Cucl+7OQaOP+Ri2MFcXsWJ8dBOuvGd0PTNrYjtoHg+Mo1TuxZJ64Rwp60u2qf
 l7sBfL+ggRyagN1id38Mpk8jlPewzfITRy0wrHt
X-Google-Smtp-Source: AGHT+IF3ccWHXwZLJTNt2cbcWMUlTbkawxrMae9FEvXWKIcvQ67mB0SwfiVLG6YBMtbG/lNG4bU3cw==
X-Received: by 2002:a05:6402:50d0:b0:5d1:1f1:a283 with SMTP id
 4fb4d7f45d1cf-5d81dd849efmr11941411a12.4.1735008047654; 
 Mon, 23 Dec 2024 18:40:47 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d80701b2absm5503298a12.81.2024.12.23.18.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 18:40:47 -0800 (PST)
Date: Mon, 23 Dec 2024 21:40:41 -0500
To: Jin Guojie <guojie.jin@gmail.com>
Message-ID: <Z2ofKS5Aqytyp1d1@wegao>
References: <31564d54-4fea-4450-997d-45e14c4957f4.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSO4HM9aBWEyCszC3-VrYvyv5DCs2ofaheHpsw0j7jiXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+B+MYSO4HM9aBWEyCszC3-VrYvyv5DCs2ofaheHpsw0j7jiXQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Dec 19, 2024 at 02:08:59PM +0800, Jin Guojie wrote:
> V2:
> * Change the expected events in F depending on memory_recursiveprot
> =

> In Patch v1[1], the role of recursive_protection in cgoup v2 was not cons=
idered.
> =

> By carefully reading the algorithm in the kernel function
> effective_protection(). When memory_recursiveprot is enabled, a
> subgroup with usage > 0 can get unclaimed greater than 0.
> =

> The purpose of doing this should be to achieve the essential purpose
> of recursive_protection: the sum of all subgroups' unprotected values
> is equal to parent's unprotected values.
> =

> Even though the documentation does not give an explicit description
> for recursive_memoryprot, it looks like the kernel's processing
> algorithm is reasonable.
> =

> Based on the idea of [2], Patch v2 is rewritten to determine whether
> memory_recursiveprot is enabled.
> =

> On distributions with memory_recursiveprot enabled by default (from
> Ubuntu 22.04 to 24.10), running this passes:
> =

> memcontrol04.c:208: TPASS: Expect: (C oom events=3D0) =3D=3D 0
> memcontrol04.c:211: TPASS: Expect: (C low events=3D966) > 0
> memcontrol04.c:208: TPASS: Expect: (D oom events=3D0) =3D=3D 0
> memcontrol04.c:211: TPASS: Expect: (D low events=3D966) > 0
> memcontrol04.c:208: TPASS: Expect: (E oom events=3D0) =3D=3D 0
> memcontrol04.c:214: TPASS: Expect: (E low events=3D0) =3D=3D 0
> memcontrol04.c:208: TPASS: Expect: (F oom events=3D0) =3D=3D 0
> memcontrol04.c:211: TPASS: Expect: (F low events=3D874) > 0
> =

> [1] https://lists.linux.it/pipermail/ltp/2024-November/040946.html
> [2] https://lore.kernel.org/ltp/20220222144511.GA12037@blackbody.suse.cz/
> =

> Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
> Suggested-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Michal Koutn=FD <mkoutny@suse.com>
> ---
>  include/tst_cgroup.h                              |  2 ++
>  lib/tst_cgroup.c                                  | 12 ++++++++++++
>  testcases/kernel/controllers/memcg/memcontrol04.c |  2 +-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> =

> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> index d23a8e652..068ff8306 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -256,4 +256,6 @@ int safe_cg_occursin(const char *file, const int line=
no,
>                          const char *const file_name,
>                          const char *const needle);
> =

> +int tst_cg_memory_recursiveprot(struct tst_cg_group *cg);
> +
>  #endif /* TST_CGROUP_H */
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 6055015eb..9e3b21ed0 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -76,6 +76,8 @@ struct cgroup_root {
>         int we_mounted_it:1;
>         /* cpuset is in compatability mode */
>         int no_cpuset_prefix:1;
> +
> +       int memory_recursiveprot:1;
>  };
> =

>  /* Controller sub-systems */
> @@ -592,6 +594,7 @@ static void cgroup_root_scan(const char *const mnt_ty=
pe,
>         }
>         for (tok =3D strtok(mnt_opts, ","); tok; tok =3D strtok(NULL, ","=
)) {
>                 nsdelegate |=3D !strcmp("nsdelegate", tok);
> +               root->memory_recursiveprot |=3D
> !strcmp("memory_recursiveprot", tok);
>         }
> =

>         if (root->ver && ctrl_field =3D=3D root->ctrl_field)
> @@ -718,6 +721,7 @@ mount:
>                 tst_res(TINFO, "Mounted V2 CGroups on %s", mnt_path);
>                 tst_cg_scan();
>                 roots[0].we_mounted_it =3D 1;
> +               roots[0].memory_recursiveprot =3D 1;
>                 return;
>         }
> =

> @@ -1509,3 +1513,11 @@ int safe_cg_occursin(const char *const file,
> const int lineno,
> =

>         return !!strstr(buf, needle);
>  }
> +
> +int tst_cg_memory_recursiveprot(struct tst_cg_group *cg)
> +{
> +       if (cg && cg->dirs_by_ctrl[0]->dir_root)
> +               return cg->dirs_by_ctrl[0]->dir_root->memory_recursivepro=
t;
> +       return 0;
> +}
> +
> diff --git a/testcases/kernel/controllers/memcg/memcontrol04.c
> b/testcases/kernel/controllers/memcg/memcontrol04.c
> index 1b8d115f8..9e9d6ab6e 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol04.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol04.c
> @@ -207,7 +207,7 @@ static void test_memcg_low(void)
> =

>                 TST_EXP_EXPR(oom =3D=3D 0, "(%c oom events=3D%ld) =3D=3D =
0", id, oom);
> =

> -               if (i < E) {
> +               if (i < E || ((i =3D=3D F) &&
> tst_cg_memory_recursiveprot(leaf_cg[F]))) {
>                         TST_EXP_EXPR(low > 0,
>                                      "(%c low events=3D%ld) > 0", id, low=
);
>                 } else {
> --
Maybe just give a warning instead of error if event of F > 0, since event o=
f F > 0 has no
real impact on end user, at the same time maybe we will get a fix in kernel=
 side to correct
this behavior.
> 2.34.1
> =

> -- =

> Mailing list info: https://lists.linux.it/listinfo/ltp

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
