Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEdCQ-0004tp-UW
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 12:51:10 +0000
Date: Mon, 13 Jul 2015 14:49:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150713124938.GA6569@rei.suse.de>
References: <CANBXnMk9SoMKBGcuMqxTrgYz5EUkgX6P-gKG7q0NGW2ni_nKHg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANBXnMk9SoMKBGcuMqxTrgYz5EUkgX6P-gKG7q0NGW2ni_nKHg@mail.gmail.com>
Subject: Re: [LTP] LTP newbie
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
To: Adil Mujeeb <mujeeb.adil@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  Following is my understanding:
> 
> 1. my temp directory path not considered which i specified on the command
> line

Looking at the command line you send it should have been -d temp/ and
not just temp/.

> 2. I ask for syscalls test execution, but looks like it is executing
> alltests

The file in /tmp called alltest is created after runtest files are
filtered by the runltp script. So likely the file contained only syscall
testcases. Have you checked?

> 3. No progress message displayed

You passed -q which means quiet.

>  I tried going through documentation but there is no simple example how to
> test a subset of test. Also is there any document which gives the test
> category structure and in each category how many test cases? Can i know how
> many tests cases covered in syscalls?

All testcases are specified in (text) runtest files. Each line is a
testcase that starts with test name (till the first whitespace) and the
rest of the line is command to be executed.

You have several options for running subset of testcases, you can use
the -f option to select list of runtest files to execute, the -s option
to run all testcases whose name is matched by regexp or you can copy and
edit the runtest files supplied by us to fit your needs.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
