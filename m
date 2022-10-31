Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D0AFA3740
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 03:40:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 737473CAA09
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 04:40:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263B33C8122
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 04:40:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 55CB01400349
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 04:40:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667187612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMNo6QNdcQP/LoTgADLiqFaahedAAXkXMit9fYAf/IA=;
 b=jUoMdQbv12fSo0rfBvzzljPuUzEdwvxpjpqtmXYw2GISXZc0Mp/EHP0kEPLsbaFnRCygcz
 E2tlmTdRgbP5B9ijTXUGBuIi+exJuCSBtIvq58N11PyCkKzQRwaBBz2SwN8EHD6ZvlgX3U
 TwQZt7XS34wsbfYUCNED4ZRbREyCC1A=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-uOqzLOtFNEKRAac9k5hahw-1; Sun, 30 Oct 2022 23:40:10 -0400
X-MC-Unique: uOqzLOtFNEKRAac9k5hahw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-13bdcfbd787so4797991fac.18
 for <ltp@lists.linux.it>; Sun, 30 Oct 2022 20:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMNo6QNdcQP/LoTgADLiqFaahedAAXkXMit9fYAf/IA=;
 b=lhgiLHfpzkBdfBUix1ar+0GCHSEd/kwF73/TnurbAUnCRIUvWESrxvrHvvPC+lFXBJ
 e9P59iNUyFCuCuSIZB/Zr2wkP1yqEZ+8aRFOUveJAz2B3T0hSg4GuX1BTOwMSEGnCoZG
 q7jr9ERWXiNe2INiY1zqoOCzFE1XFLrCXeRenCZsxgshkSMJz6xw4KB2hxznYPEWSK0K
 Ddrxt0pSqGe9L23zycJILhVvbwt/HEy79+73yIUOGP4FDMPYricyoxM6W27RFBewuc0E
 2hHDipUwWatCDu54K8TlFaqlAT8Smvfybe8B9JzdYXzkjzNMJV3I2dkt7wm1WvT5mpCE
 kcQQ==
X-Gm-Message-State: ACrzQf0NEiXX6EuBUzX4qQ4hu86FtCH08yRHxrWo7b6zA3Z/6kimz6ZV
 HnZOMOZEkLF1jA/OxOp0kn+xQbqej4W9Flx1hw+21tX0NFK2vI302CemJ1fi7NY+UHHENJW6TDo
 gbpr4gyhPjQ3CK2AG39UeZArCyQk=
X-Received: by 2002:a05:6820:601:b0:480:89ab:e2e8 with SMTP id
 e1-20020a056820060100b0048089abe2e8mr4581680oow.95.1667187608935; 
 Sun, 30 Oct 2022 20:40:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM45/9vXn21SHli/gjQsq1r4vjoGWvNf5G2f21ZSWQ3K2KoukH6fy/gT7Ph1xPwl2N//J+GUupWCRzHeECeZV4o=
X-Received: by 2002:a05:6820:601:b0:480:89ab:e2e8 with SMTP id
 e1-20020a056820060100b0048089abe2e8mr4581669oow.95.1667187608600; Sun, 30 Oct
 2022 20:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-2-tsahu@linux.ibm.com>
In-Reply-To: <20221029071344.45447-2-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 31 Oct 2022 11:39:55 +0800
Message-ID: <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0899280955=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0899280955==
Content-Type: multipart/alternative; boundary="0000000000002f5d9405ec4c5d38"

--0000000000002f5d9405ec4c5d38
Content-Type: text/plain; charset="UTF-8"

Hi Tarun,

This version is much better, comments are inline below.

On Sat, Oct 29, 2022 at 3:14 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:

