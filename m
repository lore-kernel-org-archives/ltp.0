Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB53AEDEC12
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 06:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772605756; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ao4sl850zScrv4f/8Ch8cDVmew7J/++Zi9PqWXtIbFM=;
 b=lBMVbAgqhTGVnj+moS3aikulASK8T5LWoZEPaQuylkU0GYOeM+y996X2AtBxs/BeA8V9r
 Pumrl1rrkPlmBOv9gzWrkWhdCi5frX+gIM3mjq1fXDcYzq9u1uwLNMZmme8PdR0uYz+Roif
 hzVPp5Ymh2fRs5r8ld3JREfJNRe/nj8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 757F53CC83A
	for <ltp@archiver.kernel.org>; Wed,  4 Mar 2026 07:29:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EFA33CB04A
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 07:28:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 637B42002C7
 for <ltp@lists.linux.it>; Wed,  4 Mar 2026 07:28:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772605729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bze0t4zaVRvCbij/feu6/RgwgjNbDhFRAqwpA8ECm18=;
 b=FOziCSuVDSTxObBARxZ6XwdJS0SYTco9Zz8ut33lTeNpbsWexJ35kdYxFTj49Vc68gQGHb
 DTyuZ7tVa8KOTzU5wVqkulVOHF+dx8+Nfr+ibJDQ9irICtK/XmdRHWkX+4nBdxuilMJBEQ
 WyHQ2qQbh4IItd2RFKvm/3qfWO3MjRI=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-guCTeMEEP7OXoMx2Ltc_HQ-1; Wed, 04 Mar 2026 01:28:47 -0500
X-MC-Unique: guCTeMEEP7OXoMx2Ltc_HQ-1
X-Mimecast-MFC-AGG-ID: guCTeMEEP7OXoMx2Ltc_HQ_1772605726
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2be27d4e3e5so20081258eec.1
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 22:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772605726; x=1773210526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bze0t4zaVRvCbij/feu6/RgwgjNbDhFRAqwpA8ECm18=;
 b=rd2CnhCF7ceWlGanVaUb8O56y1imIr3GpEXpis3fceECaikFB/f2GXlepHXZCXiPDO
 1RpMYCwEVS4OtKgarB8oLalfIpoBbzj3jAIVG18YyMeZydFNWzKQbUXFTdu9NuaPczII
 n8Pv7eh5kLBphnkfEoRo3WIuoIA9rP2QeSmmpSajKQWvJwRaN/cf4sTfZwe1gVsigyh4
 ykWts6BSpXLWeWpu9RanWUMxe57MLJckyzrOm3BnJCLrhMMHPN9IQqSfepDtSjYwdFkW
 WQ1pp53EndY9pJcHuHW1N7mKfrBARCW7FOfBygNVQg+Cm5fo6j/vFjFh9xq5bXgKkwSi
 V+XA==
X-Gm-Message-State: AOJu0YzURYAMqW9KzG1wHVwVi/L3+f2yqDnZwAGq7rk/CT3gWdjYpIE+
 GGFGHF6Dd4Nn5YeiwiYeltZZYvvmj1J87ouhq76Z1moH5DFpZycgvPc40g1geaSTamHBI2tzuMh
 B/jteiZJOPJ6Ld2yV7Lx7ZVc/jGhLhK1FNz08PpJ2sWsJY9wX6MiGG1/FKmfyH+klXdVS4nr7Iv
 FnvILVIlLw3NmHkzjZOScP2kJYh9Y=
X-Gm-Gg: ATEYQzw0PspvRqpRRLRD+1T0WYUtZ2DiMnBExkc0QURjRWoZ13Dm8bsR5cP4PQLAHZ1
 KACeWyiEXMzbu9vVBI4a9XQM0F8EaMnz0WLQ+/qZnRBpH94lacwp7fiUenn6wVTnmCYZsDiCsS7
 kPT3u31a2h7ZyRqg8DEtPzf0brXijgML80GvHLTKaEw4rI5w9z0XzD4cc3dMSsM4TVpWLhDy6WR
 swYc8k=
X-Received: by 2002:a05:7300:7490:b0:2b8:261a:fbdf with SMTP id
 5a478bee46e88-2be311d3f90mr414962eec.39.1772605726401; 
 Tue, 03 Mar 2026 22:28:46 -0800 (PST)
X-Received: by 2002:a05:7300:7490:b0:2b8:261a:fbdf with SMTP id
 5a478bee46e88-2be311d3f90mr414956eec.39.1772605725950; Tue, 03 Mar 2026
 22:28:45 -0800 (PST)
MIME-Version: 1.0
References: <20260226155929.3500-1-always.starving0@gmail.com>
In-Reply-To: <20260226155929.3500-1-always.starving0@gmail.com>
Date: Wed, 4 Mar 2026 14:28:34 +0800
X-Gm-Features: AaiRm53SQIS8hTuk4Z_18nIWerrzbY6wIOAJjfCLCyRFfvecXP2j2R8hiR_puig
Message-ID: <CAEemH2e5o6YShwNmxOkskav-H2m-ZhKyi23KhKEYi0sRMhGYkQ@mail.gmail.com>
To: Jinseok Kim <always.starving0@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AwxqKmeAZu2PRbJvo_Zr355Cs53quSeU872K7bi777U_1772605726
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] open: clean up make check findings
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch merged, thanks!


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
