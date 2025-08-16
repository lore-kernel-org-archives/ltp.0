Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE34CA0EE4
	for <ltp@archiver.kernel.org>; Sat, 16 Aug 2025 02:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755310728; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Eig0hU1GegKsB41VYZ4CS19vO8DYX981FsCXDG0Yj4I=;
 b=RGzXF8yYwcCVKaIM8JH9FImiI9tycDRyhQ/fGEt+L2n8iFstO7HBzlgOkzpC/Bzwb96iA
 wQ7GI6KjAJP2+yQBhFfq6McAPmpuDHkvq9XsZ6NZm3kjyHfFUNlFKtLcuTSoB+XIxMJ/iuW
 90853qdevp+JzFNk2UNFHmhXXDDiNy4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FABE3CC2FE
	for <ltp@archiver.kernel.org>; Sat, 16 Aug 2025 04:18:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 742F83C6B54
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 04:18:26 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CEDEC140019F
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 04:18:24 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61868d83059so5939811a12.0
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 19:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755310704; x=1755915504; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bwsXpXXIuYQCL/FW90IpYibOz6Dfp82j0b3aRU8rwPo=;
 b=NzQ+peLBmQS1qYveixlaXiLZsVr4nb5bXwaAujD3BC4KxfJqLSFf55P5mpf0aNBQtL
 5u7FJuHcp9jm7aMSJvGb7YkoAjZRFVdMyd6cyvqTumFaM//VbMIsOQ8MsjIQe4ZK/ENX
 si5DfgEFknzH+uo+/jXwBsNkY13WIq/pW+Wq9j/M2H/PHopGbZ666GtO0jY7vqkRZD1a
 XQdN/sAoIfILObwFY9F/WPBYN0gDEGybA7mGHpjWisJG8OnUbDy4j0R8JADaIKC2eUYa
 jtt9tygKg17W7yuxjqNG7ODwWvjeBkZeLA7bhwt4BLHMdXzACNyak9Nm0HJsA6RstX+/
 6arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755310704; x=1755915504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwsXpXXIuYQCL/FW90IpYibOz6Dfp82j0b3aRU8rwPo=;
 b=DF37ZbFOFmA0gQK/NB8JL+eMbr9HWwinCYW5lDxr/2YuZ3BZXM7lH0ip9XPhM1YphY
 KTJQThVbO8YSOVHHvujw9lw+pYejYdcIFA5kuKKmjEirJqe9UY0gAPj1iV3ZZrG0Gjkt
 gQC0aTwxYP1SgOMc38t7s6gzSaB3ocshSKPhcQwcW0p0qHT27nscxWZXbgZr2t3KQ7PG
 hAboglyMUy0kUg3sivbxjIC4dzEPO/Hhbd8ALdHdM7/YZvYpm7hd93FjLAp+e9w7uUjY
 DvNEu9TmTk1/gck9y2/iRnzUnrEJBaE6dA6u8gYvUCqcumcmCvbfTzNbBA2h4W85byKK
 pZEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTrOf6MloMtl9s6nFfzLHdsPKunjf6EEuOchwmzjIk4BFIrtT1NrMCAXCcNs5qB0gZ0+E=@lists.linux.it
X-Gm-Message-State: AOJu0YxH26LhyTERXd5xrFRy/1kVUuNVCFCuCFMoY+M6YPh2A4V7UzCt
 ui1cGgXAr0aMie4Dk6ARV8zJdzz2BNOgVxWE7ogfJlhkS44s1nVPARKGhYRRUO0GlA==
X-Gm-Gg: ASbGncvqgHzeTLIUJwF6qnKu+TYLCumOqhVzzUx4hZBVQPor8ekj1I5udUPFSAXwC9X
 J0o+u6UJ8PQKet9x0s0p+gYggln3Wj1dkQf4WD4PBfB9/kDz5J8Ak15hRGvb9blbNpzrpvRtwoU
 XC/g0fYvHfoth6d64+Su6gc4k+0QK0sPzutDpIMfA41P1NpKbHVRV87qytdTxUOl9k+hrZjA4Kl
 7M8fSZSClUWaR1qvSmbKqc0CECa7S1e3pYgoNQglJR6Up6jvvbE5Uf5DuV5GCumH8EiEyfsOJMQ
 PxJ3MUINDemZ7VIpWPSIll1ZPgAe0GygJHTpcXKK9vkwoHJTL3605XUu14MSzK9UxIO3Swskgz1
 YlLRG9kRGIAHwDzu5SJtINQ==
