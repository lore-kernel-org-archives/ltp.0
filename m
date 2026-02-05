Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEB4EC1E98
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770287642; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EZPs4ir8qazm3IfDnQwlION1huexh+LUY6VkH0y89v0=;
 b=CHt+5AVhcT+X0AIlBa2kpolLQHw+0/SEzxDLDrFkzS+9kxhMMaHBLty4cucYwt0PKalL4
 LYKTk+69jZVD3Y9dcBzODwPKbTV4HdE9vIgBvCxhywY1GIjIaUE3S4qcuQPtSdlww8y9pXr
 DMCsUpr3pxfy41hT+8oN5IBMJlRGlmk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6CCF3CE37C
	for <ltp@archiver.kernel.org>; Thu,  5 Feb 2026 11:34:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE5A13C259D
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 11:33:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A8DFD1400C43
 for <ltp@lists.linux.it>; Thu,  5 Feb 2026 11:33:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770287616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wpTEQ1hQNGdOC7AdjO/7pcL7FYgWSXx8dReLYZqEoP0=;
 b=P8Pt/n3CFQA8oa1cnv5+VqCg4f+T07XlUADqLKDroitzMe6Mdhu71AD/5aDG2n+8RoIdY1
 qg2kmzH+/E8lT6u4AFh3Aug8VPWwIpSPjyL5x9XxDg+EOAPUtJVkn24lBAEXYzlUIlAZQ5
 m5cXvl90Kwm8zp+dEYxybJZPyhogtfc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-P106L0I_NReEM3dh9wZVGQ-1; Thu, 05 Feb 2026 05:33:35 -0500
X-MC-Unique: P106L0I_NReEM3dh9wZVGQ-1
X-Mimecast-MFC-AGG-ID: P106L0I_NReEM3dh9wZVGQ_1770287614
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c6b1b22b134so488270a12.2
 for <ltp@lists.linux.it>; Thu, 05 Feb 2026 02:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770287614; x=1770892414;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wpTEQ1hQNGdOC7AdjO/7pcL7FYgWSXx8dReLYZqEoP0=;
 b=Pdr7rexCSzTr6oJgXMZRyiv70Ox5vnoq9mXaBgM7PacUwEoazzWt4oWCW+lNznczQq
 VjkA8Dt5ByB492qjSaf/UqYTMYPuaAcwxAU/1HYEBQfFm1NPzj5eo86tuOFg5I3cE1Um
 k7BR2nWAXykbsV2Y8SAgfSKIvfYIQPxwO3xIsJlAPA4o0pV2NaO6r199b9WHU+pnICHR
 MjowSVjlHe8A/UREFTCf6FCbwqZ06dfKNDkDZW1+AxbMJhf/Jxa7MrTTdLrrwe2cdoB7
 ONPx+02MCDcZxDJKhTdIIRU5aeR1qPutRPFfmzEds9iIdYqlxs4NMmYHSvLazNMHeggU
 jCAg==
X-Gm-Message-State: AOJu0Yw+PFnI1aimGv0FXqavoi2GB9COazgaBwUNO9N8tbEERkNwn6q0
 f0AA4NbR0f7H8f35W6z9+jtBZx6hACxtu/uS9qzZ7p0ouim8XguF91VmpC9ovZkjg2vqCJZyvm2
 YWOwg+B+fI4cmqgfhz+4IxoHZ0bd/OarVmw164BEEDJ43AOIGmtFe
X-Gm-Gg: AZuq6aJIekiFfmzZpwmVOePIGRguzOuWg4GtXGMwxfzqi9qCI2FDmOr6IwtTKqSsq0d
 GzYVQ0cMQddl8WjyX6UB2CdHC6Lz1nL0iJgJ2KgTvvNeplhqo+YyP7U9l9/RLcHA8ctSoVx2Xty
 emkE9XWKqPl9sxr2VEFE72E0MWWiIl1ORdJsL+iKYYdeDbl1h37LFOW6k/ZIxKMgZz8W8QgEq6s
 /DtWUJoQAtxiKSxStfcfDnaUyMhQ/HELJiGGX3qyK3mulrxNdjFZgUU4e3fhV+VJ59cqL+0cp4e
 Nbyz++Ay0GInTFt4ggSerwOkFQOnXc+E8YI3qJqyg+9+Ne1hDDReCsDvwBUytQ4NQ1KO/PE0nGX
 hMY8t
X-Received: by 2002:a05:6a21:62cc:b0:361:4fa2:9757 with SMTP id
 adf61e73a8af0-393724ac33amr5843701637.55.1770287614486; 
 Thu, 05 Feb 2026 02:33:34 -0800 (PST)
X-Received: by 2002:a05:6a21:62cc:b0:361:4fa2:9757 with SMTP id
 adf61e73a8af0-393724ac33amr5843684637.55.1770287614096; 
 Thu, 05 Feb 2026 02:33:34 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c84c70da7sm4856747a12.22.2026.02.05.02.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 02:33:33 -0800 (PST)
Date: Thu, 5 Feb 2026 18:33:31 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYRx-5KWXt2EEHLe@redhat.com>
References: <20260203024320.227453-1-liwang@redhat.com>
 <20260204122332.GC224465@pevik> <aYNVsiL4xf2P9R6A@redhat.com>
 <20260204222753.GA279256@pevik> <aYP2AxZJeXgEDMpA@redhat.com>
 <20260205100825.GB294817@pevik>
MIME-Version: 1.0
In-Reply-To: <20260205100825.GB294817@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KW_ouegrb--4m0BFLKHb7UWaosy3JJadSNs391pPoj0_1770287614
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] openat2: define _GNU_SOURCE and include
 <fcntl.h>
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

> Thank you for your time. I try to send a patch to add the outcome to
> doc/developers/ground_rules.rst and wait for ack of others to get broader
> consensus about it.

That's awesome.

Once we get the consensus, I think we need do a cleanup work for the whole project
to drop <foo.h> from testcase which includes "lapi/foo.h".

And also go through all LAPI headers, to garantee each "lapi/foo.h" includes
the original <foo.h>.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
