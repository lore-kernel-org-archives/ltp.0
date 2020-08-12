From: gengcixi@gmail.com <gengcixi@gmail.com>
Date: Wed, 12 Aug 2020 15:35:29 +0800
Subject: [LTP] [PATCH 2/2] device_drivers/uart01: uart01 test extension
In-Reply-To: <20200812073529.25715-1-gengcixi@gmail.com>
References: <20200812073529.25715-1-gengcixi@gmail.com>
Message-ID: <20200812073529.25715-2-gengcixi@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cixi Geng <cixi.geng1@unisoc.com>

expand the uart01 test to support more options:
    -f: create a file with ramdom content,and test uart use the file
	to transfer data
    -l: support to loop test with loop number
    -k: support loopback mode test

modify: make UART_Rx and UART_Tx test into the same UART_DEV for we
usually test uart transceiver function together.

This is an updated version which comes from patch written by Cyril

https://patchwork.ozlabs.org/project/ltp/patch/20200623112827.10744-3-chrubis@suse.cz/

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 runtest/kernel_misc                           | 10 +-
 testcases/kernel/device-drivers/Makefile      |  1 +
 testcases/kernel/device-drivers/uart/uart01.c | 94 +++++++++++++++----
 3 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index a7f1d9b56..977a15697 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -13,8 +13,8 @@ zram01 zram01.sh
 zram02 zram02.sh
 zram03 zram03
 umip_basic_test umip_basic_test
-uart01_9600 uart01 -b 9600
-uart01_19200 uart01 -b 19200
-uart01_38400 uart01 -b 38400
-uart01_57600 uart01 -b 57600
-uart01_115200 uart01 -b 115200
+uart01_9600 uart01 -b 9600 -f binary -k 0 -l 2
+uart01_19200 uart01 -b 19200 -f binary -k 0 -l 3
+uart01_38400 uart01 -b 38400 -f binary -k 0 -l 1
+uart01_57600 uart01 -b 57600 -f binary -k 0 -l 3
+uart01_115200 uart01 -b 115200 -f /binary -k 0 -l 5
diff --git a/testcases/kernel/device-drivers/Makefile b/testcases/kernel/device-drivers/Makefile
index 55e0d25a0..be0d88e38 100644
--- a/testcases/kernel/device-drivers/Makefile
+++ b/testcases/kernel/device-drivers/Makefile
@@ -24,6 +24,7 @@ SUBDIRS		:= acpi \
 		   locking \
 		   pci \
 		   rcu \
+		   uart \
 		   rtc \
 		   tbio \
 		   uaccess \
diff --git a/testcases/kernel/device-drivers/uart/uart01.c b/testcases/kernel/device-drivers/uart/uart01.c
index 4647c55e3..0501cb462 100644
--- a/testcases/kernel/device-drivers/uart/uart01.c
+++ b/testcases/kernel/device-drivers/uart/uart01.c
@@ -22,6 +22,10 @@
 #include <linux/serial.h>
 
 #include "tst_test.h"
+#define TIOCM_OUT1	0x2000
+#define TIOCM_OUT2	0x4000
+#define TIOCM_LOOP	0x8000
+
 
 static const char hex_asc[] = "0123456789abcdef";
 #define hex_asc_lo(x)	hex_asc[((x) & 0x0f)]
@@ -39,6 +43,7 @@ struct g_opt {
 #define MODE_DUPLEX     (MODE_TX_ONLY | MODE_RX_ONLY)
 	unsigned int mode;
 	unsigned char *cmp_buff;
+	unsigned char loopback;
 };
 
 static int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
@@ -187,7 +192,6 @@ static int stress_test_uart_once(struct g_opt *opts, int fd, unsigned char *data
 			.fd = fd,
 		};
 		int ret;
