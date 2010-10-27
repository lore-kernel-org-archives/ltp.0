Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PB5Li-0007rk-Eu
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 12:43:26 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB5Le-0000Wh-8F
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 12:43:24 +0000
Received: by gwaa11 with SMTP id a11so345113gwa.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 05:43:17 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 13:43:16 +0100
Message-ID: <AANLkTinKu3Kx0FMdgvvG34rc6tcv4Wt5qV1jaAnGzHnv@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] Realtime tests on embedded target
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

Hi all,

I've managed to get to the point where I should be able to run the
realtime tests on my target but there are a few issues :

1) The run script "testscripts/test_realtime.sh" sources
"$LTPROOT/testcases/realtime/scripts/setenv.sh" - this isn't copied by
make install.

2) After manually copying in, "setenv.sh" sets up paths to use test
definitions under "$LTPROOT/testcases/realtime/" - these aren't copied
by make install either.

3 ) Generally we now have a bit of a pain as various scripts now try
to invoke "make" - I think this should really only be a build-time
thing and not part of the test run scritps? Is this actually necessary
as most embedded targets aren't likely to have local make/gcc! I've
commented them out for now for initial testing...

4) After copying in the whole of "testcases/realtime" I run a
run_auto.sh script (sched_jitter/run_auto.sh) this fails as it's
looking for the executable in its working dir (I guess where the
scripts make pass would have put it). However, the previous build and
make install put all the executables in $LTPROOT/testcases/bin as
you'd expect.

I'd be happy to address & submit changes but these are significant
changes to make so it would make sense to check with stake-holders
first if anyone's aware or looking at this actively?

Cheers,

~Pev

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
