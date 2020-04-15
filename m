From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Apr 2020 17:47:31 +0200
Subject: [LTP] [PATCH] Add write()/ioctl() race variant to snd_seq01
In-Reply-To: <20200409113259.27515-1-mdoucha@suse.cz>
References: <20200409113259.27515-1-mdoucha@suse.cz>
Message-ID: <20200415154731.GA21877@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
> index e0f197e74..c3b4b6ac2 100644
> --- a/testcases/kernel/sound/snd_seq01.c
> +++ b/testcases/kernel/sound/snd_seq01.c
> @@ -24,10 +24,27 @@
>  #include "tst_fuzzy_sync.h"
>  #include "tst_taint.h"
>  
> +typedef void (*racefunc_t)(void);
> +
>  static int fd = -1;
>  static int client_id;
> +static struct snd_seq_remove_events rminfo = {
> +	.remove_mode = SNDRV_SEQ_REMOVE_OUTPUT
> +};
> +static struct snd_seq_event ssev = {
> +	.flags = SNDRV_SEQ_TIME_STAMP_TICK | SNDRV_SEQ_TIME_MODE_REL,
> +	.queue = 0,
> +	.type = SNDRV_SEQ_EVENT_USR0,
> +	.time = { .tick = 10 }
> +};
> +
>  static struct tst_fzsync_pair fzsync_pair;
>  
> +static void race_ioctl(void);
> +static void race_write(void);
> +
> +racefunc_t testfunc_list[] = {race_ioctl, race_write};

Can't we just define this as void (*testfuncs[])(void) instead?

There is no point in having a typedef if we don't use the type anywhere
else.

Also why don't decleare the array after the race_* function
implementation? As is it now we do have two more useless lines with
function signatures here.

>  static void setup(void)
>  {
>  	struct snd_seq_queue_info qconf = { .queue = 0 };
> @@ -44,6 +61,7 @@ static void setup(void)
>  
>  	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_CLIENT_ID, &client_id);
>  	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_CREATE_QUEUE, &qconf);
> +	ssev.dest.client = client_id;
>  
>  	fzsync_pair.exec_loops = 100000;
>  	tst_fzsync_pair_init(&fzsync_pair);
> @@ -63,28 +81,39 @@ static void reinit_pool(int pool_size)
>  		.client = client_id
>  	};
>  
> -	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_SET_CLIENT_POOL, &pconf);
> +	ioctl(fd, SNDRV_SEQ_IOCTL_SET_CLIENT_POOL, &pconf);
> +}
> +
> +static void race_ioctl(void)
> +{
> +	reinit_pool(512);
> +}
> +
> +static void race_write(void)
> +{
> +	write(fd, &ssev, sizeof(ssev));
>  }

Is it okay to use SAFE_WRITE() here? Otherwise write() generates a
warning that couldn't be easily silenced.

-- 
Cyril Hrubis
chrubis@suse.cz
