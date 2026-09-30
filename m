Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24C2CA5FC1
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 19:42:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 860393C99F9
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 21:42:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 72DDD3C73DC
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 21:42:24 +0200 (CEST)
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A47636002DF
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 21:42:23 +0200 (CEST)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a5d8fe8912so796460a12.2
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 12:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790797343; cv=none;
 d=google.com; s=arc-20260327;
 b=l2MOV5t+vqao/NacUT9HNYHg00nR47LTlmN1T8KyJ0SRcICFHTemgL0Scj9gL4xXp4
 3ApqNUSWqCnbEb4WrsYJxF2qYS5RHCcekk9grU31QVlzcrk8QoiODtM0v9pfzEDNVLw+
 VXKnsyw3QaAfIUF0AXfnkL2NhU/wpRt0E6azCKTMlpvQomg2q3Q2u34wC0yy/9faIrGy
 xFW8CPorTpA6SeCp85YkKStFkCbPaiGkTt60mWIRrDGxul7M3JtPnyluKJ57vcNywY2c
 Wapse8x4d8gDpqQ+ViLJTVa/q/HXJoqAC+M8tJ9ndjNQlLTrEv2aTLv80HegPQdvZeF0
 Pe8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZvxJ482jmiC7fOb6OyQb45DOoi2gyiJsyc/9TG6wFFY=;
 fh=5rVajFr6pEzxGWYdr+bXx5ScH3RywqfBBFeQ5xF9kVA=;
 b=DLJyYL/BcdvuMg3dFQ+X8KJW/Std2ZJiCY8eWOJGthU1Rouwc7xjn3JpqFoQttPLMa
 s8aXpFNSe3L4P3nR7FjV6dy1nT1QmGDr4ClrOtkQnVnP9ARBhKcwpX6JCMId3jEfDGCa
 8N3IAlzy6EVTRWZ4fdnwxWlrQ9VypV19wvCZz5hpBZxBIFUTm0wiH571XaYXAACdLlTt
 9bdEl+Yq51+U7o2PbeD7U9V3Pq2LD1g9Y0LUqrNCnvs+2OrFYKBsikvxYiSYhM7diLEP
 GyYieYQCcT1l7A+EDhnkzcx7Razza8UNYxKrU87OjnlW5CV8Pbqb4jYSijSFJXNuERb3
 fcAg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790797343; x=1791402143; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ZvxJ482jmiC7fOb6OyQb45DOoi2gyiJsyc/9TG6wFFY=;
 b=Ck+sMBzpV0mmi9bSrfSlCwSh862oncYCK2td0jHHV8kXeIi7AWdeJZm33GF53uSVwE
 v57janWKNQnhdCAUCh6F/ZpOgYPT9Sxlmd8yHjYOdhLbv38KTSMgueZoZ3nFwENWj22N
 C5sUkTRRiPx1UwwklE4+LERt85+rGDMZO8SEqBImzdp0t3QYRr9kbZUNsu5zJg1EIjNE
 oc6D71BJui5c+OolJiMNcQakwMCuIzgLCtc9/sDl65DnWp9a34/kXcutPRBZB9/NSWOv
 2KfUSBlk78c3lAcYekDJ3kfQzCCeHg/qGau3ZgaKVpzKsppRRaUH5gWZOfvcnYnSzUm5
 ZNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790797343; x=1791402143;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZvxJ482jmiC7fOb6OyQb45DOoi2gyiJsyc/9TG6wFFY=;
 b=mKY2x9y5oWA8gkU+bSBFk5MDtcJHEAJI197ZxnTdUObG8QIkebTenhVwhLi+EVlmzx
 xLor6Jx74QSBvAp1ajzSIoKa1zJc38fEoDgQ28m5sL8tNXljTqg/cRcrfruSFIyuzf9i
 Vdi6vwebfKsVIz3xEwvVeLjDpv07BAPtPE1hJ+XDqPFnoUH43obcsd8rQrUmMGX2xsqL
 OFSaZVC0iGsPWv59f6yiuITgxUQc1BMh6Z1bBJsFpojS0bdD3hFqnUHsAtpoJf8T9aVf
 bJf340AlDvTeW+CASWOwWf/2qdu4/zSdlFChBWLDxp5yif1yk6KPGUUtIY7P3YDcGD+p
 EgZg==
