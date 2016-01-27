From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jan 2016 14:22:05 +0100
Subject: [LTP] [PATCH] kernel/syscalls: add new test with 'open() +
 O_TMPFILE'
In-Reply-To: <56A8B1ED.3080205@oracle.com>
References: <1451471611-17666-1-git-send-email-alexey.kodanev@oracle.com>
 <20160126162442.GA21691@rei.lan> <56A8B1ED.3080205@oracle.com>
Message-ID: <20160127132205.GA29474@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> +static int dir_not_empty(void)
> >> +{
> >> +	struct dirent *entry;
> >> +	DIR *dir = SAFE_OPENDIR(cleanup, test_dir);
> >> +	int ret = 0;
> >> +
> >> +	while ((entry = SAFE_READDIR(cleanup, dir)) != NULL) {
> >> +		const char *file = entry->d_name;
> >> +
> >> +		if (!strcmp(file, "..") || !strcmp(file, "."))
> >> +			continue;
> >> +
> >> +		tst_resm(TINFO, "found a file: %s", file);
> >> +		ret = 1;
> >> +		break;
> >> +	}
> >> +
> >> +	SAFE_CLOSEDIR(cleanup, dir);
> >> +	return ret;
> >> +}
> > Maybe we should add this function to a library, since it's used at two
> > places allready.
> 
> OK, tst_dir_is_empty(dir) is fine?

Fine with me.

-- 
Cyril Hrubis
chrubis@suse.cz
