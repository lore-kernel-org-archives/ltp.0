Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9CBC54EE9
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 04:17:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B31E03CAD53
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 06:17:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B07F13C8942
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 06:17:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3BF741A0117B
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 06:17:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663820227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8xWVR9N0Oq4VxQS8aJ9RHzB5VWk4wrPOwOVMwvxjxU=;
 b=Z0fsVV/UYMfI0mf3mJkwo2U1a4uMjlEP1+yiY5LIvkw7fiS24bTdyrLTPzBHiMMrDPZCPj
 CINvud21oILgrx+B2ZCZGqCBDvAzDD15RKwLZ2Zpcflu7SgyVYzW8ACX0iZ+iBvz/8UmIy
 tlhoMoJ5tkkS8CHWLE8vTi5lTsttpq0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-126-2kyd74zzPAGvN9ZJxIbPkg-1; Thu, 22 Sep 2022 00:17:06 -0400
X-MC-Unique: 2kyd74zzPAGvN9ZJxIbPkg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5-20020a05600c028500b003b4d2247d3eso2236763wmk.0
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 21:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=I8xWVR9N0Oq4VxQS8aJ9RHzB5VWk4wrPOwOVMwvxjxU=;
 b=THWgybkTPVjx7b6RVmc933QSu88/odEKvbDDc0PJx2OyfCZL8XS/Rpwj6/yqinmMPm
 JxFQuMfWgPrsYEjx8bU/V/Rk0aec+z1xFvYUVHGj3F7APOmNuD76uclXcuzK4JV0yUrD
 6NoaBrQw78628h/IoLIfYk1T3lap2UQ34Lu4lQoZSw7ABOWPuGO9heuhGvj6tA/o2pnR
 NcOknaqUNFtxf+mTN7Oe38gT9Rrb05NNqCJYV7iJ1Zu04vabd00ussvrGTLf/4Xas1hZ
 SZLeUw0x7bwt6xwJGaMv61hjlSx0Bgqnpx6kiay06umfvkbnadIpKxgHpjbRRG7e1mW8
 K59g==
X-Gm-Message-State: ACrzQf2SzOxWQf8g8yj1CVJlTwYsV4XQmbR9Ec39i3emb+selfW9O55P
 h53iYFM2l3ViXXBgV8QpBpAP2mr+Mb7y3UT6Rja3BX7iy0d8EbBVNBVxY7NyJO3bZ9N5rHaCuXG
 pzCNnFFx2SMgkkO8JI5q2q5x/MXQ=
X-Received: by 2002:a7b:c848:0:b0:3b4:73f4:2320 with SMTP id
 c8-20020a7bc848000000b003b473f42320mr824585wml.124.1663820224111; 
 Wed, 21 Sep 2022 21:17:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7C2CbwxjTGvIzgvPDPRTFseBNDLwddpDCDd90nd7uZuWMKjx33qJtxh/UHWQtz7fSGlSavfZxbqC50YGgycog=
X-Received: by 2002:a7b:c848:0:b0:3b4:73f4:2320 with SMTP id
 c8-20020a7bc848000000b003b473f42320mr824580wml.124.1663820223894; Wed, 21 Sep
 2022 21:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220921155006.13360-1-mdoucha@suse.cz>
In-Reply-To: <20220921155006.13360-1-mdoucha@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Sep 2022 12:16:52 +0800
Message-ID: <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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
Content-Type: multipart/mixed; boundary="===============0202663496=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0202663496==
Content-Type: multipart/alternative; boundary="0000000000006a6ea905e93c55c4"

--0000000000006a6ea905e93c55c4
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 21, 2022 at 11:50 PM Martin Doucha <mdoucha@suse.cz> wrote:

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>
> Implement tst_supported_fs feature suggested by pvorel in his patch:
> tst_test.sh: Fix filesystem support detection
>
> Although the tst_fs_type_name() functions could use some improvements,
> e.g. ext4 must be specified in skiplist as "ext2/ext3/ext4" to get properly
>

Yes, that's true, we need to make it keep consistent with two
skipping ways. Otherwise below test output "ext2/ext3/ext4"
looks like a bit mess to remember.

