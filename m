Return-Path: <SRS0=7mwu=OQ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7EFAC433F5
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 07:40:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21E2060FDA
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 07:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21E2060FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D97F3C8DFB
	for <ltp@archiver.kernel.org>; Sun, 26 Sep 2021 09:40:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12AA53C7445
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 09:39:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8143F1CA5D3A
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 09:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632641989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/hFGcdxi7ZgvJBxIVGoql5kqdzcVL+/4Xu2O9hNots4=;
 b=LNlpXERCBwX3P0YutRztEcyuuVgIGIJwAvIf0lZmAdZeQPn3KvPBSmaoDuhGJNw8U/hAHE
 WDNoWuCQec2titkYBjFShHPfuYyd+CAhrJAMO57PftV1Ov8W8KosJKqkuH30DHYE1v2S7x
 jHPBchbVGTFijQ+Xjq6O1kkAXn2QTf4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-DgSGENIWMyWWEOJed_bVJQ-1; Sun, 26 Sep 2021 03:39:48 -0400
X-MC-Unique: DgSGENIWMyWWEOJed_bVJQ-1
Received: by mail-yb1-f197.google.com with SMTP id
 m16-20020a25d410000000b005ab243aaaf4so10120044ybf.20
 for <ltp@lists.linux.it>; Sun, 26 Sep 2021 00:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/hFGcdxi7ZgvJBxIVGoql5kqdzcVL+/4Xu2O9hNots4=;
 b=irPJ4QCMHyONyrOVsiP5ksoCc51ItklV6rgRsNfDf+jT9Q08qaNOx/ciX5rqpREuHM
 qHpBexgpchvbdLANrjjgiZ50K+HA0/33MykKUBj6xFW+7m/Vk/6jfQJNREP5DO5Wonif
 Zo9UjR0EOb57S613MGB2sZqUr803v/TCQbgKAKi4DH99HodX7s7uufpC2lVKXIYFYWLk
 m0c5yGyugVLO0yp8+zXO9NfzWQof76tjRJr03wyuNuPd/H8IBv7sW9cDs+gvXGNADdbl
 KobRCQyteAg0XCIGlZL+vFYggveXuZDzbHwe3hg7sDll+zzhtJl7UVXm16zj0M6CdRQ1
 EEBg==
X-Gm-Message-State: AOAM532iX9fuPAse+WehzTj9ZZ3CJVfquz2frNGGVGqEd+CqhTnV41Qi
 xJposMUiyZldJB8RKiNV3Y0KHyMKwvEIv5HA9gz+72dStn4pAU9/7axVZkYtVibzy/sSJzNByGx
 la3IwPus+XECNQdNBwmL/BIYTUTQ=
X-Received: by 2002:a25:42c9:: with SMTP id p192mr6825358yba.339.1632641987713; 
 Sun, 26 Sep 2021 00:39:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFq9/kxKTGFuvNea7NgKVfI1dvYJ28O0pD9yPVozIWDmIV1JgPwPtx2asQ3w5tmzySIpXXlDj8q4M9bSNe/Wo=
X-Received: by 2002:a25:42c9:: with SMTP id p192mr6825340yba.339.1632641987513; 
 Sun, 26 Sep 2021 00:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <YUrnljqYd5Hx/fi+@yuki>
 <CAEemH2dDRT-iQPH0a-Aip8OZDUpp2Z3_x4dgVBEg4tv_pyWvfw@mail.gmail.com>
 <YUr9676LXNi0xMs6@yuki>
 <CAEemH2c37Qx6uEG40utX8pGC2Gp0ZLtT_z194L4RVNm6N2CefQ@mail.gmail.com>
 <YUs+jf35Zqp8GjJl@yuki> <20210922165218.GA3081072@maple.netwinder.org>
 <YUyQMBLPbCs4/Gur@yuki> <20210924014900.GA3975163@maple.netwinder.org>
 <CAEemH2diTBrnYAbBedQN+bog6y4NdLZG628egCqxuopZ7DHB0Q@mail.gmail.com>
 <20210924151130.GA4029248@maple.netwinder.org> <YU4YOI4yPufWP9uC@yuki>
In-Reply-To: <YU4YOI4yPufWP9uC@yuki>
From: Li Wang <liwang@redhat.com>
Date: Sun, 26 Sep 2021 15:39:35 +0800
Message-ID: <CAEemH2e7LpOgVfNXXthovR4xt4aHYkTLCW+j4OsGoHegta+-uQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] fallocate05: increase the fallocate and
 defallocate size
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
Content-Type: multipart/mixed; boundary="===============0242564915=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0242564915==
Content-Type: multipart/alternative; boundary="000000000000b6286f05cce11559"

