From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Dec 2015 16:57:23 +0100
Subject: [LTP] [PATCH V2] Add testcases to test the kernel input stack
In-Reply-To: <1448901816-8540-1-git-send-email-chnyda@suse.com>
References: <1448901816-8540-1-git-send-email-chnyda@suse.com>
Message-ID: <20151203155722.GF29110@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This version looks much better. A few comments below.

> +++ b/testcases/kernel/input/input01.c
> @@ -0,0 +1,185 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> + /*
> + *
> + *  Create a virtual device (mouse), send events to /dev/uinput
> + *  and check that the events are well received in /dev/input/eventX
> + *
> + */
> +
> +#include <linux/input.h>
> +#include <linux/uinput.h>
> +#include <fnmatch.h>

Here as well, the fnmatch.h is no longer needed.

> +#include "input_helper.h"
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +
> +#define NB_TEST 100
> +
> +static void setup(void);
> +static void send_information(void);
> +static int verify_data(struct input_event *iev, int *nb);
> +static int check_information(void);
> +static void cleanup(void);
> +
> +static int fd;
> +static int fd2;
> +
> +char *TCID = "input01";
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int pid;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
> +
> +		setup();
> +		pid = tst_fork();
> +
> +		if (!pid) {
> +			send_information();
> +			cleanup();
> +		} else {
> +			fd2 = setup_read();
> +			if (check_information())
> +				tst_resm(TFAIL,
> +					"Wrong data received in eventX");
> +			else
> +				tst_resm(TPASS, "Data received in eventX");
> +		}
> +	}
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	fd = open_uinput();
> +
> +	setup_mouse_events(fd);
> +
> +	create_device(fd);
> +}
> +
> +static void send_information(void)
> +{
> +	int nb;
> +
> +	for (nb = 0; nb < NB_TEST; ++nb) {
> +		send_rel_move(fd, 10, 1);
> +		usleep(100);
> +	}
> +}
> +
> +static int check_information(void)
> +{
> +	int nb;
> +	int fail;
> +	int rd;
> +	uint i;
> +	struct input_event iev[64];
> +
> +	fail = 0;
> +	nb = 0;
> +
> +	while (nb < NB_TEST * 3 && !fail) {
> +		rd = read(fd2, iev, sizeof(struct input_event) * 64);
> +
> +		if (rd == 0 || rd % sizeof(struct input_event) != 0) {
> +			tst_resm(TINFO,
> +				"Unexpected return value of read: %i", rd);
> +			fail = 1;
> +		}
> +
> +		for (i = 0; i < rd / sizeof(struct input_event) && !fail; i++)
> +			fail = verify_data(&iev[i], &nb);
> +	}
> +
> +	SAFE_CLOSE(NULL, fd2);
> +	return fail;
> +}
> +
> +static int verify_data(struct input_event *iev, int *nb)
> +{
> +	if (*nb % 3 == 0) {
> +		if (iev->type != EV_REL) {
> +			tst_resm(TINFO,
> +				"%i: Unexpected event type %i expected %i",
> +					*nb, iev->type, EV_REL);
> +			return 1;
> +		}
> +
> +		if (iev->code != REL_X)
> +			return 1;
> +
> +		if (iev->value != 10)
> +			return 1;
> +
> +		(*nb)++;
> +		return 0;
> +	}
> +
> +	if (*nb % 3 == 1) {
> +		if (iev->type != EV_REL) {
> +			tst_resm(TINFO,
> +				"%i: Unexpected event type %i expected %i",
> +				*nb, iev->type, EV_REL);
> +			return 1;
> +		}
> +
> +		if (iev->code != REL_Y)
> +			return 1;
> +
> +		if (iev->value != 1)
> +			return 1;
> +
> +		(*nb)++;
> +		return 0;
> +	}
> +
> +	if (*nb % 3 == 2) {
> +		if (iev->type != EV_SYN) {
> +			tst_resm(TINFO,
> +				"%i: Unexpected event type %i expected %i",
> +					*nb, iev->type, EV_SYN);
> +			return 1;
> +		}
> +
> +		if (iev->code != 0)
> +			return 1;
> +
> +		if (iev->value != 0)
> +			return 1;
> +
> +		(*nb)++;
> +		return 0;
> +	}
> +	return 1;
> +}
> +
> +static void cleanup(void)
> +{
> +	destroy_device(fd);
> +}
> diff --git a/testcases/kernel/input/input02.c b/testcases/kernel/input/input02.c
> new file mode 100644
> index 0000000..691f367
> --- /dev/null
> +++ b/testcases/kernel/input/input02.c
> @@ -0,0 +1,100 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> + /*
> + *
> + *  Create a virtual device (mouse), send events to /dev/uinput
> + *  and check that the events are not received in /dev/input/eventX
> + *  because the device is grabbed by another process
> + *
> + */
> +
> +#include <linux/input.h>
> +#include <linux/uinput.h>
> +#include <fnmatch.h>

