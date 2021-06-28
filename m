From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Mon, 28 Jun 2021 18:05:56 +0200
Subject: [LTP] [PATCH v3 2/4] syscalls/msgstress04: fix fork failure on
 small memory systems
In-Reply-To: <YNnhBhN6bzUCfqdk@pevik>
References: <20210623135912.81156-1-krzysztof.kozlowski@canonical.com>
 <20210623135912.81156-3-krzysztof.kozlowski@canonical.com>
 <YNnhBhN6bzUCfqdk@pevik>
Message-ID: <07365741-d607-b1b0-879a-ecf7ae34cc14@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 28/06/2021 16:47, Petr Vorel wrote:
> Hi Krzysztof,
> 
> nit: Instead of git commit subject "syscalls/msgstress04: fix fork failure
> on small memory systems". I'd use "tst_pid.c: fix fork ...".

Sure.

>> +/*
>> + * Get the effective session UID - either one invoking current test via sudo
>> + * or the real UID.
>> + */
>> +static int get_session_uid(void)
>> +{
>> +	const char *sudo_uid;
>> +
>> +	sudo_uid = getenv("SUDO_UID");
>> +	if (sudo_uid) {
>> +		int real_uid;
>> +
>> +		TEST(sscanf(sudo_uid, "%u", &real_uid));
> FYI We recently decided to not use TEST() macro in library itself.
> See Richard's effort [1]. We should document it in LTP Library API Writing Guidelines [2]
> 

I'll remove it.

>> +		if (TEST_RETURN != 1) {
>> +#ifdef DEBUG
> FYI we don't support DEBUG. Either the information is always important or not.
> In this case I'd probably avoid printing it.

Sure.

> 
>> +			tst_resm(TINFO, "No SUDO_UID from env");
>> +#endif
>> +		} else {
>> +			return real_uid;
>> +		}
>> +	}
>> +
>> +	return getuid();
>> +}
>> +
>> +static int read_session_pids_limit(const char *path_fmt, int uid,
>> +				   void (*cleanup_fn) (void))
>> +{
>> +	int max_pids, ret;
>> +	char path[PATH_MAX];
>> +
>> +	ret = snprintf(path, sizeof(path), path_fmt, uid);
>> +	if (ret < 0 || (size_t)ret >= sizeof(path))
>> +		return -1;
>> +
>> +	if (access(path, R_OK) != 0) {
>> +		tst_resm(TINFO, "Cannot read session user limits from '%s'", path);
>> +		return -1;
>> +	}
>> +
>> +	SAFE_FILE_SCANF(cleanup_fn, path, "%d", &max_pids);
>> +	tst_resm(TINFO, "Found limit of processes %d (from %s)", max_pids, path);
>> +
>> +	return max_pids;
>> +}
>> +
>> +static int get_session_pids_limit(void (*cleanup_fn) (void))
>> +{
>> +	int max_pids, uid;
>> +
>> +	uid = get_session_uid();
>> +	if (TEST_RETURN != 1) {
> and here as well 

OK, thanks for review!


Best regards,
Krzysztof
