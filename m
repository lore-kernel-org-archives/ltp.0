From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Sep 2019 17:33:57 +0200
Subject: [LTP] [PATCH v4 1/2] capability: Introduce capability API
In-Reply-To: <878squlvhl.fsf@rpws.prws.suse.cz>
References: <20190823094621.21747-1-rpalethorpe@suse.com>
 <20190904121147.26027-1-rpalethorpe@suse.com>
 <20190911144107.GA23680@rei.lan> <878squlvhl.fsf@rpws.prws.suse.cz>
Message-ID: <20190911153356.GA24362@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> OK
> 
> Thanks a bunch!

Pushed, thanks.

I've also updated the comments to match the code, i.e. tst_cap_action()
works only on a single capability and it's the tst_cap_setup() that does
the loop over the array.

-- 
Cyril Hrubis
chrubis@suse.cz
