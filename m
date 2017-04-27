From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 27 Apr 2017 16:02:05 +0200
Subject: [LTP] LTP release
In-Reply-To: <20170427155632.567dfd49@linux-v3j5>
References: <20170424162534.GA13616@rei.lan>
 <20170427155632.567dfd49@linux-v3j5>
Message-ID: <20170427140205.GD14404@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> On a slightly different subject, I am thinking that as soon as possible after
> this release we merge the m32 and CVE patches into master? Then we can
> probably include them in the next release.

Agreed, I wanted to get them into this release but that would be rushed
at this point.

> There are now 8 CVE tests and a small library for reproducing race conditions
> in my dev branch. I am going to organise them into a single clean patch set
> for review before writing any more.

I will look at these once we are done with the release. So far it looks
good for me. I got only one simple complilation failure (already fixed
in git) and the results from testruns I've done so far looks mostly
good.

-- 
Cyril Hrubis
chrubis@suse.cz
