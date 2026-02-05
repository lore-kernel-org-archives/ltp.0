Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0014BEC1E86
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770286664; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CBP0FvoYatenE/kSc4C2kayhJkCnzvzhLnjR8EHwoEs=;
 b=Gz87LKxK8WD4xNdl9hwgBa6DOorCyHxxw5e0pd4u0DQVMjLOtCUveQxzoi1rXF5531C9N
 7MzP0vjlC3I3kMoa5Iz4O0m5e+skvj22/Rv4nKISq7hUxsAGuStYJWwOw39gxYyLXyHeNbo
 htdxAOchVoMY/n+q/LraELgdv09t4Oo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B7D73CE35F
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 11:17:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 024403CE20E
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 11:17:20 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 038A4200239
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 11:17:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770286637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PYhJz7lKnvArDC4RqjxPJWX7LyYacQxMruMysY9Vf+0=;
 b=XOtlawqzVyqWNOL6m+jV2fxZMg1oIrdp7DVyPQ4mkcKxFa6WIQjk/rd9hGGx2/mpuCeJ/C
 /mTksOXDcRaLRiF8XcGqgy45apnMNHq3C44i5kEjEWlWiJroEYtB2pFph8X3jVAoLzSVnG
 EKqdMfoA0p+qWv3xnD241Ws1y6+ggn4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-YHBu15FjMvy55WASMBQ-Pg-1; Thu, 05 Feb 2026 05:17:15 -0500
X-MC-Unique: YHBu15FjMvy55WASMBQ-Pg-1
X-Mimecast-MFC-AGG-ID: YHBu15FjMvy55WASMBQ-Pg_1770286635
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b5edecdf94eso2026637a12.2
 for <ltp@lists.linux.it>; Thu, 05 Feb 2026 02:17:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770286635; x=1770891435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYhJz7lKnvArDC4RqjxPJWX7LyYacQxMruMysY9Vf+0=;
 b=ZplmXErSpA3cncikAKJb6DclVJJUK1AFyE7pIs5hHLhre1pAlzxThqU5IETS0Lz+T1
 D1TorcQF88SGCLuICWTOdsuS5qrgkZshbDOVO06C31SnfTVVBLWnEgu9H0r0KXjJ9u7J
 cigtOvThRB9ogqnlzRWzkzHCNVH61iAkT6jzoJaC+sLRIBz1rQKz0oBDw4V00xTkyAPa
 aRXWIfojJmf7WqugVviEyK7xBaDhlt9QhN0GdoxS1JsHRbUwQJOhIWVKxmrG5J8hgfjW
 CADoFQ2qQqT4wzJL5TtQTt9Wp9OufrAKaRErkpiR/T2Y7OvUE4POpLDRSmHfC/nx68Zu
 cWUw==
X-Gm-Message-State: AOJu0YyqvDQ9Q7URHUXyQiqzl055J610ey+ikEJtpDqrInqHvbJ578ub
 7MRh2YG9ZNoRW8G8xF5Al1rDCy2KcIWUx4GjNcYMGpEWYdOAVncSSdMn7Dcy9wd/u+jo5Ml8GU9
 L8LcxhclH4uK43a44eV+rH314y6bx0EcgpS/M8bsy1Sc7lXMzb+6r
X-Gm-Gg: AZuq6aLOMpkHZtFq/WwiTZQxHTVGbf7N43olk2Ir81CmMCrOfXKo0hHtBw5Fcg/GFQ6
 WtFpfkVMQfDM+Y8a967D8E8uJozWDkbTIBQ/nWS6FZcMuMfcfaO9ngztgExD6fIdfhvpuiU077v
 TvqZvug41xryXhQezf2haulOT2STileo+uoKEWfQ2p/Rw27Bk+kgk5bGgki6/0jGDzB9dw0dmS2
 c1I7lTBKIXXm5uxqoy5NrKyyc3stRWz8pr0+Wk/VuGzkMS/I9QBEaMuDS7U+nTDw4gLLtiE0y29
 MJLHaC2/5KcDzZ4W/9F0BDaZ5AshvD0i89+wmoHTTtI4JS7jaSCdWr6lFs2/VkLbRmlHnm+Iuzj
 TRNop
X-Received: by 2002:a05:6a20:7345:b0:38f:df47:87a0 with SMTP id
 adf61e73a8af0-3937249d02emr6555709637.61.1770286634967; 
 Thu, 05 Feb 2026 02:17:14 -0800 (PST)
X-Received: by 2002:a05:6a20:7345:b0:38f:df47:87a0 with SMTP id
 adf61e73a8af0-3937249d02emr6555698637.61.1770286634626; 
 Thu, 05 Feb 2026 02:17:14 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c8360c2e6sm4345769a12.16.2026.02.05.02.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 02:17:13 -0800 (PST)
Date: Thu, 5 Feb 2026 18:17:11 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYRuJ9BuS_MutfOD@redhat.com>
References: <20260204124323.244578-1-pvorel@suse.cz>
 <aYQz6gN7WvJbSg1k@redhat.com> <20260205094458.GA294817@pevik>
MIME-Version: 1.0
In-Reply-To: <20260205094458.GA294817@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eAkW5WDAQqdMv1beqXUEI_LUexwRYSDfYWbvdWCY2zo_1770286635
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] openat2: Move includes to lapi, remove _GNU_SOURCE
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

On Thu, Feb 05, 2026 at 10:44:58AM +0100, Petr Vorel wrote:
> > On Wed, Feb 04, 2026 at 01:43:23PM +0100, Petr Vorel wrote:
> > > Improve 767b3e519e. struct open_how is also used in lapi/openat2.h,
> > > which is used by all openat2*.c tests.  Therefore move <fcntl.h> to the
> > > lapi header (and use lapi/fcntl.h instead).
> 
> > > Also remove _GNU_SOURCE which should not be needed.
> 
> > > While at it, move include "config.h" to the top.
> 
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > Hi Li,
> 
> > > my points from the original patchset why not use _GNU_SOURCE:
> 
> > > glibc test tst-openat2.c [1] which includes <fcntl.h>, uses struct
> 
> > Interesting, I haven't figure out why it can be built within glibc itself.
> 
> I also checked Makefile, but haven't found that. Never mind, I was wrong, it's
> obviously needed.

It's becuase of -D_GNU_SOURCE cflag in Makerules(which included in Makefile):
https://sourceware.org/git/?p=glibc.git;a=blob;f=Makerules;h=30c3559a285e5bc0571358ab785bf9b5d5a8f449;hb=HEAD#l1182

In case of you miss my last reply thread:
https://lists.linux.it/pipermail/ltp/2026-February/046438.html

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
