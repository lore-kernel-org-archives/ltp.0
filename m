Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CE010BA45E
	for <ltp@archiver.kernel.org>; Sat, 28 Mar 2026 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774658688; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fD+wO0uChmQoQHdMmpNJ7uNKVsthGS2LV8sXQNKeYsI=;
 b=AruOcuxVjLa411vUNSqLU1IP+OLENmOpgsHHdDIZ+48DA5ZoPtUk5Jq75IflPXxm0y5rA
 vZe8nr5U4P08fK2sDQEgk4u0IOh0Nhy0pRQZ6pcgAC+xXPIL+BfBxI5DBWZVtpbtjbGOf0b
 f0e3f+UgHDrDpUVtek2LXZ7s0mtj7bY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E4EF3DD44B
	for <ltp@archiver.kernel.org>; Sat, 28 Mar 2026 01:44:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 792763D022F
 for <ltp@lists.linux.it>; Sat, 28 Mar 2026 01:44:24 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9D3A600874
 for <ltp@lists.linux.it>; Sat, 28 Mar 2026 01:44:23 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486ff201041so24887015e9.1
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 17:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774658663; x=1775263463; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sGgCm+M3d52/Im+QzLDipfz6FcC29PloYWhWwy8nnV0=;
 b=JLf/owcn70Zutp5Ftw8bQ/rXCW2SEQSICJtU26tD+QsfAMuLuP4lBvP2AEnh3eUmd7
 DeCPH2phzCwkk+c6x57f8LhWH4sKDO3svMEa/lQdyOkFFZghCBu18CtRFGlrQpHqavfu
 CXbTZVj0FZNfZvpDAiFFXG2ulcoKwzo6LQ/u4SsaIsn9sLYZzcoqLBHqxKom4x93wUbg
 R///jMUOLSEtw8/rE4Q7NFjsW4H+PerNFfD/AJdVN6ywFhhGwQwYzaxlxsOFyWBt+vM1
 MS4yBVTSLYJzPSdEJOFJbmkEvFqwCHf+wdgbz0R6/84kq4p1R7w8hjH5WR3PTcn/HyEx
 q8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774658663; x=1775263463;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sGgCm+M3d52/Im+QzLDipfz6FcC29PloYWhWwy8nnV0=;
 b=bdXbLAP4y5mWVGyJNcNWz2JvtnP3ibXenwd2ZlFcqIP+xvjhZwZlbqlGH5g1U+bbb9
 2EWy885Nzq1DMIceE46VENi3leoHm1Z03WOT9MEbB4QAYgPcbNYxQZi67XpkmI0RI1QA
 zDuvkco3NzHS9BmKkuANRZ3MG5eLpTu2hDNWJ+jXRcvTPjYBw4G3rsuMd+f+ylAsEjGx
 6a6as7c45ivhKVy9m1AYzp2kejVVJuoHnI7jD/7gClsHseSbLtqf3tcrZEY788+uUiIx
 ClK/j1J+IPUaKza+RoE6t+fi9bjuUu8HyQ02sr+PrQrufgNt82l2RhmcCR8lv36eZnkx
 G2ww==
X-Gm-Message-State: AOJu0Yxf48oQG2QsCAkQnpAgCjSWsNpmxsoFy8pXKH3ReLmZr47UXGoU
 7JTUtuLhMt4ViiyV1Qzs0MchUMgkwBzFCqaLjQ6/KFPVun0PWO/qhcoE7X9msAtYwA==
X-Gm-Gg: ATEYQzzQYiMig9lUUNMib/fY+JRyn1XT0m4O7zXzkHY6t3l5gq+pJcF77IrL2/VF4+P
 uB8wag7AOo1VPTBbJepPe2KTmOojDVIHElJZu6zsuOhc702HEtJnCtQtDF9HJoAx66FqXF7mrds
 xLmGV9tPEVB5O9B9VTAyrjj3gWhEZjykXuUVKWAsOEAxNFXorBaQVQ0coz5uEzH3C5DM/2SNVne
 2qYejTkB7DaPBEQer6IPmZSuvFWcsOigoyieH9QSIlE9WpLxbLAJMjM8NpAKcYx7JPfJoWRLwU2
 oAPZR/dOeRP12YmAaj26aHYsVtxru7uP34WeW1Yv+o5xEPkAWg7ViBcoERHrI/OCtq6yAkBffwV
 owu5LAkaBrBXp/qVjvXB1JZaAwJAG4RWJq/2F0KLU0NBRImnO2elNEp/xbsFnlM60FvCzAMuE45
 TNCtlmp59AnxYHvtmaNbcUb+7JSXEXOGMnlocKPGqm
X-Received: by 2002:a05:600c:41c4:b0:486:fc5f:1ab9 with SMTP id
 5b1f17b1804b1-48727d8410cmr53152315e9.14.1774658663066; 
 Fri, 27 Mar 2026 17:44:23 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm116516035e9.12.2026.03.27.17.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 17:44:22 -0700 (PDT)
Date: Sat, 28 Mar 2026 00:44:21 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <acckSVyvtJTMsOGP@autotest-wegao.qe.prg2.suse.org>
References: <20260327123436.8195-1-wegao@suse.com>
 <69c691f1.050a0220.33d880.427e@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69c691f1.050a0220.33d880.427e@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 27, 2026 at 02:19:28PM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> we still have a problem with the patch. We are considering deterministic
> events, where one event comes after the other.
> 
> consolidate_events() accepts events matching either ex->error or
> ex->error2:
> 
> > +		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {
> 
> but the first accepted event becomes the one passed to check_event().
> Since event delivery order is non-deterministic, the first event could
> have error == ESHUTDOWN (error2). check_error_event_info_error() then
> only checks against ex->error:
> 
> > 	if (info_error->error != ex->error) {
> > 		tst_res(TFAIL, "Unexpected error code value (%d!=%d)",
> > 			info_error->error, ex->error);
> 
> So it compares ESHUTDOWN against EFSCORRUPTED, doesn't match, and
> reports TFAIL.
> 
> We need to change that into:
> 
>   if (info_error->error != ex->error &&
>       (ex->error2 == 0 || info_error->error != ex->error2)) {
> 
> Similar to the consolidate_events(), otherwise we will have a TFAIL when
> events don't arrive in the same order. Did you try to run patch with a high
> number of `-i` ? It should fails sometimes with the actual code.
I remember i have tested in openqa with -i1000 without error in early version such
as v4 or v5(The main logic not touched compared with v6/v7).

BTW: is this the final comments?
> 
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
