Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F90FC3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 07:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746774076; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=UyOhAzaIMw2L1Oxgj4peVm8ZyfwbHQhyygd7Lyv8wWE=;
 b=RGVhE5TzD7kcN1BcSZO3JOdkGkExEfSqObyLlR1ouIbFCHmd5XQq6w4tfmI+sJNjUsXHB
 KkESeaEByi7E/ii4qtUzf4QSjKV6w1mtOo28ydn3zcvKvabARJNkt4iLKxFQl6S9uwhoYQq
 AyAPtxWvqkM/lYPdeRr99TVAeOobsXk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF2943CC179
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 09:01:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5F553C1AEE
 for <ltp@lists.linux.it>; Fri,  9 May 2025 09:00:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 45519200760
 for <ltp@lists.linux.it>; Fri,  9 May 2025 09:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746774052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WNDjAl1nJqkiQRuWIcLSVLRDvoB2wbzrkxloVFMsAOI=;
 b=i6fRz9/Pi91OsaViYtC4whLxqp0rd+P6edl+FFU0tlQYtuccJoAbc/DS38wyW58vDgbGWQ
 5DeJvl2Whl5G9oG7Fi8gj1ISPn0SlcW4HDfHEKotUiJjcRL/zCwgu8d3pJ4IXs7YQNDfh+
 Xz/YVBtHz0geIrZt5yNEsC3Or7IP44k=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-9c1SRkGsOo225rnSh-6Dew-1; Fri, 09 May 2025 03:00:51 -0400
X-MC-Unique: 9c1SRkGsOo225rnSh-6Dew-1
X-Mimecast-MFC-AGG-ID: 9c1SRkGsOo225rnSh-6Dew_1746774049
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b1fdf8f67e6so1189873a12.2
 for <ltp@lists.linux.it>; Fri, 09 May 2025 00:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746774049; x=1747378849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WNDjAl1nJqkiQRuWIcLSVLRDvoB2wbzrkxloVFMsAOI=;
 b=YHaIOWjwb4R9J5GIYLoyVLVG4Nr7vJTU1FT2C4VBJ5ASphipENB6YyOua8RzVmtzsf
 o9jN2311cVItAjBiAeiZC3NqR8h4VVz86InQbRBjarc1uYUgM9d/yAE6jpvPHyVlCM9r
 WTWxGprTamfHXm/htML/nhtNInHJUDJl96XqxTxLgJ1GTrtf9wMazfaUCP68/datTwst
 i1d0nuKtENEO0QgOvQKHDzkcnGCBJUk+I8kTITt9LiTemG5NQVj4cY6ndfW72sbK6xUX
 Pm0HKYgA9WCAa+ZF3qPCGFnBliIuW9xHMjaR8ItVEU3vlLLkihjF50FIbQUWPTo+lz7/
 cY4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkHG+VhPnE1BFuqcJ1kJ7rXNdqdkTJom/76oeWeWwp+NYHKwGwZhoy9oABztfFQ7ENhwE=@lists.linux.it
X-Gm-Message-State: AOJu0YzoTrKaFTPYjt38QQd5Q6GLnLEl9prV7W5EUyv/u9ZJYhZJOe61
 DTa7JwDrWXqOomv7UiJQ7q1VgQWJKv29/t8HGgpYyMdduSrk8huBgZW715jSYNM7FxaBbxVmj9/
 WrjIC2p9KLlcubxoq8f0RtKrzKmRTytxFk4P4ZY1EzJtZ9xaNza5LuO7Fk/+T61sLpZiMlJuKhj
 AkUmtkRrVM3k5k20b0vcWCvwQ=
X-Gm-Gg: ASbGncu5W2J27kfSl+dcHK4bDiJZl9fCUBrYlHzAcgDAw8tme9xwPlFlKnNfVM3MNEb
 WvmKb6bFvwLDO4rkN+gnxnORestaLKpsV7EroQlUWRbAl6+5BA1iJWQsV0HLFVlIUd7lGYA==
X-Received: by 2002:a17:90b:4fd2:b0:30a:3e8e:492c with SMTP id
 98e67ed59e1d1-30c3d650661mr3665169a91.32.1746774049173; 
 Fri, 09 May 2025 00:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5KGqb0WCUwUHFsxEz8UOBgQ9B2pzArBW/Kc+2l36OmaK17jB0Ii7SW27UrnFY5XN4oLaisT/Y1dLywtnTqI4=
X-Received: by 2002:a17:90b:4fd2:b0:30a:3e8e:492c with SMTP id
 98e67ed59e1d1-30c3d650661mr3665137a91.32.1746774048912; Fri, 09 May 2025
 00:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250109132334.212281-1-pvorel@suse.cz>
 <20250109132334.212281-2-pvorel@suse.cz>
 <a8437881-a652-4847-9907-41922126bece@suse.com>
 <20250110145726.GA413134@pevik>
In-Reply-To: <20250110145726.GA413134@pevik>
Date: Fri, 9 May 2025 15:00:35 +0800
X-Gm-Features: ATxdqUEz0Ua-5DTj2wzqEl9AEuc4TdvxBcb39oKRBZgRm0qb6f_6IBFMgSw93SU
Message-ID: <CAEemH2eF=ZR+vChd0RG1KXM8vUCCH=k6qNhh8hytsrhWWOereA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kEzioSKRsfV5wE2hIxT_ru3kn9nnI1V5tTusCQPkQy0_1746774049
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] macros: Add basic docs
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

Petr Vorel <pvorel@suse.cz> wrote:

> > > + * DOC: tst_test_macros.h -- helpers for testing syscalls
> > >    */
> > Is this really needed?
>
> Well, IMHO throwing just functions description to users is not enough.
> I would even add a short description about the goal of these macros.
>
> And because sooner or later as we increase sphinx doc in the headers the list
> will be quite long. Therefore for the start I added just a title (short
> paragraph with a description would be of curse  better).

+1

Sometimes the file name doesn't reflect everything about the
content, adding a short description helps to understand.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
