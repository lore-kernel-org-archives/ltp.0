From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Oct 2015 15:48:59 +0100
Subject: [LTP] [PATCH] Cleanup syscalls/flock test messages
In-Reply-To: <20151024103612.GA29118@issan.sis.pasteur.fr>
References: <20151024103612.GA29118@issan.sis.pasteur.fr>
Message-ID: <20151026144859.GB6059@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Please find a small patch that cleanup flock(2) syscalls tests to use
> TTERRNO/TERRNO in messages instead of home made versions with
> TEST_ERRNO/errno.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
