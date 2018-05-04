From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 May 2018 16:53:31 +0200
Subject: [LTP] [PATCH 1/1] setregid: Fallback to `nogroup' group
In-Reply-To: <20180504082829.10973-1-pvorel@suse.cz>
References: <20180504082829.10973-1-pvorel@suse.cz>
Message-ID: <20180504145330.GD7653@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	GET_GID(nobody);
> +#define GET_GID_FALLBACK(group, group2) do { \
> +	junk = getgrnam(#group); \
> +	if (junk == NULL) { \
> +		tst_resm(TINFO, "%s not found, trying fallback %s", #group, #group2); \
> +		junk = getgrnam(#group2); \
> +		if (junk == NULL) { \
> +			tst_brkm(TBROK, NULL, "%s or %s must be a valid group", #group, #group2); \
> +		} \
> +	} \
> +	GID16_CHECK(junk->gr_gid, setregid, NULL); \
> +	group ## _gr = *(junk); \
> +} while (0)
> +
> +	GET_GID_FALLBACK(nobody, nogroup);

Uh this macros are ugly, but then the original is is ugly as well.

So let's get this in for the release to keep the amount of changes
minimal if you promise to clean it up after the release is finalized :-).

-- 
Cyril Hrubis
chrubis@suse.cz
