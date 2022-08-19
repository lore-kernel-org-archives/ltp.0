Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299F0C32789
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 09:04:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E4BE3CA33A
	for <ltp@archiver.kernel.org>; Mon, 22 Aug 2022 11:04:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AE583C65EB
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 00:34:37 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5EF2F14001EE
 for <ltp@lists.linux.it>; Sat, 20 Aug 2022 00:34:37 +0200 (CEST)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-3321c2a8d4cso157243677b3.5
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 15:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc;
 bh=ZlWbI++jh8dqP5fLWt1UFrn3ApOU9dqiRzqm6PTMrG4=;
 b=tOOwgFa1L/GC9/dSeYlO9lz6r+s/Y73u8pYRZ/ZtmXEcAjlZGepG4OOA2ViviS6yDI
 /PtrZKxHTBXqCGOE3Pc/31ZI1pf5rgDl7sDfCWPExTeZwxSuSH3N0/iR/tShXPZ0DrUC
 A01uKnzaDERsHZ6YpwFSW3B6x/d9Aq1+3G7GmqfGPK0pXV0ijK90uL2NjAYrVZLi4xYJ
 faCkTc+bfrB/68onT/5cSri9+aOQu6kGqS3ZI15g9v/pk7rNllvOg7rDUAAQjHNp0idu
 Z/x6lVTTfJ/x68/QM3Q1506brEaSLMVe6Bw5QOy39R7ZSfZilSUJYG2UodiRoP6OX1s6
 Kb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc;
 bh=ZlWbI++jh8dqP5fLWt1UFrn3ApOU9dqiRzqm6PTMrG4=;
 b=aFSe2XrETs6oslviMJCsh0agmDZknXbNT0v6c5+kF1/dosTU69AvCEbuioIfR3f7KX
 RcUHynvm5RX8ab6ll4MFrHlpDNM7XLFPW415bdwbKsgOTUo4UduQZ52DgfXxT6S8QTAb
 cAt9VK8z95UOdsSI0T8gxRpsbAc30QewbEvlIU+Mb0f2dh8h5cg5pn7ErXmVpKB6s+kx
 H19szgld8AdoAuJzG1leXbRZ9sAEhTWVrpH3CSAu44PxddqbYY9E845Bxu8gtr8G7fsi
 hCLDi747PZr9/8BUHn+WO2UYlsB5QL1UMk3SiQz0UdGrjEh2J6+k+lfbIC04F6jCKd8G
 qn4A==
X-Gm-Message-State: ACgBeo1oT2Z5Pv/NPEoi9DaRNrFJR6TdSQRuCmV3LY0Pmr9meNlnrduw
 2Xw9XNJDXLl/BnrgcJCYsPB6lne3sbFoZiH4xeYoxfSe9bVJ/w==
X-Google-Smtp-Source: AA6agR4qa22g2Tr52pLpBHeTi8XH0OQYbg0+4ku/jXXbXWtJx9aUkVvMR4/3hWHs0fU+Scl3jTitp4ODuopJy7SAt/I=
X-Received: by 2002:a0d:c307:0:b0:335:6fff:dc70 with SMTP id
 f7-20020a0dc307000000b003356fffdc70mr9884556ywd.493.1660948475949; Fri, 19
 Aug 2022 15:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220819213148.1995580-1-edliaw@google.com>
In-Reply-To: <20220819213148.1995580-1-edliaw@google.com>
Date: Fri, 19 Aug 2022 15:34:25 -0700
Message-ID: <CAMvVZq0DKK7PydiVwbS1GZoSaJLu=qUSXq_xi17wQS176hHt3g@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 22 Aug 2022 11:04:29 +0200
Subject: Re: [LTP] [PATCH v2] syscalls/signal06: loop being clobbered by
 syscall on clang
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
From: Viktor Martensson via ltp <ltp@lists.linux.it>
Reply-To: Viktor Martensson <vmartensson@google.com>
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0802915950=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0802915950==
Content-Type: multipart/alternative; boundary="000000000000e6a61c05e69fb30a"

--000000000000e6a61c05e69fb30a
Content-Type: text/plain; charset="UTF-8"

Hello!

The syscall will get the return value in %rax I believe, so it may be wise
to indicate that it gets modified no? I would assume something like

*int foo; *
asm volatile ("syscall" : *"=a" (foo)*: "a"(__NR_tkill), "D"(pid),
"S"(SIGHUP) : "rcx", "r11");

would instruct the compiler to expect that %rax has been modified, and it
can't rely on it staying the same. An optimization pass may otherwise take
away the repeated setting of __NR_tkill in %rax.

/V

On Fri, Aug 19, 2022 at 2:31 PM 'Edward Liaw' via kernel-team <
kernel-team@android.com> wrote:

