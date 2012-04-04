Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFIkx-0005nk-Fw
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:27:43 +0000
Received: from mail-pz0-f46.google.com ([209.85.210.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFIkw-00041W-Pc
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 05:27:43 +0000
Received: by dadz9 with SMTP id z9so552504dad.33
	for <ltp-list@lists.sourceforge.net>;
	Tue, 03 Apr 2012 22:27:37 -0700 (PDT)
Date: Tue, 3 Apr 2012 22:23:43 -0700 (PDT)
From: Garrett Cooper <yanegomi@gmail.com>
Message-ID: <alpine.BSF.2.00.1204032222300.25027@toaster.local>
MIME-Version: 1.0
Subject: [LTP] [PATCH 0/4] Replace commonly used perl tools with awk
	equivalents
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

The intent behind these changes are to remove unnecessary perl
dependencies in LTP by using awk in its stead. It was something that was
discussed a while ago on ltp-list@.

Garrett Cooper (4):
   Replace create_valgrind_check.pl with an awk equivalent
   Install .awk files
   Replace create_dmesg_entries_for_each_test.pl with an awk equivalent
   Replace create_kernel_faults_in_loops_and_probability.pl with an awk
     equivalent

  runltp                                             |   50 +++++----
  tools/Makefile                                     |    2 +-
  tools/create_dmesg_entries_for_each_test.awk       |   32 ++++++
  tools/create_dmesg_entries_for_each_test.pl        |   74 --------------
  ...eate_kernel_faults_in_loops_and_probability.awk |   40 ++++++++
  ...reate_kernel_faults_in_loops_and_probability.pl |  100 ------------------
  tools/create_valgrind_check.awk                    |   42 ++++++++
  tools/create_valgrind_check.pl                     |  106 --------------------
  8 files changed, 146 insertions(+), 300 deletions(-)
  create mode 100644 tools/create_dmesg_entries_for_each_test.awk
  delete mode 100644 tools/create_dmesg_entries_for_each_test.pl
  create mode 100644 tools/create_kernel_faults_in_loops_and_probability.awk
  delete mode 100755 tools/create_kernel_faults_in_loops_and_probability.pl
  create mode 100644 tools/create_valgrind_check.awk
  delete mode 100755 tools/create_valgrind_check.pl

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
