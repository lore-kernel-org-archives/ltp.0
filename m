Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YGW76-0003gR-43
	for ltp-list@lists.sourceforge.net; Wed, 28 Jan 2015 17:09:12 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id B1C22ADE5
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Jan 2015 17:09:01 +0000 (UTC)
Date: Wed, 28 Jan 2015 18:09:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150128170859.GA27612@rei.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [RFC] usctest cleanup
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

Hi!
I'm investigating usefullnes of the few macros that are in the usctest.h
header.

The TEST_CLEANUP does nothing unless the test gets -e parameter, which
does not happen by default anyway.

And even if the the option is passed it does not work unless the test
sets expected errnos with TEST_EXP_ENOS() and logs errnos from the calls
with TEST_ERROR_LOG(), which seems to be the case only for about 250 out
of the thousands testcases we have.

And even if the code would have been working the usefulness is
questionable. The errno values are checked troughly in the testcases and
there is no need to print a summary at the test exit.

So unless anybody objects I would like to remove these three macros.

Then there is a TEST_PAUSE macro that expands to usc_global_setup_hook()
and which is used in nearly all setup functions. What it does it stop
the test in the setup in pause() waiting for SIGUSR1 if option -p has
been passed to the test and can change the program break with the
sbrk(). Has anyone ever used that or we can remove that as well?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
