Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F39F99344
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776932435; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=1Y4iNy6HMRVlaqcb4Yz7+DM+CEikuGbk5HTOukdbftA=;
 b=fw2hHwFmKLHhpy3Yu2yX7LZNx/1gu+DRaDbgVO3wBSQcc7hqWIxizaGWJicahDAumlgg3
 xAhMCF1OPL/h3KOK9sWp4lcnec+kmGgxasdyqgkQkHjAfQVvJ7foe9a/ULvAsmJljTAOtUt
 VOmsqC9DHK8Zz9jtFfGiVm0OikiA4CE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 344853E2D80
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:20:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1D5F3E18DC
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:20:11 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 706C01A0091B
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:20:10 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso6203746f8f.0
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776932409; x=1777537209; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8IyhkRP2GH/Q4mWr1xOz5R01an2p4E0XlYfmHinv4Bw=;
 b=cjK37uKBg/nlPBp0PPJ/8c8sTryGQL1sFo7KuuKPsJr0pMFRUwZPubWJWDEW7LW1y/
 6dCQcG96v2+uyKK/HVFng3Sg8lOx4zyOHsTwWHvQ4CHMnoswvKu7+zgUKVX2xUFdSkA/
 8bbcUGr9mC6ffLBoJfNLMGlWD04CvqmwDR2LJq2oUTQd/CyThZiYUDNc59Hw2fYZWjzS
 Yj6sYefWSzIzSFPC0YLh6qW1j3TRYocZkbZ9yItpaZfTwYoMZuh4AekhTwLEAOsvkVi0
 L13Q58GRwG1uwBe+pnODG43YDWKZsGmzYnNdBxpTYF+sbzW97hqRbqwxk2wO8ixLFUWh
 mG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776932409; x=1777537209;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IyhkRP2GH/Q4mWr1xOz5R01an2p4E0XlYfmHinv4Bw=;
 b=QxY4d3Ja22hhEcdrP1NoLfYE1FQoIhX3VffqK1U1G4Q4ibgbtDOpT3Ra0XA2wbV7t2
 gNpeVi7tA1mWjm1F2t+1LwS4to1N3du7ynqqNrRVAKZADPGFP9JJR09UHRqRcJCg340e
 vIrgliUxZ4b/Cy2l8OV+/UUnWpCFJKnsrpnjcjE6Lwv5uYWuJ+9iktJ06fuxYIaBUy0h
 tlHnUloZcPPoVdQ8QPaSt5VUfLoEftnn3wZ1JkjA5xWzNsLYgNZX9Y/YxDqi+OU4nYJ3
 YNE2UMQGXpc0ftsuSwSV/eCTCpop9eCMM9n5yp2SgvzB3PVmDr4CQRDX7cfG3FHIiLQx
 MHgw==
X-Gm-Message-State: AOJu0YyAlZWaQQGphfivZkhDIcEP06xurEreN39DvptsYXILRD+xQhQR
 naUB3kU96tkwcJ2flmixi0wS3o6vBZYqs5kB1SkgMaAEH8M1TZy2RmvqEoBi4M6f+Pc2E2znlDQ
 gDI4=
X-Gm-Gg: AeBDietjAlVAjhOQYW5slt1IJh/gh72D6WeUxh+rFFu4RgfkcwZnxj487t0nKH1i7qc
 IIcCVzjXqZ4/mmHGZ131KuObUDUiIKZq5f+rNwpIe8R8K9x+UdQM3HN3Lerr4jteTSx4heWCJFJ
 D/Tk74s5hWFBA7fH6vLr0A9rHIgbNsxHw51YEVjh3nq2f4d+XH/h5NlwVfoy71wkVlu5s3vqPmw
 heOpz2waJJkIJO/gwTILmegEZ5y5//yjcGWfbNAU7CpHOIXBMj7BDG6+RvsXxChz6utnilEnPYB
 8OzXYuHNT1OUZ4TOWk3CZ0rGX5VliYCVge9ZzNJtKDwu9DHaCM/FXEf0df7egTaTpRQAKRPzH+G
 IZtBpDTle3GqdiNrpdnpk3RLozAjOS85nK4v3lnA/I0++3rN3k2tE+OfmZ+lm5A3eJ2j/UfmT3W
 9/R8d4ZGC/w6RhSmirhsuhig==
