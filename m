From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 18:08:35 +0100
Subject: [LTP] [PATCH V2 24/32] rt_sigaction/rt_sigprocmark: Define
 _GNU_SOURCE
In-Reply-To: <1452302060-103643-24-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-24-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202170835.GN19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Fixes musl build failure e.g.
> error: 'SA_NOMASK' undeclared here (not in a function)

Manual states that SA_NOMASK is deprecated synonym for SA_NODEFER. Does
the test work for SA_NODEFER without defining _GNU_SOURCE?

-- 
Cyril Hrubis
chrubis@suse.cz
