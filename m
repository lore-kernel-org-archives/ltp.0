From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 6 Oct 2016 14:38:05 +0200
Subject: [LTP] [PATCH 1/2] llistxattr: added a new testcase to
 llistxattr02
In-Reply-To: <1475755719-17762-2-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1475755719-17762-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1475755719-17762-2-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161006123804.GB10467@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +int longpath_setup(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < PATH_MAX + 2; i++)
> +		longpathname[i] = 'a';
> +
> +	return 0;
> +}

Why don't we just do memset() in the setup()?

memset(longpathname, 'a', sizeof(longpathname) - 1);

Should do the same.

-- 
Cyril Hrubis
chrubis@suse.cz
