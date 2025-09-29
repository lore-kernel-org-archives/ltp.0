Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C631ECAC5B5
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 10:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759143160; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JEOQOmHwZE54gt5T2OQfXUt3SdZZ1fD8/GZCT3p1gcc=;
 b=gtT6Z7jUB2JffO9DiQ/IitQE6qk8TlXGsGrfdBx+g8QtgoqWQUEIH2pFRT3s5G7w19MYe
 LkFvCkojOm1UYGxTAfCSUOjyK2hw2PKhysWXJNyjPWEU+GaObSp8imLPBP7Bh1JGcAC5nAN
 ojv4UAevWZl/0y4Fw7wvX1xDbxrSZtc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 128A33CE1E2
	for <ltp@archiver.kernel.org>; Mon, 29 Sep 2025 12:52:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DEE03C4F80
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 12:52:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 277BB2005F1
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 12:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759143137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pWynaJ+sfpvXgmxrjfrAlVWda+W/H2/49GGyVJFR57Q=;
 b=ZVGBxz7WEy81UkZ2Hhl6xFxrUp0nHnKnoUussqPijL2Sj9LX7B9l0gdspkSXQR2hfxWSZL
 xUa1PRryfePVU/9TUtGOQRksaaDmrm/TXa8atkiZVwEm4xFBNloLbS7+wxZofIhvnnIkiE
 aurY14z+CGzlcOopnFeSL73ODx8jr7I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-Q1cU4R3DMr2y1Gd89xqbPQ-1; Mon, 29 Sep 2025 06:52:16 -0400
X-MC-Unique: Q1cU4R3DMr2y1Gd89xqbPQ-1
X-Mimecast-MFC-AGG-ID: Q1cU4R3DMr2y1Gd89xqbPQ_1759143135
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso3022241f8f.2
 for <ltp@lists.linux.it>; Mon, 29 Sep 2025 03:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759143135; x=1759747935;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWynaJ+sfpvXgmxrjfrAlVWda+W/H2/49GGyVJFR57Q=;
 b=pk2G+b1ixN5CZ+2lpRwjwvBPVPHPu/pzaDGMFtEtaaJuFPStGJWD+p0YVoCoD5eZy/
 9kOzN9V7GSurl5tqTIL1mxGsAJ/0/VFzzvRGgDsVaHtU9M4EeyrN/gAn/1/lPb2mcV29
 iI1N0jkc4FhFG2MuDAJXW/4wGLOMTNe8U/8tfNAPlSwiVjMVaXuzt6Nsu11QiACWcaoV
 te9wrH9PWTT3AFrmdG8LFCbKDsJDhZqiIlFQ96BcgYuphoFh9XH25ZvjmYw8Cis3m3fl
 n9Jg/pJQLnDyTkoXGvEIGecnc8ygLOurm9/kkxlCCAx8lklZGgK7Js4d8qhZaIN+6oc7
 Bjpw==
X-Gm-Message-State: AOJu0Yw9LeqGXX2bgIfP89Z8GWLgiM5lQH9m3oqoSVStfe3oliHNKZLe
 djk9qLvksMZAjnyV1JWzdtQcp4BE9sawR5XETWI4MSj36kdUGul4BioUVZXY2hqvWfBAY4rfHJR
 6/hw1AAU8ThsVsc1UleSKVyqrJqeTNYNNIHC77aDV1KNjX0wYDdTj
X-Gm-Gg: ASbGncuhbZW/wLsT9HxYZdIhabIBvnFyZvQJtQLrPqZL02k7b3h/jmStFfTS1/zIRmc
 k9nkWoBayBqoWJHGtlebkou+1rNn72SvnuZHeNhFNB0KwIgj6nuL37xq99AJJGV0l09fST4smqT
 GOGGTYOkxh8ZcimJkJK20A1XlOKyR7CCZbOpfFLw79xkDdgcYtpXPZUWAQKIyHIPUFvR86nRWS7
 FcOJhNkf1zmYNOmmb71XG7CVORpIqtNgEvq4AIOK72UHkGWoqlZ7BF9VsXuCy0T+G0FR+K727Yd
 6IKHEcIQod2287B3SFhAwU2WsZ1OBDVVoz3c4yG0gwEduvlPz+73VtZOlg==
X-Received: by 2002:a05:6000:26ce:b0:3e6:f91e:fa72 with SMTP id
 ffacd0b85a97d-40e4354d383mr13005840f8f.7.1759143134938; 
 Mon, 29 Sep 2025 03:52:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkTQn6n0Wgm+qO9PGOu1p0Vbxrokb7fDVvALoBhK/bYZM9gJg3CqA2vRcYXqq4pipvxmNxAA==
X-Received: by 2002:a05:6000:26ce:b0:3e6:f91e:fa72 with SMTP id
 ffacd0b85a97d-40e4354d383mr13005818f8f.7.1759143134561; 
 Mon, 29 Sep 2025 03:52:14 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2965sm17724637f8f.55.2025.09.29.03.52.13
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 03:52:14 -0700 (PDT)
Date: Mon, 29 Sep 2025 12:52:12 +0200
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250929105212.rygpolrvz2kr7nkp@lida.tpb.lab.eng.brq.redhat.com>
References: <20250917090712.5tbidlr7yvqvikj7@lida.tpb.lab.eng.brq.redhat.com>
 <aNECd4Qw4JSpjqxP@yuki.lan>
 <20250922110611.duahjf4vqvwp4zs4@lida.tpb.lab.eng.brq.redhat.com>
 <aNpjeHgpAWTa8sIo@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <aNpjeHgpAWTa8sIo@yuki.lan>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CGfGnNz-efCjBzEZFskMPffjUi3iuKjs6Ce75KwATaQ_1759143135
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Proposal for new LTP config knob: LTP_QUIET
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 "Bird, Tim" <Tim.Bird@sony.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thank-you Cyril.  Looks perfect.

Martin

On  Mon  2025-09-29  12:46 , Cyril Hrubis wrote:
> Hi!
> > I'm attaching updated patch.  Hope it does address your comments.
> > Please check.
> 
> I dared to add your Signed-off-by: (I hope you do not mind) and merged,
> thanks.
> 
> Ah, and also removed the TWARN from the patch description since we does
> not skip TWARN in this patch revision.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
