Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF50AD2F010
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 12:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769518684; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hdIa4BTGHzrHw7TkOMtTumowGPXJpg1Yhp3Q8euaqHI=;
 b=PcZ+vc+RM0mSpVrY836Z8rM6Uqo6azskKc6x445t0D2vTfPZQd7t+sQb8rnat5LWrJksF
 OvT/f3BRINBfbuk5S4BFXzugU544mhMcVmaP91kvJUhboAMcBznqRBz78OK+6PFb4Kjz2Mp
 4WSk1rqxKKpEL1zT2bzwdIKBTqgc8OE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58AE33CAD4B
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 13:58:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05EF03C9BEC
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 13:57:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 82C242009C4
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 13:57:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769518658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WuuCIbsq0G5lJGjDYYSTZBQPWAsT+zIyFlZ8LGFaGe8=;
 b=VH2hi5mdqrNFktDrZSeuIaICBoXbwsMNiuwQIyh5bxmAfDF+c9Kv1bVE4NXgPBDMmSYOxf
 080EEyogCtHuYs2v9Llj6HClLParLsTMVD/gm+KAscIWvv2M9L+0AMeCtKTz2tmVTQZ0qy
 /1/3WhjVuX5PncPL8ATj5i73vaq5W50=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-bWMjJvG_PeScQzzL8FwMgg-1; Tue, 27 Jan 2026 07:57:36 -0500
X-MC-Unique: bWMjJvG_PeScQzzL8FwMgg-1
X-Mimecast-MFC-AGG-ID: bWMjJvG_PeScQzzL8FwMgg_1769518655
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b6b9c1249fso10746110eec.1
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 04:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769518655; x=1770123455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WuuCIbsq0G5lJGjDYYSTZBQPWAsT+zIyFlZ8LGFaGe8=;
 b=EZnoj/rUmnO2s0YiskNOfWdtz2GrtsX5eaUZdGOYR9KCySKieTEU4jQwilYhaKmpHO
 efGe1e1e68R6QZXTcb12nvyKIs0Pp3Gp3uap1Wq4w9t5B5R66NwdImITMRunX2Y4y2uC
 apyHIBB5jJxTWX0q65BP4/TPDulMv6WYUWANqkVc6Vf3VL+DI2Awu4ab6OUNFs9+yprk
 C+OqlVpObH+kmfH0MMga5B6/lh/dg7YaVnnmkCV4JAphmd8h39GCBjrzW4Mzg6ay+i5Y
 HhMthD+7Tu1zB2WAPNrbME+KIPcXKLuSkEooNKzo9lkymPaCkeuniQ9Ic3tyGPMKPJG1
 IhHg==
X-Gm-Message-State: AOJu0YzhFLuDP7fw35CXIW51/mOlULpk70Q4Mnjr84AFT+GEH0I2bthV
 i5brOQGHHD/M5E4KYoIyfGxFKWADSlaknMhGAaC0mEwJ6ovCudb5g602V3JmJUpYtBkZGON1+9m
 5+1gL5RqzKzovBaUsf6vLCH0l3+eKpeQvc1B/kaXDW1Dabe2+wNq5Oc2X0RzZxwdu1+ZOE8xAjc
 CWS9sw4wl1uU7Tlj0MxAtpWl6A3SA=
X-Gm-Gg: AZuq6aJcVsBPwHFLVAvF/6v1IxAKUQi1bPCNjOF/cJZWrLkau4AwVBqdirk6qFRtY7a
 YyS8JIZUlNSTmMcmRDl/lk6XgXiphX2DbCNdROYQMAt9L/fs0wha4b+7cAOc+Sx9855kcuAsow7
 KZpYMjjlZ7MEboJsPUUAnQ8HmUm/lmJxMCUG3GMsu7TuCn3951dA+bAnU2cHqHBSld2Nw=
X-Received: by 2002:a05:7301:578f:b0:2b4:80f0:3bf3 with SMTP id
 5a478bee46e88-2b78d8cced0mr1248819eec.1.1769518654904; 
 Tue, 27 Jan 2026 04:57:34 -0800 (PST)
X-Received: by 2002:a05:7301:578f:b0:2b4:80f0:3bf3 with SMTP id
 5a478bee46e88-2b78d8cced0mr1248800eec.1.1769518654460; Tue, 27 Jan 2026
 04:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20260123115419.154326-1-liwang@redhat.com>
 <aXi0jgsiQjJozZCF@yuki.lan>
In-Reply-To: <aXi0jgsiQjJozZCF@yuki.lan>
Date: Tue, 27 Jan 2026 20:57:22 +0800
X-Gm-Features: AZwV_QhKZ36enm6B7fBTrytv-gJ5bTIxuFuSGxtfr2Cyyn4YXKghFHjIKlLQ6Wc
Message-ID: <CAEemH2epCaTrRAcQ2DDWrHSRTdS0T6wiawZ7Zr4PUqPgDMkqkA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jzMZnfFwHC1VUOwe0UHJM9kZ8bizUnCdH6bXQWGZO14_1769518655
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] userfaultfd05: require
 CONFIG_HAVE_ARCH_USERFAULTFD_WP
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
Cc: Ricardo Branco <rbranco@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This one works as well. Feel free to push the version you like with my
> reviewed-by.
>

Thanks, I merged this one since it makes things easier.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
