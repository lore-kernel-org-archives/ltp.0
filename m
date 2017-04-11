From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 12 Apr 2017 00:24:59 +0300
Subject: [LTP] [PATCH v2 1/2] dns-stress: fix test and use locally defined
	IP addresses
Message-ID: <1491945900-13627-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* define IP addresses, which are used in DNS query/answer,
  inside the test. It should be safe to use any network
  as we run 'named' on a non-standard port

* remove *_REV env variables from test_net.sh

* remove useless ping test inside setup()

* options section in conf provides directory path for 'named' that's
  why we don't need to specify full path for named.pid file

* remove 'client' A/AAAA records as they not used in the test

* remove TST_TMPDIR usage, use cwd

* add printing port number on which 'named' is listening

* sleep 100ms instead of 1sec when waiting for dns server

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

v2: fall back to hex in IPv6 host part, the previous version
    might be useful for debug only:
    node254.ltp-ns.org -- fd00:cafe::254 -- 10.23.0.254

 testcases/lib/test_net.sh               |    6 ----
 testcases/network/stress/dns/dns-stress |   50 +++++++++++++------------------
 2 files changed, 21 insertions(+), 35 deletions(-)
 mode change 100644 => 100755 testcases/network/stress/dns/dns-stress

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 5ce2049..928b991 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -512,12 +512,6 @@ export IPV6_NETWORK="${IPV6_NETWORK:-fd00:1:1:1}"
 export LHOST_IPV6_HOST="${LHOST_IPV6_HOST:-:2}"
 # Set remote host last octet, default is '1'
 export RHOST_IPV6_HOST="${RHOST_IPV6_HOST:-:1}"
-# Reverse network portion of the IPv6 address
-export IPV6_NET_REV="${IPV6_NET_REV:-1.0.0.0.1.0.0.0.1.0.0.0.0.0.d.f}"
-# Reverse host portion of the IPv6 address of the local host
-export LHOST_IPV6_REV="${LHOST_IPV6_REV:-2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0}"
-# Reverse host portion of the IPv6 address of the remote host
-export RHOST_IPV6_REV="${RHOST_IPV6_REV:-1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0}"
 
 # Networks that aren't reachable through the test links
 export IPV4_NET16_UNUSED="${IPV4_NET16_UNUSED:-10.23}"
diff --git a/testcases/network/stress/dns/dns-stress b/testcases/network/stress/dns/dns-stress
old mode 100644
new mode 100755
index 7a6cba5..06b4709
--- a/testcases/network/stress/dns/dns-stress
+++ b/testcases/network/stress/dns/dns-stress
@@ -1,6 +1,5 @@
 #!/bin/sh
-
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2015-2017 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2005
 #
 # This program is free software; you can redistribute it and/or
@@ -27,7 +26,7 @@ TST_CLEANUP="cleanup"
 
 # Minimum host ID in the zone file.
 # The ID is used as the host portion of the address
-MIN_ID=3
+MIN_ID=2
 # Maximum host ID in the zone file.
 MAX_ID=254
 # Domain name for testing
@@ -49,19 +48,16 @@ common_setup()
 
 	if [ "$TST_IPV6" ]; then
 		record="AAAA"
-		net="$IPV6_NETWORK"
-		net_rev="$IPV6_NET_REV"
+		net="fd00:cafe"
+		net_rev="0.0.0.0.0.0.0.0.e.f.a.c.0.0.d.f"
 	else
 		record="A"
-		net="$IPV4_NETWORK"
-		net_rev="$IPV4_NET_REV"
+		net="10.23.0"
+		net_rev="0.23.10"
 	fi
 
 	trap "tst_brkm TBROK 'test interrupted'" INT
 
-	check_icmpv${ipver}_connectivity $(tst_iface) $(tst_ipaddr rhost) || \
-		tst_brkm TBROK "Failed to ping to $(tst_ipaddr rhost)"
-
 	tst_tmpdir
 
 	ip6_opt=
@@ -73,7 +69,7 @@ common_setup()
 	cat << EOD > named.conf
 	options {
 		directory "$(pwd)";
-		pid-file "$(pwd)/named.pid";
+		pid-file "named.pid";
 		recursion no;
 		$ip6_opt
 	};
