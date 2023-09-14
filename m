Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FF0EDE99C
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 09:45:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 776AB3CE726
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 11:45:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5032E3CB253
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 11:44:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0C3C420A6C7
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 11:44:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694684690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BANKxLh//dfbx2i1INStXZkL/cKOcwTcTDlzuFLqBSA=;
 b=B0mNqXxzpBz10Toybid8/oopHXz8lTSBcH3Ezm4yrnQRakGLKonC3LmiHGre2S2Yrv5zbJ
 jgwITg9SmYyMZAFVY2msudDKY0CJwTp7aONgVvSR0hw8/4j7JM8DQb5/Lc2SQMmNrnR9IQ
 TPAfP6ciGlZHGXFmTzs8ZqXrgAB9YAg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-4LDXmmxlNIGls7K7e21NKg-1; Thu, 14 Sep 2023 05:44:49 -0400
X-MC-Unique: 4LDXmmxlNIGls7K7e21NKg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5007f3d3293so902373e87.3
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 02:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694684687; x=1695289487;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BANKxLh//dfbx2i1INStXZkL/cKOcwTcTDlzuFLqBSA=;
 b=vLA7G5Bouu2fCTzM9G2NRGyPfUOdM9YGViXc1ROTEnRahoMSs09w4nrqijbc9GOy4D
 q1Xh93VfP5N1rTXvTaaOp1g9cS1c+m0fkZwuph6ylVNEXegDi83vN6fNPuDSAwaFPV6d
 ypNs+3bajGaTvhSlcLBbuu6gQfDihabd7jq9+D/n45Dq+JfrawqBJlaUg+x3KoAYkIpn
 BzSWQq+qcs6dF4tuRt4JJKBlEuvMOnfVnf2rC9O2Z1dA92nfkPrU+opBifNxMRAdV4GP
 eyfHm/GqguM8BkSD7l2W4V73LK1Ld8Vw6rh1Uz7BceVCa2shc3D/ZVjhrwz9k7oAxFOP
 UW7g==
X-Gm-Message-State: AOJu0Yx3QCGtoKfQYGLPBhiUkTGwuIgawkYayps8uQAn/z1wq3UfWE1c
 5HIGpQVWnbMQgT+Qdki5IrL58VkaL3lWB3n+o8ZWnuYcDstKp25tM82xo+XQy6Hg2nE5dUUy+1f
 E17rj1LjAokv2TqJ1pyhguKFJpYL/eBY4dW/yHxa/vwQ=
X-Received: by 2002:ac2:4bd2:0:b0:4ff:7f57:facd with SMTP id
 o18-20020ac24bd2000000b004ff7f57facdmr5040892lfq.54.1694684686726; 
 Thu, 14 Sep 2023 02:44:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlB1Q/hiv5a9BbLxBheODcDSmPXa8E6Fg7rD1kthcQFH4qkiEKaQPmFufK8WzJ8SbH5DctQT+EC8Z8TxecNMU=
X-Received: by 2002:ac2:4bd2:0:b0:4ff:7f57:facd with SMTP id
 o18-20020ac24bd2000000b004ff7f57facdmr5040879lfq.54.1694684686347; Thu, 14
 Sep 2023 02:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230524093930.43971-1-liwang@redhat.com>
 <20230911080233.1305942-1-liwang@redhat.com>
In-Reply-To: <20230911080233.1305942-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 14 Sep 2023 17:44:34 +0800
Message-ID: <CAEemH2ejp3iLbv7fXAr6H3WuC+TQ3O05V0t2HUyYSbsNYixFaQ@mail.gmail.com>
To: ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] lib: add support for kinds of hpsize
 reservation
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

[Please hold off on merging this patch]

The hesitating part of this method (from myself) is the new field
'hp->hpsize'.
It seems not wise to leave it to users to fill the gigantic page size
manually,
as some arches support different huge/gigantic page sizes:

   x86_64 and x86:  2MB and 1GB.
   PowerPC:  ranging from 64KB to 16GB.
   ARM64:  2MB and 1GB.
   IA-64 (Itanium):  from 4KB to 256MB.

we probably need a intelengent way to detect and reserve whatever
hugepage or gitantic-page that all acmplish that in ltp-library or setup().
Then people don't need to fill any byte which avoiding typo or
something wrong.

What I can think of the improved way is to extend the hugepage policy
with "_G" subfix to  specified the gigantic pages.

Is this sounds better?  What do you think?

Something drafted base on my patch V2:

--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -20,14 +20,15 @@ extern char *nr_opt; /* -s num   Set the number of the
been allocated hugepages
 extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H
/var/hugetlbfs */

 enum tst_hp_policy {
-       TST_REQUEST,
-       TST_NEEDS,
+       TST_REQUEST_H = 0x0,
+       TST_REQUEST_G = 0x1,
+       TST_NEEDS_H   = 0x2,
+       TST_NEEDS_G   = 0x4,
 };

 struct tst_hugepage {
        const unsigned long number;
        enum  tst_hp_policy policy;
-       const unsigned long hpsize;
 };

 /*
@@ -35,6 +36,11 @@ struct tst_hugepage {
  */
 size_t tst_get_hugepage_size(void);

+/*
+ * Get the gigantic hugepage size. Returns 0 if hugepages are not
supported.
+ */
+size_t tst_get_gigantic_size(void);
+
 /*
  * Try the best to request a specified number of huge pages from system,
  * it will store the reserved hpage number in tst_hugepages.
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index f4b18bbbf..568884fbb 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -21,6 +21,30 @@ size_t tst_get_hugepage_size(void)
        return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 }

+/* Check if hugetlb page is gigantic */
+static inline int is_hugetlb_gigantic(unsigned long hpage_size)
+{
+       return (hpage_size / getpagesize()) >> 11;
+}
+
+size_t tst_get_gigantic_size(void)
+{
+       DIR *dir;
+       struct dirent *ent;
+       unsigned long g_hpage_size;
+
+       dir = SAFE_OPENDIR(PATH_HUGEPAGES);
+       while ((ent = SAFE_READDIR(dir))) {
+               if ((sscanf(ent->d_name, "hugepages-%lukB", &g_hpage_size)
== 1) &&
+                       is_hugetlb_gigantic(g_hpage_size * 1024)) {
+                       break;
+               }
+       }
+
+       SAFE_CLOSEDIR(dir);
+       return g_hpage_size * 1024;
+}
+
 unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 {
        unsigned long val, max_hpages, hpsize;
@@ -43,10 +67,10 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage
*hp)
        else
                tst_hugepages = hp->number;

-       if (hp->hpsize)
-               hpsize = hp->hpsize;
+       if (hp->policy & (TST_NEEDS_G | TST_REQUEST_G))
+               hpsize = tst_get_gigantic_size() / 1024;
        else
-               hpsize = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE);
+               hpsize = tst_get_hugepage_size() / 1024;

        sprintf(hugepage_path,
PATH_HUGEPAGES"/hugepages-%lukB/nr_hugepages", hpsize);
        if (access(hugepage_path, F_OK)) {




-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
