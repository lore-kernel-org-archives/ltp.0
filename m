Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34926C433F5
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 22:39:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 432943C941B
	for <ltp@archiver.kernel.org>; Wed, 16 Mar 2022 23:39:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 227093C698B
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 23:39:05 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EFD87600967
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 23:39:04 +0100 (CET)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 83A1E3F1A1
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 22:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1647470343;
 bh=e3n7HjcRR3rKlr/cbXLYrZDNXlxoipQaaRgFGsbfFZE=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=qDQrLyWa9JoWkJ9q4GyfWn2BtYhUFD4O6SIJMlKDyAr9jVTA3PYROrZVUl9asi2Gn
 rm2yqIPw0TtDvep9lwIlaLx1HliwkvPEe4jp/11cmnjuiaiL1rV9+FPsceaXqj/FLm
 9k1m0YsNk3NRVykGGEYcWm/4JYVFdNsx/dphf4oHmBHIfARA6rZWBH/JnrIv/GGuvy
 ouEUp03wIGTqXIox27o1jnXHurqfJ/DNCk5C7susa52kDCYWXrFLP60I8Ss6qI6bfe
 ekXUw6nni4mOHxyu1XZmlIiM5x6layWYQD86nw2mu/Gmrapb8934gpAoPtNj7qJUQL
 Mi6NJp8TG7nXQ==
Received: by mail-ed1-f72.google.com with SMTP id
 b9-20020aa7d489000000b0041669cd2cbfso2054215edr.16
 for <ltp@lists.linux.it>; Wed, 16 Mar 2022 15:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e3n7HjcRR3rKlr/cbXLYrZDNXlxoipQaaRgFGsbfFZE=;
 b=NIPNgVqJdAQ/DCUM7uSouU4RN1Qr4KMGFCaMVrQaZuVm1Ce0wJvSfbPKs48k4Ch6YT
 FIo9Sf8BkZJCtnMt3oa4Y/ZjJGFQ2rRl91Yn9ogALXVTfiHc83J0gVvWyWgwXAIyJ0sg
 QbqkKPXxwjHxqoq/LKqypJPrFDgevIFhfHVvDNWnRqNFhCx4CpTIsBPsArjRgiCFHRgk
 DmOaIWS5LsxjZuYC2X3YFH7lHVoPbvfzduap17wPreTi8DK2cbZiZ3T6lz3jdhHFnnx6
 nAirLDXZGRR23ymyZd6ZplS34Nsj1xmPaty2S8sSa02JPkO7o69AIzf97nlvUZszp29q
 WO9g==
X-Gm-Message-State: AOAM530WP26e6ord/3Nue5G+JVPolkaRJVKzKFf1MBhyaVr4KP6tZYKS
 yi1rvghTj/r4DgSDMdvw+opend/kEvhuHBTuGv/yuUrlUqupapSD+g+RNplAtHM66Fw380BoSC7
 9loYT5N1EnXa4Hr78JRRna2MJco0XUen6e1qTW3gVKvCD
X-Received: by 2002:a50:c344:0:b0:418:e53f:f19b with SMTP id
 q4-20020a50c344000000b00418e53ff19bmr1596992edb.222.1647470342636; 
 Wed, 16 Mar 2022 15:39:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBRasjGAP4d4WZU7ft7FTGh0decjMg6J+jV58LL6iTIyrJg39F/bR5zWt5Exam+O7jiR7Pgdl7+HdYWAA9hk4=
X-Received: by 2002:a50:c344:0:b0:418:e53f:f19b with SMTP id
 q4-20020a50c344000000b00418e53ff19bmr1596980edb.222.1647470342352; Wed, 16
 Mar 2022 15:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <baec527891fe83e75958f9db3634f1a0a828bf07.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <871qzeniu7.fsf@suse.de>
In-Reply-To: <871qzeniu7.fsf@suse.de>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 16 Mar 2022 15:38:26 -0700
Message-ID: <CADS1e3ff7dnQe8zByitszNhKViiOLOF-UfNtSbMsFkkSX5Sy7Q@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 04/16] API/cgroup: Implement tst_cg_load_config
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
Content-Type: multipart/mixed; boundary="===============1979066108=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1979066108==
Content-Type: multipart/alternative; boundary="00000000000088e53d05da5d942d"