> Most of libhugetlbfs test require mounted hugetlbfs and random opened
> unlinked file for follow-up test actions.
>
> Here, this patch adds two new field in tst_test struct(include/tst_test.h)
> which user can set if the test requires mounted hugetlbfs and other one
> for if test requires opened unlinked file.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  include/tst_test.h | 20 +++++++++++++++++-
>  lib/tst_test.c     | 51 +++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 67 insertions(+), 4 deletions(-)
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index a69965b95..f36382ae9 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -131,7 +131,7 @@ struct tst_tag {
>  };
>
>  extern unsigned int tst_variant;
> -
> +extern int tst_hugetlb_fd;
>  #define TST_NO_HUGEPAGES ((unsigned long)-1)
>
>  #define TST_UNLIMITED_RUNTIME (-1)
> @@ -176,6 +176,18 @@ struct tst_test {
>         int all_filesystems:1;
>         int skip_in_lockdown:1;
>         int skip_in_compat:1;
> +       /*
> +        * If set, the test function will create a hugetlbfs mount point
> +        * at /tmp/xxxxxx, where xxxxxx is a random string.
> +        */
> +       int needs_hugetlbfs:1;
> +       /*
> +        * If set, the test function will create and open a random file
> +        * under mounted hugetlbfs. To use this option, needs_hugetlbfs
> must
> +        * be set. The file descriptior will be set in tst_hugetlb_fd.
> +        * The close(tst_hugetlb_fd) will be called on test exit(cleanup).
> +        */
> +       int needs_unlinked_hugetlb_file:1;
>

Why not consider encapsulating these two new fields in 'struct
tst_hugepage' ?

Then the tst_test in the case can simply initialize to:

....
static struct tst_test test = {
    .needs_root = 1,
    .taint_check = TST_TAINT_D | TST_TAINT_W,
    .setup = setup,
    .test_all = run_test,
    .hugepages = {1, TST_NEEDS, 1, 1},
};



>
>         /*
>          * The skip_filesystems is a NULL terminated list of filesystems
> the
> @@ -357,6 +369,12 @@ unsigned int tst_remaining_runtime(void);
>   */
>  void tst_set_max_runtime(int max_runtime);
>
> +/*
> + * Create and open a random file inside the given dir path.
> + * It unlinks the file after opening and return file descriptor.
> + */
> +int tst_create_unlinked_file(const char *path);
>

what about renaming this function to tst_'get|create'_unlinked_file_fd?
I guess the 'fd' part should be emphasized here.



> +
>  /*
>   * Returns path to the test temporary directory in a newly allocated
> buffer.
>   */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8ccde1629..43cba1004 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -925,7 +925,8 @@ static int needs_tmpdir(void)
>                tst_test->needs_device ||
>                tst_test->mntpoint ||
>                tst_test->resource_files ||
> -              tst_test->needs_checkpoints;
> +              tst_test->needs_checkpoints ||
> +                  tst_test->needs_hugetlbfs;
>  }
>
>  static void copy_resources(void)
> @@ -1021,6 +1022,30 @@ static void prepare_and_mount_dev_fs(const char
> *mntpoint)
>         }
>  }
>
> +static void prepare_and_mount_hugetlb_fs(void)
> +{
> +       tst_test->mntpoint = tst_get_tmpdir();
> +       SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
> +       mntpoint_mounted = 1;
> +}
> +
> +int tst_create_unlinked_file(const char *path)
> +{
> +       char template[PATH_MAX];
> +       int fd;
> +
> +       snprintf(template, PATH_MAX, "%s/ltp_%.3sXXXXXX",
> +                       path, TCID);
> +
> +       fd = mkstemp(template);
> +       if (fd < 0)
> +               tst_brk(TBROK | TERRNO,
> +                        "%s: mkstemp(%s) failed", __func__, template);
> +
> +       SAFE_UNLINK(template);
> +       return fd;
> +}
> +
>  static const char *limit_tmpfs_mount_size(const char *mnt_data,
>                 char *buf, size_t buf_size, const char *fs_type)
>  {
> @@ -1094,6 +1119,8 @@ static void do_cgroup_requires(void)
>         tst_cg_init();
>  }
>
> +int tst_hugetlb_fd = -1;
> +
>  static void do_setup(int argc, char *argv[])
>  {
>         if (!tst_test)
> @@ -1217,6 +1244,17 @@ static void do_setup(int argc, char *argv[])
>                 }
>         }
>
> +       if (tst_test->needs_hugetlbfs)
> +               prepare_and_mount_hugetlb_fs();
> +
> +       if (tst_test->needs_unlinked_hugetlb_file) {
> +               if (!(tst_test->needs_hugetlbfs)) {
> +                       tst_brk(TBROK, "Option needs_unlinked_hugetlb_file
> "
> +                                       "requires option needs_hugetlbfs");
> +               }
> +               tst_hugetlb_fd =
> tst_create_unlinked_file(tst_test->mntpoint);
> +       }
> +
>

