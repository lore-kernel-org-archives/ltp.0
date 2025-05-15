Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117FDC2D0CD
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 08:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747298824; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mRQWbof5WyBHYT/N7vR9MQGawOQAhtHEHPo0y2uddeU=;
 b=cdKPtsASYw8hgqdKn3JxU1K3g4FrkxVGNV9/M9J4jw5zwOqtx3z/+NxegbXWw4sOJCf7o
 tJnkCddSSLY9uvcjy8UXV5V+oQAA4KqLjgfBvu/QnjdZ8nKq59+nbqGpzk0Om2IwG10Fdq4
 M+YPquLlxi0baJSyT2rOEcmxVhuhevQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C6DE3CC470
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 10:47:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DB093CC454
 for <ltp@lists.linux.it>; Thu, 15 May 2025 10:46:41 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B09A1400984
 for <ltp@lists.linux.it>; Thu, 15 May 2025 10:46:41 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a0b9c371d8so537141f8f.0
 for <ltp@lists.linux.it>; Thu, 15 May 2025 01:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1747298800; x=1747903600; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnvStXgT1wrox2babaubbNl0QKQmjN0u7Nc04BdDQTA=;
 b=U0sP63pbIQv3WfbxYrWglKubQpka8fc5HxbLal77XNpY/rcBNlVaWGgBtUqoKV0zbo
 jGAJzDKjPXt1n9T09M17ruwoGgBhAZF513jEXQxNOkZcblXfKIawAveKHQ/gt+TQKM5F
 x/Y3VOJwPSbD5Dm3ciEUzgJr4Gop3igjJewbREweJd+nzE+2NxshXwSAjKFhc068mZlS
 BKJSC6x/JzMW0d1T/MSvLzmkEvacUrNX28G5rFMwzXHvLBGwb0U02fSf/Nz5EY74tI7p
 TnLJkMwSL83+XYPiuh5Zp9wfPZyC+wew8p08aAWP58jW52LtJGHob4X6jjQD3bg0f4RC
 V7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747298800; x=1747903600;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wnvStXgT1wrox2babaubbNl0QKQmjN0u7Nc04BdDQTA=;
 b=tc3SAOF8VhvJMVssZAaCBhSKsN5p7Pf0yeqqblQyMbYI/IZGEC/1dHyUuD4et7pEFG
 DimOhdIvVYx9xhAtuPiCmVmnKkKtbBd+Oqrwg67CGi0ejQPd2+XFX/w4HASmtn1I2y3d
 XNj1rikn3ydg/iYT3LnYJnCwMbfZZneMizbN1YGZdgKaq5h5OYy/6rSZqx8Csle30m0z
 OkDE0+Ca/RDvXD2V0CPr+9iP9S1YRQQIsG28we6Rj23XerFaakR6OWfcDaR+Ti+XwboN
 A+WCsH6/zvxZ4A+4BgF8uaw5idXcT8Q4EERmlUFgZVglEZyTXxZXUEOuiGE3TX+GDMdA
 hvdw==
X-Gm-Message-State: AOJu0YwkIciVqqgl+eQxEo3fM9lG3//c3ft33h1SC0+XT8pKbCJVFjIa
 xvyor8NlahdSjzNfsaAc1pBluKpIyxxUsTpjUqDvgioRRNttyZuxfwjXk06SE1s=
X-Gm-Gg: ASbGncvSPIRnNgD4iiE2YLrJQmdePVcAdqVnmZO7FS3zrYEPbVZ7xgiXPk64/mYXeK9
 nyiM+eE1F2EHKQuDvmIDG6iy4+1ZP7adoqSM6txmyYWAfig0CPoQXLe1RzFfFkIMc6+1t03DffX
 hUOcNGkLyJZ4h2V03yqdoGhh3cjeNEi9eoyZ+KRUAlY4s5AjtCfh4Zz8vs4wGXLwskLwr4c18Hz
 R6NGikwyfbzPpIvFZZD3aqYnObrhPYo1S8KbzIIND+7xK2e5SnP0lnZrj8Rego1eg6TOb4Pgar6
 qq3HoaghASX/Due1lgfV8YngtIn8qbMQTB1EP1A=
X-Google-Smtp-Source: AGHT+IFYk9sSmxZ04KRf/2+U5/QAIVdqlTJLJRdH8fSdYwpFEQTXsL0nmD8Dud5yRfVyZrcJ7ZhB5Q==
X-Received: by 2002:a05:6000:250a:b0:39e:db6a:4744 with SMTP id
 ffacd0b85a97d-3a353741abcmr1451432f8f.32.1747298800377; 
 Thu, 15 May 2025 01:46:40 -0700 (PDT)
Received: from localhost ([177.45.162.169])
 by smtp.gmail.com with UTF8SMTPSA id
 a1e0cc1a2514c-87be7a5c528sm66072241.11.2025.05.15.01.46.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 01:46:39 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 15 May 2025 05:46:35 -0300
Message-Id: <D9WLQ935PWHU.15YKNJYVP25PV@suse.com>
To: "Li Wang" <liwang@redhat.com>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
 <20250514-conversions-kill-v1-5-cd633e941e8b@suse.com>
 <CAEemH2cqO7AHyibDxNUOsr4eLRJvXkD-ckj=YmLQQGrHO08OXA@mail.gmail.com>
In-Reply-To: <CAEemH2cqO7AHyibDxNUOsr4eLRJvXkD-ckj=YmLQQGrHO08OXA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] syscalls/kill09: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li!

On Wed May 14, 2025 at 11:27 PM -03, Li Wang wrote:
> Hi Ricardo,
>
> In this patch, you convert kill09.c to the new API, which is good,
> but in patch 6/6 you remove kill09.c entirally.
>
> I don't understand why we still need this conversion if we finally
> need to remove it :).

Unfortunately it only became apparent that it could be removed entirely
after I converted it. So I sent it this way to see if it's acceptable to
remove, as its easier to see why. But agreed that it should be squashed,
I'll send a v2.

Thanks for reviewing,
-	Ricardo.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
