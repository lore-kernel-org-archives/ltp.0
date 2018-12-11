From: Eric Biggers <ebiggers@kernel.org>
Date: Tue, 11 Dec 2018 12:52:45 -0800
Subject: [LTP] [PATCH v2 3/3] crypto/crypto_user01.c: new test for
 information leak bug
In-Reply-To: <20181211191543.GA5389@rei>
References: <20181211060317.18698-1-ebiggers@kernel.org>
 <20181211060317.18698-4-ebiggers@kernel.org>
 <20181211123251.GA27346@rei> <20181211184334.GD221175@gmail.com>
 <20181211191543.GA5389@rei>
Message-ID: <20181211205243.GE221175@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

On Tue, Dec 11, 2018 at 08:15:43PM +0100, Cyril Hrubis wrote:
> Hi!
> > No it doesn't really make sense to run a test twice, but this has two associated
> > CVE numbers, resulting in two runs when tests are run by CVE number.  Are you
> > saying you'd prefer that it be listed under just the more recent CVE?  Or are
> > you saying the runtest/cve file will be going away and replaced by something
> > else anyway?
> 
> For now I would just put it under the newer CVE number.
> 
> For a future I would like to be able to export all the metadata from the
> tests to the tesrunner, so the testrunner would know, among other
> things, which tests are associated with CVEs. That, in turn, would
> eliminate the need to maintain various different sets of runtest files.
> 
> But given that I just started to work on that I do not expect it to be
> finished anytime soon.
> 
> Does that sounds reasonable to you?
> 
> Also no need to resent the patchset, I can remove the runtest entry when
> applying the patch.
> 

Yes that sounds reasonable to me, please feel free to just put it under the
newer CVE number.  Thanks!

- Eric
