Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A415C433FE
	for <ltp@archiver.kernel.org>; Sun,  6 Nov 2022 06:25:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE8EE3CDB18
	for <ltp@archiver.kernel.org>; Sun,  6 Nov 2022 07:25:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2ABE3CA327
 for <ltp@lists.linux.it>; Sun,  6 Nov 2022 07:24:59 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2ECA600046
 for <ltp@lists.linux.it>; Sun,  6 Nov 2022 07:24:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667715895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V+d9saNQHRK3e199S/DOUXStt3kGDaxUVbh8yqUc9B0=;
 b=Psr0WmE4Z0mcb0UrewKoPxdjXu5bibMpZHhHzcB1tglS0JYN/OVcjZAeJo7ganvVxxMMO/
 OIMYLzWfwggrueTsnC3XoWLgYqFGk7+MCL+78mT3bdB0+O59Q8NzJSVhPQ7Bl64YbFgu3d
 ePEklc/n36LMmXBqD82NppiglY6cKW8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-499-RGfNsMOLMyijHFBLdWq0yQ-1; Sun, 06 Nov 2022 01:24:50 -0500
X-MC-Unique: RGfNsMOLMyijHFBLdWq0yQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 l31-20020a9d1b22000000b0066c48e9249fso3938252otl.5
 for <ltp@lists.linux.it>; Sat, 05 Nov 2022 23:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V+d9saNQHRK3e199S/DOUXStt3kGDaxUVbh8yqUc9B0=;
 b=7kjuFQ0W9BrHPzRkqSW+1SiJJEg1uPvwDIVZapEcZRXtMVfBvKNUEUxsBE1YGlwZXV
 xFKShJTy7RGflGfaRIuhOyCFGWvfmpwWbs7CTfhqTxr51BHg4nIibYlDN4QB5BlQNGAo
 Km2eiufkb1dcSPhIPcdL9+EWeppIwpXEwqcyRr2imGOqZtlMDcDsP2FDOXYKEqqEM9e4
 PyC3ExgJcDBj0ydJnyKoW0ugj/xy98wBLx9gJyGF5eeikYHqTOQN09ORlP6irbtvXMdl
 zbi+Q4F+WCUCYW0lxhGkJK0/PwzvpKc9gNONMB0YJn+1DkfhktFvtSNZi3a9SwckAN6X
 CUyw==
X-Gm-Message-State: ACrzQf1n4Hez5piS0WuEeYRFQaIpDJE5O8+jBpzOR8qF1vM5HGTByEGx
 Aem2qjGYrzkCyAhkhOMRSdnMz2eEqGx2xEoka6EXojoneR0OWQFGWgAt/zR8So84VOW5B8A0Kc1
 gZR7qrXsIxDQBnjlPAiC/q4GofOc=
X-Received: by 2002:a9d:6b99:0:b0:66c:6851:b961 with SMTP id
 b25-20020a9d6b99000000b0066c6851b961mr14434037otq.160.1667715889972; 
 Sat, 05 Nov 2022 23:24:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5FlLh8ajFhOVtuGPouCH6lWcTd/+FfmHONBiTJCfP+ae2OZBqRHMJ144I32FPRq9mkI85J4odl6fEv1jxND7E=
X-Received: by 2002:a9d:6b99:0:b0:66c:6851:b961 with SMTP id
 b25-20020a9d6b99000000b0066c6851b961mr14434026otq.160.1667715889565; Sat, 05
 Nov 2022 23:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20221103164550.7037-1-mdoucha@suse.cz>
In-Reply-To: <20221103164550.7037-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sun, 6 Nov 2022 14:24:35 +0800
Message-ID: <CAEemH2di5wCY-M+EUGdovSRWU2zvminpuVpBBP_FiU3U8KDw0w@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] save_restore: Introduce new struct field for flags
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
Content-Type: multipart/mixed; boundary="===============0689357936=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0689357936==
Content-Type: multipart/alternative; boundary="0000000000002f307205ecc75dd6"

--0000000000002f307205ecc75dd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 4, 2022 at 8:07 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Tests using the .save_restore functionality currently cannot run
> without root privileges at all because the test will write
> into the path at least at the end and trigger error, even when
> the config paths are flagged as optional.
>
> Introduce new tst_path_val field for flags and replace path prefix flags
> with bit flags. Also introduce new flags to control handling of read/writ=
e
> errors and read-only sysfiles and rewrite save_restore implementation
> accordingly.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>
> This is technically a v2 for
>
> https://patchwork.ozlabs.org/project/ltp/patch/20221021155740.8339-1-mdou=
cha@suse.cz/
>
> I'll send a follow-up patchset to replace setup() code which requires roo=
t
> privileges without good reason after this patch gets merged. Here I've ke=
pt
> test changes to the minimum needed to maintain current save_restore
> behavior
> with the new flags system. The only change in behavior is the use of
> read-only
> handling flags where it's clear that the change is desired.
>
> Though a few tests should get closer attention during review:
> - all KSM tests
> - add_key05
> - migrate_pages02
>
>  doc/c-test-api.txt                            | 38 ++++----
>  include/tst_sys_conf.h                        | 15 ++-
>  lib/tst_sys_conf.c                            | 97 ++++++++++++-------
>  lib/tst_test.c                                |  3 +-
>  testcases/cve/icmp_rate_limit01.c             |  2 +-
>  testcases/kernel/containers/userns/userns08.c |  2 +-
>  testcases/kernel/kvm/kvm_pagefault01.c        |  3 +-
>  testcases/kernel/mem/ksm/ksm01.c              | 10 +-
>  testcases/kernel/mem/ksm/ksm02.c              | 10 +-
>  testcases/kernel/mem/ksm/ksm03.c              | 10 +-
>  testcases/kernel/mem/ksm/ksm04.c              | 10 +-
>  testcases/kernel/mem/ksm/ksm05.c              |  2 +-
>  testcases/kernel/mem/ksm/ksm06.c              |  9 +-
>  testcases/kernel/syscalls/add_key/add_key05.c |  7 +-
>  testcases/kernel/syscalls/bind/bind06.c       |  2 +-
>  testcases/kernel/syscalls/fork/fork13.c       |  2 +-
>  .../kernel/syscalls/ipc/msgget/msgget03.c     |  2 +-
>  testcases/kernel/syscalls/madvise/madvise06.c |  2 +-
>  testcases/kernel/syscalls/madvise/madvise08.c |  2 +-
>  .../syscalls/migrate_pages/migrate_pages02.c  |  2 +-
>  testcases/kernel/syscalls/sendto/sendto03.c   |  2 +-
>  .../kernel/syscalls/setsockopt/setsockopt05.c |  2 +-
>  .../kernel/syscalls/setsockopt/setsockopt06.c |  2 +-
>  .../kernel/syscalls/setsockopt/setsockopt07.c |  2 +-
>  .../kernel/syscalls/setsockopt/setsockopt08.c |  2 +-
>  .../kernel/syscalls/setsockopt/setsockopt09.c |  2 +-
>  testcases/kernel/syscalls/syslog/syslog11.c   |  2 +-
>  27 files changed, 142 insertions(+), 102 deletions(-)
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index e4c66b492..dbca6266b 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1602,35 +1602,33 @@ LTP library can be instructed to save and restore
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
> +* 'TST_SR_IGNORE_MISSING' =E2=80=93 Continue without saving the file if =
it does
> not exist
> +* 'TST_SR_FAIL_RO' =E2=80=93 End test with 'TBROK' if the file is read-o=
nly
> +* 'TST_SR_IGNORE_RO' =E2=80=93 Continue without saving the file if it is=
 read-only
