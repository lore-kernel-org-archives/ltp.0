From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Apr 2016 13:34:07 +0200
Subject: [LTP] [PATCH] waitpid/waitpid03: break test if fork failed
In-Reply-To: <20160414030928.GG17476@localhost.localdomain>
References: <20160412132256.GA7441@localhost.localdomain>
 <20160412155230.GB2917@rei.suse.cz>
 <20160413065818.GF17476@localhost.localdomain>
 <20160413125535.GF10941@rei.lan>
 <20160414030928.GG17476@localhost.localdomain>
Message-ID: <20160419113407.GA14360@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	while (ikids-- > 1)
> +		kill(pid[ikids], 9);

I've changed the number to a signal constat i.e. 9 -> SIGKILL and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
