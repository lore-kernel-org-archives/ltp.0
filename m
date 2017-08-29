From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Aug 2017 14:13:50 +0200
Subject: [LTP] [PATCH] android: madvise08: fix for android devices.
In-Reply-To: <20170828212444.123677-1-sspatil@google.com>
References: <20170828212444.123677-1-sspatil@google.com>
Message-ID: <20170829121350.GG31839@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  static void setup(void)
>  {
> @@ -80,7 +81,7 @@ static void setup(void)
>  	if (!(0x1 & filter))
>  		tst_brk(TCONF, "Anonymous private memory is not dumpable.");
>  
> -	SAFE_FILE_SCANF(CORE_PATTERN, "%m[^\n]", &cpattern);
> +	SAFE_FILE_SCANF(CORE_PATTERN, "%s[^\n]", cpattern);
>  	tst_res(TINFO, "System core pattern is '%s'", cpattern);
>  
>  	SAFE_GETCWD(cwd, sizeof(cwd));
> @@ -108,10 +109,7 @@ static void setup(void)
>  
>  static void cleanup(void)
>  {
> -	if (cpattern)
> -		SAFE_FILE_PRINTF(CORE_PATTERN, "%s", cpattern);
> -
> -	free(cpattern);
> +	SAFE_FILE_PRINTF(CORE_PATTERN, "%s", cpattern);

This change breaks the test in a case that tst_brk() is called before we
read the cpattern successfully, as we will write and empty string to the
cpattern file here in the test cleanup. We have to restore it only and
only if it was read correctly. We may as well add a flag called
restore_pattern and set it to 1 once we write with SAFE_FILE_PRINTF() in
the test setup and use it here.

-- 
Cyril Hrubis
chrubis@suse.cz
