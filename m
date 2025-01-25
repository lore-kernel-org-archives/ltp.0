Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA4C02181
	for <ltp@archiver.kernel.org>; Sat, 25 Jan 2025 02:47:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16C973C0E66
	for <ltp@archiver.kernel.org>; Sat, 25 Jan 2025 03:47:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 567213C06E9
 for <ltp@lists.linux.it>; Sat, 25 Jan 2025 03:47:05 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A7C8B14232E2
 for <ltp@lists.linux.it>; Sat, 25 Jan 2025 03:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737773222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qO/8TtsmGiZKm+xFuttxNg6v4m+S7G4bNeckKzDY73U=;
 b=A+c7mOfcF4vBXVJVvwr7KL3/LNyat0uh3lX2o9iHt9tEvy8TytKyc7NFhD8FLPNBNvuxGa
 jb5UxH7IN5hReqdqRRjlYLAql9oQ5oIcxqH8llJfQoOgZp8OtYgiXqoQdCS2XwzZHJEPqs
 3bznWJVeE41pJlIpbyTartLp/lkjfJE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-N3IiPLKZMBCT7xREnSLNSg-1; Fri, 24 Jan 2025 21:47:00 -0500
X-MC-Unique: N3IiPLKZMBCT7xREnSLNSg-1
X-Mimecast-MFC-AGG-ID: N3IiPLKZMBCT7xREnSLNSg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef9dbeb848so5072340a91.0
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 18:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737773218; x=1738378018;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qO/8TtsmGiZKm+xFuttxNg6v4m+S7G4bNeckKzDY73U=;
 b=RqL5oH4vybjqqxBWVFj7YNuhMjVC5AuawYcsxfAk7wTnai4+SA/whN4ucUCQFIUR5c
 TAW7MaP5XvH9+eFRUT6rfD2MKl8vmMgePXcgoRJx3H+Tz8Kc+8KGMSh4yMXzVArA8rBj
 XAXmzttZXq4Nunq0v74QB7y34IT6L3bshRb/rRygZIiUY+bvS74QaHRQoaL+m/d/FvtO
 EwhwQrw53NqMmSP3YQYn6wARQqdmRwzAtfTptjPfLwpWpHzncnQHvwZ9r1a0Sr3JuIgt
 hiDC+UwOhPyGfRvFB9QUaDZo8TJm7mw38n7b6cIWRyICRXsagJU/FlCgLAHu4MIqlKEz
 uagA==
X-Gm-Message-State: AOJu0YylMpK5R2y6/S+dp8z6DM+g+g88nRhaiEb1COWJcXElk2RfTPk+
 IvrScV2yrqkmRrxmLVkgHmM/aTMJwVZMJGXHZp/vm8usK+fxlAlz5VlwUH+UtgL+PVvLbNqo7uB
 rYP3GkYk+ZvlyFYuKZ8PExz0bJardTSxSWHwCo3fYvfY0s6v4NvGHKu5bQlGZHZePIGEugDvq4s
 UfqLaNxl5Ehw8qA11+HkexH3K09TO1UQvfbA==
X-Gm-Gg: ASbGnctYbdTneaT4LTyO6N+1Pl5UMco66SoHlccD0QzwPqc0UTjW7fPwIfz7Daxq2qm
 fWdn4BRi9vdRB8AiSCpUSSKDmuk5/MuYOOa53NZndCeVCPdwXwwM7GdM5Bns3jJM=
X-Received: by 2002:a17:90b:2cc5:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2f782c73b74mr47137828a91.8.1737773218338; 
 Fri, 24 Jan 2025 18:46:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQB3QbSqWfBp2CrSfXPxuFCUyI21foLzzCsEjFNRsPT2nq6eWwKL17vl0rOZRjH688dljQ4x5OPcHPviy7cYQ=
X-Received: by 2002:a17:90b:2cc5:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2f782c73b74mr47137816a91.8.1737773218030; Fri, 24 Jan 2025
 18:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20250118102615.127485-1-liwang@redhat.com>
 <Z5N3XdwnqOthwIps@yuki.lan>
 <CAEemH2dt4SoupdQ4f+OShMss6Ukau=DeeF8jtve_PFKqAz+ggg@mail.gmail.com>
In-Reply-To: <CAEemH2dt4SoupdQ4f+OShMss6Ukau=DeeF8jtve_PFKqAz+ggg@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 25 Jan 2025 10:46:46 +0800
X-Gm-Features: AWEUYZlm2r36PkZYlJJEAxX2stawzDjXrEu5H3kSwIPdji2LOt0uiPLLfa-OYZA
Message-ID: <CAEemH2fdHF2SqSxxWpWwzuuMtnMwzici+Hg7u5HBLrL10U3vbw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B7tqUWbSBB1f8VujVojxjAoVMXfO-MKlNdlk0JvFzl4_1737773220
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: switch cgroup bit-fields from signed to
 unsigned int
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

Patch merged, thanks!

>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