X-Google-Smtp-Source: AGHT+IHNk8PBKUNrSPx10ifAUYOJvFnn2Jc4DOTuWB3OZc7DjYdpAwzxQ0MKpk/V8JZvySJfquvRNQ==
X-Received: by 2002:a17:907:7f09:b0:ae3:5185:5416 with SMTP id
 a640c23a62f3a-afcdb1a2e5amr388545866b.13.1755310704049; 
 Fri, 15 Aug 2025 19:18:24 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afcdd01168csm262745266b.91.2025.08.15.19.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 19:18:23 -0700 (PDT)
Date: Sat, 16 Aug 2025 02:18:21 +0000
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <aJ_qbZDvDJwVoZGA@localhost>
References: <20250801090949.129941-1-dongml2@chinatelecom.cn>
 <202508110750.a66a4225-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202508110750.a66a4225-lkp@intel.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH net v2] net: ip: order the reuseport socket in
 __inet_hash
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
Cc: kuniyu@google.com, kraig@google.com, lkp@intel.com, netdev@vger.kernel.org,
 dsahern@kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 edumazet@google.com, horms@kernel.org, oe-lkp@lists.linux.dev, kuba@kernel.org,
 Menglong Dong <menglong8.dong@gmail.com>, pabeni@redhat.com,
 ncardwell@google.com, davem@davemloft.net, ltp@lists.linux.it,
 Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Aug 11, 2025 at 01:27:12PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__inet_hash" on:
> 
> commit: 859ca60b71ef223e210d3d003a225d9ca70879fd ("[PATCH net v2] net: ip: order the reuseport socket in __inet_hash")
> url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/net-ip-order-the-reuseport-socket-in-__inet_hash/20250801-171131
> base: https://git.kernel.org/cgit/linux/kernel/git/davem/net.git 01051012887329ea78eaca19b1d2eac4c9f601b5
> patch link: https://lore.kernel.org/all/20250801090949.129941-1-dongml2@chinatelecom.cn/
> patch subject: [PATCH net v2] net: ip: order the reuseport socket in __inet_hash
> 
> in testcase: ltp
> version: ltp-x86_64-6505f9e29-1_20250802
> with following parameters:
> 
> 	disk: 1HDD
> 	fs: ext4
> 	test: fs_perms_simple
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-12
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
> 
> 
> kern :err : [  128.186735] BUG: KASAN: slab-use-after-free in __inet_hash (net/ipv4/inet_hashtables.c:749 net/ipv4/inet_hashtables.c:800) 

This kasan error not related with LTP case, i guess it triggered by network
related process such as bind etc. I try to give following patch to fix
kasan error, correct me if any mistake, thanks.

From: Wei Gao <wegao@suse.com>
Date: Sat, 16 Aug 2025 09:32:56 +0800
Subject: [PATCH v1] net: Fix BUG:KASAN:slab-use-after-free_in__inet_hash

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508110750.a66a4225-lkp@intel.com
Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/linux/rculist_nulls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index da500f4ae142..5def9009c507 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -57,7 +57,7 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
  * @node: element of the list.
  */
 #define hlist_nulls_pprev_rcu(node) \
-       (*((struct hlist_nulls_node __rcu __force **)&(node)->pprev))
+       (*((struct hlist_nulls_node __rcu __force **)(node)->pprev))

 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
@@ -175,7 +175,7 @@ static inline void hlist_nulls_add_before_rcu(struct hlist_nulls_node *n,
 {
        WRITE_ONCE(n->pprev, next->pprev);
        n->next = next;
-       rcu_assign_pointer(hlist_nulls_pprev_rcu(n), n);
+       rcu_assign_pointer(hlist_nulls_pprev_rcu(next), n);
        WRITE_ONCE(next->pprev, &n->next);
 }

--
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
