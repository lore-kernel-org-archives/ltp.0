From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Tue, 31 Mar 2020 14:54:42 +0800
Subject: [LTP] [PATCH V3] uart: add uart testcase in kernel device-drivers
Message-ID: <20200331065442.28591-1-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <gengcixi@gmail.com>

---
the serialcheck.c is from github(https://github.com/nsekhar/serialcheck.git)

the uart.sh refer to ltp-ddt serialcheck.sh testcase.

test log:
    <<<test_output>>>
    incrementing stop
    serialcheck 1 TINFO: timeout per run is 0h 5m 0s
    serialcheck 1 TINFO: start test on /dev/ttyS0 115200
    1+0 records in
    1+0 records out
    57600 bytes (58 kB, 56 KiB) copied, 0.002604 s, 22.1 MB/s
    Needed 0 reads 1 writes loops 5 / 5
    cts: 0 dsr: 0 rng: 0 dcd: 0 rx: 0 tx: 283968 frame 0 ovr 0 par: 0 brk: 0 buf_ovrr: 0
    serialcheck 1 TPASS: uart /dev/ttyS0 test 115200 passed
    serialcheck 1 TCONF: ttyS1 port is used, skip
    
    Summary:
    passed   1
    failed   0
    skipped  1
    warnings 0
    <<<execution_status>>>
    initiation_status="ok"
    duration=25 termination_type=exited termination_id=0 corefile=no
    cutime=21 cstime=36
    <<<test_end>>>
---

use serialcheck tool test uart device in loopback mode.
the shell scripts can automatically detect the machine's
uart device, and filter out the busy used port. then run
serialcheck to test

Signed-off-by: Carlos Hernandez <ceh@ti.com>
Signed-off-by: Orson Zhai <orsonzhai@gmail.com>
Signed-off-by: Cixi Geng <gengcixi@gmail.com>
---
 runtest/uart                                  |   6 +
 testcases/kernel/device-drivers/Makefile      |   1 +
 testcases/kernel/device-drivers/uart/Makefile |  13 +
 .../kernel/device-drivers/uart/serialcheck.c  | 578 ++++++++++++++++++
 testcases/kernel/device-drivers/uart/uart.sh  |  61 ++
 5 files changed, 659 insertions(+)
 create mode 100644 runtest/uart
 create mode 100644 testcases/kernel/device-drivers/uart/Makefile
 create mode 100644 testcases/kernel/device-drivers/uart/serialcheck.c
 create mode 100755 testcases/kernel/device-drivers/uart/uart.sh

diff --git a/runtest/uart b/runtest/uart
new file mode 100644
index 000000000..990a011af
--- /dev/null
+++ b/runtest/uart
@@ -0,0 +1,6 @@
+# uart test in loopback mode
+uart_9600_k uart.sh 9600 5 k
+uart_19200_k uart.sh 19200 5 k
+uart_38400_k uart.sh 38400 5 k
+uart_57600_k  uart.sh 57600 5 k
+uart_115200_k uart.sh 115200 5 k
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 55e0d25a0..a214f211b 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -27,6 +27,7 @@ SUBDIRS		:= acpi \
 		   rtc \
 		   tbio \
 		   uaccess \
+		   uart \
 		   zram
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/device-drivers/uart/Makefile b/testcases/kernel/device-drivers/uart/Makefile
new file mode 100644
index 000000000..05e41d444
--- /dev/null
+++ b/testcases/kernel/device-drivers/uart/Makefile
@@ -0,0 +1,13 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2014-2015 Oracle and/or its affiliates. All Rights Reserved.
+
+top_srcdir	?= ../../../..
+
+CFLAGS+=-O2 -Wall -Wextra -g -Wno-sign-compare -Wno-pointer-sign
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+INSTALL_TARGETS		:= *.sh serialcheck
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/uart/serialcheck.c b/testcases/kernel/device-drivers/uart/serialcheck.c
new file mode 100644
index 000000000..1b75a819c
--- /dev/null
+++ b/testcases/kernel/device-drivers/uart/serialcheck.c
@@ -0,0 +1,578 @@
+#include <argp.h>
+#include <string.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <termios.h>
+#include <stdarg.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <stdint.h>
+#include <poll.h>
+#include <sys/ioctl.h>
+#include <signal.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <inttypes.h>
+
+#include <linux/serial.h>
+
+#define TIOCM_OUT1	0x2000
+#define TIOCM_OUT2	0x4000
+#define TIOCM_LOOP	0x8000
+
+#define __same_type(a, b)	__builtin_types_compatible_p(typeof(a), typeof(b))
+#define BUILD_BUG_ON_ZERO(e)	(sizeof(struct { int:-!!(e); }))
+#define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
+#define ARRAY_SIZE(arr)	(sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
+
+
+#define min(x, y) ({			\
+		typeof(x) _min1 = (x);	\
+		typeof(y) _min2 = (y);	\
+		(void) (&_min1 == &_min2);	\
+		_min1 < _min2 ? _min1 : _min2;	})
+
+static const char hex_asc[] = "0123456789abcdef";
+#define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
+#define hex_asc_hi(x)	hex_asc[((x) & 0xf0) >> 4]
+
+volatile sig_atomic_t is_interrupted = 0;
+
+void sigint_handler(int sig)
+{
+	printf("Caught signal %d\n", sig);
+	is_interrupted = 1;
+}
+
+struct g_opt {
+	char *uart_name;
+	char *file_trans;
+	unsigned int baudrate;
+#define MODE_DUPLEX	(MODE_TX_ONLY | MODE_RX_ONLY)
+#define MODE_TX_ONLY	(1 << 0)
+#define MODE_RX_ONLY	(1 << 1)
+	unsigned int mode;
+	unsigned int loops;
+	unsigned char hflow;
+	unsigned char do_termios;
+	unsigned char *cmp_buff;
+	unsigned char loopback;
+};
+
+/* name, key, arg, flags, doc, group */
+static struct argp_option options[] = {
+	{"baud",	'b', "NUM",  0, "baudrate", 0},
+	{"device",	'd', "FILE", 0, "serial node device", 0},
+	{"file",	'f', "FILE", 0, "binary file for transfers", 0},
+	{"hflow",	'h', NULL,   0, "enable hardware flow control", 0},
+	{"mode",	'm', "M",    0, "transfer mode (d = duplex, t = send r = receive)", 0},
+	{"loops",	'l', "NUM",  0, "loops to perform (0 => wait fot CTRL-C", 0},
+	{"no-termios",	'n', NULL,   0, "No termios change (baud rate etc. remains unchanged)", 0},
+	{"loopback",	'k', NULL,   0, "loopback mode", 0},
+	{NULL, 0, NULL, 0, NULL, 0}
+};
+
+static error_t parse_opt(int key, char *arg, struct argp_state *state)
+{
+	struct g_opt *go = state->input;
+	unsigned long long num;
+	char *p;
+	error_t ret = 0;
+
+	switch (key) {
+	case ARGP_KEY_INIT:
+		memset(go, 0, sizeof(*go));
+		go->baudrate = 115200;
+		go->loops = UINT_MAX;
+		go->do_termios = 1;
+		go->loopback = 0;
+		break;
+	case ARGP_KEY_ARG:
+		ret =  ARGP_ERR_UNKNOWN;
+		break;
+	case 'b':
+		num = strtoul(arg, &p, 0);
+		if (!num || num > UINT_MAX || *p != '\0') {
+			printf("Unsupported baudrate: %s\n", arg);
+			ret =  ARGP_ERR_UNKNOWN;
+		} else
+			go->baudrate = num;
+		break;
+	case 'd':
+		free(go->uart_name);
+		go->uart_name = strdup(arg);
+		break;
+	case 'f':
+		free(go->file_trans);
+		go->file_trans = strdup(arg);
+		break;
+	case 'h':
+		go->hflow = 1;
+		break;
+	case 'm':
+		if (arg[0] == 'r')
+			go->mode = MODE_RX_ONLY;
+		else if (arg[0] == 't')
+			go->mode = MODE_TX_ONLY;
+		else if (arg[0] == 'd')
+			go->mode = MODE_DUPLEX;
+		else {
+			printf("Unsuported mode: %s\n", arg);
+			ret = ARGP_ERR_UNKNOWN;
+		}
+		break;
+	case 'n':
+		go->do_termios = 0;
+		break;
+	case 'l':
+		num = strtoull(arg, &p, 0);
+		if (num >= UINT_MAX || *p != '\0') {
+			printf("Unsuported loop count: %s\n", arg);
+			ret = ARGP_ERR_UNKNOWN;
+		} else
+			go->loops = num;
+		break;
+	case 'k':
+		go->loopback = 1;
+		break;
+	default:
+		ret = ARGP_ERR_UNKNOWN;
+	}
+	return ret;
+}
+
+static struct argp argp = {
+	.options = options,
+	.parser = parse_opt,
+	.doc = "user stress testing tool",
+};
+
+static void dieh(const char *s)
+{
+	printf("Error: %s. Use --help\n", s);
+	exit(1);
+}
+
+static void die(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vprintf(fmt, ap);
+	va_end(ap);
+	exit(1);
+}
+
+static int print_ret_neg(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vprintf(fmt, ap);
+	va_end(ap);
+	return -1;
+}
+
+static int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	int i;
+
+	i = vsnprintf(buf, size, fmt, args);
+
+	if (i < size)
+		return i;
+	if (size != 0)
+		return size - 1;
+	return 0;
+}
+
+static int scnprintf(char *buf, size_t size, const char *fmt, ...)
+{
+	va_list args;
+	int i;
+
+	va_start(args, fmt);
+	i = vscnprintf(buf, size, fmt, args);
+	va_end(args);
+
+	return i;
+}
+
+
+static void hex_dump_to_buffer(const void *buf, size_t len, int rowsize,
+		int groupsize, char *linebuf, size_t linebuflen,
+		int ascii)
+{
+	const uint8_t *ptr = buf;
+	uint8_t ch;
+	int j, lx = 0;
+	int ascii_column;
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	if (!len)
+		goto nil;
+	if (len > rowsize)              /* limit to one line at a time */
+		len = rowsize;
+	if ((len % groupsize) != 0)     /* no mixed size output */
+		groupsize = 1;
+
+	switch (groupsize) {
+	case 8: {
+		const uint64_t *ptr8 = buf;
+		int ngroups = len / groupsize;
+
+		for (j = 0; j < ngroups; j++)
+			lx += scnprintf(linebuf + lx, linebuflen - lx,
+					"%s%16.16llx", j ? " " : "",
+					(unsigned long long)*(ptr8 + j));
+		ascii_column = 17 * ngroups + 2;
+		break;
+		}
+
+	case 4: {
+		const uint32_t *ptr4 = buf;
+		int ngroups = len / groupsize;
+
+		for (j = 0; j < ngroups; j++)
+			lx += scnprintf(linebuf + lx, linebuflen - lx,
+					"%s%8.8x", j ? " " : "", *(ptr4 + j));
+		ascii_column = 9 * ngroups + 2;
+		break;
+		}
+
+	case 2: {
+		const uint16_t *ptr2 = buf;
+		int ngroups = len / groupsize;
+
+		for (j = 0; j < ngroups; j++)
+			lx += scnprintf(linebuf + lx, linebuflen - lx,
+					"%s%4.4x", j ? " " : "", *(ptr2 + j));
+		ascii_column = 5 * ngroups + 2;
+		break;
+		}
+
+	default:
+		for (j = 0; (j < len) && (lx + 3) <= linebuflen; j++) {
+			ch = ptr[j];
+			linebuf[lx++] = hex_asc_hi(ch);
+			linebuf[lx++] = hex_asc_lo(ch);
+			linebuf[lx++] = ' ';
+			if (j == 7)
+				linebuf[lx++] = ' ';
+		}
+		if (j)
+			lx--;
+
+		ascii_column = 3 * rowsize + 2 + 2;
+		break;
+	}
+	if (!ascii)
+		goto nil;
+
+	while (lx < (linebuflen - 1) && lx < (ascii_column - 1))
+		linebuf[lx++] = ' ';
+	for (j = 0; (j < len) && (lx + 2) < linebuflen; j++) {
+		ch = ptr[j];
+		linebuf[lx++] = (isascii(ch) && isprint(ch)) ? ch : '.';
+	}
+nil:
+	linebuf[lx++] = '\0';
+}
+
+static void print_hex_dump(const void *buf, size_t len, int offset)
+{
+	const uint8_t *ptr = buf;
+	int i, linelen, remaining = len;
+	unsigned char linebuf[32 * 3 + 2 + 32 + 2 + 1];
+	int rowsize = 16;
+	int groupsize = 1;
+
+	if (rowsize != 16 && rowsize != 32)
+		rowsize = 16;
+
+	for (i = 0; i < len; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		hex_dump_to_buffer(ptr + i, linelen, rowsize, groupsize,
+				linebuf, sizeof(linebuf), 1);
+
+		printf("%.8x: %s\n", i + offset, linebuf);
+	}
+}
+
+static int stress_test_uart_once(struct g_opt *opts, int fd, unsigned char *data,
+		off_t data_len)
+{
+	unsigned char *cmp_data = opts->cmp_buff;
+	ssize_t size;
+	int wait_rx;
+	int wait_tx;
+	ssize_t progress_rx = 0;
+	ssize_t progress_tx = 0;
+	unsigned int reads = 0;
+	unsigned int writes = 0;
+
+	do {
+		struct pollfd pfd = {
+			.fd = fd,
+		};
+		int ret;
+
+		if (opts->mode & MODE_RX_ONLY && progress_rx < data_len) {
+			pfd.events |= POLLIN;
+			wait_rx = 1;
+		} else {
+			wait_rx = 0;
+		}
+
+		if (opts->mode & MODE_TX_ONLY && progress_tx < data_len) {
+			pfd.events |= POLLOUT;
+			wait_tx = 1;
+		} else {
+			wait_tx = 0;
+		}
+
+		ret = poll(&pfd, 1, 100 * 1000);
+		if (ret == 0) {
+			printf("\ntimeout, RX/TX: %zd/%zd\n", progress_rx, progress_tx);
+			break;
+		}
+		if (ret < 0)
+			return print_ret_neg("\npoll() failed: %m\n");
+
+		if (pfd.revents & POLLIN) {
+
+			size = read(fd, cmp_data + progress_rx, data_len - progress_rx);
+			if (size < 0)
+				return print_ret_neg("\nRead failed: %m\n");
+			reads++;
+			progress_rx += size;
+			if (progress_rx >= data_len)
+				wait_rx = 0;
+		}
+
+		if (pfd.revents & POLLOUT) {
+
+			size = write(fd, data + progress_tx, data_len - progress_tx);
+			if (size < 0)
+				return print_ret_neg("\nwrite failed: %m\n");
+			writes++;
+			progress_tx += size;
+			if (progress_tx >= data_len)
+				wait_tx = 0;
+		}
+	} while (wait_rx || wait_tx);
+
+	printf("Needed %u reads %u writes ", reads, writes);
+	if (opts->mode & MODE_RX_ONLY && memcmp(data, cmp_data, data_len)) {
+		unsigned int i;
+		int found = 0;
+		unsigned int min_pos;
+		unsigned int max_pos;
+
+		for (i = 0; i < data_len && !found; i++) {
+			if (data[i] != cmp_data[i]) {
+				found = 1;
+				break;
+			}
+		}
+
+		if (!found)
+			print_ret_neg("\nmemcmp() didn't match but manual cmp did\n");
+
+		max_pos = (i & ~0xfULL) + 16 * 3;
+		if (max_pos > data_len)
+			max_pos = data_len;
+
+		min_pos = i & ~0xfULL;
+		if (min_pos > 16 * 3)
+			min_pos -= 16 * 3;
+		else
+			min_pos = 0;
+
+		printf("Oh oh, inconsistency at pos %d (0x%x).\n", i, i);
+
+		printf("\nOriginal sample:\n");
+		print_hex_dump(data + min_pos, max_pos - min_pos, min_pos);
+
+		printf("\nReceived sample:\n");
+		print_hex_dump(cmp_data + min_pos, max_pos - min_pos, min_pos);
+		return -1;
+	}
+	return 0;
+}
+
+static int stress_test_uart(struct g_opt *opts, int fd, unsigned char *data,
+		off_t data_len)
+{
+	unsigned int loops = 0;
+	int status;
+
+	opts->cmp_buff = malloc(data_len);
+	if (!opts->cmp_buff)
+		die("Failed to malloc(%d): %m\n", data_len);
+	memset(opts->cmp_buff, 0, data_len);
+
+	do {
+		status = stress_test_uart_once(opts, fd, data, data_len);
+		memset(opts->cmp_buff, 0, data_len);
+		printf("loops %u / %u%c[K\n", loops + 1, opts->loops, 27);
+		if (!status)
+			printf("%cM", 27);
+	} while (++loops < opts->loops && !status && !is_interrupted);
+	printf("\n");
+	free(opts->cmp_buff);
+	return status;
+}
+
+void set_modem(int fd, int bits, int mask)
+{
+	int status, ret;
+
+	ret = ioctl(fd, TIOCMGET, &status);
+	if (ret < 0)
+		die("mcr get failed: %m\n");
+
+	status = (status & ~mask) | (bits & mask);
+
+	ret = ioctl(fd, TIOCMSET, &status);
+	if (ret < 0)
+		die("mcr set failed: %m\n");
+}
+
+int main(int argc, char *argv[])
+{
+	struct g_opt opts;
+	struct sigaction sigint_action;
+	struct termios old_term, new_term;
+	struct serial_icounter_struct old_counters;
+	struct serial_icounter_struct new_counters;
+	struct stat data_stat;
+	struct rlimit rlim;
+	int fd;
+	int ret;
+	int status;
+	int flags;
+	unsigned char *data;
+	unsigned int open_mode;
+	off_t data_len;
+
+	argp_parse(&argp, argc, argv, 0, NULL, &opts);
+	if (!opts.file_trans)
+		dieh("Missing file for transfers");
+	if (!opts.uart_name)
+		dieh("Missing uart node");
+	if (!opts.mode)
+		dieh("Missing mode");
+
+	fd = open(opts.file_trans, O_RDONLY);
+	if (fd < 0)
+		die("Failed to open %s: %m\n", opts.file_trans);
+
+	ret = fstat(fd, &data_stat);
+	if (ret < 0)
+		die("stat on %s failed: %m\n", opts.file_trans);
+
+	data_len = data_stat.st_size;
+
+	ret = getrlimit(RLIMIT_MEMLOCK, &rlim);
+	if (ret < 0)
+		die("getrlimit() failed: %m\n");
+
+	flags = MAP_SHARED | MAP_POPULATE;
+	if (rlim.rlim_cur < (rlim_t)data_len)
+		printf("File of %jd bytes can't be locked\n", (intmax_t)data_len);
+	else
+		flags |= MAP_LOCKED;
+
+	data = mmap(NULL, data_len, PROT_READ, flags, fd, 0);
+	if (data == MAP_FAILED)
+		die("mmap() of %s size %d failed: %m\n", opts.file_trans,
+				data_len);
+	close(fd);
+
+	if (opts.mode == MODE_TX_ONLY)
+		open_mode = O_WRONLY;
+	else if (opts.mode == MODE_RX_ONLY)
+		open_mode = O_RDONLY;
+	else if (opts.mode == MODE_DUPLEX)
+		open_mode = O_RDWR;
+	else
+		die("Unknown mode?\n");
+
+	sigint_action.sa_handler = sigint_handler;
+	sigemptyset(&sigint_action.sa_mask);
+	sigint_action.sa_flags = 0;
+	sigaction(SIGINT, &sigint_action, NULL);
+
+	fd = open(opts.uart_name, open_mode | O_NONBLOCK);
+	if (fd < 0)
+		die("Failed to open %s: %m\n", opts.uart_name);
+
+	ret = tcgetattr(fd, &old_term);
+	if (ret < 0)
+		die("tcgetattr() failed: %m\n");
+
+	new_term = old_term;
+
+	/* or c_cflag |= BOTHER and c_ospeed for any speed */
+	ret = cfsetspeed(&new_term, opts.baudrate);
+	if (ret < 0)
+		die("cfsetspeed(, %u) failed %m\n", opts.baudrate);
+	cfmakeraw(&new_term);
+	new_term.c_cflag |= CREAD;
+	if (opts.hflow)
+		new_term.c_cflag |= CRTSCTS;
+	else
+		new_term.c_cflag &= ~CRTSCTS;
+	new_term.c_cc[VMIN] = 64;
+	new_term.c_cc[VTIME] = 8;
+
+	ret = tcsetattr(fd, TCSANOW, &new_term);
+	if (ret < 0)
+		die("tcsetattr failed: %m\n");
+
+	if (opts.do_termios) {
+		ret = tcflush(fd, TCIFLUSH);
+		if (ret < 0)
+			die("tcflush failed: %m\n");
+	}
+
+	ret = fcntl(fd, F_SETFL, 0);
+	if (ret)
+		printf("Failed to remove nonblock mode\n");
+
+	set_modem(fd, opts.loopback ? TIOCM_LOOP : 0, TIOCM_LOOP);
+
+	ret = ioctl(fd, TIOCGICOUNT, &old_counters);
+
+	status = stress_test_uart(&opts, fd, data, data_len);
+
+	if (!ret) {
+		ret = ioctl(fd, TIOCGICOUNT, &new_counters);
+		if (!ret) {
+#define CNT(x) (new_counters.x - old_counters.x)
+			printf("cts: %d dsr: %d rng: %d dcd: %d rx: %d tx: %d "
+			"frame %d ovr %d par: %d brk: %d buf_ovrr: %d\n",
+			CNT(cts), CNT(dsr), CNT(rng), CNT(dcd), CNT(rx),
+			CNT(tx), CNT(frame), CNT(overrun), CNT(parity),
+			CNT(brk), CNT(buf_overrun));
+#undef CNT
+		}
+	}
+	if (ret)
+		printf("Failed to ioctl(,TIOCGICOUNT,)\n");
+
+	set_modem(fd, 0, TIOCM_LOOP);
+
+	ret = tcsetattr(fd, TCSAFLUSH, &old_term);
+	if (ret)
+		printf("tcsetattr() of old ones failed: %m\n");
+
+	close(fd);
+	return status;
+}
diff --git a/testcases/kernel/device-drivers/uart/uart.sh b/testcases/kernel/device-drivers/uart/uart.sh
new file mode 100755
index 000000000..93438302f
--- /dev/null
+++ b/testcases/kernel/device-drivers/uart/uart.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com/
+# Copyright (C) 2019, Unisoc Communications Inc.
+#
+# Test UART ports using git://git.breakpoint.cc/bigeasy/serialcheck.git
+
+TST_TESTFUNC=do_test
+TST_POS_ARGS=3
+TST_USAGE=usage
+TST_NEEDS_ROOT=1
+TST_NEEDS_CMDS="lsof dd"
+TST_NEEDS_TMPDIR=1
+
+. tst_test.sh
+
+usage()
+{
+    echo "usage: ./${0} {-r UART_RATE} {-l LOOPS} {-h|k to enable HW flow control or loopback}"
+    exit 1
+}
+
+UART_RATE=$1
+UART_LOOPS=$2
+UART_MODE=$3
+
+test_serial()
+{
+    dd if=/dev/urandom of=binary count=1 bs=$((UART_RATE / 2))
+    serialcheck -b $UART_RATE -d $1 -f binary -l $UART_LOOPS -m r -${UART_MODE} &
+    PID=$!
+    if serialcheck -b $UART_RATE -d $1 -f binary -l $UART_LOOPS -m t -${UART_MODE} ;then
+        tst_res TPASS "uart $1 test $UART_RATE passed"
+    else
+        kill -- -$PID 2>/dev/null
+        tst_res TFAIL "uart $1 test $UART_RATE failed"
+    fi
+}
+
+do_test()
+{
+    local i
+    for i in /sys/class/tty/*/uartclk ;do
+        PORT=`echo $i |cut -d '/' -f 5`
+        # Activate port in case it will be initialized only when startup
+        echo "UART TESTING">${PORT} 2>/dev/null
+        PORT_TO_TEST=""
+        if [ `cat /sys/class/tty/${PORT}/uartclk` -ne 0 ]; then
+            lsof | grep "/dev/${PORT}" &> /dev/null || PORT_TO_TEST="/dev/${PORT}"
+            if [ x"${PORT_TO_TEST}" = x ] ;then
+                tst_res TCONF "${PORT} port is used, skip"
+            else
+                tst_res TINFO "start test on ${PORT_TO_TEST} ${UART_RATE}"
+                test_serial ${PORT_TO_TEST}
+            fi
+        fi
+    done
+}
+
+tst_run
-- 
2.17.1

