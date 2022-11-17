Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A0BC4332F
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 04:00:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A9C83C86D9
	for <ltp@archiver.kernel.org>; Thu, 17 Nov 2022 05:00:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F3A53C62DE
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 04:59:49 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 76D7F142182D
 for <ltp@lists.linux.it>; Thu, 17 Nov 2022 04:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668657584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rC+mpihldOD3jmX5lN8NgG2RRlU9vaCNvLfaiI4UEC4=;
 b=KvaYOse72NClgpwchsrGHMKK2fMRY5fVqDPwRmnxA9KqK7MSzPf9lHWiu7Khv9QDDlhHez
 RMFQNzYLKg05dKAXKCt68zUnlVmvRaoKQvGr0j8E173krkKa9dT6G60sOQsCHmOa6srzv+
 EDw7x6UmF6z0hjKJrHkbeZVYTj9fQuo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-5N6PabIGMteFFb7_HcmHng-1; Wed, 16 Nov 2022 22:59:42 -0500
X-MC-Unique: 5N6PabIGMteFFb7_HcmHng-1
Received: by mail-wm1-f72.google.com with SMTP id
 p14-20020a05600c204e00b003cf4cce4da5so94006wmg.0
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 19:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rC+mpihldOD3jmX5lN8NgG2RRlU9vaCNvLfaiI4UEC4=;
 b=YxkljqQ8VFYlWWnlvlyKcxkSmwkBRCKdCpNtKP5B8rfBOJGDqmckfBFDSXSWaJ4a2o
 XAo4GVZu2TyB4iFPf5JKFkl+kGYaT4tDLcEncTWe4fZoI4uPDInIMAIjWR4q26vBbH7+
 9TvDvE6JIWhn6SzvtUjedHXZ8JGEZwu2BaccpYPXdg10RLzwpULOmlLLcn38BXb74XPR
 Ka92eXehObi9MrzZ//mxq1rK4OqOnjM3OobM0siPVKMEuLd9ZfhwkU7Gcte694wMRIlN
 h6K0LLKkZ1ydNvjX9ShE+dibhPqVRu2xuNF6zmEOug/8niQlzUt5Y4j7p7/ktd24jq0S
 +bVA==
X-Gm-Message-State: ANoB5pkCiop82rtu8KplWWXk9mZi9QXjaVFZPgdKslzsyEa/nPUNfHZ3
 zR+T473orJMUVtZZjNUWWz5jHl6tMjgeLzTG/sMLGlACocPab9Nxi9Gs8QD445/z9q1xQMEtsbQ
 f6ejH6vb1VQytHkzGTs4jvcUDTH0=
X-Received: by 2002:a05:600c:1604:b0:3cf:7fb1:e217 with SMTP id
 m4-20020a05600c160400b003cf7fb1e217mr384978wmn.92.1668657580827; 
 Wed, 16 Nov 2022 19:59:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4uwb1ZQQcWNAb+xowvOchKOIATEWzNAYIy4oARJQTx6ysHElLeCeGeiUCxFLRyaAAAgcoj2yNHNGyTt1b4I/s=
X-Received: by 2002:a05:600c:1604:b0:3cf:7fb1:e217 with SMTP id
 m4-20020a05600c160400b003cf7fb1e217mr384967wmn.92.1668657580531; Wed, 16 Nov
 2022 19:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20221116160715.10082-1-mdoucha@suse.cz>
In-Reply-To: <20221116160715.10082-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 17 Nov 2022 11:59:28 +0800
Message-ID: <CAEemH2dGJ3LzO=OS7hrxxgMJ+T4FguiBFgB3KXirJw-R7zVBBQ@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] save_restore: Introduce new struct field for
 flags
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
Content-Type: multipart/mixed; boundary="===============1141590489=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1141590489==
Content-Type: multipart/alternative; boundary="00000000000056f47305eda29e99"

