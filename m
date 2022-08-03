Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F9BC19F28
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 07:50:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 996753C8A72
	for <ltp@archiver.kernel.org>; Wed,  3 Aug 2022 09:50:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFC783C25DD
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 09:50:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6FF30140012D
 for <ltp@lists.linux.it>; Wed,  3 Aug 2022 09:50:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1659513001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0p/Ux3Chye6QIqpjgTqeAflPr67Y57KS/FbzI2UyHI=;
 b=VpKKY3dD4QbTTDZ1MLo2Ag0ZDcaBshCKqpqB+ccPRcDMcZQH+9d9vlqnTqRGcxNdEoUlOW
 uDkZ8M8uRfA6ANSBplj+Tl7MhD/gqcDrj7Rh3JHiaZ1mQsbpBL2xtsTHNB5Bu9NHWtIA9s
 vAV9CZhl8YJHy/O+2dimaP7jzMomMQw=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-YyqghUr8NlCd3CL4yCif9A-1; Wed, 03 Aug 2022 03:49:59 -0400
X-MC-Unique: YyqghUr8NlCd3CL4yCif9A-1
Received: by mail-yb1-f199.google.com with SMTP id
 m123-20020a253f81000000b0066ff6484995so12911801yba.22
 for <ltp@lists.linux.it>; Wed, 03 Aug 2022 00:49:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h0p/Ux3Chye6QIqpjgTqeAflPr67Y57KS/FbzI2UyHI=;
 b=xROzJYAKVu13xn87HEouNbmGazUlHWgueOCtFBHEnPnAvzkTmFtuQDxd0ttJ1dYAb6
 2NVqpLqGpk7U39WGforn0VS+Z8ASd+Mh5Jl5s0rb7Ko9z7ovTiLippfnksBEHU6HJnum
 3RXaSbl+aN/veh4A7FCRnkHU9ekTCEmpfX4aG1NiOm7zSnr1994Ww11NvnLtLWInXP3z
 41VR0BPbJggKD5DJ4PU6KqB+0gk+E8ast3GjnMPVFhYSZOLeeugJkLTUoOHyyWQH4HvH
 6nU4pgF02mnKzp2TOPRxE0rJZh+mdMhDxSnCDofbESWYR1Jvlu2fLwmL5cW9UY8HhGXU
 SMEA==
X-Gm-Message-State: ACgBeo2rTzxXfhd9puHqlC5WJTRBvtswyWBL6pDwx1brrw+F+GJecyqf
 Kfn2+ReDT8xchQ7OEEtqq9TKGcSiQ7YfK+khqCH1g32bAJR+AZnFrua/fx8DyCj3J7HaNH4YZZW
 jHp1V/CdvtcyWUIM/NbHS9PF7Y00=
X-Received: by 2002:a81:1595:0:b0:31f:420f:abe5 with SMTP id
 143-20020a811595000000b0031f420fabe5mr22111162ywv.15.1659512998964; 
 Wed, 03 Aug 2022 00:49:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4fMfwX7lFRJ+mR79tLj2EVKZOES/qbVw+rK+H+fuVtr2iOb6lwsmFiYTGEhB6JlEbZe+ljRu1H/bW0HJzQo8c=
X-Received: by 2002:a81:1595:0:b0:31f:420f:abe5 with SMTP id
 143-20020a811595000000b0031f420fabe5mr22111145ywv.15.1659512998652; Wed, 03
 Aug 2022 00:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220725100641.11625-1-rpalethorpe@suse.com>
In-Reply-To: <20220725100641.11625-1-rpalethorpe@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 3 Aug 2022 15:49:47 +0800
Message-ID: <CAEemH2ck+baL4PA5F5OoL1VRCS+W=CJHpXJbx9-jUNVa9ofR0Q@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] read_all: Add worker timeout and rewrite
 scheduling
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
Content-Type: multipart/mixed; boundary="===============1868034500=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1868034500==
Content-Type: multipart/alternative; boundary="000000000000c905ed05e5517a7d"

