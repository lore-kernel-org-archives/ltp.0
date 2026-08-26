Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F80C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 13:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787751526; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0+B/AxRGDPYEhXBb69pHekz8yP+kaCx3bToV1dFSe7k=;
 b=H8ZLeR4v6HJwS5bTcl3MxHENFJqbtAe5CZbuPFL+jKmYo4f/gqORgeZgejXSY/cR826Bv
 f06MIeaUXhZwG5tdT6MfbBq/eXCKPi952f60QK3rbLpwlVn6pfjckVFUgtm+eCQx3ihTRUB
 ZJseBpzs2kaWiSxjbHX2mImgeTd3Mls=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81AF53CD537
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 15:38:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FC063C2603
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 15:38:27 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 44FD7600A31
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 15:38:26 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so141650466b.1
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787751506; x=1788356306; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2+3tT+TwZeYCgEIQoFOW4itih31eJbrXH1v0t7afePI=;
 b=KY+r0jTkOXZnj7vNNeqxfkQ/utxe/ABxPJG13PTZ5tkwWQX8ZxtjOkMzeaHqVZVB1D
 OvEuA51nU18VMjv5yEhkywisRMACf715mRgWn/C4Esm7qbxWQQESV3QeO/zYY+J7opmK
 dlVOegY1hPedIPXKxwt6k8XE7W7iIJpll4bGcWRPo3+fce/CTH51lC6mCklstQKu+DVs
 8wAUDo0ucpBhsezg8nXEXoZi7BZ/4vpzw+ate4Q46F2esxF+z1StnWZI0B+1ErlLC7lY
 OvznDHAKYD6EH4zFjUZY8O86PNXk81ZBq5S46vTihBlnXfY7TF2dATqYC+aOJ5lVWLic
 gbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787751506; x=1788356306;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2+3tT+TwZeYCgEIQoFOW4itih31eJbrXH1v0t7afePI=;
 b=LxTktV//+/6EWXmMVKRurnf8zGI63QQhBn/VahumHBku5HTlokOvBciJBYNGuTK/FB
 5KoihtvjKqvwQL9i8tMfqWhdp3sWZnZduzmntS1BJuaf9k+wE/Mkqmq2fL9u4ufvBW58
 FnoqJdF+HtpKri4byX563/MtttblO2MdZ/t/m7IzSW2tk9k36aOmVSNS3NB82HWXX8VU
 v9lbdA4BJgyp6vgKxwZZC/lFgZjBh5mkggNEVO2p+0dSuWHk/DMNVrObn50iSqoM8r+J
 i4yq0CbCRFrWisRRpg8vvTlMwuOAc5KaIfXTI7NAzXm3PoRgDxrEBoNJjKevPP6FZMIg
 BIjA==
X-Gm-Message-State: AFuF++kysiKoGKzm0FkWiyCCZkzcULIPmk/OSqjh9csTsxAyBbRbyRad
 W3QAeR/mpVY/apmgdzKb9opct/EHl+/FM+b7PZz34RFqB1EOHgU9pyrF0x6XhVI8s1dwOOq3MZB
 oKjU=
X-Gm-Gg: AR+sD10M4KHGvSgTQVcWgWGp6ZCgH2Jk+0iq5k312q0X+x/pUQR5key8YCkyPcRWOMY
 HgHYTakMaBSDomx5bI6mrRhgNMLAWRMAcdvTpV3hZy7m25dhMvndmKTpJTOxsgIqbSVFUwGjF8x
 ls7eRbRSQTmww7+RUgYSyek4luL756UuKAhRQj2hG5KlSHVbr4UlXKMBiOuBk+UidiFomgr95ut
 bBtskBMhv56+8+WMr/DXmyhd3UyALmBnrIYM+aEaXayZ07mnX8KIriRDdsnG1CPf/b1cSmr+Gxi
 4HGzpCrTTx9i7EkjeCd1rzu/CsKwN8NFHqOse+ZY62o40KZz2xhUvB//WrnSFgODhAgvhJpX7H/
 VzhunN7JQ4dw2n4YIMYs5+/d7sk5BXnAx+qE8Hcz8iuDRsaHcyzIZTplDNsag8zHxJQiKGKhDmv
 r/NPmfwYRroLTYBwgM0/r9V3KvHxyWw9h0T1JIsqfHrv+Fr1Ig5h7i8f6dK+zb1k8/ZQf1qq5/h
 9Br/JKlAp5bRhZLMhX4Ns8FESbrEyrKnetqPoLY1fQ8HQ1wto/ogg5uUhumaHA=
X-Received: by 2002:a17:907:1c0f:b0:c25:23d:5295 with SMTP id
 a640c23a62f3a-c250c33579fmr745545566b.17.1787751505615; 
 Wed, 26 Aug 2026 06:38:25 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a73041asm546980866b.28.2026.08.26.06.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:38:25 -0700 (PDT)
Date: Wed, 26 Aug 2026 13:38:23 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ao7sDiRA4JguwRUl@autotest-wegao.qe.prg2.suse.org>
References: <ao6ygGRQfGejamJC@autotest-wegao.qe.prg2.suse.org>
 <6a8eb6b5.9c218f23.39bd08.c61c@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a8eb6b5.9c218f23.39bd08.c61c@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 26, 2026 at 09:49:40AM +0000, Andrea Cervesato wrote:
> > Thanks for the technical discussion, and we should find better solution
> > for avoid oom, but on cgroupv2(does not support disabling the OOM killer)
> > scenario, replacing sleep-based pacing with memory.reclaim is simply replacing 
> > one guess with another. In user-space, it is impossible to catch the exact 
> > second when memory hits memory.max. Furthermore, calling memory.reclaim proactively 
> > just guesses when to bypass memory.max altogether, which invalidates the 
> > core goal of the test.
> 
> Less LLM please :-)
I just use AI polish my sentences; the idea is mine :)
> 
> The OOM killer can be disabled in v2, but only for a specific group.
The following document shows: cgroupv2 has memory.oom.group, but
is not used to disable the OOM killer.

Documentation/admin-guide/cgroup-v2.rst
  memory.oom.group
        A read-write single value file which exists on non-root
        cgroups.  The default value is "0".

        Determines whether the cgroup should be treated as
        an indivisible workload by the OOM killer. If set,
        all tasks belonging to the cgroup or to its descendants
        (if the memory cgroup is not a leaf cgroup) are killed
        together or not at all. This can be used to avoid
        partial kills to guarantee workload integrity.  <<<<<<<
> 
> If you don't want to use memory.reclaim in v2 / disable OOM killer in v1,
> then we need to do things by hand as explained in the previous comment,
> for both v1 and v2.

I guess "need to do things by hand" includes totally removing the hard
sleep time; currently, I have no good solution (as I mentioned in previous
comments, memory.reclaim is not an option).

But I don't object to disabling the OOM solution, as cgroup-v2.rst also
mentioned, we can protect task with oom_score_adj set to -1000,
this is maybe another option for fix our openqa failed case.
Do you think this is the preferred one?
> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
