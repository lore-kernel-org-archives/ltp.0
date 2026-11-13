Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76675606A323
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 04:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=rGrHJ7rk;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=dMgcRkLZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794543156; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=lZBrx5101oDRk74px3WWaOSjK7k8RIv4xczapkbZ6nw=;
 b=rGrHJ7rkiaSyrctzR4ZA5FRia5V1/Gb1Wm5BOcHDC6Kpa93E2/HQPsHUHXOGYY8w2/JBX
 1u5ph4nPWx5zW0L8GctEqhM4+4PHM63/am+Rw04SARh+nKmoScMfwdjEdY5Sv2EAqXgAKs4
 XMwmZYjWm789r2/x5EGQutpb7A04I+k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D7683EBC4D
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 05:12:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7D0E3EB501
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:43 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ABDE46005D4
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 05:11:42 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so308260f8f.0
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 20:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794543102; x=1795147902; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bMLCGc+cDh7zAe3aLju+NdJ7JWmgclMgsi7dciBffhA=;
 b=dMgcRkLZUb3D/yoh7uup2uDPWWYLgnIvjtlRBvlGF0hVKbZJM8+1IvaA1WA23sSOBj
 vFO9ACljXOU3lUa76EDiV41vzL8/J/QPII17K/L0XdKuVhUYX28QWM68EJUJlhAn5fE0
 hrbj6U8nxCdcn4QIuDFaShHiq1k6sHIMdCk3efy/5lMKYrKOqGosULq9JZhEbLFez8Fa
 cKohzLqmOK+8cCoxUVjDlP87OXblDixDPqcVKl1xvjLuIGNnIA9hdH8UqUKggU9G5jsF
 gE8eT8IpAFclT0Bkoyve7pnSKbLzmrj0hZi9QYDzmrZfVytYjaUqoxa13sjZUQ537WbY
 WAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794543102; x=1795147902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bMLCGc+cDh7zAe3aLju+NdJ7JWmgclMgsi7dciBffhA=;
 b=iAxKpBUJKZGlWPyNMmNVyLarjP62jYOCX50NTt/ozMU+xggYSXd818GJ/snMwphH4r
 O0EVhy+GWjKT8/giY6qDQ3qlljL6KOeAajQ1XvblXRDLjTs5oKd0NnXiquZpzgZQJgfE
 jFOPW6sAHmVO1NqH+FNyW2C72UglsskMm61ZR9ku1+55jwf6MMwGBnoVEy5c7oTd00tb
 cbK3pWnmsc44Z8j2/J5VlMDT2oZDd5Is/82m9XIbFipmWljWDOBIp/6TY+lJzrel8WFV
 jKzLcM40RoMpC37w6zNBLfMo8DpLLEh7mPZO50w4iVleL1nxdFA69+ltD0tUkoO0bdor
 k93Q==
X-Gm-Message-State: APuU4Z9KxSAvJe9ICd0yMnWK6no6MYoYjjGpjU5PWH26jBABaFck4S7Q
 KHU+Wj36eISH88pFhL+eihxsi8cPf3WYUK1tfm632oBoec+YOO1SmKA0XAVnZ/3c+APizqAoWkd
 UzOhaGw==
X-Gm-Gg: AYBFou28kn3Qls8ws72decJ23Jt42YU2IptJWc+00LbCJdPSCHGPRZP9Fcd+2pvxgqy
 4bBQeaElcb4ITFQQQebRD8B4+ICGhpyrBZDA7nBnV90NCOsv7ZDLxXrnwcFzuv0Du82PEu2QjCp
 DKtdV6How6eXPjLxrpdiXsvUbyiYhkp+N8iRyZf4RpmdLDsQy771G5yNrxHAGIJ6XloxnWqPfPT
 MHKlPy3NmPfs48+jSBc0CThMN8KyZKXaml772mqhYujimnHC3RIvOmqLo9taxDCZNUE7n9WwuAm
 cw+jHqmbrRsjdWqtmKQFBw4D3jEjeZjCMezOQrJic4CmEf3QBxlt9jqwd9LyvlvNHjOeC7aRBgm
 8JkdGdi/W3NyPfQ+n63ey13/hWx2NmLW/Co1FqlP/Mvla6VPf8+Tju2I7DmfC0bTTAnnncgD96J
 EL1PsFY7EVvefP6k8Gl4QqN7WbnVVkASNj4kcG1Ktgd6xst+xJyPFCqFnDvYEa/TeecARd0TQ+u
 4KGRQ566nIbZMZHrrW023IOBTkYoc19/BeZzcTIPOes32z3o7OAA3ZUzlj9mylwd23PPOKisY9e
 J9aWbqona6zBA8bTKOKluefnAC7oMawgSOjLRZApuuJsCPuS4tz888+OiKdNyuRJ/FhtkTmEGww
 4KGYe8ZZ0rnaD4ZzSReOv8QdWcbAU/DjEZw==
X-Received: by 2002:a5d:584e:0:b0:491:cd7:e96b with SMTP id
 ffacd0b85a97d-49b021bf3d3mr10265406f8f.15.1794543102056; 
 Thu, 12 Nov 2026 20:11:42 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-49c608d10b2sm3981292f8f.44.2026.11.12.20.11.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 20:11:41 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 13 Nov 2026 04:11:31 +0000
Message-ID: <20261113041136.17102-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113041136.17102-1-wegao@suse.com>
References: <20261113041136.17102-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/4] perf_event_open02: Use
 tst_bind_to_current_cpu() helper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Replace the local duplicate bind_to_current_cpu() implementation
with the tst_bind_to_current_cpu() library helper.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../perf_event_open/perf_event_open02.c       | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index e38c3f133..1e100982e 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -174,26 +174,6 @@ static int count_hardware_counters(void)
 }
 #endif /* __s390__ */
 
-static void bind_to_current_cpu(void)
-{
-#ifdef HAVE_SCHED_GETCPU
-	int cpu = sched_getcpu();
-	size_t mask_size;
-	cpu_set_t *mask;
-
-	if (cpu == -1)
-		tst_brk(TBROK | TERRNO, "sched_getcpu() failed");
-
-	mask = CPU_ALLOC(cpu + 1);
-	mask_size = CPU_ALLOC_SIZE(cpu + 1);
-	CPU_ZERO_S(mask_size, mask);
-	CPU_SET(cpu, mask);
-	if (sched_setaffinity(0, mask_size, mask) == -1)
-		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
-	CPU_FREE(mask);
-#endif
-}
-
 static void setup(void)
 {
 	int i;
@@ -214,7 +194,7 @@ static void setup(void)
 	if (access(PATH_KERN_PERF_EVENT_PARANOID, F_OK) == -1)
 		tst_brk(TCONF, "Kernel doesn't have perf_event support");
 
-	bind_to_current_cpu();
+	tst_bind_to_current_cpu();
 #ifdef __s390__
 	/*
 	 * On s390 the "time_enabled" and "time_running" values are always the
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