--000000000000b6286f05cce11559
Content-Type: text/plain; charset="UTF-8"

On Sat, Sep 25, 2021 at 2:25 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > >That's weird.
> > >
> > >What about the testing result with unlimit the tmpfs size?
> >
> > With the .dev_min_size field set to zero, it still causes OOM. Looking
> > at the test output, it seems to use 256MB in this case:
>

With .dev_min_size==0 the test lib will choose default size 256MB for
instead.

However, unlimit tmpfs-size does not mean set .dev_min_size to zero.
It should be returned mnt_data directly in limit_tmpfs_mount_size.
That also does the 20210524 version.

e.g.

--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -892,6 +892,8 @@ static void prepare_and_mount_dev_fs(const char
*mntpoint)
 static const char *limit_tmpfs_mount_size(const char *mnt_data,
                char *buf, size_t buf_size, const char *fs_type)
 {
+       return mnt_data;
+
        if (strcmp(fs_type, "tmpfs"))
                return mnt_data;



> >
> > tst_test.c:1421: TINFO: Testing on tmpfs
> > tst_test.c:922: TINFO: Skipping mkfs for TMPFS filesystem
> > tst_test.c:903: TINFO: Limiting tmpfs size to 256MB
> > tst_test.c:1353: TINFO: Timeout per run is 0h 15m 00s
> > tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183
> > tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086
> > tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177
> > tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315
> > tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993
> > tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935
> > tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786
> > tcf-agent invoked oom-killer: gfp_mask=0x100cca(GFP_HIGHUSER_MOVABLE),
> order=0, oom_score_adj=0
> > [...]
> > Mem-Info:
> > active_anon:229 inactive_anon:44809 isolated_anon:0
> >   active_file:7 inactive_file:4 isolated_file:0
> >   unevictable:0 dirty:0 writeback:0
> >   slab_reclaimable:1205 slab_unreclaimable:3757
> >   mapped:334 shmem:42064 pagetables:226 bounce:0
> >   free:1004 free_pcp:0 free_cma:0
> > Node 0 active_anon:916kB inactive_anon:179236kB active_file:28kB
> inactive_file:88kB unevictable:0kB isolated(anon):0kB isolated(file) :0kB
> mapped:1336kB dirty:0kB writeback:0kB shmem:168256kB writeback_tmp:0kB
> kernel_stack:1016kB all_unreclaimable? no
> > Normal free:3776kB min:1872kB low:2340kB high:2808kB
> > reserved_highatomic:0KB active_anon:916kB inactive_anon:179236kB
> active_file:28k B inactive_file:16kB unevictable:0kB writepending:0kB
> present:262144kB managed:220688kB mlocked:0kB pagetables:904kB bounce:0kB
> free_pcp:224kB local_pcp:0kB free_cma:0kB
> > lowmem_reserve[]: 0 0 0
> > Normal: 1*4kB (M) 1*8kB (M) 22*16kB (U) 35*32kB (UE) 16*64kB (UE)
> 9*128kB (UE) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0* 16384kB
> = 3660kB
> > 42138 total pagecache pages
>
> That is strange, for me the tmpfs starts to return ENOSPC when the
> system is getting low on memory.
>

Maybe he enabled some OOM kernel options you didn't.
Or, some other configuration we don't know.


-- 
Regards,
Li Wang

--000000000000b6286f05cce11559
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Sat, Sep 25, 2021 at 2:25 AM Cyril Hrubis &lt;<a=
 href=3D"mailto:chrubis@suse.cz">chrubis@suse.cz</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
&gt; &gt;That&#39;s weird.<br>
&gt; &gt;<br>
&gt; &gt;What about the testing result with unlimit the tmpfs size?<br>
&gt; <br>
&gt; With the .dev_min_size field set to zero, it still causes OOM. Looking=
 <br>
&gt; at the test output, it seems to use 256MB in this case:<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">With .dev_min_size=3D=3D0 the test lib will choose default size 256MB for=
 instead.</div><div class=3D"gmail_default" style=3D"font-size:small"><br><=
/div><div class=3D"gmail_default" style=3D"font-size:small">However, unlimi=
t tmpfs-size does not mean set .dev_min_size to zero.=C2=A0<br></div><div c=
lass=3D"gmail_default">It should be returned mnt_data directly in limit_tmp=
fs_mount_size.</div><div class=3D"gmail_default" style=3D"font-size:small">=
That also does the 20210524 version.</div></div><div class=3D"gmail_default=
" style=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D=
"font-size:small">e.g.</div><div class=3D"gmail_default" style=3D"font-size=
:small"><br></div><div class=3D"gmail_default" style=3D"font-size:small">--=
- a/lib/tst_test.c<br>+++ b/lib/tst_test.c<br>@@ -892,6 +892,8 @@ static vo=
id prepare_and_mount_dev_fs(const char *mntpoint)<br>=C2=A0static const cha=
r *limit_tmpfs_mount_size(const char *mnt_data,<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf, size_t buf_size, const char *fs_=
type)<br>=C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 return mnt_data;<br>+<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (strcmp(fs_type, &quot;tmpfs&quot;))<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return mnt_data;<br></div><di=
v><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
&gt; <br>
&gt; tst_test.c:1421: TINFO: Testing on tmpfs<br>
&gt; tst_test.c:922: TINFO: Skipping mkfs for TMPFS filesystem<br>
&gt; tst_test.c:903: TINFO: Limiting tmpfs size to 256MB<br>
&gt; tst_test.c:1353: TINFO: Timeout per run is 0h 15m 00s<br>
&gt; tst_fill_fs.c:32: TINFO: Creating file mntpoint/file0 size 21710183<br=
>
&gt; tst_fill_fs.c:32: TINFO: Creating file mntpoint/file1 size 8070086<br>
&gt; tst_fill_fs.c:32: TINFO: Creating file mntpoint/file2 size 3971177<br>
&gt; tst_fill_fs.c:32: TINFO: Creating file mntpoint/file3 size 36915315<br=
>
&gt; tst_fill_fs.c:32: TINFO: Creating file mntpoint/file4 size 70310993<br=
>
&gt; tst_fill_fs.c:32: TINFO: Creating file mntpoint/file5 size 4807935<br>
&gt; tst_fill_fs.c:32: TINFO: Creating file mntpoint/file6 size 90739786<br=
>
&gt; tcf-agent invoked oom-killer: gfp_mask=3D0x100cca(GFP_HIGHUSER_MOVABLE=
), order=3D0, oom_score_adj=3D0<br>
&gt; [...]<br>
&gt; Mem-Info:<br>
&gt; active_anon:229 inactive_anon:44809 isolated_anon:0<br>
&gt;=C2=A0 =C2=A0active_file:7 inactive_file:4 isolated_file:0<br>
&gt;=C2=A0 =C2=A0unevictable:0 dirty:0 writeback:0<br>
&gt;=C2=A0 =C2=A0slab_reclaimable:1205 slab_unreclaimable:3757<br>
&gt;=C2=A0 =C2=A0mapped:334 shmem:42064 pagetables:226 bounce:0<br>
&gt;=C2=A0 =C2=A0free:1004 free_pcp:0 free_cma:0<br>
&gt; Node 0 active_anon:916kB inactive_anon:179236kB active_file:28kB inact=
ive_file:88kB unevictable:0kB isolated(anon):0kB isolated(file) :0kB mapped=
:1336kB dirty:0kB writeback:0kB shmem:168256kB writeback_tmp:0kB kernel_sta=
ck:1016kB all_unreclaimable? no<br>
&gt; Normal free:3776kB min:1872kB low:2340kB high:2808kB <br>
&gt; reserved_highatomic:0KB active_anon:916kB inactive_anon:179236kB activ=
e_file:28k B inactive_file:16kB unevictable:0kB writepending:0kB present:26=
2144kB managed:220688kB mlocked:0kB pagetables:904kB bounce:0kB free_pcp:22=
4kB local_pcp:0kB free_cma:0kB<br>
&gt; lowmem_reserve[]: 0 0 0<br>
&gt; Normal: 1*4kB (M) 1*8kB (M) 22*16kB (U) 35*32kB (UE) 16*64kB (UE) 9*12=
8kB (UE) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB 0*8192kB 0* 16384kB =3D=
 3660kB<br>
&gt; 42138 total pagecache pages<br>
<br>
That is strange, for me the tmpfs starts to return ENOSPC when the<br>
system is getting low on memory.<br></blockquote><div><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">Maybe he enabled some OOM kern=
el options you didn&#39;t.</div><div class=3D"gmail_default" style=3D"font-=
size:small">Or, some other configuration we don&#39;t know.</div><div class=
=3D"gmail_default" style=3D"font-size:small"><br></div></div><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Re=
gards,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000b6286f05cce11559--


--===============0242564915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0242564915==--

