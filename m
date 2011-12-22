Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Rdli6-0001OJ-7V
	for ltp-list@lists.sourceforge.net; Thu, 22 Dec 2011 16:41:38 +0000
Date: Thu, 22 Dec 2011 17:51:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111222165119.GB3466@saboteur.suse.cz>
References: <1321609032-16026-1-git-send-email-caspar@casparzhang.com>
	<1321609032-16026-7-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1321609032-16026-7-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v5 6/7] mm/zram01: verify content written to zram
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Caspar Zhang <caspar@casparzhang.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> diff --git a/testcases/kernel/mem/zram/zram01.c b/testcases/kernel/mem/zram/zram01.c
> index 6967bd1..38adf63 100644
> --- a/testcases/kernel/mem/zram/zram01.c
> +++ b/testcases/kernel/mem/zram/zram01.c
> @@ -44,6 +44,7 @@ int modprobe = 0;
>  
>  static void set_disksize(void);
>  static void write_device(void);
> +static void verify_device(void);
>  static void reset(void);
>  static void setup(void);
>  static void cleanup(void);
> @@ -68,6 +69,7 @@ int main(int argc, char *argv[])
>  
>  		write_device();
>  		dump_info();
> +		verify_device();
>  
>  		reset();
>  		dump_info();
> @@ -96,7 +98,7 @@ static void set_disksize(void)
>  static void write_device(void)
>  {
>  	int fd;
> -	void *s;
> +	char *s;
>  
>  	tst_resm(TINFO, "map it into memory.");
>  	fd = open(DEVICE, O_RDWR);
> @@ -107,7 +109,8 @@ static void write_device(void)
>  		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
>  
>  	tst_resm(TINFO, "write all the memory.");
> -	memset(s, 'a', SIZE);
> +	memset(s, 'a', SIZE-1);
> +	s[SIZE-1] = '\0';
>  
>  	if (munmap(s, SIZE) == -1)
>  		tst_brkm(TBROK|TERRNO, cleanup, "munmap");
> @@ -115,6 +118,37 @@ static void write_device(void)
>  	close(fd);
>  }
>  
> +static void verify_device(void)
> +{
> +	int fd, i, fail;
> +	char *s;
> +
> +	tst_resm(TINFO, "verify contents from device.");
> +	fd = open(DEVICE, O_RDONLY);
> +	if (fd == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "open %s", DEVICE);
> +	s = mmap(NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
> +	if (s == MAP_FAILED)
> +		tst_brkm(TBROK|TERRNO, cleanup, "2nd mmap");
> +
> +	i = 0;
> +	fail = 0;
> +	while (s[i]) {
> +		if (s[i] != 'a')
> +			fail++;
> +		i++;
> +	}

Hmm, I would make sure here, that I haven't read more than SIZE
characters. Eg. I wouldn't expect that device you are testing is null
terminated, even if you wrote the terminating zero there.

> +	if (i != SIZE-1)
> +		tst_resm(TFAIL, "expect size: %d, actual size: %d.",
> +				SIZE-1, i);
> +	if (fail)
> +		tst_resm(TFAIL, "%d failed bytes found.", fail);
> +	if (munmap(s, SIZE) == -1)
> +		tst_brkm(TBROK|TERRNO, cleanup, "2nd munmap");
> +
> +	close(fd);
> +}
> +
>  static void reset(void)
>  {
>  	int fd;


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
