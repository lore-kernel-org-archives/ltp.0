Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81494C3DA60
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 10:29:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 144523D1AD0
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 12:29:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 840903D0B1D
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 12:29:35 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6EF1A140170B
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 12:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721298572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lOQKYfDqTXYELG9+ex5yTQc8eeQtGKsG4BMLlRaIgXc=;
 b=hIDjeJd42Tr1bgIJtf7SWf20flptsJdryX3JPJTXbdL6qyucncUdvb0/tjWFUczYjhoRE3
 SggWOV9g7Q7asiS+jj+gWV9D/B6hwfQkjmlY85rDwF3UfRTHdt4GFxzvQDpoM16546vNza
 cIoR4dmvuHwsKCXWxJvxSLp+cOYC+f4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-sQdhvrtLPlGcRzUMgCYuHA-1; Thu, 18 Jul 2024 06:29:31 -0400
X-MC-Unique: sQdhvrtLPlGcRzUMgCYuHA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb5594a9f3so171930a91.1
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 03:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721298568; x=1721903368;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lOQKYfDqTXYELG9+ex5yTQc8eeQtGKsG4BMLlRaIgXc=;
 b=JUb6LBmg3ye/xAO0Do+NmvIKGRZ+1mZG1KcPnbMwWNyeW9G4Es7EPkVhY9Z4StYE+P
 AMvVIpJh9GlvxAzdw8HkoI5OTARkfHOeJGH71834d1D1eeNTY0cf3iQ3RTJs5a4I8SNX
 eEc80Or4aeawr9AOdihocJ92pTs0DEVKRc5ljJVXXXjydzn7Plfn88XuyZlKKrjWn6D0
 U+7Bp7U/NmoOFH9fkMbg0gabiPZ3hr7kDqfvfnpHRnDX1CRMxQQdgKNHG8OuTuXL2qfF
 4yWTBSWCAKEXc6OGE2RRmKBlleDJlpzYpsLuHkjMck+acXTHBiOMD2dHZxYPaEdg5sF+
 4qZw==
X-Gm-Message-State: AOJu0Ywz8TqWx9l3dPeiGvUofjHVmve0sL/Z5yzDObww3Jh9fWf2Ny2Z
 kPiOLqL0+bPf+tPu+cKpthRg7cPFGnpHnoL2BymtwH1jJHPiNY3PL1kR7E852rag0r0H/zf4sj0
 IZTzFbCS4pRssdxfl4g65YFU6hEE3e/TwBfS4N5hxJXQMAwMyGGzeFg6qgjPIOTzG6LbVpRfNYD
 ADfO/EWiVh2PTFF0L3Iz5ltdRTjJlSVKjq0V1P
X-Received: by 2002:a17:90a:be14:b0:2c9:9658:d704 with SMTP id
 98e67ed59e1d1-2cb5294fa12mr3018452a91.40.1721298568558; 
 Thu, 18 Jul 2024 03:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnuRDbT4B+MnAl9nWU6Q+ULGt1KYqzlQritCSg+tpv4GV67k4O99DNGnA/FXbuDHeFPZKVG5jyH7ZH5MpjjaA=
X-Received: by 2002:a17:90a:be14:b0:2c9:9658:d704 with SMTP id
 98e67ed59e1d1-2cb5294fa12mr3018442a91.40.1721298568253; Thu, 18 Jul 2024
 03:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240717171713.687339-1-pvorel@suse.cz>
In-Reply-To: <20240717171713.687339-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Jul 2024 18:29:16 +0800
Message-ID: <CAEemH2eMhsHaj39V47ju2MW_9K0Bh4wc2dSmcGDxFCtZu9is8A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 0/6] sched_football in runtest/sched + configure
 cleanup
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

For all:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
