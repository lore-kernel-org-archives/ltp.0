Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F72FC55838
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786002456; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=gWiDlLnSV2qzdc/5MXTn0tD/uUwPOJq32MFKYPnWHas=;
 b=cjZgDO6K4xK89nFYqdlvgM/0KGrfLDu/wS8BiTpy/9K4SdumysFEdsGF2q+Bvhy2t7C30
 uh+uUgOorCdPJEjMpUwtwdZKn7mvl1sK9sD9cwOfPAH7KLLXYUejUshJB8Qt/96u5ib+4mU
 Mp1DYG3ysO0UNvYyvM6+5Cc7+6kUD7k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 504903E27FC
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 09:47:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31393C73A9
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:47:16 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D088E1A004A3
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:47:15 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso27582095e9.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786002435; x=1786607235; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GoXp31yrNRk1G9Vjo/+pyfU++uMzDOct6xroZbuqhkk=;
 b=ealQLWHiG+kIvAtqsZDCKmtSqaZnfv2ERQmi/6WIfV9OkMIU/IHv05hb56gg1NxyV/
 Uv7NzobhnNpi7fm99fFn8X/T0NcUStedy2pk2lsdiT5KvSyQblf5LC24G/jy2JwwLdRx
 Pcphsh7c8Rwlruw+XAvH/XSIQycHbVXT5ysfjkkZUyTFPtTBCQvfS/RXEZolsZsn4OLq
 rLV4BRVlNRcRysjy/3aHXzh/v2Y8eY63rdMOLHvgGQWdUZ6hrtSQpJHXMOgUpzGt/1H6
 f1mj3ua4P23nvzusHCJuWDkl9Rv/J3zhUykWwQIaSB/BqKSmYQmlBHtDDHWzTIFwwTwF
 m57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786002435; x=1786607235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GoXp31yrNRk1G9Vjo/+pyfU++uMzDOct6xroZbuqhkk=;
 b=p5GrnEuYYDZZQHs0i/Cao3BXCgyb5ZFd/81sf7S3KxXd5VPLl0RyxA4URY8e3zIv8c
 XYovp/ei8YoCBROl8GZcGM6/bznhFBljirmPYsZR3efgABR48QhtxNjcSMmkBX97tytA
 O8E8Vj2hDWywTffvbLDVUky9I8KJkwyX5sTeto6me050wnYumXtEQZZCVKPO0Jmn8DIm
 dmvsVrAMPh7iUmErC2206r2ZWrXuXUPDpOucqi2Gk4y69kNdWtBSTfr+0saKEW5717DW
 HzRphPQP518sIY19047kwCSeHyLKQWMrttB5CR2+lI86HYEPRR2gMH0I97zdG9ZEQawZ
 3tyg==
X-Gm-Message-State: AOJu0YzhDhs039aO+rIAkg7qWlHQ7kFJzDk06T5znIZSYNLFgKdUDfTd
 iXM44g+++vKMGgVVjRI5AEezMoG+23ZB/ATfF335mE4COPJSOWcZ/4BSL2EbYVZHE2i7z67rDGc
 tGds3PfY=
X-Gm-Gg: AR+sD13uUaOG/JjbdMhxWNXjFGDNcWfpBjHjPw3ViY5XhtXv7Vmk5EJZc53vGH0mG9c
 ZwwHYRCMq4TQekNsgCiXZOhhtYDYOJDgdCuLYtf/njnVq1DVr6JavHRGy3zwDOYk4mZxArgAa3C
 frx+XYvl+Ic+44qk8yeOccWitXugAj/2EXDpoBJ6jOfSLc5B5a2jFS74ZBzB67N3S4FAhFUMWen
 8/7QeO+YWKrM5B0h5gPipEFxm/R6PKFAMHta38bAWaCdsd9PA+dOgjq9lUB8r/l166dD3ns0XHb
 GdkAYobUifBlERbPpjA1DchzsXQjgoi9+aaJYIzXjRcdWvwROLwErE3yHq/qc5iLxcp5D0jX4Bs
 AwL1kOzzEdjCdPCUKuV/UyH0cF0IznLZ+xIaPcLVtAZ70AgdYYAjBIn+9IZ63DrwcTRFQGL9JPy
 NagM5toglqjJALRCp9mE9+xRHi1aTj4Z9KP96vXJt7E1+UkSQ=
X-Received: by 2002:a05:600c:468e:b0:495:4a22:d684 with SMTP id
 5b1f17b1804b1-4994e7cc8f1mr152938955e9.10.1786002435058; 
 Thu, 06 Aug 2026 00:47:15 -0700 (PDT)
Received: from localhost ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499542851d6sm46262165e9.12.2026.08.06.00.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 00:47:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  6 Aug 2026 09:47:12 +0200
Message-ID: <20260806074713.158271-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nfs_lib: Skip NFS versions disabled on server
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
 testcases/network/nfs/nfs_stress/nfs_lib.sh | 56 ++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 8bff3f23ae12..4065b000467e 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -55,19 +55,24 @@ TST_NEEDS_DRIVERS="nfsd"
 # debugging whether test failures are related to veth/netns).
 LTP_NFS_NETNS_USE_LO=${LTP_NFS_NETNS_USE_LO:-}
 
-get_socket_type()
+get_socket_type_raw()
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
+	echo "$(get_socket_type_raw "$1")${TST_IPV6}"
+}
+
 # directory mounted by NFS client
 get_local_dir()
 {
@@ -109,6 +114,51 @@ nfs_server_udp_enabled()
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
+	local v type
+	local n=0
+	local new_version=
+	local new_socket_type=
+
+	for v in $VERSION; do
+		type=$(get_socket_type_raw $n)
+
+		if nfs_server_vers_enabled "$v"; then
+			new_version="$new_version $v"
+			new_socket_type="$new_socket_type $type"
+		else
+			tst_res TINFO "NFSv$v disabled on server, skipping"
+		fi
+
+		n=$(( n + 1 ))
+	done
+
+	[ -z "$new_version" ] && \
+		tst_brk TCONF "none of the requested NFS versions ($VERSION) are enabled on server"
+
+	VERSION="${new_version# }"
+	SOCKET_TYPE="${new_socket_type# }"
+}
+
 nfs_setup_server()
 {
 	local remote_dir="$1"
@@ -198,6 +248,8 @@ nfs_setup()
 
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
