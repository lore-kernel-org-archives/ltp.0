Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B93E674B5
	for <ltp@archiver.kernel.org>; Mon, 22 Dec 2025 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766412841; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zsG7UyzWif2HNCshQkXZMIfbD9V6EKaKE4zMhRCzysI=;
 b=AaeBPV3w74yLYY2k+vTxaygTZqCHKwS5UAEdXe+FQYjNXUDea4QgpOKOOtopE8KoUvrgr
 P1+1Z3yL1xRq4kxBhcyXqxA1BIy1Xgvf1SD9hsDTOJhXb+m6HplxWqbvxP/DBU1xY1RzruL
 P9AqSGxl8SJ9RuINyYLZA6C99Cic5SU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E5243D0713
	for <ltp@archiver.kernel.org>; Mon, 22 Dec 2025 15:14:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CB543D066B
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 15:13:37 +0100 (CET)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B4057200925
 for <ltp@lists.linux.it>; Mon, 22 Dec 2025 15:13:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=OgKe4TRfpImQDEM2lnlFCHdIEMRNgoMn6lklpsZlZhk=; b=Yoo6zAWyEU+T
 PlEjkxLiNua4PwYh5xLK1fAoLaKyQWXQ7i9yY7N4GHM4ApvM6wO/40X74sNQsyOMkcxrJWbfGGzDE
 gfcizV1jvjKujeE5P+AZLTjw/fPQNj4tL4vgMJIfFgLUT4OsjT20NajTTqM7uoVfMh7095JKTO2kV
 1VZiYgSmvM4pDMxY/vh8dfFziXF0pn7VTIxY7r00D3VMOI4NOu1odybtht5H6l9W0jRF+t8hByBQr
 8ZrjltmJKl9dshFMNO9MOoBFSW3HoxHUDLUi/n/9A1GwssBm7cA4gSaZfkmYoilZrqQwJteIaf5tV
 euQx7TUdYPcJgBrMDstgVA==;
Received: from [130.117.225.5] (helo=dev010.aci.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <vasileios.almpanis@virtuozzo.com>)
 id 1vXgf6-005Eae-2y; Mon, 22 Dec 2025 15:13:24 +0100
To: ltp@lists.linux.it
Date: Mon, 22 Dec 2025 14:13:26 +0000
Message-ID: <20251222141331.121827-1-vasileios.almpanis@virtuozzo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219212717.GA15539@pevik>
References: <20251219212717.GA15539@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] ssh-stress: disable resource penalties
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
Changes in v2:
- Removed unnecessary parenthesis around if statements.
---
 testcases/network/stress/ssh/ssh-stress.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/testcases/network/stress/ssh/ssh-stress.sh b/testcases/network/stress/ssh/ssh-stress.sh
index c27c27a28..d5db24835 100755
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
 
+	if [ -n "$major" ] && [ -n "$minor" ]; then
+		if [ "$major" -gt 9 ] || [ "$major" -eq 9 ] && [ "$minor" -ge 8 ]; then
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
