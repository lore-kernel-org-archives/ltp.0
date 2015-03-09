Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YUtAv-0007g9-IB
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 08:36:33 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YUtAs-0002yz-Tv
	for ltp-list@lists.sourceforge.net; Mon, 09 Mar 2015 08:36:33 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t298ZQjX028252
	for <ltp-list@lists.sourceforge.net>; Mon, 9 Mar 2015 16:35:26 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Mon, 9 Mar 2015 16:31:56 +0800
Message-ID: <1425889922-13650-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 1/7] lib6/asapi_01.c: cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

* Remove useless comments.

* Modify the format of ftab[].

* Move the test body from main() to do_test().

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_01.c | 440 ++++++++++++++++----------------------
 1 file changed, 186 insertions(+), 254 deletions(-)

diff --git a/testcases/network/lib6/asapi_01.c b/testcases/network/lib6/asapi_01.c
index e0c86d2..d53ce23 100644
--- a/testcases/network/lib6/asapi_01.c
+++ b/testcases/network/lib6/asapi_01.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   Author: David L Stevens
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,26 +14,13 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * Test Name: asapi_01
- *
- * Test Description:
- *  These tests are for the "Advanced Sockets API" (RFC 3542)
- *  Verify that in6 and sockaddr fields are present.
- *
- * Usage:  <for command-line>
- *  asapi_01
- *
- * HISTORY
- *	01/2005 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
- *
+ *   Description:
+ *     These tests are for the "Advanced Sockets API" (RFC 3542)
+ *     Verify that in6 and sockaddr fields are present.
  */
 
 #include <stdio.h>
@@ -46,13 +34,9 @@
 #include "test.h"
 #include "runcc.h"
 
-char *TCID = "asapi_01";	/* Test program identifier.    */
-
-void setup(void), cleanup(void);
-
 enum ttype { EXISTS, ALIAS, VALUE };
 
