From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jun 2018 17:22:28 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix check for $TST_DEVICE
In-Reply-To: <20180629134945.GA13958@rei>
References: <20180628122944.3373-1-pvorel@suse.cz> <20180629134945.GA13958@rei>
Message-ID: <20180629152228.g4cjr2jbir2upf5u@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, 
> Hi!
> > When tst_device acquire call fails, it outputs into stdout,
> > therefore the content is actually help message.
> > => Check for file presence rather than variable not being empty.

> > Fixes: c5ac5d712 tst_test.sh: Make use of tst_device helper

> Good catch, I guess that it also wouldn't harm if we changed the helper
> to print the help message to stderr as well.

Pushed, with your Suggested-by:


Kind regards,
Petr
