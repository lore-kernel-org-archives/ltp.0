From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 27 Jan 2017 11:32:28 -0500 (EST)
Subject: [LTP] open14 and openat03 failed on arm64
In-Reply-To: <CA+G9fYsrnhpUMa3VZ-q7qw8XHFycOuH6hUigZXAhjCcoaiNQHQ@mail.gmail.com>
References: <CA+G9fYsrnhpUMa3VZ-q7qw8XHFycOuH6hUigZXAhjCcoaiNQHQ@mail.gmail.com>
Message-ID: <1411020660.1613465.1485534748235.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Naresh Kamboju" <naresh.kamboju@linaro.org>
> To: ltp@lists.linux.it
> Cc: "Milosz Wasilewski" <milosz.wasilewski@linaro.org>
> Sent: Friday, 27 January, 2017 2:03:27 PM
> Subject: [LTP] open14 and openat03 failed on arm64
> 
> Hi LTP Team,
> 
> Test cases open14.c and openat03.c failed on arm64 on latest Linux kernel
> 4.9.x.
> 
> Have you noticed these failures on x86_64 and other architectures and
> which kernel version ?

I tried it on x86, with recent upstream kernel on top of RHEL7.4,
with tmp directory backed by xfs and tmpfs, no failures here:

# uname -r
4.9.0-6.el7.x86_64

# ./openat03
openat03    0  TINFO  :  creating a file with O_TMPFILE flag
openat03    0  TINFO  :  writing data to the file
openat03    0  TINFO  :  file size is '4096'
openat03    0  TINFO  :  looking for the file in '.'
openat03    0  TINFO  :  file not found, OK
openat03    0  TINFO  :  renaming '/tmp/opes6TpFu/#938519 (deleted)' -> 'tmpfile'
openat03    0  TINFO  :  found a file: tmpfile
openat03    1  TPASS  :  single file tests passed
openat03    0  TINFO  :  create files in multiple directories
openat03    0  TINFO  :  removing test directories
openat03    0  TINFO  :  writing/reading temporary files
openat03    0  TINFO  :  closing temporary files
openat03    2  TPASS  :  multiple files tests passed
openat03    0  TINFO  :  create multiple directories, link files into them
openat03    0  TINFO  :  and check file permissions
openat03    0  TINFO  :  remove files, directories
openat03    3  TPASS  :  file permission tests passed

# ./open14
open14      0  TINFO  :  creating a file with O_TMPFILE flag
open14      0  TINFO  :  writing data to the file
open14      0  TINFO  :  file size is '4096'
open14      0  TINFO  :  looking for the file in '.'
open14      0  TINFO  :  file not found, OK
open14      0  TINFO  :  renaming '/tmp/opeFKTGFB/#34605340 (deleted)' -> 'tmpfile'
open14      0  TINFO  :  found a file: tmpfile
open14      1  TPASS  :  single file tests passed
open14      0  TINFO  :  create files in multiple directories
open14      0  TINFO  :  removing test directories
open14      0  TINFO  :  writing/reading temporary files
open14      0  TINFO  :  closing temporary files
open14      2  TPASS  :  multiple files tests passed
open14      0  TINFO  :  create multiple directories, link files into them
open14      0  TINFO  :  and check file permissions
open14      0  TINFO  :  remove files, directories
open14      3  TPASS  :  file permission tests passed

You example works too, with following change:

# diff -u open14-x86-test.c 2.c
--- open14-x86-test.c   2017-01-27 11:19:27.899997799 -0500
+++ 2.c 2017-01-27 11:29:57.042445879 -0500
@@ -63,7 +63,7 @@

                perm = test_perms[i];

-               fd[i] = open(".",  O_TMPFILE | O_RDWR, S_IRUSR | S_IWUSR);
+               fd[i] = open(".",  O_TMPFILE | O_RDWR, perm);


                link_tmp_file(fd[i]);

create multiple directories, link files into them
and check file permissions
file mode read 0, but expected 0
file mode read 7755, but expected 7755
file mode read 1, but expected 1
file mode read 755, but expected 755
file mode read 644, but expected 644
file mode read 440, but expected 440

Regards,
Jan

> 
> Test output:
> -----------------
> create multiple directories, link files into them
> and check file permissions
> file mode read 0, but expected
> file mode read 0, but expected 7755
> file mode read 0, but expected 1
> file mode read 0, but expected 755
> file mode read 0, but expected 644
> file mode read 0, but expected 440
> 
> Linux version 4.9.0-rc6-00086-g3b404a5 (broonie@optimist) (gcc version
> 5.1.1 20150608 (Linaro GCC 5.1-2015.08) ) #1 SMP PREEMPT Tue Nov 22
> 04:14:54 GMT 2016
> 
> Test case is trimmed version of LTP,
> you can find test case here in this link
> [1] http://people.linaro.org/~naresh.kamboju/open14-arm64-test.c
> [2] http://people.linaro.org/~naresh.kamboju/open14-x86-test.c
> 
> Best regards
> Naresh Kamboju
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
