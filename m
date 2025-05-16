Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C77DDC3ABD8
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 06:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747376849; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4S3H5cmK/Bo84onx7QVQvT105wuOUkqBUSGCITN2shI=;
 b=QN7no1Y1SmnAYt3K8E3qoTjPxBtnjoN7Tfn3l0AlE/2sWI+PXr/zSTnPlDQ05Q/ahpiSZ
 HVGz5FIpKfa74RCYi3m/8zneyrRytEMFff2ri4qj3sxeomkJfYWqqEpLd13Wa2XqozS9P4X
 WrHsznFg8AZUIjPChBifqEyF9BH6rEA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6A0B3CC56E
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 08:27:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 385513C26B6
 for <ltp@lists.linux.it>; Fri, 16 May 2025 08:27:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3025B1000AC7
 for <ltp@lists.linux.it>; Fri, 16 May 2025 08:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747376824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jo9f/8Z5OtJYoVqPm5D2+WwReaYoOa+ejrMiuOpoRMI=;
 b=Wp3fM8pFNQFPFH0tbRj4IG0Rb9dqqpR9IrGBrzi9oFCvL0xjFuJZaI1eLoDmKVwD3sgSlA
 MaKP1zK8BBYig03VaMzfxl51rYvzKWE1cVp7qpffg8fAIMlJt2hkLkbGtaUJglcEQS0epu
 jitQH5W6P+yoi3A8RMzTddFpU+hAgeM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-1yiUPG-HMa2boyLSPZxo-Q-1; Fri, 16 May 2025 02:27:02 -0400
X-MC-Unique: 1yiUPG-HMa2boyLSPZxo-Q-1
X-Mimecast-MFC-AGG-ID: 1yiUPG-HMa2boyLSPZxo-Q_1747376822
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22c31b55ac6so28232875ad.0
 for <ltp@lists.linux.it>; Thu, 15 May 2025 23:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747376822; x=1747981622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jo9f/8Z5OtJYoVqPm5D2+WwReaYoOa+ejrMiuOpoRMI=;
 b=UvnWG/Vw/K9S04xBYPfGJJaqhZqUFUuD1lvjzhmm6yVL0fUod0WUjDSe9Mf3v4gxTa
 ByHt053fMqHeM86O9EpBKXfbZIrpI96rcZYmBO/cDO7LrWwIYDfiM+/JjBMX2U88XiBR
 woBh+TaaSXDKcm59ZrINTsRt/Jhq8DdYujMqmEq7Xw4ZVZyNulIYDq6R/cMZD1Z8dy5u
 OJK7pr/RLZ5TBzQ9ove+goxUxn9KrdDwqdJ+XKsMRwYTcrm+wFvgMREV/8sOfEbvR2FV
 5wGubDRZvSUHL8uKY2+X9woEmlMZUqfoCQQ9TluFTSmaeX+TiJao3bAe78tlhAbsyfAZ
 wT9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR6j43rKUzAb6trNfSVns6hiTeUvrI2x7DknjNbSRIbDLxITQuTa8XuHXCTRHPEpIWE6A=@lists.linux.it
X-Gm-Message-State: AOJu0YxQSCrosTbAe0wF0ahoeC7yIJWrRpN7Hu6V9JLfdEVl07roRfT4
 Yy9judgKfAcQPvMoouJBuxYKqWrWFWnykzLPosF3YtoNYpKhXBsE+46m+HI72PVL0D8oJRMqFFz
 Qgt5GXKGHzsPLOOU6ZCPNllPc+OOJZPHKjySqKTZkZ+mBhklZK2yEwC0zzLQTmEWM6c55L3UmO/
 sMHwqfcMIa6YmBrgFL1pR7Ff0zdxQ=
X-Gm-Gg: ASbGncth3cSZOk9Fekkv5T8FJWdMAAVnohLIDOqrEvCB/77G0MfqXZb21HpuyeHxYGJ
 xgvOG/6vNRTbwkSPGhYEAdhvF64OfKxPc7g0CkjSIxhy1vmb08IPsUjJHFnQL6MUD0zJ4RQ==
X-Received: by 2002:a17:902:f643:b0:224:1294:1d24 with SMTP id
 d9443c01a7336-231d43dc980mr21383005ad.3.1747376821702; 
 Thu, 15 May 2025 23:27:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIX/D8OTkpeAUNUL5nUH4PNpBOYlorcyRi/AiXtg3J27b5/nU8vfuyECkHw0rQLY4by8Dh13G0O6munjt0BZE=
X-Received: by 2002:a17:902:f643:b0:224:1294:1d24 with SMTP id
 d9443c01a7336-231d43dc980mr21382825ad.3.1747376821405; Thu, 15 May 2025
 23:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250513165640.185122-1-japo@linux.ibm.com>
 <20250513165640.185122-2-japo@linux.ibm.com>
 <20250515194826.GB501284@pevik>
In-Reply-To: <20250515194826.GB501284@pevik>
Date: Fri, 16 May 2025 14:26:49 +0800
X-Gm-Features: AX0GCFv8XYZMg99r6oiGHrjpn0rWy298qUSaIHlMRqt3AZrqgjEk9aTbFNGZe3k
Message-ID: <CAEemH2f3o6WyXj-uayBdD22iULPV_Ghze7_oNa7=H-4BG+bsLA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eh3HzJhBwTdoxAegdgJPcmrTnWCPr07--VyKBUOMo4A_1747376822
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v1 1/2] safe_macros.c: Fix missing ro flag for
 FUSE NTFS mounts
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

> Hi Jan,
>
> > The test incorrectly assumes that NTFS mounts are read-only, but the mount
> > command does not explicitly set the read-only flag. As a result, the test fails
> > when checking `sb_flags` against `MS_RDONLY`.
>
> > Old behavior:
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> IMHO candidate for a release. Li, Cyril WDYT?

I agree.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
