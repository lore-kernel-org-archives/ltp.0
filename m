From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 14 Feb 2017 16:41:29 +0100
Subject: [LTP] Is MADV_HWPOISON supposed to work only on faulted-in pages?
Message-ID: <6a445beb-119c-9a9a-0277-07866afe4924@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

code below (and LTP madvise07 [1]) doesn't produce SIGBUS,
unless I touch/prefault page before call to madvise().

Is this expected behavior?

Thanks,
Jan

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/madvise/madvise07.c

-------------------- 8< --------------------
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>

int main(void)
{
	void *mem = mmap(NULL, getpagesize(), PROT_READ | PROT_WRITE,
			MAP_ANONYMOUS | MAP_PRIVATE /*| MAP_POPULATE*/,
			-1, 0);

	if (mem == MAP_FAILED)
		exit(1);

	if (madvise(mem, getpagesize(), MADV_HWPOISON) == -1)
		exit(1);

	*((char *)mem) = 'd';

	return 0;
}
-------------------- 8< --------------------
