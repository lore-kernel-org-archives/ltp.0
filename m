Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA8610AB830
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 14:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774621195; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=LZwvTI2OvzWcREoj2LwWXwPt7ir7DdKKuRjYPvT0nRs=;
 b=NULcFiXrmIG8R2GRSeM/I8UbbRcxlVKY56GmWAjGuoQ81wfxL0aRWYC22ofS4/Jzv6lKs
 GYOkkZ/v4EnG0u8/+5yb12ug6T6a2I+lvr2BSpfKtArU8BZJgU5KuysHCuTYqalvLfw1oFS
 0kHk4nimwwLHQyRoNuDv1uJEsHYt0oo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96DA53C201F
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 15:19:55 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C0363C1C0B
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 15:19:31 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ADBB5200097
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 15:19:30 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b611274bso1154712f8f.3
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 07:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774621170; x=1775225970; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=T72nEcFf7x3xiTtS7TUUrR84K2cw9+oMpRj10ThIjn4=;
 b=ERSoe5r7XCrophZZSvyhOQU5SP6TCHVA4vON/kU/JVfx0OdzvuWP0bDcZ1PA4hmJQQ
 rsvurUNZrK3yHyYVFkj8UnBHe3xDkjsong9Ric6ZptQWJ6DfpgEOOw2VHNi8zjkSizdX
 ekLpoAEF2mkQsgEPghnAEkJmWdZXd2jZhaEuooPNZEmHdRsAGN71+6OK8K36lhCmbExY
 U/91bhv1Yx8MFH6jdYcrwNET7abeOgtpKBvM64WGbHTHx/DWJAuVRAx5zkxj6BRl8G9e
 29pioRBILlcf8Qeo0iiJC5prDzdOA+6SA7FIq8fugarFocEGRwbf1olbt8l3jkqT1dvZ
 v8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774621170; x=1775225970;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T72nEcFf7x3xiTtS7TUUrR84K2cw9+oMpRj10ThIjn4=;
 b=BFbRWpd4V4c84MtmS5hSFQmakuGGmNs4LushTr5YLzhjZ+BnYNVJWG1NFnjjsPau5B
 1HG25O702gXJzkMdldqosklYB8cXAKGgj2CwqI5EGMJOBM1MEH6g/NkI2/6pWo+Fh0rY
 lLXA+LC5OkuK9SuFzzgY+v02ndxaHQSpHC7fhW4LLNHBW9xh0BUEKBWLhvBG7MebXAX+
 gwQVaUSKBHWi5Ag7u6jL3wqXPKEXdlu8q+hwK+VN/J+AdSgRUeDGp5WVBlhKdBRmIS4s
 0KnPwtZcR9iGbnooVXSnFlbzRe2B09GgKWaahSfqr1HrnS7gSHksEDhtyzhH3BNIxHgO
 n1Mw==
X-Gm-Message-State: AOJu0YxthobHvMsW+0A89BVHShwuzjaWgFBBE6Qn0/aJcIYKChkyRRuf
 MYavpegmVW8TD5WgTJl72/vsFQ9q/rhGB34fVw9sHci6JZEa2D65TkK0yfC0gwEeekU1yu60+ss
 ImssanImu0g==
X-Gm-Gg: ATEYQzzBLN5MeAKz6VD8Gm2uKr7jj8p3/LMYlfJdAqduKuMP4JVniqtvSYquQwL66fX
 7LJiyJN385CIvk2dZdsTn63UVNWRByA0j7zkTY/AbMn2qXRAeoeChXAC4mxC9fKhanLhEdkx0bZ
 h0/yJwV042GIYex0GJGJDY1JJfgakndcjpywEVyM+pJWaTp0TG9Im4ms5Ov5GhzFqJwg13RBBER
 T8gpUq2Mjjn4gKwDPweGU1TCV6iiYeWALttN3ncE0LczPRAAHkAHpcjtI6Eie0e6yEHlHx2WWSt
 a7y1mIsrRkgWn7oBe7x+BNQJGPfmx+Y/U245G35GcJT1y1DXhselgmE6cgNCbZFwNDvSRDRWlZi
 dDUNPpgr/zyQC0xE1+5SB1Nb7AtJ29KqShOox4pI3cs7BpksolBAih948DobIeXqkUMyOBabnzv
 4JxepkYI7lxhTr4qAS+xIHJQURlNfrzwg8sX43/pig3tOXSh69wQ==
X-Received: by 2002:a05:600c:c102:b0:485:ae14:8187 with SMTP id
 5b1f17b1804b1-48727d594c9mr35444275e9.2.1774621169964; 
 Fri, 27 Mar 2026 07:19:29 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c65989sm153468285e9.2.2026.03.27.07.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 07:19:29 -0700 (PDT)
Message-ID: <69c691f1.050a0220.33d880.427e@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260327123436.8195-1-wegao@suse.com>
Date: Fri, 27 Mar 2026 14:19:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

we still have a problem with the patch. We are considering deterministic
events, where one event comes after the other.

consolidate_events() accepts events matching either ex->error or
ex->error2:

> +		if (info->error != ex->error && (ex->error2 == 0 || info->error != ex->error2)) {

but the first accepted event becomes the one passed to check_event().
Since event delivery order is non-deterministic, the first event could
have error == ESHUTDOWN (error2). check_error_event_info_error() then
only checks against ex->error:

> 	if (info_error->error != ex->error) {
> 		tst_res(TFAIL, "Unexpected error code value (%d!=%d)",
> 			info_error->error, ex->error);

So it compares ESHUTDOWN against EFSCORRUPTED, doesn't match, and
reports TFAIL.

We need to change that into:

  if (info_error->error != ex->error &&
      (ex->error2 == 0 || info_error->error != ex->error2)) {

Similar to the consolidate_events(), otherwise we will have a TFAIL when
events don't arrive in the same order. Did you try to run patch with a high
number of `-i` ? It should fails sometimes with the actual code.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
