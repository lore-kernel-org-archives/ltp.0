Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7760AFEA83B
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774431767; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EoDpmFUfoffvAID7GgiaIc5EN87/g5WEx/4ahPKlH+g=;
 b=B0zZuxGfNEs47/bcnetvUWxfBqERU0qIHRMZ9kWw2C4RJyIezPnwVNzvGKfRXmP4mKFl4
 hNQWQD+T0cwI+PegrqNH30eQvAjfTyEo7Yy5RuBikkjMTsczFa/rNiYFBLtymbHRVI1J38v
 oqC5T2r9uevxnNClYhuMMvLTBp9UdRU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35E423E26EA
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:42:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C63DC3CF2B9
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:42:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2E976100044E
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:42:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774431741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ykpyrlby7WmseRiaLrcbOImyCYPC9/tkDB/wNk36mJo=;
 b=b0UmZgKWodsxKewgEzEg8HBDxOgeNAMTGmZfHhBsiCJD8p57AiI1p5dFxDai3jhZIkQrSU
 Z71oCeCadSE4/1OVo5YfoxiuqoZjMLbvvh5lTbPYvp3g+hDN9ogj4kSznNg0GLLCfH+HIV
 VkOsa2A6nRaMp//7pK56XuE+FvlFyTw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-y5aBwGf7NlWhv8o_CcW4KQ-1; Wed, 25 Mar 2026 05:42:19 -0400
X-MC-Unique: y5aBwGf7NlWhv8o_CcW4KQ-1
X-Mimecast-MFC-AGG-ID: y5aBwGf7NlWhv8o_CcW4KQ_1774431739
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48535f4d5e1so26970505e9.0
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 02:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774431738; x=1775036538;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ykpyrlby7WmseRiaLrcbOImyCYPC9/tkDB/wNk36mJo=;
 b=fYQZ913sDAareBVezerRnRM+/H5VcHvMx7AsKVg7hNVLQrwiIxz4quCQPpc68+Hybs
 E8hAz2gpaddZYvFrKVTI+UiEzQG+/53QOWtSqKhaB5hVWHIX+4Rzj3sE/2iaoPQ2Fcsy
 w8skaow/tw+dVZxLuET4gaoLmWA5LSMz/E5m0XIX+t1CyJqb9wrqOEvq7jco+T4DT5Ux
 AGVYTAxaLKqfRvEwkjGi1UKRioP6TJ71AJesZ3s8bmyuN8Hnonpkmdg3JyRQhkg3oHzC
 QCUeuzBFBoC6FLG5d/+4WcaX05cTaU1+Mw4jhc4wrGyAHBTw6tMs+Y6CS92fMwTMz45T
 SQ7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtgUPcN1ocdYTs2qqMBRFPBcmu1v/cHlSonJM1/8wWR2B01soa4RSSs7vMahFF0iIplPk=@lists.linux.it
X-Gm-Message-State: AOJu0YwUJderztrW29JPr6Rr4Fcy90zgzdRSj2fBwFcHX3qTqzanXjOr
 /KsTEI6ipJx8If0yU9htc6ry5VFu8T2NjELhopyfZAfx0aiJQZXRTna24Ju9EWuW8DlMQiuK6LZ
 jZ3ToE4aV0JMnskbVfa1aR+eaMjBh3x7zv6wh9nTNq9dhxRlKX6Bs
X-Gm-Gg: ATEYQzwdKxogkUdj/6/F8Jz1hzYibFiNAMxfxigJjWmCKitcdUyHqxASQSxN9ShlUjr
 +IdWyGvAnRuoTHgZVZ7bnEGjZz1Ie8HAOT7DxVyDUsC2WkQBgQswWsE3cpVW1zGko86nw8EmBrO
 4ES4LthHPuhjq8wbo0Nrsdj0XPoLe0Qz/x69mh9acOCGYRH2DeyHwwQ4Bylr5+k+oNX7+njUbS9
 +r6RwvQQTR7DJpm+EHqOVownCcSrH+AmgIl+a1pHhZnpcQu3jhyd54gM2dmaGx/58p+Xcm9SoBb
 96l7HAYD3a3PwrFUcgKhNUAUf7gjvkp107ntj9nu8lR5FuX3DZ4PAU8Nk3cTrs0gFAJwVBueOsO
 Ou1UuSYbN4IM7e4x9WamNHRd38bg/WgCu2Q==
X-Received: by 2002:a05:600c:3592:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-48715fea715mr45601525e9.12.1774431738574; 
 Wed, 25 Mar 2026 02:42:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3592:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-48715fea715mr45601025e9.12.1774431738062; 
 Wed, 25 Mar 2026 02:42:18 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487165ecf00sm18184595e9.5.2026.03.25.02.42.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Mar 2026 02:42:17 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:42:15 +0100
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260325094215.aiv3he5pdgm2v4fn@lida.tpb.lab.eng.brq.redhat.com>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
 <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
 <20260325091003.GA86256@pevik>
 <20260325092156.3sxnn26nlejzzygn@lida.tpb.lab.eng.brq.redhat.com>
 <acOs7mrlNceEtchW@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <acOs7mrlNceEtchW@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mS-HU9CFL4o48nRARyyb9lYYiRCR0dvP1rWBdAeiFT4_1774431739
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [RFC PATCH 1/1] LTP tests: Run
 without LTP_REPRODUCIBLE_OUTPUT=1
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Wed  2026-03-25  10:37 , Cyril Hrubis wrote:
> Hi!
> > > I still feel these 2 variables somehow overlap, wouldn't it make sense to merge
> > > the functionality into a single variable?
> > 
> > That sounds reasonable to me.  Which one would you prefer to
> > keep?  I'm inclined to suggest keeping LTP_REPRODUCIBLE_OUTPUT
> > and dropping LTP_QUIET but no really strong preference on my
> > side.  Thoughts?
> 
> Maybe we can finally implement proper debug levels in LTP. E.g. hide
> TINFO and TWARN messages with debug level 0 and default to debug level
> 1. With debug level 2 we would show TDEBUG as well and with debug level
> 3 we would show TDEBUG messages for library too.

That would require running valgrind tests with something like
debug level -1 ;) because what LTP_REPRODUCIBLE_OUTPUT actually
does is that it hides testrun specific output like e.g. testrun
specific addresses, temporary file names etc.

But I think a regular human user of LTP expects these to be
printed out.  So that should be the default imho.

Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
