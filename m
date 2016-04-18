From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 18 Apr 2016 21:15:08 +0200
Subject: [LTP] [PATCH] waitid/waitid01: break test if fork() failed
In-Reply-To: <20160414080425.GA10586@localhost.localdomain>
References: <20160414080425.GA10586@localhost.localdomain>
Message-ID: <20160418191507.GC11649@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Or a lot of processes will be killed when -1 passed as pid to kill().

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
