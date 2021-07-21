From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Jul 2021 17:33:15 +0200
Subject: [LTP] [PATCH v4 3/5] syscalls/msgstress02: Convert into new api
In-Reply-To: <1615550541-21714-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20201111163114.GB23576@yuki.lan>
 <1615550541-21714-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1615550541-21714-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <YPg+O2s0y/uUWiS7@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Generally looks much better, comments inline.

> -static int dotest(key_t key, int child_process)
> +static void dotest(key_t key, int child_process, int id)
>  {
> -	int id, pid;
> -	int i, count, status, exit_status;
> -
> -	sighold(SIGTERM);
> -	if ((id = msgget(key, IPC_CREAT | S_IRUSR | S_IWUSR)) < 0) {
> -		printf("msgget() error in child %d: %s\n",
> -			child_process, strerror(errno));
> -		return FAIL;
> -	}
> -	tid = id;
> -	sigrelse(SIGTERM);
> -
> -	exit_status = PASS;
> +	int pid, i, count;
>  
>  	for (i = 0; i < nkids; i++) {
> -		fflush(stdout);
> -		if ((pid = FORK_OR_VFORK()) < 0) {
> -			printf("Fork failure in the first child of child group %d\n",
> +		pid = fork();

Why don't we use SAFE_FORK() here as well?

I guess that the main point is to make sure that we cleanup the message
queueus that would otherwise stayed on the system.

...

> +	SAFE_SIGNAL(SIGTERM, SIG_IGN);

And here as well, I do not get why we ignore SIGTERM at all.

-- 
Cyril Hrubis
chrubis@suse.cz
