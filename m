Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153D9C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 06:57:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E113C3CB05B
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:57:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3D153C1BC0
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 08:56:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F7F41A00913
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 08:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666076217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ldNvpimHP7KenpuA3O5jQglQ5WTSRWU9KVRXmoki3A=;
 b=R4Lm999WCFzJexom1BwVWhnsEXQ5vUNqguh27nQm1GPQjMSKxe4Al5EbXuwY5JJF/HcbKB
 XVt0UsSn9ywg6aCrDEVEMgHaHGs3WKYMwIPoo66cnrGaL91dYQT5D5CnJQgWXTd5yRy9tF
 v+CraWrHfNaS/gSz6sqWzQAQ6+9ocB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-HhErPElxO0KOWOcRgpE3gQ-1; Tue, 18 Oct 2022 02:56:56 -0400
X-MC-Unique: HhErPElxO0KOWOcRgpE3gQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 e14-20020adf9bce000000b0022d18139c79so4223654wrc.5
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 23:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8ldNvpimHP7KenpuA3O5jQglQ5WTSRWU9KVRXmoki3A=;
 b=I9p9hT63CZTU8os1irM9zI3fB/CzLHbHreI8cGB9Tj3ZaPIZpJAyY+IsqZ0RasTW3j
 hiWA7+ladtu4NJTSPO207HyflAaYsMKERYvVUWZ2/HFCmKwZZ4P8tD8aZut3NCkclQJO
 hJMI9+auuK9jd0Ug92RK5ledl8446tRxlFkAtbhrn2kjfHk0iZdNCv7wL4A6KuLyvL/i
 C+dC+d/ILZatlYZf9sB4khkll80JDB5o6WFZ/kLt70Zwzpqg87RkT27oUkaJeVPDKJMO
 bXKo+JTHVNpwtkYCtgQN7S9KmXyPgg1Tx+QBGAMqVaHJxoYsibByymM9ao8jLfK4oJan
 FKkQ==
X-Gm-Message-State: ACrzQf3H0CI1UkQ637FQ83/3Lok5rHIYXmypb7ybXIklQmIk9IDOr0E3
 bPkqxTWVlnF0gdbNEPxy9ylYJLO9ZIIDlOsgrD4fLAHwLVCLxpKY71KZLVTzswrJnZQxzf+sKwG
 HlwlXhOcEPZ3FCn4zZTZzIsyUSRE=
X-Received: by 2002:a5d:64e2:0:b0:22e:7060:b4a7 with SMTP id
 g2-20020a5d64e2000000b0022e7060b4a7mr789690wri.129.1666076214941; 
 Mon, 17 Oct 2022 23:56:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5JmiLAb7DKLv4J6aneGF6Zt5ZFtMmnpafa1GwQXPb5C5x09mU/EGjpQY191ECzUxqtwC20OvTw88SxjbXzZ5g=
X-Received: by 2002:a5d:64e2:0:b0:22e:7060:b4a7 with SMTP id
 g2-20020a5d64e2000000b0022e7060b4a7mr789681wri.129.1666076214731; Mon, 17 Oct
 2022 23:56:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221016125731.249078-1-tsahu@linux.ibm.com>
 <20221016125731.249078-10-tsahu@linux.ibm.com>
In-Reply-To: <20221016125731.249078-10-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Oct 2022 14:56:43 +0800
Message-ID: <CAEemH2fqJaA87-N4MMQCHRmN=ZG7+x8cu_4V9-nnuNg4mfNKzA@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 09/29] Hugetlb: Migrating libhugetlbfs fork-cow
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
Content-Type: multipart/mixed; boundary="===============0361595949=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0361595949==
Content-Type: multipart/alternative; boundary="000000000000f2be9005eb4998aa"

--000000000000f2be9005eb4998aa
Content-Type: text/plain; charset="UTF-8"

Tarun Sahu <tsahu@linux.ibm.com> wrote:



> +static void run_test(void)
> +{
> +       int status;
> +       void *syncarea;
> +       volatile unsigned int *p;
> +       volatile unsigned int *trigger, *child_readback;
> +       int parent_readback;
> +       pid_t pid;
> +       struct sigaction sa = {
> +               .sa_sigaction = sigchld_handler,
> +               .sa_flags = SA_SIGINFO,
> +       };
> +
> +       /* Get a shared normal page for synchronization */
> +       if (verbose)
> +               tst_res(TINFO, "Mapping synchronization area..");
> +       syncarea = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
> +                       MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> +       if (verbose)
> +               tst_res(TINFO, "done");
> +
> +       trigger = syncarea;
> +       *trigger = 0;
> +
> +       child_readback = trigger + 1;
> +       *child_readback = 0;
> +
> +       fd = SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600);
> +       SAFE_UNLINK(hfile);
> +
> +       if (verbose)
> +               tst_res(TINFO, "Mapping hugepage area...");
> +       p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
> fd, 0);
>


