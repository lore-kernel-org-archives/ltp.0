Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WwWLE-00046k-1v
	for ltp-list@lists.sourceforge.net; Mon, 16 Jun 2014 12:48:52 +0000
Date: Mon, 16 Jun 2014 14:48:38 +0200
From: chrubis@suse.cz
Message-ID: <20140616124838.GA17753@rei.suse.cz>
References: <7CF842D49929104A9E5360C8FA9370998CEA4E@POCITMSEXMB03.LntUniverse.com>
	<20140610124815.GA32749@rei.Home>
	<7CF842D49929104A9E5360C8FA9370998CEAC3@POCITMSEXMB03.LntUniverse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7CF842D49929104A9E5360C8FA9370998CEAC3@POCITMSEXMB03.LntUniverse.com>
Subject: Re: [LTP] Request to help in analyzing the failed test cases in LTP
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
To: Ajoymon Joseph <AJOY.JOSEPH@LNTTECHSERVICES.COM>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
>         Thanks for your prompt reply.
> 
> 
>         I want to run LTP on cross platform. Please check whether my test procedure is Wright .
> 
>         1. I cross compiled LTP for my particular machine.
>                 ./configure CC=$compiler
>                 Make
>                 Make DESTDIR=/DirectoryToInstall install

This does not sound 100% correct. The canonical way to cross compile
projects using the configure script is to set the --build and --host,
see:

http://www.gnu.org/software/automake/manual/html_node/Cross_002dCompilation.html

>         2. I tar the Directory and FTP it to the machine on which testing has to be done.
> 
>         3. I ran the LTP scripts(runltp or runltplite) over there and got the results.

This part should work.

> .       For running the test individually I will try running the executable (Command-Line column) as shown in the below link
> 
>                 http://www.lineo.co.jp/ltp/linux-3.10.10-results/result.html
> 
>         Please guide me if I am wrong. I am new to LTP.

Most of the testcases can be just executed as binaries, some needs
additional parameters though, you should check the runtest/* files to
find that out.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
