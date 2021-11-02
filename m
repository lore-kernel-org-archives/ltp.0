Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9D6C433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:28:00 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C61B560EB8
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C61B560EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C0C83C711F
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C4C23C6268
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:27:48 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0BAB8600A37
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:27:48 +0100 (CET)
Received: by mail-pf1-x432.google.com with SMTP id m14so19212937pfc.9
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 04:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=poO7iQ5eLKf23Vik4rTBqi9mweJB4HMVhR7eOi0UAbo=;
 b=LTaCvNxR0cU5QQZ/mGtUD1AgqG97RDQhxXF0Gegn7YTWQCHB23dO5jkzpBqUpnUqs4
 XF9rdFlDf6WZbe6jfqR3Xv2VYtUpQ72TNmmUVfADhgVPMijGiWYY+bgJR6eUmllEA/JA
 kUaqp1A2Bx4hEjCk5acipKIDDOszsTCeUWoj81Hv4Pfd5M5YF4MZDVPktOcHTYZ1hWNC
 ElRVxcNN96vRxWA6cECPf982llkgbJvI3CtnMqppLEk5fxtrvQS1RBEbZRqzuVdzMeuD
 h0t8qSzHC2zJQhc7D+8k+OEuDAEeSp85fO6+kcxPVOsfRmADpSM/jEUr1lMQmxy7WABf
 XNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=poO7iQ5eLKf23Vik4rTBqi9mweJB4HMVhR7eOi0UAbo=;
 b=nTS9KGYeFMUrnu+jkQHi/Kyhwor/Touet5STT0bC9gxgpMDsoUkPwqrf1p5WpYtXTZ
 /oumqzsavlRMV7gde99l6oYioeRkCVeiMMye5dBSMywpEz/vK4PcLfbk9KTnsVtaIIYf
 UBArEtEbeAw7kmA4t4qgepJBEVYpUbC8ELsh+teW95eumc8ZvDPkIe+FkvDpT5Mtfmag
 Agyz7GLi6eRotKqeB+IBDEAO/HbIKvev5CmymRj8Uya+s05+q5VTKZsAAqlNXMKNW/Q9
 FpPx6wqYgEG0wC8Q2mjNYRP0QTBeG+bTmt+4D0QenhZp7/YFS1oJQ/yBTzyfafXF3nI5
 7yqQ==
X-Gm-Message-State: AOAM530RK3lInpeTuQkz/ZyRo9hBi7gRqBrkhTwv5SjiA6wOh8NpFmLb
 lH34DgT7+RRMeVXYJoyRL2rH4Q==
X-Google-Smtp-Source: ABdhPJz0YyQNDNK0wS8N3wDrahP4zj5OidmDpiM08/I4V0oQSsPqOHyi94pj+2mkbJnn40ILj+Ek/w==
X-Received: by 2002:a05:6a00:1348:b0:481:179c:ce9b with SMTP id
 k8-20020a056a00134800b00481179cce9bmr9552491pfu.27.1635852466038; 
 Tue, 02 Nov 2021 04:27:46 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com.
 [35.240.157.64])
 by smtp.gmail.com with ESMTPSA id 13sm2267614pjb.37.2021.11.02.04.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 04:27:45 -0700 (PDT)
Date: Tue, 2 Nov 2021 11:27:38 +0000
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YYEgqgFoo7oJheFr@google.com>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-2-krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] syscalls: fanotify: Add macro to require
 specific mark types
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: kernel@collabora.com, khazhy@google.com, jack@suse.com,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 29, 2021 at 06:17:24PM -0300, Gabriel Krisman Bertazi wrote:
> Like done for init flags and event types, and a macro to require a
> specific mark type.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index a2be183385e4..c67db3117e29 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>  	return rval;
>  }
>  
> +#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
> +	fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
> +				    fanotify_mark_supported_by_kernel(mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */

A nit, but I'm of the opinion that s/_ON_/_BY_ within the macro name. Otherwise,
this looks OK to me.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
