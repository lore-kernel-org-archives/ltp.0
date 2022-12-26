Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F105C4167B
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 09:48:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2435B3CB878
	for <ltp@archiver.kernel.org>; Mon, 26 Dec 2022 10:48:37 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA4D63C899B
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 10:48:26 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 658FD6005C3
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 10:48:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672048101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qVJNo+MW/IIEMZDrSZSGsODpM48jKD0pOH7tMvr38RI=;
 b=Az+HCqPmM1lJTGD26lTznZUC48QgoHhqN0Qy2JT1gP7Z4VO680k0Mxn/x6hF1Vd1N7MYq1
 Hof9oYieEb974+vSm4XQAWWsy5333rHfpYlA70/auVKNy7ThrsC2sjOtv2xSLCj/qoGUwc
 GNoXST/EQPHTpnxgsUXVrn/1H+NI/Ww=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-460-MmRXMCwAMNKwsCpikF6Vgw-1; Mon, 26 Dec 2022 04:48:17 -0500
X-MC-Unique: MmRXMCwAMNKwsCpikF6Vgw-1
Received: by mail-wm1-f71.google.com with SMTP id
 m38-20020a05600c3b2600b003d23f8c6ebdso4860242wms.0
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 01:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qVJNo+MW/IIEMZDrSZSGsODpM48jKD0pOH7tMvr38RI=;
 b=PwvqtUmxtJxXjDEKRzR0HcgpLLmYTcBKuFWYoLVe5URGrL1m59/ck3xNiK+q6HTXpf
 JOfaEQlXE4Wm8vm4Lr4OsN3wsOSF3+RKL3QUjNM9j5Cj3xYOLP4h/EnnylxvG0p47v/b
 lq7Tgh6hKPKpyNn69H4AxLifIjLtlcTpraiJCzYhvxHB+Zv2qX9f1rgm4m7PuWGRPT5p
 dqGiUK8S+dN37K5xajtHIwbVtRh5IaOfyxjvFyj8UC6ljBphZ2PE6Jew3lZo2zplyu7f
 dGB5Ll6fkMEeLXXLNbFbT5nWU8I7qoeG7M62kz767xgwZXrxib+ur+KXYPRu6NL0HbQ9
 /vGg==
X-Gm-Message-State: AFqh2kpLnttY/uQlr5RzNvQJUQFp/XLscAQjKRWe5XlnJeWx8rqeoKtk
 W92ethvLeMEHlHY84I22VGVjvM/INJ2WwD/YFMAO2NJpstvKBt/rTwKVcWZMT3fcwKWeq66g/ds
 EJRTXhH995Hid8XNM9LSJcbVJSXE=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr683367wrr.528.1672048096783; 
 Mon, 26 Dec 2022 01:48:16 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvxPPbw9cjyssw8QeirFvvCJ2jJOTQKdtBmJATykJzNV9EZVfkvK3f6oU6Z4NV+Wt3QgRK6NjABAt8YyD4+7no=
X-Received: by 2002:a5d:444d:0:b0:242:3a48:1757 with SMTP id
 x13-20020a5d444d000000b002423a481757mr683365wrr.528.1672048096545; Mon, 26
 Dec 2022 01:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-2-tsahu@linux.ibm.com>
 <CAEemH2eyO686YNSSdRE7vDhyU9qYEsdNLfwFUiv_a+jK1QeLiA@mail.gmail.com>
 <20221226093908.hfcf4o25wfh2zfsp@tarunpc>
In-Reply-To: <20221226093908.hfcf4o25wfh2zfsp@tarunpc>
From: Li Wang <liwang@redhat.com>
Date: Mon, 26 Dec 2022 17:48:05 +0800
Message-ID: <CAEemH2csQriyVe2jv5dz+A0FtHnZKS-NmDygkFWBik=5_ssQcQ@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 01/13] Hugetlb: Migrating libhugetlbfs mlock
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
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Dec 26, 2022 at 5:39 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:

> Hi Li,
> Thanks for reviewing the patch.
> Please find my comments inline.
>
> --skip
> On Dec 26 2022, Li Wang wrote:
> > On Sun, Dec 25, 2022 at 11:42 PM Tarun Sahu <tsahu@linux.ibm.com> wrote:
> > > +static void run_test(void)
> > > +{
> > >
> >
> >
> >
> > > +       struct rlimit limit_info;
> > > +
> > > +       if (getrlimit(RLIMIT_MEMLOCK, &limit_info))
> > > +               tst_res(TWARN|TERRNO, "Unable to read locked memory
> > > rlimit");
> > > +       if (limit_info.rlim_cur < hpage_size)
> > > +               tst_brk(TCONF, "Locked memory ulimit set below huge
> page
> > > size");
> > >
> >
> > These lines are better for moving into setup() phase. And, I'd propose
> > printing the value of 'limit_info.rlim_cur' and 'hpage_size' when TCONF.
> >
> > The default value of max-locked-memory is smaller than hpage_size on
> > both RHEL8 and 9, which means this test will TCONF and skip running.
> > I'm hesitating should we temporally cancel the limitations and make
> > this test can really perform then restore that value to the original,
> > is this change make sense? WDYT?
> >
> Yeah, Incase if limit is smaller than expected, we can change it
> temporarily
> to run the test. Will update in next revision. Also will change,
> getrlimit/setrlimit function to SAFE_*.
>
>
> >
> >
> > > +
> > > +       test_simple_mlock(MAP_PRIVATE, "MAP_PRIVATE");
> > > +       test_simple_mlock(MAP_SHARED, "MAP_SHARED");
> > > +       test_simple_mlock(MAP_PRIVATE|MAP_LOCKED,
> > > "MAP_PRIVATE|MAP_LOCKED");
> > > +       test_simple_mlock(MAP_SHARED|MAP_LOCKED,
> "MAP_SHARED|MAP_LOCKED");
> > >
> >
> > If we define an additional function like flags_to_str(int flags) for
> > converting
> > the flag into a string, which will be more simple for reading.
> >
> > static char *flags_to_str(int flags)
> > {
> >        ...
> > }
> >
> > static void test_simple_mlock(int flags)
> > {
> >         char *flags_str = flags_to_str(flags);
> >         ...
> > }
> >
> It was not used so often and only some specific flags are used. I think
> if there will be more general use case being some more mmap flags used in
> application, then it would be good to change this to function.
>
> Another way is to define a macro like
>
> #define FLAGS_STR(flag) #flag
>
> and pass it like: test_simple_mlock(flag, FLAGS_STR(flag));
>
> But I thought, it is like passing the string itself.
>
> what do you think?
>

Yes sure, and I think of we have TST_TO_STR() in LTP as well.

$ git grep TST_TO_STR
tst_common.h:#define TST_TO_STR_(s) #s
tst_common.h:#define TST_TO_STR(s) TST_TO_STR_(s)

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
