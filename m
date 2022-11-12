Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9C6C4332F
	for <ltp@archiver.kernel.org>; Sat, 12 Nov 2022 08:27:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53DFD3CD426
	for <ltp@archiver.kernel.org>; Sat, 12 Nov 2022 09:27:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27BFF3CAC18
 for <ltp@lists.linux.it>; Sat, 12 Nov 2022 09:27:43 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6E161200071
 for <ltp@lists.linux.it>; Sat, 12 Nov 2022 09:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668241660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y5YNOpxOaTist6WqtbhbA3GzZwF6gD15RdB2kbUUU3A=;
 b=QyqRQYGuKNO9u8HJDlF9u71IOFIOS5yeexmEXvFRdfmfgZcmYrvYtLVqK412UCvfU0Ssr5
 g2swtXW1EuLOYeH8GW+ndrWS3rowgOe4Or0GYdhMXtIKNSVw4XU973lItOqGn5b6fZiO3X
 7csxCvtR39D1XmBWT4VxlQtoZEfG8+A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-219-zz9bsr4COaWHvzrXy8-chw-1; Sat, 12 Nov 2022 03:27:38 -0500
X-MC-Unique: zz9bsr4COaWHvzrXy8-chw-1
Received: by mail-wm1-f72.google.com with SMTP id
 1-20020a05600c028100b003cf7833293cso5748466wmk.3
 for <ltp@lists.linux.it>; Sat, 12 Nov 2022 00:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y5YNOpxOaTist6WqtbhbA3GzZwF6gD15RdB2kbUUU3A=;
 b=JZd0k4yWceLLX3Kh9GurCcLuf771klETSTTscyzFJBCtLRYEoZuaBSckmmk7pjFg0O
 mERXOSSK+iMJvyJKHuPsqjIHwKfc65+mYrQ22uNkF2uP7exo5JQLrz3vIeJq1cj3IgmW
 HRm3CX423jm1MYakcli2fhyubWFwOT/IenYP69AarDkjNwa67z0W3cQsKbGRfVBT8Pyc
 /vaN4py5VvcBjRvpIhsXjM/zdpz6Ka4VcwttjDc6RrGaqK19Mxte1ABkL4+sXNLwDdDD
 Ayb+j4R88b9vk8ACegKXY9bmltaysSBdN9/0BZ67CRoc/J054oF6mzd6QFOK7r196gJN
 0sBg==
X-Gm-Message-State: ANoB5pmyV4YpzQ4S2qyJgC+t0NcCQV+vW27UZpxJdv/ugEOwl6wF7orr
 reROrEK65SDFCg8woIbgxr8kT9X3sO88W9Zye24JZv5LRfPj7Q3mlboAuyLnisfXx8ws/UMCRQH
 8Iox34koa/7NQ/KqzTEY4bZBSapM=
X-Received: by 2002:a5d:4042:0:b0:236:8322:4bd5 with SMTP id
 w2-20020a5d4042000000b0023683224bd5mr2918123wrp.129.1668241657219; 
 Sat, 12 Nov 2022 00:27:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7/Ps83DocfvxbtqFnq4cMMZRe8VoZOZ020pT9kYMG7fSptXbAHRG7R8F/6HNBtID9JfnzOAHmfSapqdfyQZ6E=
X-Received: by 2002:a5d:4042:0:b0:236:8322:4bd5 with SMTP id
 w2-20020a5d4042000000b0023683224bd5mr2918120wrp.129.1668241657011; Sat, 12
 Nov 2022 00:27:37 -0800 (PST)
MIME-Version: 1.0
References: <20221111160812.10437-1-mdoucha@suse.cz>
In-Reply-To: <20221111160812.10437-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 12 Nov 2022 16:27:25 +0800
Message-ID: <CAEemH2d1ONow28Db9gNT8BV_LtjjrQVGs1dLaYkVg8PpiPzR_Q@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] save_restore: Introduce new struct field
 for flags
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
Cc: ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============1461873238=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1461873238==
Content-Type: multipart/alternative; boundary="0000000000005db9af05ed41c75d"

--0000000000005db9af05ed41c75d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Martin Doucha <mdoucha@suse.cz> wrote:


>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 8844d9f2f..63e5acec8 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1605,35 +1605,33 @@ LTP library can be instructed to save and restore
> value of specified
>  field 'save_restore'. It is a NULL-terminated array of struct
>  'tst_path_val' where each tst_path_val.path represents a file, whose
>  value is saved at the beginning and restored at the end of the test.
> -If non-NULL value is passed it is written to the respective file at
> -the beginning of the test. Only the first line of a specified file
> -is saved and restored.
> -
> -Pathnames can be optionally prefixed to specify how strictly (during
> -'store') are handled errors:
> -
> -* (no prefix) - test ends with 'TCONF', if file doesn't exist
> -* '?'         - test prints info message and continues,
> -                if file doesn't exist or open/read fails
> -* '!'         - test ends with 'TBROK', if file doesn't exist
> +If non-NULL string is passed in tst_path_val.val, it is written
> +to the respective file at the beginning of the test. Only the first line
> +of a specified file is saved and restored.
> +
> +By default, the test will end with TCONF if the file is read-only or
> +does not exist. If the optional write of new value fails, the test will
> end
> +with 'TBROK'. This behavior can be changed using tst_path_val.flags:
> +
> +* 'TST_SR_FAIL_MISSING' =E2=80=93 End test with 'TBROK' if the file does=
 not exist
> +* 'TST_SR_SKIP_MISSING' =E2=80=93 Continue without saving the file if it=
 does not