X-Gm-Message-State: AFq9FYJLIO7p3VXEwR6jl1vpU/2POIfJAIUfNs+mBeMAWCWFgXohybi/
 B/KmP+t2b4FvJgVv4m7tK2oB6wkBajzLhKStszQ3SkY+VeoC4ExkENxhvNyxEy9KJJgyb8y3mGn
 RSSF5v5g/wKrXZpnLYaYeFxoMPNrWBjPjW4oNOzQ0Eg==
X-Gm-Gg: AYBFou2fr0/2cesKCf/VUxFCwFTKE4A9XYV3XVjDp+37isFXjVsWXJ+2wniAeke55sq
 IinSkfduM9uaFu2SLFBQ+45JzqWmSHLdgxxUpM8M4mSFU+FwQvsijS251oLbnREQxflspMws5JG
 88y4v4ngM2zvZCljC+iy+w4pGpJ68PgQnxrkaFyf0nwmizYr5mCJonExWK54gGzwDDJgBs0OWzF
 QyVQeqCXaW7znGAAtmHE9PQgdVoxwwwKwasBxhZ29uxUbNlwX3BaS35MNSIyIqCvHV42NyB7pTw
 riKt5VtcU9kUeEfPXzk2k7P7v5MUp4FV+lmQ6c7JtWA7hJT1svsvEA==
X-Received: by 2002:a05:6402:4503:b0:6aa:d21c:9c18 with SMTP id
 4fb4d7f45d1cf-6ae198d5877mr2065310a12.3.1790797342941; Wed, 30 Sep 2026
 12:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260929084253.3093742-1-anders.roxell@linaro.org>
 <20260929142156.GB2462033@pevik>
 <CADYN=9Jh83y=n55DbM-niXBE0kot87jECtuM778_WSo6e3p=8g@mail.gmail.com>
 <20260930135333.GA2721643@pevik>
In-Reply-To: <20260930135333.GA2721643@pevik>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Wed, 30 Sep 2026 21:42:12 +0200
X-Gm-Features: AclHuK9ZmbizqUarQm7GzwkYMgYnm12JqbFzQ3vUOJLf1CXbvKxriUG0u7SK1fg
Message-ID: <CADYN=9KHh8CWs2s-ed7t8fptmouC_qX1HY8B1vemd5vJw5kzZQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_clone: Fix child detection on sparc
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 30 Sept 2026 at 15:53, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Anders,
>
> > On Tue, 29 Sept 2026 at 16:22, Petr Vorel <pvorel@suse.cz> wrote:
>
> > > Hi Anders,
>
> > > > On sparc the clone syscall does not return 0 in the child. It returns
> > > > the parent pid, so the child thinks it is the parent.
>
> > > So, somebody still test sparc :). Before applying a workaround few questions.
>
> > > I suppose this is because we did not updated our syscalls numbers.
>
> > Yes, clone3 was missing...
>
> Thanks for info.
>
>
>
> > > I send a patch which regenerated syscall numbers to have clone3 on sparc (both
> > > 32 and 64 bit) v7.0:
>
> > > $ include/lapi/syscalls/generate_arch.sh ../linux
>
> > > Can you please verify it works with clone3()? It was added this year in v7.0 in
> > > 2153b2e8917b7 ("sparc: Add architecture support for clone3")
>
> > Yes, it works. I tested on sparc64 in QEMU with a v7.3-rc4 kernel and
> > a buildroot
> > rootfs with LTP 20260529 + your patch only. All 94 fs_bind tests pass.
>
> FYI there is v2 from Andrea, your testing is highly appreciated (although the
> might be some additional changes to script which generates it.
>
> https://patchwork.kernel.org/project/ltp/list/?series=1176684&state=*
>
> > > Do we care about the past?
>
> > That's a good question, I think we do, because of the LTS kernels...
> > We run the latest LTP on the LTS kernels...
>
> Yeah, it should be probably merged. I'm sorry that we did not make it to this
> LTP release (Cyril is tagging today). Could you please send v3, which address
> agent issues?

Yes I will rework the patch, send it out shortly.

Cheers,
Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