--00000000000088e53d05da5d942d
Content-Type: text/plain; charset="UTF-8"

Hi Richard,

On Mon, Mar 7, 2022 at 2:43 AM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello Luke,
>
> Really great work for the patch series in general! However see comments
> below.
>
> Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:
>
> > Implement tst_cg_load_config which consumes the state given by
> > tst_cg_print_config to update the internal test state to reflect
> > the given config.
> >
> > This allows for programs using the cgroup C API to load and reload
> > state, allowing functionality such as calling tst_cg_require and
> > tst_cg_cleanup to function properly between programs or between
> > invocations of a binary using the C API.
> >
> > Signed-off-by: Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com>
> > ---
> > v2: Add root null check in parse_root_config.
> >     Remove checking for ltp_drain_dir key from config as it was
> >     redundant.
> >     Remove unsued variable in parse_ctrl_config.
> >     Cleanup some compiler warnings.
> > v3: Rewrite to consume each line of the config with a scanf to make
> >     the parsing much simpler while using new config variables.
> >
> >  include/tst_cgroup.h |  7 +++++
> >  lib/tst_cgroup.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+)
> >
> > diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> > index 87e55f4df..9bad0d366 100644
> > --- a/include/tst_cgroup.h
> > +++ b/include/tst_cgroup.h
> > @@ -121,6 +121,13 @@ void tst_cg_scan(void);
> >   */
> >  void tst_cg_print_config(void);
> >
> > +/* Load the config printed out by tst_cg_print_config and configure the
> internal
> > + * libary state to match the config. Used to allow tst_cg_cleanup to
> properly
> > + * cleanup mounts and directories created by tst_cg_require between
> program
> > + * invocations.
> > + */
> > +void tst_cg_load_config(const char *const config);
> > +
> >  /* Ensure the specified controller is available in the test's default
> >   * CGroup, mounting/enabling it if necessary. Usually this is not
> >   * necesary use tst_test.needs_cgroup_controllers instead.
> > diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> > index 8f95064b3..90d91d94e 100644
> > --- a/lib/tst_cgroup.c
> > +++ b/lib/tst_cgroup.c
> > @@ -366,6 +366,68 @@ static struct cgroup_root *cgroup_find_root(const
> char *const mnt_path)
> >       return NULL;
> >  }
> >
> > +static void parse_config(const char *const config_entry)
>
> cgroup_parse_config_line perhaps? or cgroup_parse_ctrl?
>
> > +{
> > +     const char ctrl_name[32], mnt_path[PATH_MAX],
> > test_dir_name[NAME_MAX + 1];
>
> These buffers are not const.
>
> I have lsp and clangd setup in emacs which warns about this. It's easy
> to miss the warning in the compiler output.
>
> > +     int ver, we_require_it, we_mounted_it, ltp_dir_we_created_it;
> > +     struct cgroup_root *root;
> > +     struct cgroup_ctrl *ctrl;
> > +
> > +     sscanf(config_entry, CONFIG_FORMAT,
> > +             ctrl_name, &ver, &we_require_it, mnt_path, &we_mounted_it,
> > +             &ltp_dir_we_created_it, test_dir_name);
>
> You need to run 'make check-tst_cgroup' in ltp/lib. The sscanf return
> value is not checked which could result in segfaults and other confusing
> errors if parsing fails.
>
> > +
> > +     if (!(ctrl = cgroup_find_ctrl(ctrl_name)))
>
> check_patch.pl forbids assignments in if statements (it makes static
> analysis difficult). Again this is caught with 'make check'.
>
> > +             tst_brk(TBROK, "Could not find ctrl from config. Ctrls
> changing between calls?");
> > +
> > +     ctrl->we_require_it = we_require_it;
> > +
> > +     if (!(root = cgroup_find_root(mnt_path)))
> > +             tst_brk(TBROK, "Could not find root from config. Config
> possibly malformed?");
> > +
> > +     if (we_mounted_it)
> > +             root->we_mounted_it = 1;
> > +
> > +     if (!root->ltp_dir.dir_name) {
> > +             cgroup_dir_mk(&root->mnt_dir, cgroup_ltp_dir,
> &root->ltp_dir);
> > +             cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir,
> &root->drain_dir);
> > +             if (ltp_dir_we_created_it) {
> > +                     root->ltp_dir.we_created_it = 1;
> > +                     root->drain_dir.we_created_it = 1;
> > +             }
> > +     }
> > +
> > +     if (!root->test_dir.dir_name && strcmp(test_dir_name, "NULL")) {
> > +             strncpy(cgroup_test_dir, test_dir_name, NAME_MAX);
>
> I think this could result in an unterminated string. strncpy does not
> add a null char after the string that was copied. Note also that the
> format string passed to sscanf does not limit the field width so it
> could overwrite root and ctrl on the stack if the input is long enough.
>
>
Thank you for pointing all these things out. I forgot about all the
shenanigans that can happen when you don't sanity check string stuff :)

A few solutions to creating the scanff format are:
1) pre-processor trick to concatenate defines into a string, something like
this
#define _tostr(str) #str
#define tostr(str) _tostr(str)
#define CONFIG_FORMAT "%" tostr(CTRL_NAME_MAX) "s\t%d\t%d\t%"
tostr(PATH_MAX) "s\t%d\t%d\t%" tostr(NAME_MAX) "s"

2) just hardcode the lengths to avoid all of this nonsense above

3) just create the format at runtime

I'm more or less asking what you think is best to avoid sending out all of
the patches and then discussing this / if there is a better way.



> > +             cgroup_dir_mk(&root->ltp_dir, cgroup_test_dir,
> &root->test_dir);
> > +             root->test_dir.we_created_it = 1;
> > +     }
> > +}
> > +
> > +/* Load the test state config provided by tst_cg_print_config
> > + *
> > + * This will reload some internal tst_cgroup state given by the config
> > + * that might otherwise have been lost between calls or between
> different
> > + * processes. In particular this is used by testcases/lib/tst_cgctl to
> > + * provide access to this C api to shell scripts.
> > + *
> > + * The config keeps track of the minimal state needed for tst_cg_cleanup
> > + * to cleanup mounts and directories created by tst_cg_require.
> > + */
> > +void tst_cg_load_config(const char *const config)
> > +{
> > +     char temp_config[BUFSIZ];
> > +     char *line;
> > +
> > +     if (strlen(config) >= BUFSIZ)
> > +             tst_brk(TBROK, "Config has exceeded buffer size?");
> > +     strncpy(temp_config, config, BUFSIZ);
>
> Again, this won't copy the null byte from config if strlen(config) ==
> BUFSIZ. You could use memcpy here anyway if you know the string length.
>
> > +
> > +     line = strtok(temp_config, "\n");
> > +     /* Make sure to consume the header. */
> > +     for (line = strtok(NULL, "\n"); line; line = strtok(NULL, "\n"))
> > +             parse_config(line);
> > +}
> >
> >  /* Determine if a mounted cgroup hierarchy is unique and record it if
> so.
> >   *
>
>
I will take all of the other things you mentioned and clean them up. Thanks
for the review!


>
> --
> Thank you,
> Richard.
>

Thanks,
- Luke

--00000000000088e53d05da5d942d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Richard, <br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 7, 2022 at 2:43 AM Richar=
d Palethorpe &lt;<a href=3D"mailto:rpalethorpe@suse.de">rpalethorpe@suse.de=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Hello Luke,<br>
<br>
Really great work for the patch series in general! However see comments<br>
below.<br>
<br>
Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowakowskikrijger@canoni=
cal.com" target=3D"_blank">luke.nowakowskikrijger@canonical.com</a>&gt; wri=
tes:<br>
<br>
&gt; Implement tst_cg_load_config which consumes the state given by<br>
&gt; tst_cg_print_config to update the internal test state to reflect<br>
&gt; the given config.<br>
&gt;<br>
&gt; This allows for programs using the cgroup C API to load and reload<br>
&gt; state, allowing functionality such as calling tst_cg_require and<br>
&gt; tst_cg_cleanup to function properly between programs or between<br>
&gt; invocations of a binary using the C API.<br>
&gt;<br>
&gt; Signed-off-by: Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowa=
kowskikrijger@canonical.com" target=3D"_blank">luke.nowakowskikrijger@canon=
ical.com</a>&gt;<br>
&gt; ---<br>
&gt; v2: Add root null check in parse_root_config.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Remove checking for ltp_drain_dir key from config a=
s it was<br>
&gt;=C2=A0 =C2=A0 =C2=A0redundant.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Remove unsued variable in parse_ctrl_config.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Cleanup some compiler warnings.<br>
&gt; v3: Rewrite to consume each line of the config with a scanf to make<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0the parsing much simpler while using new config var=
iables.<br>
&gt;<br>
&gt;=C2=A0 include/tst_cgroup.h |=C2=A0 7 +++++<br>
&gt;=C2=A0 lib/tst_cgroup.c=C2=A0 =C2=A0 =C2=A0| 62 +++++++++++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 69 insertions(+)<br>
&gt;<br>
&gt; diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h<br>
&gt; index 87e55f4df..9bad0d366 100644<br>
&gt; --- a/include/tst_cgroup.h<br>
&gt; +++ b/include/tst_cgroup.h<br>
&gt; @@ -121,6 +121,13 @@ void tst_cg_scan(void);<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 void tst_cg_print_config(void);<br>
&gt;=C2=A0 <br>
&gt; +/* Load the config printed out by tst_cg_print_config and configure t=
he internal<br>
&gt; + * libary state to match the config. Used to allow tst_cg_cleanup to =
properly<br>
&gt; + * cleanup mounts and directories created by tst_cg_require between p=
rogram<br>
&gt; + * invocations.<br>
&gt; + */<br>
&gt; +void tst_cg_load_config(const char *const config);<br>
&gt; +<br>
&gt;=C2=A0 /* Ensure the specified controller is available in the test&#39;=
s default<br>
&gt;=C2=A0 =C2=A0* CGroup, mounting/enabling it if necessary. Usually this =
is not<br>
&gt;=C2=A0 =C2=A0* necesary use tst_test.needs_cgroup_controllers instead.<=
br>
&gt; diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c<br>
&gt; index 8f95064b3..90d91d94e 100644<br>
&gt; --- a/lib/tst_cgroup.c<br>
&gt; +++ b/lib/tst_cgroup.c<br>
&gt; @@ -366,6 +366,68 @@ static struct cgroup_root *cgroup_find_root(const=
 char *const mnt_path)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +static void parse_config(const char *const config_entry)<br>
<br>
cgroup_parse_config_line perhaps? or cgroup_parse_ctrl?<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const char ctrl_name[32], mnt_path[PATH_MAX],<br>
&gt; test_dir_name[NAME_MAX + 1];<br>
<br>
These buffers are not const.<br>
<br>
I have lsp and clangd setup in emacs which warns about this. It&#39;s easy<=
br>
to miss the warning in the compiler output.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int ver, we_require_it, we_mounted_it, ltp_dir_we=
_created_it;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cgroup_root *root;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct cgroup_ctrl *ctrl;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0sscanf(config_entry, CONFIG_FORMAT,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ctrl_name, &amp;ver, =
&amp;we_require_it, mnt_path, &amp;we_mounted_it,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ltp_dir_we_creat=
ed_it, test_dir_name);<br>
<br>
You need to run &#39;make check-tst_cgroup&#39; in ltp/lib. The sscanf retu=
rn<br>
value is not checked which could result in segfaults and other confusing<br=
>
errors if parsing fails.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!(ctrl =3D cgroup_find_ctrl(ctrl_name)))<br>
<br>
<a href=3D"http://check_patch.pl" rel=3D"noreferrer" target=3D"_blank">chec=
k_patch.pl</a> forbids assignments in if statements (it makes static<br>
analysis difficult). Again this is caught with &#39;make check&#39;.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK, &quot;=
Could not find ctrl from config. Ctrls changing between calls?&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ctrl-&gt;we_require_it =3D we_require_it;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!(root =3D cgroup_find_root(mnt_path)))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK, &quot;=
Could not find root from config. Config possibly malformed?&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (we_mounted_it)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0root-&gt;we_mounted_i=
t =3D 1;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!root-&gt;ltp_dir.dir_name) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cgroup_dir_mk(&amp;ro=
ot-&gt;mnt_dir, cgroup_ltp_dir, &amp;root-&gt;ltp_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cgroup_dir_mk(&amp;ro=
ot-&gt;ltp_dir, cgroup_ltp_drain_dir, &amp;root-&gt;drain_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ltp_dir_we_create=
d_it) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0root-&gt;ltp_dir.we_created_it =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0root-&gt;drain_dir.we_created_it =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!root-&gt;test_dir.dir_name &amp;&amp; strcmp=
(test_dir_name, &quot;NULL&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strncpy(cgroup_test_d=
ir, test_dir_name, NAME_MAX);<br>
<br>
I think this could result in an unterminated string. strncpy does not<br>
add a null char after the string that was copied. Note also that the<br>
format string passed to sscanf does not limit the field width so it<br>
could overwrite root and ctrl on the stack if the input is long enough.<br>
<br></blockquote><div><br></div><div>Thank you for pointing all these thing=
s out. I forgot about all the shenanigans that can happen when you don&#39;=
t sanity check string stuff :)</div><div><br></div><div>A few solutions to =
creating the scanff format are:</div><div>1) pre-processor trick to concate=
nate defines into a string, something like this</div><div>#define _tostr(st=
r) #str<br>#define tostr(str) _tostr(str)<br>#define CONFIG_FORMAT &quot;%&=
quot; tostr(CTRL_NAME_MAX) &quot;s\t%d\t%d\t%&quot; tostr(PATH_MAX) &quot;s=
\t%d\t%d\t%&quot; tostr(NAME_MAX) &quot;s&quot;</div><div><br></div><div>2)=
 just hardcode the lengths to avoid all of this nonsense above</div><div><b=
r></div><div>3) just create the format at runtime</div><div><br></div><div>=
I&#39;m more or less asking what you think is best to avoid sending out all=
 of the patches and then discussing this / if there is a better way. <br></=
div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cgroup_dir_mk(&amp;ro=
ot-&gt;ltp_dir, cgroup_test_dir, &amp;root-&gt;test_dir);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0root-&gt;test_dir.we_=
created_it =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Load the test state config provided by tst_cg_print_config<br>
&gt; + *<br>
&gt; + * This will reload some internal tst_cgroup state given by the confi=
g<br>
&gt; + * that might otherwise have been lost between calls or between diffe=
rent<br>
&gt; + * processes. In particular this is used by testcases/lib/tst_cgctl t=
o<br>
&gt; + * provide access to this C api to shell scripts.<br>
&gt; + *<br>
&gt; + * The config keeps track of the minimal state needed for tst_cg_clea=
nup<br>
&gt; + * to cleanup mounts and directories created by tst_cg_require.<br>
&gt; + */<br>
&gt; +void tst_cg_load_config(const char *const config)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char temp_config[BUFSIZ];<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *line;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (strlen(config) &gt;=3D BUFSIZ)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK, &quot;=
Config has exceeded buffer size?&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0strncpy(temp_config, config, BUFSIZ);<br>
<br>
Again, this won&#39;t copy the null byte from config if strlen(config) =3D=
=3D<br>
BUFSIZ. You could use memcpy here anyway if you know the string length.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0line =3D strtok(temp_config, &quot;\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Make sure to consume the header. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (line =3D strtok(NULL, &quot;\n&quot;); line;=
 line =3D strtok(NULL, &quot;\n&quot;))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0parse_config(line);<b=
r>
&gt; +}<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 /* Determine if a mounted cgroup hierarchy is unique and record =
it if so.<br>
&gt;=C2=A0 =C2=A0*<br>
<br></blockquote><div><br></div><div>I will take all of the other things yo=
u mentioned and clean them up. Thanks for the review!<br></div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
Thank you,<br>
Richard.<br></blockquote><div><br></div><div>Thanks, <br></div><div>- Luke =
<br></div></div></div>

--00000000000088e53d05da5d942d--

--===============1979066108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1979066108==--
