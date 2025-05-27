Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABEBC54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 08:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748336162; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zxOPiFv3Xg8IV0dHQowyfp9JaZCwKcYtWzLhh7ODSM4=;
 b=kP5C7+eLB+/2Sqc3GQef4FERkuqeDSPGJNMrNVFxrakbB5UKoiziVn9jA5tJrk0RwjGS6
 lspgIhpK5rmUAfyMNQ6vTVXziutIsk3u1CImczW6jgPfu9yCg9NM+TZzG8mMTZ6DlATP1T7
 1o5UNmngo0086TgoMzPWVH7JgaivCzg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 948533C5529
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 10:56:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3601E3C535B
 for <ltp@lists.linux.it>; Tue, 27 May 2025 10:55:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81E251C0131D
 for <ltp@lists.linux.it>; Tue, 27 May 2025 10:55:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748336139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1r/G5k9BwQdZDTEiaL48FJ9xLI50+4a1Ok2cAtoedR8=;
 b=JNbht4pzVV4k4NqB4V94VJF5oHU6CcrXqQwtGehHrd84bcIXPK5lq/4mbVRJL/gwj+vepR
 2rR/8xfMQIEUPnz3NYDztlYXyDAHhlVxqtSWnBAP3sOqVyLj0MIwrjLKt9nOu9Wi8lXr7y
 2VpxbtvbcMJsyKLEeYNdYoS7DkOMkyQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-KGO4t9sAPnO4KQPuaIrn8g-1; Tue, 27 May 2025 04:55:38 -0400
X-MC-Unique: KGO4t9sAPnO4KQPuaIrn8g-1
X-Mimecast-MFC-AGG-ID: KGO4t9sAPnO4KQPuaIrn8g_1748336137
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3111be3bba7so2333722a91.2
 for <ltp@lists.linux.it>; Tue, 27 May 2025 01:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748336136; x=1748940936;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1r/G5k9BwQdZDTEiaL48FJ9xLI50+4a1Ok2cAtoedR8=;
 b=EuzUz+KijzikN+scb4Zl8TvAfusAXDK7C0HSvYXvMwua2h3r/pbfdMqaU4nalEP6AR
 UrLEb9j0J/45xzK+gV7V13F/ULUk2O65xjL/Lohsqx5h+Q1Ziyomcefb46dckcHM+OHF
 bMTsWbwcEbiDSGSjM0n2W9DnBsi6tCgfjf7/UWNPFUsI3Lp5IJFkKiux8FdJ3lRWppjT
 VbktY7G9jJAIr+7rgsyEB/XIx3i+mgfxJdFM1jEXDCuAqWuBuo73Go5xF60wDe7mAGCY
 V1vjELVnIr74b04Uz4PJtTAmuo3paU7HRikBASg2QvGjqNeZdFRUaNpUmkrNsRL8KrY5
 Wmbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/md5RQK5p820bwkxqGP0mVGatIaq6htNoLH4dxf2kNlsZ+dtINKcBWaKk9B8y/4vIhn4=@lists.linux.it
X-Gm-Message-State: AOJu0Yy0TOPqEfCpo5FfiGDVMtgdCFOUVJKaWtDIZBBd8ov0MnNFeI1X
 ubiGsyCRYNVkbHD+q1xYZ4NI/2GNIbcu/zY4z19g9aXm5EOXGceIq9I3uadXcmgL/1hQktY3UYq
 4N590ZxG4kVRouYK6CAKz4psMkuBQ9uFCpWOJ9k4rY7NMXgYFUy9NtT2b9Hp5VwWqWmaJt6Un7x
 sBVVmccYJWoV46kCTcGQ8jAxSu+CbH2JNUjs14/w==
X-Gm-Gg: ASbGncsqiRaVz3YyJtxlmgxcZNTQsJEusFSJAOzoiY54DM4a4hZj9wixUKf8JYXmf1y
 FXrui+yNqyyFF0LBlb7WvR+uzact/kGpKl9Y5VJ5L3v1Z+gvjcH8Owc+tn+dC1eZ9nBywKA==
X-Received: by 2002:a17:90b:51:b0:311:a623:676c with SMTP id
 98e67ed59e1d1-311a623714cmr4225445a91.27.1748336136024; 
 Tue, 27 May 2025 01:55:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtgIw/f17VgPNn+nXu/I69PpZOVwVY9jP1mWhIJ8Gnwj6H81zX7mrtbXGjejM3jdL4G+8rENKrcXckCKzluzQ=
X-Received: by 2002:a17:90b:51:b0:311:a623:676c with SMTP id
 98e67ed59e1d1-311a623714cmr4225422a91.27.1748336135696; Tue, 27 May 2025
 01:55:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250526143429.22997-1-chrubis@suse.cz>
 <20250526155132.GA151544@pevik>
In-Reply-To: <20250526155132.GA151544@pevik>
Date: Tue, 27 May 2025 16:55:23 +0800
X-Gm-Features: AX0GCFuB2C9H8KcXCoGsxrul9J6sQBUSqHiLyXKNc0vS5z5ijTopEnBhvZwFKbY
Message-ID: <CAEemH2fdSHLpxvEZQ4Yp53hzMpRWx8ZEzmmxJQ7xk0ja=Tctug@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CN2vimJMa66Jvun0gWdA40ZO7V3JBgGgbUrna-_NVJQ_1748336137
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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

> @Li @Jan Could you please have a look?
> It'd be nice to include it in the release.

Yeah, looks good.

> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
