From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Jun 2021 12:36:31 +0200
Subject: [LTP] [PATCH 1/2] syscalls/msgstress03: fix fork failure on
 small memory systems
In-Reply-To: <20210622111440.74722-1-krzysztof.kozlowski@canonical.com>
References: <20210622111440.74722-1-krzysztof.kozlowski@canonical.com>
Message-ID: <YNMOr/9X8J3NaAMZ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +/*
> + * Get the effective session UID - either one invoking current test via sudo
> + * or the real UID.
> + */
> +int get_session_uid(void)
> +{
> +	const char *sudo_uid;
> +
> +	sudo_uid = getenv("SUDO_UID");
> +	if (sudo_uid) {
> +		int real_uid;
> +
> +		TEST(sscanf(sudo_uid, "%u", &real_uid));
> +		if (TEST_RETURN != 1) {
> +#ifdef DEBUG
> +			tst_resm(TINFO, "No SUDO_UID from env");
> +#endif
> +		} else {
> +			return real_uid;
> +		}
> +	}
> +
> +	return getuid();
> +}
> +
>  /*
>   * rm_shm() - removes a shared memory segment.
>   */
> @@ -218,3 +243,36 @@ int get_max_msgqueues(void)
>  	fclose(f);
>  	return atoi(buff);
>  }
> +
> +/*
> + * Get the limit of processes for current session configured by systemd user.slice.
> + * This also applies to root user.
> + */
> +int get_pids_limit(void)
> +{
> +	int real_uid, ret;
> +	char path[PATH_MAX];
> +	long unsigned int max_pids;
> +
> +	real_uid = get_session_uid();
> +	if (TEST_RETURN != 1) {
> +		tst_resm(TINFO, "Cannot get UID");
> +		return -1;
> +	}
> +
> +	ret = snprintf(path, sizeof(path),
> +		       "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max",
> +		       real_uid);
> +	if (ret < 0 || (size_t)ret >= sizeof(path))
> +		return -1;
> +
> +	if (access(path, R_OK) != 0) {
> +		tst_resm(TINFO, "Cannot read session user limits from '%s'", path);
> +		return -1;
> +	}
> +
> +	SAFE_FILE_SCANF(cleanup, path, "%lu", &max_pids);
> +	tst_resm(TINFO, "Found limit of processes %lu (from %s)", max_pids, path);
> +
> +	return max_pids;
> +}

This is quite generic functionality so we may as well put it into the
include/tst_pid.h and lib/tst_pid.c as tst_get_pids_limit().

And we do already have tst_get_free_pids_() in there so we can substract
that as well if applicable to make it a bit more precise.

Also I think that it may make sense to put the part that substract some
constant to leave room for the rest of the system to the library as
well. There is no point in having this heuristic in each test.

-- 
Cyril Hrubis
chrubis@suse.cz