Here as well, the fnmatch.h is no longer needed.

> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "input_helper.h"
> +
> +#define NB_TEST 100
> +
> +static void setup(void);
> +static void send_information(void);
> +static void cleanup(void);
> +
> +static int fd;
> +static int fd2;
> +
> +char *TCID = "input02";
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int pid;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
> +
> +		setup();
> +		pid = tst_fork();
> +		fd2 = setup_read();
> +
> +		if (!pid) {
> +			send_information();
> +			cleanup();
> +		} else {
> +			if (check_no_data(fd2))
> +				tst_resm(TPASS, "No data received in eventX");
> +			else
> +				tst_resm(TFAIL, "Data received in eventX");
> +		}
> +	}
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	fd = open_uinput();
> +
> +	setup_mouse_events(fd);
> +
> +	create_device(fd);
> +}
> +
> +static void send_information(void)
> +{
> +	int nb;
> +
> +	SAFE_IOCTL(NULL, fd2, EVIOCGRAB, 1);
> +	tst_resm(TINFO, "The virtual device was grabbed");
> +
> +	for (nb = 0; nb < NB_TEST; ++nb) {
> +		send_rel_move(fd, 10, 1);
> +		usleep(100);
> +	}
> +}
> +
> +static void cleanup(void)
> +{
> +	destroy_device(fd);
> +}
> diff --git a/testcases/kernel/input/input03.c b/testcases/kernel/input/input03.c
> new file mode 100644
> index 0000000..6e312d7
> --- /dev/null
> +++ b/testcases/kernel/input/input03.c
> @@ -0,0 +1,126 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> + /*
> + *
> + *  Create a virtual device (mouse), send events to /dev/uinput
> + *  and check that the events are well received in /dev/input/mice
> + *
> + */
> +
> +#include <linux/input.h>
> +#include <linux/uinput.h>
> +#include <fnmatch.h>

Here as well, the fnmatch.h is no longer needed.

> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "input_helper.h"
> +
> +#define NB_TEST 100
> +#define X_VALUE 10
> +#define Y_VALUE 10
> +
> +static void setup(void);
> +static void send_information(void);
> +static int check_information(void);
> +static void cleanup(void);
> +
> +static int fd;
> +static int fd2;
> +
> +char *TCID = "input03";
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int pid;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
> +
> +		setup();
> +		pid = tst_fork();
> +
> +		if (!pid) {
> +			send_information();
> +			cleanup();
> +		} else {
> +			if (check_information())
> +				tst_resm(TFAIL, "Wrong data received");
> +			else
> +				tst_resm(TPASS,
> +					"Data received in /dev/input/mice");
> +		}
> +	}
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	fd = open_uinput();
> +
> +	setup_mouse_events(fd);
> +
> +	create_device(fd);
> +}
> +
> +static void send_information(void)
> +{
> +	int nb;
> +
> +	for (nb = 0; nb < NB_TEST; ++nb) {
> +
> +		send_rel_move(fd, X_VALUE, Y_VALUE);
> +		usleep(100);
> +	}
> +}
> +
> +static int check_information(void)
> +{
> +	int nb;
> +	int fail;
> +	int rd;
> +	char buf[3];
> +
> +	fd2 = SAFE_OPEN(NULL, "/dev/input/mice", O_RDONLY);
> +	fail = 0;
> +	nb = 0;
> +
> +	while (nb < NB_TEST && !fail) {
> +		memset(buf, 0, 3);
> +		rd = read(fd2, buf, 3);
> +
> +		if (rd < 3)
> +			fail = 1;
> +		if (buf[1] != X_VALUE || buf[2] != -Y_VALUE || buf[0] != 40)
> +			fail = 1;
> +		nb++;

Here as well. I guess that the test may fail if we move the mouse while
it runs.

Maybe we can make it fail only if we do not get the expected events (and
ignore everything else)...

> +	}
> +
> +	SAFE_CLOSE(NULL, fd2);
> +	return fail;
> +}
> +
> +static void cleanup(void)
> +{
> +	destroy_device(fd);
> +}
> diff --git a/testcases/kernel/input/input04.c b/testcases/kernel/input/input04.c
> new file mode 100644
> index 0000000..c41e6b9
> --- /dev/null
> +++ b/testcases/kernel/input/input04.c
> @@ -0,0 +1,116 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> + /*
> + *
> + *  Create a virtual device (mouse), send empty events to /dev/uinput
> + *  and check that the events are not received in /dev/input/mice
> + *
> + */
> +
> +#include <linux/input.h>
> +#include <linux/uinput.h>
> +#include <fnmatch.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "input_helper.h"
> +
> +#define NB_TEST 100
> +#define X_VALUE 0
> +#define Y_VALUE 0

