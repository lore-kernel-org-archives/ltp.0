Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O6fEi-0000zA-NW
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 07:29:40 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O6fEh-0006QU-EO
	for ltp-list@lists.sourceforge.net; Tue, 27 Apr 2010 07:29:40 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Tue, 27 Apr 2010 12:43:11 +0530
Message-Id: <1272352392.6915.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: [LTP] UTIMENSAT test fails hugely
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sf.net>

Hi,

Anybody seeing it on their system(s):

# head -17514 output/LTP_RUN_ON-2010_Apr_21-17h_51m_22s.output | tail
-956
<<<test_start>>>
tag=utimensat01 stime=1271853062
cmdline="utimensat_tests.sh"
contacts=""
analysis=exit
<<<test_output>>>
sudo: sorry, you must have a tty to run sudo
/opt/ltp/testcases/bin/utimensat_tests.sh: line 252:
cd: /tmp/ltp-WvDfUaurtr/utimensat_tests: No such file or directory
============================================================

Testing read-only file, owned by self

***** Testing times==NULL case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01
-q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 1

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 2

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 3

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 4

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 5

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 6

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 7

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 8

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 9

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  n
RESULT:     
FAILED test 10

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  n
RESULT:     
FAILED test 11

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  n
RESULT:     
FAILED test 12

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  y
RESULT:     
FAILED test 13

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  y
RESULT:     
FAILED test 14

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  y
RESULT:     
FAILED test 15

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ x, y } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 16

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 17

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 18

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
============================================================

Testing read-only file, not owned by self

***** Testing times==NULL case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01
-q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file 
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 19

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 20

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 21

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 22

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 23

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 24

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 25

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 26

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 27

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 28

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 29

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 30

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 31

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 32

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 33

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ x, y } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 34

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 35

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 36

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
============================================================

Testing writable file, not owned by self

***** Testing times==NULL case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01
-q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 37

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 38

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 39

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 40

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 41

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 42

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 43

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 44

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 45

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 46

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 47

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 48

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 49

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 50

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 51

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ x, y } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 52

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 53

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 54

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
============================================================

Testing append-only file, owned by self

***** Testing times==NULL case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01
-q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 55

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 56

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 57

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 58

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 59

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS y  y
RESULT:     
FAILED test 60

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 61

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 62

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 63

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 64

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 65

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 66

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 67

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 68

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 69

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ x, y } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 70

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 71

Writable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q -w
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 72

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
============================================================

Testing immutable file, owned by self

***** Testing times==NULL case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01
-q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file 
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 73

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 74

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 75

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 76

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 77

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 78

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 79

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 80

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 81

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 82

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ x, y } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 83

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 84

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
============================================================

Testing immutable append-only file, owned by self

***** Testing times==NULL case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01
-q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file 
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 85

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 86

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 87

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EACCES   
RESULT:     
FAILED test 88

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 89

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: SUCCESS n  n
RESULT:     
FAILED test 90

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_NOW, UTIME_OMIT } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 91

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 n 0 o
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 92

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ UTIME_OMIT, UTIME_NOW } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 93

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 0 o 0 n
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 94

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
***** Testing times=={ x, y } case *****
Pathname test
sudo: sorry, you must have a tty to run sudo
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the
same file
./utimensat01 -q /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file
1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 95

Readable file descriptor (futimens(3)) test
sudo: sorry, you must have a tty to run sudo
./utimensat01 -q
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 1 1 1 1
sudo: sorry, you must have a tty to run sudo
EXPECTED: EPERM   
RESULT:     
FAILED test 96

sudo: sorry, you must have a tty to run sudo
sudo: sorry, you must have a tty to run sudo
============================================================

***** Testing pathname==NULL, dirfd!=AT_FDCWD, flags has
AT_SYMLINK_NOFOLLOW *****
sudo: sorry, you must have a tty to run sudo
utimensat01 -q -n
-d /tmp/ltp-WvDfUaurtr/utimensat_tests/utimensat.test_file NULL 
open: No such file or directory
FAILED (bad test setup)
<<<execution_status>>>
initiation_status="ok"
duration=3 termination_type=exited termination_id=1 corefile=no
cutime=34 cstime=160
<<<test_end>>>
--------------

# uname -a
Linux 2.6.33.1-19.fc13.ppc64 #1 SMP Tue Mar 23 06:32:38 EDT 2010 ppc64
ppc64 ppc64 GNU/Linux
# cat /etc/issue
Fedora release 13 (Goddard)
Kernel \r on an \m (\l)

Regards--
Subrata



------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
