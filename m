From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Mar 2019 07:42:40 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscall: Add userfaultfd testcase
In-Reply-To: <20190314085717.10207-1-camann@suse.com>
References: <20190314085717.10207-1-camann@suse.com>
Message-ID: <824216999.8470703.1552563760595.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> This tests the userfaultfd syscall to handle pagefault events.
> It does so by registering a userfaultfd object to the address of
> a memory page. In a second thread it handles the event and writes
> data in the monitored memory page to indicate success.
> 
> Signed-off-by: Christian Amann <camann@suse.com>

Hi,

my main concern is that direct include of linux header.

Other than that it looks ok, but you could use more SAFE_ macros
which do the common checks and print error messages for you.

<snip>

> +
> +/*
> + * Test userfaultfd
> + *
> + * Force a pagefault event and handle it using userfaultfd
> + * from a different thread
> + *
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include <linux/userfaultfd.h>

This doesn't look like it will compile on older kernels.

> +#include <pthread.h>
> +#include <poll.h>
> +
> +static int page_size;
> +static char *page;
> +static void *copy_page;
> +
> +static int sys_userfaultfd(int flags)
> +{
> +	return tst_syscall(__NR_userfaultfd, flags);
> +}
> +
> +static void set_pages(void)
> +{
> +	page_size = sysconf(_SC_PAGE_SIZE);
> +	page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	copy_page = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

Please use SAFE_MMAP

> +}
> +
> +static void *handle_thread(void *arg)
> +{
> +	static struct uffd_msg msg;
> +	long uffd;
> +	struct uffdio_copy uffdio_copy;
> +	ssize_t nread;
> +
> +	uffd = (long) arg;
> +
> +	struct pollfd pollfd;
> +	int nready;
> +
> +	pollfd.fd = uffd;
> +	pollfd.events = POLLIN;
> +	nready = poll(&pollfd, 1, -1);

SAFE_POLL

> +	if (nready == -1)
> +		tst_brk(TBROK | TERRNO,
> +				"Error on poll");
> +
> +	nread = read(uffd, &msg, sizeof(msg));

SAFE_READ should work here too if you pass len_strict=1

> +	if (nread <= 0)
> +		tst_brk(TBROK | TERRNO, "Error on read");
> +
> +	if (msg.event != UFFD_EVENT_PAGEFAULT)
> +		tst_brk(TBROK | TERRNO,
> +				"Received unexpected UFFD_EVENT");
> +
> +	memset(copy_page, 'X', page_size);
> +
> +	uffdio_copy.src = (unsigned long) copy_page;
> +
> +	uffdio_copy.dst = (unsigned long) msg.arg.pagefault.address
> +			& ~(page_size - 1);
> +	uffdio_copy.len = page_size;
> +	uffdio_copy.mode = 0;
> +	uffdio_copy.copy = 0;
> +	if (ioctl(uffd, UFFDIO_COPY, &uffdio_copy) == -1)
> +		tst_brk(TBROK | TERRNO,
> +				"ioctl returned error for UFFDIO_COPY");

SAFE_IOCTL

> +	close(uffd);
> +}
> +
> +static void run(void)
> +{
> +	long uffd;
> +	pthread_t thr;
> +	struct uffdio_api uffdio_api;
> +	struct uffdio_register uffdio_register;
> +	int thread_ret;
> +
> +	set_pages();
> +
> +	uffd = sys_userfaultfd(O_CLOEXEC | O_NONBLOCK);
> +	if (uffd == -1)
> +		tst_brk(TBROK | TERRNO,
> +			"Could not create userfault file descriptor");
> +
> +	uffdio_api.api = UFFD_API;
> +	uffdio_api.features = 0;
> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1)
> +		tst_brk(TBROK | TERRNO, "ioctl returned error for UFFDIO_API");

SAFE_IOCTL

> +
> +	uffdio_register.range.start = (unsigned long) page;
> +	uffdio_register.range.len = page_size;
> +	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
> +
> +	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
> +		tst_brk(TBROK | TERRNO,
> +			"ioctl returned error for UFFDIO_REGISTER");

SAFE_IOCTL

> +
> +	thread_ret = pthread_create(&thr, NULL,
> +			handle_thread, (void *) uffd);

SAFE_PTHREAD_CREATE

> +	if (thread_ret != 0) {
> +		errno = thread_ret;
> +		tst_brk(TBROK | TERRNO, "Could not create pthread");
> +	}
> +
> +	char c = page[0xf];
> +
> +	if (c == 'X')
> +		tst_res(TPASS, "Pagefault handled!");
> +	else
> +		tst_res(TFAIL, "Pagefault not handled!");
> +
> +	pthread_join(thr, NULL);

SAFE_PTHREAD_JOIN

Regards,
Jan

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.min_kver = "4.3",
> +	.timeout = 20
> +};
> --
> 2.16.4
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
