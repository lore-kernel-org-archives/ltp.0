From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 13 Nov 2018 13:51:44 +0100
Subject: [LTP] [PATCH 1/2] syscalls/rt_sigsuspend01: ignore reserved
 signals
In-Reply-To: <20181109014616.165281-1-smuckle@google.com>
References: <20181109014616.165281-1-smuckle@google.com>
Message-ID: <20181113125144.GB11121@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Looking at the test code it's complete mess, there is quite a lot
useless code as well. Let me clean up that first, I will do that today,
then we can fix it.

-- 
Cyril Hrubis
chrubis@suse.cz
