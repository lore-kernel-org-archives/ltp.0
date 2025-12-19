Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0BEE66892
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 21:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766179110; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=oAC+WEXVTDvnqQsQuT8USOTiVmhZzyEQ/1U98IxsSfE=;
 b=VT8iRf+0cJ7CSkUVz0tAhOJBn70GX/+qdercErBRRM+e9r8dSRD8ULrMhEiDq0aov7vsB
 3bn8jwze1e4QodokdBAfeNQkZT+8S0OjIC2rfg3L72i+3b36uj1kE5PAeNa/bM11gOlwIur
 6X5E8oZAlVZJlu7tLRGLJ7Qui1iwY0g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 078033D053F
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 22:18:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 337183D0514
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 16:39:31 +0100 (CET)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E47C6601AD7
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 16:39:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=+xMUU4WuZi4JCAcK1X8nopc7petzGSZc6AMnJDC/d4c=; b=N0eCKqFK/Xaf
 /TDopwin5vQwzSC2hwvmxzlk2lQqwaec7qV5V7VJhZKVYAtw0KZgL8LdCz+hXuzGtzFIZgdYWaiuQ
 UtEzwpqe3T6UqcW6yAh/VpGvTZE5ssjEeBVYxGrh7GdI0BHy/oxFZEq/GRZTJyWR5qfinl8DS8nWW
 LpsWhIQXHrEg/zCaMY+99gGxCSdirEFLmS6iE2dMZ1jx5fPZ4auz1HkWyTJpUzyGrZfKpqN4eSNqx
 ivenZNtgYJzTzJL/uy9ZEk0XuUWPmvsgmMCyEbzCw6KElpDzpih58Herut/4Y60Sy4PmErthYiCvb
 FsNWyPDzxuEnGsiwl27tDg==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1vWcZe-004qdO-0H; Fri, 19 Dec 2025 16:39:22 +0100
To: ltp@lists.linux.it
Date: Fri, 19 Dec 2025 15:37:31 +0000
Message-ID: <20251219153923.45803-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 19 Dec 2025 22:18:06 +0100
Subject: [LTP] [PATCH] ssh-stress: disable resource penalties
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
From: Vasileios Almpanis via ltp <ltp@lists.linux.it>
Reply-To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Cc: joerg.vehlow@aox.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Our tests create a number of ssh sessions in the
background which are immediately killed. Some of
them haven't finished the authentication stage yet
and they close the connection incurring penalties from
the ssh daemon.

debug1: srclimit_penalise: active penalty for ipv4 10.0.0.1/32
already exists, 16 seconds remaining

Then when we try to reconnect to the daemon we are bounced
because of the active penalty which leads to a failed test.

ssh-stress 1 TINFO: Killing all ssh sessions
kex_exchange_identification: read: Connection reset by peer
Connection reset by fd00:1:1:1::2 port 58373
ssh-stress 1 TFAIL: SSH not reachable

From the sshd logs we can see

debug1: srclimit_penalise: active penalty for ipv4 10.0.0.1/32
already exists, 16 seconds remaining

This feature was added to OpenSSH 9.8 in the 2024 release in the
81c1099d2 commit. Lets disable penalties for the versions that
support them.

Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
---
 testcases/network/stress/ssh/ssh-stress.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
index c27c27a28..cb6659ed5 100755
--- a/testcases/network/stress/ssh/ssh-stress.sh
+++ b/testcases/network/stress/ssh/ssh-stress.sh
@@ -39,8 +39,12 @@ cleanup()
 
 setup()
 {
-	local port rc
+	local port rc version major minor
 
+	version=$(sshd -V 2>&1 | sed -nE 's/^.*OpenSSH_([0-9]+)\.([0-9]+).*$/\1 \2/p' | head -n1)
+	set -- $version
+	major=$1
+	minor=$2
 
 	port=$(tst_rhost_run -c "tst_get_unused_port ipv${TST_IPVER} stream")
 
@@ -60,6 +64,13 @@ HostKey $TST_TMPDIR/ssh_host_ecdsa_key
 HostKey $TST_TMPDIR/ssh_host_ed25519_key
 EOF
 
+	if ([ -n "$major" ] && [ -n "$minor" ]); then
+		if ([ "$major" -gt 9 ] || ([ "$major" -eq 9 ] && [ "$minor" -ge 8 ])); then
+			cat << EOF >> sshd_config
+PerSourcePenalties no
+EOF
+		fi
+	fi
 	ssh-keygen -q -N "" -t rsa -b 4096 -f $TST_TMPDIR/ssh_host_rsa_key
 	ssh-keygen -q -N "" -t ecdsa -f $TST_TMPDIR/ssh_host_ecdsa_key
 	ssh-keygen -q -N "" -t ed25519 -f $TST_TMPDIR/ssh_host_ed25519_key
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
