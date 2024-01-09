Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11751C46CD2
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 17:15:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EDEA3CE51E
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 18:15:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95D0B3C0645
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:15:07 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 011B5600706
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 18:15:07 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5572a9b3420so7165691a12.1
 for <ltp@lists.linux.it>; Tue, 09 Jan 2024 09:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704820506; x=1705425306; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKtwj4LMvTmsNwZJQ5SnLtMDuc0qSj3iQ7MBVeVRUjI=;
 b=FxM4LVidlWhauLBXQMQjApo+E2C7+aA0OC2YxJvL13/TMJN0m2ray6lI3YRCRSOgrv
 7b4iL01C8BBxfkDIREqT0q0G+p3OlC4e8CZ6IJy5hiBPFqoVt/pTb0De6W+2rJGRk9aC
 C2U5N9U8VeT3ZPNkZhckkdtQxDxyYk02WobbzH0q25HwD+TanPrkDgau3E6KHUr/1OsS
 R1K9WO9FNGl8JtE/O1X2ij58fZGae9rsoq8KJh3axqh9Gark4lW41cxpj/UcGSN28FLr
 sDWH+AO+pQ3SzILk9kfE0Wm7jINhdGZMKAfqteMXcSNURjcwqdKqOby9/eZ3aRrd5AQC
 Ttfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704820506; x=1705425306;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKtwj4LMvTmsNwZJQ5SnLtMDuc0qSj3iQ7MBVeVRUjI=;
 b=sQiO7xpm4ROJJSMD4pQVIQOMczbM2MXEQcUI/jvT34fSIeLrEKx0WpeVoXOjxSh3iQ
 a9PurP6k5kWs2dyHU4+Eh6pAGPT6Qxlknq+sIiDzv4EcKsHGt5Arbh53EOYH2ULpate5
 oHEB9D2GFcYJ52CaHsydyHCHECMAscQpJuh+LJM2sJNbUu2iGXi/PSJ6fZQU/b728mqo
 3UtFMY2x8/SCoQeUIK9yNYVXVb+rUrq94hlePC/n/khjqiIIpHiyHVU7kMM1o8wyaw0g
 08m9reQTkBmgeiUVdNqlcuDJ7mgceTZX/AlJxvXaPmXx14ix5GkIHY0Vv0SUutvaOp8m
 ZueQ==
X-Gm-Message-State: AOJu0Yy6vA1flK7luqe+9GYm6zg9sWk6T/nQJpddzKUHH6E/cXneD5dv
 E9OvJsVsBd5B3QIAJlEfWpI=
X-Google-Smtp-Source: AGHT+IF0GVLAjzWICcP4QmgtwmHvPGphyaSzaaGl36XhVOOYU5RREEkkVbjnEbhIQBhWpJOkg5AwEQ==
X-Received: by 2002:a17:906:d94:b0:a28:abfa:e405 with SMTP id
 m20-20020a1709060d9400b00a28abfae405mr916792eji.58.1704820506076; 
 Tue, 09 Jan 2024 09:15:06 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 bn24-20020a170906c0d800b00a29340be3dfsm1231090ejb.37.2024.01.09.09.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 09:15:05 -0800 (PST)
Date: Tue, 9 Jan 2024 18:15:02 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240109171502.GA1661159@pevik>
References: <ZUEd79N7aiC_VCDO@yuki>
 <20231211204908.7212-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231211204908.7212-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/mmap15: Rewrite test using new LTP API
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

I'm sorry v3 come too late, although Cyril pointed out not needed needs_root and
else if => if change, in the end v2 was merged.

Thus I fixed this as a separate change.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
