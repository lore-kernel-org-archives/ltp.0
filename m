Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1N65Je-0007xj-8I
	for ltp-list@lists.sourceforge.net; Thu, 05 Nov 2009 16:36:06 +0000
Received: from relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 666DE90847
	for <ltp-list@lists.sourceforge.net>;
	Thu,  5 Nov 2009 17:35:51 +0100 (CET)
Date: Thu, 5 Nov 2009 17:35:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20091105163550.GC19831@schrodinger.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
Subject: [LTP] [PATCH] fix overflow in growfiles.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Following patch fixes buffer overflow.c.

Signed-off-by: Cyril Hrubis chrubis@suse.cz

-- 
Cyril Hrubis
chrubis@suse.cz

--tKW2IUtsqtDRztdT
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="fix_growfiles_overflow.patch"

Index: delme/testcases/kernel/fs/doio/growfiles.c
===================================================================
--- delme.orig/testcases/kernel/fs/doio/growfiles.c
+++ delme/testcases/kernel/fs/doio/growfiles.c
@@ -390,7 +390,7 @@ int backgrnd = 1;		/* return control to 
 struct stat statbuf;
 int time_iterval = -1;
 time_t start_time;
-char reason[40];		/* reason for loop termination */
+char reason[128];		/* reason for loop termination */
 int num_procs=1;
 int forker_mode=0;
 int reexec=REXEC_INIT;		/* reexec info */

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--tKW2IUtsqtDRztdT--

