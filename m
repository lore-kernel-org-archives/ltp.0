From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Mar 2020 16:22:18 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
In-Reply-To: <20200304151201.19117-1-pvorel@suse.cz>
References: <20200304151201.19117-1-pvorel@suse.cz>
Message-ID: <20200304152218.GA5193@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> SAFE_TIMERFD_CREATE(), SAFE_TIMERFD_GETTIME() and SAFE_TIMERFD_SETTIME()
> 
> Added only to new C API.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

I do have a patch that adds tst_clock_name() to the tst_safe_clocks.h I
will send it so that you can make use of it here as well.

-- 
Cyril Hrubis
chrubis@suse.cz
