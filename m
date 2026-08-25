Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B97C61DBD
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 17:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787678067; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=J9b27+WfUCzecbJsueOza/d7OcUWcDugR013+Yqilt4=;
 b=Uc32G2VwDSlwdVczRFMD1gzrt4O+rkIhipBdLlWacxwfZFlPGQCL/7rCzW0sQiMeIf2jA
 t/zg6B9cwlFqo0U8t7RL9poNliuLwUC441F2tBr7XRy2VjPQUForolnVykjpRsUzekxKMk7
 q6z8bXjVzS2sU66nJf0VRWM9HnuZq7E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D348F3C850D
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 19:14:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E4483C210D
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:14:08 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A3E21A0037F
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:14:07 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so7596678a12.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787678047; x=1788282847; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P7YUmG036QIY5PSbEJqAWBbrHFHZvEXHOP4wcgYgvSA=;
 b=MXELFZfywek/IZ3tEELS+Y/BmXN9RIUiFDVktL/FVS9Cid47k2qDmbM0eidI+nsSlP
 JWK6+p506W2FmW70dW7movFww5dWG1fb5saV+q52YGb6HSSWaClWigiJyyeOWy+TZxkC
 ZS0YO0c8ekAcZZDl/GnTkfoT625GnAAQwfDDv4jGrXahcX564LmrST7bI8PcjVg9FDXf
 O08pp6z9QD9Wk2kiI7b31xBR8eYMLDnkBa+VLNZoQdLsJbaQ6ysdbaSSD+muKUt2C2Ls
 mvxli/61vLO60Cyi+57GJO218QYlYn/nYVeE9g43wBwWlze77NLtdpaxIPAuB+bsUnO0
 hZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787678047; x=1788282847;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P7YUmG036QIY5PSbEJqAWBbrHFHZvEXHOP4wcgYgvSA=;
 b=g/anfFNAPsiwlkN6n91hdQJ/+/sHZchShmtHdumx8+xAb7x2VBLB7a8o2EtoEYx3E9
 aMNq5JfvlOryfRkPLV/44FLBKx7HhUtbqKUT9gcuNYpoQY1xBYdLOL0ZLR6sElrJmjbj
 3kwj1rJzc4j4j8ntVC76JA+fBDbv/Pi4eqfdZROp+PhEB05rtbtNbKzBggsxiyUyLhpI
 39kaa7Vr0mEw3q4WbP9kQ2RSh04ewXWR148ePqKX9xkSwsXZtZJJTiOtWWbP8dve+C38
 hd9UKiEqSONDhVjZnN08bVIn9D3Rkff9mTIGuo20BbYyoCMeGiOXDdx0rnwQ3wkDs4nF
 J6rQ==
X-Gm-Message-State: AFuF++kjoFdrDalNCXsvQyyaWuTi/w+bHhR1D9STqIYzFS1eEgUUECs8
 HvTosI/KycAoVd+G3Hzxii7CBMlhsQ+/bUBVq0vw2JFNgBUHkjbogSjqZgdQjPN4ZT0JzAt78N8
 faZvyq/8=
X-Gm-Gg: AR+sD111UCm8v1cw83Xdw0OI1aiHo+gx16+cYweyo6o3CnYlVG0nLZgMshFLHDB5nSc
 i4LLdbcUmRMVNq1PO82FiV/VjHXY9IPUtYLu4tTpA6zekMMqC/otnmNNq30I0uVFz9r8gBDsay4
 UJhJbpI/IfNOLPRTqH8oeu9F/px4FVotObh6fXM5GEpAqnEJXOoOSONsZff5vlvVDtSsyzxTIap
 rwEZQreGDzydWQwlV4a41NxQNvtHsLiFo+p2YC6kTyAVqB7+v5qgUdsgaEZ2E4HMYuimbxeGHMt
 GYcTHJq/jRDPtHjm6Bk+Nke5w8rt9OrO8lLu5WsREYncNtcmiwc0Bh+zfMDslXTsRqLlI8w6KrM
 wYWbN6PN86krr9MJ0olcFxUjdn85FBuqhjp14dqR/3obE2ESAA1A32resg9N64ylskaIQPjbJCd
 lghVoHuD+u5BxMNI3W8rvhj8pn6fQenfm+SwpQqAlXD9gY5xgx7XV1KtaU
