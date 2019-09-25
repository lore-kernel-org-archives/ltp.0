From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Sep 2019 13:22:36 +0200
Subject: [LTP] LTP Release
In-Reply-To: <20190906130707.GA7515@rei.lan>
References: <20190906130707.GA7515@rei.lan>
Message-ID: <20190925112236.GA17496@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I did a few testruns and so far it looks good.

I've send one patch for acct02, which is mostly cosmetic, that I would
like to get merged.

I would still consider merging the eBPF regression test, does anybody
have a strong opinion on this?

Apart from this preadv203 sometimes fails to trigger EAGAIN on virtual
machines, but I doubt we can fix this before the release, I will try to
do so later on.

The rest seems to be good, i.e. failures does not seem to be bugs in
tests.

What is the status from rest of you? Is there anything that should be
considered for the release? Is something failing unexpectedly?

-- 
Cyril Hrubis
chrubis@suse.cz
