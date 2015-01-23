Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YEaiu-00009r-MD
	for ltp-list@lists.sourceforge.net; Fri, 23 Jan 2015 09:40:16 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YEais-0004ve-Uk
	for ltp-list@lists.sourceforge.net; Fri, 23 Jan 2015 09:40:17 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t0N9dSmv006586
	for <ltp-list@lists.sourceforge.net>; Fri, 23 Jan 2015 17:39:28 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 23 Jan 2015 17:36:08 +0800
Message-ID: <1422005772-19099-3-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1422005772-19099-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1422005772-19099-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/7] lib6/asapi_03.c: cleanup
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
 testcases/network/lib6/asapi_03.c | 397 +++++++++++++++++---------------------
 1 file changed, 172 insertions(+), 225 deletions(-)

diff --git a/testcases/network/lib6/asapi_03.c b/testcases/network/lib6/asapi_03.c
index 5753d19..738a3f4 100644
--- a/testcases/network/lib6/asapi_03.c
+++ b/testcases/network/lib6/asapi_03.c
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
- * Test Name: asapi_03
- *
- * Test Description:
- *  These tests are for the "Advanced Sockets API" (RFC 3542)
- *  Verify that in6 and sockaddr fields are present.
- *
- * Usage:  <for command-line>
- *  asapi_03
- *
- * HISTORY
- *	03/2005 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
- *
+ *   Description:
+ *     These tests are for the "Advanced Sockets API" (RFC 3542)
+ *     Verify that in6 and sockaddr fields are present.
  */
 
 #include <stdio.h>
@@ -47,10 +35,6 @@
 #include "usctest.h"
 #include "runcc.h"
 
