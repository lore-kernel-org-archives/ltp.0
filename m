From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 9 Mar 2017 17:03:13 +0100
Subject: [LTP] [PATCH 1/1] gitignore: add gitignore for posix and
 realtime test suites
In-Reply-To: <20170308165105.3981-1-pvorel@suse.cz>
References: <20170308165105.3981-1-pvorel@suse.cz>
Message-ID: <20170309160313.GA17980@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> These are needed, when configured with non-default
> --with-open-posix-testsuite --with-realtime-testsuite switches.

There a few empty files added there, can you fix that? Otherwise it
looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz
