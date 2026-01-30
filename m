Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE49ED73EA9
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 00:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769733748; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FpjgD4+ey9uFx67wDkAr39viOJwcJBINjP+QCECE9C4=;
 b=qSc2PFu6M7eSlg3CWZPqA0Wr98y5jptbXp+M1vuk4jgkcjaqHnxvRv6CeR4XdiSzwDgSp
 UQSSUl3D3pSBjmW5az6YbmN7FK7kW7mZkgxbSKBZ6cp4+E1h7kqID7aY4bT5FgRwxZe82Ii
 e1B3IegO++noa9TY51rVd0yNQq74fl4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54B503CBE1B
	for <ltp@archiver.kernel.org>; Fri, 30 Jan 2026 01:42:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2EBE3CBE1B
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 01:42:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AAC4D60095F
 for <ltp@lists.linux.it>; Fri, 30 Jan 2026 01:42:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769733721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p+Qg5KXmjO9dXnA0OZ4Ye3YiXhoAjgvenbvzOH1BSQM=;
 b=ef/NwtE7tij0AhXlq/uxeENvQ2gD2M1UBe8f02raAUdPgMnu4m/hSAqqP3Lilwq8pNWGGX
 jkebwjbxZzhfWQXTAC4xfidZikqQpP489kcGgArMzSM7K3Mxuxw/Do8G0jxMwVgwv6wWYK
 iELwH6VW7WNFYSMF76B7TGjDCiLnpRk=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-T-nf-ddwMrWdVOaxS2G1rA-1; Thu, 29 Jan 2026 19:41:59 -0500
X-MC-Unique: T-nf-ddwMrWdVOaxS2G1rA-1
X-Mimecast-MFC-AGG-ID: T-nf-ddwMrWdVOaxS2G1rA_1769733718
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2b722bc1be1so8352231eec.0
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 16:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769733718; x=1770338518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+Qg5KXmjO9dXnA0OZ4Ye3YiXhoAjgvenbvzOH1BSQM=;
 b=pdf0qybrrH5dGhk5OESL4bwvkE3Gn0pbVWOfcQH7NNGoLp7/YEPvd9Rwi0/smX7FCn
 qU1xupTtbnBjQ8HJJRbomvwZv/PndiUWsZ5XxQ1L4dRkJXjdR0FwXMe7rHGJC2UOF0cf
 KukZPUk6WAnIAoAShicqno0dSiR6ARSZcxCKzqNPWF36gYTfWMeOPNHXB5c2fAbo5FQI
 j9dGyLQyK8G74pzfgPGfzJ7jCauAYKfOtiMtzDA8VafV2GoK739+mtrIdEm0cnTW/A2h
 0fVtrL2vb+gObFMqeuj1Oadi9zwjE+TKRd5buJuW9RD8IMImnTbH6rjouv79xQJ3QaxX
 dgGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYnjKYivlC7I3ro1XMUenFBk4h3+A0aoYjC0Jj7JJ10u8XSazT0FRVgzUQyKON/YRAwMI=@lists.linux.it
X-Gm-Message-State: AOJu0YxKxKPKvgYkfMKdyq25EVi4g3st+CRcz0N/iuicSYSuZgYVJrNN
 UCsqZOflPtBgwOIrThOylMkmFCWfffH/SqPisv4mjU09aMGIbYU4nKQXhM3UcfR//NUlucR21/X
 YWd9Dzx+nXm5lb1B+4K13bKwD9KqjV4E/KkllyMnNxQBTVb1pwlByQvd04FpBSmysj0/X74aUby
 SixpqqBO1eOesNUrP2vLSQfVAtxxE=
X-Gm-Gg: AZuq6aLKuTFYfdzPE2c1rsydznRKlZM08oRD52wlLQVsIy29V6k6uC0t/n1+GoiMVjk
 V+e56SfNGAA5wXpgSzowjI00TRDNyQUk1zb7vm5KHq0QqwzSiWPAioaF0v0TEHwLBI9Q6vkP0ZL
 DiJmWcf64vxF+2KOsjMdclB2vNQ2jb4npXa3Mp4uahdXGHgPP+2XQCNCN6DkByVlJU7gM=
X-Received: by 2002:a05:7301:e24:b0:2b7:a2d6:b309 with SMTP id
 5a478bee46e88-2b7c894555amr688532eec.39.1769733718291; 
 Thu, 29 Jan 2026 16:41:58 -0800 (PST)
X-Received: by 2002:a05:7301:e24:b0:2b7:a2d6:b309 with SMTP id
 5a478bee46e88-2b7c894555amr688520eec.39.1769733717897; Thu, 29 Jan 2026
 16:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20251215161353.GA282302@pevik>
 <DEYXGZU8IXPQ.2N0IS65HUZ0LI@suse.com>
 <20251215165247.GC282302@pevik> <DF171554SNRA.2CKR0Q3FLG2TU@suse.com>
 <CABeuJB2TJ4bQDX709-sLO0tb0acYH770kS6X5zXMh0V0M3Yt-w@mail.gmail.com>
 <aV6DCbns02E4BCTj@yuki.lan> <20260107160656.GB791855@pevik>
 <aV6G0gxYWHSFkls0@yuki.lan>
 <CAASaF6wOSvi+07Pq5O6+f1Hkrq6WWMgpCaooJxWrO9uOvRM3pw@mail.gmail.com>
 <aXt3cKet0G4d0oF0@yuki.lan> <20260130002719.GB120546@pevik>
In-Reply-To: <20260130002719.GB120546@pevik>
Date: Fri, 30 Jan 2026 08:41:46 +0800
X-Gm-Features: AZwV_Qh9KYZmxEz0dSqhb4Pjcbi6plbItclFNwEYZ0U46bCTo7vd3wOatF1dUeI
Message-ID: <CAEemH2eSL4SZYH_bwRFeE93LQMLyrdF9SyZ=n_JPd6AR+8FH4A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DqqK3BeJbOebJ95eyunEVCigNrG1UIivWO_8z7TWEFg_1769733718
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ioctl_pidfd02-06: Add CONFIG_USER_NS and
 CONFIG_PID_NS to needs_kconfigs
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
Cc: Ricardo Branco <rbranco@suse.com>, Martin Doucha <martin.doucha@suse.com>,
 ltp@lists.linux.it, Terry Tritton <terry.tritton@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Maybe the best way forward would be to add hooks for certain config
> > options into the LTP kernel config parser that would do additional
> > runtime checks. That way we would have both the information on which
> > kernel configs should be enabled in test metadata as well as runtime
> > checks.
>
> I like the idea: having metadata doc + runtime check is nice.
>

+1

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