--000000000000c905ed05e5517a7d
Content-Type: text/plain; charset="UTF-8"

Hi Richard, All,

On Mon, Jul 25, 2022 at 6:06 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> Kill and restart workers that take too long to read a file. The
> default being 10% of max_runtime. A custom time can be set with the
> new -t option.
>
> This is to prevent a worker from blocking forever in a read. Currently
> when this happens the whole test times out and any remaining files in
> the worker's queue are not tested.
>
> As a side effect we can now also set the timeout very low to cause
> partial reads. However setting it to less than the time it takes to
> start (fork) a new worker is treated as an error. Forking takes much
> longer than most reads.
>
> A number of other possible issues were fixed as well as a side effect
> of changing the scheduling:
>
> + The worker queues are now filled in a
>   "round robin" way. Before this only happened when -r was large
>   enough.
> + When testing is finished the main process waits on the child procs before
>   destroying the semaphores and worker queues.
> + max_runtime is set to 100 secs. This is so that the worker timeout
>   is a round number.
> + Files which don't implement O_NONBLOCK and may block, no longer need
>   to be avoided. Even if they refuse to die immediately;
>   although this may result in TBROK due to zombie processes.
>
> Note that with a worker timeout of 1s, 2 to 3 files will usually timeout on
> my workstation. With 2s, none will. In any case testing completes in
> under 3s for proc, sys or dev.
>
> This is much faster than many other machines. It's quite likely the
> worker timeout and max_runtime need to be increased on small and very
> large machines. This can be done manually by setting LTP_RUNTIME_MUL.
>

Yes, apart from a bit of difficulty (at least for me) to comprehend the
detailed
behavior of this scheduler :).

Thanks for your improvements! Just one tiny query below.

Reviewed-by: Li Wang <liwang@redhat.com>



> --- a/testcases/kernel/fs/read_all/read_all.c
> +++ b/testcases/kernel/fs/read_all/read_all.c
> ...


> +#include <signal.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <sys/wait.h>
>  #include <lapi/fnmatch.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> @@ -43,7 +45,10 @@
>  #include <pwd.h>
>  #include <grp.h>
>
> +#include "tst_atomic.h"
> +#include "tst_safe_clocks.h"
>  #include "tst_test.h"
> +#include "tst_timer.h"
>
>  #define QUEUE_SIZE 16384
>  #define BUFFER_SIZE 1024
> @@ -55,11 +60,15 @@ struct queue {
>         int front;
>         int back;
>         char data[QUEUE_SIZE];
>

I doubt whether we need to maintain a queue to store the paths.
During the test it seems only one path is being pushed in the q->data[],
so the rest of the space is wasted, right?

By shrinking the QUEUE_SIZE to equal BUFFER_SIZE, the test
still works normally.



> +       char popped[BUFFER_SIZE];
>  };
>
>  struct worker {
> +       int i;
>         pid_t pid;
>         struct queue *q;
> +       int last_seen;
> +       unsigned int kill_sent:1;
>  };
>
>

-- 
Regards,
Li Wang

--000000000000c905ed05e5517a7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Hi=C2=A0Richard, All,</div></div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 25, 2022 at 6:06 PM Ri=
chard Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.com" target=3D"_bla=
nk">rpalethorpe@suse.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Kill and restart workers that take too long to read=
 a file. The<br>
