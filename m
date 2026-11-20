Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993E606A325
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qPBqXv3K
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95B403E9FB9
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 09:57:02 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D9193E9256
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 09:56:47 +0100 (CET)
Received: from mta0.migadu.com (out-63.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::3f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 192391A00362
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 09:56:44 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=YN8/y4gr5fyzdEobi9tPVJFl228jdVLg82DuXQgUHHE=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795165003; v=1; x=1795769803;
 b=qPBqXv3KlvJjbVDcDvArNY53X7PypzLcbx1gBJ9SI+kDKALNdqU5J6zUFTSo/cMAMBMDflBH
 AzZ5EP0zSyoVxW5p2UmfeZVb24GZBAQ74AXB1gJeUZaKbPthumEWL4JIlf1E5+2mC88Uy6wJo9I
 PQd5RzFP3lc37Wx5O5xcDGIw=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 51b19a1ea42a5eff;
 Fri, 20 Nov 2026 08:56:43 +0000
X-Mizu-Trace-ID: 51b19a1ea42a5eff
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 16:56:34 +0800
From: Li Wang <li.wang@linux.dev>
To: Yu Miao <yumiao@kylinos.cn>
Message-ID: <awALQmqJEzv_pCXv@linux.dev>
Mail-Followup-To: Yu Miao <yumiao@kylinos.cn>, ltp@lists.linux.it
References: <20261116013147.69993-1-yumiao@kylinos.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261116013147.69993-1-yumiao@kylinos.cn>
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_lib.sh: poll for expected values in
 check_mem_stat()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Reading memory.stat does not always return up-to-date values: the
> kernel only flushes the pending stats updates synchronously when they
> exceed a threshold (MEMCG_CHARGE_BATCH * num_online_cpus()), otherwise
> the updates are applied by the periodic async flusher, so the values
> can be stale for up to 2 seconds.
> 
> The tests only touch 65 pages (260KiB), which may generate fewer
> stat updates than the threshold on machines with multiple CPUs, so
> the checks right after the memory has been touched may read stale
> values and fail, e.g. on 7.3.0 with 4 CPUs:
> 
>     memcg_stat_rss 1 TFAIL: rss is 0, 266240 expected
> 
> Poll for the expected value with a 3s timeout instead, which follows
> the polling pattern already used by signal_memcg_process() in this
> file.

Patch merged, with some minor polishing:

--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -160,15 +160,17 @@ shmmax_cleanup()
 check_mem_stat()
 {
        local item_size
-       local cms_iter
+       local loops=30

-       for cms_iter in $(seq 30); do
+       while [ $loops -gt 0 ]; do
                if [ -e $1 ]; then
                        item_size=$(cat $1)
                else
                        item_size=$(grep -w $1 memory.stat | cut -d " " -f 2)
                fi

+               [ -z "$item_size" ] && break
+
                if [ "$3" ]; then
                        if [ $item_size -ge $2 ] && [ $item_size -le $3 ]; then
                                tst_res TPASS "$1 is ${2}-${3} as expected"
@@ -179,7 +181,8 @@ check_mem_stat()
                        return
                fi

-               tst_sleep 100ms
+               loops=$((loops - 1))
+               [ $loops -gt 0 ] && tst_sleep 100ms
        done

        if [ "$3" ]; then


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
