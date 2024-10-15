Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B258CFC275
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 08:13:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E700F3C669D
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 10:13:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84DF63C0202
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:13:10 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EF42623C836
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:13:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728979988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GDRVSoMGcWu5rrDZdp5eQbB5rymJQNikVbRhwlRJORI=;
 b=f5YjcaeLhTLeuRGwnVZyst0d8mR/qY8Ya4xLcVjOm4fIN8cBEcE2E5k35C5LpEN5/MdmE3
 lEDghWjki4AUkl5jTbphHuqaslVDDZosJPkXJ6P1Jyb3UhLMEBzA98MOdWUnxiUrcWH8+C
 pIT3hsZRXw5dcSokNxNIG8c6CYfaqbM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-l_qzzVCQN_uLDEr0g74wEA-1; Tue, 15 Oct 2024 04:13:06 -0400
X-MC-Unique: l_qzzVCQN_uLDEr0g74wEA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e2dcea0f03so6399796a91.1
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 01:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728979984; x=1729584784;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GDRVSoMGcWu5rrDZdp5eQbB5rymJQNikVbRhwlRJORI=;
 b=fJ7wJVJkqkTN/UdFonsPF2KMkkCusGTk6HqamCC6zbrpLJL961rAgMoCT3JBqzA2BJ
 VZc/k+eXto7k9t2OkjE+kCucjEi4geqbw14ooUdx7FSgSJn9aP9Iyc6vF8/bpvihWFAt
 CasLCal/KWsiqG4Jj+2umaEw66xMb+Fewq4KQxitbG+QLdrOu8etIUDUKSQXz0zthQMe
 303N59puZLWzZeAVfkq0iG/QpcLbV0UwpsY231hVEY+VFeOzNXhb4YJev5/XH0m9qX+q
 a9v4s4jRWZAFvJ3tYKnpGkWI6CGMoKkemb8I/GnpGyVCwRM4c8/3s/x7rtMENF3A0wxy
 yeLw==
X-Gm-Message-State: AOJu0Yw+ZIGuVkS+VT6K9j9BPGjrK24cUKSH9aBUfymKeW6pCcOfzS3E
 5wN5NOd34TcpRj+0LGMou7kQ9tMrhOTLqZQ+Sen8Au/XVnz/OZqUT/Tzt/wSujA7uRvuMafwmZr
 H6ZhEXNFJAaRDuMCBwVjB3l/HpBieE4fCrLIvDRtJrIF8vsvm1fI7cHS26TRjM7HyF70R+HU3Er
 BS64IZTaXuEfpLNypgmesL0b+3xzvLdSOjNGFu
X-Received: by 2002:a17:90a:3904:b0:2e2:e148:3d30 with SMTP id
 98e67ed59e1d1-2e2f0ad9725mr18420531a91.23.1728979984188; 
 Tue, 15 Oct 2024 01:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDyot4S4Nm7hFk3kXTNIJWRE8b9rXS8qVKBqxBDlUkoG4uk/iAlUaE1s7Yzs7lv1n0xBwp1cRwap2HN2aOM/Q=
X-Received: by 2002:a17:90a:3904:b0:2e2:e148:3d30 with SMTP id
 98e67ed59e1d1-2e2f0ad9725mr18420510a91.23.1728979983881; Tue, 15 Oct 2024
 01:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-2-5328a785bbad@suse.com>
In-Reply-To: <20241009-generate_syscalls-v4-2-5328a785bbad@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Oct 2024 16:12:52 +0800
Message-ID: <CAEemH2fx8cOMjT5bEhec4GOJ24wmLFHGrBctofobxOSN_BagPg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 2/4] Add script to generate arch(s) dependant
 syscalls
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

Andrea Cervesato <andrea.cervesato@suse.de> wrote:


> Add generate_arch.sh script which can be used to generate arch(s)
> dependant syscalls file. The way it works is pretty simple: for each
> architecture defined into supported-arch.txt, compile kernel headers,
> extract the list of syscalls and generate a .in file containing all of
> them, associated with their own syscall's number.
> The way syscalls files are generated, passes through a C application
> which is automatically checking the availability of the syscalls in
> the user space environment.
>

This is a great idea, thanks for achieving it.

Reviewed-by: Li Wang <liwang@redhat.com>



-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
