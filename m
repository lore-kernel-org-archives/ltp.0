Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F09C433FE
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 10:35:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 263573C9F27
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 11:35:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 635373C574A
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 11:35:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B558C601029
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 11:35:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644575700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xe6XfGjBGbFIszMJE+YG/e65ieZlGWKs+bTQYsY6CqI=;
 b=Bclk3glCyxj5H++o+4jPGlkMRhdmvk6Lhm7wVNyPl7DSumr9CpextOYn5qJ1b3gYleO2RJ
 KNJe2jz1/9kr/4nvBdpGCnKk+N9bQSTF1Pw9cOXy7PQb6XKs0rkeUEPrOIbaQmaB9tpZdz
 w4rqbQWw3XOawiOpc9wXYY+FuwnUA3Q=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-eyxkY26ePr-KDfnFO_BHdQ-1; Fri, 11 Feb 2022 05:34:58 -0500
X-MC-Unique: eyxkY26ePr-KDfnFO_BHdQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 v134-20020a25618c000000b00620dc86b9d6so10533869ybb.0
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 02:34:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xe6XfGjBGbFIszMJE+YG/e65ieZlGWKs+bTQYsY6CqI=;
 b=jgK/umkO9vKsjpLo58BxD3EI9WKjzO3UJr9XMgaHhUJMkToAIm09R3L8G59xX3E5Fq
 CztOfrpqTeVhgBL8TBT6E1UvhwDWc1ZlTCow1zyuzs99YuttFrEOVNEthpVsE21bli7x
 5p+MwR2OrNyVuiOgiM6u426Y1Teg27dqDEgRCXsuVN6KbHYDzb6IY96oOsnFe+ZU5kJ/
 poTYcnd6bqDDMgSB9W/DTuwGrzCeutDTCXSn6rRehvETrPU9hxtEgNxudkf9D2LYhgcg
 roD43PBI+ssa//BtzswHswjWRapT0BZOHiNCnZdz7fg+gdksIX0fwJwmONLeaTCTCxAe
 tEUw==
X-Gm-Message-State: AOAM532g8Jx1dkirfxdrdDttophE8HZdDxUm9B8ubNrAORxOX/MTMWt9
 Pjjf2JmKQQHAqGfXJk+fCTWfL2jB1BMS45058iUceNRphKhsXvbxnrsX+3o/l4/C6qEwkLH3e8Q
 BVbN4C3vUB1TKvrIc3S2jkxkcHeU=
X-Received: by 2002:a05:6902:56a:: with SMTP id
 a10mr680847ybt.398.1644575698031; 
 Fri, 11 Feb 2022 02:34:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFyDcD5f+Yzp7WdJ9ER2Y0ajTUSjZq+HqhSyfqSOpMd9wh7gNTJC+hSNxJZVtzDgDQ1UAwulH+0DOrN7DjOfg=
X-Received: by 2002:a05:6902:56a:: with SMTP id
 a10mr680837ybt.398.1644575697814; 
 Fri, 11 Feb 2022 02:34:57 -0800 (PST)
MIME-Version: 1.0
References: <20220210161817.11555-1-mdoucha@suse.cz>
 <CAEemH2cmyRbkQ3-4MvY3jhTaEJ+A430WNyKixE2YRKuyiL6djw@mail.gmail.com>
 <014f765e-ce73-e90b-40ac-875cef4842e4@suse.cz>
In-Reply-To: <014f765e-ce73-e90b-40ac-875cef4842e4@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Feb 2022 18:34:42 +0800
Message-ID: <CAEemH2c6muy5xNGAqhTpVqYwbiVUTFg-gOkHg6JZE_DHLgtxyA@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0316613005=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0316613005==
Content-Type: multipart/alternative; boundary="000000000000465de305d7bb9e41"

--000000000000465de305d7bb9e41
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 11, 2022 at 5:17 PM Martin Doucha <mdoucha@suse.cz> wrote:

> On 11. 02. 22 7:47, Li Wang wrote:
> > On Fri, Feb 11, 2022 at 12:18 AM Martin Doucha <mdoucha@suse.cz
> > <mailto:mdoucha@suse.cz>> wrote:
> >     @@ -1560,6 +1568,7 @@ void tst_run_tcases(int argc, char *argv[],
> >     struct tst_test *self)
> >
> >             SAFE_SIGNAL(SIGALRM, alarm_handler);
> >             SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
> >     +       SAFE_SIGNAL(SIGCHLD, sigchild_handler);
> >
> >
> > Do we really need setup this signal handler for SIGCHILD?
> >
> > Since we have already called 'SAFE_WAITPID(test_pid, &status, 0)'
> > in the library process (lib_pid) which rely on SIGCHILD as well.
> > And even this handler will be called everytime when test exit normally.
> >
> > Maybe better just add a kill function to cleanup the remain
> > descendants if main test process exit with abonormal status.
> >
> > e.g.
> >
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1503,6 +1503,8 @@ static int fork_testrun(void)
> >         if (WIFEXITED(status) && WEXITSTATUS(status))
> >                 return WEXITSTATUS(status);
> >
> > +       kill(-test_pid, SIGKILL);
>
> This will not work because at this point, the child process was already
> destroyed by waitpid() and all its remaining children were moved under

PID 1 (init). The only place where the grandchildren are still reachable
> this way is in SIGCHLD handler while the dead child process still exists
> in zombie state.


Signal communicatoin is asynchronous processing, setup SIGCHILD
handler can not 100% garantee the libarary process response
in time as well.

Though the test_pid being moved under PID 1(init), kill(-test_pid, SIGKILL)
still works well for killing them. That beacuse the dead child process still
exists until kernel recliam its all parent.


-- 
Regards,
Li Wang

--000000000000465de305d7bb9e41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Feb 11, 2022 at 5:17 PM Martin Doucha &lt;<=
a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On 11. 02. 22 7:47, Li Wan=
g wrote:<br>
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
in zombie state.</blockquote><div><br></div><div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">Signal communicatoin is asynchronous processin=
g, setup SIGCHILD</div><div class=3D"gmail_default">handler can not 100% ga=
rantee the libarary process response</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">in time as well.</div><br></div><div><div class=3D"gm=
ail_default" style=3D"font-size:small">Though the test_pid being moved unde=
r PID 1(init), kill(-test_pid, SIGKILL)</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">still works well for killing them. That beacuse th=
e dead child process still</div><div class=3D"gmail_default" style=3D"font-=
size:small">exists until kernel recliam its all parent.</div></div><div><br=
></div></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signatur=
e"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></di=
v></div>

--000000000000465de305d7bb9e41--


--===============0316613005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0316613005==--

