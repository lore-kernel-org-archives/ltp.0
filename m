Return-Path: <SRS0=SXDC=PJ=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26A4C433F5
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 07:21:57 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1A160F5D
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 07:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BB1A160F5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28A733C5531
	for <ltp@archiver.kernel.org>; Thu, 21 Oct 2021 09:21:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EEDE3C312E
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 09:21:43 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 223551401187
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 09:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634800901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U8VrVKdBN7Ah4MFzQHm5tGzhzDoh+BFOlDYlooKdylI=;
 b=P/Y4C4+7MxohczjPpeXRN3RIsnA0ZCQxshoGo6M2Oc5N1EqhqLxnizDGvndS9n5lxjTL4z
 EFa8PeLgekBCzKZiShfJmJPdN1Krbh2lBZr1PfrQXo/QV+/yns/fR44rjD3vsC9S9cTgaB
 IXfUg5WP4RYEgwgkulHX+sbC73hy7Lg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-5gfXWjHRPqWFxMnxF7dowg-1; Thu, 21 Oct 2021 03:21:37 -0400
X-MC-Unique: 5gfXWjHRPqWFxMnxF7dowg-1
Received: by mail-qt1-f199.google.com with SMTP id
 e10-20020ac8670a000000b002a78257482eso3987057qtp.10
 for <ltp@lists.linux.it>; Thu, 21 Oct 2021 00:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U8VrVKdBN7Ah4MFzQHm5tGzhzDoh+BFOlDYlooKdylI=;
 b=hoi+YKuRZTytbbH3nItFixE0xsWJu1V3Pf6arADhXhiOZ0XsZbDRV2zSbt04pgxxEM
 OLMrkdgzrKGOXjxVK0lhVZJaOsVx8TvMeLZlZWFw5dUqFZ1Z4oCqWioWFqgDh8BpWLvd
 cFTrDc3Q8Ds1tZxuZrmokv/FL2nxRkl+59Po2lsBczz7OV+erXOG0aD9itz/YYoDtbqq
 xLqBZGBinHa8Ccxli5TXNLsBdpmDVSve7zaYokoHw0Ar2mba95Deb3N8MsyhI08p4Sjl
 k0XGyByDgLgFRePxSL8Q2HZMzNCYfWIGteWdXo56U0xKNQUh0DYiqS/XM+/MbQ4y9IvC
 rdLw==
X-Gm-Message-State: AOAM530wlbzmpjVUAMtOd79qcWoXp5bBU6m+EYwjIC2XU8Lo1hDvl2xf
 3zT63+RPQlRNUMJd1giUUZpIAcGk48eVncPZ2puzhq7HGR9eHsvqFTwyatTGsfzz4jOyqv3v3yZ
 pMGo/OFSugESw2bEhnd7T2fEB9oI=
X-Received: by 2002:a25:e4c7:: with SMTP id b190mr4250047ybh.302.1634800897285; 
 Thu, 21 Oct 2021 00:21:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxykHzjedyNLxq3eI+uSYl08QWONjX7ZwWvrYIGDl27mTs9iybB3kxRJZrGWqjJN+d2uT5farlqmpAjO96ksI=
X-Received: by 2002:a25:e4c7:: with SMTP id b190mr4250031ybh.302.1634800897012; 
 Thu, 21 Oct 2021 00:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20211020091353.90731-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211020091353.90731-1-krzysztof.kozlowski@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Oct 2021 15:21:24 +0800
Message-ID: <CAEemH2cPDbcekuQ=j9SmoUFQ1e-LRLzFqKSOd2_bXELTSmus=A@mail.gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] lib: memutils: respect minimum memory
 watermark when polluting memory
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
Content-Type: multipart/mixed; boundary="===============0403559320=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0403559320==
Content-Type: multipart/alternative; boundary="000000000000bef38c05ced7becb"

--000000000000bef38c05ced7becb
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 20, 2021 at 5:14 PM Krzysztof Kozlowski <
krzysztof.kozlowski@canonical.com> wrote:

