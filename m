From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Mar 2020 18:50:10 +0100
Subject: [LTP] [PATCH v2 2/3] nfs: Detect disabled UDP
In-Reply-To: <20200311175011.12171-1-pvorel@suse.cz>
References: <20200311175011.12171-1-pvorel@suse.cz>
Message-ID: <20200311175011.12171-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

nfs-utils disabled serving NFS over UDP in version 2.2.1,
which produce TBROK:

nfs01 1 TBROK: 'mount -t nfs -o proto=udp,vers=3
10.0.0.2:/tmp/LTP_nfs01.3pixnljzEv/3/udp /tmp/LTP_nfs01.3pixnljzEv/3/0'
failed on '': 'mount.nfs: requested NFS version or transport protocol is
not supported'

Detect UDP enabled (parsing all configs) and return TCONF when disabled.
Also detect UDP enabled by default by default, when config has commented
default values.

NOTE: Debian based distros still use older version, once it upgrades, it
will might keep using current configuration files
(/etc/default/nfs-kernel-server, /etc/default/nfs-common), therefore
code might need to be adjusted.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1-v2:
* detect UDP also on IPv6 ("udp6")
* use Simplified regexp

 testcases/network/nfs/nfs_stress/nfs_lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index f233976c7..3d447783d 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -46,6 +46,15 @@ get_socket_type()
 	done
 }
 
+nfs_server_udp_enabled()
+{
+	local config f
+
+	tst_rhost_run -c "[ -f /etc/nfs.conf ]" || return 0
+	config=$(tst_rhost_run -c 'for f in $(grep ^include.*= '/etc/nfs.conf' | cut -d = -f2); do [ -f $f ] && printf "$f "; done')
+	tst_rhost_run -c "grep -q '^[# ]*udp *= *y' /etc/nfs.conf $config"
+}
+
 nfs_setup_server()
 {
 	local export_cmd="exportfs -i -o fsid=$$,no_root_squash,rw *:$remote_dir"
@@ -98,6 +107,10 @@ nfs_setup()
 		type=$(get_socket_type $n)
 		tst_res TINFO "setup NFSv$i, socket type $type"
 
+		if [ "$type" = "udp" -o "$type" = "udp6" ] && ! nfs_server_udp_enabled; then
+			tst_brk TCONF "UDP support disabled on NFS server"
+		fi
+
 		local_dir="$TST_TMPDIR/$i/$n"
 		remote_dir="$TST_TMPDIR/$i/$type"
 		mkdir -p $local_dir
-- 
2.25.1

