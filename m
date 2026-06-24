Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77501CDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782304690; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=cERfB1VyFsrFbHFUPbuv03At9NtNTY3BXtACcTTVE7A=;
 b=U4DTGMTa8hfN6wg0C3evPi35SWGddMWvxS1spApUdbnirTxTB47Y+6QfMdZgdeYl2Gwbs
 dl+fYUhqDnO8JhZLX/JSp3fzlPruv6R4+afadx4x0aRNznj8riNeklrNmbUCLgLfM3xXivN
 YTbte0oNrmw+w/LGebSwNN3pFlfPO94=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF05E3E6270
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:38:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A45C63E11C6
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:37:49 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E319D1A006E5
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:37:48 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-46255b269c2so691340f8f.3
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782304668; x=1782909468; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ESFKdELFcCNOu9D6klAOATra7FFLP8Ky61tTpclMUsc=;
 b=QCEyHwOlX3UlfedW3HrT9Ha3fRUc9CALY8qS2NmSRuYR+ybx8yJnGRPLA1wc7PCF0o
 HoRK65cXkzRhIHlDAp0+mMi2pCR7fU4xbGRair+lGQiaJ1HHfEQO3drvHouSELYW2haJ
 m+WRQ8oerdNiIjUkz3Ko6kbPpfjuhZhulwzGlJCXVJ1+rATbqtUPPHdbQpEJvtmIjfRk
 CK2oJozDZtLTXYH3xzpeSglAkHlJFZtLb8MIx+6wXHdm26i6kvPbHDYGgJ6uw3DCC2kT
 PctiaKA6xEI0vnU9FXQETN7ULseT+/0y3Bpp8mAbeYbOYf3IUkmk1D0FLxgSLumLjXta
 yjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304668; x=1782909468;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ESFKdELFcCNOu9D6klAOATra7FFLP8Ky61tTpclMUsc=;
 b=a9/sN90zX1ocP7vkY5lde90ztN48qyg06CJFrbWh0AufQV6QnL6xNzi+hKM0TSOZJ7
 fJ1/wR5pd5j6+AfaIUdxMrFDgseFpf7Whl1//75nxNPXPaJyFcYB7Vqna8J8+h7SJWkB
 lXaJJUuf/eA8fuqzpwCdQY45229QC2/iCJQGj0xcBhXU8HobuaNc/tDTSKa7f2qUenvq
 QME2WAviwOzVPsSX12YzmVAG2ItkKEai5EoAmmHEQ5Thj3CIz5nsK20xqhjxvmdAsEah
 q1yW3UanuQ7DO6d8w4nsSx2OPqtbdB5hAvj6pHWB8MTBdPLx3g3MG7Rq3zYrAGddyhv9
 fc2A==
X-Gm-Message-State: AOJu0YysfENGXlviiFrT17g2d2w3r+u7zBq8nNN4o20EMjsSIEiuhDof
 RwCvLAEICrj9Od9pvZjb8fNg0hn/AHtdMg/beQMkjXIjYdEhyKoVGt4g8zi68VNl7QXe9YlMWqH
 Zx7aks0OMLw==
X-Gm-Gg: AfdE7cnOobGu9H5yeW/xm88byRbT9PMzok6yLX40ObmmmR4W7ewPjoBbf4NhbGJEriB
 I4MmVD+Z1jyKpmB+o30N4xCq4FsXBOFOoO3ej7LNH6aDyp1hNVq740a+lVSVwF5GnDsuH+mv0OQ
 bMjRVLe/a/aH6LCRaalS588Lc6TYH6vvbkEJm2ujg67n6nheFI+kfDt2YFQ+AMhjEdIvDHrtXu0
 aP2QblV+wZ3pSZATNuCc7aDnmuBRUh1asrTLv2IGPq9sHti4eUw1rV2SoSNTzb7iVFcnFi6QPdB
 /7R1N5X7dWMsw/HnxzsD0Ov7rxZkfmiJWxvugo8I1cxOHk1VJGdJnPI9YxAsFiYak3kUxtaIoKI
 XamqfCvGEUJbKiRBanRmVwN3aHCR7aLfYaH5HN+DRsXBFqQSg1GIwadMpz8/mWqzjvNy+Vmz1/m
 PCuqP4MS2HhhJmHmsSmaVzbIY6Md2AId6NvQE1Y/Fg4P0o6UaBKPOwMbY9mPeXNg==
X-Received: by 2002:a05:6000:26cb:b0:452:c9f:4b91 with SMTP id
 ffacd0b85a97d-46c04a340admr5424521f8f.4.1782304668142; 
 Wed, 24 Jun 2026 05:37:48 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d9a22sm6531792f8f.19.2026.06.24.05.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:37:47 -0700 (PDT)
Message-ID: <6a3bcf9b.a1a40faf.11c7da.da5c@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajvNadKNfin2Ati9@yuki.lan>
Date: Wed, 24 Jun 2026 12:37:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/13] vma05.sh, keyctl01.sh: Add groups
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

> Also linter should be cheaper and pretty easy for this case.

We can easily do that yes, but I don't know where we could implement
this inside the make check command. I guess we need one more script
verifying the parent folders/test tags and cross-checking with the
group name which has been assigned.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
