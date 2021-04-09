From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 9 Apr 2021 17:34:17 +0300
Subject: [LTP] [PATCH v3 3/3] syscalls/semctl01: Convert into new api
 1)Use SAFE MACRO 2)Remove useless macro and UCLINUX 3)Use IPC_PRIVATE
 instead of key
In-Reply-To: <1617969305-2237-3-git-send-email-xuyang2018.jy@fujitsu.com>
References: <YHAoQooWArsl2rgD@yuki>
 <1617969305-2237-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1617969305-2237-3-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <d1c91207-35eb-402f-566c-1289ba2c786a@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09.04.2021 14:55, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
...
>  
> -	TST_CHECKPOINT_INIT(tst_rmdir);
> +static void verify_semctl(unsigned int n)
> +{
> +	struct tcases *tc = &tests[n];
> +	int rval;
> +
> +	if (sem_id == -1)
> +		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
> +	if (tc->func_setup != NULL) {

if (tc->func_setup)

> +		switch (tc->cmd) {
> +		case GETNCNT:
> +			tc->func_setup(-1);
> +			break;
> +		case GETZCNT:
> +			tc->func_setup(0);
> +			break;
> +		default:
> +			tc->func_setup();
> +			break;
> +		}
> +	}
>  
> -	/* get an IPC resource key */
> -	semkey = getipckey();
> +	rval = SAFE_SEMCTL(*(tc->semid), tc->semnum, tc->cmd, tc->arg);
> +	switch (tc->cmd) {
> +	case GETNCNT:
> +	case GETZCNT:
> +	case GETPID:
> +	case GETVAL:
> +	case IPC_INFO:
> +	case SEM_STAT:
> +		(*tc->func_test)(rval);

Can be the same as with func_setup() above, i.e. tc->func_test(rval)

> +		break;
> +	default:
> +		(*tc->func_test)();

And here

> +		break;
> +	}
>  
> -	/* create a semaphore set with read and alter permissions */
> -	sem_id_1 = semget(semkey, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
> -	if (sem_id_1 == -1)
> -		tst_brkm(TBROK, cleanup, "couldn't create semaphore in setup");
> +	if (tc->cmd == GETNCNT || tc->cmd == GETZCNT)
> +		kill_all_children();
>  }
>  
> -void cleanup(void)
> +static void setup(void)
>  {
> -	/* if it exists, remove the semaphore resource */
> -	rm_sema(sem_id_1);
> +	sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
> +}

setup() is redundant now, we have the same in verify_semctl().

>  
> -	tst_rmdir();
> +static void cleanup(void)
> +{
> +	if (sem_id >= 0)
> +		SAFE_SEMCTL(sem_id, 0, IPC_RMID);
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_semctl,
> +	.tcnt = ARRAY_SIZE(tests),
> +	.forks_child = 1,
> +};
> 

For the rest:

Reviewed-by: Alexey Kodanev <alexey.kodanev@oracle.com>
