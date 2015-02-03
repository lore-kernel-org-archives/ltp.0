Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YIf7I-0005J6-RJ
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 15:10:16 +0000
Date: Tue, 3 Feb 2015 16:10:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150203151002.GA18977@rei.scz.novell.com>
References: <54CB92BC.8020605@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54CB92BC.8020605@redhat.com>
Subject: Re: [LTP] the mandatory (?) nature of testscripts
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
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Hello all,
> I normally execute the ltp suite using runltp with -f, specifying just
> the runtest files I want to execute, possibly even writing my own ones
> and using the fact that runltp detects absolute paths in the comma-
> separated list and looks for them outside /opt/ltp.
> 
> >From this viewpoint, and also looking at things like
> testscripts/syscalls.sh, this approach seems perfectly valid (there's
> at least nothing against it in the documentation, as far as I can tell).
> My impression was therefore that testscripts are just convenient
> (or legacy?) ways to run big chunks of the suite.

They are there from a times before current maintainers took over the
project. At that time the CVS repository was a dumping ground for
anything that the previous developers found at least a little bit
useful.

As far as I know, there was no architecture decision behind it, no
documentation either.

I simply didn't touched these because I had enough work fixing the
testcases.

I'm all for removing scripts that have no added value, the math.sh and
syscalls.sh looks like an obvious examples. There are likely more of
these, some may be even broken.

> However then I found testscripts/network.sh and all the "mandatory"
> variables it exports - not using it resulted in the ping01 test failing
> due to recent rewrite in cbab2eed06. And, as it turns out, network.sh
> is not alone.
>
> Therefore I would like to ask (since I didn't find this documented);
> is running individual tests via runltp -f something "officially"
> supported and the network tests should be altered to get their defaults
> in another way, or is runltp -f wild west and I'm on my own, with the
> only supported way to run the suite being the testscripts?

Well at the time the runltp is the supported way to run the testcases.
(Although I'm still dreaming of writing a better test driver instead of
the runltp and ltp-pan combination.) Or a more straight answer is that
this is the script I care about. Ideally the network parameters would be
handled somehow in the script, the same way the loop devices are, but
that haven't been done.

Also the mantra I'm repeating here over and over is to make the
testcases as self contained as possible. For the network testcases we
have to pass the the remove host and a few more parameters somehow, but
apart from that, it should just work fine.

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
