Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFF3606A32A
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ROll5JIt;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=WF+iGcLM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794821842; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=ovm97wR57thUf5WGgawvfje8ek6PoxMuo7U5YLxsgtk=;
 b=ROll5JIt+U9srAq3abWBvankJ2C6S/Kg1CxvTSx92AT8cdIBFYpvipCOQjkjQCY5jCNh7
 2H6iCJjh3sGTcSKC9v//8QissrMyriyd9CZVwuIXYO9k+vpRlEGaXC97802nwSFzPkvKuR0
 ZMwDZvaBY/kc1FdABrkWq6R0XRmhOF8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0690E3E9407
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 10:37:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E42523CA4DA
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 10:37:01 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6AE232001D4
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 10:37:01 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so15214045e9.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 01:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794821821; x=1795426621; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UTxHt0heZc/LryT+b2ldrRWDKUc/snU60s0+bVPfyTs=;
 b=WF+iGcLM2GCQ9GM5dEWH+RT4w/W8yntX7J6ygL74f5AcVtWqzMiKjWC+GDhFUhbbwr
 fBe68G2QdsAHgq7pb0tBCx6hOe47rhNWfG+Pjtf2hY4ls7icAL5jFyoqFkh55oDnnlgy
 hjvxkrH8PxrgZRrEp3te38ahHf5XP6xg/a0FupPKO8lYyMFhhTXtky/12B87YUDAf5nv
 zxv/81wc0DkwT0/9tkHyNFd8ODVHCoUqjl+qnoXk//hRFiypzhXyIHkRg5oe9JzoCcQ5
 8eyOCIffGDFJBfll2FisV1bEMhHn8SeRw/WVOGA6H8XpZb0rReI1jSYtKOe2/SEVgl6S
 q1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794821821; x=1795426621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UTxHt0heZc/LryT+b2ldrRWDKUc/snU60s0+bVPfyTs=;
 b=ZrMGMV4GGTaR9/FrBs1x51xc3k+A0d0g8uoEXZEv9/TlgBxSdrkt6RHDe/2/BN0PCw
 7Yvgo0WW9JNS4nAvgSHCZP78qM+Q4ujZb00Ed8zESHaz/NiEZdBfAEFEP0A1k8QSSEVz
 pu84Du1m+YYzgTle7at3zIFrTfYljAt6864A604T8XZ7k2woDMuDI32wrBrL9gP6CX3K
 LrwSAzV3hNlINx0STcjCUuHDpTUrG0qAnlPG4FERlK9/zhqT0/1GAcBz+OSu0cZyIeGy
 /UoL07X8L0ILnAnUZczhkvqzIdIR1GhFGhZs6jb9UA5QSt27PPAmaVNMUSBghxO6nTEq
 kP/w==
X-Gm-Message-State: APuU4Z+j85i8vpgiJpXvgRj9N0erPWKCfg0diFTGRLnSfGbzhrlLzfkj
 oFNthy6GtGjAnkm6YT+XBTkjMDysdc/OgNPv4APloAwFRDDp5esk59hA48xbwHyuUsHZNAtxxSV
 Nq8Yc/xo=
X-Gm-Gg: AYBFou3iA7Gqt0utuTL+LFLYFKh7nJl6UeosYqhXxORKDd6QRV/+ItmMGTUAxh6Aqi+
 rH4xnEjSC4vFOeMipXQuJoQ2aim12idD1gc9nkZMzPMemDSzS5Cfidx/U5dm5yNjivSNzccZF34
 8/ur9osPzRTWlyrNr0XN3qVmlNbDW+VoMJnKS6JIMVt2VuWqkVOAQOoItXw0rRaDLi3t7uQneDo
 VFE7LbrsGN++7eO0KY9aneTx0YXg8bpqW+f3kK98qk/GGwSKczb4wxvpMMtSlCWbCXZQhkP37Uu
 yhpXVFS3Z0BhSaw3iB813YuPfFSmvvUxMR1UVpj+BU5Y8lbdkRQPm3rr4jL/wmvLd9D0kDtrh6u
 dTrsWk61L7eutE2FC8x2hUAopVcECGtps8l7WDYYWza65sW1TTo7D4MwZ/lrQWH3iwEOWC2XHed
 umSS85LIDX5cVFSlhZYAwCh4Ln1BVnJ/M5QcPrAtQ5zVWe2nZ4b9jqs/dvMAJ9LsSufTqzyiRQk
 kgGAPgf9BVl4Dz2rX1B+0KQhS13t2o5ypFFHUQtcyET7kAf/Hmbf/8xrYxqUllMNPrn7e0fRy0q
 9E3k+IqEkQvEEmFAZdJv+FlSuioD
X-Received: by 2002:a05:600c:46cb:b0:4bb:52d8:73ef with SMTP id
 5b1f17b1804b1-4bb55af12e1mr212395315e9.34.1794821820691; 
 Mon, 16 Nov 2026 01:37:00 -0800 (PST)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55acdccfsm287674415e9.8.2026.11.16.01.37.00
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 01:37:00 -0800 (PST)
To: ltp@lists.linux.it
Date: Mon, 16 Nov 2026 10:36:58 +0100
Message-ID: <20261116093659.828828-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] pids.sh: Wait for killed tasks to leave the cgroup
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

pids_task1 leaves an orphaned child in the cgroup, so "wait" in
stop_pids_tasks_path() can't wait for it, and kill -9 only queues the
signal. The rmdir that follows can fail with EBUSY (unchecked), leaving
the child cgroup behind and breaking the cgroup cleanup:

    rmdir: failed to remove '.../test-3200/child1': Device or resource busy
    tst_cgroup.c:1052: TBROK: unlinkat(..., 'test-3200', AT_REMOVEDIR): EBUSY

Wait for the cgroup to become empty at the end of
stop_pids_tasks_path() and in cleanup() before the test cgroup is removed.

Fixes: dd2b901a9 ("controllers: Update pids.sh to use newer cgroup lib")
Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/controllers/pids/pids.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index dd27b5616f0c..32434ab0dba0 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -32,11 +32,28 @@ OPTIONS
 EOF
 }
 
+wait_cgroup_empty()
+{
+	local delay=1000
+
+	while [ -n "$(cat "$1/$task_list" 2>/dev/null)" ]; do
+		if [ $delay -gt 4000000 ]; then
+			# tst_brk() only warns in cleanup(), so return after it
+			tst_brk TBROK "cgroup $1 is not empty"
+			return
+		fi
+		tst_sleep ${delay}us
+		delay=$((delay * 2))
+	done
+}
+
 cleanup()
 {
 	killall -9 pids_task2 >/dev/null 2>&1
 	killall -9 pids_task1 >/dev/null 2>&1
 
+	[ -n "$testpath" ] && wait_cgroup_empty "$testpath"
+
 	cgroup_cleanup
 }
 
@@ -83,6 +100,10 @@ stop_pids_tasks_path()
 		kill -9 $i 2>/dev/null
 		wait $i 2>/dev/null
 	done
+
+	# wait can't reap the orphaned pids_task1 children, so wait for them
+	# to leave the cgroup instead
+	wait_cgroup_empty "$path"
 }
 
 case1()
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
