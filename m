From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Jun 2017 15:51:06 +0200
Subject: [LTP] [PATCH 0/2] ltp: update add_key tests for nonempty NULL
 payload fix
In-Reply-To: <20170606170425.GA88445@gmail.com>
References: <20170605174811.95267-1-ebiggers3@gmail.com>
 <20170606114416.GA5208@rei> <20170606170425.GA88445@gmail.com>
Message-ID: <20170607135106.GC26322@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Personally, I don't align quite as strongly with that viewpoint (and maybe you
> and the other LTP developers don't either) because this can, after all, only be
> a problem in cases where the test suite is upgraded, and furthermore if a test
> fails it's helpful to 'git log' the test anyway.
> 
> Would you suggest I simply update add_key02 instead?

Yes, I would have done that as well.

-- 
Cyril Hrubis
chrubis@suse.cz
