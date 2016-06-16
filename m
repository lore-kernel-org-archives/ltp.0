From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jun 2016 13:25:44 +0800
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <57614F55.9090407@redhat.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
 <57614F55.9090407@redhat.com>
Message-ID: <20160616052544.GA18852@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 15, 2016 at 02:51:33PM +0200, Jan Stancek wrote:
> On 06/15/2016 09:34 AM, Jan Stancek wrote:
> 
> How about something like this?

This one looks better, just have a little comments as below:

> static int walk_file_lines(const char *filename, walk_func func,
> 			   void *func_priv)
> {
> 	FILE *fp;
> 	char line[BUFSIZ];
> 
> 	fp = fopen(filename, "r");
> 	if (fp == NULL)
> 		tst_brk(TBROK | TERRNO, "fopen %s", path_meminfo);

A typo here, the 'path_meminfo' should be replaced by 'filename'.

> static int match_colonpair_str_long(const char *line, void *priv)
> {
> 	struct colonpair_str_long *s = priv;
> 	char buf[BUFSIZ];
> 	long val;
> 
> 	if (sscanf(line, "%64s %ld", buf, &val) == 2) {
> 		/* strip colon for comparison with key */
> 		buf[strlen(buf) - 1] = '\0';

If manual set the last character as '\0', there will be limit this
match function area.

e.g.
  # cat /proc/stat | grep processes
      processes 129493

A caller can not get correct value of the processes, since the
string saved in buf[] as: 'p' 'r' 'o' 'c' 'e' 's' 's' 'e' '\0',
it will disturb the mathing result and return 0.

My proposal is to have a simple choice here:

/* strip colon for comparison with key */
	if (buf[strlen(buf) -1] == ':')
		buf[strlen(buf) -1] = '\0';
> 
> long tst_get_avail_mem(void)
> {
> 	long mem_available;
> 
> 	mem_available = tst_get_meminfo("MemAvailable");
> 	if (mem_available == -1) {
> 		mem_available = tst_get_meminfo("MemFree");
> 		mem_available += tst_get_meminfo("Cached");
> 	}
> 
> 	return mem_available;
> }

I'd like to add new callers for reading '/proc/stat' and
'/proc/self/status' to verify read_colonpair_str_long() function.

static const char *path_proc_stat = "/proc/stat";
static const char *path_self_status = "/proc/self/status";

long tst_get_stat(const char *key)
{
	return read_colonpair_str_long(path_proc_stat, key, -1);
}

long tst_get_self_status(const char *key)
{
	return read_colonpair_str_long(path_self_status, key, -1);
}

a simple test program:
---------------------
# cat newlib_tests/test14.c

#include "tst_test.h"
#include "tst_proc.h"

static void do_test(void)
{
	tst_res(TINFO, "MemTotal = %ld kB", tst_get_meminfo("MemTotal"));
	tst_res(TINFO, "MemAvailable = %ld kB", tst_get_meminfo("MemAvailable"));
	tst_res(TINFO, "MemAvailable = %ld kB", tst_get_avail_mem());
	tst_res(TINFO, "Shmem = %ld kB", tst_get_meminfo("Shmem"));
	tst_res(TINFO, "SwapFree = %ld kB", tst_get_meminfo("SwapFree"));

	tst_res(TINFO, "btime = %ld", %tst_get_stat("btime"));
	tst_res(TINFO, "processes = %ld", %tst_get_stat("processes"));
	tst_res(TINFO, "VmPeak = %ld kB", tst_get_self_status("VmPeak"));

	tst_res(TPASS, "Test proc read file pass");
}

static struct tst_test test =
{
	.tid = "test14",
	.test_all = do_test,
};


# ./test14
tst_test.c:699: INFO: Timeout per run is 300s
test14.c:25: INFO: MemTotal = 16230660 kB
test14.c:26: INFO: MemAvailable = 13310720 kB
test14.c:26: INFO: MemAvailable = 13310720 kB
test14.c:27: INFO: Shmem = 8588 kB
test14.c:28: INFO: SwapFree = 8156220 kB
test14.c:30: INFO: btime = 1465882713
test14.c:31: INFO: processes = 288403
test14.c:33: INFO: VmPeak = 4368 kB
test14.c:35: PASS: Test proc read file pass

Summary:
passed   1
failed   0
skipped  0
warnings 0


Regards,
Li Wang

