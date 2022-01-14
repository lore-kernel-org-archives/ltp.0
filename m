Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0E1C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 09:33:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5784D3C9569
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 10:33:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B28C13C862B
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 10:33:29 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 467501401180
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 10:33:28 +0100 (CET)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C68FB3F17B
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 09:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1642152800;
 bh=AP4dQk+pPMP63BqxMXy3AZgq5wxtqISuDnX9edFWcaE=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=K/8cUbIeKe3uK7ovDeMPDlbbalA+RfzjzFNI3ppx917nI27QaQzZU88xWpRiahurX
 ABZOKuC5dzAyTLz3vek1mssji+E+7dypXsXlsctJf5fg3mkw9dEamhHbkMt58HflCL
 FvLhR+rlUxS9md0ZxlhWZxKIpw08E5RPDUEMIrTPswpvzCCi/hR0S64W6RBhwyr8bB
 GCWoKX5uPviViw3toanUxVwm37rjmyOY8dVZ1ka6IboFGND1nFrXoXmbT4frx4BFrI
 i+0G3Nh9JExaUbgvJ8fJ/zPuZbJ+vZGFER+KKUr4WgwTTfF465XSLJvBh47xxTnCJR
 3RPWKN/0rZXLw==
Received: by mail-ed1-f72.google.com with SMTP id
 r8-20020a05640251c800b003f9a52daa3fso7840430edd.22
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 01:33:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AP4dQk+pPMP63BqxMXy3AZgq5wxtqISuDnX9edFWcaE=;
 b=EJcQ60+OXIY91LwWaBNA2zZdwQYlVPLJJexHsy3UvkcrYb/HtPJm4IW5eiljFPxDrP
 S/fQ7tKRhIx+ZFFB2Ih2WjaAP5TCa1ap8nqg3y7Pnk97q2mCnMf4HGQuYBuLCidm1q4S
 2StxlNHt2qvMi5vB73Bj/Xule3EfCedO1N2I6a/bTHj+2v3ywia+X3rs0R5zLJL2i4Em
 SkDpVTfHWX717PMfQRTWN5y4fm6xOWy3qd3uGdRzmvZkeokna0+CYrX8EMvZickzdXP1
 mXyQAhmlv+OjJxl++6kCQKA/Fn4v5v8I8TygEv7PzqZ/2Nu6Vn5YGYOzyoLjWPpZFvd4
 p30g==
X-Gm-Message-State: AOAM5323ym0dWxQj2mijQc/uGkeNwJ1bYuY64QWophpvrfwYFtKQ9Kxy
 dJ1oagICJXuD9/088TUL5ssrRcej708i2TtIo+YLsBbMLagrXVbgWqNruYgykUc46fLyxd8sRQR
 9eCd2xJUQ43CjUSpyV8CXL0F+PHD5Nk/bDn7O0sH/cJFR
X-Received: by 2002:a17:907:e8c:: with SMTP id
 ho12mr7113038ejc.722.1642152800548; 
 Fri, 14 Jan 2022 01:33:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOG4ZkwNWoCQsrCG83ysa/Vs3KqxzitnQnox007UAx+ARLZociIwM0wNMw8aEUkvfizoo5O7m21rmh6uvCFvY=
X-Received: by 2002:a17:907:e8c:: with SMTP id
 ho12mr7113028ejc.722.1642152800316; 
 Fri, 14 Jan 2022 01:33:20 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <39c482de2c75e393fa53c31d06620995dabc5284.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2dhHo7nPWG7EKsRa055et6eAWGpD_8uLP3VG89nhNNuJw@mail.gmail.com>
In-Reply-To: <CAEemH2dhHo7nPWG7EKsRa055et6eAWGpD_8uLP3VG89nhNNuJw@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Fri, 14 Jan 2022 01:32:44 -0800
Message-ID: <CADS1e3chR0NtsYT6-6qePZkqDReJ3Cvs6u2DPym6nan7htHvzg@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/6] API/cgroup: Implement tst_cgroup_load_config()
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
Content-Type: multipart/mixed; boundary="===============0433005839=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0433005839==
Content-Type: multipart/alternative; boundary="00000000000054874e05d5877e59"

--00000000000054874e05d5877e59
Content-Type: text/plain; charset="UTF-8"

Hi Li,

On Thu, Jan 13, 2022 at 10:57 PM Li Wang <liwang@redhat.com> wrote:

