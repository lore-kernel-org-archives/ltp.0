From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 15:46:11 +0100
Subject: [LTP] [PATCH 2/3] socketcall: TCONF instead of TFAIL when user
 is not root
In-Reply-To: <1478087824-31577-3-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478087824-31577-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1478087824-31577-3-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161102144611.GB28344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> sockatcall01 uses certain protocols that require super user
> privileges.

Right, the RAW socket needs root. You should have included that in the
commit message from the start. Pushed with better commit message, thanks.

Also it took me while to realize that the syscall is not implemented on
x86_64 and that the test returns PASS wrongly instead of CONF. I have
fixed that in another patch as well.

-- 
Cyril Hrubis
chrubis@suse.cz
