Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103B7D3CCB3
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 07:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768462383; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=qopGSwch91IiLmexdNBrNJKyva6GVcUfVvtYoeXQWdI=;
 b=eHawZIx/oHgctSWIKWfazZ4T9kzTTRPHHxs7Q0yFgOxahsWx2Qc2WZsOCKDT/nAeiaCVc
 AOOn+AB6Cfw8BDsnx+444JhQVFo+zB3SEsadHZtjBtaTDhanMOJ+K7l8gez9DTsGJzFDeiA
 iM5ldwSnAnnjis4QV1idgXWmUyBtmfM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D0093C768C
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 08:33:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 855773C12E0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 08:32:39 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A37C7200246
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 08:32:38 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so644955e9.0
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 23:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768462358; x=1769067158; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEnWKfB/t9rvHwkF4rycQSvL4zCa8MCD6NDYtBHMVBE=;
 b=LsJoSdCRLibAnK9PEhBwS7kNttVnwPWpXklT0BKqrxLFPKZTc+9Nf0w5Z5lkLO6q8N
 Jj+O1KlofEFTdZDvPKtOX4LSf9x8zGMG5TeULcBOBsmRJQU6Ky2UQUxgo+ZErgNiHF7o
 REOsodnk9LskqieGItUkKzv07p4EbQ8c4f1v1xcnL60xyeySbbIseg1ZS2Bz6x2Z+NTC
 IWwdkG3YxPRQT8YTeELA+GOqMsUQTx+4XfONI+rHWP/NwEMXVlY1z7y6kv1e2gOzg131
 QjuKcxpifeh4DyAdU4SLj2a/jihDzg09IvD/vL0i/maBrmuLp7Eh86/PUVJXsw5IwvRZ
 N29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768462358; x=1769067158;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rEnWKfB/t9rvHwkF4rycQSvL4zCa8MCD6NDYtBHMVBE=;
 b=rvlAJ/4Jijv52kjt/zJKkz4uNF7eUKlD7DwgFok4sGyfiD5I/9biEUIrL+/JmoXD/o
 hlc0tPEjVTrSMIA6ncBulG6vTYBMJGquu9KZdr0zVtAbUyt5fU1hQeiuxfYe560ZCMH1
 mx/Z0ppAg3Z0T7LHKd32sE3AH+YXY/7YnITbcuK9Zjbyq+CkY3jqsWYH6mD6pfjIRBH1
 8QJmdbtHCPpMB3hmRNLv1bs+rpHOC+P/Xp9nwJholw4qkr0EOeTCFA8b6zSoLUdViXw8
 s7wIZhttYgpdwbTOL1zAEKvF8sHmMU+Nz6jUnX02iZDz/ofmHszr+GIehuJfND0qCxXr
 NotA==
X-Gm-Message-State: AOJu0Ywi9fyWmYf2W7DzoGYP8T/CemfNPLQyjwrV9IUBAIxiGDOfpTZJ
 k2LRap/e11ER3yAyAsdADWC6mQCc2VMMLSSzuuDjJqRYWzpWxvR3KH+WrLxoGkbYK9w=
X-Gm-Gg: AY/fxX5lB7lc3gFU+4/ZbJOnzZqj8d1f/xxLm+Re1wmItXoJP1uD8LjNICpjvWj6HMf
 D0rdgiSE7gUGxXd0o6MRnT4erQHazDfQHLZ0UQSc/GoBD8rcVyZJZT4yCdABG6iU7nZqU3I6IwR
 wItwlfslZ+rfkNfBRaoquakFjnctRjltM+PErJOMXOS2Dq14SP4MMavQubfYgavJq+gla+LkOXu
 zaUHYY2QU83TyHBq7/0uHozubTD6zTOm/naAj8qIWHLElcGQvZ6SgvURqjwkqbpRQHInLNZSxTN
 kXX0s2wzHOuukFKwZV6FrUTeH+/84TdmGNiVA8V7cNzpM40QGrW6ei2nkHGgZX/o3SlMed8oWQo
 sIywbsbDwNO/fmLsDunv6rGeH3XDRn+5uXC3TWJY66aF/N+xdOTNrF/lBRPBGiTkO04tCHl21sE
 3rmM2aYEHjIUve4m4XqcNUcOdsr9Zu/JbdXIJPKR8Mqu+dnOBNlcKzgThvm8NsT1gArsftPduHP
 GHv70M=
X-Received: by 2002:a05:600c:3484:b0:459:db7b:988e with SMTP id
 5b1f17b1804b1-47ee3305a23mr61284895e9.13.1768462358036; 
 Wed, 14 Jan 2026 23:32:38 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b789sm31335575e9.1.2026.01.14.23.32.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 23:32:37 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 15 Jan 2026 08:32:37 +0100
Message-Id: <DFOZL37P5I1Q.BU4BB97DWGQG@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.18.2
References: <20260114-fix_ci_doc-v1-1-5203d4c21546@suse.com>
 <20260114163449.GA423783@pevik>
In-Reply-To: <20260114163449.GA423783@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: fix documentation build for new patches
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