>  Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:
>
> > +static int parse_root_config(char *config_entry)
> > +{
> > +       char *key;
> > +       char *value;
> > +       struct cgroup_root *root;
> > +
> > +       for (key = strtok(config_entry, " "); key; key = strtok(NULL, "
> ")) {
> > +               if (!(value = strchr(key, '='))) {
> > +                       if (!(root = cgroup_find_root(key)))
> > +                               tst_brk(TBROK, "Could not find root from
> config. Roots changing between calls?");
> > +
> > +                       continue;
> > +               }
> > +
> > +               *value = '\0';
> > +               value = value + 1;
> > +
> > +               if (!strcmp(key, CONFIG_MOUNTROOT_KEY) && !strcmp(value,
> "yes")) {
> > +                       root->we_mounted_it = 1;
> > +
>
> > +               } else if (!strcmp(key, CONFIG_LTPDIR_KEY) &&
> !root->ltp_dir.dir_name) {
> > +                       cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir,
> &root->ltp_dir);
> > +                       if (!strcmp(value, "yes"))
> > +                               root->ltp_dir.we_created_it = 1;
> > +
> > +               } else if (!strcmp(key, CONFIG_DRAINDIR_KEY) &&
> !root->drain_dir.dir_name) {
> > +                       cgroup_dir_mk(&root->ltp_dir,
> cgroup_ltp_drain_dir, &root->drain_dir);
> > +                       if (!strcmp(value, "yes"))
> > +                               root->ltp_dir.we_created_it = 1;
>
> I think that parsing the  CONFIG_DRAINDIR_KEY from '$_cgroup_state'
> is superfluous. Because from the tst_cgroup_cleanup, if
> root->ltp_dir.we_created_it
> is 1 then both of the two directories will be removed, so just using
> CONFIG_LTPDIR_KE
> to track the status is enough.
>
>
This is definitely true and I think it makes it a lot simpler. I will add
this in the next version.

And maybe it is not necessary to print "Created_Drain_Dir=xx" in
> tst_cgroup_print_config at all.
>
> Then, the code snippet could be as:
>
>                 } else if (!strcmp(key, CONFIG_LTPDIR_KEY) &&
> !root->ltp_dir.dir_name) {
>                         cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir,
> &root->ltp_dir);
>                         cgroup_dir_mk(&root->ltp_dir,
> cgroup_ltp_drain_dir, &root->drain_dir);
>                         if (!strcmp(value, "yes"))
>                                 root->ltp_dir.we_created_it = 1;
>
>
> > +
> > +               } else if (!strcmp(key, CONFIG_TESTID_KEY) &&
> strcmp(value, "NULL") &&
> > +                                  !root->test_dir.dir_name) {
> > +                       cgroup_dir_mk(&root->ltp_dir, value,
> &root->test_dir);
> > +                       root->test_dir.we_created_it = 1;
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
>
>
>
>
I'll be posting the changes along with all the modified tests probably
later today or early next week, and I will definitely need help reviewing
that :)


>
> --
> Regards,
> Li Wang
>
>
Thanks as always,
- Luke

--00000000000054874e05d5877e59
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Li, <br></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Thu, Jan 13, 2022 at 10:57 PM Li Wang &=
lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt; wrote:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0Luke Nowakow=
ski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" tar=
get=3D"_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br>
<br>
&gt; +static int parse_root_config(char *config_entry)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *key;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0char *value;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cgroup_root *root;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (key =3D strtok(config_entry, &quot; &=
quot;); key; key =3D strtok(NULL, &quot; &quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(value =
=3D strchr(key, &#39;=3D&#39;))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!(root =3D cgroup_find_root(key)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK, &quot;Could not fi=
nd root from config. Roots changing between calls?&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*value =3D &#3=
9;\0&#39;;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D valu=
e + 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(ke=
y, CONFIG_MOUNTROOT_KEY) &amp;&amp; !strcmp(value, &quot;yes&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0root-&gt;we_mounted_it =3D 1;<br>
&gt; +<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!st=
rcmp(key, CONFIG_LTPDIR_KEY) &amp;&amp; !root-&gt;ltp_dir.dir_name) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0cgroup_dir_mk(&amp;root-&gt;mnt_dir, cgroup_ltp_dir, &amp;roo=
t-&gt;ltp_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!strcmp(value, &quot;yes&quot;))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0root-&gt;ltp_dir.we_created_it =
=3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!st=
rcmp(key, CONFIG_DRAINDIR_KEY) &amp;&amp; !root-&gt;drain_dir.dir_name) {<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0cgroup_dir_mk(&amp;root-&gt;ltp_dir, cgroup_ltp_drain_dir, &a=
mp;root-&gt;drain_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (!strcmp(value, &quot;yes&quot;))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0root-&gt;ltp_dir.we_created_it =
=3D 1;<br>
<br>
I think that parsing the=C2=A0 CONFIG_DRAINDIR_KEY from &#39;$_cgroup_state=
&#39;<br>
is superfluous. Because from the tst_cgroup_cleanup, if<br>
root-&gt;ltp_dir.we_created_it<br>
is 1 then both of the two directories will be removed, so just using<br>
CONFIG_LTPDIR_KE<br>
to track the status is enough.<br>
<br></blockquote><div><br></div><div>This is definitely true and I think it=
 makes it a lot simpler. I will add this in the next version.=C2=A0 <br></d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
And maybe it is not necessary to print &quot;Created_Drain_Dir=3Dxx&quot; i=
n<br>
tst_cgroup_print_config at all.<br>
<br>
Then, the code snippet could be as:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (!strcmp(=
key, CONFIG_LTPDIR_KEY) &amp;&amp;<br>
!root-&gt;ltp_dir.dir_name) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cgroup_dir_mk(&amp;root-&gt;mnt_dir, cgroup_ltp_dir,<br>
&amp;root-&gt;ltp_dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 cgroup_dir_mk(&amp;root-&gt;ltp_dir,<br>
cgroup_ltp_drain_dir, &amp;root-&gt;drain_dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!strcmp(value, &quot;yes&quot;))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 root-&gt;ltp_dir.we_created_it =3D 1=
;<br>
<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!st=
rcmp(key, CONFIG_TESTID_KEY) &amp;&amp; strcmp(value, &quot;NULL&quot;) &am=
p;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !root-&gt;test_dir.dir_na=
me) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0cgroup_dir_mk(&amp;root-&gt;ltp_dir, value, &amp;root-&gt;tes=
t_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0root-&gt;test_dir.we_created_it =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
<br>
<br>
<br></blockquote><div>=C2=A0</div><div>I&#39;ll be posting the changes alon=
g with all the modified tests probably later today or early next week, and =
I will definitely need help reviewing that :) <br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
--<br>
Regards,<br>
Li Wang<br>
<br></blockquote><div><br></div><div>Thanks as always,<br></div><div>- Luke=
<br></div></div></div>

--00000000000054874e05d5877e59--

--===============0433005839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0433005839==--
