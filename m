From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Apr 2016 17:42:45 +0200
Subject: [LTP] [PATCH] ptrace/ptrace05: preventing kill other processes
 if fork failed
In-Reply-To: <20160412131905.GD17476@localhost.localdomain>
References: <20160412030734.GA11627@localhost.localdomain>
 <20160412100858.GC24915@rei.lan>
 <20160412131905.GD17476@localhost.localdomain>
Message-ID: <20160412154245.GA2917@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If fork failed, we should try next signum. Or the kill(-1, 9) on line
> 196 will kill a lot of processes.

I've shortened the error message a bit and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