Seems we have to add a confliction check[1] to avoid multiple mounting
at 'tst_test->mntpoint'. Or maybe go another method to move all the
hugetlbfs
operations into tst_hugetlb.c to isolate details from the tst_test library,
but
this will require more changes for all preexisting hugetlb tests.


[1] something like this:

@@ -1224,9 +1224,9 @@ static void do_setup(int argc, char *argv[])
        }

        if (!!tst_test->needs_rofs + !!tst_test->needs_devfs +
-           !!tst_test->needs_device > 1) {
+           !!tst_test->needs_device + !!tst_test->needs_hugetlbfs > 1) {
                tst_brk(TBROK,
-                       "Two or more of needs_{rofs, devfs, device} are
set");
+                       "Two or more of needs_{rofs, devfs, device,
hugetlb} are set");
        }


        if (tst_test->needs_device && !mntpoint_mounted) {
>                 tdev.dev = tst_acquire_device_(NULL,
> tst_test->dev_min_size);


> @@ -1299,8 +1337,15 @@ static void do_cleanup(void)
>         if (ovl_mounted)
>                 SAFE_UMOUNT(OVL_MNT);
>
> -       if (mntpoint_mounted)
> -               tst_umount(tst_test->mntpoint);
> +       if (tst_hugetlb_fd >= 0)
> +               SAFE_CLOSE(tst_hugetlb_fd);
> +
> +       if (mntpoint_mounted) {
> +               if (tst_test->needs_hugetlbfs)
> +                       SAFE_UMOUNT(tst_test->mntpoint);
> +               else
> +                       tst_umount(tst_test->mntpoint);
> +       }
>
>         if (tst_test->needs_device && tdev.dev)
>                 tst_release_device(tdev.dev);
> --
> 2.31.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000002f5d9405ec4c5d38
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hi=
=C2=A0Tarun,</div><div class=3D"gmail_default" style=3D"font-size:small"><b=
r></div><div class=3D"gmail_default" style=3D"font-size:small">This version=
=C2=A0is much=C2=A0better, comments are inline below.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Oct 29, 2022=
 at 3:14 PM Tarun Sahu &lt;<a href=3D"mailto:tsahu@linux.ibm.com" target=3D=
"_blank">tsahu@linux.ibm.com</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Most of libhugetlbfs test require mounted huget=
lbfs and random opened<br>
unlinked file for follow-up test actions.<br>
<br>
Here, this patch adds two new field in tst_test struct(include/tst_test.h)<=
br>
which user can set if the test requires mounted hugetlbfs and other one<br>
for if test requires opened unlinked file.<br>
<br>
Signed-off-by: Tarun Sahu &lt;<a href=3D"mailto:tsahu@linux.ibm.com" target=
=3D"_blank">tsahu@linux.ibm.com</a>&gt;<br>
---<br>
=C2=A0include/tst_test.h | 20 +++++++++++++++++-<br>
=C2=A0lib/tst_test.c=C2=A0 =C2=A0 =C2=A0| 51 ++++++++++++++++++++++++++++++=
+++++++++++++---<br>
=C2=A02 files changed, 67 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/include/tst_test.h b/include/tst_test.h<br>
index a69965b95..f36382ae9 100644<br>
--- a/include/tst_test.h<br>
+++ b/include/tst_test.h<br>
@@ -131,7 +131,7 @@ struct tst_tag {<br>
=C2=A0};<br>
<br>
=C2=A0extern unsigned int tst_variant;<br>
-<br>
+extern int tst_hugetlb_fd;<br>
=C2=A0#define TST_NO_HUGEPAGES ((unsigned long)-1)<br>
<br>
=C2=A0#define TST_UNLIMITED_RUNTIME (-1)<br>
@@ -176,6 +176,18 @@ struct tst_test {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int all_filesystems:1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int skip_in_lockdown:1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int skip_in_compat:1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If set, the test function will create a huge=
tlbfs mount point<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * at /tmp/xxxxxx, where xxxxxx is a random str=
ing.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int needs_hugetlbfs:1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If set, the test function will create and op=
en a random file<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * under mounted hugetlbfs. To use this option,=
 needs_hugetlbfs must<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * be set. The file descriptior will be set in =
tst_hugetlb_fd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * The close(tst_hugetlb_fd) will be called on =
test exit(cleanup).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int needs_unlinked_hugetlb_file:1;<br></blockqu=
ote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:sma=
ll">Why not consider encapsulating=C2=A0these two new fields in &#39;struct=
 tst_hugepage&#39; ?</div><div class=3D"gmail_default" style=3D"font-size:s=
mall"><br></div><div class=3D"gmail_default" style=3D"font-size:small">Then=
 the tst_test in the case can simply initialize to:</div><div class=3D"gmai=
l_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default"=
 style=3D"font-size:small">....</div><div class=3D"gmail_default" style=3D"=
font-size:small">static struct tst_test test =3D {<br>=C2=A0 =C2=A0 .needs_=
root =3D 1,<br>=C2=A0 =C2=A0 .taint_check =3D TST_TAINT_D | TST_TAINT_W,<br=
>=C2=A0 =C2=A0 .setup =3D setup,<br>=C2=A0 =C2=A0 .test_all =3D run_test,<b=
r>=C2=A0 =C2=A0 .hugepages =3D {1, TST_NEEDS, 1, 1},<br>};<br></div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* The skip_filesystems is a NULL terminat=
ed list of filesystems the<br>
@@ -357,6 +369,12 @@ unsigned int tst_remaining_runtime(void);<br>
=C2=A0 */<br>
=C2=A0void tst_set_max_runtime(int max_runtime);<br>
<br>
+/*<br>
+ * Create and open a random file inside the given dir path.<br>
+ * It unlinks the file after opening and return file descriptor.<br>
+ */<br>
+int tst_create_unlinked_file(const char *path);<br></blockquote><div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-size:small">what about=
 renaming this function to tst_&#39;get|create&#39;_unlinked_file_fd?</div>=
<div class=3D"gmail_default" style=3D"font-size:small">I guess the &#39;fd&=
#39; part should be emphasized here.</div><br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0/*<br>
=C2=A0 * Returns path to the test temporary directory in a newly allocated =
buffer.<br>
=C2=A0 */<br>
diff --git a/lib/tst_test.c b/lib/tst_test.c<br>
index 8ccde1629..43cba1004 100644<br>
--- a/lib/tst_test.c<br>
+++ b/lib/tst_test.c<br>
@@ -925,7 +925,8 @@ static int needs_tmpdir(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_test-&gt;needs_d=
evice ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_test-&gt;mntpoin=
t ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_test-&gt;resourc=
e_files ||<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_test-&gt;needs_checkp=
oints;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_test-&gt;needs_checkp=
oints ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_test-&g=
t;needs_hugetlbfs;<br>
=C2=A0}<br>
<br>
=C2=A0static void copy_resources(void)<br>
@@ -1021,6 +1022,30 @@ static void prepare_and_mount_dev_fs(const char *mnt=
point)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
+static void prepare_and_mount_hugetlb_fs(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_test-&gt;mntpoint =3D tst_get_tmpdir();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MOUNT(&quot;none&quot;, tst_test-&gt;mntpo=
int, &quot;hugetlbfs&quot;, 0, NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mntpoint_mounted =3D 1;<br>
+}<br>
+<br>
+int tst_create_unlinked_file(const char *path)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char template[PATH_MAX];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(template, PATH_MAX, &quot;%s/ltp_%.3sX=
XXXXX&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0path, TCID);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D mkstemp(template);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TBROK | TER=
RNO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;%s: mkstemp(%s) failed&quot;, __func__, template);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_UNLINK(template);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return fd;<br>
+}<br>
+<br>
=C2=A0static const char *limit_tmpfs_mount_size(const char *mnt_data,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf, size_t b=
uf_size, const char *fs_type)<br>
=C2=A0{<br>
@@ -1094,6 +1119,8 @@ static void do_cgroup_requires(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_cg_init();<br>
=C2=A0}<br>
<br>
+int tst_hugetlb_fd =3D -1;<br>
+<br>
=C2=A0static void do_setup(int argc, char *argv[])<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tst_test)<br>
@@ -1217,6 +1244,17 @@ static void do_setup(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_test-&gt;needs_hugetlbfs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prepare_and_mount_h=
ugetlb_fs();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_test-&gt;needs_unlinked_hugetlb_file) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(tst_test-&gt;=
needs_hugetlbfs)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_brk(TBROK, &quot;Option needs_unlinked_hugetlb_file &quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;req=
uires option needs_hugetlbfs&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_hugetlb_fd =3D =
tst_create_unlinked_file(tst_test-&gt;mntpoint);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font=
-size:small">Seems we have to add a confliction check[1] to avoid multiple =
mounting</div><div class=3D"gmail_default" style=3D"font-size:small">at &#3=
9;tst_test-&gt;mntpoint&#39;. Or maybe go another method to move all the hu=
getlbfs</div><div class=3D"gmail_default" style=3D"font-size:small">operati=
ons into tst_hugetlb.c to isolate details from the tst_test library, but</d=
iv><div class=3D"gmail_default" style=3D"font-size:small">this will require=
 more changes for all preexisting hugetlb tests.</div><div class=3D"gmail_d=
efault" style=3D"font-size:small"><br></div><div class=3D"gmail_default" st=
yle=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"fon=
t-size:small">[1] something like this:</div><div><br></div><div class=3D"gm=
ail_default">@@ -1224,9 +1224,9 @@ static void do_setup(int argc, char *arg=
v[])</div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 if (!!tst_test-&gt;needs_rofs + !!tst_test-&gt;needs_devfs +<br>- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!tst_test-&gt;needs_device &gt; 1) {<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !!tst_test-&gt;needs_device + !!tst_t=
est-&gt;needs_hugetlbfs &gt; 1) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 tst_brk(TBROK,<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Two or more of needs_{rofs,=
 devfs, device} are set&quot;);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Two or more of needs_{rofs, de=
vfs, device, hugetlb} are set&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br><=
div class=3D"gmail_default"><br></div><div class=3D"gmail_default"><br></di=
v><div class=3D"gmail_default" style=3D"font-size:small"></div><div class=
=3D"gmail_default" style=3D"font-size:small"></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tst_test-&gt;needs_device &amp;&amp; !mntpo=
int_mounted) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://t=
dev.dev" rel=3D"noreferrer" target=3D"_blank">tdev.dev</a> =3D tst_acquire_=
device_(NULL, tst_test-&gt;dev_min_size);</blockquote><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
<br>
@@ -1299,8 +1337,15 @@ static void do_cleanup(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ovl_mounted)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_UMOUNT(OVL_MNT=
);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mntpoint_mounted)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_umount(tst_test=
-&gt;mntpoint);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_hugetlb_fd &gt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CLOSE(tst_huge=
tlb_fd);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (mntpoint_mounted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_test-&gt;ne=
eds_hugetlbfs)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SAFE_UMOUNT(tst_test-&gt;mntpoint);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_umount(tst_test-&gt;mntpoint);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tst_test-&gt;needs_device &amp;&amp; <a hre=
f=3D"http://tdev.dev" rel=3D"noreferrer" target=3D"_blank">tdev.dev</a>)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_release_device(=
<a href=3D"http://tdev.dev" rel=3D"noreferrer" target=3D"_blank">tdev.dev</=
a>);<br>
-- <br>
2.31.1<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--0000000000002f5d9405ec4c5d38--


--===============0899280955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0899280955==--

