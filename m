Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B6FC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 02:36:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10DE83C8D18
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 03:36:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03433C0BA7
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:35:50 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C37AE6008D1
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 03:35:49 +0100 (CET)
Received: by mail-qt1-x829.google.com with SMTP id p19so11597585qtw.12
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 18:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=G+Bwtd4hccdbBEg6XJR8xmKWMDe5fbaxRcI2i1y0oxs=;
 b=dL2HNPnCG7IHvvGS3jt4/+Llii8YYT8vPk5bNqBFv+Xfg05kOsQbfB7SPLVyLEuI06
 NK2Zx185j4h9sZ23c1OuCXmRyzthTtiGaxvoEV/q/jstEUXb+DCS3b0bLG6AOFULWIa/
 1xSezoarab34AbcZn2QeYq9CUa3OJkKhV0SyfTxZ+7T2FxMS8Ie9pndHlKXOWj/SFWDh
 hYAhsJ9a5IWrEI8DHzYL6B6bcCIZObCppUv7Y0mE4A6zPMC9Nu5BBMyFGSmG4DI/5WbF
 uW87uqgRF0cKte3YavNIyE9ESKPUoasgwsIoaf95ssiw+FmtucWF/eqL56NgPrcd934x
 cx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=G+Bwtd4hccdbBEg6XJR8xmKWMDe5fbaxRcI2i1y0oxs=;
 b=YUdnBCoXkwvKXsG7Beif3HGc2HQ6c3iY3S/p4RIuReak5WLVTeadTb+TvPmaU7ZWvW
 5Q7HmNd7MyzSn7k8AGi0YYQpYrjYVHgMbk2gablAc1K2rLGh4VGMunzTbO+1Qq3XpaNM
 D1QrSeLQbURNSreYcDpifi3b/tRU1GFgu4xS9VdPffBgTxex1VRNjwV7QlWT29b7i9bO
 Jut3QAI2orJ2s1rJ+rEeuLKDaxdx3IGZCfOOn3rQKqesA6L8cATZW8o75y+ZHjtk+gk3
 HslLnOIUOaQYPjTBFflH5yJXrt5VF3t/+II38I4iJvcteusDzqvxCaVN9p5fzfnSfi84
 Jydg==
X-Gm-Message-State: AOAM53395gnITElG2lvtyO4KDrg8s+kMJLyweJ3R5XEajXc2mW6iuEsj
 dqVJ2EQ/vjwbXLQYQk9IG6bVox4mvpZGCwlOo6sZHg==
X-Google-Smtp-Source: ABdhPJzPOwehzMafSgRoO2tfh9iKO0br0hCJAUITfkkoiwMvCmKgGvKn2YNLfQtpiu9OygbFJUMcS30ToGG2LF9ROzU=
X-Received: by 2002:a05:622a:4d1:: with SMTP id
 q17mr742455qtx.560.1640054148143; 
 Mon, 20 Dec 2021 18:35:48 -0800 (PST)
MIME-Version: 1.0
References: <20211217021726.2487455-1-yaelt@google.com>
 <YbyW+nRbUnmfHue1@pevik>
In-Reply-To: <YbyW+nRbUnmfHue1@pevik>
Date: Mon, 20 Dec 2021 21:35:37 -0500
Message-ID: <CAKoutNuSwbSs6E7BPQXyWFRxy2P=5+M86CMNbGFcLw0mB=m9DQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/keyctl09: test encrypted keys.
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
From: Yael Tiomkin via ltp <ltp@lists.linux.it>
Reply-To: Yael Tiomkin <yaelt@google.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0741726454=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0741726454==
Content-Type: multipart/alternative; boundary="000000000000ea07f605d39edce6"

