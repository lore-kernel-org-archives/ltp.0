Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EC8C433F5
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 11:02:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0F4C3C9F2F
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 12:02:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB4EB3C9ED2
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 12:01:58 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 789BB1A014EA
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 12:01:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644577315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5FUrFtJDzUx+0BPI4LIWLGKqFnm6FKUXZ+gwOGFGP9w=;
 b=AI56nQbiqy49vqFf4tUnCk/AFPqtoGiulfnWrb8+n7UnSc+ramFkUdHZc3g0ZCeHadiuyP
 jHFGhrEQPlyyC8skJIFOfOriBEDaQ/cb4bIIGbK7r1GUQMQD3QuRXl+TgEGJb119QZbPzF
 gGG/vIdHY7DxdvvuD2Ih3nV0TvTIks8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-Y-G1SenONwWcwfO3qlJT4w-1; Fri, 11 Feb 2022 06:01:54 -0500
X-MC-Unique: Y-G1SenONwWcwfO3qlJT4w-1
Received: by mail-yb1-f199.google.com with SMTP id
 h6-20020a253a06000000b0061de83305f2so17946408yba.19
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 03:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5FUrFtJDzUx+0BPI4LIWLGKqFnm6FKUXZ+gwOGFGP9w=;
 b=PZHvpeEnsiOvuu+U0w8xKZBhgYGS8+HRJrxj95st67GtOUwXSqFBFmrgvdAc52HB0I
 X0pxmhJZH9aN3hKiREald45mUdXtGmzz8rfTCytPdrmA3nQwmKzBHfR/xbwJS74A45oT
 IewxWRJc9hTbGwUSr/7G8FsDExkkV+3powCTrOcOPH53xoq2Mo/C+biYGZ7x7STO5KW9
 QOlhYyJZnORV/+8v8xXnT8z9ZK/ABIo/WG0MSLMc2VYQDySN2v8XUX/FEMLoiLb4Vouy
 GZFMr4NGG9/ZYVGKnZsa9Xlk0PPd4eORN/9sxErHulBB1fveXY5gn/on4wGi/638dVZv
 SZag==
X-Gm-Message-State: AOAM531SzSgpUjdf9Pjds3DhLj3wEJFg45SABKcqe8rFrLD4E28vHHz/
 M8dgrw2kZAp0FnF5YweIr6u3rV9h8lUP4zTebIeItqZ9lHHHwE/QMzGuG59LOzxiXEWSKfMJSLO
 jZBxT1T0/h/e61NKf9vOOBiVBTtc=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr1010206ywh.19.1644577313875; 
 Fri, 11 Feb 2022 03:01:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9yQv2ONjgETFYTVlPtGgmYQvSUAR7kJv6qg7GWEXyYNhfmp5C8K6oh+7uM313Lp0Lm6yy6aevgJPNoBch0HM=
X-Received: by 2002:a81:ae0c:: with SMTP id m12mr1010168ywh.19.1644577313398; 
 Fri, 11 Feb 2022 03:01:53 -0800 (PST)
MIME-Version: 1.0
References: <20220210161817.11555-1-mdoucha@suse.cz>
 <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
 <014f765e-ce73-e90b-40ac-875cef4842e4@suse.cz>
 <CAEemH2c6muy5xNGAqhTpVqYwbiVUTFg-gOkHg6JZE_DHLgtxyA@mail.gmail.com>
In-Reply-To: <CAEemH2c6muy5xNGAqhTpVqYwbiVUTFg-gOkHg6JZE_DHLgtxyA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Feb 2022 19:01:39 +0800
Message-ID: <CAEemH2d1ECs=3s63UGu1tLuQu8Uy-e9GSfO1t-yCUi+ZGLKsdQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Terminate leftover subprocesses when main test
 process crashes
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
Content-Type: multipart/mixed; boundary="===============1560140528=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1560140528==
Content-Type: multipart/alternative; boundary="000000000000923c6305d7bbfe69"

--000000000000923c6305d7bbfe69
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 11, 2022 at 6:34 PM Li Wang <liwang@redhat.com> wrote:

