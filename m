Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29073CA5FAD
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1790701320; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SLVO+K/FeCftfFmEGrb1TOdOHyOi6hCf4OSpPzhdszs=;
 b=ICDlRJky/BM/sWrj+u5/VaN9OOfuNy2R5UdWPkibWMfrJPwMLXBx0J06lN7XGKT4mXkQ6
 /BieQ6vtVxV5kYDGrgzsQw1CROozYYC+4oQH2DFHDrfi9JURrZY1OUHMdvhjh6GqS83sdXd
 MMkkx0ZAdkaWkrJwI/7YoGadw/Yp0A0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51A133E9F88
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 19:02:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A0BF53E2F17
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:01:39 +0200 (CEST)
Received: from mail-wr2-x0f.google.com (mail-wr2-x0f.google.com
 [IPv6:2a00:1450:4864:30::f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3EBD11000A52
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:01:39 +0200 (CEST)
Received: by mail-wr2-x0f.google.com with SMTP id
 ffacd0b85a97d-488811c9ebaso2179921f8f.2
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790701298; x=1791306098; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4JX2OhxZRTAx5W4yQ70yEuXB/ZmxfY7/c7Hb1OpWeKU=;
 b=XxALT2LuBMHHA6McHMLkKJRjyWRWvb1DBmcA4gU2VtDy3VBolg8Et5eTuFqXkIjPwy
 0VDW2TIe2QCprnS9sorMgR6Ovj5nFo4x9UU1zP0qOdRZ/4V06XKMQnXfxNM5dl7Cwb1h
 vtS4qJnFQL4kOYnKjhs2zEo9jrvBKekhfYWWd8wr42EEU1uyUhIVpACa8Yb4QLbrrajr
 NIa4EGnyNToPqwDbRUh3OJ1plRvpimQ2xZmun5O20i5qJUGBwJhT3B3vFkwoJpLp5nrf
 jNQaszmGHkLksgcLW5jaOYTmioeHHE4ojfZB6bFhAnEyQbKKh1oyTkNOwKMQAlL90ZRU
 tSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790701298; x=1791306098;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4JX2OhxZRTAx5W4yQ70yEuXB/ZmxfY7/c7Hb1OpWeKU=;
 b=HLApi+nCBYEyqhufgpAzomjVuIGHO8WlTj8jE1jmmJ0dLqk6yv9zoAELZhj14cASMl
 L66in/r2fBIjai0NqKphsAl66hj7UXtzAS16tHlHgT4tSDqO4x/stdNH2TDTMPRFOdFS
 qGq9r7hKp77BVDzZm2qjfmZzsxTY2WvvvlnOZ02t5F3IW7vchcTWQ9/DkNBOlyWB7OVP
 An+ABXosf0CJ4Wpl+JYU3wSWOdomI0gnTCrxuBxXv+vFONC3DqxPuCycko/jBSFRPYVf
 Bb8rgaYgRe6ckhf/BH6z/Z1Q47/zfyEtVzp+crqVCnuYMjSA0u0l+ufyBNcn+z/31IhQ
 Jscw==
X-Gm-Message-State: AFuF++nekAmQBmd1NjU9JCUXEWXZc5YguT7LB5siNuGRdGD19ovaOf/+
 MM2ziXVOykYi4QwrFNcPEQgRpaV9eif48rfMctHfih+lsWujBQKJe5LYwfdL7te0Vo4=
X-Gm-Gg: AYBFou0TACAh0FbVpgc3+LBSNk9vERnIArm12ZbLPFMtg/BNQMc4H8k6jR6DnxmfvXi
 jLheY/Zk2kKeedKACA5u76UWFTWBnLVW7/wxlbXE8hznRxzDXS7kuHHvu8dqSN+8tnA5BIeVqIm
 5KsIqkM0BMYvNhAl+l9hvwAq+8QbdT/Z9BpQuVneBU2ZweAqddaQJnI39FcVYDa58r0yVTleaqp
 v0bmpRFki4k4jU3JEBo4muf5cNkZMdHJS/P6zcofQJIQ9itU4ZqEhICAsCVzEPGP+4f3G3Dba7Z
 PP6MhQ5IAVq+pIhU+HpA8hXHp5Mrf89RiMtkELgUc0yld44gPkkXVCbypBkiDUURgjmOIK5m9HK
 VRD2C7v7Aq8HL7gOtOrWnlJbMWEeO1C7f0CJqRgRriDjQJ4h6zgQMhi2UTcC8p8IXUhdY/BviTl
 n61C7ZKbiOhu60SQxWXus52BW4RPOVwbMEsQ/Ea9aCPZNPQHTlEdQmpucX7xaGw7SuzeJTZsy1k
 A==
X-Received: by 2002:a05:600c:8707:b0:4a0:89:6727 with SMTP id
 5b1f17b1804b1-4a0008968a1mr154081835e9.16.1790701298489; 
 Tue, 29 Sep 2026 10:01:38 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfa57d7sm88288255e9.10.2026.09.29.10.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:01:37 -0700 (PDT)
Date: Tue, 29 Sep 2026 19:01:36 +0200
To: Wei Gao <wegao@suse.com>
Message-ID: <arvu7cbAv0CmoxFZ@localhost.localdomain>
References: <20260929022340.524-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260929022340.524-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] memcontrol03: Bind to single CPU on systems
 with 64KB pagesize
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
From: =?utf-8?q?Michal_Koutn=C3=BD_via_ltp?= <ltp@lists.linux.it>
Reply-To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi.

On Tue, Sep 29, 2026 at 02:23:32AM +0000, Wei Gao <wegao@suse.com> wrote:
> On multi-CPU systems with 64KB page size (e.g. ppc64le), memcontrol03
> intermittently fails with over-reclaim of protected pagecache under
> trunk_B:
> 
>   memcontrol03.c:104: TINFO: Child 142113 in trunk_G: Allocating anon: 150994944
>   memcontrol03.c:121: TPASS: Child 142113 exited
>   memcontrol03.c:214: TPASS: Expect: (A/B memory.current=54394880) ~= 52428800
>   ...
>   memcontrol03.c:104: TINFO: Child 142114 in trunk_G: Allocating anon: 174063616
>   memcontrol03.c:116: TPASS: Child 142114 killed by OOM
>   memcontrol03.c:230: TFAIL: Expect: (A/B memory.current=43319296) ~= 52428800
> 
> In the kernel, per-CPU charge batching (MEMCG_CHARGE_BATCH = 64 pages)
> caches up to 64 * 64KB = 4MB per CPU in memcg_stock. On a multi-CPU
> system, allocating memory across CPUs allows cached stock charges to
> accumulate in ancestor trunk_A (up to 4MB * nr_cpus, e.g. 16MB on a
> 4-CPU machine). Because trunk_A has memory.max = 200M, this extra stock
> pressure forces the reclaimer to evict pagecache in trunk_B down to
> ~35-43MB instead of the expected ~50MB. Simply enlarging the tolerance
> rate further is not good idea.
> 
> Bind the test process to a single CPU in setup() when page size is
> >= 64KB. This confines stock batching to a single CPU, preventing
> multi-CPU stock inflation and ensuring reproducible reclaim behavior.

Should the goal be stability/repeatibility of the test.
What about pinning to the single CPU regardless of page size?

Thanks,
Michal

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
