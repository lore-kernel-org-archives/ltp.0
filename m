From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 22 Jul 2019 14:24:00 +0200
Subject: [LTP] [PATCH v4] timers/timer_create0{2, 3,
 4}: Ported to new library
In-Reply-To: <20190719113721.6285-1-camann@suse.com>
References: <20190719113721.6285-1-camann@suse.com>
Message-ID: <20190722122400.GA13282@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with changes to the timer_create04.c, thanks.

I've changed the timer_create04 not to iterate over all the clock types,
which does not make much sense for invalid input tests and rather than
that I've added a few more invalid tests, I've also made sure that the
we get EINVAL with different parts of the sigev structure filled with
wrong values instead of memseting it to a constant.

-- 
Cyril Hrubis
chrubis@suse.cz
