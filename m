Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E096CD6E7B
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780652127; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=f9+N2tWHlaZ4J114sKWL/6NPZ4B0sC5neEMiS+oIeOY=;
 b=ooO0rZZhEwll1mv9nWmF2B37UMtEE2JJkeP3ZURISvdTCzD1FRxykhOnvH52vrkB/54xm
 7qN300aXmd5d9HC9qYGnRvOnYvWurKnxy7Eg5RVVn8cFAdUsuE8EhMroMMvFZP2suLdS/D6
 9DxbRjAQta+zngCfM3/la4Zikh3wiu8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 11C8B3E547D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:35:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCE803CDA3F
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:35:06 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8FF75600AD8
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:35:05 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso1351354f8f.2
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780652105; x=1781256905; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4w6M6qn9EUZwpVsK0DFERhZ1jdJUpzF1AnNmL5GNmrQ=;
 b=OpM9DmZKkNo1YFr2kRCu4PzUjrY1V99gMYoA6pLTVU2O6MdUMfkRT2WcFgc9y8LOTS
 ZzEiHL34OrXEyVL021pve8qqtAMcsmUrokgHzVny71UfbaUyxVWe7fFKXVxtz6gFzGvW
 kBrkym8vTWZdPXTrBKyckH8USAID7+ynaOop2rJI+zwrRQL+VcCGSYwcolzCH2/vAsg/
 4deG0e0NYQSHHdMyFdE2DoZkzMX9QaTuGoXsBQRv4HF2wKhtakpN1mZB84Ymqsa1qADx
 cDpQ/3Iz7m6Mq/1u7RM4zha4t/JM9tiD//1Axnh1iY8UkvO+48b5XQKDsWS1MCHW30hF
 9Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652105; x=1781256905;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4w6M6qn9EUZwpVsK0DFERhZ1jdJUpzF1AnNmL5GNmrQ=;
 b=cOYvSBfKoldCixxvnMimQxkOD+yeAXEc/AThGCjFrnVvXYbqK9LxCtuQ0GTKNoV3ab
 MtBIYfk/tYBSbI7E682u/3lA4IAAiosMAseNmpNy/f0N40gB47MLT1MM7dfi6U7S/7Dd
 d2Zbn6aUlhwUN65c3fE9YFzVnhcS4AgO5rcpFSuGslEqkSlImCSNzpiTEGrvRasya5Us
 BCs8rKgmdrzI0eO3mdwnkZxCWPrpbNch+b8qJH+zCNogANueLfebj82kanaUS8zHfQ3T
 sGoKtWAr/fZA42r+ksBswYYkAsPQ/3KkdnmzpHhAmA4vgMjD1MKSwgkUYP+OgQVFb7ng
 aBMA==
X-Gm-Message-State: AOJu0YwFRNYdq/w98MbWmfaUGdNwspGhwMiJphivTQ7rztjXvGY4ELPh
 2TQhxL7J0QDfB9qr+dO3R1ajuJJEPa00dm+DeepK2Z7mgbvhk+InNb7q3S6rvJYXoA==
X-Gm-Gg: Acq92OExvQfJcl15VM6SQqAmqVkg75ccLiYjZ7Xw/ZUinTIQ3zSZNfnE0cMl/Ia8Pjs
 ng8mVMczG37BSy3Rsw0b+CbxY0MNJ8LJrCeZ+3edq07hes4IqcXj8G4G0YKvMvifNQKor8oCOMf
 dHQtAl6e4ThsaTCj1ndLdxlb3M3DOR8M/RCT35/QdvGvxZJ2ap8ziTH1yBgP2qO4+GXQMdlHC3o
 gjm0nKlum3ymDzE+3Ru3gXBPcHvB4EfbBw0O8vj6ZbdeRcFLSLJ6ylTWO99yv01zXtD0voOVae/
 RRqKiTrWDVMDOAvvLyo258sEOl8sgThfD3L1dv/j2xKLY3nWzfFmldO701YlMqf6iGTerW8c/gp
 KOa0EM6DA1bjaGozSyOGOnXk/VHBgZ+tJveL03qdm4UJBT8RGqzCNsMKm/zm3baFm243s+5UnnK
 9Mv3Q+BBy/SO5vQkzG3dlCDAc7eP3sIX7+lduJ9ohOEKtoc4Or9Kc=
X-Received: by 2002:a5d:53d2:0:b0:45e:fa4c:47c8 with SMTP id
 ffacd0b85a97d-4603065d2d9mr3212608f8f.27.1780652104838; 
 Fri, 05 Jun 2026 02:35:04 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4602cda3651sm11378423f8f.32.2026.06.05.02.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:35:04 -0700 (PDT)
Date: Fri, 5 Jun 2026 09:35:03 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aiKYR7gagyA0y9zP@autotest-wegao.qe.prg2.suse.org>
References: <20260605042942.30480-1-wegao@suse.com>
 <6a22780a.a05553f2.14c34d.8596@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a22780a.a05553f2.14c34d.8596@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmapstress06: Convert to new API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jun 05, 2026 at 07:17:29AM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> did you use the ltp-convert skill from the agent to generate the first
> draft? If you have any suggestion please let me know, so we can fine
> tuning the configuration to make it more accurate.
Yes, v2 first draft is created by latest ltp-convert skill(gemini). 

I have done some test on power/x86 and give feedback to AI then finally we have v2.
Most of the v2 code are directly created by AI. It looks good from now.

Some error happen i have not noticed such as "manpage:`mmap(2)" format
is also created by ltp-convert skill, you can check AI feedback on v2. I
have no idea why this kind of simple issue still happen.

> 
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
