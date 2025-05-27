Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02888C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 10:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748340494; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1gBCqsOdxCEdl3IOwHmnJ5PM51ah5PMSRjR2xcM8h3w=;
 b=O3OBQquSdO1Q8YlkaVJGxFUt56353ioAcKPr5sfb5NcLw62eTV4oOtSWcy2I7ktFGiACD
 4IoT9Li1bsIr45Ot1VwGcZ2KZDVm27WaQ2QCaWRS7D+0e3aQBVyaeY4f3OVU3VS1B6FdGjS
 sC9wsP8LWGJd2UiN0Fn3TEapsFJanK0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59B253C56B2
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 12:08:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 190513C19ED
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:07:53 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7408110007CA
 for <ltp@lists.linux.it>; Tue, 27 May 2025 12:07:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748340470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JvysihV9zY6tTU3ibEkXeyEtwkhPdLoksKoJVAJtOv8=;
 b=aANRbNNKtbOL7B0YW0npETG762UMPaGHJJBZRy2MCVOiuawKD9FQOEmVMBN4hmxIHr4WWB
 dG8ZIYbCwRecPv6WOAB6kYyYaFKEgiBQnnK4wbPg3dfcfJnaTxbD1HOCSMf95tdF34dJEp
 WzzW+fUkW76grE+fknL8mvn7lpeajdQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-EpiLxJkZNQSzAfjeamdvug-1; Tue, 27 May 2025 06:07:49 -0400
X-MC-Unique: EpiLxJkZNQSzAfjeamdvug-1
X-Mimecast-MFC-AGG-ID: EpiLxJkZNQSzAfjeamdvug_1748340468
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3119ba092aeso1504022a91.1
 for <ltp@lists.linux.it>; Tue, 27 May 2025 03:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748340466; x=1748945266;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JvysihV9zY6tTU3ibEkXeyEtwkhPdLoksKoJVAJtOv8=;
 b=btFFQ1+uMZld2USju3HQ9D2DVxdaIkmvtEQS+9K3LZtvEQ6FVgCePTKODePmCMy+u3
 BbinN5kw+Ye2bJloOqzINJ7JCFpyZLsZLbFSrBJ3ZKGxSRACImwAkeey4uxn51GJ++OE
 erd7fdWGJgTD7NoMzk+UcN2KNLkqYWcv2DFOR/XUlbC26fOG9lGJkThONR7+cX+0vqXz
 Iu0iN/SY8GXQPToQsRrPqL+dDTh4dodAWZ4lTSN+++pgGnPENEZc9SlKDZXOuYmBT49B
 dOrWjR+LcZ2kKLHRRHcmymJSQD1tuOmYWuNgKrTocWMnn8BpIsNj6KN+Vxk5zP3/FY3b
 v3gw==
X-Gm-Message-State: AOJu0Yx7mpXJC0mYv6Oe1EbInvvcz+WFPuPjdq08kuuM8eeqMvWrdCQW
 s69292JERt47C9UuK9mvrXHyWLIa7zwz+NuPzNKRpQrcEW4CIhS7pro3crEpnYLJsskTkfxNLVb
 qNY8fcYcjf+MeKsd4YnMXaBPDpY1Z95g3lNOVwKRxPl2QxLDR9fmqKEMNCl8omt2FPg4neXDL/N
 mnKxn6Y+v5+6figzx21urkLA8KpoPZi9Abnb8RZA==
X-Gm-Gg: ASbGncuxfI6pgxFSr840uBk/9BCQiqhs34KZ5UKQ0OBAwFaWViZjJFDaDnD3sLC1HRr
 u94O2TqS0PzAKNR2H8q8z+tSl3iBydnBITZsdoe1WdBz/LofAtK3l9OJrWg8jv0KN9zMasQ==
X-Received: by 2002:a17:90b:52c6:b0:306:b593:4557 with SMTP id
 98e67ed59e1d1-3110f112705mr19605577a91.4.1748340465655; 
 Tue, 27 May 2025 03:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+TO/uMq5F6ZTWY1fVqCENVnZcId9OcXVEF6CiWNal2thPfEpEuBuH6xOQIH7XiRfWUUlH0G+DGP/GElcyqxA=
X-Received: by 2002:a17:90b:52c6:b0:306:b593:4557 with SMTP id
 98e67ed59e1d1-3110f112705mr19605547a91.4.1748340465310; Tue, 27 May 2025
 03:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250527094415.4760-1-andrea.cervesato@suse.de>
In-Reply-To: <20250527094415.4760-1-andrea.cervesato@suse.de>
Date: Tue, 27 May 2025 18:07:32 +0800
X-Gm-Features: AX0GCFuIKqVjorFvGFiZdMDIv0JZ7tk5Ve6tWKPnHhRouEZdWsm_bfN4ZLovhUk
Message-ID: <CAEemH2eGQP6k1cSDH42c=ZXLHtXdekDh5H_nWSr0o1_=j1i8ug@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fWIXkKaCCUYjTe2GROZm5mPWX4sgWqDdXT_FHJJ0_3U_1748340468
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kirk: version 2.1
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Li Wang <liwang@redhat.com>

RBT is to this patch. Thanks!

If you feel json2logs (to compatible old log format) can be widely used,
I can send it as a separate patch. Otherwise, I will only keep it as our
internal patch.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
