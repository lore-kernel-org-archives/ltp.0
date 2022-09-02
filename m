Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7CEECAAD3
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 03:00:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B9223CA6D4
	for <ltp@archiver.kernel.org>; Fri,  2 Sep 2022 05:00:56 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49FF73CA5F7
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 05:00:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8F5F0600A5E
 for <ltp@lists.linux.it>; Fri,  2 Sep 2022 05:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1662087638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHCK9z+V2FjJcmAUcygm4//A2aNu1YXd9ofvZYxYZEQ=;
 b=HCovbutAomDsvDktm/OAlfwf79T84xMPXxB7T7N8MiaTIinO646EHroGy2QXGuvhjjgHOr
 G73qYWKT6K2F+iE0bNYor9Y2dF7b2nyjhgT6T6NjWl0/RxsCHweLJypdQaPOLAAd1P7T0o
 +zEBeMflnSzr/6REyC/KrCOISmEbNLk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-446-1YNu6fMvNpC_ki9SvBIP6A-1; Thu, 01 Sep 2022 23:00:37 -0400
X-MC-Unique: 1YNu6fMvNpC_ki9SvBIP6A-1
Received: by mail-yb1-f199.google.com with SMTP id
 d135-20020a25688d000000b0069578d248abso799316ybc.21
 for <ltp@lists.linux.it>; Thu, 01 Sep 2022 20:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=hHCK9z+V2FjJcmAUcygm4//A2aNu1YXd9ofvZYxYZEQ=;
 b=V9S4p2cFCjJJ039ehiPVvG5ZS8Ul5xffHzVVKAbwwvvDOubgvDB/Zd1ZAehYTLnZqL
 SGHxTP4BuPrOZpqXT4D9en3PbhHJYjLOZl4kGPIS8wifQzN1SKVMXmAdYYG6IObEwMJC
 4Rvk4TS05AWT3yJPTm9lPmAGauxNhR2PvW+pjripY2csHmA6cPfYijmT7BqE3KNTRYIT
 u/OO/bDGN4wT12BcRIUjrfsunrCGCdnn0CdwTArC7IGpzPZoUHBEfzJ48hOnt+ju8Vl9
 flw8HSDipxghJ6LjHBgyeq6jjJCnIA+9rqIzaU85A5xrPmp1Ndtu2E7JUFYPtUQ+A35O
 xLiw==
X-Gm-Message-State: ACgBeo2j2picpdP/M3kiPtfYstTgQqRKVFf6+ZpoAL64BDcR7YCa9OWe
 dDOrSn4qP7lw99qm5E7r4mMz6fmuVZ+9wQ4/kVei0hCyKyv0EthO8PUc3oiO5/NbNF5rFgEKmMd
 czYxhEFCcNKLiW1mSjtNjbKi97XU=
X-Received: by 2002:a25:ac5d:0:b0:695:ba5f:3b07 with SMTP id
 r29-20020a25ac5d000000b00695ba5f3b07mr22301489ybd.186.1662087636696; 
 Thu, 01 Sep 2022 20:00:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6xeetykMy9u0/SCV0dJCCBfhxH2DVEaXL1pazMNcWM7Am0jFkx8e9/dmk3G/l/7NvqikXa/g/U/0oeDoj1cP8=
X-Received: by 2002:a25:ac5d:0:b0:695:ba5f:3b07 with SMTP id
 r29-20020a25ac5d000000b00695ba5f3b07mr22301473ybd.186.1662087636370; Thu, 01
 Sep 2022 20:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220830105418.15966-1-akumar@suse.de>
 <CAEemH2eLoJwm_+ORaoT7xamtqvLTekN7H7NWmU-ErXPMdK+77w@mail.gmail.com>
 <1830205.tdWV9SEqCh@localhost>
In-Reply-To: <1830205.tdWV9SEqCh@localhost>
From: Li Wang <liwang@redhat.com>
Date: Fri, 2 Sep 2022 11:00:25 +0800
Message-ID: <CAEemH2eZtuSrrLqfJRMB3rRMK3tye3OD_YzeqR6fXskSMOX8Lw@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getsid02.c: Rewrite using new LTP API
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
Content-Type: multipart/mixed; boundary="===============1414561315=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1414561315==
Content-Type: multipart/alternative; boundary="00000000000026da7605e7a8ef5d"