X-Received: by 2002:a17:906:fe08:b0:c21:34a3:4d9c with SMTP id
 a640c23a62f3a-c250c345beamr11011166b.21.1787678046827; 
 Tue, 25 Aug 2026 10:14:06 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5deaa786csm500661a12.20.2026.08.25.10.14.06
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:14:06 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 25 Aug 2026 19:14:01 +0200
Message-ID: <20260825171405.123011-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] uevent02: Make wait_for_uevents() order-independent
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

Commit 8e63c9e6179a ("net: Defer netdev KOBJ_ADD uevent until the
device is published")[0] in kernel v7.2 changed register_netdevice()
to emit a network interface's own "add" uevent only after the
interface is fully registered, instead of before its queue kobjects
are created. This flips the uevent order for tun device creation from:

    add(net), add(rx queue), add(tx queue)
to:
    add(rx queue), add(tx queue), add(net)

wait_for_uevents() matched events strictly in the order given in the
uevents array, so on kernels with the reordered uevents the "add(net)"
event only matches once the rx/tx queue events have already been
consumed from the socket, leaving wait_for_uevents() stuck waiting for
events that already went by, until uevent02 times out and fails.

Since the relative order of unrelated uevents is a kernel
implementation detail the test should not depend on, make
wait_for_uevents() track the still-unmatched events in a pending set
and match incoming uevents against any of them, regardless of
position.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8e63c9e6179a

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/kernel/uevents/uevent.h | 37 ++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/uevents/uevent.h b/testcases/kernel/uevents/uevent.h
index 1ad092d5ea39..b4e4fce2b2f5 100644
--- a/testcases/kernel/uevents/uevent.h
+++ b/testcases/kernel/uevents/uevent.h
@@ -117,15 +117,30 @@ static inline int open_uevent_netlink(void)
 	return fd;
 }
 
+#define UEVENT_MAX_PENDING 16
+
 /*
  * Reads events from uevent netlink socket until all expected events passed in
- * the uevent array are matched.
+ * the uevent array are matched. Events do not have to arrive in the order
+ * they are listed in the uevents array, since the kernel is free to reorder
+ * unrelated uevents, e.g. commit 8e63c9e6179a ("net: Defer netdev KOBJ_ADD
+ * uevent until the device is published") changed the order in which a
+ * network interface and its queues announce themselves.
  */
 static inline void wait_for_uevents(int fd, const struct uevent_desc *const uevents[])
 {
-	int i = 0;
+	const struct uevent_desc *pending[UEVENT_MAX_PENDING];
+	int i, cnt = 0, remaining;
+
+	while (uevents[cnt]) {
+		if (cnt >= UEVENT_MAX_PENDING)
+			tst_brk(TBROK, "Too many expected uevents, increase UEVENT_MAX_PENDING");
+		pending[cnt] = uevents[cnt];
+		cnt++;
+	}
+	remaining = cnt;
 
-	while (1) {
+	while (remaining) {
 		int len;
 		char buf[4096];
 
@@ -136,14 +151,20 @@ static inline void wait_for_uevents(int fd, const struct uevent_desc *const ueve
 
 		print_uevent(buf, len);
 
-		if (uevent_match(buf, len, uevents[i])) {
-			tst_res(TPASS, "Got expected UEVENT");
-			if (!uevents[++i]) {
-				close(fd);
-				return;
+		for (i = 0; i < cnt; i++) {
+			if (!pending[i])
+				continue;
+
+			if (uevent_match(buf, len, pending[i])) {
+				tst_res(TPASS, "Got expected UEVENT");
+				pending[i] = NULL;
+				remaining--;
+				break;
 			}
 		}
 	}
+
+	close(fd);
 }
 
 /*
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
