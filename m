Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E135CDB471
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782302758; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=OGaAFvdxgCed1Gasw8mGE2W/m6jKKKVMagltrnMs3BHBfEORe19n9jR+YS+XqejswwiRt
 nrBDaMD3OteYqna7I6Pz04cbSRFD5QzND2VFPJrn/cLhMoSJkfOZZCAtwXFnlD+fjlbIoW8
 dirS10r+WU4whoZOE7CPCEjqcDBPmtY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81DFB3E2E82
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:05:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5CEA63E2E86
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:05:34 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 59DBB1400C7D
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:05:33 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so813785f8f.2
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 05:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782302733; x=1782907533; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Kp4a56OpwkXx5OHsWKFh4XbvCcllYa+H9LIGVvPq4JUazQ4jxJb5u3nfgWNR5hDt/T
 OXWXOPeWLPoepwa7GI9UigUnHyZ8cVXkXL8I9d/X5kEDIYY+VOzK0tiMi9OAlnGhhzLF
 47AZodBQTBEAdlq2KfxBupZBbJ/0ap3miIRqvw381TtsRBSoNP+2nbXeuyR2rap4+Jwh
 N1nLtHmnymIslpXGzURd51PKP1fiajowTyh+t2ftZWxZDqnWrZKkse5/h2LpaYRjVkcV
 sjmMbXTMEHb/G2B1dNIzaGjVFwFlTgEaspmckqddqvHrs/APrOLK91aUmxNf0sGsSVYN
 +9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782302733; x=1782907533;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=iQ4tJmO4AQxl+q3A3Uo7/xmEQ/ERmi4TpsjuAV8NbPpNNSWqHMx6iPiYfDu8VJn7g8
 oJCwhMdxTYSUu8DNFswaowvrg75jvEk7XIgPE41FAK4TpLd3ZD7Z6uDBM2XfDzgOwH9H
 LoStErhZOamMEIXw30c6oAAIq58NJg+HTQR/ja1w8LOiG0CKFckLegA0Ox7jcyjRFTM5
 u4RcYxZdAk/uh2vJr38uT4F5GnEwxvyFQ3FAHS5x90xOSJIy9WwpHzAgGtCPd3V7AbbA
 2spAJ8ksz3mCbl7q62j44zajPRb1rOKNTHimz1sIn6OXcucozjUU9TiEsA6VcBlIlkcb
 3RVg==
X-Gm-Message-State: AOJu0YzvX3F7yaGG3Nv9HSPRGvhNomcIewSm1xYVG3BNSi1aJaIRXP0F
 EUVvxPOIt+LNfdjk9R9NDN3mMkjhu+qHliUPyqLpgOUrfivMSxsezouLVKoYaoLi8+2Xl2T/f9y
 iRizeDKFNMw==
X-Gm-Gg: AfdE7ckYaRjedWNpx8fiHuw5IcyXzl7ixHMZDsSjywjohd9K0YElzxFDA/HvH3842S+
 ljuyVLJ/aekXMI1dREmxOXl6SUJtB9RchYMkQ76hXBGyDTtzhGZSWzB+K68256e4xGnK+cbi32E
 5Jy5ohnPPdoKP5icgcG88xxzE08lGdGPPss23pBCZfrXERSNk4o27/w8y1Rzb+XEAwLHeV99akI
 jTUh3dXmkA+NTXxGbY+Kw5OTMTe6dseHsy2n/umbSDohDh0IBnrcFxb238gPO05iqzL/bAa6t0Y
 XQOdSCaNKoauYyT0yk6vIhK7GRtucowvXOngXBRdJKXtUNjKGVnxXUSuwo0OSaxzFGCHpTpPZ5C
 GFU4tilnD1UqqjBBAe0RI0GJ/jvFrjSjgF+KP9/zb6ezRCyXE9pK8EyY3j6V0QAjuzm9GkPE/tq
 /98/0OQZKc/upicdV+lDfTYAepdHuhlHVxkTX5oeWE67HCw0xe3K6Rrf01EdYA2OK1MEBrORmj
X-Received: by 2002:a05:600c:3501:b0:490:bad9:de43 with SMTP id
 5b1f17b1804b1-492608fa418mr36974965e9.0.1782302732596; 
 Wed, 24 Jun 2026 05:05:32 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd15535sm490205625e9.3.2026.06.24.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:05:32 -0700 (PDT)
Message-ID: <6a3bc80c.561280e1.325e99.2936@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-11-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 12:05:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 10/13] testcases: Fix the CVE tags
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
