From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Nov 2020 14:09:56 +0100
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <20201113202828.GA2229@pevik>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
 <20201113202828.GA2229@pevik>
Message-ID: <20201119130956.GD12628@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> FYI I plan to send a patchset which runs tests in lib/newlib_tests/.
> First I thought simple check for 0 would be ok, but with non-zero results it
> might be good to not only check expected return value but maybe for whole
> output (the same approach we have unfinished in patchset from Christian Lanig).

That has to be indeed done, since many of these tests have no way how to
check if the call to test library had done what it should have.

-- 
Cyril Hrubis
chrubis@suse.cz
