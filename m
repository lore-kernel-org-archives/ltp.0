From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 28 Oct 2020 11:45:28 +0800
Subject: [LTP] [PATCH v2 2/2] lib/tst_kconfig: Make use of boolean
 expression eval
In-Reply-To: <20201027110446.20416-3-chrubis@suse.cz>
References: <20201027110446.20416-1-chrubis@suse.cz>
 <20201027110446.20416-3-chrubis@suse.cz>
Message-ID: <5F98E958.7070302@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/10/27 19:04, Cyril Hrubis wrote:
> Now each string in the kconfig[] array in tst_test structure is an
> boolean expression which is evaluated. All expressions has to be true in
> order for the test to continue.
>
> This also makes the parser for the kernel config a bit more robust as it
> was pointed out that there may have been cases where it could be mislead
> by hand edited config files.
>
> + Update the docs.
>
> Signed-off-by: Cyril Hrubis<chrubis@suse.cz>
> CC: Pengfei Xu<pengfei.xu@intel.com>
> ---
>
> v2:
>     - squashed the two patches since we are doing more extensive changes
>     - made the parser a bit more robust
>     - renamed a few fucntions and identifiers to make the code easier to
>       understand
>     - sprinkled the code with consts
>
>   doc/test-writing-guidelines.txt |  21 +-
>   include/tst_kconfig.h           |  34 +--
>   lib/newlib_tests/config06       |   1 +
>   lib/newlib_tests/test_kconfig.c |   1 +
>   lib/tst_kconfig.c               | 362 +++++++++++++++++++++-----------
>   5 files changed, 270 insertions(+), 149 deletions(-)
>   create mode 100644 lib/newlib_tests/config06
>
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 1a51ef7c7..3c2ab7166 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1643,21 +1643,26 @@ on the system, disabled syscalls can be detected by checking for 'ENOSYS'
>   errno etc.
>
>   However in rare cases core kernel features couldn't be detected based on the
> -kernel userspace API and we have to resort to kernel .config parsing.
> +kernel userspace API and we have to resort to parse the kernel .config.
>
> -For this cases the test should set the 'NULL' terminated '.needs_kconfigs' array
> -of kernel config options required for the test. The config option can be
> -specified either as plain "CONFIG_FOO" in which case it's sufficient for the
> -test continue if it's set to any value (typically =y or =m). Or with a value
> -as "CONFIG_FOO=bar" in which case the value has to match as well. The test is
> -aborted with 'TCONF' if any of the required options were not set.
> +For this cases the test should set the 'NULL' terminated '.needs_kconfigs'
> +array of boolean expressions with constraints on the kconfig variables. The
> +boolean expression consits of variables, two binary operations '&' and '|',
> +negation '!' and correct sequence of parentesis '()'. Variables are expected
> +to be in a form of "CONFIG_FOO[=bar]".
> +
> +The test will continue to run if all expressions are evaluated to 'True'.
> +Missing variable is mapped to 'False' as well as variable with different than
> +specified value, e.g. 'CONFIG_FOO=bar' will evaluate to 'False' if the value
> +is anything else but 'bar'. If config variable is specified as plain
> +'CONFIG_FOO' it's evaluated to true it's set to any value (typically =y or =m).
>
>   [source,c]
>   -------------------------------------------------------------------------------
>   #include "tst_test.h"
>
>   static const char *kconfigs[] = {
> -	"CONFIG_X86_INTEL_UMIP",
> +	"CONFIG_X86_INTEL_UMIP | CONFIG_X86_UMIP",
>   	NULL
>   };
>
> diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
> index 2d2cfd782..1bb21fea8 100644
> --- a/include/tst_kconfig.h
> +++ b/include/tst_kconfig.h
> @@ -6,27 +6,27 @@
>   #ifndef TST_KCONFIG_H__
>   #define TST_KCONFIG_H__
>
> -struct tst_kconfig_res {
> -	char match;
> -	char *value;
> +struct tst_kconfig_var {
> +	char id[64];
> +	unsigned int id_len;
> +	char choice;
> +	char *val;
>   };
>
>   /**
> - * Reads a kernel config and parses it for values defined in kconfigs array.
> + *
> + * Reads a kernel config, parses it and writes results into an array of
> + * tst_kconfig_var structures.
>    *
>    * The path to the kernel config should be autodetected in most of the cases as
>    * the code looks for know locations. It can be explicitely set/overrided with
>    * the KCONFIG_PATH environment variable as well.
>    *
> - * The kcofings array is expected to contain strings in a format "CONFIG_FOO"
> - * or "CONFIG_FOO=bar". The result array has to be suitably sized to fit the
> - * results.
> - *
> - * @param kconfigs array of config strings to look for
> - * @param results array to store results to
> - * @param cnt size of the arrays
> + * The caller has to initialize the tst_kconfig_var structure. The id has to be
> + * filled with config variable name such as 'CONFIG_FOO', the id_len should
> + * hold the id string length and the choice and val has to be zeroed.
>    *
> - * The match in the tst_kconfig_res structure is set as follows:
> + * After a call to this function each choice be set as follows:
>    *
>    *  'm' - config option set to m
>    *  'y' - config option set to y
> @@ -34,11 +34,13 @@ struct tst_kconfig_res {
>    *  'n' - config option is not set
>    *   0  - config option not found
>    *
> - * In the case that match is set to 'v' the value points to a newly allocated
> - * string that holds the value.
> + * In the case that match is set to 'v' the val pointer points to a newly
> + * allocated string that holds the value.
> + *
> + * @param vars An array of caller initalized tst_kconfig_var structures.
> + * @param vars_len Length of the vars array.
>    */
> -void tst_kconfig_read(const char *const kconfigs[],
> -		      struct tst_kconfig_res results[], size_t cnt);
> +void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len);
>
>   /**
>    * Checks if required kernel configuration options are set in the kernel
> diff --git a/lib/newlib_tests/config06 b/lib/newlib_tests/config06
> new file mode 100644
> index 000000000..b7db25411
> --- /dev/null
> +++ b/lib/newlib_tests/config06
> @@ -0,0 +1 @@
> +# Empty
> diff --git a/lib/newlib_tests/test_kconfig.c b/lib/newlib_tests/test_kconfig.c
> index d9c662fc5..183d55611 100644
> --- a/lib/newlib_tests/test_kconfig.c
> +++ b/lib/newlib_tests/test_kconfig.c
> @@ -14,6 +14,7 @@ static const char *kconfigs[] = {
>   	"CONFIG_MMU",
>   	"CONFIG_EXT4_FS=m",
>   	"CONFIG_PGTABLE_LEVELS=4",
> +	"CONFIG_MMU&  CONFIG_EXT4_FS=m",
>   	NULL
>   };
>
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index d49187b6f..f3159b981 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -12,6 +12,7 @@
>   #define TST_NO_DEFAULT_MAIN
>   #include "tst_test.h"
>   #include "tst_kconfig.h"
> +#include "tst_bool_expr.h"
>
>   static const char *kconfig_path(char *path_buf, size_t path_buf_len)
>   {
> @@ -84,126 +85,108 @@ static void close_kconfig(FILE *fp)
>   		fclose(fp);
>   }
>
> -struct match {
> -	/* match len, string length up to \0 or = */
> -	size_t len;
> -	/* if set part of conf string after = */
> -	const char *val;
> -	/* if set the config option was matched already */
> -	int match;
> -};
> -
> -static int is_set(const char *str, const char *val)
> +static inline int kconfig_parse_line(const char *line,
> +                                     struct tst_kconfig_var *vars,
> +                                     unsigned int vars_len)
>   {
> -	size_t vlen = strlen(val);
> +	unsigned int i, var_len = 0;
> +	const char *var;
> +	int is_not_set = 0;
>
> -	while (isspace(*str))
> -		str++;
> +	while (isspace(*line))
> +		line++;
>
> -	if (strncmp(str, val, vlen))
> -		return 0;
> +	if (*line == '#') {
> +		if (!strstr(line, "is not set"))
> +			return 0;
>
> -	switch (str[vlen]) {
> -	case ' ':
> -	case '\n':
> -	case '\0':
> -		return 1;
> -	break;
> -	default:
> -		return 0;
> +		is_not_set = 1;
>   	}
> -}
> -
> -static inline int match(struct match *match, const char *conf,
> -                        struct tst_kconfig_res *result, const char *line)
> -{
> -	if (match->match)
> -		return 0;
>
> -	const char *cfg = strstr(line, "CONFIG_");
> +	var = strstr(line, "CONFIG_");
>
> -	if (!cfg)
> +	if (!var)
>   		return 0;
>
> -	if (strncmp(cfg, conf, match->len))
> -		return 0;
> -
> -	const char *val =&cfg[match->len];
> -
> -	switch (cfg[match->len]) {
> -	case '=':
> +	for (;;) {
> +		switch (var[var_len]) {
> +		case 'A' ... 'Z':
> +		case '0' ... '9':
> +		case '_':
> +			var_len++;
> +		break;
> +		default:
> +			goto out;
>   		break;
> -	case ' ':
> -		if (is_set(val, "is not set")) {
> -			result->match = 'n';
> -			goto match;
>   		}
> -	/* fall through */
> -	default:
> -		return 0;
>   	}
>
> -	if (is_set(val, "=y")) {
> -		result->match = 'y';
> -		goto match;
> -	}
> +out:
>
> -	if (is_set(val, "=m")) {
> -		result->match = 'm';
> -		goto match;
> -	}
> +	for (i = 0; i<  vars_len; i++) {
> +		const char *val;
> +		unsigned int val_len = 0;
>
> -	result->match = 'v';
> -	result->value = strndup(val+1, strlen(val)-2);
> +		if (vars[i].id_len != var_len)
> +			continue;
>
> -match:
> -	match->match = 1;
> -	return 1;
> -}
> +		if (strncmp(vars[i].id, var, var_len))
> +			continue;
>
> -void tst_kconfig_read(const char *const *kconfigs,
> -                      struct tst_kconfig_res results[], size_t cnt)
Hi Cyril,

New tst_kconfig_read() breaks the compilation of acct02 so we also need 
to update acct02. :-)

Best Regards,
Xiao Yang
> -{
> -	struct match matches[cnt];
> -	FILE *fp;
> -	unsigned int i, j;
> -	char buf[1024];
> +		if (is_not_set) {
> +			vars[i].choice = 'n';
> +			return 1;
> +		}
>
> -	for (i = 0; i<  cnt; i++) {
> -		const char *val = strchr(kconfigs[i], '=');
> +		val = var + var_len;
>
> -		if (strncmp("CONFIG_", kconfigs[i], 7))
> -			tst_brk(TBROK, "Invalid config string '%s'", kconfigs[i]);
> +		while (isspace(*val))
> +			val++;
> +
> +		if (*val != '=')
> +			return 0;
> +
> +		val++;
>
> -		matches[i].match = 0;
> -		matches[i].len = strlen(kconfigs[i]);
> +		while (isspace(*val))
> +			val++;
>
> -		if (val) {
> -			matches[i].val = val + 1;
> -			matches[i].len -= strlen(val);
> +		while (!isspace(val[val_len]))
> +			val_len++;
> +
> +		if (val_len == 1) {
> +			switch (val[0]) {
> +			case 'y':
> +				vars[i].choice = 'y';
> +				return 1;
> +			case 'm':
> +				vars[i].choice = 'm';
> +				return 1;
> +			}
>   		}
>
> -		results[i].match = 0;
> -		results[i].value = NULL;
> +		vars[i].choice = 'v';
> +		vars[i].val = strndup(val, val_len);
>   	}
>
> -	fp = open_kconfig();
> +	return 0;
> +}
> +
> +void tst_kconfig_read(struct tst_kconfig_var vars[], size_t vars_len)
> +{
> +	char line[128];
> +	unsigned int vars_found = 0;
> +
> +	FILE *fp = open_kconfig();
>   	if (!fp)
>   		tst_brk(TBROK, "Cannot parse kernel .config");
>
> -	while (fgets(buf, sizeof(buf), fp)) {
> -		for (i = 0; i<  cnt; i++) {
> -			if (match(&matches[i], kconfigs[i],&results[i], buf)) {
> -				for (j = 0; j<  cnt; j++) {
> -					if (matches[j].match)
> -						break;
> -				}
> -
> -				if (j == cnt)
> -					goto exit;
> -			}
> -		}
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (kconfig_parse_line(line, vars, vars_len))
> +			vars_found++;
>
> +		if (vars_found == vars_len)
> +			goto exit;
>   	}
>
>   exit:
> @@ -219,65 +202,194 @@ static size_t array_len(const char *const kconfigs[])
>   	return i;
>   }
>
> -static int compare_res(struct tst_kconfig_res *res, const char *kconfig,
> -                       char match, const char *val)
> +static const char *strnchr(const char *s, int c, unsigned int len)
>   {
> -	if (res->match != match) {
> -		tst_res(TINFO, "Needs kernel %s, have %c", kconfig, res->match);
> -		return 1;
> +	unsigned int i;
> +
> +	for (i = 0; i<  len; i++) {
> +		if (s[i] == c)
> +			return s + i;
>   	}
>
> -	if (match != 'v')
> -		return 0;
> +	return NULL;
> +}
> +
> +static inline unsigned int get_len(const char* kconfig, unsigned int len)
> +{
> +	const char *sep = strnchr(kconfig, '=', len);
> +
> +	if (!sep)
> +		return len;
> +
> +	return sep - kconfig;
> +}
> +
> +static inline unsigned int get_var_cnt(struct tst_expr *const exprs[],
> +                                       unsigned int expr_cnt)
> +{
> +	unsigned int i;
> +	const struct tst_expr *j;
> +	unsigned int cnt = 0;
>
> -	if (strcmp(res->value, val)) {
> -		tst_res(TINFO, "Needs kernel %s, have %s", kconfig, res->value);
> -		return 1;
> +	for (i = 0; i<  expr_cnt; i++) {
> +		for (j = exprs[i]; j; j = j->next) {
> +			if (j->op == TST_OP_VAR)
> +				cnt++;
> +		}
>   	}
>
> -	return 0;
> +	return cnt;
>   }
>
> -void tst_kconfig_check(const char *const kconfigs[])
> +static const struct tst_kconfig_var *find_var(const struct tst_kconfig_var vars[],
> +                                        unsigned int var_cnt,
> +                                        const char *var)
>   {
> -	size_t cnt = array_len(kconfigs);
> -	struct tst_kconfig_res results[cnt];
>   	unsigned int i;
> -	int abort_test = 0;
>
> -	tst_kconfig_read(kconfigs, results, cnt);
> +	for (i = 0; i<  var_cnt; i++) {
> +		if (!strcmp(vars[i].id, var))
> +			return&vars[i];
> +	}
>
> -	for (i = 0; i<  cnt; i++) {
> -		if (results[i].match == 0) {
> -			tst_res(TINFO, "Missing kernel %s", kconfigs[i]);
> -			abort_test = 1;
> +	return NULL;
> +}
> +
> +/*
> + * Fill in the kconfig variables array from the expressions. Also makes sure
> + * that each variable is copied to the array exaclty once.
> + */
> +static inline unsigned int populate_vars(struct tst_expr *exprs[],
> +                                         unsigned int expr_cnt,
> +                                    struct tst_kconfig_var vars[])
> +{
> +	unsigned int i;
> +	struct tst_expr *j;
> +	unsigned int cnt = 0;
> +
> +	for (i = 0; i<  expr_cnt; i++) {
> +		for (j = exprs[i]; j; j = j->next) {
> +			const struct tst_kconfig_var *var;
> +
> +			if (j->op != TST_OP_VAR)
> +				continue;
> +
> +			vars[cnt].id_len = get_len(j->tok, j->tok_len);
> +
> +			if (vars[cnt].id_len + 1>= sizeof(vars[cnt].id))
> +				tst_brk(TBROK, "kconfig var id too long!");
> +
> +			strncpy(vars[cnt].id, j->tok, vars[cnt].id_len);
> +			vars[cnt].id[vars[cnt].id_len] = 0;
> +			vars[cnt].choice = 0;
> +
> +			var = find_var(vars, cnt, vars[cnt].id);
> +
> +			if (var)
> +				j->priv = var;
> +			else
> +				j->priv =&vars[cnt++];
> +		}
> +	}
> +
> +	return cnt;
> +}
> +
> +static int map(struct tst_expr *expr)
> +{
> +	const struct tst_kconfig_var *var = expr->priv;
> +
> +	if (var->choice == 0)
> +		return 0;
> +
> +	const char *val = strnchr(expr->tok, '=', expr->tok_len);
> +
> +	/* CONFIG_FOO evaluates to true if y or m */
> +	if (!val)
> +		return var->choice == 'y' || var->choice == 'm';
> +
> +	unsigned int len = expr->tok_len - (val - expr->tok);
> +	char choice = 'v';
> +	val++;
> +
> +	if (!strncmp(val, "n", len))
> +		choice = 'n';
> +
> +	if (!strncmp(val, "y", len))
> +		choice = 'y';
> +
> +	if (!strncmp(val, "m", len))
> +		choice = 'm';
> +
> +	if (choice != 'v')
> +		return var->choice == choice;
> +
> +	return !strncmp(val, var->val, len);
> +}
> +
> +static void dump_vars(const struct tst_expr *expr)
> +{
> +	const struct tst_expr *i;
> +	const struct tst_kconfig_var *var;
> +
> +	tst_res(TINFO, "Variables:");
> +
> +	for (i = expr; i; i = i->next) {
> +		if (i->op != TST_OP_VAR)
> +			continue;
> +
> +		var = i->priv;
> +
> +		if (!var->choice) {
> +			tst_res(TINFO, " %s Undefined", var->id);
>   			continue;
>   		}
>
> -		if (results[i].match == 'n') {
> -			tst_res(TINFO, "Kernel %s is not set", kconfigs[i]);
> -			abort_test = 1;
> +		if (var->choice == 'v') {
> +			tst_res(TINFO, " %s=%s", var->id, var->val);
>   			continue;
>   		}
>
> -		const char *val = strchr(kconfigs[i], '=');
> +		tst_res(TINFO, " %s=%c", var->id, var->choice);
> +	}
> +}
>
> -		if (val) {
> -			char match = 'v';
> -			val++;
> +void tst_kconfig_check(const char *const kconfigs[])
> +{
> +	size_t expr_cnt = array_len(kconfigs);
> +	struct tst_expr *exprs[expr_cnt];
> +	unsigned int i, var_cnt;
> +	int abort_test = 0;
>
> -			if (!strcmp(val, "y"))
> -				match = 'y';
> +	for (i = 0; i<  expr_cnt; i++) {
> +		exprs[i] = tst_bool_expr_parse(kconfigs[i]);
>
> -			if (!strcmp(val, "m"))
> -				match = 'm';
> +		if (!exprs[i])
> +			tst_brk(TBROK, "Invalid kconfig expression!");
> +	}
>
> -			if (compare_res(&results[i], kconfigs[i], match, val))
> -				abort_test = 1;
> +	var_cnt = get_var_cnt(exprs, expr_cnt);
> +	struct tst_kconfig_var vars[var_cnt];
>
> +	var_cnt = populate_vars(exprs, expr_cnt, vars);
> +
> +	tst_kconfig_read(vars, var_cnt);
> +
> +	for (i = 0; i<  expr_cnt; i++) {
> +		int val = tst_bool_expr_eval(exprs[i], map);
> +
> +		if (val != 1) {
> +			abort_test = 1;
> +			tst_res(TINFO, "Expression '%s' not satisfied!", kconfigs[i]);
> +			dump_vars(exprs[i]);
>   		}
>
> -		free(results[i].value);
> +		tst_bool_expr_free(exprs[i]);
> +	}
> +
> +	for (i = 0; i<  var_cnt; i++) {
> +		if (vars[i].choice == 'v')
> +			free(vars[i].val);
>   	}
>
>   	if (abort_test)



