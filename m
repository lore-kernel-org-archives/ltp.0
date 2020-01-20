From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Jan 2020 13:29:07 +0100
Subject: [LTP] [PATCH 1/1] tst_device.h: Use <sys/syscall.h> and
 fallback to sync()
In-Reply-To: <20200120105441.19418-1-pvorel@suse.cz>
References: <20200120105441.19418-1-pvorel@suse.cz>
Message-ID: <20200120122907.GB21132@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I would rather fix the socketcall tests, I do not thing that anything
else would break.

-- 
Cyril Hrubis
chrubis@suse.cz