@@ -100,23 +96,22 @@ EOD
 	86400      ; dummy value
 )
 	IN	NS	dns.$DOMAIN.
-dns	IN	$record	$(tst_ipaddr)
-client	IN	$record	$(tst_ipaddr rhost)
 EOD
 }
 
 setup_4()
 {
-	id=$MIN_ID
+	printf "dns\tIN\tA\t$net.1\n" >> ltp-ns.zone
+	local id=$MIN_ID
 	while [ $id -le $MAX_ID ]; do
-		printf "node$id\tIN\tA\t$IPV4_NETWORK.$id\n" >> ltp-ns.zone
+		printf "node$id\tIN\tA\t$net.$id\n" >> ltp-ns.zone
 		id=$(($id + 1))
 	done
 
 	# reverse zone file
 	cat << EOD > ltp-ns.rev
 \$TTL 10
-@	IN	SOA dns.$DOMAIN. root.$DOMAIN. (
+@	IN	SOA $DOMAIN. root.$DOMAIN. (
 	2005092701 ; serial
 	3600       ; dummy value
 	900        ; dummy value
@@ -124,8 +119,6 @@ setup_4()
 	86400      ; dummy value
 )
         IN      NS      dns.$DOMAIN.
-$LHOST_IPV4_HOST	IN	PTR	dns.$DOMAIN.
-$RHOST_IPV4_HOST	IN	PTR	client.$DOMAIN.
 EOD
 
 	id=$MIN_ID
@@ -137,16 +130,17 @@ EOD
 
 setup_6()
 {
-	id=$MIN_ID
+	printf "dns\tIN\tAAAA\t$net::1\n" >> ltp-ns.zone
+	local id=$MIN_ID
 	while [ $id -le $MAX_ID ]; do
-		printf "node$id\tIN\tAAAA\t$IPV6_NETWORK::%x\n" $id >> ltp-ns.zone
+		printf "node$id\tIN\tAAAA\t$net::%x\n" $id >> ltp-ns.zone
 		id=$(($id + 1))
 	done
 
 	# reverse zone file
 	cat << EOD > ltp-ns.rev
 \$TTL 10
-@	IN	SOA dns.$DOMAIN. root.$DOMAIN. (
+@	IN	SOA $DOMAIN. root.$DOMAIN. (
 	2005092701 ; serial
 	3600       ; dummy value
 	900        ; dummy value
@@ -154,13 +148,11 @@ setup_6()
 	86400      ; dummy value
 )
         IN      NS      dns.$DOMAIN.
-$LHOST_IPV6_REV	IN	PTR	dns.$DOMAIN.
-$RHOST_IPV6_REV	IN	PTR	client.$DOMAIN.
 EOD
 
 	id=$MIN_ID
+	local rev_ip="0.0.0.0.0.0.0.0.0.0.0.0.0.0"
 	while [ $id -le $MAX_ID ]; do
-		local rev_ip="0.0.0.0.0.0.0.0.0.0.0.0.0.0"
 		printf "%x.%x.$rev_ip\tIN\tPTR\tnode$id.$DOMAIN.\n" \
 			$(($id % 16)) $(($id / 16)) >> ltp-ns.rev
 		id=$(($id + 1))
@@ -169,19 +161,19 @@ EOD
 
 start_named()
 {
-	chmod 770 $TST_TMPDIR
-	chmod 660 $TST_TMPDIR/*
+	chmod 770 .
+	chmod 660 ./*
 
-	port=$(tst_get_unused_port ipv${ipver} stream)
+	port=$(tst_get_unused_port ipv${ipver} dgram)
 
-	# Start named daemon
+	tst_resm TINFO "Start named daemon, port $port"
 	named -$ipver -c named.conf -p $port || \
 		tst_brkm TBROK "Failed to run named daemon"
 
 	# Make sure named.pid is created.
 	while true ; do
 		test -s named.pid && break
-		sleep 1
+		tst_sleep 100ms
 	done
 }
 
-- 
1.7.1

