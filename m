Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPY1k-0005ja-Js
	for ltp-list@lists.sourceforge.net; Mon, 17 Mar 2014 13:56:28 +0000
Date: Mon, 17 Mar 2014 14:56:06 +0100
From: chrubis@suse.cz
Message-ID: <20140317135606.GA1368@rei>
References: <0247700D01F14443B9209F90AD938CC524365A3B@sestoex05.enea.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0247700D01F14443B9209F90AD938CC524365A3B@sestoex05.enea.se>
Subject: Re: [LTP] Design question around ltp-list
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
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I'd like to create a time-boxed test case, i.e. the test will run for
> a certain amount of time and if nothing goes wrong during this time,
> the test passed.
>
> This would also need to be recursive. So when starting my test, it in
> turn will start some test cases to be used as a system load. These
> loads are simple application that will run until killed. My intention
> was to start them using ltp-pan.
>
> So imagine my test case is started with ltp-pan, where a running time
> has been specified. My test case in turn will use ltp-pan to start an
> application that only exits when killed. What will happen when the
> first ltp-pan invocation times out? Will it automatically kill child
> ltp-pan instances, and they in turn kill the load applications?
>
> Or how are you supposed to do such a test case?

LTP testcases are self-contained and does not depend on any test driver
(i.e. ltp-pan). Moreover ltp-pan may be replaced with a better test
driver in the future.

If you need a background load while your test is running you should fork
a child process from the test itself and do the load from the child. The
test is also responsible for cleaning up later.

All that you need to start a LTP test should be executing the binary
(you may need to modify $PATH, set $LTP_DEV etc. but that should be
all). Also note that these are allready set if you are in the middle of
LTP testcase execution.

Also note that you can start a LTP testcase just by doing exec() with
right testname from another testcase (becase all of the test binaries
are in $PATH).

-- 
Cyril Hrubis
chrubis@suse.cz

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
