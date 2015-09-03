Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZXSUw-00089V-Sg
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2015 11:16:06 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZXSUv-000744-Kq
	for ltp-list@lists.sourceforge.net; Thu, 03 Sep 2015 11:16:06 +0000
Date: Thu, 3 Sep 2015 13:15:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150903111522.GA24962@rei.suse.cz>
References: <CANKSX+FjoktkpNQ4tRkEKLv_XKuDHF57-TaO13bs2wYAJDcQiw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANKSX+FjoktkpNQ4tRkEKLv_XKuDHF57-TaO13bs2wYAJDcQiw@mail.gmail.com>
Subject: Re: [LTP] Syscall/io_* tests failing to compile
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
To: "$rik@nth " <srikanth007m@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am seeing below errors while compiling syscalls from the latest
> available LTP tar ball from sourceforge. My system is having latest
> libaio-dev library as well.
> 
> the same issue even observed for other io syscalls(io_getevents etc..)
> as well. Do i need to setup any other environment to compile it
> successfully.
> 
> /usr/bin/arm-linux-gnueabihf-gcc -static -g -O2 -fno-strict-aliasing
> -pipe -Wall -W -static -Wold-style-definition
> -I/home/LTP/ltp-full-20150420/testcases/kernel/include
> -I../../../../include -I../../../../include -static -pthread
> -L../../../../lib  io_destroy01.c   -lltp  -o io_destroy01
> /tmp/cc0f3RO7.o: In function `main':
> /home/LTP/ltp-full-20150420/testcases/kernel/syscalls/io_destroy/io_destroy01.c:77:
> undefined reference to `io_destroy'
> collect2: ld returned 1 exit status
> make: *** [io_destroy01] Error 1

The -laio is missing from the command line, but since you are seeing the
failure the HAVE_LIBAIO_H must be defined in config.h.

So it's looks like you have hand edited config.h (which is wrong thing
to do) after installing the library instead of reruning configure.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
