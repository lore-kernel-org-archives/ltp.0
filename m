From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 7 Nov 2019 19:29:23 +0530
Subject: [LTP] LTP: diotest4.c:476: read to read-only space. returns 0:
 Success
Message-ID: <CA+G9fYtmA5F174nTAtyshr03wkSqMS7+7NTDuJMd_DhJF6a4pw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LTP test case dio04 test failed on 32bit kernel running linux next
20191107 kernel.
Linux version 5.4.0-rc6-next-20191107.

diotest4    1  TPASS  :  Negative Offset
diotest4    2  TPASS  :  removed
diotest4    3  TPASS  :  Odd count of read and write
diotest4    4  TPASS  :  Read beyond the file size
diotest4    5  TPASS  :  Invalid file descriptor
diotest4    6  TPASS  :  Out of range file descriptor
diotest4    7  TPASS  :  Closed file descriptor
diotest4    8  TPASS  :  removed
diotest4    9  TCONF  :  diotest4.c:345: Direct I/O on /dev/null is
not supported
diotest4   10  TPASS  :  read, write to a mmaped file
diotest4   11  TPASS  :  read, write to an unmapped file
diotest4   12  TPASS  :  read from file not open for reading
diotest4   13  TPASS  :  write to file not open for writing
diotest4   14  TPASS  :  read, write with non-aligned buffer
diotest4   15  TFAIL  :  diotest4.c:476: read to read-only space.
returns 0: Success
diotest4   16  TFAIL  :  diotest4.c:180: read, write buffer in read-only space
diotest4   17  TFAIL  :  diotest4.c:114: read allows  nonexistant
space. returns 0: Success
diotest4   18  TFAIL  :  diotest4.c:129: write allows  nonexistant
space.returns -1: Invalid argument
diotest4   19  TFAIL  :  diotest4.c:180: read, write in non-existant space
diotest4   20  TPASS  :  read, write for file with O_SYNC
diotest4    0  TINFO  :  2/15 test blocks failed

Test results comparison link,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-dio-tests/dio04

Test case source link,
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/io/direct_io/diotest4.c

Test case description:

* NAME
* diotest4.c
*
* DESCRIPTION
* The program generates error conditions and verifies the error
* code generated with the expected error value. The program also
* tests some of the boundary condtions. The size of test file created
* is filesize_in_blocks * 4k.
* Test blocks:
* [1] Negative Offset
* [2] Negative count - removed 08/01/2003 - robbiew
* [3] Odd count of read and write
* [4] Read beyond the file size
* [5] Invalid file descriptor
* [6] Out of range file descriptor
* [7] Closed file descriptor
* [8] Directory read, write - removed 10/7/2002 - plars
* [9] Character device (/dev/null) read, write
* [10] read, write to a mmaped file
* [11] read, write to an unmaped file with munmap
* [12] read from file not open for reading
* [13] write to file not open for writing
* [14] read, write with non-aligned buffer
* [15] read, write buffer in read-only space
* [16] read, write in non-existant space
* [17] read, write for file with O_SYNC

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: c68c5373c504078cc0e0edc7d5c88b47ca308144
  git describe: next-20191107
  make_kernelversion: 5.4.0-rc6
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/641/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/641

Best regards
Naresh Kamboju
