From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Jan 2020 17:19:57 +0100
Subject: [LTP] [PATCH v5 1/4] lib/tst_kconfig.c: add any kconfig with or
 without expected value function
In-Reply-To: <20191220092529.3239-1-pengfei.xu@intel.com>
References: <20191220092529.3239-1-pengfei.xu@intel.com>
Message-ID: <20200129161957.GF22477@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  	for (i = 0; i < cnt; i++) {
>  		const char *val = strchr(kconfigs[i], '=');
> @@ -176,12 +177,9 @@ void tst_kconfig_read(const char *const *kconfigs,
>  			tst_brk(TBROK, "Invalid config string '%s'", kconfigs[i]);
>  
>  		matches[i].match = 0;
> -		matches[i].len = strlen(kconfigs[i]);
>  
> -		if (val) {
> +		if (val)
>  			matches[i].val = val + 1;
> -			matches[i].len -= strlen(val);
> -		}
>  
>  		results[i].match = 0;
>  		results[i].value = NULL;
> @@ -193,17 +191,29 @@ void tst_kconfig_read(const char *const *kconfigs,
>  
>  	while (fgets(buf, sizeof(buf), fp)) {
>  		for (i = 0; i < cnt; i++) {
> -			if (match(&matches[i], kconfigs[i], &results[i], buf)) {
> -				for (j = 0; j < cnt; j++) {
> -					if (matches[j].match)
> -						break;
> +			memset(kconfig_multi, 0, sizeof(kconfig_multi));
> +			/* strtok_r will split kconfigs[i] to multi string, so copy it */
> +			memcpy(kconfig_multi, kconfigs[i], strlen(kconfigs[i]));
> +			kconfig_token = strtok_r(kconfig_multi, "|=", &p_left);
> +
> +			while (kconfig_token != NULL) {
> +				if (strncmp("CONFIG_", kconfig_token, 7))
> +					tst_brk(TBROK, "Invalid config string '%s'", kconfig_token);
> +				matches[i].len = strlen(kconfig_token);
> +				if (match(&matches[i], kconfig_token, &results[i], buf)) {
> +					for (j = 0; j < cnt; j++) {
> +						if (matches[j].match)
> +							break;
> +					}
> +					if (j == cnt)
> +						goto exit;

I do not think that this actually works correctly. One of the problems I
see is that we do match only the CONFIG_FOO part in the
tst_kconfig_read() and the result value is evaluated later on. This
means that if we had something as "CONFIG_FOO=5|CONFIG_FOO=4" the code
will pick up only the first occurence of the = and we would end up doing
strcmp("4", "5|CONFIG_FOO=4") which would fail as well.

If we wanted to have proper solution for logic statements inside of the
kconfig parser we would have to isolate the CONFIG_FOO names first, pass
them to the tst_kconfig_read() function, that would get us values for
all config variables we need, then we could split the configs strings
greadily on | and evaluate them one after another.

So the first function would have to be able to get arrays of strings and
return another array of strings isolating the CONFIG_FOO variables. That
would be passed to tst_kconfig_read() that would yield results[] array,
for all interesting variables. From that point we can split the kconfig
strings by | and evaluate one after another until we get match or end of
the string.

-- 
Cyril Hrubis
chrubis@suse.cz