--00000000000056f47305eda29e99
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 12:07 AM Martin Doucha <mdoucha@suse.cz> wrote:

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
> Changes since v1:
> - TST_SR_IF_ACCESS =3D> TST_SR_COND_ACCESS
> - TST_SR_IGNORE_RO =3D> TST_SR_SKIP_RO
> - TST_SR_IGNORE_MISSING =3D> TST_SR_SKIP_MISSING (to match the IGNORE_RO
> change)
>
> Changes since v2:
> - Fixed save_restore example in C Test API docs
>
> Changes since v3:
> - Renamed flags to match tst_brk() constants
> - Added TERRNO to tst_res(TINFO) messages in tst_sys_conf.c
> - Added save_restore flags to newly added hugemmap08
>
> Changes since v4:
> - Print caller line number in print_error()
>
> I've removed Jan Stancek's ack because the changes are rather significant=
.
> Please review again.
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
>
>
>  doc/c-test-api.txt                            |  40 +++----
>  include/tst_sys_conf.h                        |  18 +++-
>  lib/tst_sys_conf.c                            | 100 +++++++++++-------
>  lib/tst_test.c                                |   3 +-
>  testcases/cve/icmp_rate_limit01.c             |   2 +-
>  testcases/kernel/containers/userns/userns08.c |   2 +-
>  testcases/kernel/kvm/kvm_pagefault01.c        |   3 +-
>  .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |   2 +-
>  testcases/kernel/mem/ksm/ksm01.c              |  10 +-
>  testcases/kernel/mem/ksm/ksm02.c              |  10 +-
>  testcases/kernel/mem/ksm/ksm03.c              |  10 +-
>  testcases/kernel/mem/ksm/ksm04.c              |  10 +-
>  testcases/kernel/mem/ksm/ksm05.c              |   2 +-
>  testcases/kernel/mem/ksm/ksm06.c              |   9 +-
>  testcases/kernel/syscalls/add_key/add_key05.c |   9 +-
>  testcases/kernel/syscalls/bind/bind06.c       |   2 +-
>  testcases/kernel/syscalls/fork/fork13.c       |   2 +-
>  .../kernel/syscalls/ipc/msgget/msgget03.c     |   2 +-
>  testcases/kernel/syscalls/madvise/madvise06.c |   3 +-
>  testcases/kernel/syscalls/madvise/madvise08.c |   2 +-
>  .../syscalls/migrate_pages/migrate_pages02.c  |   3 +-
>  testcases/kernel/syscalls/sendto/sendto03.c   |   2 +-
>  .../kernel/syscalls/setsockopt/setsockopt05.c |   2 +-
>  .../kernel/syscalls/setsockopt/setsockopt06.c |   2 +-
>  .../kernel/syscalls/setsockopt/setsockopt07.c |   2 +-
>  .../kernel/syscalls/setsockopt/setsockopt08.c |   2 +-
>  .../kernel/syscalls/setsockopt/setsockopt09.c |   2 +-
>  testcases/kernel/syscalls/syslog/syslog11.c   |   2 +-
>  28 files changed, 157 insertions(+), 101 deletions(-)
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 834a342fd..e6d121dce 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -1602,35 +1602,39 @@ LTP library can be instructed to save and restore
> value of specified
>  field 'save_restore'. It is a NULL-terminated array of struct
>  'tst_path_val' where each tst_path_val.path represents a file, whose
>  value is saved at the beginning and restored at the end of the test.
> -If non-NULL value is passed it is written to the respective file at
> -the beginning of the test. Only the first line of a specified file
> -is saved and restored.
> +If non-NULL string is passed in tst_path_val.val, it is written
> +to the respective file at the beginning of the test. Only the first line
> +of a specified file is saved and restored.
>
> -Pathnames can be optionally prefixed to specify how strictly (during
> -'store') are handled errors:
> +By default, the test will end with TCONF if the file is read-only or
> +does not exist. If the optional write of new value fails, the test will
> end
> +with 'TBROK'. This behavior can be changed using tst_path_val.flags:
>
> -* (no prefix) - test ends with 'TCONF', if file doesn't exist
> -* '?'         - test prints info message and continues,
> -                if file doesn't exist or open/read fails
> -* '!'         - test ends with 'TBROK', if file doesn't exist
> +* 'TST_SR_TBROK_MISSING' =E2=80=93 End test with 'TBROK' if the file doe=
s not
> exist
> +* 'TST_SR_TCONF_MISSING' =E2=80=93 End test with 'TCONF' if the file doe=
s not
> exist
> +* 'TST_SR_SKIP_MISSING' =E2=80=93 Continue without saving the file if it=
 does not
> exist
> +* 'TST_SR_TBROK_RO' =E2=80=93 End test with 'TBROK' if the file is read-=
only
> +* 'TST_SR_TCONF_RO' =E2=80=93 End test with 'TCONF' if the file is read-=
only
> +* 'TST_SR_SKIP_RO' =E2=80=93 Continue without saving the file if it is r=
ead-only
> +* 'TST_SR_IGNORE_ERR' =E2=80=93 Ignore errors when writing new value int=
o the file
> +
> +Common flag combinations also have shortcuts:
> +
> +* 'TST_SR_TCONF' =E2=80=93 Equivalent to 'TST_SR_TCONF_MISSING | TST_SR_=
TCONF_RO'
> +* 'TST_SR_TBROK' =E2=80=93 Equivalent to 'TST_SR_TBROK_MISSING | TST_SR_=
TBROK_RO'
> +* 'TST_SR_SKIP' =E2=80=93 Equivalent to 'TST_SR_SKIP_MISSING | TST_SR_SK=
IP_RO'
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
> +               {"/proc/sys/kernel/core_pattern", NULL, TST_SR_TCONF},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
> +               {"/sys/kernel/mm/ksm/run", "1", TST_SR_TBROK},
>                 {}
>         },
>  };
> diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h
> index b7bbe36fc..4c85767be 100644
> --- a/include/tst_sys_conf.h
> +++ b/include/tst_sys_conf.h
> @@ -5,14 +5,26 @@
>  #ifndef TST_SYS_CONF_H__
>  #define TST_SYS_CONF_H__
>
> +#define TST_SR_TCONF_MISSING 0x0
> +#define TST_SR_TBROK_MISSING 0x1
> +#define TST_SR_SKIP_MISSING 0x2
> +#define TST_SR_TCONF_RO 0x0
> +#define TST_SR_TBROK_RO 0x4
> +#define TST_SR_SKIP_RO 0x8
>


> +#define TST_SR_IGNORE_ERR 0x10
>