>
>
> On Fri, Feb 11, 2022 at 5:17 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
>> On 11. 02. 22 7:47, Li Wang wrote:
>> > On Fri, Feb 11, 2022 at 12:18 AM Martin Doucha <mdoucha@suse.cz
>> > <mailto:mdoucha@suse.cz>> wrote:
>> >     @@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc, char *argv[],
>> >     struct tst_test *self)
>> >
>> >             SAFE_SIGNAL(SIGALRM, alarm_handler);
>> >             SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
>> >     +       SAFE_SIGNAL(SIGCHLD, sigchild_handler);
>> >
>> >
>> > Do we really need setup this signal handler for SIGCHILD?
>> >
>> > Since we have already called 'SAFE_WAITPID(test_pid, &status, 0)'
>> > in the library process (lib_pid) which rely on SIGCHILD as well.
>> > And even this handler will be called everytime when test exit normally.
>> >
>> > Maybe better just add a kill function to cleanup the remain
>> > descendants if main test process exit with abonormal status.
>> >
>> > e.g.
>> >
>> > --- a/lib/tst_test.c
>> > +++ b/lib/tst_test.c
>> > @@ -1503,6 +1503,8 @@ static int fork_testrun(void)
>> >         if (WIFEXITED(status) && WEXITSTATUS(status))
>> >                 return WEXITSTATUS(status);
>> >
>> > +       kill(-test_pid, SIGKILL);
>>
>> This will not work because at this point, the child process was already
>> destroyed by waitpid() and all its remaining children were moved under
>
> PID 1 (init). The only place where the grandchildren are still reachable
>> this way is in SIGCHLD handler while the dead child process still exists
>> in zombie state.
>
>
> Signal communicatoin is asynchronous processing, setup SIGCHILD
> handler can not 100% garantee the libarary process response
> in time as well.
>
> Though the test_pid being moved under PID 1(init), kill(-test_pid, SIGKILL)
> still works well for killing them. That beacuse the dead child process
> still
> exists until kernel recliam its all parent.
>


I give 5 seconds sleep before sending SIGKILL in lib-process
and modified the test_children_cleanup.c to print ppid each 1sec
to verify this:

# ./test_children_cleanup
tst_test.c:1452: TINFO: Timeout per run is 0h 00m 10s
test_children_cleanup.c:20: TINFO: Main process 173236 starting
test_children_cleanup.c:39: TINFO: Forked child 173238
test_children_cleanup.c:33: TINFO: ppid is 173236
test_children_cleanup.c:33: TINFO: ppid is 1
test_children_cleanup.c:33: TINFO: ppid is 1
test_children_cleanup.c:33: TINFO: ppid is 1
test_children_cleanup.c:33: TINFO: ppid is 1
tst_test.c:1502: TINFO: If you are running on slow machine, try exporting
LTP_TIMEOUT_MUL > 1
tst_test.c:1504: TBROK: Test killed! (timeout?)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
=======

--- a/lib/newlib_tests/test_children_cleanup.c
+++ b/lib/newlib_tests/test_children_cleanup.c
@@ -28,7 +28,11 @@ static void run(void)

        /* Start child that will outlive the main test process */
        if (!child_pid) {
-               sleep(30);
+               int i;
+               for (i = 0; i < 30; i++) {
+                       tst_res(TINFO, "ppid is %d", getppid());
+                       sleep(1);
+               }
                return;
        }

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 84ce0a5d3..6f2d93611 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1503,6 +1503,9 @@ static int fork_testrun(void)
        if (WIFEXITED(status) && WEXITSTATUS(status))
                return WEXITSTATUS(status);

+       sleep(5);
+       kill(-test_pid, SIGKILL);
+
        if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
                tst_res(TINFO, "If you are running on slow machine, "
                               "try exporting LTP_TIMEOUT_MUL > 1");


-- 
Regards,
Li Wang

--000000000000923c6305d7bbfe69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 11, 2022 at 6:34 PM Li Wang &lt;<a href=
=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D=
"ltr"><div style=3D"font-size:small"><br></div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 11, 2022 at 5:17=
 PM Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=3D"_blank">=
mdoucha@suse.cz</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">On 11. 02. 22 7:47, Li Wang wrote:<br>
&gt; On Fri, Feb 11, 2022 at 12:18 AM Martin Doucha &lt;<a href=3D"mailto:m=
doucha@suse.cz" target=3D"_blank">mdoucha@suse.cz</a><br>
&gt; &lt;mailto:<a href=3D"mailto:mdoucha@suse.cz" target=3D"_blank">mdouch=
a@suse.cz</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc,=
 char *argv[],<br>
