Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1WPzk8-0008EC-7O
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 19:32:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WPzk7-000354-0U
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 19:32:08 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2IJW0DM001032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Mar 2014 15:32:00 -0400
Received: from tarantula.localdomain (ovpn-113-111.phx2.redhat.com
	[10.3.113.111])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id s2IJVvou010338
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Mar 2014 15:31:58 -0400
Date: Tue, 18 Mar 2014 14:31:56 -0500
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20140318193156.GD15827@tarantula.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] update ffsb autotools files for aarch64
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

The autotools files for ffsb -- utils/ffsb-6.0-rc2/config.guess and
utils/ffsb-6.0-rc2/config.sub -- do not understand aarch64 and it fails
to build:

=======================================================================
...
make[1]: Entering directory `.../ltp-full-20140115/utils'
cd ffsb-6.0-rc2; ./configure
checking for a BSD-compatible install... /usr/bin/install -c
checking whether build environment is sane... yes
checking for a thread-safe mkdir -p... /usr/bin/mkdir -p
checking for gawk... gawk
checking whether make sets $(MAKE)... yes
checking build system type... ./config.guess: unable to guess system type

This script, last modified 2009-08-19, has failed to recognize
the operating system you are using. It is advised that you
download the most up to date version of the config scripts from

  http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD
and
  http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD
...
=======================================================================


Updating to the latest config.{guess,sub} files from gnu.org does
indeed fix the problem.

I could attach a patch, but it's nearly 50 KiB and really not very
interesting.  Could someone with commit rights update the autotools
files?

Thanks!
Jeff Bastian

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
