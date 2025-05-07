Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601DDC3ABC0
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 15:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746630938; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=U8YyhdvXIrsDUxBVxpeZgRvNrJK+Uw3LPmLxDjpXqCw=;
 b=GYDgOS3y+79ewN2FZKz7HpKbf9uokE531eYnGyiKWx6SaC1hECUDiOea1/rpBXMxLdDTh
 Q9KxDAQA+rWKW7wLORHpF6TsnKhcB4XPmvrHI+XGd2nmRLJQRKcCT+DXYxaExWkevnidykD
 otIwhpEa0oEJOnYP19t9pb5oZ7T8Gmo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1B953CBFA2
	for <ltp@archiver.kernel.org>; Wed,  7 May 2025 17:15:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BCE63CBF51
 for <ltp@lists.linux.it>; Wed,  7 May 2025 17:11:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 75DFD6009D0
 for <ltp@lists.linux.it>; Wed,  7 May 2025 17:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746630713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+tLPbYzwsfVRgQFNwUjTUwqiXAosSIFfC/+zKaoS5fI=;
 b=LDH+6F+MUt4NHeCmJbn/6phW+gZRjXhdscUzbwEKD8jPN9gMvv+LNzKuJbzO3eM9xwrW4B
 JeRRk6SHrF1pTIa12j5Gd12obnwHAQAqj9dBop5HkZ2V5iq4UurTkOhv9lmNmhfmGBABVh
 6tI59bIIrmzjtZ5wbkK/BKAr6Hn+Pbk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-W4LMKgraMP6wBK6Cjpm6YA-1; Wed, 07 May 2025 11:11:52 -0400
X-MC-Unique: W4LMKgraMP6wBK6Cjpm6YA-1
X-Mimecast-MFC-AGG-ID: W4LMKgraMP6wBK6Cjpm6YA_1746630711
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a0b662be0cso331275f8f.2
 for <ltp@lists.linux.it>; Wed, 07 May 2025 08:11:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746630711; x=1747235511;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+tLPbYzwsfVRgQFNwUjTUwqiXAosSIFfC/+zKaoS5fI=;
 b=FG8Vnq6W9wtGbyComRkUE9URPnbphRr0eX4lq6TpZJmGLZVI/172OkYIIYrlGXBM5w
 kFZIvtJsuAL7wAM+f0/2RLRJGGP5Aj1a0+oHkMZcrb9INjrr3yQtEut8CwTFJgiXQ5im
 mbrjIbnkuLLAxmPEWnIWWYvvFn/+TZ0csQ4gEe4UWPDn2tQsR2zmWh9PmgMqF9ksvv+d
 CzFwXsjNPAJIDZktC+ObVlEwcGOkluDl4xVUanoFkK9rbmUM257rbrxcXpOXVpD93F92
 7QMWdjo8sZQphpmXW0Ii9mPW3RlyiKhegQbYLCuEVhp5pD29lRAB+C+nr8jOeS9G1Rmp
 rCoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeXnSSQMkmaOstRumdCCOQY2LFDcekNE5vq8ISk8+3aQzpkJmwLirfoizQiXDJmdL0m+M=@lists.linux.it
X-Gm-Message-State: AOJu0Yz+ytCBXvF1mZuvNKBAxJxUr2Fk9Xtp8AUn6c9ujbs00CXPCSAx
 dfOrId+WBd+euKi4WhYatrpan1OfMAyZ8ZNziRC4uszeqoxp/F7bJFTGBw9YKsI9V46J8CDysEt
 rS/Jw2vGPpwv/yDYluDOSHRUJ2JOd/9pTZIYGqT1GTZlb2J4v
X-Gm-Gg: ASbGnctwEEk35iuMU/S1fXFhyZNeJUds/WwfJx7Vw5Ce5YYdOfaxulz/9elCzDKj/k8
 o+E28D1bksxycavQElxVaNGp0NmklTjAXFWbMYLdTi+RCPlTYYPEeF27qsbZB9pTKNacv6RZzp0
 kPrpTwO/yyxXWPro0+ZcFOZWXMTtiYC7cXX6y33cn6ECWRPpNxTnhLOWr4LQ3rv0Ucp5rQgWsO9
 X5YeHqBM4EMQ907lfHzK4JzFh+H58AzCdxMVIfUjcNjmrMwi+/sD+EbFHVKkFL/Jn7C7f3DoUpL
 NKGKf/NBkL2cxJef7gB5LGo70cCvhw==
X-Received: by 2002:a05:6000:2502:b0:391:466f:314e with SMTP id
 ffacd0b85a97d-3a0b49a80d9mr3050701f8f.16.1746630711050; 
 Wed, 07 May 2025 08:11:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9BFtgZUAQuvkC++iPR3bWtAbyBPWQjRcej3UEEVqHRRRvmiaB/JRPvpAaoZXjzAL07IjzIg==
X-Received: by 2002:a05:6000:2502:b0:391:466f:314e with SMTP id
 ffacd0b85a97d-3a0b49a80d9mr3050665f8f.16.1746630710651; 
 Wed, 07 May 2025 08:11:50 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0bc0sm16940824f8f.20.2025.05.07.08.11.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 May 2025 08:11:50 -0700 (PDT)
Date: Wed, 7 May 2025 17:11:48 +0200
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20250507151148.yhrnckco7zkrpfzw@lida.tpb.lab.eng.brq.redhat.com>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <4428939d-dc71-488b-9728-030accaca3e8@suse.cz>
 <aBh9Z4QA2YcdOFq1@rei.lan> <20250506080520.GA64990@pevik>
MIME-Version: 1.0
In-Reply-To: <20250506080520.GA64990@pevik>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y_LU2WOF30tUOkqGphHIDjBQoZVMOUu_-lGmtWLx4pM_1746630711
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 07 May 2025 17:14:16 +0200
Subject: Re: [LTP] LTP in valgrind :)
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
Cc: Mark Wielaard <mark@klomp.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello guys,

On  Tue  2025-05-06  10:05 , Petr Vorel wrote:
> Hi all,
>
> [ Cc Martin and Mark from Valgrind project ]
>
> > Hi!
> > > > It also opens some interesting questions, i.e. how do we make comparing
> > > > results from two different tests easier. Currently they grep the test
> > > > results for a summary, but maybe we can do better.
>
> > > One option is to extract all TPASS/TFAIL/TWARN/TBROK/TCONF messages,
> > > discard any message contents past the file:line header and then compare
> > > whether the sanitized output is identical. That'll take care of random
> > > values in the output while ensuring that the test went through the same
> > > code paths as before. We could provide a sanitizer script for that.
>
> > Maybe we can even add an option to the test library to supress the
> > messages in output, that would be fairly simple.
>
> @Martin @Mark: feel free to comment what we can do for you :).
> Whole thread:
> https://lore.kernel.org/ltp/20250505195003.GB137650@pevik/T/#t

Nice to see you noticed!  Primarily we're trying to identify
valgrind gaps and bugs.  For our use-case it's good to have
reproducible test runs in a sense of identical test results for
repeated test runs.  We got pretty close to this by only taking
into account the testcase summaries at the very end of the test
logs.  Any steps to get closer to reproducible test runs on the
LTP side are interesting for us, and we'll try to reflect those!

Cheers,
Martin


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