-struct ftent {
+static struct ftent {
 	char *ft_tname;		/* test name */
 	int ft_type;		/* test type */
 	char *ft_incl;		/* include file list */
@@ -66,257 +50,205 @@ struct ftent {
 #define ft_value	ftun.fu_value
 #define ft_dname	ftun.fu_dname
 } ftab[] = {
-/* section 2.1 structure & field definitions */
-	{
-		"ip6_hdr un1_flow", EXISTS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un1.ip6_un1_flow", "0", {
-	"4"}}, {
-		"ip6_hdr ip6_flow", ALIAS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un1.ip6_un1_flow", NULL, {
-	"ip6_flow"}}, {
-		"ip6_hdr un1_plen", EXISTS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un1.ip6_un1_plen", "4", {
-	"2"}}, {
-		"ip6_hdr ip6_plen", ALIAS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un1.ip6_un1_plen", "4", {
-	"ip6_plen"}}, {
-		"ip6_hdr un1_nxt", EXISTS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un1.ip6_un1_nxt", "6", {
-	"1"}}, {
-		"ip6_hdr ip6_nxt", ALIAS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un1.ip6_un1_nxt", NULL, {
-	"ip6_nxt"}}, {
-		"ip6_hdr un1_hlim", EXISTS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un1.ip6_un1_hlim", "7", {
-	"1"}}, {
-		"ip6_hdr ip6_hlim", ALIAS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un1.ip6_un1_hlim", NULL, {
-	"ip6_hlim"}}, {
-		"ip6_hdr un1_vfc", EXISTS, IP6_H, "ip6_hdr",
-		    "ip6_ctlun.ip6_un2_vfc", "0", {
-	"1"}}, {
-		"ip6_hdr ip6_src", EXISTS, IP6_H, "ip6_hdr", "ip6_src",
-		    "sizeof(struct ip6_hdrctl)", {
-	"sizeof(struct in6_addr)"}}, {
-		"ip6_hdr ip6_dst", EXISTS, IP6_H, "ip6_hdr", "ip6_dst",
-		    "(sizeof(struct ip6_hdrctl)+sizeof(struct in6_addr))", {
-	"sizeof(struct in6_addr)"}},
-/* section 2.2 structure and field definitions */
-	{
-		"IPPROTO_HOPOPTS", VALUE, IN_H, "IPPROTO_HOPOPTS", NULL, NULL, {
-	"0"}}, {
-		"IPPROTO_IPV6", VALUE, IN_H, "IPPROTO_IPV6", NULL, NULL, {
-	"41"}}, {
-		"IPPROTO_ROUTING", VALUE, IN_H, "IPPROTO_ROUTING", NULL, NULL, {
-	"43"}}, {
-		"IPPROTO_FRAGMENT", VALUE, IN_H, "IPPROTO_FRAGMENT", NULL, NULL, {
-	"44"}}, {
-		"IPPROTO_ESP", VALUE, IN_H, "IPPROTO_ESP", NULL, NULL, {
-	"50"}}, {
-		"IPPROTO_AH", VALUE, IN_H, "IPPROTO_AH", NULL, NULL, {
-	"51"}}, {
-		"IPPROTO_ICMPV6", VALUE, IN_H, "IPPROTO_ICMPV6", NULL, NULL, {
-	"58"}}, {
-		"IPPROTO_NONE", VALUE, IN_H, "IPPROTO_NONE", NULL, NULL, {
-	"59"}}, {
-		"IPPROTO_DSTOPTS", VALUE, IN_H, "IPPROTO_DSTOPTS", NULL, NULL, {
-	"60"}},
-/* ip6_hbh */
-	{
-		"ip6_hbh ip6h_nxt", EXISTS, IP6_H, "ip6_hbh", "ip6h_nxt", "0", {
-	"1"}}, {
-		"ip6_hbh ip6h_nxt", EXISTS, IP6_H, "ip6_hbh", "ip6h_len", "1", {
-	"1"}},
-/* ip6_dest */
-	{
-		"ip6_dest ip6d_nxt", EXISTS, IP6_H, "ip6_dest", "ip6d_nxt", "0", {
-	"1"}}, {
-		"ip6_dest ip6d_nxt", EXISTS, IP6_H, "ip6_dest", "ip6d_len", "1", {
-	"1"}},
-/* ip6_rthdr0 */
-	{
-		"ip6_rthdr0 ip6r0_nxt", EXISTS, IP6_H, "ip6_rthdr0",
-		    "ip6r0_nxt", "0", {
-	"1"}}, {
-		"ip6_rthdr0 ip6r0_len", EXISTS, IP6_H, "ip6_rthdr0",
-		    "ip6r0_len", "1", {
-	"1"}}, {
-		"ip6_rthdr0 ip6r0_type", EXISTS, IP6_H, "ip6_rthdr0",
-		    "ip6r0_type", "2", {
-	"1"}}, {
-		"ip6_rthdr0 ip6r0_segleft", EXISTS, IP6_H, "ip6_rthdr0",
-		    "ip6r0_segleft", "3", {
-	"1"}}, {
-		"ip6_rthdr0 ip6r0_reserved", EXISTS, IP6_H, "ip6_rthdr0",
-		    "ip6r0_reserved", "4", {
-	"1"}},
-/* ip6_frag */
-	{
-		"ip6_frag ip6f_nxt", EXISTS, IP6_H, "ip6_frag", "ip6f_nxt", "0", {
-	"1"}}, {
-		"ip6_frag ip6f_reserved", EXISTS, IP6_H, "ip6_frag",
-		    "ip6f_reserved", "1", {
-	"1"}}, {
-		"ip6_frag ip6f_offlg", EXISTS, IP6_H, "ip6_frag",
-		    "ip6f_offlg", "2", {
-	"2"}}, {
-		"ip6_frag ip6f_ident", EXISTS, IP6_H, "ip6_frag",
-		    "ip6f_ident", "4", {
-	"4"}}, {
-		"IP6F_OFF_MASK", VALUE, IP6_H, "IP6F_OFF_MASK", NULL, NULL, {
-	"htons(0xfff8)"}}, {
-		"IP6F_RESERVED_MASK", VALUE, IP6_H, "IP6F_RESERVED_MASK",
-		    NULL, NULL, {
-	"htons(0x0006)"}}, {
-		"IP6F_MORE_FRAG", VALUE, IP6_H, "IP6F_MORE_FRAG", NULL, NULL, {
-	"htons(0x0001)"}}, {
-		"IP6OPT_TYPE", VALUE, IP6_H, "IP6OPT_TYPE(0xff)", NULL, NULL, {
-	"0xc0"}}, {
-		"IP6OPT_TYPE_SKIP", VALUE, IP6_H, "IP6OPT_TYPE_SKIP",
-		    NULL, NULL, {
-	"0x00"}}, {
-		"IP6OPT_TYPE_DISCARD", VALUE, IP6_H, "IP6OPT_TYPE_DISCARD",
-		    NULL, NULL, {
-	"0x40"}}, {
-		"IP6OPT_TYPE_FORCEICMP", VALUE, IP6_H, "IP6OPT_TYPE_FORCEICMP",
-		    NULL, NULL, {
-	"0x80"}}, {
-		"IP6OPT_TYPE_ICMP", VALUE, IP6_H, "IP6OPT_TYPE_ICMP",
-		    NULL, NULL, {
-	"0xc0"}}, {
-		"IP6OPT_TYPE_MUTABLE", VALUE, IP6_H, "IP6OPT_TYPE_MUTABLE",
-		    NULL, NULL, {
-	"0x20"}}, {
-		"IP6OPT_PAD1", VALUE, IP6_H, "IP6OPT_PAD1", NULL, NULL, {
-	"0x00"}}, {
-		"IP6OPT_PADN", VALUE, IP6_H, "IP6OPT_PADN", NULL, NULL, {
-	"0x01"}}, {
-		"IP6OPT_JUMBO", VALUE, IP6_H, "IP6OPT_JUMBO", NULL, NULL, {
-	"0xc2"}}, {
-		"IP6OPT_NSAP_ADDR", VALUE, IP6_H, "IP6OPT_NSAP_ADDR",
-		    NULL, NULL, {
-	"0xc3"}}, {
-		"IP6OPT_TUNNEL_LIMIT", VALUE, IP6_H, "IP6OPT_TUNNEL_LIMIT",
-		    NULL, NULL, {
-	"0x04"}}, {
-		"IP6OPT_ROUTER_ALERT", VALUE, IP6_H, "IP6OPT_ROUTER_ALERT",
-		    NULL, NULL, {
-	"0x05"}},
-/* ip6_opt_jumbo */
-	{
-		"ip6_opt_jumbo ip6oj_type", EXISTS, IP6_H, "ip6_opt_jumbo",
-		    "ip6oj_type", "0", {
-	"1"}}, {
-		"ip6_opt_jumbo ip6oj_len", EXISTS, IP6_H, "ip6_opt_jumbo",
-		    "ip6oj_len", "1", {
-	"1"}}, {
-		"ip6_opt_jumbo ip6oj_jumbo_len element", EXISTS, IP6_H,
-		    "ip6_opt_jumbo", "ip6oj_jumbo_len[0]", "2", {
-	"1"}}, {
-		"ip6_opt_jumbo ip6oj_jumbo_len array", EXISTS, IP6_H,
-		    "ip6_opt_jumbo", "ip6oj_jumbo_len", "2", {
-	"4"}},
-/* ip6_opt_nsap */
-	{
-		"ip6_opt_nsap ip6on_type", EXISTS, IP6_H, "ip6_opt_nsap",
-		    "ip6on_type", "0", {
-	"1"}}, {
-		"ip6_opt_nsap ip6on_len", EXISTS, IP6_H, "ip6_opt_nsap",
-		    "ip6on_len", "1", {
-	"1"}}, {
-		"ip6_opt_nsap ip6on_src_nsap_len", EXISTS, IP6_H,
-		    "ip6_opt_nsap", "ip6on_src_nsap_len", "2", {
-	"1"}}, {
-		"ip6_opt_nsap ip6on_dst_nsap_len", EXISTS, IP6_H,
-		    "ip6_opt_nsap", "ip6on_dst_nsap_len", "3", {
-	"1"}},
-/* ip6_opt_tunnel */
-	{
-		"ip6_opt_tunnel ip6ot_type", EXISTS, IP6_H, "ip6_opt_tunnel",
-		    "ip6ot_type", "0", {
-	"1"}}, {
-		"ip6_opt_tunnel ip6ot_len", EXISTS, IP6_H, "ip6_opt_tunnel",
-		    "ip6ot_len", "1", {
-	"1"}}, {
-		"ip6_opt_tunnel ip6ot_encap_limit", EXISTS, IP6_H,
-		    "ip6_opt_tunnel", "ip6ot_encap_limit", "2", {
-	"1"}},
-/* ip6_opt_router */
-	{
-		"ip6_opt_router ip6or_type", EXISTS, IP6_H, "ip6_opt_router",
-		    "ip6or_type", "0", {
-	"1"}}, {
-		"ip6_opt_router ip6or_len", EXISTS, IP6_H, "ip6_opt_router",
-		    "ip6or_len", "1", {
-	"1"}}, {
-		"ip6_opt_router ip6or_value element", EXISTS, IP6_H,
-		    "ip6_opt_router", "ip6or_value[0]", "2", {
-	"1"}}, {
-		"ip6_opt_router ip6or_value array", EXISTS, IP6_H,
-		    "ip6_opt_router", "ip6or_value", "2", {
-	"2"}},
-/* IP6_ALERT_* definitions */
-	{
-		"IP6_ALERT_MLD", VALUE, IP6_H, "IP6_ALERT_MLD", NULL, NULL, {
-	"0"}}, {
-		"IP6_ALERT_RSVP", VALUE, IP6_H, "IP6_ALERT_RSVP", NULL, NULL, {
-	"htons(1)"}}, {
-		"IP6_ALERT_AN", VALUE, IP6_H, "IP6_ALERT_AN", NULL, NULL, {
-"htons(2)"}},};
-
-#define FTCOUNT	(sizeof(ftab)/sizeof(ftab[0]))
-
-int TST_TOTAL = FTCOUNT;
+	/* section 2.1 structure & field definitions */
+	{ "ip6_hdr un1_flow", EXISTS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un1.ip6_un1_flow", "0", {"4"} },
+	{ "ip6_hdr ip6_flow", ALIAS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un1.ip6_un1_flow", NULL, {"ip6_flow"} },
+	{ "ip6_hdr un1_plen", EXISTS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un1.ip6_un1_plen", "4", {"2"} },
+	{ "ip6_hdr ip6_plen", ALIAS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un1.ip6_un1_plen", "4", {"ip6_plen"} },
+	{ "ip6_hdr un1_nxt", EXISTS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un1.ip6_un1_nxt", "6", {"1"} },
+	{ "ip6_hdr ip6_nxt", ALIAS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un1.ip6_un1_nxt", NULL, {"ip6_nxt"} },
+	{ "ip6_hdr un1_hlim", EXISTS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un1.ip6_un1_hlim", "7", {"1"} },
+	{ "ip6_hdr ip6_hlim", ALIAS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un1.ip6_un1_hlim", NULL, {"ip6_hlim"} },
+	{ "ip6_hdr un1_vfc", EXISTS, IP6_H, "ip6_hdr",
+		"ip6_ctlun.ip6_un2_vfc", "0", {"1"} },
+	{ "ip6_hdr ip6_src", EXISTS, IP6_H, "ip6_hdr",
+		"ip6_src", "sizeof(struct ip6_hdrctl)",
+		{"sizeof(struct in6_addr)"} },
+	{ "ip6_hdr ip6_dst", EXISTS, IP6_H, "ip6_hdr", "ip6_dst",
+		"(sizeof(struct ip6_hdrctl)+sizeof(struct in6_addr))",
+		{"sizeof(struct in6_addr)"} },
+	/* section 2.2 structure and field definitions */
+	{ "IPPROTO_HOPOPTS", VALUE, IN_H, "IPPROTO_HOPOPTS",
+		NULL, NULL, {"0"} },
+	{ "IPPROTO_IPV6", VALUE, IN_H, "IPPROTO_IPV6",
+		NULL, NULL, {"41"} },
+	{ "IPPROTO_ROUTING", VALUE, IN_H, "IPPROTO_ROUTING",
+		NULL, NULL, {"43"} },
+	{ "IPPROTO_FRAGMENT", VALUE, IN_H, "IPPROTO_FRAGMENT",
+		NULL, NULL, {"44"} },
+	{ "IPPROTO_ESP", VALUE, IN_H, "IPPROTO_ESP",
+		NULL, NULL, {"50"} },
+	{ "IPPROTO_AH", VALUE, IN_H, "IPPROTO_AH",
+		NULL, NULL, {"51"} },
+	{ "IPPROTO_ICMPV6", VALUE, IN_H, "IPPROTO_ICMPV6",
+		NULL, NULL, {"58"} },
+	{ "IPPROTO_NONE", VALUE, IN_H, "IPPROTO_NONE",
+		NULL, NULL, {"59"} },
+	{ "IPPROTO_DSTOPTS", VALUE, IN_H, "IPPROTO_DSTOPTS",
+		NULL, NULL, {"60"} },
+	/* ip6_hbh */
+	{ "ip6_hbh ip6h_nxt", EXISTS, IP6_H, "ip6_hbh",
+		"ip6h_nxt", "0", {"1"} },
+	{ "ip6_hbh ip6h_nxt", EXISTS, IP6_H, "ip6_hbh",
+		"ip6h_len", "1", {"1"} },
+	/* ip6_dest */
+	{ "ip6_dest ip6d_nxt", EXISTS, IP6_H, "ip6_dest",
+		"ip6d_nxt", "0", {"1"} },
+	{ "ip6_dest ip6d_nxt", EXISTS, IP6_H, "ip6_dest",
+		"ip6d_len", "1", {"1"} },
+	/* ip6_rthdr0 */
+	{ "ip6_rthdr0 ip6r0_nxt", EXISTS, IP6_H, "ip6_rthdr0",
+		"ip6r0_nxt", "0", {"1"} },
+	{ "ip6_rthdr0 ip6r0_len", EXISTS, IP6_H, "ip6_rthdr0",
+		"ip6r0_len", "1", {"1"} },
+	{ "ip6_rthdr0 ip6r0_type", EXISTS, IP6_H, "ip6_rthdr0",
+		"ip6r0_type", "2", {"1"} },
+	{ "ip6_rthdr0 ip6r0_segleft", EXISTS, IP6_H, "ip6_rthdr0",
+		"ip6r0_segleft", "3", {"1"} },
+	{ "ip6_rthdr0 ip6r0_reserved", EXISTS, IP6_H, "ip6_rthdr0",
+		"ip6r0_reserved", "4", {"1"} },
+	/* ip6_frag */
+	{ "ip6_frag ip6f_nxt", EXISTS, IP6_H, "ip6_frag",
+		"ip6f_nxt", "0", {"1"} },
+	{ "ip6_frag ip6f_reserved", EXISTS, IP6_H, "ip6_frag",
+		"ip6f_reserved", "1", {"1"} },
+	{ "ip6_frag ip6f_offlg", EXISTS, IP6_H, "ip6_frag",
+		"ip6f_offlg", "2", {"2"} },
+	{ "ip6_frag ip6f_ident", EXISTS, IP6_H, "ip6_frag",
+		"ip6f_ident", "4", {"4"} },
+	{ "IP6F_OFF_MASK", VALUE, IP6_H, "IP6F_OFF_MASK",
+		NULL, NULL, {"htons(0xfff8)"} },
+	{ "IP6F_RESERVED_MASK", VALUE, IP6_H, "IP6F_RESERVED_MASK",
+		NULL, NULL, {"htons(0x0006)"} },
+	{ "IP6F_MORE_FRAG", VALUE, IP6_H, "IP6F_MORE_FRAG",
+		NULL, NULL, {"htons(0x0001)"} },
+	{ "IP6OPT_TYPE", VALUE, IP6_H, "IP6OPT_TYPE(0xff)",
+		NULL, NULL, {"0xc0"} },
+	{ "IP6OPT_TYPE_SKIP", VALUE, IP6_H, "IP6OPT_TYPE_SKIP",
+		NULL, NULL, {"0x00"} },
+	{ "IP6OPT_TYPE_DISCARD", VALUE, IP6_H, "IP6OPT_TYPE_DISCARD",
+		NULL, NULL, {"0x40"} },
+	{ "IP6OPT_TYPE_FORCEICMP", VALUE, IP6_H, "IP6OPT_TYPE_FORCEICMP",
+		NULL, NULL, {"0x80"} },
+	{ "IP6OPT_TYPE_ICMP", VALUE, IP6_H, "IP6OPT_TYPE_ICMP",
+		NULL, NULL, {"0xc0"} },
+	{ "IP6OPT_TYPE_MUTABLE", VALUE, IP6_H, "IP6OPT_TYPE_MUTABLE",
+		NULL, NULL, {"0x20"} },
+	{ "IP6OPT_PAD1", VALUE, IP6_H, "IP6OPT_PAD1",
+		NULL, NULL, {"0x00"} },
+	{ "IP6OPT_PADN", VALUE, IP6_H, "IP6OPT_PADN",
+		NULL, NULL, {"0x01"} },
+	{ "IP6OPT_JUMBO", VALUE, IP6_H, "IP6OPT_JUMBO",
+		NULL, NULL, {"0xc2"} },
+	{ "IP6OPT_NSAP_ADDR", VALUE, IP6_H, "IP6OPT_NSAP_ADDR",
+		NULL, NULL, {"0xc3"} },
+	{ "IP6OPT_TUNNEL_LIMIT", VALUE, IP6_H, "IP6OPT_TUNNEL_LIMIT",
+		NULL, NULL, {"0x04"} },
+	{ "IP6OPT_ROUTER_ALERT", VALUE, IP6_H, "IP6OPT_ROUTER_ALERT",
+		NULL, NULL, {"0x05"} },
+	/* ip6_opt_jumbo */
+	{ "ip6_opt_jumbo ip6oj_type", EXISTS, IP6_H, "ip6_opt_jumbo",
+		"ip6oj_type", "0", {"1"} },
+	{ "ip6_opt_jumbo ip6oj_len", EXISTS, IP6_H, "ip6_opt_jumbo",
+		"ip6oj_len", "1", {"1"} },
+	{ "ip6_opt_jumbo ip6oj_jumbo_len element", EXISTS, IP6_H,
+		"ip6_opt_jumbo", "ip6oj_jumbo_len[0]", "2", {"1"} },
+	{ "ip6_opt_jumbo ip6oj_jumbo_len array", EXISTS, IP6_H,
+		"ip6_opt_jumbo", "ip6oj_jumbo_len", "2", {"4"} },
+	/* ip6_opt_nsap */
+	{ "ip6_opt_nsap ip6on_type", EXISTS, IP6_H, "ip6_opt_nsap",
+		"ip6on_type", "0", {"1"} },
+	{ "ip6_opt_nsap ip6on_len", EXISTS, IP6_H, "ip6_opt_nsap",
+		"ip6on_len", "1", {"1"} },
+	{ "ip6_opt_nsap ip6on_src_nsap_len", EXISTS, IP6_H,
+		"ip6_opt_nsap", "ip6on_src_nsap_len", "2", {"1"} },
+	{ "ip6_opt_nsap ip6on_dst_nsap_len", EXISTS, IP6_H,
+		"ip6_opt_nsap", "ip6on_dst_nsap_len", "3", {"1"} },
+	/* ip6_opt_tunnel */
+	{ "ip6_opt_tunnel ip6ot_type", EXISTS, IP6_H,
+		"ip6_opt_tunnel", "ip6ot_type", "0", {"1"} },
+	{ "ip6_opt_tunnel ip6ot_len", EXISTS, IP6_H,
+		"ip6_opt_tunnel", "ip6ot_len", "1", {"1"} },
+	{ "ip6_opt_tunnel ip6ot_encap_limit", EXISTS, IP6_H,
+		"ip6_opt_tunnel", "ip6ot_encap_limit", "2", {"1"} },
+	/* ip6_opt_router */
+	{ "ip6_opt_router ip6or_type", EXISTS, IP6_H,
+		"ip6_opt_router", "ip6or_type", "0", {"1"} },
+	{ "ip6_opt_router ip6or_len", EXISTS, IP6_H,
+		"ip6_opt_router", "ip6or_len", "1", {"1"} },
+	{ "ip6_opt_router ip6or_value element", EXISTS, IP6_H,
+		"ip6_opt_router", "ip6or_value[0]", "2", {"1"} },
+	{ "ip6_opt_router ip6or_value array", EXISTS, IP6_H,
+		"ip6_opt_router", "ip6or_value", "2", {"2"} },
+	/* IP6_ALERT_* definitions */
+	{ "IP6_ALERT_MLD", VALUE, IP6_H, "IP6_ALERT_MLD",
+		NULL, NULL, {"0"} },
+	{ "IP6_ALERT_RSVP", VALUE, IP6_H, "IP6_ALERT_RSVP",
+		NULL, NULL, {"htons(1)"} },
+	{ "IP6_ALERT_AN", VALUE, IP6_H, "IP6_ALERT_AN",
+		NULL, NULL, {"htons(2)"} },
+};
+
+static void setup(void);
+static void do_test(const struct ftent *);
+
+char *TCID = "asapi_01";
+int TST_TOTAL = ARRAY_SIZE(ftab);
 
 int main(int argc, char *argv[])
 {
 	int i, lc;
 	const char *msg;
 
-	/* Parse standard options given to run the test. */
 	msg = parse_opts(argc, argv, NULL, NULL);
-	if (msg != NULL) {
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		for (i = 0; i < FTCOUNT; ++i) {
-			switch (ftab[i].ft_type) {
-			case EXISTS:
-				structcheck(ftab[i].ft_tname, ftab[i].ft_incl,
-					    ftab[i].ft_struct, ftab[i].ft_field,
-					    ftab[i].ft_offset,
-					    ftab[i].ft_value);
-				break;
-			case ALIAS:
-				aliascheck(ftab[i].ft_tname, ftab[i].ft_incl,
-					   ftab[i].ft_struct, ftab[i].ft_field,
-					   ftab[i].ft_dname);
-				break;
-			case VALUE:
-				valuecheck(ftab[i].ft_tname, ftab[i].ft_incl,
-					   ftab[i].ft_struct, ftab[i].ft_dname);
-				break;
-			default:
-				tst_resm(TBROK, "invalid type %d",
-					 ftab[i].ft_type);
-				break;
-			}
-		}
-	}
+		tst_count = 0;
 
-	cleanup();
+		for (i = 0; i < TST_TOTAL; i++)
+			do_test(&ftab[i]);
+	}
 
 	tst_exit();
 }
 
 void setup(void)
 {
-	TEST_PAUSE;		/* if -P option specified */
+	TEST_PAUSE;
 }
 
-void cleanup(void)
+void do_test(const struct ftent *ftptr)
 {
+	switch (ftptr->ft_type) {
+	case EXISTS:
+		structcheck(ftptr->ft_tname, ftptr->ft_incl,
+			ftptr->ft_struct, ftptr->ft_field,
+			ftptr->ft_offset, ftptr->ft_value);
+		break;
+	case ALIAS:
+		aliascheck(ftptr->ft_tname, ftptr->ft_incl,
+			ftptr->ft_struct, ftptr->ft_field,
+			ftptr->ft_dname);
+		break;
+	case VALUE:
+		valuecheck(ftptr->ft_tname, ftptr->ft_incl,
+			ftptr->ft_struct, ftptr->ft_dname);
+		break;
+	default:
+		tst_resm(TBROK, "invalid type %d",
+			ftptr->ft_type);
+		break;
+	}
 }
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
