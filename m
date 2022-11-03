Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA10C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 09:56:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34ACE3CAD4F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 10:56:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C76603CA6CD
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 10:55:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 10B2B200253
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 10:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1667469346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=poGfu8XvleipbAyJzoL+dagATySCm5qo0xVj3WMDzX4=;
 b=WmUsKdMAibZKYKhlinUP5vdqRKxpCRRcdyBivKsvWnM76BRd7/ShkVn5s8xVPC2iFlqP14
 hyZHwQXP22/UdBQAosUIz1ztWLbck92WZw+mm+WFlf1ysM9BXAJsznchY6ViOqO8qmP7Qh
 6Z2EsEmNF6wIsbE+E3CBoAuBi7Z7v+w=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-261-tRC3TQ3uPveGOPcgGMQDfw-1; Thu, 03 Nov 2022 05:55:37 -0400
X-MC-Unique: tRC3TQ3uPveGOPcgGMQDfw-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-13b041fd3cbso831308fac.16
 for <ltp@lists.linux.it>; Thu, 03 Nov 2022 02:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=poGfu8XvleipbAyJzoL+dagATySCm5qo0xVj3WMDzX4=;
 b=tWiPn4XH9R91lNYAt5nt8wMwsuuKOYvN/7uyYeorDuahUKUPSceU/1XT2GV+Qj1Cdd
 I0fzP27wsB4muIUW4lXINyyGz+WE7r8aIaJd/FsXT7rUEJP0gaWsizZ8t4Nd3SscSxnp
 /ZjN2pwJ54YNrxRlKdJYYtwIzkeU9b7aLQMNiu+1M9IiGCeZ4BY760nXjsNQ7eYyvjaH
 YnokZG0vp5ghL2btAbnoNdcjaiK7ZxsE6WXUoGtQybyjWPOn2LQWzivhqA9VVuWhlCe5
 RIikuWS2stLvs+CERuljpqnfBVI8vgPzf2cSP/48SDA9B1Fk9yokpAR375aqwEJf6qpp
 5JFw==
X-Gm-Message-State: ACrzQf10/3y4M8deKnkQLvQ3mItODkMMQm6P+kV++/qm5aCqtWFc/NcK
 dXoUe7o/Sn+1lv7sNDj1KJAkWSHozR773kqqBxyADLn5jF9mfe1uzXmYtX07bZUUkTNswkcNamt
 AiWmuP/mld2wVCzjQm5LQopQVm2I=
X-Received: by 2002:aca:b954:0:b0:359:fb87:84f8 with SMTP id
 j81-20020acab954000000b00359fb8784f8mr12502969oif.19.1667469337086; 
 Thu, 03 Nov 2022 02:55:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5YZNldxBKWo6f0yNMZ1lzPeYTHDs+XEu5aWAOMTPEVIHRjAVVpEFDWCl8gyYd1CXH5DwZHvWBQsOkIWwQvSng=
X-Received: by 2002:aca:b954:0:b0:359:fb87:84f8 with SMTP id
 j81-20020acab954000000b00359fb8784f8mr12502956oif.19.1667469336906; Thu, 03
 Nov 2022 02:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20221103054317.499221-1-tsahu@linux.ibm.com>
 <20221103054317.499221-2-tsahu@linux.ibm.com>
 <CAEemH2dNhMq35OgCbTTPVO-Hfj62uVb1EsSTuH48P176V+ZJVA@mail.gmail.com>
 <20221103093108.hs64zkkrd2mjhudk@tarunpc>
In-Reply-To: <20221103093108.hs64zkkrd2mjhudk@tarunpc>
From: Li Wang <liwang@redhat.com>
Date: Thu, 3 Nov 2022 17:55:23 +0800
Message-ID: <CAEemH2ecxDkTVRV-1neSkx59ht0aHGfS1Gv-RsWAtUCZaOUZsg@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/4] Hugetlb: Add new tst_test options for
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
Cc: geetika@linux.ibm.com, sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: multipart/mixed; boundary="===============0825933788=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0825933788==
Content-Type: multipart/alternative; boundary="00000000000080268005ec8df53c"

--00000000000080268005ec8df53c
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 3, 2022 at 5:33 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:

> Hello,
> Thanks for reviewing.
>
> I am thinking of adding following lines in "lib/hugetlb.h"
>
> #define HUGEPAGE_TOTAL "HugePages_Total:"
> #define HUGEPAGE_FREE "HugePages_Total:"
> #define HUGEPAGE_RSVD "HugePages_Total:"
> #define HUGEPAGE_Surp "HugePages_Total:"
>
> There are all test that uses, TOTAL, MANY that uses FREE, few RSVD, SURP.
> If we change it now, we can update this series now and, proceed further for
> series of next tests.
>
> What do you think?
>

I guess put in the top header file "inlucde/tst_hugepage.h" should be
better,
it provides more scope(for the whole LTP) of use.

I ever thought to combine this hugetlb/lib there, especially for new cases,
it would be easier to maintain only one library for hugetlb.
(and also adding more definitions. e.g.
"/proc/sys/vm/nr_overcommit_hugepages")


-- 
Regards,
Li Wang

--00000000000080268005ec8df53c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Nov 3, 2022 at 5:33 PM Tarun Sahu &lt;<a hr=
ef=3D"mailto:tsahu@linux.ibm.com" target=3D"_blank">tsahu@linux.ibm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hell=
o, <br>
Thanks for reviewing.<br>
<br>
I am thinking of adding following lines in &quot;lib/hugetlb.h&quot;<br>
<br>
#define HUGEPAGE_TOTAL &quot;HugePages_Total:&quot;<br>
#define HUGEPAGE_FREE &quot;HugePages_Total:&quot;<br>
#define HUGEPAGE_RSVD &quot;HugePages_Total:&quot;<br>
#define HUGEPAGE_Surp &quot;HugePages_Total:&quot;<br>
<br>
There are all test that uses, TOTAL, MANY that uses FREE, few RSVD, SURP.<b=
r>
If we change it now, we can update this series now and, proceed further for=
<br>
series of next tests.<br>
<br>
What do you think?<br></blockquote><div><br></div><div><div class=3D"gmail_=
default" style=3D"font-size:small">I guess put in the top header file &quot=
;inlucde/tst_hugepage.h&quot; should be better,</div><div class=3D"gmail_de=
fault" style=3D"font-size:small">it provides more scope(for the whole LTP) =
of use. </div><div class=3D"gmail_default" style=3D"font-size:small"><br></=
div><div class=3D"gmail_default" style=3D"font-size:small">I ever thought t=
o combine this hugetlb/lib there, especially for new cases,</div><div class=
=3D"gmail_default" style=3D"font-size:small">it would be=C2=A0easier to mai=
ntain only one library for hugetlb.</div><div class=3D"gmail_default" style=
=3D"font-size:small">(and also adding more definitions. e.g. &quot;/proc/sy=
s/vm/nr_overcommit_hugepages&quot;)</div></div><div><br></div></div><div><b=
r></div>-- <br><div dir=3D"ltr"><div dir=3D"ltr"><div>Regards,<br></div><di=
v>Li Wang<br></div></div></div></div>

--00000000000080268005ec8df53c--


--===============0825933788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0825933788==--

