Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9080C433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 11:42:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2C260C41
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 11:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0B2C260C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2CB3C681F
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 13:42:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E1123C65EB
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 13:42:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 197C760082D
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 13:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635248558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hgwQGsqdmlUmlsBZ/zO4prxthan5+aNJWnlHeg6CFo4=;
 b=Qeqqeh4wlzlenvbd4Ph3V52zPdZLKZ/ZoyW96ebgRTfbous5BfhNmRCRUAMqIxU44L6X6Y
 l71iNQb8G0InDJcgePbyNbX7eixkimfv1b4utwV6lUZPjk8rJI/J7iGiZs57MHcUesCMHz
 Smq/42+szyvrdKwyRmiyePs4cdh0oPk=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-0OXzRXGrNZS147i9I3AcGQ-1; Tue, 26 Oct 2021 07:42:37 -0400
X-MC-Unique: 0OXzRXGrNZS147i9I3AcGQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 s143-20020acaa995000000b0029997b94a79so8802340oie.13
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 04:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hgwQGsqdmlUmlsBZ/zO4prxthan5+aNJWnlHeg6CFo4=;
 b=ViEEN485u9P9hJ/P8RXGZjSQvnrZ6u0/a2hvvGyQP0DTdaxeO3pf/aWrMNd0gN9ye+
 rfEudOmRwKNXozyhsnFUmsE0ShYQxWBJh+5237pCcXes7Qfk1FMjiEnVYwvULYf7zsNA
 L3sUmWkpe7WK4DXe+LMYGYnkQpJSSrc7LbbANx2udrSRLHIa4B7jBb2DZNk1pQwjpvyB
 p0UVBf6gEo3P3+VBg/oqlmYFH93iUkpG1lc3AuQdE1JhawGwomcYwRa5z4T6rG95OMDc
 q88QF72zpScnXLJiVEeSKZdgeomLAChLmqrn3oSZQrusSe1vTKAwzW5PbNr/UkZfiMME
 vKAA==
X-Gm-Message-State: AOAM531f6OIKqmyPIdxZ7mVdSnpWGO7TgvVXZALNyyGTNSBFiJx1u4Uq
 J+A443ffCYhTWniE1KHXv2i0MEEzCyQzMW83F9pl2boUoT1BT+RqspfhNY6MZcudyvBAVhD68rA
 As6GFP45RQ8+S13c5JP30jFJX5ko=
X-Received: by 2002:a05:6808:140b:: with SMTP id
 w11mr16346438oiv.45.1635248556837; 
 Tue, 26 Oct 2021 04:42:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1E9VIOk3xPYYEMOsZ0fLc/W+pj4KbRhMex1fTvnBbFqCBqFui+IVzFWIONSfbzXg0c7FVCydfmS44kHzP6XY=
X-Received: by 2002:a05:6808:140b:: with SMTP id
 w11mr16346405oiv.45.1635248556479; 
 Tue, 26 Oct 2021 04:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211025160134.9283-1-chrubis@suse.cz>
 <20211025160134.9283-3-chrubis@suse.cz>
In-Reply-To: <20211025160134.9283-3-chrubis@suse.cz>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Oct 2021 13:42:20 +0200
Message-ID: <CAASaF6ziq8EbnvywTtdJeSfQkcyE7Gvc9Rn9NK-rk-gimp6ysg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] lib: Add .max_runtime and
 tst_remaining_runtime()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 25, 2021 at 6:01 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> This is another attempt of decoupling test runtime from timeouts.
>
> Fundamentally there are two types of tests in LTP. First type are tests
> that are rather quick (much less than a second) and can live with
> whatever default timeout we set up. Second type of tests are tests that
> run in a loop until timeout or a number of iterations is reached, these
> are the tests that are going to be converted to the .max_runtime added
> by this patch and followups.
>
> This patch does:
>
> - adds .max_runtime to tst_test structure - this is the maximal runtime
>   per test iteration

I'm looking at the series, but I'm not sure I see much difference between
runtime and timeout. Other than some margin added by library (the MAX formula)
is there some other difference?

>
> - if .max_runtime is set
>   - test timeout is computed based on it and set as:
>     max_runtime + MAX(10, max_runtime)
>
>   - the -I option is mapped to the max runtime
>     this nicely unifies the test runtime command line option
>
> - replaces the tst_timeout_remining() whith tst_remaining_runtime() and
>   simplifies the code since we do no have to keep any margin for the
>   timeout, since we computed the timeout based on the runtime
>
> Side efect of this work is that all tests that use
> tst_remaining_runtime() must define it's runtime explicitelly which I
> think is step into the right direction as well.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---

<snip>

> diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
> index 220130f4b..e43bc5888 100644
> --- a/testcases/kernel/syscalls/move_pages/move_pages12.c
> +++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
> @@ -153,7 +153,6 @@ static void do_test(unsigned int n)
>         void *ptr;
>         pid_t cpid = -1;
>         int status;
> -       unsigned int twenty_percent = (tst_timeout_remaining() / 5);
>
>         addr = SAFE_MMAP(NULL, tcases[n].tpages * hpsz, PROT_READ | PROT_WRITE,
>                 MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
> @@ -198,7 +197,7 @@ static void do_test(unsigned int n)
>
>                 SAFE_MUNMAP(addr, tcases[n].tpages * hpsz);
>
> -               if (tst_timeout_remaining() < twenty_percent)
> +               if (!tst_remaining_runtime())
>                         break;
>         }
>
> @@ -339,6 +338,7 @@ static struct tst_test test = {
>         .forks_child = 1,
>         .setup = setup,
>         .cleanup = cleanup,
> +       .max_runtime = 60,

Where does 60 come from?


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
