Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VQdx8-0002KT-PX
	for ltp-list@lists.sourceforge.net; Mon, 30 Sep 2013 13:55:58 +0000
Date: Mon, 30 Sep 2013 15:56:21 +0200
From: chrubis@suse.cz
Message-ID: <20130930135621.GA4341@rei.suse.cz>
References: <CAK67bL8u742otAZLwk9u8_EBJ6hoW31iEgWx8eWtpxLZB0GoBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK67bL8u742otAZLwk9u8_EBJ6hoW31iEgWx8eWtpxLZB0GoBQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Unzip command validation irrespective of verbose
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
To: siva sankar padhy <padhy.sivasankar@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I have faced a problem while running unzip test case on my ARM board.
> I am using* ltp-full-20130904 release.*
> As i observed the unzip test case is failing due to mismatch in the verbose
> message.
> test case expects "extracting" but on my board the unzip binary shows
> "inflating"
> So  this is a patch for* unzip_file.zip.*This checks the created directory
> structure rather than verbose message.
> 
> This is my first patch. So please regret for any wrong formatting of make
> the patch review. :)

Still the same problem as the last time, long lines have been wrapped by
your mailing client which corrupted the patch.

Try any of:

1) Disable line wrapping in your mail client
2) Attach the patch as an attachement
3) Configure and use 'git send-email' and send you patches via git

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