> Indicate to the compiler that the syscall will modify registers rcx
> and r11 to prevent loop from getting clobbered.
>
> Signed-off-by: Edward Liaw <edliaw@google.com>
>
> ---
> When I combined the asm instruction into one line, it threw an error
> that the "Asm-specifier for input or output variable conflicts with asm
> clobber list" for rax.  I omitted it for now, but I'm not sure if that
> is correct.
>
> Also, is it ok to change the subject line like I did?
> ---
>  testcases/kernel/syscalls/signal/signal06.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/signal/signal06.c
> b/testcases/kernel/syscalls/signal/signal06.c
> index 64f886ee3..fba380610 100644
> --- a/testcases/kernel/syscalls/signal/signal06.c
> +++ b/testcases/kernel/syscalls/signal/signal06.c
> @@ -72,8 +72,7 @@ void test(void)
>         while (D == VALUE && loop < LOOPS) {
>                 /* sys_tkill(pid, SIGHUP); asm to avoid save/reload
>                  * fp regs around c call */
> -               asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
> -               asm ("syscall" : : : "ax");
> +               asm volatile ("syscall" : : "a"(__NR_tkill), "D"(pid),
> "S"(SIGHUP) : "rcx", "r11");
>
>                 loop++;
>         }
> --
> 2.37.2.609.g9ff673ca1a-goog
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an
> email to kernel-team+unsubscribe@android.com.
>
>

--000000000000e6a61c05e69fb30a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello!<br></div><div><br></div><div>The syscall will =
get the return value in %rax I believe, so it may be wise to indicate that =
it gets modified no? I would assume something like</div><div><br></div><div=
><font face=3D"monospace" color=3D"#990000"><b>int foo;=C2=A0</b></font></d=
iv><div><font face=3D"monospace">asm volatile (&quot;syscall&quot; : <font =
color=3D"#990000"><b>&quot;=3Da&quot; (foo)</b>:</font> &quot;a&quot;(__NR_=
tkill), &quot;D&quot;(pid), &quot;S&quot;(SIGHUP) : &quot;rcx&quot;, &quot;=
r11&quot;);<br></font></div><div><br></div><div>would instruct the compiler=
 to expect that %rax has been modified, and it can&#39;t rely on it staying=
 the same. An optimization pass may otherwise take away the repeated settin=
g of __NR_tkill in %rax.=C2=A0</div><div>=C2=A0</div><div>/V</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, A=
ug 19, 2022 at 2:31 PM &#39;Edward Liaw&#39; via kernel-team &lt;<a href=3D=
"mailto:kernel-team@android.com">kernel-team@android.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">Indicate to the com=
piler that the syscall will modify registers rcx<br>
and r11 to prevent loop from getting clobbered.<br>
<br>
Signed-off-by: Edward Liaw &lt;<a href=3D"mailto:edliaw@google.com" target=
=3D"_blank">edliaw@google.com</a>&gt;<br>
<br>
---<br>
When I combined the asm instruction into one line, it threw an error<br>
that the &quot;Asm-specifier for input or output variable conflicts with as=
m<br>
clobber list&quot; for rax.=C2=A0 I omitted it for now, but I&#39;m not sur=
e if that<br>
is correct.<br>
<br>
Also, is it ok to change the subject line like I did?<br>
---<br>
=C2=A0testcases/kernel/syscalls/signal/signal06.c | 3 +--<br>
=C2=A01 file changed, 1 insertion(+), 2 deletions(-)<br>
<br>
diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel=
/syscalls/signal/signal06.c<br>
index 64f886ee3..fba380610 100644<br>
--- a/testcases/kernel/syscalls/signal/signal06.c<br>
+++ b/testcases/kernel/syscalls/signal/signal06.c<br>
@@ -72,8 +72,7 @@ void test(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (D =3D=3D VALUE &amp;&amp; loop &lt; LOOP=
S) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* sys_tkill(pid, S=
IGHUP); asm to avoid save/reload<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* fp regs aro=
und c call */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0asm (&quot;&quot; :=
 : &quot;a&quot;(__NR_tkill), &quot;D&quot;(pid), &quot;S&quot;(SIGHUP));<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0asm (&quot;syscall&=
quot; : : : &quot;ax&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0asm volatile (&quot=
;syscall&quot; : : &quot;a&quot;(__NR_tkill), &quot;D&quot;(pid), &quot;S&q=
uot;(SIGHUP) : &quot;rcx&quot;, &quot;r11&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 loop++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.37.2.609.g9ff673ca1a-goog<br>
<br>
-- <br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:kernel-team%2Bunsubscribe@android.com" target=3D"=
_blank">kernel-team+unsubscribe@android.com</a>.<br>
<br>
</blockquote></div>

--000000000000e6a61c05e69fb30a--

--===============0802915950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0802915950==--
