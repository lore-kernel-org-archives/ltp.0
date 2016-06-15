From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 15 Jun 2016 14:51:33 +0200
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
Message-ID: <57614F55.9090407@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06/15/2016 09:34 AM, Jan Stancek wrote:
> 
> 
> 
> ----- Original Message -----
>> From: "Li Wang" <liwang@redhat.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp@lists.linux.it
>> Sent: Tuesday, 14 June, 2016 4:37:29 PM
>> Subject: Re: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
>>
>> It is a good proposal, but the achieved function seems a little bit
>> narrow for ltp-lib.
> 
> OK, let me try to come up with something more generic.

How about something like this?

#include <stdio.h>
#include "tst_proc.h"

#define TST_NO_DEFAULT_MAIN
#include "tst_test.h"

static const char *path_meminfo = "/proc/meminfo";

typedef int walk_func(const char *line, void *priv);

/*
 * Go through all lines in a text file, calling walk_func() on each
 * until it returns 1 or file hits EOF. Returns last return value of
 * walk_func().
 *
 * @filename: name of text file to walk
 * @walk_func: function called for each line
 * @func_priv: walk_func's specific struct representing in/out data
 * */
static int walk_file_lines(const char *filename, walk_func func,
			   void *func_priv)
{
	FILE *fp;
	char line[BUFSIZ];

	fp = fopen(filename, "r");
	if (fp == NULL)
		tst_brk(TBROK | TERRNO, "fopen %s", path_meminfo);

	while (fgets(line, BUFSIZ, fp) != NULL) {
		if (func(line, func_priv) == 1) {
			fclose(fp);
			return 1;
		}
		continue;
	}
	fclose(fp);

	return 0;
}

struct colonpair_str_long
{
	const char *key;
	long value;
};

/*
 *  Returns 1 if "line" matches pattern: "Key: Value" and
 *  Key is equal to colonpair_str_long->key, otherwise returns 0.
 *
 *  @line: line searched for pattern
 *  @priv: pointer to colonpair_str_long struct where
 *         .key - Key to search for
 *         .value - stores "Value" if "Key" is found
 */
static int match_colonpair_str_long(const char *line, void *priv)
{
	struct colonpair_str_long *s = priv;
	char buf[BUFSIZ];
	long val;

	if (sscanf(line, "%64s %ld", buf, &val) == 2) {
		/* strip colon for comparison with key */
		buf[strlen(buf) - 1] = '\0';

		if (strcmp(buf, s->key) == 0) {
			s->value = val;
			return 1;
		}
	}

	return 0;
}

static long read_colonpair_str_long(const char *filename, const char *key,
				    long ret_for_missing)
{
	struct colonpair_str_long data = {
		.key = key,
	};

	if (walk_file_lines(filename, match_colonpair_str_long, &data))
		return data.value;

	return ret_for_missing;
}

/*
 * Search for Key: Value pair in /proc/meminfo, if found
 * return Value, otherwise return -1.
 */
long tst_get_meminfo(const char *key)
{
	return read_colonpair_str_long(path_meminfo, key, -1);
}

long tst_get_avail_mem(void)
{
	long mem_available;

	mem_available = tst_get_meminfo("MemAvailable");
	if (mem_available == -1) {
		mem_available = tst_get_meminfo("MemFree");
		mem_available += tst_get_meminfo("Cached");
	}

	return mem_available;
}
