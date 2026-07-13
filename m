Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0E3C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 10:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783940024; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ZMc/BIRSrkWsRpSB0sfSgwrox0tOI3BqrhfgwqeptlE=;
 b=GrVSPLIROkAzfJ3L6VWsb8V/bZgcdP4w0r7DR3wjSbJgjvrFRz4pqlzF7PF+wiqLa9e3a
 F0WSIZZWAR7RVEa73ZiB2BpjLOJ5RQaYgZpRCYjzWd7W6cO07Ilj4YM7mWtV6ggfg6xdvGP
 TTcxUBrja9PG8H5Rhz0lrQuZz4eYpfc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06C773E5BA1
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 12:53:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51F4D3D00A7
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 12:53:25 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 582CC140033D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 12:53:24 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47362928f65so2934580f8f.2
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 03:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783940004; x=1784544804; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AIspeMJbwqBMA5mdKPCDGZVxvvenrVYBY2N/Fz36CAY=;
 b=PCW2X8Hztbp/Wd2m2ivYEkr7dYQWeWu54mVhWfuBaJK5LIwQ8K+PiVdA4g+gMczzbt
 ocB7YWwrGU5UrwxG+C6jGVL/phGTxDuxpLTN0dP2uORztZDNSDep95JjUmx4GSSV9XPP
 MlzZD9X0KN79c8guzpGaNKUys5MoIcxl7qBEoIwdkEXU5NfB3azuNAMpN0Vb465YjN1i
 /9ktIQz4thgCUj5Roi8JfeuAG/3Tr3cQ35IuVGoyXsonhsqzHjmCUOi7Y11RQ2hKePcc
 1pejwkHnLDOEJgrJPZPdoWFT9/FdztjAwm65anjsBBzgcWlCQX5hb8mT1dlwyNmJ4yy4
 p+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940004; x=1784544804;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AIspeMJbwqBMA5mdKPCDGZVxvvenrVYBY2N/Fz36CAY=;
 b=Z/uZShJXkb5Qot6mv3GFP1Rbb8klkxgrIbt2ofsDVwI2uIAAtdgfPZknLlSKmqDILc
 2ezfTS56AO+IO3w0g3YKaA01FkRRoX18LHqSLQvJLNt1681OxTF1OToepv3px1BllnfW
 kJ9JJXWAhc6e/rQpH9hxmBr09jwOtSkDAxY2jRjscP0z4yInlwtuJwd4pq7suK/tqLnh
 qOYvwCd1f2Yifz6LkOTLx+lVO6uVCPEfcPK5eWFV1qnb+rvz/zVFQVLnht7b3mappZZn
 f3bAivwYC7wQfXbEm4vKcplIw4VH2jeWGclpDHJsWc3WVITaxn5YIHHqoeBz70/lD4Dq
 rOwA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq67b693qFfCKwypCCRUEL5LjGrtnR5mp8/rRRi+DaWmWGheD1NQMxs9Rlh4a49zs9UGk8=@lists.linux.it
X-Gm-Message-State: AOJu0YzQsiNkjD6d4XLgRWq2bycU+gtfWm4Lb1LFtdksuedoqUTpjmMY
 TePd8alP3e/w0K55D1Gf1iaVFdtehTjTANxTo1HfvQDljszdq4z70KwV68y1/GzUtCc=
X-Gm-Gg: AfdE7ckKEYq4J98F0+DlImJm48vDYdydVE8ZgVfo2pSkxWC85gGshj3BsQqonGVz8AJ
 BgoOMiGgWfmTn4z3jQqmbVR2jn0qxbwpwiIJD7SgIdsslcMlfneOvVUD3jm4ilTVcFBXsR5B03g
 EZQz48dr9mRuH3zJyZJ3uXu9LJYpIgc+oJvncp5vvTtjMrg8CCwa8j5xirohn7rpPSPaOlQcS1h
 vEtz34ldYhsTUbYahTfNkIU89/vE5zQZXIYMl5JOuHK1HAMd4pUtNgIS3RRb7/XXZUvb+vBXbcM
 xXw8/Wn92TP1i7bqMVYKeRNo38Q+BtOeOkGWNBnWBxNpcSai0g/UT6st6MuTbtvPuLmqUOzWF8P
 k3dvhBTskcRLh8YXk3v1LJbc3qsnQ9MrwGbIvJFnQY5LFKwooAa28XPhPd4llCyuUJv/8Ipl/8M
 nh4fC3ZbP4Vp//BsqcbTmYnKnp9NmXw/gv
X-Received: by 2002:a05:6000:41c6:b0:45e:f8d0:d22c with SMTP id
 ffacd0b85a97d-47f2dcae7ffmr9473121f8f.25.1783940003705; 
 Mon, 13 Jul 2026 03:53:23 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d91bsm89679847f8f.4.2026.07.13.03.53.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 03:53:23 -0700 (PDT)
Message-ID: <6a54c3a3.c9089686.76aeb.9e76@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <alSz9CsUarbMjg6n@yuki.lan>
Date: Mon, 13 Jul 2026 10:53:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] metadata: test.sh: Add support for
 building out-of-tree
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Writing a prototype for the whole LTP would be a lot of work and it may
> not even produce something that is usable.

This is questionable, I think it would take no more than half a day with
the LLMs applied to the PoC I wrote a couple of years ago. I can try it
in the free time and see how it looks like.

When it's available I will send you a draft so you can take a look at it
and we can evaluate if it makes sense to try or not. I'm sure there are
corner cases where autotools is better and vice versa.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
