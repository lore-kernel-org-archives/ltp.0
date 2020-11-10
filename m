From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Tue, 10 Nov 2020 12:18:45 +0800
Subject: [LTP] Last NFSD update breaks nfsv4.2 copy_file_range
Message-ID: <20201110041845.ag2kj3l6l6263ri5@xzhoux.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

copy_file_range for NFSv4.2 is broke by this

commit 9f0b5792f07d8f0745c3620d577d6930ff2a96fd
Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Mon Sep 28 13:09:01 2020 -0400

    NFSD: Encode a full READ_PLUS reply


LTP copy_file_range01 repeats this failure:
copy_file_range01.c:144: TFAIL: file contents do not match

Revert this commit then the failure gone.

Attached simplified reproducer for your ref.

-- 
Murphy
-------------- next part --------------
#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>

int main(int argc, char **argv)
{
	int fd_in, fd_out;
	struct stat stat;
	loff_t len;
	ssize_t ret;
	char buf[2];
	loff_t in = 0, out, i2, o2, to_cp, copied;

	if (argc != 6) {
		fprintf(stderr, "Usage: %s <src> <dest> inoff outoff len\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	fd_in = open(argv[1], O_RDONLY);
	if (fd_in == -1) {
		perror("open (argv[1])");
		exit(EXIT_FAILURE);
	}

	fd_out = open(argv[2], O_CREAT|O_WRONLY|O_TRUNC|O_SYNC, 0644);
	if (fd_out == -1) {
		perror("open (argv[2])");
		exit(EXIT_FAILURE);
	}

	in = strtoul(argv[3], NULL, 0);
	out = strtoul(argv[4], NULL, 0);
	len = strtoul(argv[5], NULL, 0);
	i2 = in;
	o2 = out;
	to_cp = len;

	do {
		ret = copy_file_range(fd_in, &in, fd_out, &out, to_cp, 0);
		if (ret == -1) {
			perror("copy_file_range");
			exit(EXIT_FAILURE);
		}
		copied += ret;
		to_cp -= ret;
	} while (to_cp > 0 && ret > 0);

	close(fd_in);
	close(fd_out);
	sync();

	FILE *fp1, *fp2;
	int ch1, ch2, count = 0;

	fp1 = fopen(argv[1], "r");
	if (fseek(fp1, i2, SEEK_SET)) {
		perror("fseek fp1");
		exit(EXIT_FAILURE);
	}
	fp2 = fopen(argv[2], "r");
	if (fseek(fp2, o2, SEEK_SET)) {
		perror("fseek fp2");
		exit(EXIT_FAILURE);
	}

	do {
		ch1 = fgetc(fp1);
		ch2 = fgetc(fp2);
		count++;
	} while ((count < len) && (ch1 == ch2));
	fclose(fp1);
	fclose(fp2);

	if (ch1 != ch2) {
		printf("%d %d %d copied %d ch1 %c ch2 %c count %d file content corrupted\n", i2, o2, len, copied, ch1, ch2, count);
		return 1;
	}
	return 0;
}
-------------- next part --------------
A non-text attachment was scrubbed...
Name: nfs_copy_range.sh
Type: application/x-sh
Size: 638 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201110/b17885bd/attachment.sh>