Better going with a single FS for matching (i.e. "ext4" for both fs_type
and '-d path').
But we can solve this in a separate patch later.

$ df -T . | tail -1 | awk '{print $2}'
ext4

$ ./tst_supported_fs -s "ext4" ext4
tst_supported_fs.c:135: TCONF: ext4 is skipped
$ echo $?
32

$ ./tst_supported_fs -s "ext4" -d .
tst_supported_fs.c:137: TINFO: ext2/ext3/ext4 is not skipped
$ echo $?
0

$ ./tst_supported_fs -s "ext2/ext3/ext4" -d .
tst_supported_fs.c:135: TCONF: ext2/ext3/ext4 is skipped
$ echo $?
32



> skipped and vfat is missing from the list of known filesystems.
>
>  testcases/lib/tst_supported_fs.c | 49 ++++++++++++++++++++++++++------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/testcases/lib/tst_supported_fs.c
> b/testcases/lib/tst_supported_fs.c
> index 70d4d38c7..5873d0ba1 100644
> --- a/testcases/lib/tst_supported_fs.c
> +++ b/testcases/lib/tst_supported_fs.c
> @@ -32,9 +32,13 @@ static void usage(void)
>         fprintf(stderr, "tst_supported_fs -s skip_list fs_type\n");
>         fprintf(stderr, "   if fs_type is in skip_list, return 1 otherwise
> return 0\n\n");
>
> +       fprintf(stderr, "tst_supported_fs -s skip_list -d path\n");
> +       fprintf(stderr, "   if filesystem mounted on path is in skip_list,
> return 1 otherwise return 0\n\n");

+
>         fprintf(stderr, "fs_type - a specified filesystem type\n");
>         fprintf(stderr, "skip_list - filesystems to skip, delimiter:
> '%c'\n",
>                         SKIP_DELIMITER);
> +       fprintf(stderr, "path - any valid file or directory\n");
>  }
>
>  static char **parse_skiplist(char *fs)
> @@ -62,10 +66,11 @@ static char **parse_skiplist(char *fs)
>  int main(int argc, char *argv[])
>  {
>         const char *const *filesystems;
> +       const char *fsname = NULL;
>         int i, ret;
>         char **skiplist = NULL;
>
> -       while ((ret = getopt(argc, argv, "hs:"))) {
> +       while ((ret = getopt(argc, argv, "hs:d:"))) {
>                 if (ret < 0)
>                         break;
>
> @@ -83,9 +88,26 @@ int main(int argc, char *argv[])
>                         if (!skiplist)
>                                 return 1;
>                         break;
> +
> +               case 'd':
> +                       if (fsname) {
> +                               fprintf(stderr,
> +                                       "Can't specify multiple paths\n");
> +                               usage();
> +                               return 2;
> +                       }
> +
> +                       fsname = tst_fs_type_name(tst_fs_type(optarg));
> +                       break;
>                 }
>         }
>
> +       if (fsname && !skiplist) {
> +               fprintf(stderr, "Parameter -d requires skiplist\n");
> +               usage();
> +               return 2;
> +       }
> +
>         if (argc - optind > 1) {
>                 fprintf(stderr, "Can't specify multiple fs_type\n");
>                 usage();
> @@ -94,22 +116,33 @@ int main(int argc, char *argv[])
>
>         /* fs_type */
>         if (optind < argc) {
> -               if (argv[optind][0] == '\0')
> +               if (fsname) {
> +                       fprintf(stderr, "Can't specify fs_type and -d
> together\n");
> +                       usage();
> +                       return 2;
> +
> +               }
> +
> +               fsname = argv[optind];
> +       }
> +
> +       if (fsname) {
> +               if (fsname[0] == '\0')
>                         tst_brk(TCONF, "fs_type is empty");
>
>                 if (skiplist) {
> -                       if (tst_fs_in_skiplist(argv[optind], (const char *
> const*)skiplist))
> -                               tst_brk(TCONF, "%s is skipped",
> argv[optind]);
> +                       if (tst_fs_in_skiplist(fsname, (const char *
> const*)skiplist))
> +                               tst_brk(TCONF, "%s is skipped", fsname);
>

TCONF does not means return 1, we might need explicitly 'return 1' here.


                        else
> -                               tst_res(TINFO, "%s is not skipped",
> argv[optind]);
> +                               tst_res(TINFO, "%s is not skipped",
> fsname);
>
>                         return 0;
>                 }
>
> -               if (tst_fs_is_supported(argv[optind]) ==
> TST_FS_UNSUPPORTED)
> -                       tst_brk(TCONF, "%s is not supported",
> argv[optind]);
> +               if (tst_fs_is_supported(fsname) == TST_FS_UNSUPPORTED)
> +                       tst_brk(TCONF, "%s is not supported", fsname);
>

Same here.



>                 else
> -                       tst_res(TINFO, "%s is supported", argv[optind]);
> +                       tst_res(TINFO, "%s is supported", fsname);
>
>                 return 0;
>         }
> --
> 2.37.3
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang

--0000000000006a6ea905e93c55c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Sep 21, 2022 at 11:50 PM Martin Doucha &lt;=
<a href=3D"mailto:mdoucha@suse.cz" target=3D"_blank">mdoucha@suse.cz</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Signed-=
off-by: Martin Doucha &lt;<a href=3D"mailto:mdoucha@suse.cz" target=3D"_bla=
nk">mdoucha@suse.cz</a>&gt;<br>
---<br>
<br>
Implement tst_supported_fs feature suggested by pvorel in his patch:<br>
tst_test.sh: Fix filesystem support detection<br>
<br>
Although the tst_fs_type_name() functions could use some improvements,<br>
e.g. ext4 must be specified in skiplist as &quot;ext2/ext3/ext4&quot; to ge=
t properly<br></blockquote><div><br></div><div><div class=3D"gmail_default"=
 style=3D"font-size:small">Yes, that&#39;s true, we need to make it keep co=
nsistent with two</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">skipping=C2=A0ways. Otherwise=C2=A0below test output &quot;ext2/ext3/ext=
4&quot;</div><div class=3D"gmail_default" style=3D"font-size:small">looks l=
ike a bit mess to remember.</div><div class=3D"gmail_default" style=3D"font=
-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:smal=
l">Better going with a single FS for matching (i.e. &quot;ext4&quot; for bo=
th fs_type and &#39;-d path&#39;).</div><div class=3D"gmail_default" style=
=3D"font-size:small">But we can solve this in a separate patch later.<br></=
div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div c=
lass=3D"gmail_default" style=3D"font-size:small">$ df -T . | tail -1 | awk =
&#39;{print $2}&#39;<br>ext4<br></div><div class=3D"gmail_default" style=3D=
"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size=
:small">$ ./tst_supported_fs -s &quot;ext4&quot; ext4<br>tst_supported_fs.c=
:135: TCONF: ext4 is skipped<br>$ echo $?<br>32<br><br></div><div class=3D"=
gmail_default" style=3D"font-size:small">$ ./tst_supported_fs -s &quot;ext4=
&quot; -d .<br>tst_supported_fs.c:137: TINFO: ext2/ext3/ext4 is not skipped=
</div><div class=3D"gmail_default" style=3D"font-size:small">$ echo $?<br>0=
<br></div><div class=3D"gmail_default" style=3D"font-size:small"><br></div>=
<div class=3D"gmail_default" style=3D"font-size:small">$ ./tst_supported_fs=
 -s &quot;ext2/ext3/ext4&quot; -d .<br>tst_supported_fs.c:135: TCONF: ext2/=
ext3/ext4 is skipped<br></div><div class=3D"gmail_default" style=3D"font-si=
ze:small">$ echo $?</div>32<br><div class=3D"gmail_default" style=3D"font-s=
ize:small"></div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
skipped and vfat is missing from the list of known filesystems.<br>
<br>
=C2=A0testcases/lib/tst_supported_fs.c | 49 ++++++++++++++++++++++++++-----=
-<br>
=C2=A01 file changed, 41 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported=
_fs.c<br>
index 70d4d38c7..5873d0ba1 100644<br>
--- a/testcases/lib/tst_supported_fs.c<br>
+++ b/testcases/lib/tst_supported_fs.c<br>
@@ -32,9 +32,13 @@ static void usage(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;tst_supported_fs -s skip_=
list fs_type\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;=C2=A0 =C2=A0if fs_type i=
s in skip_list, return 1 otherwise return 0\n\n&quot;);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;tst_supported_fs -s skip_=
list -d path\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;=C2=A0 =C2=A0if filesyste=
m mounted on path is in skip_list, return 1 otherwise return 0\n\n&quot;);<=
/blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;fs_type - a specified fil=
esystem type\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;skip_list - filesystems t=
o skip, delimiter: &#39;%c&#39;\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 SKIP_DELIMITER);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;path - any valid file or =
directory\n&quot;);<br>
=C2=A0}<br>
<br>
=C2=A0static char **parse_skiplist(char *fs)<br>
@@ -62,10 +66,11 @@ static char **parse_skiplist(char *fs)<br>
=C2=A0int main(int argc, char *argv[])<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *const *filesystems;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *fsname =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int i, ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 char **skiplist =3D NULL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while ((ret =3D getopt(argc, argv, &quot;hs:&qu=
ot;))) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0while ((ret =3D getopt(argc, argv, &quot;hs:d:&=
quot;))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
<br>
@@ -83,9 +88,26 @@ int main(int argc, char *argv[])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (!skiplist)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;d&#39;:<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (fsname) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Can=
&#39;t specify multiple paths\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fsname =3D tst_fs_type_name(tst_fs_type(optarg));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fsname &amp;&amp; !skiplist) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &qu=
ot;Parameter -d requires skiplist\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0usage();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (argc - optind &gt; 1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &qu=
ot;Can&#39;t specify multiple fs_type\n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage();<br>
@@ -94,22 +116,33 @@ int main(int argc, char *argv[])<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* fs_type */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (optind &lt; argc) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (argv[optind][0]=
 =3D=3D &#39;\0&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fsname) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0fprintf(stderr, &quot;Can&#39;t specify fs_type and -d together\n=
&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0usage();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 2;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fsname =3D argv[opt=
ind];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fsname) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fsname[0] =3D=
=3D &#39;\0&#39;)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 tst_brk(TCONF, &quot;fs_type is empty&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (skiplist) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (tst_fs_in_skiplist(argv[optind], (const char * const*)skiplis=
t))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF, &quot;%s is skipped&qu=
ot;, argv[optind]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (tst_fs_in_skiplist(fsname, (const char * const*)skiplist))<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF, &quot;%s is skipped&qu=
ot;, fsname);<br></blockquote><div><br></div><div class=3D"gmail_default" s=
tyle=3D"font-size:small">TCONF does not means return 1, we might need expli=
citly &#39;return 1&#39; here.</div><div></div><div class=3D"gmail_default"=
 style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"=
font-size:small"><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;%s is not skippe=
d&quot;, argv[optind]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quot;%s is not skippe=
d&quot;, fsname);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_fs_is_suppo=
rted(argv[optind]) =3D=3D TST_FS_UNSUPPORTED)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_brk(TCONF, &quot;%s is not supported&quot;, argv[optind]);<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_fs_is_suppo=
rted(fsname) =3D=3D TST_FS_UNSUPPORTED)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_brk(TCONF, &quot;%s is not supported&quot;, fsname);<br></blo=
ckquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-size=
:small">Same here.</div><div class=3D"gmail_default" style=3D"font-size:sma=
ll"><br></div><div class=3D"gmail_default" style=3D"font-size:small">=C2=A0=
<br></div></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TINFO, &quot;%s is supported&quot;, argv[optind]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0tst_res(TINFO, &quot;%s is supported&quot;, fsname);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-- <br>
2.37.3<br>
<br>
<br>
-- <br>
Mailing list info: <a href=3D"https://lists.linux.it/listinfo/ltp" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.linux.it/listinfo/ltp</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
><div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div>=
</div>

--0000000000006a6ea905e93c55c4--


--===============0202663496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0202663496==--

