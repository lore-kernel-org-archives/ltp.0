From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 29 Jun 2018 15:49:46 +0200
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix check for $TST_DEVICE
In-Reply-To: <20180628122944.3373-1-pvorel@suse.cz>
References: <20180628122944.3373-1-pvorel@suse.cz>
Message-ID: <20180629134945.GA13958@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When tst_device acquire call fails, it outputs into stdout,
> therefore the content is actually help message.
> => Check for file presence rather than variable not being empty.
> 
> Fixes: c5ac5d712 tst_test.sh: Make use of tst_device helper

Good catch, I guess that it also wouldn't harm if we changed the helper
to print the help message to stderr as well.

-- 
Cyril Hrubis
chrubis@suse.cz
