Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD23CDB47E
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 10:09:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D78D33CEDE3
	for <ltp@archiver.kernel.org>; Wed, 18 Oct 2023 12:09:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 833CE3C2DA4
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 12:09:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9CB2061663C
 for <ltp@lists.linux.it>; Wed, 18 Oct 2023 12:09:25 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A4F751F8D7;
 Wed, 18 Oct 2023 10:09:23 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 432632C174;
 Wed, 18 Oct 2023 10:09:23 +0000 (UTC)
References: <20230524093930.43971-1-liwang@redhat.com>
 <20230911080233.1305942-1-liwang@redhat.com>
 <CAEemH2ejp3iLbv7fXAr6H3WuC+TQ3O05V0t2HUyYSbsNYixFaQ@mail.gmail.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Wed, 18 Oct 2023 10:10:01 +0100
Organization: Linux Private Site
In-reply-to: <CAEemH2ejp3iLbv7fXAr6H3WuC+TQ3O05V0t2HUyYSbsNYixFaQ@mail.gmail.com>
Message-ID: <87mswgw8bz.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.79 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: A4F751F8D7
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Li Wang <liwang@redhat.com> writes:

> Hi Cyril,
>
> [Please hold off on merging this patch]
>
> The hesitating part of this method (from myself) is the new field
> 'hp->hpsize'.
> It seems not wise to leave it to users to fill the gigantic page size
> manually,
> as some arches support different huge/gigantic page sizes:

Yes, good idea.

>
>    x86_64 and x86:  2MB and 1GB.
>    PowerPC:  ranging from 64KB to 16GB.
>    ARM64:  2MB and 1GB.
>    IA-64 (Itanium):  from 4KB to 256MB.
>
> we probably need a intelengent way to detect and reserve whatever
> hugepage or gitantic-page that all acmplish that in ltp-library or setup().
> Then people don't need to fill any byte which avoiding typo or
> something wrong.

It seems like a special flag is needed in mmap if you want to allocate a
gigantic page other than 1GB?

>
> What I can think of the improved way is to extend the hugepage policy
> with "_G" subfix to  specified the gigantic pages.
>
> Is this sounds better?  What do you think?
>
> Something drafted base on my patch V2:
>
> --- a/include/tst_hugepage.h
> +++ b/include/tst_hugepage.h
> @@ -20,14 +20,15 @@ extern char *nr_opt; /* -s num   Set the number of the
> been allocated hugepages
>  extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H
> /var/hugetlbfs */
>
>  enum tst_hp_policy {
> -       TST_REQUEST,
> -       TST_NEEDS,
> +       TST_REQUEST_H = 0x0,
> +       TST_REQUEST_G = 0x1,
> +       TST_NEEDS_H   = 0x2,
> +       TST_NEEDS_G   = 0x4,
>  };
>
>  struct tst_hugepage {
>         const unsigned long number;
>         enum  tst_hp_policy policy;
> -       const unsigned long hpsize;
>  };

Why not keep hpsize and add enum tst_hp_size { TST_HUGE, TST_GIGANTIC }?

In theory more sizes can be added.

>
>  /*
> @@ -35,6 +36,11 @@ struct tst_hugepage {
>   */
>  size_t tst_get_hugepage_size(void);
>
> +/*
> + * Get the gigantic hugepage size. Returns 0 if hugepages are not
> supported.
> + */
> +size_t tst_get_gigantic_size(void);
> +
>  /*
>   * Try the best to request a specified number of huge pages from system,
>   * it will store the reserved hpage number in tst_hugepages.
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> index f4b18bbbf..568884fbb 100644
> --- a/lib/tst_hugepage.c
> +++ b/lib/tst_hugepage.c
> @@ -21,6 +21,30 @@ size_t tst_get_hugepage_size(void)
>         return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
>  }
>
> +/* Check if hugetlb page is gigantic */
> +static inline int is_hugetlb_gigantic(unsigned long hpage_size)
> +{
> +       return (hpage_size / getpagesize()) >> 11;
> +}

What is 11? If it is the order or shift of hugepages then that is not
constant (see below).

> +
> +size_t tst_get_gigantic_size(void)
> +{
> +       DIR *dir;
> +       struct dirent *ent;
> +       unsigned long g_hpage_size;
> +
> +       dir = SAFE_OPENDIR(PATH_HUGEPAGES);
> +       while ((ent = SAFE_READDIR(dir))) {
> +               if ((sscanf(ent->d_name, "hugepages-%lukB", &g_hpage_size)
> == 1) &&
> +                       is_hugetlb_gigantic(g_hpage_size * 1024)) {
> +                       break;
> +               }
> +       }

I guess in theory more gigantic page sizes could be added. I'm not sure
what size we should pick, but we don't want it to be random because it
would make debugging more difficult.

So could we search for the smallest size (hugepagesize) and second
smallest (smallest gigantic page)?

> +
> +       SAFE_CLOSEDIR(dir);
> +       return g_hpage_size * 1024;
> +}
> +
>  unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
>  {
>         unsigned long val, max_hpages, hpsize;
> @@ -43,10 +67,10 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage
> *hp)
>         else
>                 tst_hugepages = hp->number;
>
> -       if (hp->hpsize)
> -               hpsize = hp->hpsize;
> +       if (hp->policy & (TST_NEEDS_G | TST_REQUEST_G))
> +               hpsize = tst_get_gigantic_size() / 1024;
>         else
> -               hpsize = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE);
> +               hpsize = tst_get_hugepage_size() / 1024;
>
>         sprintf(hugepage_path,
> PATH_HUGEPAGES"/hugepages-%lukB/nr_hugepages", hpsize);
>         if (access(hugepage_path, F_OK)) {
>
>
>
>
> -- 
> Regards,
> Li Wang


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
