From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 21:28:28 +0100
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <20201113131428.13199-2-chrubis@suse.cz>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
Message-ID: <20201113202828.GA2229@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> In order to simplify common return value checks.

Great improvement, thanks!

The only concern I have is for tests which does not end 0
as it's not obvious from the output (without looking into the test source)
that everything it's working, but not a big deal.

FYI I plan to send a patchset which runs tests in lib/newlib_tests/.
First I thought simple check for 0 would be ok, but with non-zero results it
might be good to not only check expected return value but maybe for whole
output (the same approach we have unfinished in patchset from Christian Lanig).

Kind regards,
Petr
