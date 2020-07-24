From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 24 Jul 2020 16:51:03 +0200
Subject: [LTP] [PATCH V7 11/19] syscalls/mq_timed{send|receive}: Add
 support for time64 tests
In-Reply-To: <bcade4d3066ea789f590267b402277b78e86dd8d.1593152309.git.viresh.kumar@linaro.org>
References: <cover.1593152309.git.viresh.kumar@linaro.org>
 <bcade4d3066ea789f590267b402277b78e86dd8d.1593152309.git.viresh.kumar@linaro.org>
Message-ID: <20200724145103.GA10254@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've put the variant definition to the common header, since we have one
already it's pointless to keep two copies and pushed, thanks.

I've also pushed a patch on the top of that one that modifies the
timeous so that the test runs reasonably fast.

Also I'm starting to think that it may be easier to add all the syscall
variants into a single structure into an header that would be then
included by various tests, something as:

struct variant {
	int (*gettime)(clockid_t clk_id, void *ts);
	int (*settime)(clockid_t clk_id, void *ts);
	int (*getres)(clockid_t, void *ts);
	int (*tfd_gettime)(int fd, void *ts);
	int (*tfd_settime)(int fd, int flags, void *new_ts, void *old_ts);

	...

	enum tst_ts_type type;
	char desc;
} variants[] = {
...
};

Then we can include this to each test that needs it and be done with
it...

-- 
Cyril Hrubis
chrubis@suse.cz
