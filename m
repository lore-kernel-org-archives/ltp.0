Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A386CC433EF
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 03:04:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C8883C9757
	for <ltp@archiver.kernel.org>; Fri, 28 Jan 2022 04:04:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C3F73C942C
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 04:03:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 401751000958
 for <ltp@lists.linux.it>; Fri, 28 Jan 2022 04:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643339033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4w0HyWB+s5C4rZA0aqIDn0ttUyre9iMgp14W91zGgD4=;
 b=IDCqraotFG3GC21PZPv4w22aheezkSnS7H1Dt42B52Bs+G510x7yLtcoy70EiXYeZ6Ipwe
 AhHppyYpShrm5bk3tal/P3UNIJdwTBqCV1xi8ot8wc91bOj7wblYm6UievRqyy9F+7NHya
 w3QYeTBBhvxMcIKKD/dcX4e/tErM8K0=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-NfX3BV0fOBeO-HSZP7IwTA-1; Thu, 27 Jan 2022 22:03:52 -0500
X-MC-Unique: NfX3BV0fOBeO-HSZP7IwTA-1
Received: by mail-yb1-f197.google.com with SMTP id
 c7-20020a25a2c7000000b00613e4dbaf97so9874262ybn.13
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 19:03:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4w0HyWB+s5C4rZA0aqIDn0ttUyre9iMgp14W91zGgD4=;
 b=Z5bxhg/bhWJ3CYXC/iWpyPKsawKlmdc4vU0BOZHzSFxvlE6crOwgIPvD9VsKTmEvKc
 Z4nyJhsU9e9ee1OCZ3Zv9SIP+HxXd4cCHKeaWw0NoyquI12DjAb7+VL63GUwLn23wuZN
 4A0csgc0W3rfFMIn/3xjICXgTGxqjBHTmrDi5re7927AuiyifS/Psk3nqjpbs9hxca+h
 Vo2L54G1JikRbLHyCYn7ZnTaOJ+F33/ab0BU9NjWXM9JMFh3KgdihIbDVh7fszANu291
 1iV0oLp8IMm86Nri7ulwoGqaPsAAs8Q0nXPOMuLHVd8Idtl0jIH+/AS7nn+zs+Mj+PJj
 kzXA==
X-Gm-Message-State: AOAM532dDGJOwwaHYajSaH9jmJz0K+krBw4HGTonrcmv4KT/RdUzZE3S
 M7jzOmjjEUuSPHsWLfnwgJhPMPvyvT1YjcoZSDGt536tRXychnxKh/zy+4gEppkIqPCZrW6Fy+S
 jEsgdHmMzc91LciVc5a2bdpsRHXE=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr10018313ybp.71.1643339031695; 
 Thu, 27 Jan 2022 19:03:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyijMXQnQgtE9nzi6nGVwDBH1WFDM+Fr8FnuIZY9LtRPsGOfPnnf8cTjmih3dIsskuwgkXWxxj0vbdXdtlwpO0=
X-Received: by 2002:a5b:14c:: with SMTP id c12mr10018287ybp.71.1643339031352; 
 Thu, 27 Jan 2022 19:03:51 -0800 (PST)
MIME-Version: 1.0
References: <e5f8d6b684e4ee5733768442a7378c94fc963632.1643278075.git.jstancek@redhat.com>
 <YfKjpzPZyt3BejVB@pevik>
In-Reply-To: <YfKjpzPZyt3BejVB@pevik>
From: Li Wang <liwang@redhat.com>
Date: Fri, 28 Jan 2022 11:03:30 +0800
Message-ID: <CAEemH2fobbaU8-UO8RPKYVOvOdgdupdsR9gmO2a9o82xB9W19A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_gettime03: multiply the timediff if test in
 VM
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jan 27, 2022 at 9:52 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Jan,
>
> > Similar to 59e73f295dc7 ("clock_gettime04: multiply the
> > timediff if test in VM"), extend tolerance for this test too.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Makes sense, thanks!

Patch merged, thanks~

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