default being 10% of max_runtime. A custom time can be set with the<br>
new -t option.<br>
<br>
This is to prevent a worker from blocking forever in a read. Currently<br>
when this happens the whole test times out and any remaining files in<br>
the worker&#39;s queue are not tested.<br>
<br>
As a side effect we can now also set the timeout very low to cause<br>
partial reads. However setting it to less than the time it takes to<br>
start (fork) a new worker is treated as an error. Forking takes much<br>
longer than most reads.<br>
<br>
A number of other possible issues were fixed as well as a side effect<br>
of changing the scheduling:<br>
<br>
+ The worker queues are now filled in a<br>
=C2=A0 &quot;round robin&quot; way. Before this only happened when -r was l=
arge<br>
=C2=A0 enough.<br>
+ When testing is finished the main process waits on the child procs before=
<br>
=C2=A0 destroying the semaphores and worker queues.<br>
+ max_runtime is set to 100 secs. This is so that the worker timeout<br>
=C2=A0 is a round number.<br>
+ Files which don&#39;t implement O_NONBLOCK and may block, no longer need<=
br>
=C2=A0 to be avoided. Even if they refuse to die immediately;<br>
=C2=A0 although this may result in TBROK due to zombie processes.<br>
<br>
Note that with a worker timeout of 1s, 2 to 3 files will usually timeout on=
<br>
my workstation. With 2s, none will. In any case testing completes in<br>
under 3s for proc, sys or dev.<br>
<br>
This is much faster than many other machines. It&#39;s quite likely the<br>
worker timeout and max_runtime need to be increased on small and very<br>
large machines. This can be done manually by setting LTP_RUNTIME_MUL.<br></=
blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-s=
ize:small">Yes, apart from a bit of difficulty (at least for me) to compreh=
end the detailed</div><div class=3D"gmail_default" style=3D"font-size:small=
">behavior of this scheduler :).=C2=A0</div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">Thanks for your improvements! Just one tiny query below.</div=
><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div clas=
s=3D"gmail_default" style=3D"font-size:small">Reviewed-by: Li Wang &lt;<a h=
ref=3D"mailto:liwang@redhat.com" target=3D"_blank">liwang@redhat.com</a>&gt=
;<br></div><br></div><div>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
--- a/testcases/kernel/fs/read_all/read_all.c<br>
+++ b/testcases/kernel/fs/read_all/read_all.c<br>
<span class=3D"gmail_default" style=3D"font-size:small">...</span></blockqu=
ote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
+#include &lt;signal.h&gt;<br>
=C2=A0#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;sys/stat.h&gt;<br>
+#include &lt;sys/wait.h&gt;<br>
=C2=A0#include &lt;lapi/fnmatch.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;stdio.h&gt;<br>
@@ -43,7 +45,10 @@<br>
=C2=A0#include &lt;pwd.h&gt;<br>
=C2=A0#include &lt;grp.h&gt;<br>
<br>
+#include &quot;tst_atomic.h&quot;<br>
+#include &quot;tst_safe_clocks.h&quot;<br>
=C2=A0#include &quot;tst_test.h&quot;<br>
+#include &quot;tst_timer.h&quot;<br>
<br>
=C2=A0#define QUEUE_SIZE 16384<br>
=C2=A0#define BUFFER_SIZE 1024<br>
@@ -55,11 +60,15 @@ struct queue {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int front;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int back;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char data[QUEUE_SIZE];<br></blockquote><div><br=
></div><div><div class=3D"gmail_default" style=3D"font-size:small">I doubt =
whether we need to maintain a queue to store the paths.</div><div class=3D"=
gmail_default" style=3D"font-size:small">During the test it seems only one =
path is being pushed in the q-&gt;data[],</div><div class=3D"gmail_default"=
 style=3D"font-size:small">so the rest of the space is wasted, right?</div>=
<div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">By shrinking the QUEUE_SIZE to=
 equal BUFFER_SIZE, the test</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">still works normally.</div><br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char popped[BUFFER_SIZE];<br>
=C2=A0};<br>
<br>
=C2=A0struct worker {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pid_t pid;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct queue *q;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int last_seen;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int kill_sent:1;<br>
=C2=A0};<br>
<br></blockquote><div><br></div><div>=C2=A0</div></div>-- <br><div dir=3D"l=
tr"><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></d=
iv></div>

--000000000000c905ed05e5517a7d--


--===============1868034500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1868034500==--