The X_VALUE and Y_VALUE are not used, please remove them.

> +static void setup(void);
> +static void send_information(void);
> +static int check_information(void);
> +static void cleanup(void);
> +
> +static int fd;
> +static int fd2;
> +
> +char *TCID = "input04";
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int pid;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
> +
> +		setup();
> +		pid = tst_fork();
> +
> +		if (!pid) {
> +			send_information();
> +			cleanup();
> +		} else {
> +			if (check_information())
> +				tst_resm(TPASS,
> +					"No data received in /dev/input/mice");
> +			else
> +				tst_resm(TFAIL,
> +					"Data received /dev/input/mice");
> +		}
> +	}
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	fd = open_uinput();
> +
> +	setup_mouse_events(fd);
> +
> +	create_device(fd);
> +}
> +
> +static void send_information(void)
> +{
> +	int nb;
> +
> +	for (nb = 0; nb < NB_TEST; ++nb)
> +		send_rel_move(fd, 0, 0);
> +}
> +
> +static int check_information(void)
> +{
> +	int rv;
> +	struct timeval timeout;
> +	fd_set set;
> +
> +	fd2 = SAFE_OPEN(NULL, "/dev/input/mice", O_RDWR);
> +	FD_ZERO(&set);
> +	FD_SET(fd2, &set);
> +	timeout.tv_sec = 0;
> +	timeout.tv_usec = 200000;
> +	rv = select(fd2 + 1, &set, NULL, NULL, &timeout);
> +	if (rv < 0)
> +		tst_brkm(TBROK, NULL, "select failed");
> +	SAFE_CLOSE(NULL, fd2);
> +	return rv == 0;
> +}

Hmm, I guess that the /dev/input/mice tests may fail if you move your
mouse while they run. I guess that we should at least add a warning to
the test description.

Or we can make the testcase more robust and expecte that no events with
relx == 0 and rely == 0 are generated (and ignore everything else).

> +static void cleanup(void)
> +{
> +	destroy_device(fd);
> +}
> diff --git a/testcases/kernel/input/input05.c b/testcases/kernel/input/input05.c
> new file mode 100644
> index 0000000..07e5d79
> --- /dev/null
> +++ b/testcases/kernel/input/input05.c
> @@ -0,0 +1,99 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> + /*
> + *
> + *  Create a virtual device (mouse), send events to /dev/uinput
> + *  and check that the events are not received in /dev/input/eventX
> + *  because it is not possible to sent such events

Maybe we should rather write something as:

"Check that events not advertised in the input device bits are filtered."


Because I had to read the text twice before I figured out what the test
should do.

> + */
> +
> +#include <linux/input.h>
> +#include <linux/uinput.h>
> +#include <fnmatch.h>

The fnmatch() is not used only in the helper, no need to include it in
the testcases, right?

> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "input_helper.h"
> +
> +#define X_VALUE 10
> +#define Y_VALUE 10
> +
> +#define NB_TEST 100
> +
> +static void setup(void);
> +static void send_information(void);
> +static void cleanup(void);
> +
> +static int fd;
> +static int fd2;
> +
> +char *TCID = "input05";
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int pid;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
> +
> +		setup();
> +		pid = tst_fork();
> +		fd2 = setup_read();
> +
> +		if (!pid) {
> +			send_information();
> +			cleanup();
> +		} else {
> +			if (check_no_data(fd2))
> +				tst_resm(TPASS, "No data received in eventX");
> +			else
> +				tst_resm(TFAIL, "Data received in eventX");
> +		}
> +	}
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	fd = open_uinput();
> +
> +	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_KEY);
> +	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, BTN_LEFT);
> +
> +	create_device(fd);
> +}
> +
> +static void send_information(void)
> +{
> +	int nb;
> +
> +	for (nb = 0; nb < NB_TEST; ++nb)
> +		send_rel_move(fd, X_VALUE, Y_VALUE);
> +}
> +
> +static void cleanup(void)
> +{
> +	destroy_device(fd);
> +}
> diff --git a/testcases/kernel/input/input06.c b/testcases/kernel/input/input06.c
> new file mode 100644
> index 0000000..c0a0c90
> --- /dev/null
> +++ b/testcases/kernel/input/input06.c
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> + /*
> + *
> + *  Create a virtual device, activate auto-repeat and
> + *  and check that auto repeat is working
> + *
> + */
> +
> +#include <linux/input.h>
> +#include <linux/uinput.h>
> +#include <fnmatch.h>
> +#include <linux/kd.h>
> +
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "lapi/fcntl.h"
> +#include "input_helper.h"
> +
> +#define NB_TEST 100
> +
> +static void setup(void);
> +static void send_information(void);
> +static int check_information(void);
> +static void cleanup(void);
> +
> +static int fd;
> +static int caps;
> +
> +char *TCID = "input06";
> +
> +int main(int ac, char **av)
> +{
> +	int lc;
> +	int pid;
> +
> +	tst_parse_opts(ac, av, NULL, NULL);
> +
> +	for (lc = 0; lc < TEST_LOOPING(lc); ++lc) {
> +
> +		setup();
> +		pid = tst_fork();
> +
> +		if (!pid) {
> +			send_information();
> +		} else {
> +			if (check_information())
> +				tst_resm(TFAIL,
> +					"Wrong data received in eventX");
> +			else
> +				tst_resm(TPASS, "Data received in eventX");
> +		}
> +	}
> +	tst_exit();
> +}
> +
> +static void setup(void)
> +{
> +	tst_require_root();
> +
> +	fd = open_uinput();
> +
> +	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_KEY);
> +	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, KEY_X);
> +	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, KEY_Y);
> +	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, KEY_ENTER);
> +
> +	create_device(fd);
> +}
> +
> +static void send_information(void)
> +{
> +	send_event(fd, EV_KEY, KEY_X, 10);
> +	send_event(fd, EV_SYN, 0, 0);
> +
> +	/* sleep to keep the key pressed for some time (auto-repeat) */
> +	sleep(1);

Hmm, I do not like the test hanging for one second to wait for
auto-repeat.

What about adjusting auto repeat values so that it kicks in in less than
0.1s?

You can apparently do that by writing EV_REP events to the device. The
REP_DELAY should control how long it takes to start auto repeat and
REP_PERIOD should control the rate once auto-repeat is active.

> +	send_event(fd, EV_KEY, KEY_Y, 10);
> +	send_event(fd, EV_KEY, KEY_ENTER, 10);
> +	send_event(fd, EV_SYN, 0, 0);
> +
> +	cleanup();
> +}
> +
> +static int check_information(void)
> +{
> +	int rd;
> +	uint i;
> +	char buf[128];
> +
> +	i = 1;
> +	rd = read(STDIN_FILENO, buf, sizeof(buf));

I do not think that this would work when the test is executed from the
runltp script. The problem is that the test driver ltp-pan runs the
testcases on background and the ltp-pan process is the process leader
(and that makes the ltp-pan the only program that gets the stdin).

I guess that we will have to open the /dev/inputXXX device and read
events from there instead.

> +	if (rd < 1)
> +		return 1;
> +
> +	if (buf[0] == 'X')
> +		caps = 32;
> +	while (buf[i] != 'y' - caps) {
> +
> +		if (buf[i] != 'x' - caps) {
> +			tst_resm(TINFO, "Unexpected input %c expected %c",
> +				buf[i], 'x' - caps);
> +			return 1;
> +		}
> +
> +		i++;
> +	}
> +
> +	if (i <= 1) {
> +		tst_resm(TINFO, "autorepeat didn't work");
> +		return 1;
> +	}
> +
> +	if (i != strlen(buf) - 2) {
> +		tst_resm(TINFO,
> +			"the buffer is filled with unwanted chararacters");
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cleanup(void)
> +{
> +	destroy_device(fd);
> +}
> diff --git a/testcases/kernel/input/input_helper.c b/testcases/kernel/input/input_helper.c
> new file mode 100644
> index 0000000..4d3b464
> --- /dev/null
> +++ b/testcases/kernel/input/input_helper.c
> @@ -0,0 +1,184 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <linux/input.h>
> +#include <linux/uinput.h>
> +#include <fnmatch.h>
> +#include <errno.h>
> +#include "test.h"
> +#include "safe_macros.h"
> +#include "input_helper.h"
> +
> +#define VIRTUAL_DEVICE_REGEX "*virtual-device-ltp*"
> +
> +static int check_device(void);
> +
> +int setup_read(void)
> +{
> +	DIR *d;
> +	char path[256];
> +	char name[256];
> +	struct dirent *dp;
> +	int fd;
> +	int ret;
> +
> +	ret = 0;
> +	fd = -1;
> +	d = opendir("/dev/input");
> +
> +	while ((dp = readdir(d))) {
> +		if (fnmatch("event[0-9]*", dp->d_name, 0) == 0) {

                You can do here:

		if (fnmatch("event[0-9]*", dp->d_name, 0))
			continue;

		To save some indentation level for the code below.
		(I also think that it's a bit more elegant that way)

> +			memset(path, 0, 256);
> +			strcat(path, "/dev/input/");
> +			strcat(path, dp->d_name);

                        Just use snprintf(path, sizeof(path), "/dev/input/%s", dp->d_name) instead.


> +			fd = open(path, O_RDONLY);
> +			if (fd < 0) {
> +				tst_resm(TINFO, "failed to open %s", path);
> +				break;
> +			}
> +			ret = ioctl(fd, EVIOCGNAME(256), name);
> +			if (ret < 0) {
> +				tst_resm(TINFO, "ioctl failed");

                                Please be more informative with these messages:

				tst_resm(TINFO | TERRNO, "ioctl(%s, EVIOCGNAME(256), ...) failed",
				         dp->d_name);
> +				break;
> +			}
> +			if (strcmp(name, VIRTUAL_DEVICE) == 0)
> +				break;
> +		}
> +	}
> +
> +	closedir(d);
> +	if (fd > 0 && ret >= 0)
> +		return fd;
> +	tst_brkm(TBROK, NULL, "unable to find the right event");
> +	return -1;
> +}
> +
> +int open_uinput(void)
> +{
> +	int fd;
> +
> +	fd = open("/dev/input/uinput", O_WRONLY | O_NONBLOCK);
> +
> +	if (fd < 0 && errno == ENOENT)
> +		fd = open("/dev/uinput", O_WRONLY | O_NONBLOCK);
> +
> +	if (fd < 0 && errno == ENOENT)
> +		tst_brkm(TCONF, NULL, "unable to find and open uinput");
> +	else if (fd < 0)
               ^
	       No need for the else, since tst_brkm() will exit the
	       test.

> +		tst_brkm(TBROK, NULL, "open failed");
                           ^
			   TERRNO here.

> +	return fd;
> +}
> +
> +void send_event(int fd, int event, int code, int value)
> +{
> +	struct input_event ev;
> +
> +	memset(&ev, 0, sizeof(struct input_event));
> +	ev.type = event;
> +	ev.code = code;
> +	ev.value = value;
> +	SAFE_WRITE(NULL, 1, fd, &ev, sizeof(struct input_event));
> +}
> +
> +void send_rel_move(int fd, int x, int y)
> +{
> +	send_event(fd, EV_REL, REL_X, x);
> +	send_event(fd, EV_REL, REL_Y, y);
> +	send_event(fd, EV_SYN, 0, 0);
> +}
> +
> +void create_device(int fd)
> +{
> +	struct uinput_user_dev uidev;
> +	int nb;
> +
> +	memset(&uidev, 0, sizeof(uidev));
> +	snprintf(uidev.name, UINPUT_MAX_NAME_SIZE, VIRTUAL_DEVICE);
> +	uidev.id.bustype = BUS_USB;
> +	uidev.id.vendor  = 0x1;
> +	uidev.id.product = 0x1;
> +	uidev.id.version = 1;
> +
> +	SAFE_WRITE(NULL, 1, fd, &uidev, sizeof(uidev));
> +	SAFE_IOCTL(NULL, fd, UI_DEV_CREATE, NULL);
> +
> +	nb = 20;
> +	do {
> +		usleep(100000);
> +		if (check_device())
> +			return;
> +		nb--;
> +
> +	} while (nb > 0);
> +
> +	destroy_device(fd);
> +	tst_brkm(TBROK, NULL, "failed to create device");
> +
> +}
> +
> +void setup_mouse_events(int fd)
> +{
> +	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_KEY);
> +	SAFE_IOCTL(NULL, fd, UI_SET_KEYBIT, BTN_LEFT);
> +	SAFE_IOCTL(NULL, fd, UI_SET_EVBIT, EV_REL);
> +	SAFE_IOCTL(NULL, fd, UI_SET_RELBIT, REL_X);
> +	SAFE_IOCTL(NULL, fd, UI_SET_RELBIT, REL_Y);
> +}
> +
> +void destroy_device(int fd)
> +{
> +	SAFE_IOCTL(NULL, fd, UI_DEV_DESTROY, NULL);
> +	SAFE_CLOSE(NULL, fd);
> +}
> +
> +/*
> + * read will eventually return ENODEV because
> + * the device will be destroyed by the other process
> + * after having sent the informations
> +*/
> +int check_no_data(int fd)
> +{
> +	int rd;
> +	struct input_event iev[64];
> +
> +	rd = read(fd, iev, sizeof(struct input_event) * 64);
> +
> +	SAFE_CLOSE(NULL, fd);
> +	return rd < 0 && errno == ENODEV;
> +}

This function is called twice right after setup_read() it would make
more sense to call the setup_read() here instead and call this function
without any parameters. Since it's not obvious that this function
actually closes the fd (the name of the function does not contain
"close" or "destroy" or something that would suggest that the file
descriptor is being closed).

> +static int check_device(void)
> +{
> +	FILE *file;
> +	char line[256];
> +
> +	file = fopen("/proc/bus/input/devices", "r");
> +	if (!file)
> +		return 0;
> +
> +	while (fgets(line, 256, file)) {
> +
> +		if (fnmatch(VIRTUAL_DEVICE_REGEX, line, 0) == 0)
> +			return 1;
> +	}
> +
> +	fclose(file);
> +
> +	return 0;
> +}
> diff --git a/testcases/kernel/input/input_helper.h b/testcases/kernel/input/input_helper.h
> new file mode 100644
> index 0000000..92c8714
> --- /dev/null
> +++ b/testcases/kernel/input/input_helper.h
> @@ -0,0 +1,37 @@
> +/*
> + * Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it would be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write the Free Software Foundation,
> + * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#ifndef INPUT_HELPER_H
> +#define INPUT_HELPER_H
> +
> +#define VIRTUAL_DEVICE "virtual-device-ltp"

This macro is not used anywhere else than in the input_helper.c code,
right? In that case it shouldn't be exported in the header.

> +#include <sys/types.h>
> +#include <dirent.h>
> +
> +char *find_event(DIR *d, char *namedir1);

This function does not seem to exists at all.

> +int setup_read(void);
> +void send_rel_move(int fd, int x, int y);
> +void send_event(int fd, int event, int code, int value);
> +int open_uinput(void);
> +void create_device(int fd);
> +void setup_mouse_events(int fd);
> +void destroy_device(int fd);
> +int check_no_data(int fd);
> +
> +#endif /* INPUT_HELPER_H */
> -- 
> 2.1.4
> 
> 
> -- 
> Mailing list info: http://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
