From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Apr 2016 13:45:59 +0200
Subject: [LTP] [PATCH] waitpid/waitpid11: break test if fork() failed
In-Reply-To: <20160415080859.GA26131@localhost.localdomain>
References: <20160415080859.GA26131@localhost.localdomain>
Message-ID: <20160420114558.GA940@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static int fail;
> +static int fork_kid_pid[MAXKIDS]; 
                                    ^
				    Trailing whitespace.
				    Please make sure not to add these.

I've also removed the call to cleanup() on line 104 in the test parent
since the whole test is done in it's child and the cleanup is done in
the child as well.

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
