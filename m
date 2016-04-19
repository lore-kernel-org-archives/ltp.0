From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Apr 2016 16:33:54 +0200
Subject: [LTP] [PATCH] fcntl/fcntl17: break test if fork failed
In-Reply-To: <20160414080655.GA10922@localhost.localdomain>
References: <20160414080655.GA10922@localhost.localdomain>
Message-ID: <20160419143354.GB21282@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  		stop_children();
> +		waitpid(child_pid1, &child_stat, 0);
> +		waitpid(child_pid2, &child_stat, 0);
> +		waitpid(child_pid3, &child_stat, 0);
> +		child_pid1 = 0;
> +		child_pid2 = 0;
> +		child_pid3 = 0;

I've moved these lines to the stop_children() function and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
