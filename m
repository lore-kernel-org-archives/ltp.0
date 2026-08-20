Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D87C5DF81
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 14:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787235856; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=KwmqZtJoHKe6ulIB5X15k98QFyJ3kyqRhd504Q3LBlI=;
 b=YASJv05c+t/m4yvMbfpOxSRsK97+XLKoJ475Qy/09lN3i9l0NizpW1+qwLnIxT5Fdtwg/
 ghoN7ozRuQmrGoQ+nLpohyJcJLFlCj0zxpqhX/O4KV6OtOhIugY6m+ZnoFtswhvlrQl3Qh/
 ScSNkQiFCBIlzosfYJHOw5CJ5tCRO0w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 810403CF3D9
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 16:24:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51DC23C0962
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:23:56 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CBADB100040A
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 16:23:55 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so2457155f8f.1
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787235835; x=1787840635; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JCqo9Ifb/W77sKQi6N6fWTmj1GlI2Ouk+JZFQ3GLHhY=;
 b=F0VtLiiwpCRGIi/NEZ6A0hH+Rs0q7UMd8vTEA2KLcZC5FKnZG3k6fdvnIgMffFUXEZ
 /Z3AM40tJvD68MhOqfroE8f21RCzilVcs+ZNT5Gl5bkDJwH6PXMnZxHINgv0q8Nuee5y
 6xP+lQ84ELAKH584IuKqMf8lGCOEY/VdGAfeXXGCZJRBV+d6MDEcjtFBj/+S4yD1NWju
 3CjwmHDmyxOsXELPP0/Mqcs7nMz2mzzVoQrm6IGeiIklKbyF8DWalwzzfvTq6PJxi8ia
 MnDe8sK3zDU2IQ6W3E0aaqpMI+yx+sUmlFxYPWgiO3VFrA/rAWfz7b7dK90eDhHl1NcC
 L25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787235835; x=1787840635;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JCqo9Ifb/W77sKQi6N6fWTmj1GlI2Ouk+JZFQ3GLHhY=;
 b=iW3fYpgBwzIvU7NMDTPJEj5xVVr7WSq03nvxkOl1XiKgZAMgs7F/5HhGTWyYzqZBb/
 OncCqXU9Ew7a8iuyQiK4kVvMU2d8D/VSooPnaHfMd95t+wZtcAbPCuUMa9KKx2eFmjHP
 rn0/U6xq+8Vtz7nQBZd4NDLvhHLhHtL+fPRa5Z7PhMBha/YdvVn2FDO6jdOmY0xGbsOz
 EhwYxIOrUSSEDbX8SXhxVkjjhh7oJLkdd4Eg6b7mcSRvoIzgnY6ckK6cTXTp5X8RMQ6k
 HnI50dY7AeXY5NYdWb6hy8pO561ci/mvArif53K6OS3ZsMAUxEExPDQhMk7sCSo4IIba
 4osQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrM/ao2Ox87xPLBOtln6/qyf1SLoXBe3yFQL/g+OD2ehDR0cJfBwQMhDgCnrjLATh4zxFo=@lists.linux.it
X-Gm-Message-State: AFuF++kGY8KVHlPA731rRwIikyrJyIdaq0dx4Vk0w9LRkPHaTbTTrYl4
 SvAOYPxCPQWKLn8ak1x+RIoQxp2LI7BubZ4K40XyeJqTGt3U8NX8AwZj3QVSrgIWq9Q=
X-Gm-Gg: AR+sD10itZxXqFK1tGqX0vaxSk1PMf4i0+a5pufk1uWAxyYMCuPPtlygzN4MeraHLsG
 fP0lIhwkpv/uGD0mV8vfrTunDylH0FlqiTjtsct+fC1by3oK7Rge752TekkhABI1nRwvT2x048h
 yvje5AAysD/9/Zag6dNyd20AKl/jn97KC0ZL95mIhqvHcKOz2GVx/PFQ4k/sJqnQS4tDhcB7VZ+
 1aKX7m27KX8X2RCPjp4eBsfKJUtK+ox2jbyoGfwaF5noY6yN0BoxzQJks1Kbxgb+piaxP6aEj72
 sZFfkXyV4sgrJI053VSnFi2kMbL+3z8mnFpbXzzq9xoeB6jBmAtlnuNrTKqYkc+OOCJbpkxaYT4
 x3GIxwxnzSwFkT1nfYg4K66pFpjpvQ9b5bxUm9uP8NBnfouIT82H7EnZd5wauINiDsCQsBfySac
 9kjDnj6z/6LKmaM7llsLAW5pf9IMv7Lq6U/3M+gRTUMGl7RUyMJMehik36AUpNOqzrxu2WIszXv
 64lM+6ghg==
X-Received: by 2002:a05:6000:4a01:b0:47f:81c4:36b4 with SMTP id
 ffacd0b85a97d-482b1fd479bmr25008398f8f.14.1787235835094; 
 Thu, 20 Aug 2026 07:23:55 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b80a5sm13879836f8f.24.2026.08.20.07.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:23:54 -0700 (PDT)
Message-ID: <6a870dfa.332d3c56.afc7f.5723@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aocLlPNLd_0O8VP-@yuki.lan>
Date: Thu, 20 Aug 2026 14:23:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v2 04/16] fchroot01: test fchroot() with a
 directory fd
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > + * The syscall runs in a forked child so that the root of the parent
> > + * process, which the test framework needs for its cleanup, is left
> > + * untouched.
> 
> I do not think that we need this. The process that runs the run()
> function is forked from the library process in order for the test to be
> isolated from the library.
> 
> As long as we do not have a custom cleanup() function that needs to run
> outside of the jail we do not have to fork in the run().

the fork() ensures that if fchroot() passes (instead of failing) at the next
iterations we don't have a dirty environment. This is done for all tests,
so iterations always starts from scratch.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
