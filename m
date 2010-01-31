Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NbUhJ-0007eN-Ks
	for ltp-list@lists.sourceforge.net; Sun, 31 Jan 2010 07:58:21 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NbUhI-0004NA-Mw
	for ltp-list@lists.sourceforge.net; Sun, 31 Jan 2010 07:58:21 +0000
Received: by pxi38 with SMTP id 38so3028527pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 30 Jan 2010 23:58:14 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 30 Jan 2010 23:58:14 -0800
Message-ID: <364299f41001302358m15143b1flc2f64ba5ea0d620a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] LTP build test scripts now available
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>, =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi folks,
    I'm asking that anyone who is interested in helping out LTP please
contribute by testing with the testscripts/build scripts on a
semi-regular basis:

.../testscripts/build/test_install_in_build_tree.sh
.../testscripts/build/test_install_out_of_build_tree.sh
.../testscripts/build/test_out_of_build_tree.sh

    I've added these scripts for three identified common fetch ->
build -> test scenarios:

    1. Install in source tree.
    2. Install out of build tree, but build in source tree.
    3. Install out of build tree, build in source tree.

    They all assume that the end-user has access to CVS today, but
that can be tailored to meet other needs [in the future].
    What I'm requesting:
    1. I would appreciate the feedback.
    2. In order to ensure build integrity and compatibility obtaining
a profile of common distro configurations (kernel configs, build
tools, etc) so I can better tailor the tests to find known build and
configuration issues before other folks do by accident would be
helpful. If I could obtain access to distro ISOs that aren't mirrored
anymore (with binary packages to install the tools from), that would
make my life a lot easier.
    Please CC me the results so I can analyze this and improve the
overall end-to-end process.
Thanks,
-Garrett

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