X-Received: by 2002:a05:6000:40cb:b0:43e:aa43:243 with SMTP id
 ffacd0b85a97d-43fe3e24eaamr40568923f8f.43.1776932409407; 
 Thu, 23 Apr 2026 01:20:09 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43fe4cb1249sm48034582f8f.5.2026.04.23.01.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 01:20:08 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 08:20:01 +0000
Message-ID: <20260423082003.28493-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ns-tools: Restore ns-icmpv4_sender
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Commit 19c9b694c6b ("ns-tools: Remove unused tools") removed
ns-icmpv4_sender.c, assuming it was unused. However, it is still
required by broken_ip tests (e.g. broken_ip4-version, broken_ip4-ihl),
which were not removed.

Restore ns-icmpv4_sender.c and update Makefile, .gitignore and
00_Descriptions.txt accordingly.

Fixes: 19c9b694c6b ("ns-tools: Remove unused tools")
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/network/.gitignore                  |   1 +
 .../stress/ns-tools/00_Descriptions.txt       |   4 +
 testcases/network/stress/ns-tools/Makefile    |   2 +-
 .../stress/ns-tools/ns-icmpv4_sender.c        | 622 ++++++++++++++++++
 4 files changed, 628 insertions(+), 1 deletion(-)
 create mode 100644 testcases/network/stress/ns-tools/ns-icmpv4_sender.c

diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index 00b73161c..3ebb6e33c 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -26,6 +26,7 @@
 /sockets/ltpServer
 /sockets/vsock01
 /stress/ns-tools/ns-icmp_redirector
+/stress/ns-tools/ns-icmpv4_sender
 /stress/ns-tools/ns-icmpv6_sender
 /stress/ns-tools/ns-igmp_querier
 /stress/ns-tools/ns-mcast_join
diff --git a/testcases/network/stress/ns-tools/00_Descriptions.txt b/testcases/network/stress/ns-tools/00_Descriptions.txt
index 56a221b71..b0fb2188c 100644
--- a/testcases/network/stress/ns-tools/00_Descriptions.txt
+++ b/testcases/network/stress/ns-tools/00_Descriptions.txt
@@ -10,6 +10,10 @@ ns-icmp_redirector (binary)
 	gateway. When the utility receives the packet from the host
 	under test. This utility reply ICMP redirect message.
 
+ns-icmpv4_sender (binary)
+	ICMPv4 echo request sender.
+	This utility is also able to set illegal information in the IP header
+
 ns-icmpv6_sender (binary)
 	ICMPv6 message (Echo request / MLDv2 query) sender.
 	This utility is also able to set illegal information in the IP header
diff --git a/testcases/network/stress/ns-tools/Makefile b/testcases/network/stress/ns-tools/Makefile
index b20b11b04..6a1d27242 100644
--- a/testcases/network/stress/ns-tools/Makefile
+++ b/testcases/network/stress/ns-tools/Makefile
@@ -6,7 +6,7 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= create_file tst_net_stress.sh
+INSTALL_TARGETS		:= create_file tst_net_stress.sh ns-icmpv4_sender
 
 FILTER_OUT_MAKE_TARGETS	:= ns-common
 
