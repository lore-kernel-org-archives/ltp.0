Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1OMX01-0008JS-Bd
	for ltp-list@lists.sourceforge.net; Thu, 10 Jun 2010 01:56:05 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OMX00-0002WI-Dg
	for ltp-list@lists.sourceforge.net; Thu, 10 Jun 2010 01:56:05 +0000
Received: by vws11 with SMTP id 11so7455858vws.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 Jun 2010 18:55:58 -0700 (PDT)
MIME-Version: 1.0
From: Henry Yei <hyei@mvista.com>
Date: Wed, 9 Jun 2010 18:30:14 -0700
Message-ID: <AANLkTina6_TBV4b6ky66yrw9QgBVwRHYh8WCRhwENLeb@mail.gmail.com>
Subject: [LTP] [PATCH][runtest/fs] fix issue where growfiles tests still not
	creating temp files in directory specified by TMPDIR as expected
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

Hello,

A previous patch that attempts to force tests to use the TMPDIR env
variable is incomplete. This patch fixes growfiles test arguments in
the fs scenario.

Scripts which use growfiles with command-line file names are not performing the
tests in the expected target directory. When file names are provided on the
growfiles command line, they are taken relative to the cwd and not the -d
auto_dir passed on the command line. This renders many of the test scripts in
runtests ineffective in that the tests are not being performed on the expected
filesystem.

For example, the first line of the fs scenario reads:

gf01 growfiles -B 800000 -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10
glseek20 glseek20.2 -d $TMPDIR

The -d $TMPDIR construct is almost always used in the scripts to point to the
filesystem under test. However, the presence of the
glseek20 glseek20.2 command line parameters constitute full file names from the
test's view, so they will be used as-is (in the current working directory) as
opposed to $TMPDIR/glseek20 or $TMPDIR/glseek20.2 as expected by the script.

To get the desired behavior, here are the key switches:

-f specifies the 'auto_file' which is the base file name (gf is used if it's
missing)

-d specifies the 'auto_dir' to be used ('.' is used if it's missing)

-S specifies the number of 'auto seq' files to be used. These files are of the
form: "%s/%s%d" using auto_dir, auto_file, file_number.


Signed-off-by: Henry Yei <hyei@mvista.com>

------------------------------------------------------------------------------
ThinkGeek and WIRED's GeekDad team up for the Ultimate 
GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the 
lucky parental unit.  See the prize list and enter to win: 
http://p.sf.net/sfu/thinkgeek-promo
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
