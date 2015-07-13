Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZEbE8-0001cu-3u
	for ltp-list@lists.sourceforge.net; Mon, 13 Jul 2015 10:44:48 +0000
Date: Mon, 13 Jul 2015 12:43:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150713104302.GB2900@rei.suse.de>
References: <BLU436-SMTP2533A9350B9BD99FA2EE294CF9C0@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BLU436-SMTP2533A9350B9BD99FA2EE294CF9C0@phx.gbl>
Subject: Re: [LTP] Purpose of fsync02
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
To: Rock Lee <rocklee_104@outlook.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 	I used ltp to test my linux OS.Sometimes, I get "fsync took too long" 
> error.Then I read fsync02 description -- Create a sparse file, fsync it, 
> and time the fsync, but I don't know what is the purpose to do this, Any 
> ideas or pointers would be greatly appreciated.

Looks like the testcase tries to assert that fsync() finishes in
reasonable time. Which is 120 seconds and if I'm right the amout of data
it writes to the file is about 8MB and that seems to be fairly
reasonable unless you system is under heavy load.

One of the problems may be that it uses BUFSIZ for the size of the
buffer, which is defined in my glibc to 8192, if that constant is
defined substantially larger on your system the test may easily fail.

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
