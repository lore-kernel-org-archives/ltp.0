Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EF4C5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786440072; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=6t8o1tIcKGQIIqgsqLqjK1iAoq6Ch8/JhGqdI0oXCHM=;
 b=WSu39SdY/8OCtML6Q5HqO2tsK8DrK3Pmj7bdOTC4xXAzKtSyeDpZAN7H0SugIkU4zLPbL
 x8ArXMn79DEJtYi+sWFWfdfAqDFFk2Zw2BHs9pnP5+w17CZbz0HueKn5qkLq7sYNj2TyAtb
 2qCrAGu/uWR/ICGZIdVA8QKvHZaD5HQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DFF63D0EE9
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 11:21:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90AB43D06FC
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 11:20:53 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB58B200079
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 11:20:52 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so26973365e9.2
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 02:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786440052; x=1787044852; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=axWTklZFLvmPy/Dwsb8SqUQuKEaHic8aWmnN9Vjf7HY=;
 b=fIqEAl3D40R23vPBjs2ztuXO4ljdjph3ho9MYJiIcNd0QXr7io/ILnXicgoiRLo1pY
 7v8ZncNThxs/sgbkoBMmCHWOvzaWmcVoCyQcT4Cqd5C2nLDInilFL5Nz9aG1FkK59HK8
 n2JChJawlQHXyi1XrBzs+QYb/X2qUE+sNydzlgHsKv+FSJX5CTgW+aZjQRaMikTcrhr7
 8XWcnabjnWtqZtFOaFM/+rl7ieqPWiy7YyvT0pRrGorJ/7GH35I6p/0Z4dTB6rPTuflg
 gw5ffu4zsUwTCo7iMFhEh2eXzbGrqf6AYjJ17t0545BnV8b+Mf6u1cuBY1XLPD2pOApr
 iMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786440052; x=1787044852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=axWTklZFLvmPy/Dwsb8SqUQuKEaHic8aWmnN9Vjf7HY=;
 b=n5DBOn80slhMyjReX6sauV9TU0XBiVa8InwO+uoQGTPOi6Z389CaYgaa/Yh1YejK1n
 C0shiE0OtT9XY910WkZZZKOITQEoJqxfxWAvhK/J7378oiE171HpA6yLxx6FboIAEBXk
 5g6fYFePBD6BINUoyKwM2YD4Pv6BjAx4E5pYUhaVKubBL5eO7W0NfYr4vS++hdQPfsPa
 yCsgROEbvz4WZd7eCc5OQhevyizlFY1gStHh+VnNqasIoxih/TeRGMwcIQe0xoqM91wb
 dJqKV8P0U1usyFFVI1z1zQaDOrp+nAj4EaFKRX/F29FIhMceZaThfE8QrC6YBFFUDwfz
 oJmw==
X-Gm-Message-State: AOJu0YxnF5ZbjHwll5rA7/mszhIhlnBD8S/wb4ZA/3f7P99KcSvgg5Nf
 Ui87pYA4DuZRgN2Sk3iGGQ/C/4LEABCSOJfdEyh3MCpYB/djkeBvmbVSPfOTTzH5HPIMqLVp/1Q
 z30ITTSs=
X-Gm-Gg: AR+sD12Lr3+rCrB5kiy6w+69z1k7OQ7hrDkNACY4/aO7+bNRyCNzSFFulGPN+cbJIXL
 cQGopBwS+UZCE7QsKvoywwnfojq3K7ut7azJ8I0La+un8vYl/Vr5nJQjjAHeOUOebVJyORxWJv7
 vupEadejsXLgcuCulL+Xgllo8IYlgw4n504nrqXAiRA62ue6w274mNEYMM9fUcn5OsumltEEEqp
 L9BY5k7v9uXH+0UIsErNus09ulE3UtIc3CVlIRXRQS7L2DxBLVrvE4/LRWhBEJGWmfbeFE8uVq0
 8IsUGDkNyJJ8SFGgKfpKyh07Xc2XJj/Ngs7vNgDIXOuUFXdv76n19mEQQD4CbaPCkjQlc+pxg2U
 wqeoi4KSwW0gF0tl1IXggEOhS1N9yxfjkWRfuPXnGSoACJG/QofvOtygiErgdD05NR/z4jUkcc0
 hQn95H9pBBYeUDV8SLN4DP3PbkQhX0YQvOnneP3ocBUvYmu6xCV00wg+taUA==