> exist
> +* 'TST_SR_FAIL_RO' =E2=80=93 End test with 'TBROK' if the file is read-o=
nly
> +* 'TST_SR_SKIP_RO' =E2=80=93 Continue without saving the file if it is r=
ead-only
> +* 'TST_SR_IGNORE_ERR' =E2=80=93 Ignore errors when writing new value int=
o the file
> +* 'TST_SR_REQUIRED' =E2=80=93 Equivalent to 'TST_SR_FAIL_MISSING | TST_S=
R_FAIL_RO'
> +* 'TST_SR_COND_ACCESS' =E2=80=93 Equivalent to 'TST_SR_SKIP_MISSING |
> TST_SR_SKIP_RO'
>
>  'restore' is always strict and will TWARN if it encounters any error.
>
>  [source,c]
>
>  ------------------------------------------------------------------------=
-------
> -static void setup(void)
> -{
> -       FILE_PRINTF("/proc/sys/kernel/core_pattern", "/mypath");
> -       SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d",
> 10);
> -}
> -
>  static struct tst_test test =3D {
>         ...
>         .setup =3D setup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"/proc/sys/kernel/core_pattern", NULL},
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> -               {"!/sys/kernel/mm/ksm/run", "1"},
> +               {"/proc/sys/kernel/core_pattern", NULL, 0},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>

This should be TST_SR_COND_ACCESS ^

Reviewed-by: Li Wang <liwang@redhat.com>


--=20
Regards,
Li Wang

--0000000000005db9af05ed41c75d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=
=3D"_blank">mdoucha@suse.cz</a>&gt; wrote:<br></div></div><div class=3D"gma=
il_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt<br>
index 8844d9f2f..63e5acec8 100644<br>
--- a/doc/c-test-api.txt<br>
+++ b/doc/c-test-api.txt<br>
@@ -1605,35 +1605,33 @@ LTP library can be instructed to save and restore v=
alue of specified<br>
=C2=A0field &#39;save_restore&#39;. It is a NULL-terminated array of struct=
<br>
=C2=A0&#39;tst_path_val&#39; where each tst_path_val.path represents a file=
, whose<br>
=C2=A0value is saved at the beginning and restored at the end of the test.<=
br>
-If non-NULL value is passed it is written to the respective file at<br>
-the beginning of the test. Only the first line of a specified file<br>
-is saved and restored.<br>
-<br>
-Pathnames can be optionally prefixed to specify how strictly (during<br>
-&#39;store&#39;) are handled errors:<br>
-<br>
-* (no prefix) - test ends with &#39;TCONF&#39;, if file doesn&#39;t exist<=
br>
-* &#39;?&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- test prints info message =
and continues,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if file doesn&#39;=
t exist or open/read fails<br>
-* &#39;!&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- test ends with &#39;TBROK=
&#39;, if file doesn&#39;t exist<br>
+If non-NULL string is passed in tst_path_val.val, it is written<br>
+to the respective file at the beginning of the test. Only the first line<b=
r>
+of a specified file is saved and restored.<br>
+<br>
+By default, the test will end with TCONF if the file is read-only or<br>
+does not exist. If the optional write of new value fails, the test will en=
d<br>
+with &#39;TBROK&#39;. This behavior can be changed using tst_path_val.flag=
s:<br>
+<br>
+* &#39;TST_SR_FAIL_MISSING&#39; =E2=80=93 End test with &#39;TBROK&#39; if=
 the file does not exist<br>
+* &#39;TST_SR_SKIP_MISSING&#39; =E2=80=93 Continue without saving the file=
 if it does not exist<br>
+* &#39;TST_SR_FAIL_RO&#39; =E2=80=93 End test with &#39;TBROK&#39; if the =
file is read-only<br>
+* &#39;TST_SR_SKIP_RO&#39; =E2=80=93 Continue without saving the file if i=
t is read-only<br>
+* &#39;TST_SR_IGNORE_ERR&#39; =E2=80=93 Ignore errors when writing new val=
ue into the file<br>
+* &#39;TST_SR_REQUIRED&#39; =E2=80=93 Equivalent to &#39;TST_SR_FAIL_MISSI=
NG | TST_SR_FAIL_RO&#39;<br>
+* &#39;TST_SR_COND_ACCESS&#39; =E2=80=93 Equivalent to &#39;TST_SR_SKIP_MI=
SSING | TST_SR_SKIP_RO&#39;<br>
<br>
=C2=A0&#39;restore&#39; is always strict and will TWARN if it encounters an=
y error.<br>
<br>
=C2=A0[source,c]<br>
=C2=A0---------------------------------------------------------------------=
----------<br>
-static void setup(void)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0FILE_PRINTF(&quot;/proc/sys/kernel/core_pattern=
&quot;, &quot;/mypath&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_TRY_FILE_PRINTF(&quot;/proc/sys/user/max_u=
ser_namespaces&quot;, &quot;%d&quot;, 10);<br>
-}<br>
-<br>
=C2=A0static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/core_pattern&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/run&quot;, &quot;1&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/core_pattern&quot;, NULL, 0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br></blockquote><div=
><br></div><div class=3D"gmail_default" style=3D"font-size:small">This shou=
ld be TST_SR_COND_ACCESS ^</div><div class=3D"gmail_default" style=3D"font-=
size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small=
">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com" target=3D"_=
blank">liwang@redhat.com</a>&gt;<br></div><div class=3D"gmail_default" styl=
e=3D"font-size:small"><br></div></div><div><br></div>-- <br><div dir=3D"ltr=
"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div=
></div>

--0000000000005db9af05ed41c75d--


--===============1461873238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1461873238==--

