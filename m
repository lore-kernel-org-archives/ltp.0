Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97265C71155
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 03:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750131903; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VCMZglwWVb3Qu1IHhNziPMN8qvkl8RT07kAXYhVZPyw=;
 b=Go/6YHGdhEpcXya57pbIAE0qG9aFgP4YrrFsdjjoO2ODAlQQFHZPwaPZGTZooiOFbgFwu
 VNjd2oLH6P1l4RZuEqHFRjWhjo0tAhYIuHbwcIbbVRUfSkpGYMfunGm9L3a2cOi2xNGbntH
 wSqsqLYQfiAMkTYHFZ/I78kiNWIHjGY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A15DC3CC1EB
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 05:45:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 514E43CA36B
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 05:44:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 92B1A1A00897
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 05:44:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750131878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uIrTBDoNgJ+c6vTBFwn/MuNHgNU/zu5tz5jcP094TPY=;
 b=H7m/DttcTYyzOW44vHcG981V+5YLcXZBIOu0p1ShkWyKh5HypG2iICII7/RIxlarAfkHVx
 ublYbaJM5/2padtQ4RbO7y2UtpbrWpPf/8Lzsct3j80WitUn57ge5jO6h53jXdrBakhOoS
 7vp89qfuLBOvEkbveXWRX9+IulRwhMo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-pAWMYL8qNgKyObhnReCnxg-1; Mon, 16 Jun 2025 23:44:36 -0400
X-MC-Unique: pAWMYL8qNgKyObhnReCnxg-1
X-Mimecast-MFC-AGG-ID: pAWMYL8qNgKyObhnReCnxg_1750131875
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3132c8437ffso6097287a91.1
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 20:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750131875; x=1750736675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uIrTBDoNgJ+c6vTBFwn/MuNHgNU/zu5tz5jcP094TPY=;
 b=PVt5XxaUz77nj4R4vDWGtTVTLi0p0zlalqHBrhOMuSjSqiIB65uPhluLi+RAXgGeXo
 F/8xbX1D3+2jL/92HniYq5CQ6Xgn2qovy6r0YY1tJytcy5aRPplShJ77/qdhRLF4VxIp
 +/VpO9sotxSD8hCwhtd5CKMxFpcYjcddUGPpeYYHMFBS21Jo14F4llCX16ah52wfZitT
 c5sxkIA4rVrsjhwgVuUMc16RZNN0/4nLKcyHNRyhPnDPK6bR8npl710hphN6m5OsIaKf
 wgyCFzMaP2SjATD0MD35VlU+T4EnveTL4jfvd3pI4P4fcaLEB1Y0LOGKMKv5PCrsMpdX
 yVxA==
X-Gm-Message-State: AOJu0YwKSOLrHN2BNcZgtgj5tNgQQpWQWckUAATOITkL6LxVhcQFowaC
 6y/XBfvD8QaxYvszOlbNbiOgLbvr1rHvrme8tH7+oEgKQA4a8NORS+byMgSuGpX0H/eqhfW3lnb
 13qdpb5BPomnXnQbJ1wTY/anwP3z8EcZ1rrYfFw2kLNkZka9T9U1D0TadCxMwGauDcbs7Y3rQJH
 /dGAf4KfddmRCmZVS5x0kL7Jp8JqQ=
X-Gm-Gg: ASbGncte6Yj4hg/Dh32MKtIugwIr/zHZnnFYKNCakB6D6o/FHiqb0xclp6u1vzerGM5
 NhGYdy0H6+Clso4kdXbGP3YCqVn+euV9D9I9MyhwIhMFaWxyU/F9iIQIy/MToKgUaMd1lx8TtC1
 aTuCBy
X-Received: by 2002:a17:90b:274d:b0:311:9e59:7aba with SMTP id
 98e67ed59e1d1-313f1be899bmr19378921a91.2.1750131875273; 
 Mon, 16 Jun 2025 20:44:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+URNt86gTOYUWf/9+M1mKgbX/8KhGcMZsYxp1eWusWO6SsjQIyK02LMWcKR7ecBhSz9POtezPHw/gZBIPRNs=
X-Received: by 2002:a17:90b:274d:b0:311:9e59:7aba with SMTP id
 98e67ed59e1d1-313f1be899bmr19378903a91.2.1750131874878; Mon, 16 Jun 2025
 20:44:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250616-conversions-kill-v1-1-a88c579477d5@suse.com>
In-Reply-To: <20250616-conversions-kill-v1-1-a88c579477d5@suse.com>
Date: Tue, 17 Jun 2025 11:44:23 +0800
X-Gm-Features: AX0GCFucDV7RrEY_x3nLxLje0Xe2217mO4JrP8jgrPVA634Ki14jPQsCHJSPBWo
Message-ID: <CAEemH2e5qUEuA2ryprVc5bpEp8ssnDAe1esS639JPY45Ksip0w@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gDaRg3Go_GGIzvQUTUmiRx1Y6aa4UVsCQQtaiJ5c_3s_1750131875
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/kill08: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,
Patch applied with minor adjustments, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
