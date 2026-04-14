Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CA9ED7BBE
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 11:05:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1F453E5BAF
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 13:05:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EF003E2673
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 13:05:11 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D4ED114004FD
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 13:05:10 +0200 (CEST)
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-506251815a3so45487221cf.0
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 04:05:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776164709; cv=none;
 d=google.com; s=arc-20240605;
 b=Rr5/ZLiQxiwMdOdjX5u0i2sANIqtup1D6nkuMHaM/KkC46aVl5/WvI14IpcCVLPbn6
 tl2A6kIfnyosjQ2+j7r3edssttPLwaRARqlw0a1ALMW87Dr9vYXzzwsEN19Iijvaoaac
 vHqVpegrTMWZ7Dl9dXYjvPCSxPzqFghGXehSLFns8rdCIwSlGkmNqv/DxyNDsV85fqg7
 no+IlxWcsSGS2lfK692om1qKDPvT+4Ayd4VQWfR3DOYnB/IDgJ4qRG+7CYGj9sCBJ2YF
 Q5sEvYve0CCDkK2gUmzhVJnai+NrDI2wJaqx4OVuGsfF1sU7xILd1hPYK5+wpYZjpbE6
 3UVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=InnZb6bYLqJHPDz/1LTH7y8TBZ2oy8kq0NtU64bI4qA=;
 fh=7eNN6S1Oks6GVEFEp4i1FP2fnxgX3ahpsN/fPiHyj78=;
 b=HA3pgtjF1hw9U9wIzqoJ/CYC8Z02jnfo/1/T7VKhMT3uRD2qAlb1ujF9foFTCfwVhV
 OaraLOugwNDH3rXjs1obfjM9qhEIELcZ8S9XiKNzHU1zOL5IFFf9oCRSKbze29OuHgvQ
 lgDS6kCncTNaKS7zKi1t3h5cy9bt/kuWkijWoxeZbWatwb+DQjIm5Ol9/zhsFJxUmDoQ
 99Khgd6U8TaHKAr3orydW3cJW7BZlPu+bz5Ms6zGvWaieRWE7AeFVb7QVLnMDt2rhDB7
 sksBlJcrARof0+eHLgya1XDh1rKgeAi251mAxUfzgSbP0/cAv2CrhfQLKY5sKDamIWFk
 iaug==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776164709; x=1776769509; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=InnZb6bYLqJHPDz/1LTH7y8TBZ2oy8kq0NtU64bI4qA=;
 b=XsbxjRCSnR1O7iW59psexoVcAdDDfwEXWhR5j+eSTfUqud39eAoCEKYNBY2IXJwOJa
 OaTej/w3kwLn8VC5nPhSBgBZOgqRlxsN8RxVx9pSpGmYNlP92wRJ283+sfoDYYB3xixT
 HN44Vah8OTSOHr1q7FfIfLUAJnmQni08tuwpjwo/xEzi28UOTVhCtJZW0Pxq4WucI7GY
 c21edSP2pOrwyjFvBNHDeE8IfhGF485+km1QA960awWNOhxZeWYTzOt7ir4JtWPPW2X3
 aqcnl6eWZIZCyfFnnS4qekeLMi8TrODWs+NjyOxfD/BkcVNU74lX4TChjaMquqXmrthB
 EyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776164709; x=1776769509;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InnZb6bYLqJHPDz/1LTH7y8TBZ2oy8kq0NtU64bI4qA=;
 b=P94m6xm/+DI5FOl1ALoIBhOc2/NCTwsaCYrTwIPzPr7ECIEvtpr5sqMeKnK1Zfou/q
 BspT0T2Xl1++RkK+S3EqH8DEDlGIFlxqR5nw3XDCbqKGqZgWrzQDc049iB8biB1qLJLd
 oTI4o2dszJa4sGHD/k7f244m0jU1YouHkrkcxGh+9F2a2NScUhX7WUuC/zW9ksLOex+l
 4kaZ4+dP+8ahBMBadJM/2bmwKz/+d0b2TEP5mylvujk9xCNw7/QnX3fGqduCHc7mwLBQ
 hnhwVD5/ocMM8qv7tLOxnlyn8r5a+AbQ84ivvh+kS2pwA4r7WcKUUQe/RWJG8H3oddGH
 2IwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mK9FbU0a9rXIYm11W92wCyCoCj55Yvq1VsA855DBk1yYqg5J4yVaBwHhd7SjYuSqkHPI=@lists.linux.it
X-Gm-Message-State: AOJu0Yx26vlGTr4blIaJa8e5t365mNtHMoteR1PEhjl3LfMHQkj9nRNq
 U5GuFb5m4R0RFj+1IjXeOSI6U/Oq/0sTnlmjLXyR6Dp2IndptJVST0/7KCVvLTEoWjGatpiD0Nm
 FWUT8HIg8jNFmFHYBblxTjKNGc+1f/DdZEv2L2xH16lT46g==
X-Gm-Gg: AeBDiesOI2XEED8MTdeu9wJisM0vuJyh/8XKw1NXxDfjXDWTbdTknirb6lxC1NYazW6
 cPyDfv9NuGo9NiUU4TerU4GhKNllYjWEpBD8YaBTjixkRbckZbHKbsRmYqLUewFpEi0uqrJbcQU
 qp5mUQDWzSujPEn67LJqtPir404jMwm9VjINfj/3TTPkDiKAN5Lqe/uO3BOn2bF/j68zohhUt+g
 /AlxWGi4oUqW12lkls5mcWby0SFsGcFXMtETbJNIXDpDygYEA5/DXGnuJPXtjEc4gWR7RU+ptYy
 obfE7w==
X-Received: by 2002:ac8:590a:0:b0:509:3cd:b22f with SMTP id
 d75a77b69052e-50dd5af20e4mr250333411cf.23.1776164709110; Tue, 14 Apr 2026
 04:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <69dce7cd.050a0220.18678b.446a@mx.google.com>
 <CANgNiRz+BdnL-yYw3BqcKo+o2tSmPEV-wiaCftxse8rqEA+3fw@mail.gmail.com>
 <8f26a37e-9443-4332-ac42-01443b19e18b@suse.cz>
In-Reply-To: <8f26a37e-9443-4332-ac42-01443b19e18b@suse.cz>
From: Li Wang <wangli.ahau@gmail.com>
Date: Tue, 14 Apr 2026 19:04:57 +0800
X-Gm-Features: AQROBzCC4xFYtqxVBlxt80HvV3uvvkAbroSccEjJMzHb-7Zb3s386XQ7ubfRKWI
Message-ID: <CANgNiRwX10QS8DPeT5Yfs+K_S85L0CCMzHx1aMBpx-i38L-65A@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] AI review agent
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
Cc: LTP Mailing List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Martin Doucha <mdoucha@suse.cz> wrote:

> On 4/14/26 10:36, Li Wang wrote:
> > Hi Andrea,
> >
> > Thanks for the nice AI review tool.
> > I noticed that each automated AI review email starts with the
> > following disclaimer:
> >
> >> Our agent completed the review of the patch.
> >> The agent can sometimes produce false positives although often its
> >> findings are genuine. If you find issues with the review, please
> >> comment this email or ignore the suggestions.
> >
> >  From my view, it consumes a little bit of energy to read or scroll
> > past this note at the beginning of every email.
> >
> > Maybe we could just put it at the bottom of the email as a note?
> Hi,
> I think the e-mail should still start with some short notice that the
> review was AI generated, with the longer disclaimer at the bottom. For
> example:

Maybe yes, I see Andrea already merged the PR, so let's see how it looks,
if necessary, then we can follow up this suggestion. Thanks!


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