> Previous fix for an out-of-memory killer killing ioctl_sg01 process
> in commit 4d2e3d44fad5 ("lib: memutils: don't pollute
> entire system memory to avoid OoM") was not fully effective.  While it
> covers most of the cases, an ARM64 machine with 128 GB of memory, 64 kB
> page size and v5.11 kernel hit it again.  Polluting the memory fails
> with OoM:
>
>   LTP: starting ioctl_sg01
>   ioctl_sg01 invoked oom-killer:
> gfp_mask=0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), order=0, oom_score_adj=0
>   ...
>   Mem-Info:
>   active_anon:309 inactive_anon:1964781 isolated_anon:0
>                   active_file:94 inactive_file:0 isolated_file:0
>                   unevictable:305 dirty:0 writeback:0
>                   slab_reclaimable:1510 slab_unreclaimable:5012
>                   mapped:115 shmem:339 pagetables:463 bounce:0
>                   free:112043 free_pcp:1 free_cma:3159
>   Node 0 active_anon:19776kB inactive_anon:125745984kB active_file:6016kB
> inactive_file:0kB unevictable:19520kB ...
>   Node 0 DMA free:710656kB min:205120kB low:256384kB high:307648kB
> reserved_highatomic:0KB active_anon:0kB inactive_anon:3332032kB ...
>   lowmem_reserve[]: 0 0 7908 7908 7908
>   Node 0 Normal free:6460096kB min:6463168kB low:8078912kB high:9694656kB
> reserved_highatomic:0KB active_anon:19776kB inactive_anon:122413952kB ...
>   lowmem_reserve[]: 0 0 0 0 0
>
> The important part are details of memory on Node 0 in Normal zone:
> 1. free memory: 6460096 kB
> 2. min (minimum watermark): 6463168 kB
>
> Parse the /proc/sys/vm/min_free_kbytes which contains the free
> memory level used as minimum watermark (triggering OoM killer).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> ---
>
> Changes since v2:
> 1. Use /proc/sys/vm/min_free_kbytes instead of parsing zoneinfo, thanks
>    tgo Liu Xinpeng.
>
> Changes since v1:
> 1. Add static and rename to count_min_pages().
> ---
>  lib/tst_memutils.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index af132bcc6c24..df53c542d239 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -16,12 +16,18 @@
>  void tst_pollute_memory(size_t maxsize, int fillchar)
>  {
>         size_t i, map_count = 0, safety = 0, blocksize = BLOCKSIZE;
> +       unsigned long min_free;
>         void **map_blocks;
>         struct sysinfo info;
>
> +       SAFE_FILE_SCANF("/proc/sys/vm/min_free_kbytes", "%lu", &min_free);
> +       min_free *= 1024;
> +       /* Apply a margin because we cannot get below "min" watermark */
> +       min_free += min_free / 10;
> +
>         SAFE_SYSINFO(&info);
>         safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);
> -       safety = MAX(safety, (info.freeram / 64));
> +       safety = MAX(safety, min_free);
>

Therically this is correct, and I believe it will work on your tested
machine.

But my concern is ioctl_sg01 still fails on the special system which
MemAvai < MemFree.

Just like the one Xinpeng mentioned before:
https://lists.linux.it/pipermail/ltp/2021-January/020817.html

[root@test-env-nm05-compute-14e5e72e38 ~]# cat /proc/meminfo

MemTotal:       526997420 kB
MemFree:        520224908 kB
MemAvailable:   519936744 kB...

[root@test-env-nm05-compute-14e5e72e38 ~]# cat  /proc/sys/vm/min_free_kbytes
90112


There even reserve the safety to the 128MB, still less than the gap
between MemFree and MemAvailable.

MemFree (520224908 kB) - MemAvailable (520224908 kB) = 288164 kB  > safety


-- 
Regards,
Li Wang

--000000000000bef38c05ced7becb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Wed, Oct 20, 2021 at 5:14 PM Krzysztof Kozlowski=
 &lt;<a href=3D"mailto:krzysztof.kozlowski@canonical.com">krzysztof.kozlows=
ki@canonical.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Previous fix for an out-of-memory killer killing ioctl_sg01=
 process<br>
