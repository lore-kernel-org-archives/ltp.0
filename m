Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F51A10BA420
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 03:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774583264; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lgPc74QBoO8DXlGnWJC9QHyQBH62KJdMJ2GmvPYjFxY=;
 b=pKGP+n5r78khmU62s1gelKW3kOO5CZzyBXh9D88wwvyRIWsZ/A4HP3yLd6iEJxL1vkGKn
 6hvNEwOhZtvQzDyLt0oJkhnm+pQ6NuqDuQwn9wDS+RIIueuisNLkq95B8pmgirFhAyo5D9K
 JvnJ65fgmh2ibZbPa5WSqTpO50Sia1s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E41343D8E72
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 04:47:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A1523D75B8
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 04:47:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D69466008BB
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 04:47:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774583240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r3vKWezhLcT4nFBdAgtT0c4oyX8o/FGDWEfpFlrimYE=;
 b=DQZtTKHiLKaFSQqbE2UqA8cGq+4+dEPaIG+x693hBTUUtQ/4zDcyRP4wN+9Lnv8Ik2F3SA
 ZPzGXIJRKriiXrupV8hK24DcdADKT0t4uxjjeunHCp+SmKCpeuOKK02l4KYXNVDY7HDGD9
 Tvf+SsB78ri0nj+l2HrtRR+Pw9ANcwY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-tAwLzWOXOze6v6msZKbOdg-1; Thu, 26 Mar 2026 23:47:18 -0400
X-MC-Unique: tAwLzWOXOze6v6msZKbOdg-1
X-Mimecast-MFC-AGG-ID: tAwLzWOXOze6v6msZKbOdg_1774583238
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35c0bd3a968so1703991a91.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 20:47:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774583237; x=1775188037;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r3vKWezhLcT4nFBdAgtT0c4oyX8o/FGDWEfpFlrimYE=;
 b=n806ROn2k61JQKWPUNfH4g6Jgk10/OFCB3XeFQJaYEzMcoJXIcaK2GQxeT4CXjNXhP
 bc96VR3q66jMlgqDCgqpG2tKX/JRmOA+dQ3N6JsRNu2au91zKpgzuIKlEKAsy0HLBYvp
 l6u8ADlZt7Li05F+Pq3yfdSbkf/04e4OLFKa+Y1R4iGHFcfuRMu2jJBPOeQtUF8OPnLN
 qqiGyRvP0KUFt1AoiZaI1Qc4IibVqEGnYWEjS57N861r8kU0YWyt54Qc0wuMO+2XQcX8
 csvOtHUXS4EdptencH1cXACcwJ6SOFz5W+keZRWS/WWAGPBoAkodeDASgBQgXnhDoTLA
 qbXA==
X-Gm-Message-State: AOJu0Yxk1rtLR6TS6mtcjEcZGNPvMSUz08Q+vreZ0PR6PhVeODadt4Yx
 PkM9KDGe312BVAeW63ZzDcXhB5XBYZEPAq6BDG63Rq+p7EDg2aIRj6UQM4+g9V76gkq5jYjtMSA
 2QUKa/2gy5HGBGZLoguqjlLigPaKA9hh4TZN2JaE5MuwNEMIianS8
X-Gm-Gg: ATEYQzwv0mLANsbhB7OFc8oQurrSeoLlmt2ZzciQ4uxyrw+fP9xloMGbNHGxwYYvG4x
 K2EpyXtpwaO/3meaRHBV8GhsQ922DjRtY9/5N79eXog72C3K73GcSqUq/G4prxUJGJd3J4oLUBw
 FePhkCeg6H+/g3ATN6Ure8ecb6p8Sxs9pA+5kqRpHPSqgRZCzuJFXcjKT3tTvGCIcuZMF/wdMHZ
 2I9KBfrRrTw2cynOaIhUq/V8bXBtCQAt/WEMCYHGLpqLCXyAeowldLrp3jMqy0XUYaoSibFXN4A
 9pEaoizaJZzKsqkXICLejolOi06d77gjzxsR1w5XY6Ej7yxXxnqxxcH8Ou5CpgDryHVFI5qd0Gg
 tq0QnvlNYVtt8S6CQOg==
X-Received: by 2002:a17:90b:3f4f:b0:35c:59f:e345 with SMTP id
 98e67ed59e1d1-35c30116062mr979101a91.26.1774583237593; 
 Thu, 26 Mar 2026 20:47:17 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4f:b0:35c:59f:e345 with SMTP id
 98e67ed59e1d1-35c30116062mr979082a91.26.1774583237154; 
 Thu, 26 Mar 2026 20:47:17 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c22d09573sm3250693a91.16.2026.03.26.20.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 20:47:16 -0700 (PDT)
Date: Fri, 27 Mar 2026 11:47:14 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acX9wktQPqS95Xh8@redhat.com>
References: <20260326170435.22566-1-pvorel@suse.cz>
 <20260326170435.22566-3-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260326170435.22566-3-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VDDZKMd02QZoNjW79VmRF9pKkG8HZCxWiQ5nAr4Dw0o_1774583238
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib: Rename variable LTP_ENABLE_DEBUG =>
 LTP_DEBUG
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

On Thu, Mar 26, 2026 at 06:04:34PM +0100, Petr Vorel wrote:
> 1) LTP_DEBUG is shorter to write.
> 2) Enable is usually meant as boolean (on/off), that hides possible 2
> value even more.

Agreed, LTP_DEBUG is better.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