> +* 'TST_SR_IGNORE_ERR' =E2=80=93 Ignore errors when writing new value int=
o the file
> +* 'TST_SR_REQUIRED' =E2=80=93 Equivalent to 'TST_SR_FAIL_MISSING | TST_S=
R_FAIL_RO'
> +* 'TST_SR_IF_ACCESS' =E2=80=93 Equivalent to 'TST_SR_IGNORE_MISSING |
> TST_SR_IGNORE_RO'
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
> +               {"/sys/kernel/mm/ksm/run", "1", TST_SR_REQUIRED},
>                 {}
>         },
>  };
> diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
> index b7bbe36fc..a87f4e1cd 100644
> --- a/include/tst_sys_conf.h
> +++ b/include/tst_sys_conf.h
> @@ -5,14 +5,23 @@
>  #ifndef TST_SYS_CONF_H__
>  #define TST_SYS_CONF_H__
>
> +#define TST_SR_FAIL_MISSING 0x1
> +#define TST_SR_IGNORE_MISSING 0x2
> +#define TST_SR_FAIL_RO 0x4
> +#define TST_SR_IGNORE_RO 0x8
> +#define TST_SR_IGNORE_ERR 0x10
>

This is a good thought to split the permission and respectively
handle them, but I feel that these names are a bit ambiguous.

For example TST_SR_IGNORE_RO, I was puzzled a while when
reading it in the below code, it can be thought of as ignoring the
READ_ONLY permission if just from the literal meaning.

We need to find more precise names.



> +
> +#define TST_SR_REQUIRED (TST_SR_FAIL_MISSING | TST_SR_FAIL_RO)
> +#define TST_SR_IF_ACCESS (TST_SR_IGNORE_MISSING | TST_SR_IGNORE_RO)
>

Here as well, especially these two will be more frequently used in testcase
writing.


> +
>  struct tst_path_val {
>          const char *path;
>          const char *val;
> +       unsigned int flags;
>  };
>
> -int tst_sys_conf_save_str(const char *path, const char *value);
> -int tst_sys_conf_save(const char *path);
>


> -void tst_sys_conf_set(const char *path, const char *value);
>

I made it an external function for wide use by users, but seems
that's a bit redundant, we have SAFE_FILE_PRINTF instead,
so here I'm OK with removing it.


+void tst_sys_conf_save_str(const char *path, const char *value);
>

Do we have any other place to use tst_sys_conf_save_str?
If no, I would suggest declaring it only as a static function
in the tst_sys_conf.c