in commit 4d2e3d44fad5 (&quot;lib: memutils: don&#39;t pollute<br>
entire system memory to avoid OoM&quot;) was not fully effective.=C2=A0 Whi=
le it<br>
covers most of the cases, an ARM64 machine with 128 GB of memory, 64 kB<br>
page size and v5.11 kernel hit it again.=C2=A0 Polluting the memory fails<b=
r>
with OoM:<br>
<br>
=C2=A0 LTP: starting ioctl_sg01<br>
=C2=A0 ioctl_sg01 invoked oom-killer: gfp_mask=3D0x100dca(GFP_HIGHUSER_MOVA=
BLE|__GFP_ZERO), order=3D0, oom_score_adj=3D0<br>
=C2=A0 ...<br>
=C2=A0 Mem-Info:<br>
=C2=A0 active_anon:309 inactive_anon:1964781 isolated_anon:0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 active_file:=
94 inactive_file:0 isolated_file:0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unevictable:=
305 dirty:0 writeback:0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slab_reclaim=
able:1510 slab_unreclaimable:5012<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mapped:115 s=
hmem:339 pagetables:463 bounce:0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 free:112043 =
free_pcp:1 free_cma:3159<br>
=C2=A0 Node 0 active_anon:19776kB inactive_anon:125745984kB active_file:601=
6kB inactive_file:0kB unevictable:19520kB ...<br>
=C2=A0 Node 0 DMA free:710656kB min:205120kB low:256384kB high:307648kB res=
erved_highatomic:0KB active_anon:0kB inactive_anon:3332032kB ...<br>
=C2=A0 lowmem_reserve[]: 0 0 7908 7908 7908<br>
=C2=A0 Node 0 Normal free:6460096kB min:6463168kB low:8078912kB high:969465=
6kB reserved_highatomic:0KB active_anon:19776kB inactive_anon:122413952kB .=
..<br>
=C2=A0 lowmem_reserve[]: 0 0 0 0 0<br>
<br>
The important part are details of memory on Node 0 in Normal zone:<br>
1. free memory: 6460096 kB<br>
2. min (minimum watermark): 6463168 kB<br>
<br>
Parse the /proc/sys/vm/min_free_kbytes which contains the free<br>
memory level used as minimum watermark (triggering OoM killer).<br>
<br>
Signed-off-by: Krzysztof Kozlowski &lt;<a href=3D"mailto:krzysztof.kozlowsk=
i@canonical.com" target=3D"_blank">krzysztof.kozlowski@canonical.com</a>&gt=
;<br>
<br>
---<br>
<br>
Changes since v2:<br>
1. Use /proc/sys/vm/min_free_kbytes instead of parsing zoneinfo, thanks<br>
=C2=A0 =C2=A0tgo Liu Xinpeng.<br>
<br>
Changes since v1:<br>
1. Add static and rename to count_min_pages().<br>
---<br>
=C2=A0lib/tst_memutils.c | 8 +++++++-<br>
=C2=A01 file changed, 7 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c<br>
index af132bcc6c24..df53c542d239 100644<br>
--- a/lib/tst_memutils.c<br>
+++ b/lib/tst_memutils.c<br>
@@ -16,12 +16,18 @@<br>
=C2=A0void tst_pollute_memory(size_t maxsize, int fillchar)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t i, map_count =3D 0, safety =3D 0, blocks=
ize =3D BLOCKSIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long min_free;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 void **map_blocks;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct sysinfo info;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_FILE_SCANF(&quot;/proc/sys/vm/min_free_kby=
tes&quot;, &quot;%lu&quot;, &amp;min_free);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0min_free *=3D 1024;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Apply a margin because we cannot get below &=
quot;min&quot; watermark */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0min_free +=3D min_free / 10;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 SAFE_SYSINFO(&amp;info);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 safety =3D MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE=
), 128 * 1024 * 1024);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0safety =3D MAX(safety, (info.freeram / 64));<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0safety =3D MAX(safety, min_free);<br></blockquo=
te><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:smal=
l">Therically this is correct, and I believe=C2=A0it will work on your test=
ed machine.</div><div class=3D"gmail_default" style=3D"font-size:small"><br=
></div><div class=3D"gmail_default" style=3D"font-size:small">But my concer=
n is ioctl_sg01 still fails on the special system which MemAvai &lt; MemFre=
e.</div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><d=
iv class=3D"gmail_default" style=3D"font-size:small">Just like the one Xinp=
eng mentioned before:</div><a href=3D"https://lists.linux.it/pipermail/ltp/=
2021-January/020817.html">https://lists.linux.it/pipermail/ltp/2021-January=
/020817.html</a><br></div><div><br></div><div><div class=3D"gmail_default" =
style=3D"font-size:small"><span style=3D"color:rgb(0,0,0);white-space:pre-w=
rap">[</span><a href=3D"mailto:root@test-env-nm05-compute-14e5e72e38" style=
=3D"white-space:pre-wrap">root@test-env-nm05-compute-14e5e72e38</a><span st=
yle=3D"color:rgb(0,0,0);white-space:pre-wrap"> ~]# cat /proc/meminfo</span>=
</div><pre style=3D"white-space:pre-wrap;color:rgb(0,0,0)">MemTotal:       =
526997420 kB
MemFree:        <span class=3D"gmail_default" style=3D"font-size:small"></s=
pan><span class=3D"gmail_default" style=3D"font-size:small"></span><span cl=
ass=3D"gmail_default" style=3D"font-size:small"></span>520224908 kB
MemAvailable:   <span class=3D"gmail_default" style=3D"font-size:small"></s=
pan>519936744 kB
<span class=3D"gmail_default" style=3D"font-size:small">...</span>

[<a href=3D"mailto:root@test-env-nm05-compute-14e5e72e38">root@test-env-nm0=
5-compute-14e5e72e38</a> ~]# cat  /proc/sys/vm/min_free_kbytes
90112
</pre><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div=
 class=3D"gmail_default" style=3D"font-size:small">There even reserve the s=
afety to the 128MB, still less than the gap</div><div class=3D"gmail_defaul=
t" style=3D"font-size:small">between MemFree and MemAvailable.=C2=A0</div><=
div class=3D"gmail_default" style=3D"font-size:small"><br></div><div class=
=3D"gmail_default" style=3D"font-size:small">MemFree (<span class=3D"gmail_=
default" style=3D"color:rgb(0,0,0);white-space:pre-wrap"></span><span style=
=3D"color:rgb(0,0,0);white-space:pre-wrap">520224908 kB</span>) - MemAvaila=
ble (<span class=3D"gmail_default" style=3D"color:rgb(0,0,0);white-space:pr=
e-wrap"></span><span style=3D"color:rgb(0,0,0);white-space:pre-wrap">520224=
908 kB</span>) =3D=C2=A0288164 kB=C2=A0 &gt; safety</div></div><div><br></d=
iv></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature"><=
div dir=3D"ltr"><div>Regards,<br></div><div>Li Wang<br></div></div></div></=
div>

--000000000000bef38c05ced7becb--


--===============0403559320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0403559320==--

