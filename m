From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Apr 2016 18:44:16 +0200
Subject: [LTP] [PATCH] clone/clone07: only kill child if clone()
	succeeded
In-Reply-To: <20160414084633.GA16717@localhost.localdomain>
References: <20160414084633.GA16717@localhost.localdomain>
Message-ID: <20160419164416.GD21282@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void cleanup(void)
>  {
> -	kill(child_pid, SIGKILL);
> +	if (child_pid > 0)
> +		kill(child_pid, SIGKILL);
>  }

Looking at the code, the child does just return 0 (which exits the child
process). There is no need to kill the child_pid in cleanup at all. So
I've removed the cleanup function and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