&gt;=C2=A0 =C2=A0 =C2=A0struct tst_test *self)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(SIGALRM, al=
arm_handler);<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SIGNAL(SIGUSR1, he=
artbeat_handler);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_SIGNAL(SIGCHLD, si=
gchild_handler);<br>
&gt; <br>
&gt; <br>
&gt; Do we really need setup this signal handler for SIGCHILD?<br>
&gt; <br>
&gt; Since we have already called &#39;SAFE_WAITPID(test_pid, &amp;status, =
0)&#39;<br>
&gt; in the library process (lib_pid) which rely on SIGCHILD as well.<br>
&gt; And even this handler will be called everytime when test exit normally=
.<br>
&gt; <br>
&gt; Maybe better just add a kill function=C2=A0to cleanup the remain<br>
&gt; descendants if main test process exit with abonormal status.<br>
&gt; <br>
&gt; e.g.<br>
&gt; <br>
&gt; --- a/lib/tst_test.c<br>
&gt; +++ b/lib/tst_test.c<br>
&gt; @@ -1503,6 +1503,8 @@ static int fork_testrun(void)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (WIFEXITED(status) &amp;&amp; WEXITSTAT=
US(status))<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return WEXITST=
ATUS(status);<br>
&gt; =C2=A0<br>
&gt; + =C2=A0 =C2=A0 =C2=A0 kill(-test_pid, SIGKILL);<br>
<br>
This will not work because at this point, the child process was already<br>
destroyed by waitpid() and all its remaining children were moved under</blo=
ckquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
PID 1 (init). The only place where the grandchildren are still reachable<br=
>
this way is in SIGCHLD handler while the dead child process still exists<br=
>
in zombie state.</blockquote><div><br></div><div><div style=3D"font-size:sm=
all">Signal communicatoin is asynchronous processing, setup SIGCHILD</div><=
div>handler can not 100% garantee the libarary process response</div><div s=
tyle=3D"font-size:small">in time as well.</div><br></div><div><div style=3D=
"font-size:small">Though the test_pid being moved under PID 1(init), kill(-=
test_pid, SIGKILL)</div><div style=3D"font-size:small">still works well for=
 killing them. That beacuse the dead child process still</div><div style=3D=
"font-size:small">exists until kernel recliam its all parent.</div></div></=
div></div></blockquote><div><br></div><div><br></div><div><div class=3D"gma=
il_default" style=3D"font-size:small">I give 5 seconds sleep before sending=
 SIGKILL in lib-process</div><div class=3D"gmail_default" style=3D"font-siz=
e:small">and modified the test_children_cleanup.c to print ppid each 1sec</=
div><div class=3D"gmail_default" style=3D"font-size:small">to verify this:<=
/div></div><div><br></div><div class=3D"gmail_default" style=3D"font-size:s=
mall"># ./test_children_cleanup</div>tst_test.c:1452: TINFO: Timeout per ru=
n is 0h 00m 10s<br>test_children_cleanup.c:20: TINFO: Main process 173236 s=
tarting<br>test_children_cleanup.c:39: TINFO: Forked child 173238<br>test_c=
hildren_cleanup.c:33: TINFO: ppid is 173236<br>test_children_cleanup.c:33: =
TINFO: ppid is 1<br>test_children_cleanup.c:33: TINFO: ppid is 1<br>test_ch=
ildren_cleanup.c:33: TINFO: ppid is 1<br>test_children_cleanup.c:33: TINFO:=
 ppid is 1<br>tst_test.c:1502: TINFO: If you are running on slow machine, t=
ry exporting LTP_TIMEOUT_MUL &gt; 1<br>tst_test.c:1504: TBROK: Test killed!=
 (timeout?)<br><br>Summary:<br>passed =C2=A0 0<br>failed =C2=A0 0<br>broken=
 =C2=A0 1<br>skipped =C2=A00<br>warnings 0<br><div class=3D"gmail_default" =
style=3D"font-size:small"></div></div><div class=3D"gmail_default" style=3D=
"font-size:small">=3D=3D=3D=3D=3D=3D=3D</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small"><br></div>--- a/lib/newlib_tests/test_children_cle=
anup.c<br>+++ b/lib/newlib_tests/test_children_cleanup.c<br>@@ -28,7 +28,11=
 @@ static void run(void)<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Start=
 child that will outlive the main test process */<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!child_pid) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sleep(30);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int i;=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i &lt;=
 30; i++) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quot;ppid is %d&quot;, getppid());<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sleep(1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>diff --git a/lib/tst_test.c b/lib/tst_t=
est.c<br>index 84ce0a5d3..6f2d93611 100644<br>--- a/lib/tst_test.c<br>+++ b=
/lib/tst_test.c<br>@@ -1503,6 +1503,9 @@ static int fork_testrun(void)<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (WIFEXITED(status) &amp;&amp; WEXITSTATUS(st=
atus))<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return WE=
XITSTATUS(status);<br>=C2=A0<br>+ =C2=A0 =C2=A0 =C2=A0 sleep(5);<br>+ =C2=
=A0 =C2=A0 =C2=A0 kill(-test_pid, SIGKILL);<br>+<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (WIFSIGNALED(status) &amp;&amp; WTERMSIG(status) =3D=3D SIGKILL) =
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO,=
 &quot;If you are running on slow machine, &quot;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;try exporting LTP_TIMEOUT_MUL &gt; 1&quot;);<br><div=
 class=3D"gmail_default" style=3D"font-size:small"><br></div><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Re=
gards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000923c6305d7bbfe69--


--===============1560140528==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1560140528==--

