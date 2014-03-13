Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liljegren.mats2@gmail.com>) id 1WO2qr-0004v7-B7
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 10:27:01 +0000
Received: from mail-ee0-f52.google.com ([74.125.83.52])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WO2qq-000378-HT
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 10:27:01 +0000
Received: by mail-ee0-f52.google.com with SMTP id e49so318033eek.39
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Mar 2014 03:26:54 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 13 Mar 2014 11:26:54 +0100
Message-ID: <CA+xJJ1_uSNtC88O4AHdVqQXnr0E56VF-EgOZ=OWKDzLyAqaAvg@mail.gmail.com>
From: Mats Liljegren <liljegren.mats2@gmail.com>
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
#   (use "git checkout -- <file>..." to discard changes in working directory)
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
utils/ffsb-6.0-rc2/configure are version controlled. Are they supposed
to?

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
