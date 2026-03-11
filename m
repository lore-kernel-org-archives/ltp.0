Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDBC1062878
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773232929; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=+h8GWj/ZhXMauj3/+mE9dYqdIPEL2Y0gbK70ZpU5VY0=;
 b=U6MqZGySGQ0NvyybOUyrYNz15tp4v5Xt+0/XnSOPYZl49erQH5oVV4/tUFjfQZd/rtGGn
 Kw2ZB5ZdtwXXy2b5bUHRWxzQNGRifVuWHRVQgxxFvhzfu9AYcXeBF8t7jaZidaZXhjNUtGi
 FuDKs+8nXdPsrKBRUVTvyS7du9J3gTU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16A4F3E2BAB
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 13:42:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6D843CCFDE
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 13:41:45 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A179C60193D
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 13:41:44 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so10674248f8f.1
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 05:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773232904; x=1773837704; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3b6QRfaMbhTwu8E81izAcD3ZeTlC1U3cEPwtNqbRWnE=;
 b=RD7ZuJYzh3rraKtCI1pca7TPv+NxuD2AAMdjpessCD7RfEdcGBKA168UCp2LUK34c+
 t+6XtbXRStGQlVj3hhOOK2OG46HzZsKyFoR2OZJ+b/8QgCHUr2qS0n5ZOOmI63ES7acy
 Sri3Jmw28RAkOFdhOq31JA4cFWcSflDXunl67KkyWump8Q71FEqTuM7CRYfG/73CnaiB
 PBtczZgcOQlH0FBnXY+ngZbQ5oo5XgSQIwaiXb5e1GInKqzOHIk4Llk9RGBpsqnlVel1
 e4OT/cba9zGz4tEYHazcU1HRo96Uffyt+hkWSulZCivVJ9vPRLG+J1WtMY91YxbZadtb
 3N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773232904; x=1773837704;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3b6QRfaMbhTwu8E81izAcD3ZeTlC1U3cEPwtNqbRWnE=;
 b=fGMdA/4P7zv1yPDhmDDEESmFoV5GtSPa6QqI/Nz22muQc17W/QdznDKWw7Xx1+Dky3
 k9l18LdaiD1pPzv06GOA8YUaN26cexfJqAlIRZ6ONP0PxnK6GmT57heHu2puQCE6RxS7
 MiZGOit8XLH6gLDccRLBkXCmsvrCBYlPhyw+uYtfy5Pvi0mta5qpeSUqohCvh7+Zce9Z
 qBbmrhl/98ZtPYLw848JAuONmoZtev2DvyLNIfObLYOFmTukFpvNsJCko1ksUOWfyNiO
 4WLfEUuWg1as2OJV6anqzDVY/89zn8XDKd/tO8WGpwBVNjulWx3f5Xrl6g0vTuzEBiTO
 afUw==
X-Gm-Message-State: AOJu0YwfLxyFyYbAiwI4SmICB6Y1//ZwrKY+VT9oRK6tWNvbvcJxg3kF
 LurwtklxMhbl5ZsiCO9GlYBCimUM4sKbETtemrwj1fGWTHfSP1lRLYMbzVzKqvEZdKYsau91btk
 3O1tY
X-Gm-Gg: ATEYQzy+Gx8J/G5TVkyh1MYkyGVfJMHmH7t2DEB9NBenGHgIJ59CP6+kxu4kP/sbknp
 f/a0/yE+r0WVCzHbTLKVTgo/fdKt7Wms8P2RZUq2rlmLLUKJkFIhW1fk/E0RyYomVQsnWeymoH/
 aQ0XT5Jxpb83sWWUYnR3iJgiKgT5IbyFZ/yZtDPT5lamqfjbFh69ncGNQzHfwieYmr7DOTxIis+
 c5E7J4dSS+wVgKPL4hU2sS6aviZutdjYFA2CeZULbHyctpl6TEDxFCSDWKC3Z0JpSR4/OWd5XeH
 asRKnunL+BX75ld/NgAHL95Pgutx9W70dUpj+GnD+wQm/tyLhKLGpS7h69NXWTbsMYI15yocAAJ
 Q8Og3N8vY8sD4Cj18FDxXteQZi3k/fztXMaNQKNywZVhIgr9JbbFpAV/EFo78YiRb5QiRFT7TnB
 ev6up+gNIF0kevXPC5bWepfWWKTlLrFxGpnN1mVyfb
X-Received: by 2002:a05:6000:2002:b0:439:b6ae:5d5f with SMTP id
 ffacd0b85a97d-439f820997cmr4773338f8f.36.1773232899580; 
 Wed, 11 Mar 2026 05:41:39 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.24])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fc0ba972sm1369886f8f.24.2026.03.11.05.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 05:41:39 -0700 (PDT)
Message-ID: <69b16303.050a0220.27d4f3.6151@mx.google.com>
To: ltp@lists.linux.it
In-Reply-To: <abFW8JI1H_m1NqS2@redhat.com>
Date: Wed, 11 Mar 2026 12:41:37 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Cyril Hrubis <notifications@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Wed, Mar 11, 2026 at 07:38:27PM +0800, Li Wang wrote:
> > On Wed, Mar 11, 2026 at 10:53:07AM +0000, Andrea Cervesato wrote:
> > > Hi!
> > > 
> > > > Hello everyone,
> > > > 
> > > > what about scheduling a new LTP meeting after the release?
> > > > When's your first available date?
> > > > 
> > > > Kind regards,
> > > > -- 
> > > > Andrea Cervesato
> > > > SUSE QE Automation Engineer Linux
> > > > andrea.cervesato@suse.com
> > > 
> > > We still didn't decide a date for the LTP meeting. I was waiting for
> > > more feedbacks.
> > > 
> > > @Li WDYT?
> > 
> > As long as it's my daytime, any date is fine with me. Thanks!
> > (FYI: 9:00 UTC is 5pm Beijing time).
> 
> I just see Cyril prefer 10:00 and 14:00 CET, that unavalibe to me on Wed/Thur.
> But if avoid Wednesday and Thursday, the time-slot works for me:).
> 
> -- 
> Regards,
> Li Wang
> 

By looking at the previous meetings, we always did it at 9:00 UTC.

What about Tuesday the 17th at 9:00 UTC (10:00 CET and 18:00 Beijing time) ?
@Li Is it too late for you or we can make it?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
