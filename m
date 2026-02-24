Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE06EFB810
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771922692; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=WUvQDQ5/98IGDYoY6OxYHeTulLoQgCWQzafyUnvAPWQ=;
 b=Ed/OwMeYFHhteD2nSuyE5zSCmnHRhTTcL9xXsk0iXtBvQZ9zsuypnI7TurS+7qaNuvdpO
 ZmvMZO33yt1Y4f801HKBdcrAG/DhSsvanGXtlFdLO7rFid8S0XBnuIFnbw48X/O5+3mZKSn
 rsldpSE5aSOelA0HwlvGg8MmDBlfjmk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 642F43D0657
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:44:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DF533CB958
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:44:29 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5B9D61400BD8
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:44:28 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so41421565e9.1
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 00:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771922668; x=1772527468; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KvaoQ3xty80MQqJYcsxudLAcZK6JNQzuqMrLXC5pP4=;
 b=RNqLb6UQ4c+QVaiE/OjQ809LE73Tp4n9euQhrbUaff7XET7AQXlH0liBZjN42bu7Ub
 t/zoI1iybx2uKS+h7jNpMpGGJ+CujWB/WkdWhvTjI3Wgpxf87lLrI311qJwru9MJ9SE8
 9aUbEmXFgKGEYNGCpSU/j8co9h9cWfE2f578+EAwQAGlND7MTuPIyUWQn7CsGKVgqE04
 WsyHwtCu9XI519Fz8nVQCNOl9A4EevelG741cvMYgvg8wctSWjhubJxLLZmmzLB0mapc
 DBqHaNvDTY471pIa78907/Khz2m3HXY5M/HENHFttPlttXyPBv3LAT2/vFvlGlLKK3j/
 FR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771922668; x=1772527468;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2KvaoQ3xty80MQqJYcsxudLAcZK6JNQzuqMrLXC5pP4=;
 b=p8Zq2jUJX5M30h5AEWEXPxUuwu4ZaMywsWBhiEG9iGOmn+g1kkxyYg6wyOUjQBFL+V
 x/WMU4Ybo8jdsmlF2fWo8dw6/PfcIk7FCtNRnMP5DEYm7oYqFVgNyeJHCpmAAY0eLUmk
 SxRBtMqwELnzhVjmUZsKf1FdE08tvOieiYOATJktP78cnceKMOV+VxyENB+5q6CQPYH0
 usbhfL7ULmRmJ7pu25ulwZcxmqlpq9AQFssCj6yoBdV0Iwhh1rpA3efHWfBgxzKnCEXM
 hAH0qp5+0TEHaNr/pHr4IuU1M/8tg5fvPIDOIOhLZc+4KO3HKTGL9ZoVpR883bEBQSl+
 TmiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3GJS1QZ6u/b6ecHglkZ4AkTHl9mdoj/yjOx6h+HsdMvkbIYJkvN21zc5ovtpHhmnMJbs=@lists.linux.it
X-Gm-Message-State: AOJu0YyKr7ABuPL7my4paj5IOZ+/Ei3Vm4JrHxWyXAicZbxrHQHlmrSh
 HWe2SWg4pQL/i8wOxyStcpyO9GXbasGuT7XGy0fz89jNY1lvtaYItxetsd+blZlyr7uRfSsu6X3
 vNRffxj4=
X-Gm-Gg: AZuq6aJZlKRgOnqEFyx65ttUqdSzRAhdFiIIZd2SCtBIwnPsGC2DgMwyLm0n8Cm/F2Z
 OheOnpLtUzdid1CzkTcaPjdC/mEpUtgikBIq34qPoIKbYXRSu6vyRrWmWzqigSVoxDx74N9pr7t
 9XCgVgQOg7wjsmjwqioZzNsC+63uO+o1TtvNKM5OVvmTlLrF8oGZOnamNVuFvwoDg1NHM1f7RCS
 BTGS96kaZkfIi0wk6TLmTKWVlC2krTnXxwBE6Itw4JfSnYFwE5ssg1R5bs1Ij0u3XVv6Ialdrvp
 yfI4ZVqJHXFxeFoBEeLCKw4FFcSP/yt2JMEdCFAPLCz7lFHrSzuo5kLnFUMqkUFqNwNG4NcZOKh
 6KoYhCt7W5ZygOlWELauRZhT5NwfoBq88leRkoZE8WuC2YdCYne2wDm2CNHCFhnJiGvQlkDWOQq
 MCGyLVWIW1rVaYPkQe6QM+v9Ylzv5vimBDdFWrryKu8o2xxhkDO/t/4Uu/kBXd9AiU0B9D25RFJ
 VhqXP1r4eznmn0vWaI=
X-Received: by 2002:a05:600c:1d1c:b0:480:4a90:1afd with SMTP id
 5b1f17b1804b1-483a94a99e4mr174749485e9.0.1771922667439; 
 Tue, 24 Feb 2026 00:44:27 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a316eb08sm349089345e9.0.2026.02.24.00.44.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 00:44:27 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 09:44:26 +0100
Message-Id: <DGN25VHXT2G4.507OAS8IVWV2@suse.com>
To: "Stephen Bertram" <sbertram@redhat.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260219135019.1140234-1-sbertram@redhat.com>
In-Reply-To: <20260219135019.1140234-1-sbertram@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cachestat02: Harden parallel worker execution.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Merged thanks.
Fixed the text length inside commit that was out of the requested
80chars line length.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
