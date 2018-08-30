From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 30 Aug 2018 07:01:45 -0400 (EDT)
Subject: [LTP] [PATCH v4 1/2] lib: introduce tst_timeout_remaining()
In-Reply-To: <20180830104219.GA6363@rei.lan>
References: <5ad739995335bda348f07fc4d3faeec501e00b19.1535618962.git.jstancek@redhat.com>
 <20180830104219.GA6363@rei.lan>
Message-ID: <706273620.43655984.1535626905479.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On Thu, Aug 30, 2018 at 10:55:18AM +0200, Jan Stancek wrote:
> > Which returns number of seconds remaining until timeout.
> > Along with tst_start_time it is only valid for test pid.
> > 
> > Its value has to be (re)initialized when:
> > - test starts
> > - test calls tst_set_timeout()
> > - test runs multiple iterations or uses .all_filesystems
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> > Changes in v4:
> > - drop tst_timer_find_clock(), use CLOCK_MONOTONIC
> > - reinitialize in heartbeat(), so we cover -i parameter and
> > tst_set_timeout()
> > - modify test18 so it sleeps
> > - add test18 .gitignore
> > - add note to docs
> > 
> >  doc/test-writing-guidelines.txt |  3 +++
> >  include/tst_test.h              |  1 +
> >  lib/newlib_tests/.gitignore     |  1 +
> >  lib/newlib_tests/test18.c       | 34 ++++++++++++++++++++++++++++++++++
> >  lib/tst_test.c                  | 22 ++++++++++++++++++++++
> >  5 files changed, 61 insertions(+)
> >  create mode 100644 lib/newlib_tests/test18.c
> > 
> > diff --git a/doc/test-writing-guidelines.txt
> > b/doc/test-writing-guidelines.txt
> > index a16972430b14..0194f2098d26 100644
> > --- a/doc/test-writing-guidelines.txt
> > +++ b/doc/test-writing-guidelines.txt
> > @@ -324,6 +324,9 @@ overriden by setting '.timeout' in the test structure
> > or by calling
> >  time may vary arbitrarily, for these timeout can be disabled by setting it
> >  to
> >  -1.
> >  
> > +Test can find out how much time (in seconds) is remaining to timeout,
> > +by calling 'tst_timeout_remaining()'.
> > +
> >  A word about the cleanup() callback
> >  +++++++++++++++++++++++++++++++++++
> >  
> > diff --git a/include/tst_test.h b/include/tst_test.h
> > index 98dacf3873ab..c0c9a7c7b995 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -217,6 +217,7 @@ const char *tst_strsig(int sig);
> >   */
> >  const char *tst_strstatus(int status);
> >  
> > +unsigned int tst_timeout_remaining(void);
> >  void tst_set_timeout(int timeout);
> >  
> >  #ifndef TST_NO_DEFAULT_MAIN
> > diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> > index 99edc640438e..76e89e438f55 100644
> > --- a/lib/newlib_tests/.gitignore
> > +++ b/lib/newlib_tests/.gitignore
> > @@ -19,6 +19,7 @@ tst_safe_fileops
> >  tst_res_hexd
> >  tst_strstatus
> >  test17
> > +test18
> >  tst_expiration_timer
> >  test_exec
> >  test_exec_child
> > diff --git a/lib/newlib_tests/test18.c b/lib/newlib_tests/test18.c
> > new file mode 100644
> > index 000000000000..6615471a5708
> > --- /dev/null
> > +++ b/lib/newlib_tests/test18.c
> > @@ -0,0 +1,34 @@
> > +/*
> > + * Copyright (c) 2018, Linux Test Project
> > + *
> > + * This program is free software: you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation, either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> > + * along with this program. If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include "tst_test.h"
> > +
> > +static void run(void)
> > +{
> > +	do {
> > +		sleep(1);
> > +	} while (tst_timeout_remaining() >= 4);
> > +
> > +	tst_res(TPASS, "Timeout remaining: %d", tst_timeout_remaining());
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.timeout = 5
> > +};
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index 2f3d357d2fcc..ae3ca6182581 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -47,6 +47,7 @@ static int iterations = 1;
> >  static float duration = -1;
> >  static pid_t main_pid, lib_pid;
> >  static int mntpoint_mounted;
> > +static struct timespec tst_start_time; /* valid only for test pid */
> >  
> >  struct results {
> >  	int passed;
> > @@ -916,6 +917,9 @@ static void add_paths(void)
> >  
> >  static void heartbeat(void)
> >  {
> > +	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
> > +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> > +
> >  	kill(getppid(), SIGUSR1);
> >  }
> >  
> > @@ -925,6 +929,9 @@ static void testrun(void)
> >  	unsigned long long stop_time = 0;
> >  	int cont = 1;
> >  
> > +	if (tst_clock_gettime(CLOCK_MONOTONIC, &tst_start_time))
> > +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> >  	add_paths();
> >  	do_test_setup();
> >  
> > @@ -992,6 +999,21 @@ static void sigint_handler(int sig
> > LTP_ATTRIBUTE_UNUSED)
> >  	}
> >  }
> 
> Looks correct to me.
> 
> I do wonder if it shouldn't suffice to add clock_gettime at the start of
> the run_test() function.

I didn't want to do that, because a test might want calculate something
based on timeout in setup(), for example to find current overall timeout
value with LTP_TIMEOUT_MUL taken into account.

For that to work, we have to initialize tst_start_time prior to
tst_test->setup().

> That would mean that we would be taking the
> timestamps slightly out-of-sync with the code that sets the alarm, but I
> doubt that it will matter for a result with resolution in seconds.
> 
> > +unsigned int tst_timeout_remaining(void)
> > +{
> > +	static struct timespec now;
> > +	unsigned int elapsed;
> > +
> > +	if (tst_clock_gettime(CLOCK_MONOTONIC, &now))
> > +		tst_res(TWARN | TERRNO, "tst_clock_gettime() failed");
> > +
> > +	elapsed = tst_timespec_diff_ms(now, tst_start_time) / 1000;
> 
> Maybe we should round this correctly to be more conservative:
> 
> elapsed = (tst_timespec_diff_ms(now, tst_start_time) + 500) / 1000;

Agreed, I'll add this.

> 
> > +	if (results->timeout > elapsed)
> > +		return results->timeout - elapsed;
> > +
> > +	return 0;
> > +}
> > +
> >  void tst_set_timeout(int timeout)
> >  {
> >  	char *mul = getenv("LTP_TIMEOUT_MUL");
> 
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