--00000000000026da7605e7a8ef5d
Content-Type: text/plain; charset="UTF-8"

On Thu, Sep 1, 2022 at 6:59 PM Avinesh Kumar <akumar@suse.de> wrote:

> Hi Li,
>
> On Wednesday, August 31, 2022 12:10:44 PM IST Li Wang wrote:
> > On Tue, Aug 30, 2022 at 6:54 PM Avinesh Kumar <akumar@suse.de> wrote:
> >
> > > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > > ---
> > >  testcases/kernel/syscalls/getsid/getsid02.c | 83 +++++----------------
> > >  1 file changed, 17 insertions(+), 66 deletions(-)
> > >
> > > diff --git a/testcases/kernel/syscalls/getsid/getsid02.c
> > > b/testcases/kernel/syscalls/getsid/getsid02.c
> > > index b5ab339e2..c235af362 100644
> > > --- a/testcases/kernel/syscalls/getsid/getsid02.c
> > > +++ b/testcases/kernel/syscalls/getsid/getsid02.c
> > > @@ -1,81 +1,32 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > >  /*
> > > - *
> > >   *   Copyright (c) International Business Machines  Corp., 2001
> > >   *   Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
> > > - *
> > > - *   This program is free software;  you can redistribute it and/or
> modify
> > > - *   it under the terms of the GNU General Public License as
> published by
> > > - *   the Free Software Foundation; either version 2 of the License, or
> > > - *   (at your option) any later version.
> > > - *
> > > - *   This program is distributed in the hope that it will be useful,
> > > - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > > - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > > - *   the GNU General Public License for more details.
> > > - *
> > > - *   You should have received a copy of the GNU General Public License
> > > - *   along with this program;  if not, write to the Free Software
> > > - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > > 02110-1301 USA
> > > + *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <
> avinesh.kumar@suse.com>
> > >   */
> > >
> > > -#define _GNU_SOURCE 1
> > > -
> > > -#include "test.h"
> > > -
> > > -#include <errno.h>
> > > +/*\
> > > + * [Description]
> > > + *
> > > + * Verify that getsid(2) fails with ESRCH errno when there is no
> > > + * process found with process ID pid.
> > > + */
> > >
> > > -char *TCID = "getsid02";
> > > -int TST_TOTAL = 1;
> > > +#include "tst_test.h"
> > >
> > >  static pid_t unused_pid;
> > >
> > > -static void cleanup(void);
> > > -static void setup(void);
> > > -
> > > -int main(int ac, char **av)
> > > +static void setup(void)
> > >  {
> > > -       int lc;
> > > -
> > > -       tst_parse_opts(ac, av, NULL, NULL);
> > > -
> > > -       setup();
> > > -
> > > -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> > > -               tst_count = 0;
> > > -
> > > -               TEST(getsid(unused_pid));
> > > -
> > > -               if (TEST_RETURN == 0) {
> > > -                       tst_resm(TFAIL, "call succeed when failure
> > > expected");
> > > -                       continue;
> > > -               }
> > > -
> > > -               switch (TEST_ERRNO) {
> > > -               case ESRCH:
> > > -                       tst_resm(TPASS, "expected failure - errno = %d
> -
> > > %s",
> > > -                                TEST_ERRNO, strerror(TEST_ERRNO));
> > > -                       break;
> > > -               default:
> > > -                       tst_resm(TFAIL, "call failed to produce "
> > > -                                "expected error - errno = %d - %s",
> > > -                                TEST_ERRNO, strerror(TEST_ERRNO));
> > > -                       break;
> > > -               }
> > > -       }
> > > -
> > > -       cleanup();
> > > -       tst_exit();
> > > +       unused_pid = tst_get_unused_pid();
> > >
> >
> > We can simply move this to the main function to avoid unused PID
> > reusing again if people perform test with '-i N'.
> >
> > How about this below:
> >
> > #include "tst_test.h"
> >
> > static void run(void)
> > {
> >     pid_t unused_pid;
> >     unused_pid = tst_get_unused_pid();
> >
> >     TST_EXP_FAIL(getsid(unused_pid), ESRCH);
> > }
> >
> > static struct tst_test test = {
> >     .test_all = run
> > };
> >
> >
> Yes, I agree to your suggestion. But while testing '-i N' with this code
> also I am getting the same unused_pid which is equal to
> /proc/sys/kernel/pid_max in my env.
>

Ah, right. I additionally checked the "Linux Programming Interface
Handbook",
it says the maximum PID number that can be used is 'pid_max - 1'. So I
realized
that why the tst_unused_pid() just read the value of
'/proc/sys/kernel/pid_max'.

Anyway, I modified the patch as I commented above and pushed it.
(that will be more easiler with removing setup() function)


-- 
Regards,
Li Wang

--00000000000026da7605e7a8ef5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Sep 1, 2022 at 6:59 PM Avinesh Kumar &lt;<a=
 href=3D"mailto:akumar@suse.de">akumar@suse.de</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Hi Li,<br>
<br>
On Wednesday, August 31, 2022 12:10:44 PM IST Li Wang wrote:<br>
&gt; On Tue, Aug 30, 2022 at 6:54 PM Avinesh Kumar &lt;<a href=3D"mailto:ak=
umar@suse.de" target=3D"_blank">akumar@suse.de</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; Signed-off-by: Avinesh Kumar &lt;<a href=3D"mailto:akumar@suse.de=
" target=3D"_blank">akumar@suse.de</a>&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 testcases/kernel/syscalls/getsid/getsid02.c | 83 +++++-----=
-----------<br>
&gt; &gt;=C2=A0 1 file changed, 17 insertions(+), 66 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/testcases/kernel/syscalls/getsid/getsid02.c<br>
&gt; &gt; b/testcases/kernel/syscalls/getsid/getsid02.c<br>
&gt; &gt; index b5ab339e2..c235af362 100644<br>
&gt; &gt; --- a/testcases/kernel/syscalls/getsid/getsid02.c<br>
&gt; &gt; +++ b/testcases/kernel/syscalls/getsid/getsid02.c<br>
&gt; &gt; @@ -1,81 +1,32 @@<br>
&gt; &gt; +// SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; &gt;=C2=A0 /*<br>
&gt; &gt; - *<br>
&gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0Copyright (c) International Business Ma=
chines=C2=A0 Corp., 2001<br>
&gt; &gt;=C2=A0 =C2=A0*=C2=A0 =C2=A0Copyright (c) 2012 Cyril Hrubis &lt;<a =
href=3D"mailto:chrubis@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt;<b=
r>
&gt; &gt; - *<br>
&gt; &gt; - *=C2=A0 =C2=A0This program is free software;=C2=A0 you can redi=
stribute it and/or modify<br>
&gt; &gt; - *=C2=A0 =C2=A0it under the terms of the GNU General Public Lice=
nse as published by<br>
&gt; &gt; - *=C2=A0 =C2=A0the Free Software Foundation; either version 2 of=
 the License, or<br>
&gt; &gt; - *=C2=A0 =C2=A0(at your option) any later version.<br>
&gt; &gt; - *<br>
&gt; &gt; - *=C2=A0 =C2=A0This program is distributed in the hope that it w=
ill be useful,<br>
&gt; &gt; - *=C2=A0 =C2=A0but WITHOUT ANY WARRANTY;=C2=A0 without even the =
implied warranty of<br>
&gt; &gt; - *=C2=A0 =C2=A0MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE.=C2=A0 See<br>
&gt; &gt; - *=C2=A0 =C2=A0the GNU General Public License for more details.<=
br>
&gt; &gt; - *<br>
&gt; &gt; - *=C2=A0 =C2=A0You should have received a copy of the GNU Genera=
l Public License<br>
&gt; &gt; - *=C2=A0 =C2=A0along with this program;=C2=A0 if not, write to t=
he Free Software<br>
&gt; &gt; - *=C2=A0 =C2=A0Foundation, Inc., 51 Franklin Street, Fifth Floor=
, Boston, MA<br>
&gt; &gt; 02110-1301 USA<br>
&gt; &gt; + *=C2=A0 =C2=A0Copyright (c) 2022 SUSE LLC Avinesh Kumar &lt;<a =
href=3D"mailto:avinesh.kumar@suse.com" target=3D"_blank">avinesh.kumar@suse=
.com</a>&gt;<br>
&gt; &gt;=C2=A0 =C2=A0*/<br>
&gt; &gt;<br>
&gt; &gt; -#define _GNU_SOURCE 1<br>
&gt; &gt; -<br>
&gt; &gt; -#include &quot;test.h&quot;<br>
&gt; &gt; -<br>
&gt; &gt; -#include &lt;errno.h&gt;<br>
&gt; &gt; +/*\<br>
&gt; &gt; + * [Description]<br>
&gt; &gt; + *<br>
&gt; &gt; + * Verify that getsid(2) fails with ESRCH errno when there is no=
<br>
&gt; &gt; + * process found with process ID pid.<br>
&gt; &gt; + */<br>
&gt; &gt;<br>
&gt; &gt; -char *TCID =3D &quot;getsid02&quot;;<br>
&gt; &gt; -int TST_TOTAL =3D 1;<br>
&gt; &gt; +#include &quot;tst_test.h&quot;<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 static pid_t unused_pid;<br>
&gt; &gt;<br>
&gt; &gt; -static void cleanup(void);<br>
&gt; &gt; -static void setup(void);<br>
&gt; &gt; -<br>
&gt; &gt; -int main(int ac, char **av)<br>
&gt; &gt; +static void setup(void)<br>
&gt; &gt;=C2=A0 {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0int lc;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_parse_opts(ac, av, NULL, NULL);<b=
r>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0setup();<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0for (lc =3D 0; TEST_LOOPING(lc); lc++=
) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_count=
 =3D 0;<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TEST(gets=
id(unused_pid));<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (TEST_=
RETURN =3D=3D 0) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0tst_resm(TFAIL, &quot;call succeed when failure<br>
&gt; &gt; expected&quot;);<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0continue;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (T=
EST_ERRNO) {<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case ESRC=
H:<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0tst_resm(TPASS, &quot;expected failure - errno =3D %d -=
<br>
&gt; &gt; %s&quot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST_ERRNO, strerror(TEST_=
ERRNO));<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<=
br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0tst_resm(TFAIL, &quot;call failed to produce &quot;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;expected error - err=
no =3D %d - %s&quot;,<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TEST_ERRNO, strerror(TEST_=
ERRNO));<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt; -<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0cleanup();<br>
&gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_exit();<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unused_pid =3D tst_get_unused_pid();<=
br>
&gt; &gt;<br>
&gt; <br>
&gt; We can simply move this to the main function to avoid unused PID<br>
&gt; reusing again if people perform test with &#39;-i N&#39;.<br>
&gt; <br>
&gt; How about this below:<br>
&gt; <br>
&gt; #include &quot;tst_test.h&quot;<br>
&gt; <br>
&gt; static void run(void)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0pid_t unused_pid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0unused_pid =3D tst_get_unused_pid();<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0TST_EXP_FAIL(getsid(unused_pid), ESRCH);<br>
&gt; }<br>
&gt; <br>
&gt; static struct tst_test test =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0.test_all =3D run<br>
&gt; };<br>
&gt; <br>
&gt; <br>
Yes, I agree to your suggestion. But while testing &#39;-i N&#39; with this=
 code<br>
also I am getting the same unused_pid which is equal to <br>
/proc/sys/kernel/pid_max in my env.<br></blockquote><div><br></div><div cla=
ss=3D"gmail_default" style=3D"font-size:small">Ah, right. I additionally ch=
ecked the &quot;Linux Programming Interface Handbook&quot;,</div><div class=
=3D"gmail_default" style=3D"font-size:small">it says the maximum PID number=
 that can be used is &#39;pid_max - 1&#39;. So I realized</div><div class=
=3D"gmail_default" style=3D"font-size:small">that why the tst_unused_pid() =
just read the value of &#39;/proc/sys/kernel/pid_max&#39;.</div></div><div>=
<br></div><div><div class=3D"gmail_default" style=3D"font-size:small">Anywa=
y, I modified the patch as I commented above and pushed it.</div><div class=
=3D"gmail_default" style=3D"font-size:small">(that will be more easiler wit=
h removing setup() function)</div><br></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div>=
<div>Li Wang<br></div></div></div></div>

--00000000000026da7605e7a8ef5d--


--===============1414561315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1414561315==--

