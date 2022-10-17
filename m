Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8B8C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 10:20:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A015D3CAFE5
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 12:20:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 036DD3C8CAF
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 12:20:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 717071400349
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 12:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666002029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JlS3zhHCoHrPQAfQ45TGJf564YUJc7X5zMPicKK5vEE=;
 b=Dg2+qSz02zydjtqTUxHD+zdr2+XM3wYMwUmCvxN38h4qAjUkK8jSvuvxqUQMC5kd5ZZCFB
 IIN8Bs+lkZo7kLacPK9GbcOye4OU5vEYY6L9xNNFLprdPgyghnVwKeR3g6s7gbXS0Dyy83
 KE5jJfD8SiQ9IvA8pZQ7Br3dzlHhtOA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-423-Gh4jzR_FOS6kYgtNm3PH5g-1; Mon, 17 Oct 2022 06:20:28 -0400
X-MC-Unique: Gh4jzR_FOS6kYgtNm3PH5g-1
Received: by mail-wr1-f72.google.com with SMTP id
 g4-20020adfbc84000000b0022fc417f87cso3556858wrh.12
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 03:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlS3zhHCoHrPQAfQ45TGJf564YUJc7X5zMPicKK5vEE=;
 b=jBshb/ubaKgEGsTX/99+JCxbe6oFkPOVAvHmfsOGWMAMyRTK52xXL+E/gKXlt0yEoi
 BDUiaanytRtuTpH5+Dx/Le66S5EJEHgUEjcEdu3GtFlVCtYvPO/Kz3iHpUzPvQiyM8YO
 vl0CSPT9vNtsCrpjbPD4znY8vRTbFMmybe351I6WQ4/VucpOKlKo6b58bAOXAK3RvzDT
 xRP4eR8IC/4FNcrRtLZ9Ra43KMk6rDxOQUkPPqunfPBvnRFMjJMSmZPlVO5wkuyIkjoP
 QvOEwptitM66psAldiXT7BvK63Y+ZqLpniDAyyJSuWvBSRUP/ADZQHQBJRYt7wJ50fcd
 qr1Q==
X-Gm-Message-State: ACrzQf2GRT+35rsu9aDZEeVSCPn01+latgOzNPalIo6CHYdjov5NN5K1
 US70CKb+oAxGVSUwk9nJN+gldGthbg/XLCiTKNWg8aO3Yv4VfUTJNnjPSLS4hofxbqL7Ch+3CGY
 ouCgf3VnLsTHpH1bLdvhMaOdSg/s=
X-Received: by 2002:a5d:6483:0:b0:22e:4804:8be4 with SMTP id
 o3-20020a5d6483000000b0022e48048be4mr5535318wri.528.1666002026850; 
 Mon, 17 Oct 2022 03:20:26 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6VCZ6UtW9B5c0l1Wu9Y8FxZprsvnyNx9tqTCv9VRziS1TFjliWCMJblNz2LwfyOvJFG50pa3M+S43/maBQVAU=
X-Received: by 2002:a5d:6483:0:b0:22e:4804:8be4 with SMTP id
 o3-20020a5d6483000000b0022e48048be4mr5535312wri.528.1666002026634; Mon, 17
 Oct 2022 03:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-2-tsahu@linux.ibm.com>
In-Reply-To: <20221016125731.249078-2-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Oct 2022 18:20:15 +0800
Message-ID: <CAEemH2d_pdFqN-P=Ab00gpHypYW2z6Y2m9P6vLenRz+tFNvndw@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 01/29] Hugetlb: Migrating libhugetlbfs
 brk_near_huge
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
Cc: aneesh.kumar@linux.ibm.com, sbhat@linux.ibm.com, ltp@lists.linux.it,
 vaibhav@linux.ibm.com
Content-Type: multipart/mixed; boundary="===============1433358463=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============1433358463==
Content-Type: multipart/alternative; boundary="000000000000fe38ca05eb38524a"

--000000000000fe38ca05eb38524a
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tsahu@linux.ibm.com> wrote:



