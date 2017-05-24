From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 May 2017 15:05:02 +0200
Subject: [LTP] [PATCH] numa: fix memhog fails in test8
In-Reply-To: <20170524021627.8366-1-liwang@redhat.com>
References: <20170524021627.8366-1-liwang@redhat.com>
Message-ID: <20170524130502.GB13101@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> memhog test fails on first iteration (when the memhog binary is not
> in the page cache) because the test script runs too fast and looks
> at the statistics even befor the memmhog binary has a chance to run.
> 
> In this patch, just redirectiong the output to a file and then checking
> the content in the script in a loop.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
