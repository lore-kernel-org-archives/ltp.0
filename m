From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Oct 2015 15:28:57 +0200
Subject: [LTP] [PATCH v7 2/7] SAFE_MACROS: Add socket(), bind(), listen(),
 connect() and getsockname()
In-Reply-To: <1444214869-3597-2-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1444214869-3597-1-git-send-email-zenglg.jy@cn.fujitsu.com>
 <1444214869-3597-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <20151007132856.GD2608@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +char *ltp_sock_addr(const struct sockaddr *sa, socklen_t salen)
> +{
> +	char portstr[8];
> +	static char str[128];

Also this is not thread safe and the testcases that use these fucntions
run in several threads. Even if the race condition where two threads
write to the str buffer at the same time is unlikely we should rather
change the interface to print the result into user supplied buffer.

So it reads:

char *tst_sock_addr(const struct sockaddr *sa, socklen_t salen,
                    char *res, size_t res_len);


And the caller would just define array and pass it to the function as:


char buf[128];

...
	tst_resm(..., tst_sock_addr(sa, salen, buf, sizeof(buf)), ...);

-- 
Cyril Hrubis
chrubis@suse.cz