-char *TCID = "asapi_03";	/* Test program identifier.    */
-
-void setup(void), cleanup(void);
-
 enum ttype { EXISTS, ALIAS, VALUE };
 
 struct ftent {
@@ -67,232 +51,195 @@ struct ftent {
 #define ft_value	ftun.fu_value
 #define ft_dname	ftun.fu_dname
 } ftab[] = {
-/* section 2.2.3, MLDv1 */
-	{
-		"MLD_LISTENER_QUERY", VALUE, ICMP6_H, "MLD_LISTENER_QUERY",
-		    NULL, NULL, {
-	"130"}}, {
-		"MLD_LISTENER_REPORT", VALUE, ICMP6_H, "MLD_LISTENER_REPORT",
-		    NULL, NULL, {
-	"131"}}, {
-		"MLD_LISTENER_REDUCTION", VALUE, ICMP6_H,
-		    "MLD_LISTENER_REDUCTION", NULL, NULL, {
-	"132"}}, {
-		"mld_hdr mld_icmp6_hdr", EXISTS, ICMP6_H, "mld_hdr",
-		    "mld_icmp6_hdr", "0", {
-	"sizeof(struct icmp6_hdr)"}}, {
-		"mld_hdr mld_addr", EXISTS, ICMP6_H, "mld_hdr", "mld_addr",
-		    "sizeof(struct icmp6_hdr)", {
-	"sizeof(struct in6_addr)"}}, {
-		"mld_hdr mld_type define", ALIAS, ICMP6_H, "mld_hdr",
-		    "mld_icmp6_hdr.icmp6_type", NULL, {
-	"mld_type"}}, {
-		"mld_hdr mld_code define", ALIAS, ICMP6_H, "mld_hdr",
-		    "mld_icmp6_hdr.icmp6_code", NULL, {
-	"mld_code"}}, {
-		"mld_hdr mld_cksum define", ALIAS, ICMP6_H, "mld_hdr",
-		    "mld_icmp6_hdr.icmp6_cksum", NULL, {
-	"mld_cksum"}}, {
-		"mld_hdr mld_maxdelay define", ALIAS, ICMP6_H, "mld_hdr",
-		    "mld_icmp6_hdr.icmp6_data16[0]", NULL, {
-	"mld_maxdelay"}}, {
-		"mld_hdr mld_reserved define", ALIAS, ICMP6_H, "mld_hdr",
-		    "mld_icmp6_hdr.icmp6_data16[1]", NULL, {
-	"mld_reserved"}},
-/* section 2.2.4, Router renumbering */
-	{
-		"ICMP6_ROUTER_RENUMBERING", VALUE, ICMP6_H,
-		    "ICMP6_ROUTER_RENUMBERING", NULL, NULL, {
-	"138"}}, {
-		"icmp6_router_renum rr_hdr", EXISTS, ICMP6_H,
-		    "icmp6_router_renum", "rr_hdr", "0", {
-	"sizeof(struct icmp6_hdr)"}}, {
-		"icmp6_router_renum rr_segnum", EXISTS, ICMP6_H,
-		    "icmp6_router_renum", "rr_segnum",
-		    "sizeof(struct icmp6_hdr)", {
-	"1"}}, {
-		"icmp6_router_renum rr_flags", EXISTS, ICMP6_H,
-		    "icmp6_router_renum", "rr_flags",
-		    "sizeof(struct icmp6_hdr)+1", {
-	"1"}}, {
-		"icmp6_router_renum rr_maxdelay", EXISTS, ICMP6_H,
-		    "icmp6_router_renum", "rr_maxdelay",
-		    "sizeof(struct icmp6_hdr)+2", {
-	"2"}}, {
-		"icmp6_router_renum rr_reserved", EXISTS, ICMP6_H,
-		    "icmp6_router_renum", "rr_reserved",
-		    "sizeof(struct icmp6_hdr)+4", {
-	"4"}}, {
-		"icmp6_router_renum rr_type define", ALIAS, ICMP6_H,
-		    "icmp6_router_renum", "rr_hdr.icmp6_type", NULL, {
-	"rr_type"}}, {
-		"icmp6_router_renum rr_code define", ALIAS, ICMP6_H,
-		    "icmp6_router_renum", "rr_hdr.icmp6_code", NULL, {
-	"rr_code"}}, {
-		"icmp6_router_renum rr_cksum define", ALIAS, ICMP6_H,
-		    "icmp6_router_renum", "rr_hdr.icmp6_cksum", NULL, {
-	"rr_cksum"}}, {
-		"icmp6_router_renum rr_seqnum define", ALIAS, ICMP6_H,
-		    "icmp6_router_renum", "rr_hdr.icmp6_data32[0]", NULL, {
-	"rr_seqnum"}}, {
-		"ICMP6_RR_FLAGS_TEST", VALUE, ICMP6_H, "ICMP6_RR_FLAGS_TEST",
-		    NULL, NULL, {
-	"0x80"}}, {
-		"ICMP6_RR_FLAGS_REQRESULT", VALUE, ICMP6_H,
-		    "ICMP6_RR_FLAGS_REQRESULT", NULL, NULL, {
-	"0x40"}}, {
-		"ICMP6_RR_FLAGS_FORCEAPPLY", VALUE, ICMP6_H,
-		    "ICMP6_RR_FLAGS_FORCEAPPLY", NULL, NULL, {
-	"0x20"}}, {
-		"ICMP6_RR_FLAGS_SPECSITE", VALUE, ICMP6_H,
-		    "ICMP6_RR_FLAGS_SPECSITE", NULL, NULL, {
-	"0x10"}}, {
-		"ICMP6_RR_FLAGS_PREVDONE", VALUE, ICMP6_H,
-		    "ICMP6_RR_FLAGS_PREVDONE", NULL, NULL, {
-	"0x08"}}, {
-		"rr_pco_match rpm_code", EXISTS, ICMP6_H, "rr_pco_match",
-		    "rpm_code", "0", {
-	"1"}}, {
-		"rr_pco_match rpm_len", EXISTS, ICMP6_H, "rr_pco_match",
-		    "rpm_len", "1", {
-	"1"}}, {
-		"rr_pco_match rpm_ordinal", EXISTS, ICMP6_H, "rr_pco_match",
-		    "rpm_ordinal", "2", {
-	"1"}}, {
-		"rr_pco_match rpm_matchlen", EXISTS, ICMP6_H, "rr_pco_match",
-		    "rpm_matchlen", "3", {
-	"1"}}, {
-		"rr_pco_match rpm_minlen", EXISTS, ICMP6_H, "rr_pco_match",
-		    "rpm_minlen", "4", {
-	"1"}}, {
-		"rr_pco_match rpm_maxlen", EXISTS, ICMP6_H, "rr_pco_match",
-		    "rpm_maxlen", "5", {
-	"1"}}, {
-		"rr_pco_match rpm_reserved", EXISTS, ICMP6_H, "rr_pco_match",
-		    "rpm_reserved", "6", {
-	"2"}}, {
-		"rr_pco_match rpm_prefix", EXISTS, ICMP6_H, "rr_pco_match",
-		    "rpm_prefix", "8", {
-	"sizeof(struct in6_addr)"}}, {
-		"RPM_PCO_ADD", VALUE, ICMP6_H, "RPM_PCO_ADD", NULL, NULL, {
-	"1"}}, {
-		"RPM_PCO_CHANGE", VALUE, ICMP6_H, "RPM_PCO_CHANGE", NULL, NULL, {
-	"2"}}, {
-		"RPM_PCO_SETGLOBAL", VALUE, ICMP6_H, "RPM_PCO_SETGLOBAL", NULL,
-		    NULL, {
-	"3"}}, {
-		"rr_pco_use rpu_uselen", EXISTS, ICMP6_H, "rr_pco_use",
-		    "rpu_uselen", "0", {
-	"1"}}, {
-		"rr_pco_use rpu_keeplen", EXISTS, ICMP6_H, "rr_pco_use",
-		    "rpu_keeplen", "1", {
-	"1"}}, {
-		"rr_pco_use rpu_ramask", EXISTS, ICMP6_H, "rr_pco_use",
-		    "rpu_ramask", "2", {
-	"1"}}, {
-		"rr_pco_use rpu_raflags", EXISTS, ICMP6_H, "rr_pco_use",
-		    "rpu_raflags", "3", {
-	"1"}}, {
-		"rr_pco_use rpu_vltime", EXISTS, ICMP6_H, "rr_pco_use",
-		    "rpu_vltime", "4", {
-	"4"}}, {
-		"rr_pco_use rpu_pltime", EXISTS, ICMP6_H, "rr_pco_use",
-		    "rpu_pltime", "8", {
-	"4"}}, {
-		"rr_pco_use rpu_flags", EXISTS, ICMP6_H, "rr_pco_use",
-		    "rpu_flags", "12", {
-	"4"}}, {
-		"rr_pco_use rpu_prefix", EXISTS, ICMP6_H, "rr_pco_use",
-		    "rpu_prefix", "16", {
-	"sizeof(struct in6_addr)"}}, {
-		"ICMP6_RR_PCOUSE_RAFLAGS_ONLINK", VALUE, ICMP6_H,
-		    "ICMP6_RR_PCOUSE_RAFLAGS_ONLINK", NULL, NULL, {
-	"0x20"}}, {
-		"ICMP6_RR_PCOUSE_RAFLAGS_AUTO", VALUE, ICMP6_H,
-		    "ICMP6_RR_PCOUSE_RAFLAGS_AUTO", NULL, NULL, {
-	"0x10"}}, {
-		"ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME", VALUE, ICMP6_H,
-		    "ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME", NULL, NULL, {
-	"htonl(0x80000000)"}}, {
-		"ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME", VALUE, ICMP6_H,
-		    "ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME", NULL, NULL, {
-	"htonl(0x40000000)"}}, {
-		"rr_result rrr_flags", EXISTS, ICMP6_H, "rr_result",
-		    "rrr_flags", "0", {
-	"2"}}, {
-		"rr_result rrr_ordinal", EXISTS, ICMP6_H, "rr_result",
-		    "rrr_ordinal", "2", {
-	"1"}}, {
-		"rr_result rrr_matchedlen", EXISTS, ICMP6_H, "rr_result",
-		    "rrr_matchedlen", "3", {
-	"1"}}, {
-		"rr_result rrr_ifid", EXISTS, ICMP6_H, "rr_result",
-		    "rrr_ifid", "4", {
-	"4"}}, {
-		"rr_result rrr_prefix", EXISTS, ICMP6_H, "rr_result",
-		    "rrr_prefix", "8", {
-	"sizeof(struct in6_addr)"}}, {
-		"ICMP6_RR_RESULT_FLAGS_OOB", VALUE, ICMP6_H,
-		    "ICMP6_RR_RESULT_FLAGS_OOB", NULL, NULL, {
-	"htons(0x0002)"}}, {
-		"ICMP6_RR_RESULT_FLAGS_FORBIDDEN", VALUE, ICMP6_H,
-		    "ICMP6_RR_RESULT_FLAGS_FORBIDDEN", NULL, NULL, {
-"htons(0x0001)"}},};
-
-#define FTCOUNT	(sizeof(ftab)/sizeof(ftab[0]))
-
-int TST_TOTAL = FTCOUNT;
+	/* section 2.2.3, MLDv1 */
+	{ "MLD_LISTENER_QUERY", VALUE, ICMP6_H,
+		"MLD_LISTENER_QUERY", NULL, NULL, {"130"} },
+	{ "MLD_LISTENER_REPORT", VALUE, ICMP6_H,
+		"MLD_LISTENER_REPORT", NULL, NULL, {"131"} },
+	{ "MLD_LISTENER_REDUCTION", VALUE, ICMP6_H,
+		"MLD_LISTENER_REDUCTION", NULL, NULL, {"132"} },
+	{ "mld_hdr mld_icmp6_hdr", EXISTS, ICMP6_H,
+		"mld_hdr", "mld_icmp6_hdr", "0",
+		{"sizeof(struct icmp6_hdr)"} },
+	{ "mld_hdr mld_addr", EXISTS, ICMP6_H, "mld_hdr",
+		"mld_addr", "sizeof(struct icmp6_hdr)",
+		{"sizeof(struct in6_addr)"} },
+	{ "mld_hdr mld_type define", ALIAS, ICMP6_H, "mld_hdr",
+		"mld_icmp6_hdr.icmp6_type", NULL, {"mld_type"} },
+	{ "mld_hdr mld_code define", ALIAS, ICMP6_H, "mld_hdr",
+		"mld_icmp6_hdr.icmp6_code", NULL, {"mld_code"} },
+	{ "mld_hdr mld_cksum define", ALIAS, ICMP6_H, "mld_hdr",
+		"mld_icmp6_hdr.icmp6_cksum", NULL, {"mld_cksum"} },
+	{ "mld_hdr mld_maxdelay define", ALIAS, ICMP6_H, "mld_hdr",
+		"mld_icmp6_hdr.icmp6_data16[0]", NULL, {"mld_maxdelay"} },
+	{ "mld_hdr mld_reserved define", ALIAS, ICMP6_H, "mld_hdr",
+		"mld_icmp6_hdr.icmp6_data16[1]", NULL, {"mld_reserved"} },
+	/* section 2.2.4, Router renumbering */
+	{ "ICMP6_ROUTER_RENUMBERING", VALUE, ICMP6_H,
+		"ICMP6_ROUTER_RENUMBERING", NULL, NULL, {"138"} },
+	{ "icmp6_router_renum rr_hdr", EXISTS, ICMP6_H,
+		"icmp6_router_renum", "rr_hdr", "0",
+		{"sizeof(struct icmp6_hdr)"} },
+	{ "icmp6_router_renum rr_segnum", EXISTS, ICMP6_H,
+		"icmp6_router_renum", "rr_segnum",
+		"sizeof(struct icmp6_hdr)", {"1"} },
+	{ "icmp6_router_renum rr_flags", EXISTS, ICMP6_H,
+		"icmp6_router_renum", "rr_flags",
+		"sizeof(struct icmp6_hdr)+1", {"1"} },
+	{ "icmp6_router_renum rr_maxdelay", EXISTS, ICMP6_H,
+		"icmp6_router_renum", "rr_maxdelay",
+		"sizeof(struct icmp6_hdr)+2", {"2"} },
+	{ "icmp6_router_renum rr_reserved", EXISTS, ICMP6_H,
+		"icmp6_router_renum", "rr_reserved",
+		"sizeof(struct icmp6_hdr)+4", {"4"} },
+	{ "icmp6_router_renum rr_type define", ALIAS, ICMP6_H,
+		"icmp6_router_renum", "rr_hdr.icmp6_type",
+		NULL, {"rr_type"} },
+	{ "icmp6_router_renum rr_code define", ALIAS, ICMP6_H,
+		"icmp6_router_renum", "rr_hdr.icmp6_code",
+		NULL, {"rr_code"} },
+	{ "icmp6_router_renum rr_cksum define", ALIAS, ICMP6_H,
+		"icmp6_router_renum", "rr_hdr.icmp6_cksum",
+		NULL, {"rr_cksum"} },
+	{ "icmp6_router_renum rr_seqnum define", ALIAS, ICMP6_H,
+		"icmp6_router_renum", "rr_hdr.icmp6_data32[0]",
+		NULL, {"rr_seqnum"} },
+	{ "ICMP6_RR_FLAGS_TEST", VALUE, ICMP6_H,
+		"ICMP6_RR_FLAGS_TEST", NULL, NULL, {"0x80"} },
+	{ "ICMP6_RR_FLAGS_REQRESULT", VALUE, ICMP6_H,
+		"ICMP6_RR_FLAGS_REQRESULT", NULL, NULL, {"0x40"} },
+	{ "ICMP6_RR_FLAGS_FORCEAPPLY", VALUE, ICMP6_H,
+		"ICMP6_RR_FLAGS_FORCEAPPLY", NULL, NULL, {"0x20"} },
+	{ "ICMP6_RR_FLAGS_SPECSITE", VALUE, ICMP6_H,
+		"ICMP6_RR_FLAGS_SPECSITE", NULL, NULL, {"0x10"} },
+	{ "ICMP6_RR_FLAGS_PREVDONE", VALUE, ICMP6_H,
+		"ICMP6_RR_FLAGS_PREVDONE", NULL, NULL, {"0x08"} },
+	{ "rr_pco_match rpm_code", EXISTS, ICMP6_H,
+		"rr_pco_match", "rpm_code", "0", {"1"} },
+	{ "rr_pco_match rpm_len", EXISTS, ICMP6_H,
+		"rr_pco_match", "rpm_len", "1", {"1"} },
+	{ "rr_pco_match rpm_ordinal", EXISTS, ICMP6_H,
+		"rr_pco_match", "rpm_ordinal", "2", {"1"} },
+	{ "rr_pco_match rpm_matchlen", EXISTS, ICMP6_H,
+		"rr_pco_match", "rpm_matchlen", "3", {"1"} },
+	{ "rr_pco_match rpm_minlen", EXISTS, ICMP6_H,
+		"rr_pco_match", "rpm_minlen", "4", {"1"} },
+	{ "rr_pco_match rpm_maxlen", EXISTS, ICMP6_H,
+		"rr_pco_match", "rpm_maxlen", "5", {"1"} },
+	{ "rr_pco_match rpm_reserved", EXISTS, ICMP6_H,
+		"rr_pco_match", "rpm_reserved", "6", {"2"} },
+	{ "rr_pco_match rpm_prefix", EXISTS, ICMP6_H,
+		"rr_pco_match", "rpm_prefix", "8",
+		{"sizeof(struct in6_addr)"} },
+	{ "RPM_PCO_ADD", VALUE, ICMP6_H, "RPM_PCO_ADD",
+		NULL, NULL, {"1"} },
+	{ "RPM_PCO_CHANGE", VALUE, ICMP6_H, "RPM_PCO_CHANGE",
+		NULL, NULL, {"2"} },
+	{ "RPM_PCO_SETGLOBAL", VALUE, ICMP6_H, "RPM_PCO_SETGLOBAL",
+		NULL, NULL, {"3"} },
+	{ "rr_pco_use rpu_uselen", EXISTS, ICMP6_H, "rr_pco_use",
+		"rpu_uselen", "0", {"1"} },
+	{ "rr_pco_use rpu_keeplen", EXISTS, ICMP6_H, "rr_pco_use",
+		"rpu_keeplen", "1", {"1"} },
+	{ "rr_pco_use rpu_ramask", EXISTS, ICMP6_H, "rr_pco_use",
+		"rpu_ramask", "2", {"1"} },
+	{ "rr_pco_use rpu_raflags", EXISTS, ICMP6_H, "rr_pco_use",
+		"rpu_raflags", "3", {"1"} },
+	{ "rr_pco_use rpu_vltime", EXISTS, ICMP6_H, "rr_pco_use",
+		"rpu_vltime", "4", {"4"} },
+	{ "rr_pco_use rpu_pltime", EXISTS, ICMP6_H, "rr_pco_use",
+		"rpu_pltime", "8", {"4"} },
+	{ "rr_pco_use rpu_flags", EXISTS, ICMP6_H, "rr_pco_use",
+		"rpu_flags", "12", {"4"} },
+	{ "rr_pco_use rpu_prefix", EXISTS, ICMP6_H, "rr_pco_use",
+		"rpu_prefix", "16", {"sizeof(struct in6_addr)"} },
+	{ "ICMP6_RR_PCOUSE_RAFLAGS_ONLINK", VALUE, ICMP6_H,
+		"ICMP6_RR_PCOUSE_RAFLAGS_ONLINK", NULL, NULL, {"0x20"} },
+	{ "ICMP6_RR_PCOUSE_RAFLAGS_AUTO", VALUE, ICMP6_H,
+		"ICMP6_RR_PCOUSE_RAFLAGS_AUTO", NULL, NULL, {"0x10"} },
+	{ "ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME", VALUE, ICMP6_H,
+		"ICMP6_RR_PCOUSE_FLAGS_DECRVLTIME", NULL, NULL,
+		{"htonl(0x80000000)"} },
+	{ "ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME", VALUE, ICMP6_H,
+		"ICMP6_RR_PCOUSE_FLAGS_DECRPLTIME", NULL, NULL,
+		{"htonl(0x40000000)"} },
+	{ "rr_result rrr_flags", EXISTS, ICMP6_H, "rr_result",
+		"rrr_flags", "0", {"2"} },
+	{ "rr_result rrr_ordinal", EXISTS, ICMP6_H, "rr_result",
+		"rrr_ordinal", "2", {"1"} },
+	{ "rr_result rrr_matchedlen", EXISTS, ICMP6_H, "rr_result",
+		"rrr_matchedlen", "3", {"1"} },
+	{ "rr_result rrr_ifid", EXISTS, ICMP6_H, "rr_result",
+		"rrr_ifid", "4", {"4"} },
+	{ "rr_result rrr_prefix", EXISTS, ICMP6_H, "rr_result",
+		"rrr_prefix", "8", {"sizeof(struct in6_addr)"} },
+	{ "ICMP6_RR_RESULT_FLAGS_OOB", VALUE, ICMP6_H,
+		"ICMP6_RR_RESULT_FLAGS_OOB", NULL, NULL,
+		{"htons(0x0002)"} },
+	{ "ICMP6_RR_RESULT_FLAGS_FORBIDDEN", VALUE, ICMP6_H,
+		"ICMP6_RR_RESULT_FLAGS_FORBIDDEN", NULL, NULL,
+		{"htons(0x0001)"} },
+};
+
+static void setup(void);
+static void cleanup(void);
+static void do_test(const struct ftent *);
+
+char *TCID = "asapi_03";
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
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			do_test(&ftab[i]);
 	}
 
 	cleanup();
-
 	tst_exit();
 }
 
 void setup(void)
 {
-	TEST_PAUSE;		/* if -P option specified */
+	TEST_PAUSE;
 }
 
 void cleanup(void)
 {
 	TEST_CLEANUP;
 }
+
+void do_test(const struct ftent *ftptr)
+{
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
+}
-- 
1.9.3


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
