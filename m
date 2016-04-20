From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Apr 2016 15:02:07 +0200
Subject: [LTP] [PATCH] mtest01/mtest01: break test if fork failed
In-Reply-To: <20160415080942.GA26368@localhost.localdomain>
References: <20160415080942.GA26368@localhost.localdomain>
Message-ID: <20160420130206.GB940@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	while (pid_list[i] > 0) {
> +		kill(pid_list[i], 9);
                                  ^
	I've changed this back to SIGKILL and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
