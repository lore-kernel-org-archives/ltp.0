Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1MIYAx-0005nr-I4
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:18:23 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MIYAw-00079o-Hp
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 01:18:23 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 6E0BD100C5E70
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Jun 2009 02:55:34 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #277) id 1MIXos-0002gd-00
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2009 02:55:34 +0200
Date: Tue, 09 Jun 2009 00:14:10 +0200
From: "Jiri Palecek >" <"<jirka"@suse.de>(none)
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.uvwibctclwynca@debian>
Subject: [LTP] [PATCH] Add test environment variables (TCID et al.) to
 tpm_version_tests.sh
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20090608221410.JK0vYVpobx3ikDcAG3aMeCEUqGVzdXStgrF_fNHI4Jg@z>

Hello,

this patch adds variables needed for tst_* routines into the tpm_version_tests.sh

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../tpm-tools/tpm/tpm_version/tpm_version_tests.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh b/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
index 0fb54cd..dd2e5b9 100755
--- a/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
+++ b/testcases/commands/tpm-tools/tpm/tpm_version/tpm_version_tests.sh
@@ -17,6 +17,10 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
+export TCID=tpm_version
+export TST_TOTAL=1
+export TST_COUNT=1
+
 setup()
 {
 	RC=0				# Return code from commands.
-- 
1.6.3.1




------------------------------------------------------------------------------
Are you an open source citizen? Join us for the Open Source Bridge conference!
Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
Need another reason to go? 24-hour hacker lounge. Register today!
http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