--000000000000ea07f605d39edce6
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 17, 2021 at 8:56 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Yael,
>
> > Test that encrypted keys can be instantiated using
> > both user-provided decrypted data
> > (
> https://lore.kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/
> ),
> > or kernel-generated numbers.
>
> Thanks a lot for adding this test. There are few missing things:
>
> BTW all mentioned here is implemented here to speedup your work:
> https://github.com/pevik/ltp/tree/yael_tiomkin/keyctl09.fixes
> Below is diff of my suggested changes.
>
> What I didn't solve is broken test when run with more than 1 iteration:
>
> ./keyctl09 -i2
> tst_test.c:1423: TINFO: Timeout per run is 0h 05m 00s
> keyctl09.c:47: TPASS: Encrypted keys were successfully instantiated and
> read
> keyctl09.c:31: TBROK: Failed to instantiate encrypted key using payload
> decrypted data: EINVAL (22)
>
> NOTE: you can specify test setup to do things only once. You should also
> cleanup
> after test run with test cleanup.
>
> https://github.com/linux-test-project/ltp/wiki/C-Test-API#11-basic-test-structure
>
> You also need to add entry to testcases/kernel/syscalls/keyctl/.gitignore
> /keyctl09
>
> and runtest/syscalls
> keyctl09 keyctl09
>
> ...
> > +/*
> > + * Description: This tests that encrypted keys can be instantiated using
> > + * user-provided decrypted data (plaintext), and separately, using
> > + * kernel-generated key material.
> > + */
>
> I'd rephrase it a bit and use LTP metadata formatting
> /*\
>  * [Description]
>  * Test that encrypted keys can be instantiated using user-provided
> decrypted
>  * data (plaintext), and separately, using kernel-generated key material.
>  */
>
> FYI metadata is LTP documentation - here is the output:
>
> https://github.com/linux-test-project/ltp/releases/download/20210121/metadata.20210121.html
>
> https://github.com/linux-test-project/ltp/releases/download/20210121/metadata.20210121.pdf
>
> You can run make in docparse/ directory and then see in output in
> metadata/metadata.{html,pdf}.
>
> > +
> > +#include <errno.h>
> > +#include <stdint.h>
> IMHO these 2 aren't needed.
> > +
> > +#include "tst_test.h"
> > +#include "lapi/keyctl.h"
> > +
> > +static void do_test(void)
> > +{
> > +     key_serial_t masterkey;
> > +     key_serial_t encryptedkey1;
> > +     key_serial_t encryptedkey2;
> > +     char buffer[128];
> > +
> > +     masterkey = add_key("user", "user:masterkey", "foo", 3,
> KEY_SPEC_PROCESS_KEYRING);
> > +     if (masterkey == -1)
> > +             tst_brk(TBROK | TERRNO, "Failed to add user key");
> > +
> > +     encryptedkey1 = add_key("encrypted", "ltptestkey1", "new enc32
> user:masterkey 32 plaintext12345678901234567890123", 60,
> KEY_SPEC_PROCESS_KEYRING);
> nit: It'd be nice to keep 80 lines per line (or 100 with string).
> Maybe use #define for payload, which makes it shorter?
>
> > +     if (encryptedkey1 == -1)
> > +             tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted
> key using payload decrypted data");
> > +
> > +     TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, sizeof(buffer)));
> > +     if (TST_RET < 0)
> > +             tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for
> encryptedkey1");
> > +
> > +     encryptedkey2 = add_key("encrypted", "ltptestkey2", "new enc32
> user:masterkey 32", 27, KEY_SPEC_PROCESS_KEYRING);
> > +     if (encryptedkey2 == -1)
> > +             tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted
> key using kernel-generated key material");
> > +
> > +     TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
> > +     if (TST_RET < 0)
> > +             tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for
> encryptedkey2");
> At least one of these should be TFAIL - failing test. TBROK is used when
> test
> fails in test preparation phase. Also have look at
> include/tst_test_macros.h
> you can use e.g. TST_EXP_PASS_SILENT().
>
> Kind regards,
> Petr
>
> diff --git runtest/syscalls runtest/syscalls
> index bcf3d56c9c..ccea1ddbdb 100644
> --- runtest/syscalls
> +++ runtest/syscalls
> @@ -643,6 +643,7 @@ keyctl05 keyctl05
>  keyctl06 keyctl06
>  keyctl07 keyctl07
>  keyctl08 keyctl08
> +keyctl09 keyctl09
>
>  kcmp01 kcmp01
>  kcmp02 kcmp02
> diff --git testcases/kernel/syscalls/keyctl/.gitignore
> testcases/kernel/syscalls/keyctl/.gitignore
> index 3544ac79ce..f9948c1766 100644
> --- testcases/kernel/syscalls/keyctl/.gitignore
> +++ testcases/kernel/syscalls/keyctl/.gitignore
> @@ -6,3 +6,4 @@
>  /keyctl06
>  /keyctl07
>  /keyctl08
> +/keyctl09
> diff --git testcases/kernel/syscalls/keyctl/keyctl09.c
> testcases/kernel/syscalls/keyctl/keyctl09.c
> index 4589ef3679..7481526c67 100644
> --- testcases/kernel/syscalls/keyctl/keyctl09.c
> +++ testcases/kernel/syscalls/keyctl/keyctl09.c
> @@ -3,15 +3,12 @@
>   * Copyright (c) 2021 Google, Inc.
>   */
>
> -/*
> - * Description: This tests that encrypted keys can be instantiated using
> - * user-provided decrypted data (plaintext), and separately, using
> - * kernel-generated key material.
> +/*\
> + * [Description]
> + * Test that encrypted keys can be instantiated using user-provided
> decrypted
> + * data (plaintext), and separately, using kernel-generated key material.
>   */
>
> -#include <errno.h>
> -#include <stdint.h>
> -
>  #include "tst_test.h"
>  #include "lapi/keyctl.h"
>
> @@ -22,11 +19,14 @@ static void do_test(void)
>         key_serial_t encryptedkey2;
>         char buffer[128];
>
> -       masterkey = add_key("user", "user:masterkey", "foo", 3,
> KEY_SPEC_PROCESS_KEYRING);
> +       masterkey = add_key("user", "user:masterkey", "foo", 3,
> +                           KEY_SPEC_PROCESS_KEYRING);
>         if (masterkey == -1)
>                 tst_brk(TBROK | TERRNO, "Failed to add user key");
>
> -       encryptedkey1 = add_key("encrypted", "ltptestkey1", "new enc32
> user:masterkey 32 plaintext12345678901234567890123", 60,
> KEY_SPEC_PROCESS_KEYRING);
> +       encryptedkey1 = add_key("encrypted", "ltptestkey1",
> +                               "new enc32 user:masterkey 32
> plaintext12345678901234567890123",
> +                               60, KEY_SPEC_PROCESS_KEYRING);
>         if (encryptedkey1 == -1)
>                 tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted
> key using payload decrypted data");
>
> @@ -34,9 +34,11 @@ static void do_test(void)
>         if (TST_RET < 0)
>                 tst_brk(TBROK | TTERRNO, "KEYCTL_READ failed for
> encryptedkey1");
>
> -       encryptedkey2 = add_key("encrypted", "ltptestkey2", "new enc32
> user:masterkey 32", 27, KEY_SPEC_PROCESS_KEYRING);
> +       encryptedkey2 = add_key("encrypted", "ltptestkey2", "new enc32
> user:masterkey 32",
> +                               27, KEY_SPEC_PROCESS_KEYRING);
>         if (encryptedkey2 == -1)
> -               tst_brk(TBROK | TERRNO, "Failed to instantiate encrypted
> key using kernel-generated key material");
> +               tst_brk(TBROK | TERRNO,
> +                       "Failed to instantiate encrypted key using
> kernel-generated key material");
>
>         TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, sizeof(buffer)));
>         if (TST_RET < 0)
>

Thank you Petr for the feedback!

I have implemented your suggestions and will repost the patch shortly.
The test failed when multiple iterations were run because the same
encrypted key cannot be added more than once. The updated test also revokes
the keys and it now passes with multiple iterations.

Yael

--000000000000ea07f605d39edce6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 17, 2021 at 8:56 AM Petr =
Vorel &lt;<a href=3D"mailto:pvorel@suse.cz">pvorel@suse.cz</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Yael,<br>
<br>
&gt; Test that encrypted keys can be instantiated using<br>
&gt; both user-provided decrypted data<br>
&gt; (<a href=3D"https://lore.kernel.org/linux-integrity/20211213192030.125=
091-1-yaelt@google.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/linux-integrity/20211213192030.125091-1-yaelt@google.com/</a>),<=
br>
&gt; or kernel-generated numbers.<br>
<br>
Thanks a lot for adding this test. There are few missing things:<br>
<br>
BTW all mentioned here is implemented here to speedup your work:<br>
<a href=3D"https://github.com/pevik/ltp/tree/yael_tiomkin/keyctl09.fixes" r=
el=3D"noreferrer" target=3D"_blank">https://github.com/pevik/ltp/tree/yael_=
tiomkin/keyctl09.fixes</a><br>
Below is diff of my suggested changes.<br>
<br>
What I didn&#39;t solve is broken test when run with more than 1 iteration:=
<br>
<br>
./keyctl09 -i2<br>
tst_test.c:1423: TINFO: Timeout per run is 0h 05m 00s<br>
keyctl09.c:47: TPASS: Encrypted keys were successfully instantiated and rea=
d<br>
keyctl09.c:31: TBROK: Failed to instantiate encrypted key using payload dec=
rypted data: EINVAL (22)<br>
<br>
NOTE: you can specify test setup to do things only once. You should also cl=
eanup<br>
after test run with test cleanup.<br>
<a href=3D"https://github.com/linux-test-project/ltp/wiki/C-Test-API#11-bas=
ic-test-structure" rel=3D"noreferrer" target=3D"_blank">https://github.com/=
linux-test-project/ltp/wiki/C-Test-API#11-basic-test-structure</a><br>
<br>
You also need to add entry to testcases/kernel/syscalls/keyctl/.gitignore<b=
r>
/keyctl09<br>
<br>
and runtest/syscalls<br>
keyctl09 keyctl09<br>
<br>
...<br>
&gt; +/*<br>
&gt; + * Description: This tests that encrypted keys can be instantiated us=
ing<br>
&gt; + * user-provided decrypted data (plaintext), and separately, using<br=
>
&gt; + * kernel-generated key material.<br>
&gt; + */<br>
<br>
I&#39;d rephrase it a bit and use LTP metadata formatting<br>
/*\<br>
=C2=A0* [Description]<br>
=C2=A0* Test that encrypted keys can be instantiated using user-provided de=
crypted<br>
=C2=A0* data (plaintext), and separately, using kernel-generated key materi=
al.<br>
=C2=A0*/<br>
<br>
FYI metadata is LTP documentation - here is the output:<br>
<a href=3D"https://github.com/linux-test-project/ltp/releases/download/2021=
0121/metadata.20210121.html" rel=3D"noreferrer" target=3D"_blank">https://g=
ithub.com/linux-test-project/ltp/releases/download/20210121/metadata.202101=
21.html</a><br>
<a href=3D"https://github.com/linux-test-project/ltp/releases/download/2021=
0121/metadata.20210121.pdf" rel=3D"noreferrer" target=3D"_blank">https://gi=
thub.com/linux-test-project/ltp/releases/download/20210121/metadata.2021012=
1.pdf</a><br>
<br>
You can run make in docparse/ directory and then see in output in<br>
metadata/metadata.{html,pdf}.<br>
<br>
&gt; +<br>
&gt; +#include &lt;errno.h&gt;<br>
&gt; +#include &lt;stdint.h&gt;<br>
IMHO these 2 aren&#39;t needed.<br>
&gt; +<br>
&gt; +#include &quot;tst_test.h&quot;<br>
&gt; +#include &quot;lapi/keyctl.h&quot;<br>
&gt; +<br>
&gt; +static void do_test(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0key_serial_t masterkey;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0key_serial_t encryptedkey1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0key_serial_t encryptedkey2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char buffer[128];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0masterkey =3D add_key(&quot;user&quot;, &quot;use=
r:masterkey&quot;, &quot;foo&quot;, 3, KEY_SPEC_PROCESS_KEYRING);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (masterkey =3D=3D -1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TERRN=
O, &quot;Failed to add user key&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0encryptedkey1 =3D add_key(&quot;encrypted&quot;, =
&quot;ltptestkey1&quot;, &quot;new enc32 user:masterkey 32 plaintext1234567=
8901234567890123&quot;, 60, KEY_SPEC_PROCESS_KEYRING);<br>
nit: It&#39;d be nice to keep 80 lines per line (or 100 with string).<br>
Maybe use #define for payload, which makes it shorter?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (encryptedkey1 =3D=3D -1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TERRN=
O, &quot;Failed to instantiate encrypted key using payload decrypted data&q=
uot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TEST(keyctl(KEYCTL_READ, encryptedkey1, buffer, s=
izeof(buffer)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (TST_RET &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TTERR=
NO, &quot;KEYCTL_READ failed for encryptedkey1&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0encryptedkey2 =3D add_key(&quot;encrypted&quot;, =
&quot;ltptestkey2&quot;, &quot;new enc32 user:masterkey 32&quot;, 27, KEY_S=
PEC_PROCESS_KEYRING);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (encryptedkey2 =3D=3D -1)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TERRN=
O, &quot;Failed to instantiate encrypted key using kernel-generated key mat=
erial&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer, s=
izeof(buffer)));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (TST_RET &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TTERR=
NO, &quot;KEYCTL_READ failed for encryptedkey2&quot;);<br>
At least one of these should be TFAIL - failing test. TBROK is used when te=
st<br>
fails in test preparation phase. Also have look at include/tst_test_macros.=
h<br>
you can use e.g. TST_EXP_PASS_SILENT().<br>
<br>
Kind regards,<br>
Petr<br>
<br>
diff --git runtest/syscalls runtest/syscalls<br>
index bcf3d56c9c..ccea1ddbdb 100644<br>
--- runtest/syscalls<br>
+++ runtest/syscalls<br>
@@ -643,6 +643,7 @@ keyctl05 keyctl05<br>
=C2=A0keyctl06 keyctl06<br>
=C2=A0keyctl07 keyctl07<br>
=C2=A0keyctl08 keyctl08<br>
+keyctl09 keyctl09<br>
<br>
=C2=A0kcmp01 kcmp01<br>
=C2=A0kcmp02 kcmp02<br>
diff --git testcases/kernel/syscalls/keyctl/.gitignore testcases/kernel/sys=
calls/keyctl/.gitignore<br>
index 3544ac79ce..f9948c1766 100644<br>
--- testcases/kernel/syscalls/keyctl/.gitignore<br>
+++ testcases/kernel/syscalls/keyctl/.gitignore<br>
@@ -6,3 +6,4 @@<br>
=C2=A0/keyctl06<br>
=C2=A0/keyctl07<br>
=C2=A0/keyctl08<br>
+/keyctl09<br>
diff --git testcases/kernel/syscalls/keyctl/keyctl09.c testcases/kernel/sys=
calls/keyctl/keyctl09.c<br>
index 4589ef3679..7481526c67 100644<br>
--- testcases/kernel/syscalls/keyctl/keyctl09.c<br>
+++ testcases/kernel/syscalls/keyctl/keyctl09.c<br>
@@ -3,15 +3,12 @@<br>
=C2=A0 * Copyright (c) 2021 Google, Inc.<br>
=C2=A0 */<br>
<br>
-/*<br>
- * Description: This tests that encrypted keys can be instantiated using<b=
r>
- * user-provided decrypted data (plaintext), and separately, using<br>
- * kernel-generated key material.<br>
+/*\<br>
+ * [Description]<br>
+ * Test that encrypted keys can be instantiated using user-provided decryp=
ted<br>
+ * data (plaintext), and separately, using kernel-generated key material.<=
br>
=C2=A0 */<br>
<br>
-#include &lt;errno.h&gt;<br>
-#include &lt;stdint.h&gt;<br>
-<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
=C2=A0#include &quot;lapi/keyctl.h&quot;<br>
<br>
@@ -22,11 +19,14 @@ static void do_test(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 key_serial_t encryptedkey2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char buffer[128];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0masterkey =3D add_key(&quot;user&quot;, &quot;u=
ser:masterkey&quot;, &quot;foo&quot;, 3, KEY_SPEC_PROCESS_KEYRING);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0masterkey =3D add_key(&quot;user&quot;, &quot;u=
ser:masterkey&quot;, &quot;foo&quot;, 3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0KEY_SPEC_PROCESS_KEYRING);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (masterkey =3D=3D -1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK | TER=
RNO, &quot;Failed to add user key&quot;);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0encryptedkey1 =3D add_key(&quot;encrypted&quot;=
, &quot;ltptestkey1&quot;, &quot;new enc32 user:masterkey 32 plaintext12345=
678901234567890123&quot;, 60, KEY_SPEC_PROCESS_KEYRING);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0encryptedkey1 =3D add_key(&quot;encrypted&quot;=
, &quot;ltptestkey1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;new enc32 user:masterkey 32 pla=
intext12345678901234567890123&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A060, KEY_SPEC_PROCESS_KEYRING);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (encryptedkey1 =3D=3D -1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK | TER=
RNO, &quot;Failed to instantiate encrypted key using payload decrypted data=
&quot;);<br>
<br>
@@ -34,9 +34,11 @@ static void do_test(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (TST_RET &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK | TTE=
RRNO, &quot;KEYCTL_READ failed for encryptedkey1&quot;);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0encryptedkey2 =3D add_key(&quot;encrypted&quot;=
, &quot;ltptestkey2&quot;, &quot;new enc32 user:masterkey 32&quot;, 27, KEY=
_SPEC_PROCESS_KEYRING);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0encryptedkey2 =3D add_key(&quot;encrypted&quot;=
, &quot;ltptestkey2&quot;, &quot;new enc32 user:masterkey 32&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A027, KEY_SPEC_PROCESS_KEYRING);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (encryptedkey2 =3D=3D -1)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TER=
RNO, &quot;Failed to instantiate encrypted key using kernel-generated key m=
aterial&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TER=
RNO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to instantiate encrypted key using kernel-generated =
key material&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST(keyctl(KEYCTL_READ, encryptedkey2, buffer,=
 sizeof(buffer)));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (TST_RET &lt; 0)<br></blockquote><div><br></=
div><div>Thank you Petr for the feedback!</div><div><br></div><div>I have i=
mplemented your suggestions and will repost the patch shortly.</div><div>Th=
e test failed when multiple iterations were run because the same encrypted =
key cannot be added more than once. The updated test also revokes the keys =
and it now passes with multiple iterations.</div><div><br></div><div>Yael</=
div></div></div>

--000000000000ea07f605d39edce6--

--===============0741726454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0741726454==--