After roughly looking at those hpage testcases, almost each one
requests the huge memory via mapping a file on hugetlbfs, which
can work but quite don't have to.

We can absolutely simplify them via `MAP_HUGETLB` to get expected
size of huge memory for use.

Reference how hugemamp06.c does:
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c#L71


+static void setup(void)
> +{
> +       int free_pages = SAFE_READ_MEMINFO("HugePages_Free:");
> +
> +       if (tst_hugepages < 2 || free_pages < 2)
> +               tst_brk(TCONF, "Not enough hugepages for testing.");
>



> +
> +       if (!Hopt)
> +               Hopt = tst_get_tmpdir();
> +       SAFE_MOUNT("none", Hopt, "hugetlbfs", 0, NULL);
> +
> +       snprintf(hfile, sizeof(hfile), "%s/ltp_hugetlbfile%d", Hopt,
> getpid());
>

If we go using MAP_HUGETLB above, those lines can be removed.



> +       hpage_size = SAFE_READ_MEMINFO("Hugepagesize:")*1024;
> +}
>



-- 
Regards,
Li Wang

--000000000000f2be9005eb4998aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">Tarun Sahu &lt;<a href=3D"mailto:tsahu@linux.ibm.com">tsahu@l=
inux.ibm.com</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+static void run_test(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int status;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0void *syncarea;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0volatile unsigned int *p;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0volatile unsigned int *trigger, *child_readback=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int parent_readback;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0pid_t pid;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct sigaction sa =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.sa_sigaction =3D s=
igchld_handler,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.sa_flags =3D SA_SI=
GINFO,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Get a shared normal page for synchronization=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (verbose)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quo=
t;Mapping synchronization area..&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0syncarea =3D SAFE_MMAP(NULL, getpagesize(), PRO=
T_READ|PROT_WRITE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0MAP_SHARED|MAP_ANONYMOUS, -1, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (verbose)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quo=
t;done&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0trigger =3D syncarea;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*trigger =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0child_readback =3D trigger + 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*child_readback =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D SAFE_OPEN(hfile, O_RDWR | O_CREAT, 0600)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_UNLINK(hfile);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (verbose)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res(TINFO, &quo=
t;Mapping hugepage area...&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0p =3D SAFE_MMAP(NULL, hpage_size, PROT_READ|PRO=
T_WRITE, MAP_PRIVATE, fd, 0);<br></blockquote><div><br></div><div><br></div=
><div><div class=3D"gmail_default" style=3D"font-size:small">After=C2=A0rou=
ghly looking at those hpage testcases, almost each one</div><div class=3D"g=
mail_default" style=3D"font-size:small">requests the huge memory via mappin=
g a file on hugetlbfs, which</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">can work but quite don&#39;t have to.</div><div class=3D"gmai=
l_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default"=
 style=3D"font-size:small">We can absolutely simplify them via `MAP_HUGETLB=
` to get expected</div><div class=3D"gmail_default" style=3D"font-size:smal=
l">size of huge memory for use.</div><div class=3D"gmail_default" style=3D"=
font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-size:=
small">Reference how hugemamp06.c does:</div><div class=3D"gmail_default" s=
tyle=3D"font-size:small"><a href=3D"https://github.com/linux-test-project/l=
tp/blob/master/testcases/kernel/mem/hugetlb/hugemmap/hugemmap06.c#L71">http=
s://github.com/linux-test-project/ltp/blob/master/testcases/kernel/mem/huge=
tlb/hugemmap/hugemmap06.c#L71<br></a></div><br></div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
+static void setup(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int free_pages =3D SAFE_READ_MEMINFO(&quot;Huge=
Pages_Free:&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (tst_hugepages &lt; 2 || free_pages &lt; 2)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_brk(TCONF, &quo=
t;Not enough hugepages for testing.&quot;);<br></blockquote><div><br></div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!Hopt)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Hopt =3D tst_get_tm=
pdir();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0SAFE_MOUNT(&quot;none&quot;, Hopt, &quot;hugetl=
bfs&quot;, 0, NULL);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0snprintf(hfile, sizeof(hfile), &quot;%s/ltp_hug=
etlbfile%d&quot;, Hopt, getpid());<br></blockquote><div><br></div><div><div=
 class=3D"gmail_default" style=3D"font-size:small">If we go using MAP_HUGET=
LB above, those lines can be removed.</div><br></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0hpage_size =3D SAFE_READ_MEMINFO(&quot;Hugepage=
size:&quot;)*1024;<br>
+}<br></blockquote><div><br></div><div>=C2=A0</div></div><div><br></div>-- =
<br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Regard=
s,<br></div><div>Li Wang<br></div></div></div></div>

--000000000000f2be9005eb4998aa--


--===============0361595949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0361595949==--

