From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Oct 2015 17:47:23 +0200
Subject: [LTP] [PATCH] syscalls/setregid02: Fix retrieving a group of
 user "nobody"
In-Reply-To: <1443010817-10169-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1443010817-10169-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20151005154723.GB21607@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -#define GET_GID(group)	do {		\
> +#define GET_GROUP_BY_NAME(group)	do {		\
>  	junk = getgrnam(#group);	\
>  	if (junk == NULL) {		\
>  		tst_brkm(TBROK|TERRNO, NULL, "getgrnam(\"%s\") failed", #group); \
> @@ -156,9 +156,18 @@ static void setup(void)
>  	group = *(junk); \
>  } while (0)
>  
> -	GET_GID(root);
> -	GET_GID(nobody);
> -	GET_GID(bin);
> +#define GET_GROUP_BY_GID(group, gid)	do {		\
> +	junk = getgrgid(gid);	\
> +	if (junk == NULL) {		\
> +		tst_brkm(TBROK|TERRNO, NULL, "getgrgid(\"%d\") failed", gid); \
> +	}				\
> +	GID16_CHECK(junk->gr_gid, setregid, NULL); \
> +	group = *(junk); \
> +} while (0)


Can we please get rid of the ugly macros and write them as functions
instead?

Othewise it looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