Anyway,  the basic method of this patch is what I liked, and
the rest part (+ fixed with Jan's comments) looks good.




> +int tst_sys_conf_save(const struct tst_path_val *conf);
>  void tst_sys_conf_restore(int verbose);
>  void tst_sys_conf_dump(void);
>
> diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
> index 003698825..3bf5c25fb 100644
> --- a/lib/tst_sys_conf.c
> +++ b/lib/tst_sys_conf.c
> @@ -20,6 +20,14 @@ struct tst_sys_conf {
>
>  static struct tst_sys_conf *save_restore_data;
>
> +static void print_error(int info_only, const char *err, const char *path=
)
> +{
> +       if (info_only)
> +               tst_res(TINFO, err, path);
> +       else
> +               tst_brk(TBROK | TERRNO, err, path);
> +}
> +
>  void tst_sys_conf_dump(void)
>  {
>         struct tst_sys_conf *i;
> @@ -28,7 +36,7 @@ void tst_sys_conf_dump(void)
>                 tst_res(TINFO, "%s =3D %s", i->path, i->value);
>  }
>
> -int tst_sys_conf_save_str(const char *path, const char *value)
> +void tst_sys_conf_save_str(const char *path, const char *value)
>  {
>         struct tst_sys_conf *n =3D SAFE_MALLOC(sizeof(*n));
>
> @@ -40,45 +48,43 @@ int tst_sys_conf_save_str(const char *path, const cha=
r
> *value)
>
>         n->next =3D save_restore_data;
>         save_restore_data =3D n;
> -
> -       return 0;
>  }
>
> -int tst_sys_conf_save(const char *path)
> +int tst_sys_conf_save(const struct tst_path_val *conf)
>  {
>         char line[PATH_MAX];
> +       int ttype, iret;
>         FILE *fp;
>         void *ret;
> -       char flag;
>
> -       if (!path)
> +       if (!conf || !conf->path)
>                 tst_brk(TBROK, "path is empty");
>
> -       flag =3D path[0];
> -       if (flag  =3D=3D '?' || flag =3D=3D '!')
> -               path++;
> -
> -       if (access(path, F_OK) !=3D 0) {
> -               switch (flag) {
> -               case '?':
> -                       tst_res(TINFO, "Path not found: '%s'", path);
> -                       break;
> -               case '!':
> -                       tst_brk(TBROK|TERRNO, "Path not found: '%s'",
> path);
> -                       break;
> -               default:
> -                       tst_brk(TCONF|TERRNO, "Path not found: '%s'",
> path);
> +       if (access(conf->path, F_OK) !=3D 0) {
> +               if (conf->flags & TST_SR_IGNORE_MISSING) {
> +                       tst_res(TINFO, "Path not found: %s", conf->path);
> +                       return 1;
>                 }
> -               return 1;
> +
> +               ttype =3D (conf->flags & TST_SR_FAIL_MISSING) ? TBROK :
> TCONF;
> +               tst_brk(ttype | TERRNO, "Path not found: %s", conf->path)=
;
>         }
>
> -       fp =3D fopen(path, "r");
> -       if (fp =3D=3D NULL) {
> -               if (flag =3D=3D '?')
> +       if (access(conf->path, W_OK) !=3D 0) {
> +               if (conf->flags & TST_SR_IGNORE_RO) {
> +                       tst_res(TINFO, "Path is not writable: %s",
> conf->path);
>                         return 1;
> +               }
>
> -               tst_brk(TBROK | TERRNO, "Failed to open FILE '%s' for
> reading",
> -                       path);
> +               ttype =3D (conf->flags & TST_SR_FAIL_RO) ? TBROK : TCONF;
> +               tst_brk(ttype | TERRNO, "Path is not writable: %s",
> conf->path);
> +       }
> +
> +       fp =3D fopen(conf->path, "r");
> +
> +       if (fp =3D=3D NULL) {
> +               print_error(conf->flags & TST_SR_IGNORE_ERR,
> +                       "Failed to open '%s' for reading", conf->path);
>                 return 1;
>         }
>
> @@ -86,24 +92,41 @@ int tst_sys_conf_save(const char *path)
>         fclose(fp);
>
>         if (ret =3D=3D NULL) {
> -               if (flag =3D=3D '?')
> +               if (conf->flags & TST_SR_IGNORE_ERR)
>                         return 1;
>
>                 tst_brk(TBROK | TERRNO, "Failed to read anything from
> '%s'",
> -                       path);
> +                       conf->path);
>         }
>
> -       return tst_sys_conf_save_str(path, line);
> -}
> +       tst_sys_conf_save_str(conf->path, line);
>
> -void tst_sys_conf_set(const char *path, const char *value)
> -{
> -       char flag =3D path[0];
> -       if (flag  =3D=3D '?' || flag =3D=3D '!')
> -               path++;
> +       if (!conf->val)
> +               return 0;
> +
> +       fp =3D fopen(conf->path, "w");
> +
> +       if (fp =3D=3D NULL) {
> +               print_error(conf->flags & TST_SR_IGNORE_ERR,
> +                       "Failed to open '%s' for writing", conf->path);
> +               return 0;
> +       }
> +
> +       iret =3D fputs(conf->val, fp);
>
> -       if (value)
> -               SAFE_FILE_PRINTF(path, "%s", value);
> +       if (iret < 0) {
> +               print_error(conf->flags & TST_SR_IGNORE_ERR,
> +                       "Failed to write into '%s'", conf->path);
> +       }
> +
> +       iret =3D fclose(fp);
> +
> +       if (iret < 0) {
> +               print_error(conf->flags & TST_SR_IGNORE_ERR,
> +                       "Failed to close '%s'", conf->path);
> +       }
> +
> +       return 0;
>  }
>
>  void tst_sys_conf_restore(int verbose)
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8ccde1629..366f67e44 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1181,8 +1181,7 @@ static void do_setup(int argc, char *argv[])
>                 const struct tst_path_val *pvl =3D tst_test->save_restore=
;
>
>                 while (pvl->path) {
> -                       if (!tst_sys_conf_save(pvl->path))
> -                               tst_sys_conf_set(pvl->path, pvl->val);
> +                       tst_sys_conf_save(pvl);
>                         pvl++;
>                 }
>         }
> diff --git a/testcases/cve/icmp_rate_limit01.c
> b/testcases/cve/icmp_rate_limit01.c
> index 1263762d2..23fd6560c 100644
> --- a/testcases/cve/icmp_rate_limit01.c
> +++ b/testcases/cve/icmp_rate_limit01.c
> @@ -269,7 +269,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/containers/userns/userns08.c
> b/testcases/kernel/containers/userns/userns08.c
> index 0f1cb54a9..3d060a548 100644
> --- a/testcases/kernel/containers/userns/userns08.c
> +++ b/testcases/kernel/containers/userns/userns08.c
> @@ -135,7 +135,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/kvm/kvm_pagefault01.c
> b/testcases/kernel/kvm/kvm_pagefault01.c
> index e355fa448..7f33f42ce 100644
> --- a/testcases/kernel/kvm/kvm_pagefault01.c
> +++ b/testcases/kernel/kvm/kvm_pagefault01.c
> @@ -217,7 +217,8 @@ static struct tst_test test =3D {
>         .cleanup =3D tst_kvm_cleanup,
>         .needs_root =3D 1,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/sys/module/kvm/parameters/tdp_mmu", "0"},
> +               {"/sys/module/kvm/parameters/tdp_mmu", "0",
> +                       TST_SR_IGNORE_MISSING},
>                 {}
>         },
>         .supported_archs =3D (const char *const []) {
> diff --git a/testcases/kernel/mem/ksm/ksm01.c
> b/testcases/kernel/mem/ksm/ksm01.c
> index 1f3852fc3..e9e5356fd 100644
> --- a/testcases/kernel/mem/ksm/ksm01.c
> +++ b/testcases/kernel/mem/ksm/ksm01.c
> @@ -80,10 +80,12 @@ static struct tst_test test =3D {
>         },
>         .setup =3D setup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/sys/kernel/mm/ksm/run", NULL},
> -               {"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
> -               {"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
> -               {"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL,
> TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_IGNORE_MISSING},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +                       TST_SR_IGNORE_MISSING},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm02.c
> b/testcases/kernel/mem/ksm/ksm02.c
> index 4183108d5..8e5c97235 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -101,10 +101,12 @@ static struct tst_test test =3D {
>         },
>         .setup =3D setup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/sys/kernel/mm/ksm/run", NULL},
> -               {"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
> -               {"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
> -               {"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL,
> TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_IGNORE_MISSING},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +                       TST_SR_IGNORE_MISSING},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm03.c
> b/testcases/kernel/mem/ksm/ksm03.c
> index 1cf2e4954..1af47f678 100644
> --- a/testcases/kernel/mem/ksm/ksm03.c
> +++ b/testcases/kernel/mem/ksm/ksm03.c
> @@ -83,10 +83,12 @@ static struct tst_test test =3D {
>         },
>         .setup =3D setup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/sys/kernel/mm/ksm/run", NULL},
> -               {"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
> -               {"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
> -               {"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL,
> TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_IGNORE_MISSING},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +                       TST_SR_IGNORE_MISSING},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm04.c
> b/testcases/kernel/mem/ksm/ksm04.c
> index 9fe9d6dd5..8d1caafa4 100644
> --- a/testcases/kernel/mem/ksm/ksm04.c
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -103,10 +103,12 @@ static struct tst_test test =3D {
>         },
>         .setup =3D setup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/sys/kernel/mm/ksm/run", NULL},
> -               {"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
> -               {"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
> -               {"?/sys/kernel/mm/ksm/merge_across_nodes", "1"},
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL,
> TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_IGNORE_MISSING},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +                       TST_SR_IGNORE_MISSING},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm05.c
> b/testcases/kernel/mem/ksm/ksm05.c
> index 146a9a3b7..8ea9bd187 100644
> --- a/testcases/kernel/mem/ksm/ksm05.c
> +++ b/testcases/kernel/mem/ksm/ksm05.c
> @@ -89,7 +89,7 @@ static struct tst_test test =3D {
>         .test_all =3D test_ksm,
>         .min_kver =3D "2.6.32",
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/sys/kernel/mm/ksm/run", "1"},
> +               {"/sys/kernel/mm/ksm/run", "1", TST_SR_REQUIRED},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm06.c
> b/testcases/kernel/mem/ksm/ksm06.c
> index 21c82edc1..539b3c833 100644
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -137,10 +137,11 @@ static struct tst_test test =3D {
>         },
>         .setup =3D setup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/sys/kernel/mm/ksm/max_page_sharing", NULL},
> -               {"!/sys/kernel/mm/ksm/run", NULL},
> -               {"!/sys/kernel/mm/ksm/sleep_millisecs", NULL},
> -               {"/sys/kernel/mm/ksm/merge_across_nodes", NULL},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_IGNORE_MISSING},
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL,
> TST_SR_REQUIRED},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", NULL, 0},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c
> b/testcases/kernel/syscalls/add_key/add_key05.c
> index 63cb262bb..9ae95b18a 100644
> --- a/testcases/kernel/syscalls/add_key/add_key05.c
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -220,9 +220,10 @@ static struct tst_test test =3D {
>         .forks_child =3D 1,
>         .cleanup =3D cleanup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/kernel/keys/gc_delay", "1"},
> -               {"?/proc/sys/kernel/keys/maxkeys", "200"},
> -               {"?/proc/sys/kernel/keys/maxbytes", "20000"},
> +               {"/proc/sys/kernel/keys/gc_delay", "1",
> TST_SR_IGNORE_MISSING},
> +               {"/proc/sys/kernel/keys/maxkeys", "200",
> TST_SR_IGNORE_MISSING},
> +               {"/proc/sys/kernel/keys/maxbytes", "20000",
> +                       TST_SR_IGNORE_MISSING},
>                 {}
>         },
>         .bufs =3D (struct tst_buffers []) {
> diff --git a/testcases/kernel/syscalls/bind/bind06.c
> b/testcases/kernel/syscalls/bind/bind06.c
> index 618cfce46..6ef72db93 100644
> --- a/testcases/kernel/syscalls/bind/bind06.c
> +++ b/testcases/kernel/syscalls/bind/bind06.c
> @@ -110,7 +110,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/fork/fork13.c
> b/testcases/kernel/syscalls/fork/fork13.c
> index fe30d1e9c..baa1825ae 100644
> --- a/testcases/kernel/syscalls/fork/fork13.c
> +++ b/testcases/kernel/syscalls/fork/fork13.c
> @@ -113,7 +113,7 @@ static struct tst_test test =3D {
>         .max_runtime =3D 600,
>         .test_all =3D check,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/proc/sys/kernel/pid_max", PID_MAX_STR},
> +               {"/proc/sys/kernel/pid_max", PID_MAX_STR, TST_SR_REQUIRED=
},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> index 2257ae0f9..272e58e3a 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> @@ -76,7 +76,7 @@ static struct tst_test test =3D {
>         .cleanup =3D cleanup,
>         .test_all =3D verify_msgget,
>         .save_restore =3D (const struct tst_path_val[]){
> -               {"/proc/sys/kernel/msgmni", NULL},
> +               {"/proc/sys/kernel/msgmni", NULL, 0},
>                 {}
>         }
>  };
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c
> b/testcases/kernel/syscalls/madvise/madvise06.c
> index 27aff18f1..37e7f72ab 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -239,7 +239,7 @@ static struct tst_test test =3D {
>         .needs_tmpdir =3D 1,
>         .needs_root =3D 1,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/vm/swappiness", NULL},
> +               {"/proc/sys/vm/swappiness", NULL, TST_SR_IGNORE_MISSING},
>                 {}
>         },
>         .needs_cgroup_ctrls =3D (const char *const []){ "memory", NULL },
> diff --git a/testcases/kernel/syscalls/madvise/madvise08.c
> b/testcases/kernel/syscalls/madvise/madvise08.c
> index 10549f4b4..75d76f725 100644
> --- a/testcases/kernel/syscalls/madvise/madvise08.c
> +++ b/testcases/kernel/syscalls/madvise/madvise08.c
> @@ -213,7 +213,7 @@ static struct tst_test test =3D {
>         .needs_root =3D 1,
>         .forks_child =3D 1,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {CORE_PATTERN, NULL},
> +               {CORE_PATTERN, NULL, 0},
>                 {}
>         },
>  };
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> index 32da57042..78a4c39bf 100644
> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> @@ -327,7 +327,7 @@ static struct tst_test test =3D {
>         .test_all =3D run,
>         .setup =3D setup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/kernel/numa_balancing", "0"},
> +               {"/proc/sys/kernel/numa_balancing", "0",
> TST_SR_IGNORE_MISSING},
>                 {}
>         },
>  };
> diff --git a/testcases/kernel/syscalls/sendto/sendto03.c
> b/testcases/kernel/syscalls/sendto/sendto03.c
> index 5d2c1e112..6ff7934c9 100644
> --- a/testcases/kernel/syscalls/sendto/sendto03.c
> +++ b/testcases/kernel/syscalls/sendto/sendto03.c
> @@ -218,7 +218,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> index 651583fb6..97876a4d4 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> @@ -102,7 +102,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
> index 9c818646b..84e318f51 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
> @@ -130,7 +130,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
> index 616159a90..e208800e2 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
> @@ -143,7 +143,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> index 563444635..35724d94d 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> @@ -159,7 +159,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> index 98f7fd00e..a5ac58389 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> @@ -124,7 +124,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL,
> TST_SR_IF_ACCESS},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/syslog/syslog11.c
> b/testcases/kernel/syscalls/syslog/syslog11.c
> index ca1ecbbe3..01a5eefa9 100644
> --- a/testcases/kernel/syscalls/syslog/syslog11.c
> +++ b/testcases/kernel/syscalls/syslog/syslog11.c
> @@ -58,7 +58,7 @@ static void run(unsigned int n)
>  static struct tst_test test =3D {
>         .test =3D run,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/proc/sys/kernel/printk", NULL},
> +               {"/proc/sys/kernel/printk", NULL, TST_SR_REQUIRED},
>                 {}
>         },
>         .needs_root =3D 1,
> --
> 2.37.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


--=20
Regards,
Li Wang

--0000000000002f307205ecc75dd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Nov 4, 2022 at 8:07 PM Martin Doucha &lt;<a=
 href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Tests using the .save_resto=
re functionality currently cannot run<br>
without root privileges at all because the test will write<br>
into the path at least at the end and trigger error, even when<br>
the config paths are flagged as optional.<br>
<br>
Introduce new tst_path_val field for flags and replace path prefix flags<br=
>
with bit flags. Also introduce new flags to control handling of read/write<=
br>
errors and read-only sysfiles and rewrite save_restore implementation<br>
accordingly.<br>
<br>
Signed-off-by: Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=
=3D"_blank">mdoucha@suse.cz</a>&gt;<br>
---<br>
<br>
This is technically a v2 for<br>
<a href=3D"https://patchwork.ozlabs.org/project/ltp/patch/20221021155740.83=
39-1-mdoucha@suse.cz/" rel=3D"noreferrer" target=3D"_blank">https://patchwo=
rk.ozlabs.org/project/ltp/patch/20221021155740.8339-1-mdoucha@suse.cz/</a><=
br>
<br>
I&#39;ll send a follow-up patchset to replace setup() code which requires r=
oot<br>
privileges without good reason after this patch gets merged. Here I&#39;ve =
kept<br>
test changes to the minimum needed to maintain current save_restore behavio=
r<br>
with the new flags system. The only change in behavior is the use of read-o=
nly<br>
handling flags where it&#39;s clear that the change is desired.<br>
<br>
Though a few tests should get closer attention during review:<br>
- all KSM tests<br>
- add_key05<br>
- migrate_pages02<br>
<br>
=C2=A0doc/c-test-api.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 38 ++++----<br>
=C2=A0include/tst_sys_conf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 15 ++-<br>
=C2=A0lib/tst_sys_conf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 97 ++++++++++++-------<b=
r>
=C2=A0lib/tst_test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 +-<br>
=C2=A0testcases/cve/icmp_rate_limit01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0testcases/kernel/containers/userns/userns08.c |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/kvm/kvm_pagefault01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 3 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 10 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm02.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 10 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm03.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 10 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm04.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 10 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm05.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm06.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 9 +-<br>
=C2=A0testcases/kernel/syscalls/add_key/add_key05.c |=C2=A0 7 +-<br>
=C2=A0testcases/kernel/syscalls/bind/bind06.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0testcases/kernel/syscalls/fork/fork13.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 2 +-<br>
=C2=A0.../kernel/syscalls/ipc/msgget/msgget03.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
2 +-<br>
=C2=A0testcases/kernel/syscalls/madvise/madvise06.c |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/syscalls/madvise/madvise08.c |=C2=A0 2 +-<br>
=C2=A0.../syscalls/migrate_pages/migrate_pages02.c=C2=A0 |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/syscalls/sendto/sendto03.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt05.c |=C2=A0 2 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt06.c |=C2=A0 2 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt07.c |=C2=A0 2 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt08.c |=C2=A0 2 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt09.c |=C2=A0 2 +-<br>
=C2=A0testcases/kernel/syscalls/syslog/syslog11.c=C2=A0 =C2=A0|=C2=A0 2 +-<=
br>
=C2=A027 files changed, 142 insertions(+), 102 deletions(-)<br>
<br>
diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt<br>
index e4c66b492..dbca6266b 100644<br>
--- a/doc/c-test-api.txt<br>
+++ b/doc/c-test-api.txt<br>
@@ -1602,35 +1602,33 @@ LTP library can be instructed to save and restore v=
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
+* &#39;TST_SR_IGNORE_MISSING&#39; =E2=80=93 Continue without saving the fi=
le if it does not exist<br>
+* &#39;TST_SR_FAIL_RO&#39; =E2=80=93 End test with &#39;TBROK&#39; if the =
file is read-only<br>
+* &#39;TST_SR_IGNORE_RO&#39; =E2=80=93 Continue without saving the file if=
 it is read-only<br>
+* &#39;TST_SR_IGNORE_ERR&#39; =E2=80=93 Ignore errors when writing new val=
ue into the file<br>
+* &#39;TST_SR_REQUIRED&#39; =E2=80=93 Equivalent to &#39;TST_SR_FAIL_MISSI=
NG | TST_SR_FAIL_RO&#39;<br>
+* &#39;TST_SR_IF_ACCESS&#39; =E2=80=93 Equivalent to &#39;TST_SR_IGNORE_MI=
SSING | TST_SR_IGNORE_RO&#39;<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, &quot;1&quot;, TST_SR_REQUIRED},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0};<br>
diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h<br>
index b7bbe36fc..a87f4e1cd 100644<br>
--- a/include/tst_sys_conf.h<br>
+++ b/include/tst_sys_conf.h<br>
@@ -5,14 +5,23 @@<br>
=C2=A0#ifndef TST_SYS_CONF_H__<br>
=C2=A0#define TST_SYS_CONF_H__<br>
<br>
+#define TST_SR_FAIL_MISSING 0x1<br>
+#define TST_SR_IGNORE_MISSING 0x2<br>
+#define TST_SR_FAIL_RO 0x4<br>
+#define TST_SR_IGNORE_RO 0x8<br>
+#define TST_SR_IGNORE_ERR 0x10<br></blockquote><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">This is a good thought to s=
plit the permission and respectively</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">handle them, but I feel that these names are=C2=A0a b=
it ambiguous.</div><div class=3D"gmail_default" style=3D"font-size:small"><=
br></div><div class=3D"gmail_default" style=3D"font-size:small">For example=
 TST_SR_IGNORE_RO, I was puzzled a while when</div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">reading it in the below code, it can be thou=
ght of as ignoring the</div><div class=3D"gmail_default" style=3D"font-size=
:small">READ_ONLY permission if just from the literal meaning.</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small"><br></div><div class=3D"gma=
il_default" style=3D"font-size:small">We=C2=A0need to find more precise nam=
es.</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
+#define TST_SR_REQUIRED (TST_SR_FAIL_MISSING | TST_SR_FAIL_RO)<br>
+#define TST_SR_IF_ACCESS (TST_SR_IGNORE_MISSING | TST_SR_IGNORE_RO)<br></b=
lockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-si=
ze:small">Here as well, especially these two will be more frequently=C2=A0u=
sed in testcase writing.</div></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
+<br>
=C2=A0struct tst_path_val {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *path;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *val;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int flags;<br>
=C2=A0};<br>
<br>
-int tst_sys_conf_save_str(const char *path, const char *value);<br>
-int tst_sys_conf_save(const char *path);<br></blockquote><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
-void tst_sys_conf_set(const char *path, const char *value);<br></blockquot=
e><div>=C2=A0</div><div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">I made it an external function for wide use by users, but seems</div><d=
iv class=3D"gmail_default" style=3D"font-size:small">that&#39;s a bit redun=
dant, we have=C2=A0SAFE_FILE_PRINTF instead,</div><div class=3D"gmail_defau=
lt" style=3D"font-size:small">so here I&#39;m OK with removing it.</div><br=
></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+void tst_sys_conf_save_str(const char *path, const char *value);<br></bloc=
kquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:=
small">Do we have any other place to use tst_sys_conf_save_str?</div><div c=
lass=3D"gmail_default" style=3D"font-size:small">If no, I would suggest dec=
laring it only as a static function</div><div class=3D"gmail_default" style=
=3D"font-size:small">in the tst_sys_conf.c</div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">Anyway,=C2=A0 the basic method=
 of this patch is what I liked, and</div><div class=3D"gmail_default" style=
=3D"font-size:small">the rest part=C2=A0(+ fixed with Jan&#39;s comments) l=
ooks good.</div><div class=3D"gmail_default" style=3D"font-size:small"><br>=
</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
+int tst_sys_conf_save(const struct tst_path_val *conf);<br>
=C2=A0void tst_sys_conf_restore(int verbose);<br>
=C2=A0void tst_sys_conf_dump(void);<br>
<br>
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c<br>
index 003698825..3bf5c25fb 100644<br>
--- a/lib/tst_sys_conf.c<br>
+++ b/lib/tst_sys_conf.c<br>
@@ -20,6 +20,14 @@ struct tst_sys_conf {<br>
<br>
=C2=A0static struct tst_sys_conf *save_restore_data;<br>
<br>
+static void print_error(int info_only, const char *err, const char *path)<=
br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (info_only)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, err,=
 path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TER=
RNO, err, path);<br>
+}<br>
+<br>
=C2=A0void tst_sys_conf_dump(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tst_sys_conf *i;<br>
@@ -28,7 +36,7 @@ void tst_sys_conf_dump(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res(TINFO, &quo=
t;%s =3D %s&quot;, i-&gt;path, i-&gt;value);<br>
=C2=A0}<br>
<br>
-int tst_sys_conf_save_str(const char *path, const char *value)<br>
+void tst_sys_conf_save_str(const char *path, const char *value)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tst_sys_conf *n =3D SAFE_MALLOC(sizeof(*=
n));<br>
<br>
@@ -40,45 +48,43 @@ int tst_sys_conf_save_str(const char *path, const char =
*value)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 n-&gt;next =3D save_restore_data;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 save_restore_data =3D n;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
-int tst_sys_conf_save(const char *path)<br>
+int tst_sys_conf_save(const struct tst_path_val *conf)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char line[PATH_MAX];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ttype, iret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FILE *fp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void *ret;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char flag;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!path)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!conf || !conf-&gt;path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK, &quo=
t;path is empty&quot;);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0flag =3D path[0];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flag=C2=A0 =3D=3D &#39;?&#39; || flag =3D=
=3D &#39;!&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path++;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(path, F_OK) !=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (flag) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;?&#39;:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TINFO, &quot;Path not found: &#39;%s&#39;&quot;, path);<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;!&#39;:<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_brk(TBROK|TERRNO, &quot;Path not found: &#39;%s&#39;&quot;, p=
ath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_brk(TCONF|TERRNO, &quot;Path not found: &#39;%s&#39;&quot;, p=
ath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(conf-&gt;path, F_OK) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;flags =
&amp; TST_SR_IGNORE_MISSING) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TINFO, &quot;Path not found: %s&quot;, conf-&gt;path);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttype =3D (conf-&gt=
;flags &amp; TST_SR_FAIL_MISSING) ? TBROK : TCONF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(ttype | TER=
RNO, &quot;Path not found: %s&quot;, conf-&gt;path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(path, &quot;r&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fp =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flag =3D=3D &#3=
9;?&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(conf-&gt;path, W_OK) !=3D 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;flags =
&amp; TST_SR_IGNORE_RO) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TINFO, &quot;Path is not writable: %s&quot;, conf-&gt;pat=
h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TER=
RNO, &quot;Failed to open FILE &#39;%s&#39; for reading&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttype =3D (conf-&gt=
;flags &amp; TST_SR_FAIL_RO) ? TBROK : TCONF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(ttype | TER=
RNO, &quot;Path is not writable: %s&quot;, conf-&gt;path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(conf-&gt;path, &quot;r&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error(conf-&g=
t;flags &amp; TST_SR_IGNORE_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to open &#39;%s&#39; for reading&quot;, conf-&gt;pat=
h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -86,24 +92,41 @@ int tst_sys_conf_save(const char *path)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fclose(fp);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flag =3D=3D &#3=
9;?&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (conf-&gt;flags =
&amp; TST_SR_IGNORE_ERR)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 1;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brk(TBROK | TER=
RNO, &quot;Failed to read anything from &#39;%s&#39;&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0conf-&gt;path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return tst_sys_conf_save_str(path, line);<br>
-}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_sys_conf_save_str(conf-&gt;path, line);<br>
<br>
-void tst_sys_conf_set(const char *path, const char *value)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0char flag =3D path[0];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (flag=C2=A0 =3D=3D &#39;?&#39; || flag =3D=
=3D &#39;!&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path++;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!conf-&gt;val)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(conf-&gt;path, &quot;w&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error(conf-&g=
t;flags &amp; TST_SR_IGNORE_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to open &#39;%s&#39; for writing&quot;, conf-&gt;pat=
h);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iret =3D fputs(conf-&gt;val, fp);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (value)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FILE_PRINTF(pa=
th, &quot;%s&quot;, value);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (iret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error(conf-&g=
t;flags &amp; TST_SR_IGNORE_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to write into &#39;%s&#39;&quot;, conf-&gt;path);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iret =3D fclose(fp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (iret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error(conf-&g=
t;flags &amp; TST_SR_IGNORE_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to close &#39;%s&#39;&quot;, conf-&gt;path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0void tst_sys_conf_restore(int verbose)<br>
diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
index 8ccde1629..366f67e44 100644<br>
--- a/lib/tst_test.c<br>
+++ b/lib/tst_test.c<br>
@@ -1181,8 +1181,7 @@ static void do_setup(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct tst_pa=
th_val *pvl =3D tst_test-&gt;save_restore;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while (pvl-&gt;path=
) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (!tst_sys_conf_save(pvl-&gt;path))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_sys_conf_set(pvl-&gt;path, pvl-&g=
t;val);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_sys_conf_save(pvl);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pvl++;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_li=
mit01.c<br>
index 1263762d2..23fd6560c 100644<br>
--- a/testcases/cve/icmp_rate_limit01.c<br>
+++ b/testcases/cve/icmp_rate_limit01.c<br>
@@ -269,7 +269,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kern=
el/containers/userns/userns08.c<br>
index 0f1cb54a9..3d060a548 100644<br>
--- a/testcases/kernel/containers/userns/userns08.c<br>
+++ b/testcases/kernel/containers/userns/userns08.c<br>
@@ -135,7 +135,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/=
kvm_pagefault01.c<br>
index e355fa448..7f33f42ce 100644<br>
--- a/testcases/kernel/kvm/kvm_pagefault01.c<br>
+++ b/testcases/kernel/kvm/kvm_pagefault01.c<br>
@@ -217,7 +217,8 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cleanup =3D tst_kvm_cleanup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/module=
/kvm/parameters/tdp_mmu&quot;, &quot;0&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/module/=
kvm/parameters/tdp_mmu&quot;, &quot;0&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .supported_archs =3D (const char *const []) {<b=
r>
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ks=
m01.c<br>
index 1f3852fc3..e9e5356fd 100644<br>
--- a/testcases/kernel/mem/ksm/ksm01.c<br>
+++ b/testcases/kernel/mem/ksm/ksm01.c<br>
@@ -80,10 +80,12 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/run&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/sleep_millisecs&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/max_page_sharing&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/merge_across_nodes&quot;, &quot;1&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ks=
m02.c<br>
index 4183108d5..8e5c97235 100644<br>
--- a/testcases/kernel/mem/ksm/ksm02.c<br>
+++ b/testcases/kernel/mem/ksm/ksm02.c<br>
@@ -101,10 +101,12 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/run&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/sleep_millisecs&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/max_page_sharing&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/merge_across_nodes&quot;, &quot;1&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ks=
m03.c<br>
index 1cf2e4954..1af47f678 100644<br>
--- a/testcases/kernel/mem/ksm/ksm03.c<br>
+++ b/testcases/kernel/mem/ksm/ksm03.c<br>
@@ -83,10 +83,12 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/run&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/sleep_millisecs&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/max_page_sharing&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/merge_across_nodes&quot;, &quot;1&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ks=
m04.c<br>
index 9fe9d6dd5..8d1caafa4 100644<br>
--- a/testcases/kernel/mem/ksm/ksm04.c<br>
+++ b/testcases/kernel/mem/ksm/ksm04.c<br>
@@ -103,10 +103,12 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/run&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/sleep_millisecs&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/max_page_sharing&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/merge_across_nodes&quot;, &quot;1&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ks=
m05.c<br>
index 146a9a3b7..8ea9bd187 100644<br>
--- a/testcases/kernel/mem/ksm/ksm05.c<br>
+++ b/testcases/kernel/mem/ksm/ksm05.c<br>
@@ -89,7 +89,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D test_ksm,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_kver =3D &quot;2.6.32&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/run&quot;, &quot;1&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, &quot;1&quot;, TST_SR_REQUIRED},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ks=
m06.c<br>
index 21c82edc1..539b3c833 100644<br>
--- a/testcases/kernel/mem/ksm/ksm06.c<br>
+++ b/testcases/kernel/mem/ksm/ksm06.c<br>
@@ -137,10 +137,11 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/sys/kernel=
/mm/ksm/max_page_sharing&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/run&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/sys/kernel=
/mm/ksm/sleep_millisecs&quot;, NULL},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_REQUIRED},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, NULL, 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kern=
el/syscalls/add_key/add_key05.c<br>
index 63cb262bb..9ae95b18a 100644<br>
--- a/testcases/kernel/syscalls/add_key/add_key05.c<br>
+++ b/testcases/kernel/syscalls/add_key/add_key05.c<br>
@@ -220,9 +220,10 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .forks_child =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cleanup =3D cleanup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/k=
ernel/keys/gc_delay&quot;, &quot;1&quot;},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/k=
ernel/keys/maxkeys&quot;, &quot;200&quot;},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/k=
ernel/keys/maxbytes&quot;, &quot;20000&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/keys/gc_delay&quot;, &quot;1&quot;, TST_SR_IGNORE_MISSING},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/keys/maxkeys&quot;, &quot;200&quot;, TST_SR_IGNORE_MISSING},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/keys/maxbytes&quot;, &quot;20000&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_IGNORE_MISSING},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .bufs =3D (struct tst_buffers []) {<br>
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/sys=
calls/bind/bind06.c<br>
index 618cfce46..6ef72db93 100644<br>
--- a/testcases/kernel/syscalls/bind/bind06.c<br>
+++ b/testcases/kernel/syscalls/bind/bind06.c<br>
@@ -110,7 +110,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/sys=
calls/fork/fork13.c<br>
index fe30d1e9c..baa1825ae 100644<br>
--- a/testcases/kernel/syscalls/fork/fork13.c<br>
+++ b/testcases/kernel/syscalls/fork/fork13.c<br>
@@ -113,7 +113,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_runtime =3D 600,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D check,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/proc/sys/k=
ernel/pid_max&quot;, PID_MAX_STR},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/pid_max&quot;, PID_MAX_STR, TST_SR_REQUIRED},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/ke=
rnel/syscalls/ipc/msgget/msgget03.c<br>
index 2257ae0f9..272e58e3a 100644<br>
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c<br>
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c<br>
@@ -76,7 +76,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .cleanup =3D cleanup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D verify_msgget,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/msgmni&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/msgmni&quot;, NULL, 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0};<br>
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kern=
el/syscalls/madvise/madvise06.c<br>
index 27aff18f1..37e7f72ab 100644<br>
--- a/testcases/kernel/syscalls/madvise/madvise06.c<br>
+++ b/testcases/kernel/syscalls/madvise/madvise06.c<br>
@@ -239,7 +239,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_tmpdir =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/v=
m/swappiness&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/vm=
/swappiness&quot;, NULL, TST_SR_IGNORE_MISSING},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_cgroup_ctrls =3D (const char *const []){=
 &quot;memory&quot;, NULL },<br>
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kern=
el/syscalls/madvise/madvise08.c<br>
index 10549f4b4..75d76f725 100644<br>
--- a/testcases/kernel/syscalls/madvise/madvise08.c<br>
+++ b/testcases/kernel/syscalls/madvise/madvise08.c<br>
@@ -213,7 +213,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .forks_child =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{CORE_PATTERN, NULL=
},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{CORE_PATTERN, NULL=
, 0},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0};<br>
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/te=
stcases/kernel/syscalls/migrate_pages/migrate_pages02.c<br>
index 32da57042..78a4c39bf 100644<br>
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c<br>
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c<br>
@@ -327,7 +327,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D run,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/k=
ernel/numa_balancing&quot;, &quot;0&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/numa_balancing&quot;, &quot;0&quot;, TST_SR_IGNORE_MISSING},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0};<br>
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel=
/syscalls/sendto/sendto03.c<br>
index 5d2c1e112..6ff7934c9 100644<br>
--- a/testcases/kernel/syscalls/sendto/sendto03.c<br>
+++ b/testcases/kernel/syscalls/sendto/sendto03.c<br>
@@ -218,7 +218,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt05.c<br>
index 651583fb6..97876a4d4 100644<br>
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c<br>
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c<br>
@@ -102,7 +102,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt06.c<br>
index 9c818646b..84e318f51 100644<br>
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c<br>
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c<br>
@@ -130,7 +130,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt07.c<br>
index 616159a90..e208800e2 100644<br>
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c<br>
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c<br>
@@ -143,7 +143,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt08.c<br>
index 563444635..35724d94d 100644<br>
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c<br>
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c<br>
@@ -159,7 +159,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt09.c<br>
index 98f7fd00e..a5ac58389 100644<br>
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c<br>
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c<br>
@@ -124,7 +124,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/u=
ser/max_user_namespaces&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_IF_ACCESS},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel=
/syscalls/syslog/syslog11.c<br>
index ca1ecbbe3..01a5eefa9 100644<br>
--- a/testcases/kernel/syscalls/syslog/syslog11.c<br>
+++ b/testcases/kernel/syscalls/syslog/syslog11.c<br>
@@ -58,7 +58,7 @@ static void run(unsigned int n)<br>
=C2=A0static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test =3D run,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;!/proc/sys/k=
ernel/printk&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/printk&quot;, NULL, TST_SR_REQUIRED},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>
-- <br>
2.37.3<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--0000000000002f307205ecc75dd6--


--===============0689357936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0689357936==--

