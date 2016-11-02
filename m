From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 2 Nov 2016 16:47:31 +0100
Subject: [LTP] [PATCH v3 4/5] llistxattr: new testcase for long path name
In-Reply-To: <1478084391-30192-5-git-send-email-dejan.jovicevic@rt-rk.com>
References: <1478084391-30192-1-git-send-email-dejan.jovicevic@rt-rk.com>
 <1478084391-30192-5-git-send-email-dejan.jovicevic@rt-rk.com>
Message-ID: <20161102154731.GG28344@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> +char longpathname[PATH_MAX + 2];

Should be static char.

>  static struct test_case {
>  	const char *path;
>  	size_t size;
> @@ -54,7 +58,8 @@ static struct test_case {
>  } tc[] = {
>  	{SYMLINK, 1, ERANGE},
>  	{"", 20, ENOENT},
> -	{(char *)-1, 20, EFAULT}
> +	{(char *)-1, 20, EFAULT},
> +	{longpathname, 20, ENAMETOOLONG}
>  };
>  
>  static void verify_llistxattr(unsigned int n)
> @@ -85,6 +90,8 @@ static void setup(void)
>  	SAFE_SYMLINK(TESTFILE, SYMLINK);
>  
>  	SAFE_LSETXATTR(SYMLINK, SECURITY_KEY, VALUE, VALUE_SIZE, XATTR_CREATE);
> +
> +	memset(&longpathname, 'a', sizeof(longpathname) - 1);

No need for the & here (in C array is a pointer to a first member and
&array == array).

Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