-
 		if (opts->mode & MODE_RX_ONLY && progress_rx < data_len) {
 			pfd.events |= POLLIN;
 			wait_rx = 1;
@@ -296,7 +300,6 @@ static int stress_test_uart(struct g_opt *opts, int fd, unsigned char *data, off
 
 	opts->cmp_buff = SAFE_MALLOC(data_len);
 	memset(opts->cmp_buff, 0, data_len);
-
 	do {
 		status = stress_test_uart_once(opts, fd, data, data_len);
 		memset(opts->cmp_buff, 0, data_len);
@@ -307,14 +310,30 @@ static int stress_test_uart(struct g_opt *opts, int fd, unsigned char *data, off
 	return status;
 }
 
+void set_modem(int fd, int bits, int mask)
+{
+	int status, ret;
+
+	ret = ioctl(fd, TIOCMGET, &status);
+	if (ret < 0)
+		tst_brk(TBROK,"mcr get failed: %m\n");
+
+	status = (status & ~mask) | (bits & mask);
+
+	ret = ioctl(fd, TIOCMSET, &status);
+	if (ret < 0)
+		tst_brk(TBROK,"mcr set failed: %m\n");
+}
+
 static int setup_uart(struct g_opt *opts, int open_mode, struct termios *old_term)
 {
 	struct termios new_term;
+	struct serial_icounter_struct old_counters;
+	struct serial_icounter_struct new_counters;
 	int fd;
 	int ret;
-
-	tst_res(TINFO, "Setting up %s speed %u hwflow=%u",
-	        opts->uart_dev, opts->baud_rate, opts->hwflow);
+	tst_res(TINFO, "Setting up %s speed %u hwflow=%u,loops=%u,loopback %u",
+	        opts->uart_dev, opts->baud_rate, opts->hwflow,opts->loops,opts->loopback);
 
 	fd = SAFE_OPEN(opts->uart_dev, open_mode | O_NONBLOCK);
 
@@ -347,6 +366,18 @@ static int setup_uart(struct g_opt *opts, int open_mode, struct termios *old_ter
 			tst_brk(TBROK, "tcflush failed: %m\n");
 	}
 
+	ret = fcntl(fd, F_SETFL, 0);
+	if (ret)
+		printf("Failed to remove nonblock mode\n");
+
+	// set loopback modem
+
+	set_modem(fd, opts->loopback ? TIOCM_LOOP : 0, TIOCM_LOOP);
+
+	ret = ioctl(fd, TIOCGICOUNT, &old_counters);
+	if (ret)
+		printf("Failed to set loopback mode\n");
+
 	ret = fcntl(fd, F_SETFL, 0);
 	if (ret)
 		printf("Failed to remove nonblock mode\n");
@@ -359,6 +390,7 @@ static void restore_uart(int fd, struct termios *old_term)
 	int ret = tcsetattr(fd, TCSAFLUSH, old_term);
 	if (ret)
 		printf("tcsetattr() of old ones failed: %m\n");
+	set_modem(fd, 0, TIOCM_LOOP);
 }
 
 static void print_counters(const char *prefix,
@@ -378,6 +410,7 @@ static struct g_opt opts = {
 	.baud_rate = 115200,
 	.loops = 1,
 	.do_termios = 1,
+	.loopback = 0,
 };
 
 static char *uart_rx;
@@ -404,10 +437,7 @@ void run(void)
 
 	fd_rx = setup_uart(&opts_in, O_RDONLY, &old_term_rx);
 
-	if (!strcmp(uart_rx, uart_tx))
-		fd_tx = SAFE_OPEN(uart_tx, O_WRONLY);
-	else
-		fd_tx = setup_uart(&opts_out, O_WRONLY, &old_term_tx);
+	fd_tx = setup_uart(&opts_out, O_WRONLY, &old_term_tx);
 
 	if (!SAFE_FORK()) {
 		ioctl(fd_rx, TIOCGICOUNT, &old_counters);
@@ -439,22 +469,36 @@ void run(void)
 	close(fd_tx);
 }
 
-static void map_file(const char *fname)
+static void map_file(const char *fname,int baud)
 {
 	struct stat st;
+	int size;
 	int fd;
+	char c;
+	FILE *f_des,*f_src;
+
+	size = baud;
 
-	fd = SAFE_OPEN(fname, O_RDONLY);
+	fd = SAFE_OPEN(fname, O_RDWR|O_CREAT);
+	f_src = fopen("/dev/urandom","r");
+	f_des = fopen(fname,"w+");
 
 	SAFE_FSTAT(fd, &st);
 
-	data_len = st.st_size;
+	data_len = size;
 
 	data = SAFE_MMAP(NULL, data_len, PROT_READ,
 	                 MAP_SHARED | MAP_LOCKED | MAP_POPULATE, fd, 0);
 
 	tst_res(TINFO, "Mapped file '%s' size %li bytes", fname, data_len);
+	while(size--)
+	{
+		c = fgetc(f_src);
+		fputc(c,f_des);
+	}
 
+	fclose(f_des);
+	fclose(f_src);
 	SAFE_CLOSE(fd);
 }
 
@@ -479,6 +523,8 @@ static void map_buffer(long buf_size)
 
 static char *baud_rate;
 static char *hwflow;
+static char *loops;
+static char *loopback;
 static char *fname;
 static char *buf_size;
 
@@ -492,17 +538,23 @@ static void setup(void)
 	if (hwflow)
 		opts.hwflow = 1;
 
+	if (loops)
+		tst_parse_int(loops, &(opts.loops), 0, INT_MAX);
+
+	if (loopback)
+		tst_parse_int(loopback, &(opts.loopback), 0, INT_MAX);
+
 	if (fname && buf_size)
 		tst_brk(TBROK, "Only one of -f and -s could be set!");
 
 	if (buf_size)
 		tst_parse_long(buf_size, &size, 0, LONG_MAX);
 
-	uart_rx = getenv("UART_RX");
-	uart_tx = getenv("UART_TX");
+	uart_rx = getenv("UART_DEV");
+	uart_tx = getenv("UART_DEV");
 
 	if (fname)
-		map_file(fname);
+		map_file(fname,opts.baud_rate);
 	else
 		map_buffer(size);
 }
@@ -511,12 +563,14 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = run,
 	.options = (struct tst_option[]) {
-		{"b:", &baud_rate, "-b       Baud rate (9600, ...)"},
-		{"w",  &hwflow   , "-w       Enable hwflow (RTS/CTS)"},
-		{"f:",  &fname,    "-f       Binary file for transfers"},
-		{"s:",  &buf_size, "-s       Binary buffer size"},
+		{"b:",  &baud_rate, "-b       Baud rate (9600, ...)"},
+		{"w",   &hwflow,    "-w       Enable hwflow (RTS/CTS)"},
+		{"f:",  &fname,     "-f       Binary file for transfers"},
+		{"l:",  &loops,     "-l       loops to perform(0=>wait for CTRL-C"},
+		{"s:",  &buf_size,  "-s       Binary buffer size"},
+		{"k:",  &loopback,  "-k       Enable loopback modem"},
 		{}
 	},
-	.needs_devices = (const char *const[]) {"UART_RX", "UART_TX", NULL},
+	.needs_devices = (const char *const[]) {"UART_DEV",NULL},
 	.forks_child = 1,
 };
-- 
2.17.1