X-Received: by 2002:a05:600c:3b05:b0:499:520c:62a7 with SMTP id
 5b1f17b1804b1-49978436f3cmr31178625e9.5.1786440052035; 
 Tue, 11 Aug 2026 02:20:52 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788fd908sm30091565e9.13.2026.08.11.02.20.51
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 02:20:51 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 11 Aug 2026 11:20:48 +0200
Message-ID: <20260811092050.29784-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810103134.GA918586@pevik>
References: <20260810103134.GA918586@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] nfs_lib: Skip NFS versions disabled on server
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

nfs06.sh mount several NFS versions in a single run
(e.g. "3,4.0,4.1,4.2"). If the server has disabled one of
the requested versions (reported via /proc/fs/nfsd/versions),
the whole test currently aborts with TBROK on the failed mount
instead of continuing with the versions that are supported.

nfs06 1 TINFO: setup NFSv4.0, socket type tcp
nfs06 1 TINFO: Mounting /var/tmp/LTP_nfs06.GHDqCwPYES/4.0/1
nfs06 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4.0 10.0.0.2:/var/tmp/LTP_nfs06.GHDqCwPYES/mntpoint/4.0/tcp /var/tmp/LTP_nfs06.GHDqCwPYES/4.0/1
mount.nfs: mount(2): Invalid argument
mount.nfs: an incorrect mount option was specified for /var/tmp/LTP_nfs06.GHDqCwPYES/4.0/1
mount.nfs: timeout set for Wed Aug  5 08:06:38 2026
mount.nfs: trying text-based options 'proto=tcp,vers=4.0,addr=10.0.0.2,clientaddr=10.0.0.1'
nfs06 1 TBROK: mount command failed

Add nfs_server_vers_enabled() to check /proc/fs/nfsd/versions on the
server, and nfs_filter_versions() to drop disabled versions from
$VERSION (keeping $SOCKET_TYPE aligned by position) before mounting.
If none of the requested versions are enabled, TCONF as before.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 54 ++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 8bff3f23ae12..e86847151ee9 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -55,19 +55,24 @@ TST_NEEDS_DRIVERS="nfsd"
 # debugging whether test failures are related to veth/netns).
 LTP_NFS_NETNS_USE_LO=${LTP_NFS_NETNS_USE_LO:-}
 
-get_socket_type()
+get_socket_type_bare()
 {
 	local t
 	local k=0
 	for t in $SOCKET_TYPE; do
 		if [ "$k" -eq "$1" ]; then
-			echo "${t}${TST_IPV6}"
+			echo "$t"
 			return
 		fi
 		k=$(( k + 1 ))
 	done
 }
 
+get_socket_type()
+{
+	echo "$(get_socket_type_bare "$1")${TST_IPV6}"
+}
+
 # directory mounted by NFS client
 get_local_dir()
 {
@@ -109,6 +114,49 @@ nfs_server_udp_enabled()
 	tst_rhost_run -c "grep -q \"^[# ]*udp *= *y\" /etc/nfs.conf $config"
 }
 
+# nfs_server_vers_enabled VERS
+# Only returns false (1) when the server explicitly lists "-VERS" in
+# /proc/fs/nfsd/versions. If that file is unavailable or doesn't mention
+# VERS at all, defaults to true so the mount is still attempted.
+nfs_server_vers_enabled()
+{
+	local vers="$1"
+	local versions=" $(tst_rhost_run -c 'cat /proc/fs/nfsd/versions 2>/dev/null') "
+
+	case "$versions" in
+	*" -$vers "*) return 1;;
+	esac
+
+	return 0
+}
+
+# Drops NFS versions the server explicitly disabled from $VERSION, keeping
+# $SOCKET_TYPE entries aligned by position with what remains.
+nfs_filter_versions()
+{
+	local v type new_version new_socket_type
+	local n=0
+
+	for v in $VERSION; do
+		type=$(get_socket_type_bare $n)
+
+		if nfs_server_vers_enabled "$v"; then
+			[ "$new_version" ] && new_version="$new_version $v" || new_version="$v"
+			[ "$new_socket_type" ] && new_socket_type="$new_socket_type $type" || new_socket_type="$type"
+		else
+			tst_res TCONF "NFSv$v disabled on server, skipping"
+		fi
+
+		n=$(( n + 1 ))
+	done
+
+	[ "$new_version" ] || \
+		tst_brk TCONF "none of the requested NFS versions ($VERSION) are enabled on server"
+
+	VERSION="$new_version"
+	SOCKET_TYPE="$new_socket_type"
+}
+
 nfs_setup_server()
 {
 	local remote_dir="$1"
@@ -198,6 +246,8 @@ nfs_setup()
 
 	tst_res TINFO "$(mount.nfs -V)"
 
+	nfs_filter_versions
+
 	for i in $VERSION; do
 		type=$(get_socket_type $n)
 		tst_res TINFO "setup NFSv$i, socket type $type"
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
