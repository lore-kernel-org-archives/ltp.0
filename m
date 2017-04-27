From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 27 Apr 2017 15:56:32 +0200
Subject: [LTP] LTP release
In-Reply-To: <20170424162534.GA13616@rei.lan>
References: <20170424162534.GA13616@rei.lan>
Message-ID: <20170427155632.567dfd49@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

On Mon, 24 Apr 2017 18:25:34 +0200
"Cyril Hrubis" <chrubis@suse.cz> wrote:

> Hi!
> It's about a time we should prepare for another release, hence as
> usuall, lets start with pointing out any patches that should be part of
> it and I would like to start with pre-release testing at the end of this
> week. Does that sound OK to everyone?
> 

On a slightly different subject, I am thinking that as soon as possible after
this release we merge the m32 and CVE patches into master? Then we can
probably include them in the next release.

There are now 8 CVE tests and a small library for reproducing race conditions
in my dev branch. I am going to organise them into a single clean patch set
for review before writing any more.

Thank you,
Richard.