> +
> +static void setup(void)
> +{
> +       if (tst_hugepages < 1)
> +               tst_brk(TCONF, "Not enough hugepages for testing.");
>


If we needs at least 1 huge page for testing, the TST_NEEDS will
be more useful than TST_REQUEST, and do not need to double
check the hpage numbers anymore.


TST_REQUEST:
  It will try the best to reserve available huge pages and return the number
  of available hugepages in tst_hugepages, which may be 0 if hugepages are
  not supported at all.

TST_NEEDS:
  This is an enforced requirement, LTP should strictly do hpages applying
and
  guarantee the 'HugePages_Free' no less than pages which makes that test
can
  use these specified numbers correctly. Otherwise, test exits with TCONF if
  the attempt to reserve hugepages fails or reserves less than requested.

See:
https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L2009



> +
> +       if (!Hopt)
> +               Hopt = tst_get_tmpdir();
> +       SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +
> +       snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt,
> getpid());
> +       hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +}
> +
> +static void cleanup(void)
> +{
> +       if (fd >= 0)
> +               SAFE_CLOSE(fd);
> +       umount2(Hopt, MNT_DETACH);
> +}
> +
> +static struct tst_test test = {
> +       .needs_root = 1,
> +       .needs_tmpdir = 1,
> +       .options = (struct tst_option[]) {
> +               {"v", &verbose, "Turns on verbose mode"},
> +               {"H:", &Hopt,   "Location of hugetlbfs, i.e.  -H
> /var/hugetlbfs"},
> +               {"s:", &nr_opt, "Set the number of the been allocated
> hugepages"},
> +               {}
> +       },
> +       .setup = setup,
> +       .cleanup = cleanup,
> +       .test_all = run_test,
> +       .hugepages = {1, TST_REQUEST},
>

^ TST_NEEDS



> +};
>



-- 
Regards,
Li Wang

--000000000000fe38ca05eb38524a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Tarun Sahu &lt;<a href=3D"mailto:tsahu@linux.ibm.com">tsahu@l=
inux.ibm.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+<br>
+static void setup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_hugepages &lt; 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF, &quo=
t;Not enough hugepages for testing.&quot;);<br></blockquote><div><br></div>=
<div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small">=
If we needs at least 1 huge page for testing, the TST_NEEDS will</div><div =
class=3D"gmail_default" style=3D"font-size:small">be more useful than TST_R=
EQUEST, and do not need to double</div><div class=3D"gmail_default" style=
=3D"font-size:small">check the hpage numbers anymore.</div><br></div><div><=
br></div><div><div class=3D"gmail_default" style=3D"font-size:small">TST_RE=
QUEST:</div>=C2=A0 It will try the best to reserve available huge pages and=
 return the number<br>=C2=A0 of available hugepages in tst_hugepages, which=
 may be 0 if hugepages are<br>=C2=A0 not supported at all.<br><br>TST_NEEDS=
:<br>=C2=A0 This is an enforced requirement, LTP should strictly do hpages =
applying and<br>=C2=A0 guarantee the &#39;HugePages_Free&#39; no less than =
pages which makes that test can<br>=C2=A0 use these specified numbers corre=
ctly. Otherwise, test exits with TCONF if<br>=C2=A0 the attempt to reserve =
hugepages fails or reserves less than requested.<br><div class=3D"gmail_def=
ault" style=3D"font-size:small"></div><div class=3D"gmail_default" style=3D=
"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size=
:small">See: <a href=3D"https://github.com/linux-test-project/ltp/blob/mast=
er/doc/c-test-api.txt#L2009">https://github.com/linux-test-project/ltp/blob=
/master/doc/c-test-api.txt#L2009</a></div><br></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!Hopt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hopt =3D tst_get_tm=
pdir();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MOUNT(&quot;none&quot;, Hopt, &quot;hugetl=
bfs&quot;, 0, NULL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(hfile, sizeof(hfile), &quot;%s/ltp_hug=
etlbfile%d&quot;, Hopt, getpid());<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hpage_size =3D SAFE_READ_MEMINFO(&quot;Hugepage=
size:&quot;)*1024;<br>
+}<br>
+<br>
+static void cleanup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &gt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_CLOSE(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0umount2(Hopt, MNT_DETACH);<br>
+}<br>
+<br>
+static struct tst_test test =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_root =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.needs_tmpdir =3D 1,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.options =3D (struct tst_option[]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;v&quot;, &am=
p;verbose, &quot;Turns on verbose mode&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;H:&quot;, &a=
mp;Hopt,=C2=A0 =C2=A0&quot;Location of hugetlbfs, i.e.=C2=A0 -H /var/hugetl=
bfs&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;s:&quot;, &a=
mp;nr_opt, &quot;Set the number of the been allocated hugepages&quot;},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.setup =3D setup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.cleanup =3D cleanup,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.test_all =3D run_test,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0.hugepages =3D {1, TST_REQUEST},<br></blockquot=
e><div><br></div><div><div class=3D"gmail_default" style=3D"font-size:small=
">^ TST_NEEDS</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
+};<br></blockquote><div><br></div><div>=C2=A0</div></div><div><br></div>--=
 <br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regar=
ds,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000fe38ca05eb38524a--


--===============1433358463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============1433358463==--

