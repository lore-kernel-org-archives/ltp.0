Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AE7C282D0
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 07:54:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E2063C9D1B
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 08:54:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B51173C023C
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 08:54:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 80F2A64AD0B
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 08:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741074838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Cd2O4jQt2h98fE2PiTMArUANXDp4rzbdEt011P/QS4=;
 b=ZkE3tmaVLsJGUQ33vzgHlWrN3EuwvVIr+W++3dJZ4jYKJhw991SX5OWuoTofqpJPBRTr8c
 nCHKHVxSX1g9GJaWW/H9GoUwn7wHFDbgYQhuH2RAPVCC78KMGAxYT+qAUBSTP6SdoKk1Yv
 kuGye64BlIRzBQ5wjbUSncjddsi//p0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-suDjCMiuPveTbOND0X13zg-1; Tue, 04 Mar 2025 02:53:56 -0500
X-MC-Unique: suDjCMiuPveTbOND0X13zg-1
X-Mimecast-MFC-AGG-ID: suDjCMiuPveTbOND0X13zg_1741074836
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fe86c01f5cso10559740a91.1
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 23:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741074836; x=1741679636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8Cd2O4jQt2h98fE2PiTMArUANXDp4rzbdEt011P/QS4=;
 b=jvwHAR52Jgty7a4D2ZhiCFafG+YS9mkP93lqWT45p6yK0o5kkcztrMEv0c2gESZUaT
 AOF+AS2UohoozU92sRj5dpDaXXhNf2jRMkcnUIgZgGIL871RzUB3JJ6R16/T6AM1Wo/+
 /rUqkDjGSfiyrvfoNyLiNMElFt7XbKJVKTOCwJyQ4RCMN8UpJgosrAmjAG3HiLaxPEU7
 9FKnG2CFWmpFb+1BfrMC1rITVTZndkdgUqpeFtlFBKVjs079+eU3b57ii6JqBPWTBuhv
 UtON1kGLhLP3nQOQICdKXszZ9stfDgfmFZNlAANLF6UynChXWty9xOXgBgOjRTsv6hoY
 bvsQ==
X-Gm-Message-State: AOJu0YxOYLKsSRmQb8p1eRw9O0DKiDEIWM6CdWUjY9Rz5rny0vHU06Yx
 0gsnNgITi/aZgkznj01KLE9rlP4eIVDmtvm83D9ESX4gFW8I/Vn8sLVvsP5iKHui7drBOpNb4/C
 Q8BfVnVCnAL3xSy7CRzxK6OTDLtlPqRoY6qB6kE9D6PYiJG7o0BufiwSzKDOGlFc76spOXUQFnH
 tPMfRCRXg7lUbI/YVamtE6qHs=
X-Gm-Gg: ASbGncu/9GIpNPpyNleS10lfBFTxlARCUA8ryvNbtGb7haO1+2d3pMz67CFBd6QzuM6
 aUN8BvnQzycF9wnr1xukcUOGbqTEab/zU7zA/R2b1ekHw03PoRmt2tmrSoDhGnDcoKKp5JOvs5w
 ==
X-Received: by 2002:a17:90a:d605:b0:2fa:15ab:4df5 with SMTP id
 98e67ed59e1d1-2febabf7de2mr21807057a91.34.1741074835767; 
 Mon, 03 Mar 2025 23:53:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEddlluVLGmLoE6DKNDruYsfillhZ5XJIZyQXH7B8D+9bDHlYSMlRUBQS2QwBoFDuflAN4GS53juXMA6x2Fggw=
X-Received: by 2002:a17:90a:d605:b0:2fa:15ab:4df5 with SMTP id
 98e67ed59e1d1-2febabf7de2mr21807043a91.34.1741074835488; Mon, 03 Mar 2025
 23:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20250228184834.1330657-1-edliaw@google.com>
 <CAEemH2e-eEvbOT_ByL1cwJODUg7rS16nO0aYVd4DFCAQB=7uPA@mail.gmail.com>
 <CAG4es9Xqe2yO2oFJxNxic5WCXwvpgKhQ=afJbNv=xDp7c2PtLA@mail.gmail.com>
In-Reply-To: <CAG4es9Xqe2yO2oFJxNxic5WCXwvpgKhQ=afJbNv=xDp7c2PtLA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 4 Mar 2025 15:53:43 +0800
X-Gm-Features: AQ5f1JqfZryPZd5rUvWok77_0Is-lPXOw57o3Ana6ywxD2J2J0NTqDmqFfKuc2s
Message-ID: <CAEemH2fN0Gq9=gmQLLwSDw8BJcUn1Kv1DNg2_oh=wOSLX6m2jQ@mail.gmail.com>
To: Edward Liaw <edliaw@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VXuAjsKFMvvHixTNNd8xFZqokEo7MCyMzwZGoKO44gc_1741074836
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] input_common.h: Add retry loop for event device
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Patch pushed, thanks!

>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
