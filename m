Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YLx77-0006mG-P2
	for ltp-list@lists.sourceforge.net; Thu, 12 Feb 2015 16:59:41 +0000
Date: Thu, 12 Feb 2015 17:59:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150212165921.GA27008@rei>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
Subject: [LTP] prototyping new library synchronization
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jiri Jaburek <jjaburek@redhat.com>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
Code prototype follows. It uses mutexes and can be used with up to
page_size/sizeof(uint32) pairs. I've checked that it compiles fine and
works back to kernel 2.6.11 compiled in year 2005, which should be more
than enough.

It uses a regular file as a backing for the shared pages which makes it
even easier to replace the fifo based solution we have. All that is
needed is to map the same file created in the test temporary directory
just like the fifo does.

Please anone that uses LTP, check that the code compiles and works for
fine on all distributions you care for. Once that is checked, I will
write the new library functions based on this code and convert all the
test to the new interface.

-- 
Cyril Hrubis
chrubis@suse.cz

--HcAYCG3uE/tztfnV
Content-Type: text/x-c; charset=us-ascii
Content-Disposition: inline; filename="tfutex.c"

#include <fcntl.h>
#include <stdint.h>
#include <unistd.h>
#include <limits.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <linux/futex.h>

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>

typedef volatile uint32_t futex_t;

static futex_t *futexes;

static void finit(void)
{
	int fd;

	fd = open("/tmp/syncronization_futex_base_file", O_RDWR | O_CREAT, 0666);

	if (fd < 0) {
		fprintf(stderr, "open(): %s\n", strerror(errno));
		exit(1);
	}

	if (ftruncate(fd, getpagesize())) {
		fprintf(stderr, "ftruncate(): %s\n", strerror(errno));
		exit(1);
	}

	futexes = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);

	if (futexes == MAP_FAILED) {
		fprintf(stderr, "mmap(): %s\n", strerror(errno));
		exit(1);
	}
}

static void fwait(unsigned int id, struct timespec *timeout)
{
	syscall(SYS_futex, &futexes[id], FUTEX_WAIT, futexes[id], timeout);
}

static void fwake(unsigned int id)
{
	int ret;

	do {
		ret = syscall(SYS_futex, &futexes[id], FUTEX_WAKE, INT_MAX, NULL);
		usleep(100);
	} while (ret == 0);
}

int main(void)
{
	int pid;

	finit();

	pid = fork();

	switch (pid) {
	case 0:
		fprintf(stderr, "Child calls wait\n");
		fwait(0, NULL);
		fprintf(stderr, "Child woken up\n");
	break;
	case -1:
		fprintf(stderr, "fork(): %s\n", strerror(errno));
	break;
	default:
		/* uncomment to change ordering */
		//usleep(100);
		fprintf(stderr, "Parent calls wake\n");
		fwake(0);
		fprintf(stderr, "Parent finishes\n");
	}

	return 0;
}

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--HcAYCG3uE/tztfnV--

