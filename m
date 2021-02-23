From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Feb 2021 10:41:08 +0100
Subject: [LTP] [PATCH 1/4] lib: Add support for linux stable and glibc
 tags
In-Reply-To: <20210222160243.507-2-pvorel@suse.cz>
References: <20210222160243.507-1-pvorel@suse.cz>
 <20210222160243.507-2-pvorel@suse.cz>
Message-ID: <YDTNtBH/9mz4I2OL@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  #define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
> +#define LINUX_STABLE_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id="
> +#define GLIBC_GIT_URL "https://sourceware.org/git/?p=glibc.git;a=commit;h="
>  #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"
>  
>  struct tst_test *tst_test;
> @@ -492,6 +495,8 @@ static void print_test_tags(void)
>  			printf(CVE_DB_URL "%s\n", tags[i].value);
>  		else if (!strcmp(tags[i].name, "linux-git"))
>  			printf(LINUX_GIT_URL "%s\n", tags[i].value);
> +		else if (!strcmp(tags[i].name, "linux-stable-git"))
> +			printf(LINUX_STABLE_GIT_URL "%s\n", tags[i].value);

Shouldn't we add GLIBC_GIT_URL handling here as well?

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