I didn't see any test using TST_SR_IGNORE_ERR flag in this patch,
is this prepared for the coming patchset?



> +
> +#define TST_SR_TCONF (TST_SR_TCONF_MISSING | TST_SR_TCONF_RO)
> +#define TST_SR_TBROK (TST_SR_TBROK_MISSING | TST_SR_TBROK_RO)
> +#define TST_SR_SKIP (TST_SR_SKIP_MISSING | TST_SR_SKIP_RO)
>

I'd suggest using "_TSKIP" to replace "_SKIP' to be consistent.
Then the whole format will look quite perfect and easy to memorize:).

Reviewed-by: Li Wang <liwang@redhat.com>



> +
>  struct tst_path_val {
>          const char *path;
>          const char *val;
> +       unsigned int flags;
>  };
>
> -int tst_sys_conf_save_str(const char *path, const char *value);
> -int tst_sys_conf_save(const char *path);
> -void tst_sys_conf_set(const char *path, const char *value);
> +void tst_sys_conf_save_str(const char *path, const char *value);
> +int tst_sys_conf_save(const struct tst_path_val *conf);
>  void tst_sys_conf_restore(int verbose);
>  void tst_sys_conf_dump(void);
>
> diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
> index 003698825..c0981dcb1 100644
> --- a/lib/tst_sys_conf.c
> +++ b/lib/tst_sys_conf.c
> @@ -20,6 +20,15 @@ struct tst_sys_conf {
>
>  static struct tst_sys_conf *save_restore_data;
>
> +static void print_error(const int lineno, int info_only, const char *err=
,
> +       const char *path)
> +{
> +       if (info_only)
> +               tst_res_(__FILE__, lineno, TINFO | TERRNO, err, path);
> +       else
> +               tst_brk_(__FILE__, lineno, TBROK | TERRNO, err, path);
> +}
> +
>  void tst_sys_conf_dump(void)
>  {
>         struct tst_sys_conf *i;
> @@ -28,7 +37,7 @@ void tst_sys_conf_dump(void)
>                 tst_res(TINFO, "%s =3D %s", i->path, i->value);
>  }
>
> -int tst_sys_conf_save_str(const char *path, const char *value)
> +void tst_sys_conf_save_str(const char *path, const char *value)
>  {
>         struct tst_sys_conf *n =3D SAFE_MALLOC(sizeof(*n));
>
> @@ -40,45 +49,45 @@ int tst_sys_conf_save_str(const char *path, const cha=
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
> +               if (conf->flags & TST_SR_SKIP_MISSING) {
> +                       tst_res(TINFO | TERRNO, "Path not found: %s",
> +                               conf->path);
> +                       return 1;
>                 }
> -               return 1;
> +
> +               ttype =3D (conf->flags & TST_SR_TBROK_MISSING) ? TBROK :
> TCONF;
> +               tst_brk(ttype | TERRNO, "Path not found: %s", conf->path)=
;
>         }
>
> -       fp =3D fopen(path, "r");
> -       if (fp =3D=3D NULL) {
> -               if (flag =3D=3D '?')
> +       if (access(conf->path, W_OK) !=3D 0) {
> +               if (conf->flags & TST_SR_SKIP_RO) {
> +                       tst_res(TINFO | TERRNO, "Path is not writable: %s=
",
> +                               conf->path);
>                         return 1;
> +               }
>
> -               tst_brk(TBROK | TERRNO, "Failed to open FILE '%s' for
> reading",
> -                       path);
> +               ttype =3D (conf->flags & TST_SR_TBROK_RO) ? TBROK : TCONF=
;
> +               tst_brk(ttype | TERRNO, "Path is not writable: %s",
> conf->path);
> +       }
> +
> +       fp =3D fopen(conf->path, "r");
> +
> +       if (fp =3D=3D NULL) {
> +               print_error(__LINE__, conf->flags & TST_SR_IGNORE_ERR,
> +                       "Failed to open '%s' for reading", conf->path);
>                 return 1;
>         }
>
> @@ -86,24 +95,41 @@ int tst_sys_conf_save(const char *path)
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
> +               print_error(__LINE__, conf->flags & TST_SR_IGNORE_ERR,
> +                       "Failed to open '%s' for writing", conf->path);
> +               return 0;
> +       }
> +
> +       iret =3D fputs(conf->val, fp);
>
> -       if (value)
> -               SAFE_FILE_PRINTF(path, "%s", value);
> +       if (iret < 0) {
> +               print_error(__LINE__, conf->flags & TST_SR_IGNORE_ERR,
> +                       "Failed to write into '%s'", conf->path);
> +       }
> +
> +       iret =3D fclose(fp);
> +
> +       if (iret < 0) {
> +               print_error(__LINE__, conf->flags & TST_SR_IGNORE_ERR,
> +                       "Failed to close '%s'", conf->path);
> +       }
> +
> +       return 0;
>  }
>
>  void tst_sys_conf_restore(int verbose)
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 1732fd058..4976dded8 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1203,8 +1203,7 @@ static void do_setup(int argc, char *argv[])
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
> index 1263762d2..8f876722f 100644
> --- a/testcases/cve/icmp_rate_limit01.c
> +++ b/testcases/cve/icmp_rate_limit01.c
> @@ -269,7 +269,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/containers/userns/userns08.c
> b/testcases/kernel/containers/userns/userns08.c
> index 0f1cb54a9..afdad6cad 100644
> --- a/testcases/kernel/containers/userns/userns08.c
> +++ b/testcases/kernel/containers/userns/userns08.c
> @@ -135,7 +135,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/kvm/kvm_pagefault01.c
> b/testcases/kernel/kvm/kvm_pagefault01.c
> index e355fa448..91891848a 100644
> --- a/testcases/kernel/kvm/kvm_pagefault01.c
> +++ b/testcases/kernel/kvm/kvm_pagefault01.c
> @@ -217,7 +217,8 @@ static struct tst_test test =3D {
>         .cleanup =3D tst_kvm_cleanup,
>         .needs_root =3D 1,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/sys/module/kvm/parameters/tdp_mmu", "0"},
> +               {"/sys/module/kvm/parameters/tdp_mmu", "0",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>                 {}
>         },
>         .supported_archs =3D (const char *const []) {
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> index 8b3bca5e3..bacd443d8 100644
> --- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
> @@ -131,7 +131,7 @@ static struct tst_test test =3D {
>         .needs_hugetlbfs =3D 1,
>         .forks_child =3D 1,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {PATH_OC_HPAGES, NULL},
> +               {PATH_OC_HPAGES, NULL, TST_SR_TCONF},
>                 {}
>         },
>         .tcnt =3D 2,
> diff --git a/testcases/kernel/mem/ksm/ksm01.c
> b/testcases/kernel/mem/ksm/ksm01.c
> index 1f3852fc3..fafa2da71 100644
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
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK=
},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm02.c
> b/testcases/kernel/mem/ksm/ksm02.c
> index 4183108d5..b5c90464e 100644
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
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK=
},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm03.c
> b/testcases/kernel/mem/ksm/ksm03.c
> index 1cf2e4954..94029054f 100644
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
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK=
},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm04.c
> b/testcases/kernel/mem/ksm/ksm04.c
> index 9fe9d6dd5..2302a2a1d 100644
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
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK=
},
> +               {"/sys/kernel/mm/ksm/max_page_sharing", NULL,
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", "1",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm05.c
> b/testcases/kernel/mem/ksm/ksm05.c
> index 146a9a3b7..c4cb779aa 100644
> --- a/testcases/kernel/mem/ksm/ksm05.c
> +++ b/testcases/kernel/mem/ksm/ksm05.c
> @@ -89,7 +89,7 @@ static struct tst_test test =3D {
>         .test_all =3D test_ksm,
>         .min_kver =3D "2.6.32",
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/sys/kernel/mm/ksm/run", "1"},
> +               {"/sys/kernel/mm/ksm/run", "1", TST_SR_TBROK},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/mem/ksm/ksm06.c
> b/testcases/kernel/mem/ksm/ksm06.c
> index 21c82edc1..0b159e5c7 100644
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
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +               {"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
> +               {"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK=
},
> +               {"/sys/kernel/mm/ksm/merge_across_nodes", NULL,
> TST_SR_TCONF},
>                 {}
>         },
>         .needs_kconfigs =3D (const char *const[]){
> diff --git a/testcases/kernel/syscalls/add_key/add_key05.c
> b/testcases/kernel/syscalls/add_key/add_key05.c
> index 63cb262bb..74b0b54dd 100644
> --- a/testcases/kernel/syscalls/add_key/add_key05.c
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -220,9 +220,12 @@ static struct tst_test test =3D {
>         .forks_child =3D 1,
>         .cleanup =3D cleanup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/kernel/keys/gc_delay", "1"},
> -               {"?/proc/sys/kernel/keys/maxkeys", "200"},
> -               {"?/proc/sys/kernel/keys/maxbytes", "20000"},
> +               {"/proc/sys/kernel/keys/gc_delay", "1",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +               {"/proc/sys/kernel/keys/maxkeys", "200",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
> +               {"/proc/sys/kernel/keys/maxbytes", "20000",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>                 {}
>         },
>         .bufs =3D (struct tst_buffers []) {
> diff --git a/testcases/kernel/syscalls/bind/bind06.c
> b/testcases/kernel/syscalls/bind/bind06.c
> index 618cfce46..f7813d26a 100644
> --- a/testcases/kernel/syscalls/bind/bind06.c
> +++ b/testcases/kernel/syscalls/bind/bind06.c
> @@ -110,7 +110,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/fork/fork13.c
> b/testcases/kernel/syscalls/fork/fork13.c
> index fe30d1e9c..bbfbf5c3b 100644
> --- a/testcases/kernel/syscalls/fork/fork13.c
> +++ b/testcases/kernel/syscalls/fork/fork13.c
> @@ -113,7 +113,7 @@ static struct tst_test test =3D {
>         .max_runtime =3D 600,
>         .test_all =3D check,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/proc/sys/kernel/pid_max", PID_MAX_STR},
> +               {"/proc/sys/kernel/pid_max", PID_MAX_STR, TST_SR_TBROK},
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> index 2257ae0f9..9e6c66cb4 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> @@ -76,7 +76,7 @@ static struct tst_test test =3D {
>         .cleanup =3D cleanup,
>         .test_all =3D verify_msgget,
>         .save_restore =3D (const struct tst_path_val[]){
> -               {"/proc/sys/kernel/msgmni", NULL},
> +               {"/proc/sys/kernel/msgmni", NULL, TST_SR_TCONF},
>                 {}
>         }
>  };
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c
> b/testcases/kernel/syscalls/madvise/madvise06.c
> index 27aff18f1..c1c55bbc2 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -239,7 +239,8 @@ static struct tst_test test =3D {
>         .needs_tmpdir =3D 1,
>         .needs_root =3D 1,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/vm/swappiness", NULL},
> +               {"/proc/sys/vm/swappiness", NULL,
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>                 {}
>         },
>         .needs_cgroup_ctrls =3D (const char *const []){ "memory", NULL },
> diff --git a/testcases/kernel/syscalls/madvise/madvise08.c
> b/testcases/kernel/syscalls/madvise/madvise08.c
> index 10549f4b4..0996cf91b 100644
> --- a/testcases/kernel/syscalls/madvise/madvise08.c
> +++ b/testcases/kernel/syscalls/madvise/madvise08.c
> @@ -213,7 +213,7 @@ static struct tst_test test =3D {
>         .needs_root =3D 1,
>         .forks_child =3D 1,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {CORE_PATTERN, NULL},
> +               {CORE_PATTERN, NULL, TST_SR_TCONF},
>                 {}
>         },
>  };
> diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> index 32da57042..4d5b2b8d5 100644
> --- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> +++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
> @@ -327,7 +327,8 @@ static struct tst_test test =3D {
>         .test_all =3D run,
>         .setup =3D setup,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/kernel/numa_balancing", "0"},
> +               {"/proc/sys/kernel/numa_balancing", "0",
> +                       TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
>                 {}
>         },
>  };
> diff --git a/testcases/kernel/syscalls/sendto/sendto03.c
> b/testcases/kernel/syscalls/sendto/sendto03.c
> index 5d2c1e112..3709b287c 100644
> --- a/testcases/kernel/syscalls/sendto/sendto03.c
> +++ b/testcases/kernel/syscalls/sendto/sendto03.c
> @@ -218,7 +218,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> index 651583fb6..580467dc8 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
> @@ -102,7 +102,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
> index 9c818646b..e67996a78 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
> @@ -130,7 +130,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
> index 616159a90..1c5a0ed6d 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
> @@ -143,7 +143,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> index 563444635..a29125fd7 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
> @@ -159,7 +159,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> index 98f7fd00e..b49b17e7d 100644
> --- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
> @@ -124,7 +124,7 @@ static struct tst_test test =3D {
>                 NULL
>         },
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"?/proc/sys/user/max_user_namespaces", NULL},
> +               {"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP}=
,
>                 {}
>         },
>         .tags =3D (const struct tst_tag[]) {
> diff --git a/testcases/kernel/syscalls/syslog/syslog11.c
> b/testcases/kernel/syscalls/syslog/syslog11.c
> index ca1ecbbe3..733da5f96 100644
> --- a/testcases/kernel/syscalls/syslog/syslog11.c
> +++ b/testcases/kernel/syscalls/syslog/syslog11.c
> @@ -58,7 +58,7 @@ static void run(unsigned int n)
>  static struct tst_test test =3D {
>         .test =3D run,
>         .save_restore =3D (const struct tst_path_val[]) {
> -               {"!/proc/sys/kernel/printk", NULL},
> +               {"/proc/sys/kernel/printk", NULL, TST_SR_TBROK},
>                 {}
>         },
>         .needs_root =3D 1,
> --
> 2.37.3
>
>

--=20
Regards,
Li Wang

--00000000000056f47305eda29e99
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Nov 17, 2022 at 12:07 AM Martin Doucha &lt;=
<a href=3D"mailto:mdoucha@suse.cz">mdoucha@suse.cz</a>&gt; wrote:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">Tests using the .save_res=
tore functionality currently cannot run<br>
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
Changes since v1:<br>
- TST_SR_IF_ACCESS =3D&gt; TST_SR_COND_ACCESS<br>
- TST_SR_IGNORE_RO =3D&gt; TST_SR_SKIP_RO<br>
- TST_SR_IGNORE_MISSING =3D&gt; TST_SR_SKIP_MISSING (to match the IGNORE_RO=
 change)<br>
<br>
Changes since v2:<br>
- Fixed save_restore example in C Test API docs<br>
<br>
Changes since v3:<br>
- Renamed flags to match tst_brk() constants<br>
- Added TERRNO to tst_res(TINFO) messages in tst_sys_conf.c<br>
- Added save_restore flags to newly added hugemmap08<br>
<br>
Changes since v4:<br>
- Print caller line number in print_error()<br>
<br>
I&#39;ve removed Jan Stancek&#39;s ack because the changes are rather signi=
ficant.<br>
Please review again.<br>
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
<br>
<br>
=C2=A0doc/c-test-api.txt=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 40 +++----<br>
=C2=A0include/tst_sys_conf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 18 +++-<br>
=C2=A0lib/tst_sys_conf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 100 +++++++++++-------<b=
r>
=C2=A0lib/tst_test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A03 +-=
<br>
=C2=A0testcases/cve/icmp_rate_limit01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0testcases/kernel/containers/userns/userns08.c |=C2=A0 =C2=A02 +-<br>
=C2=A0testcases/kernel/kvm/kvm_pagefault01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A03 +-<br>
=C2=A0.../kernel/mem/hugetlb/hugemmap/hugemmap08.c=C2=A0 |=C2=A0 =C2=A02 +-=
<br>
=C2=A0testcases/kernel/mem/ksm/ksm01.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm02.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm03.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm04.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 10 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm05.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A02 +-<br>
=C2=A0testcases/kernel/mem/ksm/ksm06.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A09 +-<br>
=C2=A0testcases/kernel/syscalls/add_key/add_key05.c |=C2=A0 =C2=A09 +-<br>
=C2=A0testcases/kernel/syscalls/bind/bind06.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0testcases/kernel/syscalls/fork/fork13.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A02 +-<br>
=C2=A0.../kernel/syscalls/ipc/msgget/msgget03.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A02 +-<br>
=C2=A0testcases/kernel/syscalls/madvise/madvise06.c |=C2=A0 =C2=A03 +-<br>
=C2=A0testcases/kernel/syscalls/madvise/madvise08.c |=C2=A0 =C2=A02 +-<br>
=C2=A0.../syscalls/migrate_pages/migrate_pages02.c=C2=A0 |=C2=A0 =C2=A03 +-=
<br>
=C2=A0testcases/kernel/syscalls/sendto/sendto03.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt05.c |=C2=A0 =C2=A02 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt06.c |=C2=A0 =C2=A02 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt07.c |=C2=A0 =C2=A02 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt08.c |=C2=A0 =C2=A02 +-<br>
=C2=A0.../kernel/syscalls/setsockopt/setsockopt09.c |=C2=A0 =C2=A02 +-<br>
=C2=A0testcases/kernel/syscalls/syslog/syslog11.c=C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A028 files changed, 157 insertions(+), 101 deletions(-)<br>
<br>
diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt<br>
index 834a342fd..e6d121dce 100644<br>
--- a/doc/c-test-api.txt<br>
+++ b/doc/c-test-api.txt<br>
@@ -1602,35 +1602,39 @@ LTP library can be instructed to save and restore v=
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
+If non-NULL string is passed in tst_path_val.val, it is written<br>
+to the respective file at the beginning of the test. Only the first line<b=
r>
+of a specified file is saved and restored.<br>
<br>
-Pathnames can be optionally prefixed to specify how strictly (during<br>
-&#39;store&#39;) are handled errors:<br>
+By default, the test will end with TCONF if the file is read-only or<br>
+does not exist. If the optional write of new value fails, the test will en=
d<br>
+with &#39;TBROK&#39;. This behavior can be changed using tst_path_val.flag=
s:<br>
<br>
-* (no prefix) - test ends with &#39;TCONF&#39;, if file doesn&#39;t exist<=
br>
-* &#39;?&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- test prints info message =
and continues,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if file doesn&#39;=
t exist or open/read fails<br>
-* &#39;!&#39;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0- test ends with &#39;TBROK=
&#39;, if file doesn&#39;t exist<br>
+* &#39;TST_SR_TBROK_MISSING&#39; =E2=80=93 End test with &#39;TBROK&#39; i=
f the file does not exist<br>
+* &#39;TST_SR_TCONF_MISSING&#39; =E2=80=93 End test with &#39;TCONF&#39; i=
f the file does not exist<br>
+* &#39;TST_SR_SKIP_MISSING&#39; =E2=80=93 Continue without saving the file=
 if it does not exist<br>
+* &#39;TST_SR_TBROK_RO&#39; =E2=80=93 End test with &#39;TBROK&#39; if the=
 file is read-only<br>
+* &#39;TST_SR_TCONF_RO&#39; =E2=80=93 End test with &#39;TCONF&#39; if the=
 file is read-only<br>
+* &#39;TST_SR_SKIP_RO&#39; =E2=80=93 Continue without saving the file if i=
t is read-only<br>
+* &#39;TST_SR_IGNORE_ERR&#39; =E2=80=93 Ignore errors when writing new val=
ue into the file<br>
+<br>
+Common flag combinations also have shortcuts:<br>
+<br>
+* &#39;TST_SR_TCONF&#39; =E2=80=93 Equivalent to &#39;TST_SR_TCONF_MISSING=
 | TST_SR_TCONF_RO&#39;<br>
+* &#39;TST_SR_TBROK&#39; =E2=80=93 Equivalent to &#39;TST_SR_TBROK_MISSING=
 | TST_SR_TBROK_RO&#39;<br>
+* &#39;TST_SR_SKIP&#39; =E2=80=93 Equivalent to &#39;TST_SR_SKIP_MISSING |=
 TST_SR_SKIP_RO&#39;<br>
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
rnel/core_pattern&quot;, NULL, TST_SR_TCONF},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/us=
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, &quot;1&quot;, TST_SR_TBROK},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0};<br>
diff --git a/include/tst_sys_conf.h b/include/tst_sys_conf.h<br>
index b7bbe36fc..4c85767be 100644<br>
--- a/include/tst_sys_conf.h<br>
+++ b/include/tst_sys_conf.h<br>
@@ -5,14 +5,26 @@<br>
=C2=A0#ifndef TST_SYS_CONF_H__<br>
=C2=A0#define TST_SYS_CONF_H__<br>
<br>
+#define TST_SR_TCONF_MISSING 0x0<br>
+#define TST_SR_TBROK_MISSING 0x1<br>
+#define TST_SR_SKIP_MISSING 0x2<br>
+#define TST_SR_TCONF_RO 0x0<br>
+#define TST_SR_TBROK_RO 0x4<br>
+#define TST_SR_SKIP_RO 0x8<br></blockquote><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
+#define TST_SR_IGNORE_ERR 0x10<br></blockquote><div><br></div><div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">I didn&#39;t see any test u=
sing TST_SR_IGNORE_ERR flag in this patch,</div><div class=3D"gmail_default=
" style=3D"font-size:small">is this prepared for the coming patchset?</div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+<br>
+#define TST_SR_TCONF (TST_SR_TCONF_MISSING | TST_SR_TCONF_RO)<br>
+#define TST_SR_TBROK (TST_SR_TBROK_MISSING | TST_SR_TBROK_RO)<br>
+#define TST_SR_SKIP (TST_SR_SKIP_MISSING | TST_SR_SKIP_RO)<br></blockquote=
><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small"=
>I&#39;d suggest using &quot;_TSKIP&quot; to=C2=A0replace=C2=A0&quot;_SKIP&=
#39; to be consistent.</div><div class=3D"gmail_default" style=3D"font-size=
:small">Then the whole format will look quite perfect and easy to memorize:=
).</div></div><div><br></div><div><div class=3D"gmail_default" style=3D"fon=
t-size:small">Reviewed-by: Li Wang &lt;<a href=3D"mailto:liwang@redhat.com"=
>liwang@redhat.com</a>&gt;</div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
+<br>
=C2=A0struct tst_path_val {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *path;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *val;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int flags;<br>
=C2=A0};<br>
<br>
-int tst_sys_conf_save_str(const char *path, const char *value);<br>
-int tst_sys_conf_save(const char *path);<br>
-void tst_sys_conf_set(const char *path, const char *value);<br>
+void tst_sys_conf_save_str(const char *path, const char *value);<br>
+int tst_sys_conf_save(const struct tst_path_val *conf);<br>
=C2=A0void tst_sys_conf_restore(int verbose);<br>
=C2=A0void tst_sys_conf_dump(void);<br>
<br>
diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c<br>
index 003698825..c0981dcb1 100644<br>
--- a/lib/tst_sys_conf.c<br>
+++ b/lib/tst_sys_conf.c<br>
@@ -20,6 +20,15 @@ struct tst_sys_conf {<br>
<br>
=C2=A0static struct tst_sys_conf *save_restore_data;<br>
<br>
+static void print_error(const int lineno, int info_only, const char *err,<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *path)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (info_only)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res_(__FILE__, =
lineno, TINFO | TERRNO, err, path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk_(__FILE__, =
lineno, TBROK | TERRNO, err, path);<br>
+}<br>
+<br>
=C2=A0void tst_sys_conf_dump(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct tst_sys_conf *i;<br>
@@ -28,7 +37,7 @@ void tst_sys_conf_dump(void)<br>
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
@@ -40,45 +49,45 @@ int tst_sys_conf_save_str(const char *path, const char =
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
&amp; TST_SR_SKIP_MISSING) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TINFO | TERRNO, &quot;Path not found: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0conf-&gt;path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 1;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttype =3D (conf-&gt=
;flags &amp; TST_SR_TBROK_MISSING) ? TBROK : TCONF;<br>
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
&amp; TST_SR_SKIP_RO) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TINFO | TERRNO, &quot;Path is not writable: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0conf-&gt;path);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TER=
RNO, &quot;Failed to open FILE &#39;%s&#39; for reading&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ttype =3D (conf-&gt=
;flags &amp; TST_SR_TBROK_RO) ? TBROK : TCONF;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(ttype | TER=
RNO, &quot;Path is not writable: %s&quot;, conf-&gt;path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fp =3D fopen(conf-&gt;path, &quot;r&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fp =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error(__LINE_=
_, conf-&gt;flags &amp; TST_SR_IGNORE_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to open &#39;%s&#39; for reading&quot;, conf-&gt;pat=
h);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -86,24 +95,41 @@ int tst_sys_conf_save(const char *path)<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error(__LINE_=
_, conf-&gt;flags &amp; TST_SR_IGNORE_ERR,<br>
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
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error(__LINE_=
_, conf-&gt;flags &amp; TST_SR_IGNORE_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to write into &#39;%s&#39;&quot;, conf-&gt;path);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0iret =3D fclose(fp);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (iret &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_error(__LINE_=
_, conf-&gt;flags &amp; TST_SR_IGNORE_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Failed to close &#39;%s&#39;&quot;, conf-&gt;path);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
<br>
=C2=A0void tst_sys_conf_restore(int verbose)<br>
diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
index 1732fd058..4976dded8 100644<br>
--- a/lib/tst_test.c<br>
+++ b/lib/tst_test.c<br>
@@ -1203,8 +1203,7 @@ static void do_setup(int argc, char *argv[])<br>
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
index 1263762d2..8f876722f 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kern=
el/containers/userns/userns08.c<br>
index 0f1cb54a9..afdad6cad 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/=
kvm_pagefault01.c<br>
index e355fa448..91891848a 100644<br>
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
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .supported_archs =3D (const char *const []) {<b=
r>
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases=
/kernel/mem/hugetlb/hugemmap/hugemmap08.c<br>
index 8b3bca5e3..bacd443d8 100644<br>
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c<br>
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c<br>
@@ -131,7 +131,7 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_hugetlbfs =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .forks_child =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{PATH_OC_HPAGES, NU=
LL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{PATH_OC_HPAGES, NU=
LL, TST_SR_TCONF},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tcnt =3D 2,<br>
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ks=
m01.c<br>
index 1f3852fc3..fafa2da71 100644<br>
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
mm/ksm/run&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ks=
m02.c<br>
index 4183108d5..b5c90464e 100644<br>
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
mm/ksm/run&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ks=
m03.c<br>
index 1cf2e4954..94029054f 100644<br>
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
mm/ksm/run&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ks=
m04.c<br>
index 9fe9d6dd5..2302a2a1d 100644<br>
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
mm/ksm/run&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/max_page_sharing&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ks=
m05.c<br>
index 146a9a3b7..c4cb779aa 100644<br>
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
mm/ksm/run&quot;, &quot;1&quot;, TST_SR_TBROK},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ks=
m06.c<br>
index 21c82edc1..0b159e5c7 100644<br>
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
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/run&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/sleep_millisecs&quot;, NULL, TST_SR_TBROK},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/sys/kernel/=
mm/ksm/merge_across_nodes&quot;, NULL, TST_SR_TCONF},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_kconfigs =3D (const char *const[]){<br>
diff --git a/testcases/kernel/syscalls/add_key/add_key05.c b/testcases/kern=
el/syscalls/add_key/add_key05.c<br>
index 63cb262bb..74b0b54dd 100644<br>
--- a/testcases/kernel/syscalls/add_key/add_key05.c<br>
+++ b/testcases/kernel/syscalls/add_key/add_key05.c<br>
@@ -220,9 +220,12 @@ static struct tst_test test =3D {<br>
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
rnel/keys/gc_delay&quot;, &quot;1&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/keys/maxkeys&quot;, &quot;200&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/keys/maxbytes&quot;, &quot;20000&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .bufs =3D (struct tst_buffers []) {<br>
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/sys=
calls/bind/bind06.c<br>
index 618cfce46..f7813d26a 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/sys=
calls/fork/fork13.c<br>
index fe30d1e9c..bbfbf5c3b 100644<br>
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
rnel/pid_max&quot;, PID_MAX_STR, TST_SR_TBROK},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/ke=
rnel/syscalls/ipc/msgget/msgget03.c<br>
index 2257ae0f9..9e6c66cb4 100644<br>
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
rnel/msgmni&quot;, NULL, TST_SR_TCONF},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0};<br>
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kern=
el/syscalls/madvise/madvise06.c<br>
index 27aff18f1..c1c55bbc2 100644<br>
--- a/testcases/kernel/syscalls/madvise/madvise06.c<br>
+++ b/testcases/kernel/syscalls/madvise/madvise06.c<br>
@@ -239,7 +239,8 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_tmpdir =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/v=
m/swappiness&quot;, NULL},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/vm=
/swappiness&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_cgroup_ctrls =3D (const char *const []){=
 &quot;memory&quot;, NULL },<br>
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kern=
el/syscalls/madvise/madvise08.c<br>
index 10549f4b4..0996cf91b 100644<br>
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
, TST_SR_TCONF},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0};<br>
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/te=
stcases/kernel/syscalls/migrate_pages/migrate_pages02.c<br>
index 32da57042..4d5b2b8d5 100644<br>
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c<br>
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c<br>
@@ -327,7 +327,8 @@ static struct tst_test test =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .test_all =3D run,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .setup =3D setup,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .save_restore =3D (const struct tst_path_val[])=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;?/proc/sys/k=
ernel/numa_balancing&quot;, &quot;0&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;/proc/sys/ke=
rnel/numa_balancing&quot;, &quot;0&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0};<br>
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel=
/syscalls/sendto/sendto03.c<br>
index 5d2c1e112..3709b287c 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt05.c<br>
index 651583fb6..580467dc8 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt06.c<br>
index 9c818646b..e67996a78 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt07.c<br>
index 616159a90..1c5a0ed6d 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt08.c<br>
index 563444635..a29125fd7 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcase=
s/kernel/syscalls/setsockopt/setsockopt09.c<br>
index 98f7fd00e..b49b17e7d 100644<br>
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
er/max_user_namespaces&quot;, NULL, TST_SR_SKIP},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .tags =3D (const struct tst_tag[]) {<br>
diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel=
/syscalls/syslog/syslog11.c<br>
index ca1ecbbe3..733da5f96 100644<br>
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
rnel/printk&quot;, NULL, TST_SR_TBROK},<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 .needs_root =3D 1,<br>
-- <br>
2.37.3<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr"><div>Regards,<br></div><div>Li =
Wang<br></div></div></div></div>

--00000000000056f47305eda29e99--


--===============1141590489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1141590489==--

