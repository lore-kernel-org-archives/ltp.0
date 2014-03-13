Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liljegren.mats2@gmail.com>) id 1WO2pb-0004sE-Sz
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 10:25:43 +0000
Received: from mail-lb0-f181.google.com ([209.85.217.181])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WO2pa-00033j-2Y
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 10:25:43 +0000
Received: by mail-lb0-f181.google.com with SMTP id c11so516719lbj.26
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Mar 2014 03:25:35 -0700 (PDT)
Received: from [172.16.141.156] (sestofw01.enea.se. [192.36.1.252])
	by mx.google.com with ESMTPSA id x4sm1879691lbn.2.2014.03.13.03.25.34
	for <ltp-list@lists.sourceforge.net>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 13 Mar 2014 03:25:34 -0700 (PDT)
Message-ID: <53218783.6020200@gmail.com>
Date: Thu, 13 Mar 2014 11:25:07 +0100
From: Mats Liljegren <liljegren.mats2@gmail.com>
MIME-Version: 1.0
Subject: [LTP] Versioned files modified by build
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
To: Linux Test Project General Discussions <ltp-list@lists.sourceforge.net>

After building in-tree (GIT), I get the following when issuing "git 
status" command:

# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working 
directory)
#
#       modified:   utils/ffsb-6.0-rc2/config.h.in
#       modified:   utils/ffsb-6.0-rc2/configure
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       testcases/kernel/io/stress_floppy/1000K_file
#       testcases/kernel/io/stress_floppy/100K_file
#       testcases/kernel/io/stress_floppy/10K_file
#       testcases/kernel/io/stress_floppy/dumpdir/

This would suggest that the files utils/ffsb-6.0-rc2/config.h.in and 
utils/ffsb-6.0-rc2/configure are version controlled. Are they supposed to?

Should above untracked files be added to .gitignore?

Or am I supposed to build somewhere else?

Regards
Mats Liljegren

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
