Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF389D61015
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769694306; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=c3+vF3FWnk4B2rJ5u3qbPFWWCPTLn18LmIEo83IjzYU=;
 b=PbJ8Ap0T89FoLaJEcC7/vIeKvm3NkcSQL/lkgN3QhS+GdQkVGkpQM9QBD5xRrL09EVSfY
 SGtR3hng153kbOd3Zi4+LL2R0d3aMtgxHQvyS2j+2ezowR7stlW9tdPR2weI9b3snyyp/ia
 ZW6/Fo96FMXpeXd9nW0vfKaex2PbKhM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 159803CC23E
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 14:45:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940093CC189
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 14:44:42 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 18F341A004E5
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 14:44:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769694280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZNeIzWHLj39vBynk6ok+VzuQNafgRMM4pzJrdYZ5PpM=;
 b=MEhiiDlt/vIJSC3DwtuWBb23vR1rnLyuDgHXuhVhsuaVbcVS1boo8QOj/eutpd3RYEEQYo
 BEWhD4hWznnUBy7/EuooJSerVlOFSIVRzAog5jOA/Xanl+YF3PauZFI6CUl+4iKr7FyuU5
 PhENnh8pEq48X5i2p/IacwPxSoov2sg=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-HaDNHcxsMoKt-qLAjuDwiA-1; Thu, 29 Jan 2026 08:44:38 -0500
X-MC-Unique: HaDNHcxsMoKt-qLAjuDwiA-1
X-Mimecast-MFC-AGG-ID: HaDNHcxsMoKt-qLAjuDwiA_1769694278
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2b795cff830so5370764eec.1
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 05:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769694278; x=1770299078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNeIzWHLj39vBynk6ok+VzuQNafgRMM4pzJrdYZ5PpM=;
 b=hBEs1ICNwmXnUy5//Byn8snfpvbd9TNljcm2XRARefQbaW4D8IEDjFmZh6lPP4cRF6
 eFWu7ngyPWKT2PCGUc7C9TH9/e5/cW7/BB3LatS+yrbM7QRe7UuxGV1nEZqpJW6CmEts
 6W4U/fcIUf5RBQTO5qzhmJK4yn2yOvEAM/CndEnZmCKdHJWO+JuupWcYy4RxbF1xz7v4
 gopqWi9D0iurD/EWYEHB+ZGXe5EnOP/h6N6d7c896RZGnNIf7ozkXeWyW3zioO4w1XK6
 KdtgfqqkPHWa1HXTSGRLFghjL0Ek3RPazFz+AtdRqNdQQ7dTVFVQEkGrx3L0f2dgv1Bd
 P/AA==
X-Gm-Message-State: AOJu0YyfmZOOJMxoIww8TxAEBdORL5V1tB4ec2afdOJZwI/LYwk6C7sI
 0FJX/BhIGnC5IV8Ep/gs2dp40PDNQgczPRAzjyz199djxIGHLHDLU1dwHQ2tDzkEHAbacH09V+a
 BWVZyMeMHxYEd8wTQDaq93U470CTun8BFASub+yByl52dhI8B790Ras27vlNm/52rpqTMduNGoU
 zp/jDfHMwjBBQdUxxgy7SFeni5Frw=
X-Gm-Gg: AZuq6aKPW4dvRkw5ei88GZAflYU3MAgZqUGa/Xxr7nl2sT0oougComhsif5tztaKiZS
 AvhnsJQ6QUYzmfcZG918N4XPehqOFmlU6hMFSnYD+ppJwFj37YrU6gKmmCXr6aAMBLLVLSYiEJH
 HDolClUOzSKXM1C3YaVtTQf21HaAmI3SVoG9x8b20S/8gqwvp7luR9RlER/I3q30SYRlE=
X-Received: by 2002:a05:7300:a188:b0:2a4:3594:d540 with SMTP id
 5a478bee46e88-2b78d90178cmr5319076eec.13.1769694277788; 
 Thu, 29 Jan 2026 05:44:37 -0800 (PST)
X-Received: by 2002:a05:7300:a188:b0:2a4:3594:d540 with SMTP id
 5a478bee46e88-2b78d90178cmr5319064eec.13.1769694277375; Thu, 29 Jan 2026
 05:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20260129100011.72437-1-liwang@redhat.com>
 <CAEemH2fppgf4iJE4h1n3XSMw9v-hMF11BZAYjz_-9dHgKv0iFg@mail.gmail.com>
 <20260129132856.GA104003@pevik>
In-Reply-To: <20260129132856.GA104003@pevik>
Date: Thu, 29 Jan 2026 21:44:25 +0800
X-Gm-Features: AZwV_QhBFXFwFJfvcJuTiW7y0s1dZc1gtqgFKVcaGwD_QVbRcPd3rtqH_ImjOeU
Message-ID: <CAEemH2fAEJNvm11Vn4i7jfVPEjW2g8RXp6oQa86Xw4sss8vUtA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ezEREb2yvi04jn5Vhq14Hnu92Xv575dBNLYb31lJTKo_1769694278
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2017-17052: tolerate ENOMEM during test
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Out of curiosity how much RAM is not enough for this? I tried 400 MB + eating
> other RAM but was not able to trigger.

It occurs (but rarely) in our CI jobs, and is hard to reproduce manually.

But if you limit resources in a cgroup or prolong the looping time for a while,
that would be possible reproduce the fail.


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