diff --git a/testcases/network/stress/ns-tools/ns-icmpv4_sender.c b/testcases/network/stress/ns-tools/ns-icmpv4_sender.c
new file mode 100644
index 000000000..f51ad5f56
--- /dev/null
+++ b/testcases/network/stress/ns-tools/ns-icmpv4_sender.c
@@ -0,0 +1,622 @@
+/******************************************************************************/
+/*                                                                            */
+/*   Copyright (c) International Business Machines  Corp., 2006               */
+/*                                                                            */
+/*   This program is free software;  you can redistribute it and/or modify    */
+/*   it under the terms of the GNU General Public License as published by     */
+/*   the Free Software Foundation; either version 2 of the License, or        */
+/*   (at your option) any later version.                                      */
+/*                                                                            */
+/*   This program is distributed in the hope that it will be useful,          */
+/*   but WITHOUT ANY WARRANTY;  without even the implied warranty of          */
+/*   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                */
+/*   the GNU General Public License for more details.                         */
+/*                                                                            */
+/*   You should have received a copy of the GNU General Public License        */
+/*   along with this program;  if not, write to the Free Software             */
+/*   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA  */
+/*                                                                            */
+/******************************************************************************/
+
+/*
+ * File:
+ *	ns-icmpv4_sender.c
+ *
+ * Description:
+ *	This is ICMPv4 echo request sender.
+ *	This utility is also able to set illegal information in the IP header
+ *
+ * Author:
+ *	Mitsuru Chinen <mitch@jp.ibm.com>
+ *
+ * History:
+ *	Mar 5 2006 - Created (Mitsuru Chinen)
+ *---------------------------------------------------------------------------*/
+
+/*
+ * Header Files
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <netdb.h>
+#include <signal.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <net/ethernet.h>
+#include <net/if_arp.h>
+
+#include "ns-traffic.h"
+
+/*
+ * Structure Definitions
+ */
+struct icmpv4_fake {
+	struct ip4_datagram pkt;
+	char *src_ifname;
+	struct sockaddr_ll saddr_ll;
+	struct sockaddr_ll daddr_ll;
+	struct in_addr saddr;
+	struct in_addr daddr;
+	unsigned short int pkt_size;
+	unsigned short int data_size;
+	double timeout;
+
+	u_int16_t fake_flag;
+};
+
+/*
+ * Gloval variables
+ */
+char *program_name;		/* program name */
+struct sigaction handler;	/* Behavior for a signal */
+int catch_sighup;		/* When catch the SIGHUP, set to non-zero */
+
+/*
+ * Function: usage()
+ *
+ * Descripton:
+ *  Print the usage of this program. Then, terminate this program with
+ *  the specified exit value.
+ *
+ * Argument:
+ *  exit_value:	exit value
+ *
+ * Return value:
+ *  This function does not return.
+ */
+void usage(char *program_name, int exit_value)
+{
+	FILE *stream = stdout;	/* stream where the usage is output */
+
+	if (exit_value == EXIT_FAILURE)
+		stream = stderr;
+
+	fprintf(stream, "%s [OPTION]\n"
+		"\t-I if_name\tInterface name of the source host\n"
+		"\t-S ip_addr\tIPv4 address of the source host\n"
+		"\t-M mac_addr\tMAC address of the destination host\n"
+		"\t-D ip_addr\tIPv4 address of the destination host\n"
+		"\t-s packetsize\tnumber of data bytes (exclude header)\n"
+		"\t-t value\ttimeout [sec]\n"
+		"\t-d\t\tdisplay debug informations\n"
+		"\t-h\t\tdisplay this usage\n"
+		"\n"
+		"\t[options for fake]\n"
+		"\t  -c\tbreak checksum\n"
+		"\t  -f\tbreak fragment information\n"
+		"\t  -i\tbreak IPv4 destination address\n"
+		"\t  -l\tbreak header length\n"
+		"\t  -L\tbreak total length\n"
+		"\t  -p\tbreak protocol number\n"
+		"\t  -v\tbreak IP version\n", program_name);
+	exit(exit_value);
+}
+
+/*
+ * Function: set_signal_flag()
+ *
+ * Description:
+ *  This function sets global variables accordig to signal
+ *
+ * Argument:
+ *  type: type of signal
+ *
+ * Return value:
+ *  None
+ */
+void set_signal_flag(int type)
+{
+	if (debug)
+		fprintf(stderr, "Catch signal. type is %d\n", type);
+
+	switch (type) {
+	case SIGHUP:
+		catch_sighup = 1;
+		handler.sa_handler = SIG_IGN;
+		if (sigaction(type, &handler, NULL) < 0)
+			fatal_error("sigaction()");
+		break;
+
+	default:
+		fprintf(stderr, "Unexpected signal (%d) is caught\n", type);
+		exit(EXIT_FAILURE);
+	}
+}
+
+/*
+ * Function: parse_options()
+ *
+ * Description:
+ *  This function parse the options, then modify the fake icmp data
+ *
+ * Argument:
+ *   argc:  the number of argument
+ *   argv:  arguments
+ *  fake_p: pointer to data of fake icmp data to modify
+ *
+ * Return value:
+ *  None
+ */
+void parse_options(int argc, char *argv[], struct icmpv4_fake *fake_p)
+{
+	int optc;		/* option */
+	unsigned long opt_ul;	/* option value in unsigned long */
+	double opt_d;		/* option value in double */
+	struct in_addr opt_addr;	/* option value in struct in_addr */
+	struct sockaddr_ll opt_addr_ll;	/* option value in struct sockaddr_ll */
+	int is_specified_src_ifname = 0;
+	int is_specified_saddr = 0;
+	int is_specified_daddr_ll = 0;
+	int is_specified_daddr = 0;
+
+	while ((optc = getopt(argc, argv, "I:S:M:D:s:t:dhcfilLpv")) != EOF) {
+		switch (optc) {
+		case 'I':
+			fake_p->src_ifname = strdup(optarg);
+			if (fake_p->src_ifname == NULL)
+				fatal_error("strdup() failed.");
+			is_specified_src_ifname = 1;
+			break;
+
+		case 'S':
+			if (inet_pton(AF_INET, optarg, &opt_addr) <= 0) {
+				fprintf(stderr, "Source address is wrong\n");
+				usage(program_name, EXIT_FAILURE);
+			}
+			fake_p->saddr = opt_addr;
+			is_specified_saddr = 1;
+			break;
+
+		case 'M':
+			if (eth_pton(AF_INET, optarg, &opt_addr_ll)) {
+				fprintf(stderr,
+					"Destination MAC address is wrong\n");
+				usage(program_name, EXIT_FAILURE);
+			}
+			fake_p->daddr_ll = opt_addr_ll;
+			is_specified_daddr_ll = 1;
+			break;
+
+		case 'D':
+			if (inet_pton(AF_INET, optarg, &opt_addr) <= 0) {
+				fprintf(stderr,
+					"Destination address is wrong\n");
+				usage(program_name, EXIT_FAILURE);
+			}
+			fake_p->daddr = opt_addr;
+			is_specified_daddr = 1;
+			break;
+
+		case 's':
+			opt_ul = strtoul(optarg, NULL, 0);
+			if (opt_ul > ICMPV4_DATA_MAXSIZE) {
+				fprintf(stderr,
+					"Data size sholud be less than %d\n",
+					ICMPV4_DATA_MAXSIZE + 1);
+				usage(program_name, EXIT_FAILURE);
+			}
+			fake_p->data_size = opt_ul;
+			break;
+
+		case 't':
+			opt_d = strtod(optarg, NULL);
+			if (opt_d < 0.0) {
+				fprintf(stderr,
+					"Timeout should be positive value\n");
+				usage(program_name, EXIT_FAILURE);
+			}
+			fake_p->timeout = opt_d;
+			break;
+
+		case 'd':
+			debug = 1;
+			break;
+
+		case 'h':
+			usage(program_name, EXIT_SUCCESS);
+			break;
+
+			/* Options for fake */
+		case 'c':
+			fake_p->fake_flag |= FAKE_CHECK;
+			break;
+
+		case 'f':
+			fake_p->fake_flag |= FAKE_FRAGMENT;
+			break;
+
+		case 'i':
+			fake_p->fake_flag |= FAKE_DADDR;
+			break;
+
+		case 'l':
+			fake_p->fake_flag |= FAKE_IHL;
+			break;
+
+		case 'L':
+			fake_p->fake_flag |= FAKE_TOT_LEN;
+			break;
+
+		case 'p':
+			fake_p->fake_flag |= FAKE_PROTOCOL;
+			break;
+
+		case 'v':
+			fake_p->fake_flag |= FAKE_VERSION;
+			break;
+
+		default:
+			usage(program_name, EXIT_FAILURE);
+		}
+	}
+
+	if (!is_specified_src_ifname) {
+		fprintf(stderr,
+			"Interface name of the source host is not specified\n");
+		usage(program_name, EXIT_FAILURE);
+	}
+
+	if (!is_specified_saddr) {
+		fprintf(stderr, "Source IP address is not specified\n");
+		usage(program_name, EXIT_FAILURE);
+	}
+
+	if (!is_specified_daddr_ll) {
+		fprintf(stderr, "Destination MAC address is not specified\n");
+		usage(program_name, EXIT_FAILURE);
+	}
+
+	if (!is_specified_daddr) {
+		fprintf(stderr, "Destination IP address is not specified\n");
+		usage(program_name, EXIT_FAILURE);
+	}
+}
+
+/*
+ * Function: complete_eth_addrs()
+ *
+ * Description:
+ *  This function sets the source and destination ethernet address completely
+ *
+ * Argument:
+ *  fake_p: pointer to data of fake icmp structure
+ *
+ * Return value:
+ *  None
+ *
+ */
+void complete_eth_addrs(struct icmpv4_fake *fake_p)
+{
+	int sock_fd;		/* Socket for ioctl() */
+	struct ifreq ifinfo;	/* Interface information */
+
+	if ((sock_fd = socket(AF_PACKET, SOCK_DGRAM, 0)) < 0)
+		fatal_error("socket()");
+
+	/* Source */
+	fake_p->saddr_ll.sll_family = AF_PACKET;	/* Always AF_PACKET */
+	fake_p->saddr_ll.sll_protocol = htons(ETH_P_IP);	/* IPv4 */
+	fake_p->saddr_ll.sll_hatype = ARPHRD_ETHER;	/* Header type */
+	fake_p->saddr_ll.sll_pkttype = PACKET_HOST;	/* Packet type */
+	fake_p->saddr_ll.sll_halen = ETH_ALEN;	/* Length of address */
+
+	/* Get the MAC address of the interface at source host */
+	get_ifinfo(&ifinfo, sock_fd, fake_p->src_ifname, SIOCGIFHWADDR);
+	memcpy(fake_p->saddr_ll.sll_addr, ifinfo.ifr_hwaddr.sa_data, ETH_ALEN);
+
+	/* Get the interface index */
+	get_ifinfo(&ifinfo, sock_fd, fake_p->src_ifname, SIOCGIFINDEX);
+	fake_p->saddr_ll.sll_ifindex = ifinfo.ifr_ifindex;
+	fake_p->daddr_ll.sll_ifindex = ifinfo.ifr_ifindex;
+
+	close(sock_fd);
+}
+
+/*
+ * Function: create_clean_packet()
+ *
+ * Description:
+ *  This function creates icmpv4 packet without any fakes
+ *
+ * Argument:
+ *  fake_p: pointer to data of fake icmp structure
+ *
+ * Return value:
+ *  None
+ */
+void create_clean_packet(struct icmpv4_fake *fake_p)
+{
+	struct ip4_datagram pkt;	/* sending IPv4 packet */
+	struct icmp4_segment *icmp_p;	/* ICMPv4 part of sending packet */
+	unsigned short int pkt_size;
+
+	memset(&pkt, '\0', sizeof(struct ip4_datagram));
+	pkt_size = sizeof(struct iphdr)	/* IP header */
+	    +sizeof(struct icmphdr)	/* ICMP header */
+	    +fake_p->data_size;	/* ICMP payload */
+
+	icmp_p = (struct icmp4_segment *)&(pkt.payload);
+
+	/* IPv4 Header */
+	pkt.hdr.version = 4;
+	pkt.hdr.ihl = sizeof(struct iphdr) / 4;
+	pkt.hdr.tos = 0;
+	pkt.hdr.tot_len = htons(pkt_size);
+	pkt.hdr.id = htons(IPV4_PACKET_ID);
+	pkt.hdr.frag_off = htons(IPV4_DEFAULT_FLAG);
+	pkt.hdr.ttl = IPV4_DEFAULT_TTL;
+	pkt.hdr.protocol = IPPROTO_ICMP;
+	pkt.hdr.check = 0;	/* Calculate later */
+	pkt.hdr.saddr = fake_p->saddr.s_addr;
+	pkt.hdr.daddr = fake_p->daddr.s_addr;
+
+	/* ICMPv4 Header */
+	icmp_p->hdr.type = ICMP_ECHO;
+	icmp_p->hdr.code = 0;
+	icmp_p->hdr.checksum = 0;	/* Calculate later */
+	icmp_p->hdr.un.echo.id = htons(ICMP_ECHO_ID);
+	icmp_p->hdr.un.echo.sequence = htons(1);
+
+	/* ICMPv4 Payload */
+	fill_payload(icmp_p->data, fake_p->data_size);
+
+	/* Calcualte checksums */
+	pkt.hdr.check = calc_checksum((u_int16_t *) (&pkt.hdr),
+				      sizeof(struct iphdr));
+	icmp_p->hdr.checksum = calc_checksum((u_int16_t *) icmp_p,
+					     sizeof(struct icmphdr) +
+					     fake_p->data_size);
+
+	/* Store the clean packet data */
+	fake_p->pkt = pkt;
+	fake_p->pkt_size = pkt_size;
+}
+
+/*
+ * Function: thrust_fakes()
+ *
+ * Description:
+ *  This function thrust fake information to the icmp packet
+ *
+ * Argument:
+ *     pkt   : Payload of the Ethernet frame (Namely, IPv6 packet
+ *  fake_flag: Flag which represents what information would be faked
+ *
+ * Return value:
+ *  None
+ */
+void thrust_fakes(struct ip4_datagram *pkt, u_int16_t fake_flag)
+{
+	int rand_val;
+	size_t bitsize;
+	u_int32_t seed;
+
+	if (debug)
+		fprintf(stderr, "fake_flag = %2x\n", fake_flag);
+
+	if (fake_flag & FAKE_VERSION) {	/* version */
+		bitsize = 4;
+		seed = bit_change_seed(bitsize, 1);
+		pkt->hdr.version ^= seed;
+	}
+
+	if (fake_flag & FAKE_IHL) {	/* header length */
+		bitsize = 4;
+		seed = bit_change_seed(bitsize, 1);
+		pkt->hdr.ihl ^= seed;
+	}
+
+	if (fake_flag & FAKE_TOT_LEN) {	/* total length */
+		bitsize = sizeof(pkt->hdr.tot_len) * 8;
+		seed = bit_change_seed(bitsize, bitsize / 8);
+		pkt->hdr.tot_len ^= seed;
+	}
+
+	if (fake_flag & FAKE_FRAGMENT) {	/* fragment information */
+		/* Set reserved flag */
+		rand_val = rand() / ((RAND_MAX + 1U) / 16);
+		if (!rand_val) {
+			if (debug)
+				fprintf(stderr, "Up reserved bit\n");
+			pkt->hdr.frag_off |= htonl(0x80000000);
+		}
+
+		/* Set more fragments flag */
+		rand_val = rand() / ((RAND_MAX + 1U) / 3);
+		if (!rand_val) {
+			if (debug)
+				fprintf(stderr, "Set more fragments flag\n");
+			pkt->hdr.frag_off |= htons(0x2000);
+		}
+
+		/* Unset unfragmented flag */
+		rand_val = rand() / ((RAND_MAX + 1U) / 3);
+		if (!rand_val) {
+			if (debug)
+				fprintf(stderr, "Unset unfragmented flag\n");
+			pkt->hdr.frag_off &= htons(0xbfff);
+		}
+
+		/* Set fragment offset */
+		rand_val = rand() / ((RAND_MAX + 1U) / 3);
+		if (!rand_val) {
+			bitsize = 13;
+			seed = bit_change_seed(bitsize, 0);
+			if (debug)
+				fprintf(stderr, "Set fragment offset %02x\n",
+					seed);
+			pkt->hdr.frag_off |= htons(seed);
+		}
+	}
+
+	if (fake_flag & FAKE_PROTOCOL) {	/* protocol */
+		rand_val = rand() / ((RAND_MAX + 1U) / 5);
+		switch (rand_val) {
+		case 1:
+		case 2:
+			if (debug)
+				fprintf(stderr, "Bit reverse\n");
+			bitsize = sizeof(pkt->hdr.protocol) * 8;
+			seed = bit_change_seed(bitsize, 0);
+			pkt->hdr.protocol ^= seed;
+			break;
+
+		case 3:
+		case 4:
+			if (debug)
+				fprintf(stderr, "Unknown Protocol\n");
+			if (rand_val) {
+				int number;
+				int counter;
+				for (counter = 0; counter <= 0xff; counter++) {
+					number =
+					    rand() / ((RAND_MAX + 1U) / 0x100);
+					if (getprotobynumber(number) == NULL) {
+						pkt->hdr.protocol = number;
+						break;
+					}
+				}
+			}
+			break;
+
+		default:
+			if (debug)
+				fprintf(stderr, "Do nothing\n");
+			break;
+		}
+	}
+
+	if (fake_flag & FAKE_DADDR) {	/* destination address */
+		bitsize = sizeof(pkt->hdr.daddr) * 8;
+		seed = bit_change_seed(bitsize, bitsize / 8);
+		pkt->hdr.daddr ^= seed;
+	}
+
+	/* Recalculate checksum once */
+	pkt->hdr.check = 0;
+	pkt->hdr.check =
+	    calc_checksum((u_int16_t *) & (pkt->hdr), sizeof(struct iphdr));
+
+	if (fake_flag & FAKE_CHECK) {	/* checksum */
+		bitsize = sizeof(pkt->hdr.check) * 8;
+		seed = bit_change_seed(bitsize, bitsize / 8);
+		pkt->hdr.check ^= seed;
+	}
+}
+
+/*
+ * Function: send_packet()
+ *
+ * Description:
+ *  This function sends icmpv4 packet
+ *
+ * Argument:
+ *  fake_p: pointer to data of fake icmp structure
+ *
+ * Return value:
+ *  None
+ */
+void send_packets(struct icmpv4_fake *fake_p)
+{
+	int sock_fd;
+	int retval;
+	struct ip4_datagram pkt;
+	double start_time;
+
+	/* Open a socket */
+	sock_fd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_IP));
+	if (sock_fd < 0)
+		fatal_error("socket()");
+
+	/* Bind the socket to the physical address */
+	retval = bind(sock_fd, (struct sockaddr *)&(fake_p->saddr_ll),
+		      sizeof(struct sockaddr_ll));
+	if (retval < 0)
+		fatal_error("bind()");
+
+	/* Set singal hander for SIGHUP */
+	handler.sa_handler = set_signal_flag;
+	handler.sa_flags = 0;
+	if (sigfillset(&handler.sa_mask) < 0)
+		fatal_error("sigfillset()");
+	if (sigaction(SIGHUP, &handler, NULL) < 0)
+		fatal_error("sigfillset()");
+
+	/*
+	 * loop for sending packets
+	 */
+	pkt = fake_p->pkt;
+	start_time = time(NULL);
+
+	for (;;) {
+		if (fake_p->fake_flag) {
+			pkt = fake_p->pkt;
+			thrust_fakes(&pkt, fake_p->fake_flag);
+		}
+
+		retval = sendto(sock_fd, &pkt, fake_p->pkt_size, 0,
+				(struct sockaddr *)&(fake_p->daddr_ll),
+				sizeof(struct sockaddr_ll));
+		if (retval < 0)
+			fatal_error("sendto()");
+
+		if (fake_p->timeout)	/* timeout */
+			if (fake_p->timeout < difftime(time(NULL), start_time))
+				break;
+
+		if (catch_sighup)	/* catch SIGHUP */
+			break;
+	}
+
+	/* Close the socket */
+	close(sock_fd);
+}
+
+/*
+ *
+ *  Function: main()
+ *
+ */
+int main(int argc, char *argv[])
+{
+	struct icmpv4_fake fake_data;
+
+	debug = 0;
+	program_name = strdup(argv[0]);
+	srand(getpid());
+
+	memset(&fake_data, '\0', sizeof(struct icmpv4_fake));
+	parse_options(argc, argv, &fake_data);
+
+	complete_eth_addrs(&fake_data);
+	create_clean_packet(&fake_data);
+
+	send_packets(&fake_data);
+
+	exit(EXIT_SUCCESS);
+}
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
